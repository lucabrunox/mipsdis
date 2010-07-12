/* binarycode.vala
 *
 * Copyright (C) 2010  Luca Bruno
 *
 * This file is part of Mipsdis.
 *
 * Mipsdis is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.

 * Mipsdis is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with Mipsdis.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Author:
 *      Luca Bruno <lethalman88@gmail.com>
 */

namespace Mips
{
  public class BinaryCode
  {
    public AddressMapping address_mapping;
    public SymbolTable symbol_table;
    public StringTable string_table;
    public TextSection text_section;
    public StringTable readonly_data;
    public PltTable plt_table;
  }

  public abstract class BinaryReference
  {
    public virtual string to_string () { return "(unnamed reference)"; }
  }

  public class AddressMapping
  {
    private ProgramHeader[] headers;

    public void add_header (ProgramHeader header)
      requires (header.type == ProgramHeader.Type.LOAD)
    {
      headers += header;
    }

    public bool has_physical_address (uint virtual_address)
    {
      foreach (var header in headers)
        {
          if (virtual_address >= header.virtual_addr && virtual_address <= (header.virtual_addr + header.file_size))
            return true;
        }
      return false;
    }

    public uint get_physical_address (uint virtual_address)
    {
      foreach (var header in headers)
        {
          if (virtual_address >= header.virtual_addr && virtual_address <= (header.virtual_addr + header.file_size))
            return virtual_address - header.virtual_addr + header.offset;
        }
      warning ("Unable to resolve virtual address to physical address: %p", (void*)(long)virtual_address);
      return virtual_address;
    }

    public uint get_virtual_base_address (uint virtual_address)
    {
      foreach (var header in headers)
        {
          if (virtual_address >= header.virtual_addr && virtual_address <= (header.virtual_addr + header.file_size))
            return header.virtual_addr;
        }
      warning ("Unable to resolve virtual address to physical address: %p", (void*)(long)virtual_address);
      return virtual_address;
    }

    public uint get_last_address ()
    {
      ProgramHeader last_header = headers[0];
      for (int i=1; i < headers.length; i++)
        {
          if (headers[i].offset > last_header.offset)
            last_header = headers[i];
        }
      return last_header.offset + last_header.file_size;
    }
  }

  public class TextSection
  {
    public uint file_offset;
    public uint virtual_address;
    public BinaryInstruction[] binary_instructions;
    private int binary_instructions_size;

    public TextSection (uint file_offset, uint virtual_address)
    {
      this.file_offset = file_offset;
      this.virtual_address = virtual_address;
    }

    public void set_instructions (int n)
    {
      binary_instructions = new BinaryInstruction[n];
      binary_instructions_size = 0;
    }

    public void add_instruction (BinaryInstruction inst)
    {
      binary_instructions[binary_instructions_size++] = inst;
    }

    public BinaryInstruction? instruction_at_address (uint virtual_address)
    {
      if (virtual_address < this.virtual_address)
        return null;
      var index = (virtual_address - this.virtual_address) / 4;
      if (index > binary_instructions.length)
        return null;
      return binary_instructions[index];
    }
  }

  public class BinaryObject : BinaryReference
  {
    public string name;

    public BinaryObject (string name)
      {
        this.name = name;
      }

    public override string to_string ()
    {
      return name;
    }
  }

  public class BinaryInstruction : BinaryReference
  {
    public Instruction instruction;
    public uint file_offset;
    public uint file_value;
    public uint virtual_address;
    public string label;
    public bool is_func_start;

    public BinaryInstruction (Instruction instruction, uint file_offset, uint file_value, uint virtual_address)
    {
      this.instruction = instruction;
      this.file_offset = file_offset;
      this.file_value = file_value;
      this.virtual_address = virtual_address;
    }

    public override string to_string ()
    {
      if (label != null)
        {
          if (is_func_start)
            return @"<$(label)>";
          else
            return label;
        }
      else
        return base.to_string ();
    }
  }

  public class BinaryString : BinaryReference
  {
    public uint file_offset;
    public string str;

    public BinaryString (uint file_offset, string str)
      {
        this.file_offset = file_offset;
        this.str = str;
      }

    public override string to_string ()
    {
      return "%p: '%s'".printf ((void*)(long)file_offset, str);
    }
  }

  public class BinaryAddress : BinaryReference
  {
    public uint address;

    public BinaryAddress (uint address)
      {
        this.address = address;
      }

    public override string to_string ()
    {
      return "%p".printf ((void*)(long)address);
    }
  }

  public class BinaryPltInitial : BinaryAddress
  {
    public BinaryPltInitial (uint address)
      {
        base (address);
      }

    public override string to_string ()
    {
      return "Initial: %p".printf ((void*)(long)address);
    }
  }
}