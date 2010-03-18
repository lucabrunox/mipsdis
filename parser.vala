namespace Mips
{
  public errordomain ParserError
  {
    UNKNOWN_INSTRUCTION,
  }

  public class Parser
  {
    private DataInputStream stream;
    public int offset = -4;

    public Parser (DataInputStream stream) throws Error
    {
      this.stream = stream;
      this.stream.set_byte_order (DataStreamByteOrder.BIG_ENDIAN);
    }

    public Instruction next_instruction (out bool has_next, out int code) throws Error, ParserError
    {
      code = stream.read_int32 (null);
      offset += 4;
      var instruction = instruction_from_code (code);
      var res = stream.fill (4, null);
      has_next = res > 0;
      return instruction;
    }

    private Instruction instruction_from_code (int code) throws ParserError
    {
      if (code == 0)
        return new Nop ();

      int opcode = (code >> 26) &0x3F; // left-most 6 bits
      switch (opcode)
      {
      case SPECIAL:
        int func = code & 0x3F;
        switch (func)
          {
          case 0x00:
            if (get_five1 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("SLL 25-21 not zero");
            return new Sll.from_code (code);
          case 0x01:
            if ((code & 0x20000) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("SPECIAL MOV bit 17 != 0");
            if (get_five4 (code) == 0)
              return new Cop1.Movci.from_code (code);
            else
              return new Cop1.Movcf.from_code (code);
          case 0x02:
            if (get_five1 (code) != 0 && get_five1 (code) != 1)
              throw new ParserError.UNKNOWN_INSTRUCTION ("SRL 25-21 not zero or one");
            return new Srl.from_code (code);
          case 0x03:
            if (get_five1 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("SRA 25-21 not zero");
            return new Sra.from_code (code);
          case 0x04:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("SLLV 10-6 not zero");
            return new Sllv.from_code (code);
          case 0x06:
            if (get_five4 (code) != 0 && get_five4 (code) != 1)
              throw new ParserError.UNKNOWN_INSTRUCTION ("SRLV 10-6 not zero or one");
            return new Srlv.from_code (code);
          case 0x07:
            if (get_five4 (code) != 0 && get_five4 (code) != 1)
              throw new ParserError.UNKNOWN_INSTRUCTION ("SRAV 10-6 not zero or one");
            return new Srav.from_code (code);
          case 0x08:
            if (get_five2 (code) != 0 || get_five3 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("JR 20-11 not zero");
            return new Jr.from_code (code);
          case 0x09:
            if (get_five2 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("JALR 20-16 not zero");
            return new Jalr.from_code (code);
          case 0x0A:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("MOVZ 10-6 not zero or one");
            return new Movz.from_code (code);
          case 0x0B:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("MOVN 10-6 not zero or one");
            return new Movn.from_code (code);
          case 0x0D:
            return new Break.from_code (code);
          case 0x10:
            if (get_five1 (code) != 0 || get_five2 (code) != 0 || get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("MFHI 25-16 or 10-6 not zero");
            return new Mfhi.from_code (code);
          case 0x12:
            if (get_five1 (code) != 0 || get_five2 (code) != 0 || get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("MFLO 25-16 or 10-6 not zero");
            return new Mflo.from_code (code);
          case 0x18:
            if (get_five3 (code) != 0 || get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("MULT 15-6 not zero");
            return new Mult.from_code (code);
          case 0x19:
            if (get_five3 (code) != 0 || get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("MULTU 15-6 not zero");
            return new Multu.from_code (code);
          case 0x1A:
            if (get_five3 (code) != 0 || get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("DIV 15-6 not zero");
            return new Div.from_code (code);
          case 0x1B:
            if (get_five3 (code) != 0 || get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("DIVU 15-6 not zero");
            return new Divu.from_code (code);
          case 0x20:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("ADD 10-6 not zero");
            return new Add.from_code (code);
          case 0x21:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("ADDU 10-6 not zero");
            return new Addu.from_code (code);
          case 0x23:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("SUBU 10-6 not zero");
            return new Subu.from_code (code);
          case 0x24:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("AND 10-6 not zero");
            return new And.from_code (code);
          case 0x25:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("OR 10-6 not zero");
            return new Or.from_code (code);
          case 0x26:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("XOR 10-6 not zero");
            return new Xor.from_code (code);
          case 0x27:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("NOR 10-6 not zero");
            return new Nor.from_code (code);
          case 0x2A:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("SLT 10-6 not zero");
            return new Slt.from_code (code);
          case 0x2B:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("SLTU 10-6 not zero");
            return new Sltu.from_code (code);
          default:
            throw new ParserError.UNKNOWN_INSTRUCTION ("Unknown SPECIAL instruction 0x%x (0x%x)", func, code);
          }

      case REGIMM:
        int func = get_five2 (code);
        switch (func)
          {
          case 0x00:
            return new Bltz.from_code (code);
          case 0x01:
            return new Bgez.from_code (code);
          case 0x10:
            return new Bltzal.from_code (code);
          case 0x11:
            return new Bgezal.from_code (code);
          case 0x13:
            return new Bgezall.from_code (code);
          default:
            throw new ParserError.UNKNOWN_INSTRUCTION ("Unknown REGIMM instruction 0x%x (0x%x)", func, code);
          }

      case COP1:
        if (((code >> 4) & 0x0F) == 0x03) // 7-4
          return new Cop1.Ccond.from_code (code);

        int func = get_five1 (code);
        switch (func)
          {
          case 0x00:
            if ((code & 0x3FF) == 0)
              return new Cop1.Mfc1.from_code (code);
            break;
          case 0x04:
            if ((code & 0x3FF) == 0)
              return new Cop1.Mtc1.from_code (code);
            break;
          case 0x08:
            return new Cop1.Bc.from_code (code);
          }

        func = code & 0x3F;
        switch (func)
          {
          case 0x00:
            return new Cop1.Add.from_code (code);
          case 0x01:
            return new Cop1.Sub.from_code (code);
          case 0x02:
            return new Cop1.Mul.from_code (code);
          case 0x03:
            return new Cop1.Div.from_code (code);
          case 0x04:
            if (get_five2 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("SQRT 20-16 not zero");
            return new Cop1.Sqrt.from_code (code);
          case 0x05:
            if (get_five2 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("ABS 20-16 not zero");
            return new Cop1.Abs.from_code (code);
          case 0x06:
            if (get_five2 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("MOV 20-16 not zero");
            return new Cop1.Mov.from_code (code);
          case 0x0D:
            if (get_five2 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("TRUNC.W 20-16 not zero");
            return new Cop1.Truncw.from_code (code);
          case 0x20:
            if (get_five2 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("CVT.S 20-16 not zero");
            return new Cop1.Cvts.from_code (code);
          case 0x21:
            if (get_five2 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("CVT.D 20-16 not zero");
            return new Cop1.Cvtd.from_code (code);
          default:
            throw new ParserError.UNKNOWN_INSTRUCTION ("Unknown COP1 instruction 0x%x (0x%x)", func, code);
          }

      case SPECIAL2:
        int func = code & 0x3F;
        switch (func)
          {
          case 0x02:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("MUL 10-6 not zero");
            return new Mul.from_code (code);
          case 0x21:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("CLO 10-6 not zero");
            return new Clo.from_code (code);
          default:
            throw new ParserError.UNKNOWN_INSTRUCTION ("Unknown SPECIAL2 instruction 0x%x (0x%x)", func, code);
          }

      case 0x04:
        return new Beq.from_code (code);

      case 0x05:
        return new Bne.from_code (code);

      case 0x06:
        if (get_five2 (code) != 0)
          throw new ParserError.UNKNOWN_INSTRUCTION ("BLEZ 20-16 not zero");
        return new Blez.from_code (code);

      case 0x07:
        if (get_five2 (code) != 0)
          throw new ParserError.UNKNOWN_INSTRUCTION ("BGTZ 20-16 not zero");
        return new Bgtz.from_code (code);

      case 0x08:
        return new Addi.from_code (code);

      case 0x09:
        return new Addiu.from_code (code);

      case 0x0A:
        return new Slti.from_code (code);

      case 0x0B:
        return new Sltiu.from_code (code);

      case 0x0C:
        return new Andi.from_code (code);

      case 0x0D:
        return new Ori.from_code (code);

      case 0x0E:
        return new Xori.from_code (code);

      case 0x0F:
        if (get_five1 (code) != 0)
          throw new ParserError.UNKNOWN_INSTRUCTION ("LUI 25-21 not zero");
        return new Lui.from_code (code);

      case 0x14:
        return new Beql.from_code (code);

      case 0x16:
        if (get_five2 (code) != 0)
          throw new ParserError.UNKNOWN_INSTRUCTION ("BLEZL 20-16 not zero");
        return new Blezl.from_code (code);

      case 0x20:
        return new Lb.from_code (code);

      case 0x21:
        return new Lh.from_code (code);

      case 0x22:
        return new Lwl.from_code (code);

      case 0x23:
        return new Lw.from_code (code);

      case 0x24:
        return new Lbu.from_code (code);

      case 0x25:
        return new Lhu.from_code (code);

      case 0x26:
        return new Lwr.from_code (code);

      case 0x28:
        return new Sb.from_code (code);

      case 0x29:
        return new Sh.from_code (code);

      case 0x2A:
        return new Swl.from_code (code);

      case 0x2B:
        return new Sw.from_code (code);

      case 0x2E:
        return new Swr.from_code (code);

      case 0x31:
        return new Lwc1.from_code (code);

      case 0x35:
        return new Ldc1.from_code (code);

      case 0x39:
        return new Swc1.from_code (code);

      case 0x3D:
        return new Sdc1.from_code (code);

      default:
        throw new ParserError.UNKNOWN_INSTRUCTION ("Unknown instruction 0x%x (0x%x)", opcode, code);
      }
    }
  }
}
