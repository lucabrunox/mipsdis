/* header.vala
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

namespace Mips {
	public errordomain HeaderError {
		NOT_ELF,
		UNSUPPORTED_PROGRAM_HEADER,
		INVALID_SECTION,
		INVALID_ADDRESS
	}

	public class ELFHeader {
		public enum Type {
			NONE,
			REL,
			EXEC,
			DYN,
			CORE
		}

		public Type type;
		public uint16 machine;
		public uint32 version;
		public uint32 entry;
		public uint32 phoff;
		public uint32 shoff;
		public uint32 flags;
		public uint16 ehsize;
		public uint16 phentsize;
		public uint16 phnum;
		public uint16 shentsize;
		public uint16 shnum;
		public uint16 shstrndx;

		public ELFHeader.from_stream (DataInputStream stream) throws Error {
			uint8[] magic = new uint8[16];
			stream.read (magic);
			if (magic[0] != 0x7f || magic[1] != 'E' || magic[2] != 'L' || magic[3] != 'F') {
				throw new HeaderError.NOT_ELF ("Unknown magic value");
			}

			type = (Type) stream.read_uint16 ();
			machine = stream.read_uint16 ();
			version = stream.read_uint32 ();
			entry = stream.read_uint32 ();
			phoff = stream.read_uint32 ();
			shoff = stream.read_uint32 ();
			flags = stream.read_uint32 ();
			ehsize = stream.read_uint16 ();
			phentsize = stream.read_uint16 ();
			phnum = stream.read_uint16 ();
			shentsize = stream.read_uint16 ();
			shnum = stream.read_uint16 ();
			shstrndx = stream.read_uint16 ();
		}
	}

  public class ProgramHeader
  {
    public enum Type
      {
        NULL,
        LOAD,
        DYNAMIC,
        INTERP,
        NOTE,
        SHLIB,
        PHDR,
        TLS,
        NUM,
      }

    public Type type;
    public uint offset;
    public uint virtual_addr;
    public uint physical_addr;
    public uint file_size;
    public uint mem_size;
    public uint flags;
    public uint align;

    public ProgramHeader.from_stream (DataInputStream stream) throws Error
    {
      type = (Type)stream.read_uint32 ();
      offset = stream.read_uint32 ();
      virtual_addr = stream.read_uint32 ();
      physical_addr = stream.read_uint32 ();
      file_size = stream.read_uint32 ();
      mem_size = stream.read_uint32 ();
      flags = stream.read_uint32 ();
      align = stream.read_uint32 ();
    }
  }

  public class DynamicSection
  {
    public enum Type
      {
        NULL,
        PLTGOT=3,
        STRTAB=5,
        SYMTAB,
        STRSZ=10,
        SYMENT,
        INIT,
        FINI,
        MIPS_BASE_ADDRESS = 0x70000006,
        MIPS_LOCAL_GOTNO = 0x7000000a,
        MIPS_SYMTABNO = 0x70000011,
        MIPS_GOTSYM = 0x70000013
      }   
      public Type type;
      public uint value;
  }

  public class DynamicHeader
  {
    private DynamicSection[] sections;

    public DynamicHeader.from_stream (DataInputStream stream) throws Error
    {
      while (true)
        {
          var type = (DynamicSection.Type)stream.read_uint32 ();
          if (type == DynamicSection.Type.NULL)
            break;

          var section = new DynamicSection ();
          section.type = type;
          section.value = stream.read_uint32 ();
          sections.resize (sections.length+1);
          sections[sections.length-1] = section;
        }
      if (stream.read_uint32() != 0)
        throw new HeaderError.INVALID_SECTION ("Invalid NULL dynamic section");
    }

    public DynamicSection get_section_by_type (DynamicSection.Type type)
    {
      foreach (var section in sections)
        {
          if (section.type == type)
            return section;
        }
      assert_not_reached ();
    }

    public int get_size ()
    {
      return sections.length + 1;
    }
  }

  public class Symbol
  {
    public enum Info
      {
        NOTYPE = 0,
        OBJECT = 0x11,
        FUNC = 0x12,
      }
    public enum Other
      {
        DEFAULT,
        INTERNAL,
        HIDDEN,
        PROTECTED
      }

    public uint name;
    public uint value;
    public uint size;
    public Info info;
    public Other other;
    public uint16 shndx;

    public Symbol.from_stream (DataInputStream stream) throws Error
    {
      name = stream.read_uint32 ();
      value = stream.read_uint32 ();
      size = stream.read_uint32 ();
      info = (Info) stream.read_byte ();
      other = (Other) stream.read_byte ();
      shndx = stream.read_uint16 ();
    }
  }

  public class SymbolTable
  {
    static const int16 BASE_GP = -0x7ff0;

    private Symbol[] symbols;
    private uint first_got_index;
    private int16 global_gp;

    public SymbolTable.from_stream (DataInputStream stream, DynamicHeader dh) throws Error
    {
      var sym_no = dh.get_section_by_type(DynamicSection.Type.MIPS_SYMTABNO).value;
      symbols = new Symbol[sym_no];

      var local_gotno = dh.get_section_by_type(DynamicSection.Type.MIPS_LOCAL_GOTNO).value;
      global_gp = (int16)(BASE_GP + local_gotno * 4);
      first_got_index = dh.get_section_by_type(DynamicSection.Type.MIPS_GOTSYM).value;

      for (int i=0; i < sym_no; i++)
        {
          var symbol = new Symbol.from_stream (stream);
          symbols[i] = symbol;
        }
    }

    public Symbol? symbol_at_gp_offset (int16 offset, out bool is_local)
    {
      int index = (int)((offset - global_gp)/4 + first_got_index);
      if (index < 0)
        return null;

      is_local = offset < global_gp;
      return symbols[index];
    }

    public int get_size ()
    {
      return symbols.length * 16;
    }
  }

  public class StringTable
  {
    public uint base_address;
    private uint8[] strings;

    public StringTable.from_stream (DataInputStream stream, uint base_address, uint size) throws Error
    {
      this.base_address = base_address;
      strings = new uint8[size];
      assert (stream.read (strings) == size);
    }

    public unowned string string_at_offset (uint offset)
    {
      return (string)(&strings[offset]);
    }

    public unowned string? string_at_address (uint address)
    {
      var offset = address - base_address;
      if (offset >= strings.length)
        return null;
      return string_at_offset (offset);
    }

    public int get_size ()
    {
      return strings.length;
    }
  }

  public class PltTable
  {
    static const int16 BASE_GP = -0x7ff0;

    private uint32[] initials;

    public PltTable.from_stream (DataInputStream stream, DynamicHeader dh) throws Error
    {
      var table_size = dh.get_section_by_type(DynamicSection.Type.MIPS_LOCAL_GOTNO).value;
      initials = new uint32[table_size];
      for (int i=0; i < table_size; i++)
        initials[i] = stream.read_uint32 ();
    }

    public uint32 get_initial_for_gp_offset (int16 offset)
    {
      return initials[(offset - BASE_GP)/4];
    }
  }
}