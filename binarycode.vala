namespace Mips
{
  public class BinaryCode
  {
    public SymbolTable symbol_table;
    public StringTable string_table;
    public TextSection text_section;
  }

  public abstract class BinaryReference
  {
    public virtual string to_string () { return "(unnamed reference)"; }
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
}