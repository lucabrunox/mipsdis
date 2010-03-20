namespace Mips
{
  public class BinaryCode
  {
    public BinaryInstruction[] binary_instructions;
    private int binary_instructions_size;

    public void set_instructions (int n)
    {
      binary_instructions = new BinaryInstruction[n];
      binary_instructions_size = 0;
    }

    public void add_instruction (BinaryInstruction inst)
    {
      binary_instructions[binary_instructions_size++] = inst;
    }
  }

  public class BinaryInstruction
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
  }
}