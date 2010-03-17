namespace Mips
{
  public errordomain OpcodeError
  {
    INVALID_OPCODE,
    INVALID_FPU_FORMAT,
  }

  public static string fpu_fmt_to_string (int fmt, int opcode) throws OpcodeError
  {
    if (opcode == COP1)
      {
        switch (fmt)
          {
          case 0x10:
            return "S";
          case 0x11:
            return "D";
          case 0x14:
            return "W";
          case 0x15:
            return "L";
          case 0x16:
            return "PS";
          default:
            throw new OpcodeError.INVALID_FPU_FORMAT ("Unknown format %d for opcode %d\n", fmt, opcode);
          }
      }
    else if (opcode == COP1X)
      {
        switch (fmt)
          {
          case 0:
            return "S";
          case 1:
            return "D";
          case 4:
            return "W";
          case 5:
            return "L";
          case 6:
            return "PS";
          default:
            throw new OpcodeError.INVALID_FPU_FORMAT ("Unknown format %d for opcode %d\n", fmt, opcode);
          }
      }
    else
      throw new OpcodeError.INVALID_OPCODE ("Unknown opcode %d\n", opcode);
  }

  public class AssemblyWriter : Visitor
  {
    private StringBuilder builder = new StringBuilder ();

    public string write_instruction (Instruction instruction)
    {
      instruction.accept (this);
      var ret = builder.str;
      builder.truncate (0);
      return ret;
    }

    public override void visit_abs (Abs inst)
    {
      try
        {
          builder.append_printf ("ABS.%s 0x%x, 0x%x", fpu_fmt_to_string (inst.fmt, COP1), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_add (Add inst)
    {
      builder.append_printf ("ADD\t0x%x, 0x%x, 0x%x", inst.rs, inst.rt, inst.rd);
    }

    public override void visit_lui (Lui inst)
    {
      builder.append_printf ("LUI\t0x%x, %d", inst.rt, inst.immediate);
    }

    public override void visit_addiu (Addiu inst)
    {
      builder.append_printf ("ADDIU\t0x%x, 0x%x, %d", inst.rs, inst.rt, inst.immediate);
    }

    public override void visit_addu (Addu inst)
    {
      builder.append_printf ("ADDU\t0x%x, 0x%x, 0x%x", inst.rd, inst.rs, inst.rt);
    }

    public override void visit_sw (Sw inst)
    {
      builder.append_printf ("SW\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
    }

    public override void visit_bgezal (Bgezal inst)
    {
      builder.append_printf ("BGEZAL\t%d\t(BAL rs, %d)", inst.offset, inst.offset);
    }

    public override void visit_nop (Nop inst)
    {
      builder.append ("NOP");
    }

    public override void visit_lw (Lw inst)
    {
      builder.append_printf ("LW\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
    }

    public override void visit_lwl (Lwl inst)
    {
      builder.append_printf ("LWL\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
    }

    public override void visit_lwr (Lwr inst)
    {
      builder.append_printf ("LWR\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
    }

    public override void visit_jalr (Jalr inst)
    {
      if (inst.has_hint ())
        builder.append_printf ("JALR.HB\t0x%x, 0x%x", inst.rd, inst.rs);
      else
        builder.append_printf ("JALR\t0x%x, 0x%x", inst.rd, inst.rs);
    }

    public override void visit_jr (Jr inst)
    {
      if (inst.has_hint ())
        builder.append_printf ("JR.HB\t0x%x", inst.rs);
      else
        builder.append_printf ("JR\t0x%x", inst.rs);
    }

    public override void visit_bltzal (Bltzal inst)
    {
      builder.append_printf ("BLTZAL\t0x%x, 0x%x", inst.rs, inst.offset);
    }

    public override void visit_sll (Sll inst)
    {
      builder.append_printf ("SLL\t0x%x, 0x%x, 0x%x", inst.rd, inst.rt, inst.sa);
    }

    public override void visit_beq (Beq inst)
    {
      if (inst.is_unconditional ())
        builder.append_printf ("B\t%d", inst.offset);
      else
        builder.append_printf ("BEQ\t0x%x, 0x%x, %d", inst.rs, inst.rt, inst.offset);
    }

    public override void visit_bne (Bne inst)
    {
      builder.append_printf ("BNE\t0x%x, 0x%x, %d", inst.rs, inst.rt, inst.offset);
    }

    public override void visit_lbu (Lbu inst)
    {
      builder.append_printf ("LBU\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
    }

    public override void visit_sb (Sb inst)
    {
      builder.append_printf ("SB\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
    }

    public override void visit_sltiu (Sltiu inst)
    {
      builder.append_printf ("SLTIU\t0x%x, 0x%x, %d", inst.rs, inst.rt, inst.immediate);
    }

    public override void visit_slti (Slti inst)
    {
      builder.append_printf ("SLTI\t0x%x, 0x%x, %d", inst.rs, inst.rt, inst.immediate);
    }

    public override void visit_ori (Ori inst)
    {
      builder.append_printf ("ORI\t0x%x, 0x%x, %d", inst.rs, inst.rt, inst.immediate);
    }

    public override void visit_sltu (Sltu inst)
    {
      builder.append_printf ("SLTU\t0x%x, 0x%x, 0x%x", inst.rd, inst.rs, inst.rt);
    }

    public override void visit_sllv (Sllv inst)
    {
      builder.append_printf ("SLLV\t0x%x, 0x%x, 0x%x", inst.rd, inst.rs, inst.rt);
    }

    public override void visit_and (And inst)
    {
      builder.append_printf ("AND\t0x%x, 0x%x, 0x%x", inst.rd, inst.rs, inst.rt);
    }

    public override void visit_or (Or inst)
    {
      builder.append_printf ("OR\t0x%x, 0x%x, 0x%x", inst.rd, inst.rs, inst.rt);
    }

    public override void visit_lhu (Lhu inst)
    {
      builder.append_printf ("LHU\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
    }

    public override void visit_subu (Subu inst)
    {
      builder.append_printf ("SUBU\t0x%x, 0x%x, 0x%x", inst.rd, inst.rs, inst.rt);
    }

    public override void visit_sh (Sh inst)
    {
      builder.append_printf ("SH\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
    }

    public override void visit_lh (Lh inst)
    {
      builder.append_printf ("LH\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
    }

    public override void visit_srl (Srl inst)
    {
      if (inst.is_rotr ())
        builder.append_printf ("ROTR\t0x%x, 0x%x, 0x%x", inst.rd, inst.rt, inst.sa);
      else
        builder.append_printf ("SRL\t0x%x, 0x%x, 0x%x", inst.rd, inst.rt, inst.sa);
    }

    public override void visit_andi (Andi inst)
    {
      builder.append_printf ("ANDI\t0x%x, 0x%x, %d", inst.rs, inst.rt, inst.immediate);
    }

    public override void visit_bgez (Bgez inst)
    {
      builder.append_printf ("BGEZ\t0x%x, 0x%x", inst.rs, inst.offset);
    }

    public override void visit_sra (Sra inst)
    {
      builder.append_printf ("SRA\t0x%x, 0x%x, 0x%x", inst.rd, inst.rt, inst.sa);
    }

    public override void visit_lb (Lb inst)
    {
      builder.append_printf ("LB\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
    }

    public override void visit_bltz (Bltz inst)
    {
      builder.append_printf ("BLTZ\t0x%x, 0x%x", inst.rs, inst.offset);
    }

    public override void visit_slt (Slt inst)
    {
      builder.append_printf ("SLT\t0x%x, 0x%x, 0x%x", inst.rd, inst.rs, inst.rt);
    }

    public override void visit_mult (Mult inst)
    {
      builder.append_printf ("MULT\t0x%x, 0x%x", inst.rs, inst.rt);
    }

    public override void visit_multu (Multu inst)
    {
      builder.append_printf ("MULTU\t0x%x, 0x%x", inst.rs, inst.rt);
    }

    public override void visit_mfhi (Mfhi inst)
    {
      builder.append_printf ("MFHI\t0x%x", inst.rd);
    }

    public override void visit_blez (Blez inst)
    {
      builder.append_printf ("BLEZ\t0x%x, 0x%x", inst.rs, inst.offset);
    }

    public override void visit_bgtz (Bgtz inst)
    {
      builder.append_printf ("BGTZ\t0x%x, 0x%x", inst.rs, inst.offset);
    }

    public override void visit_xori (Xori inst)
    {
      builder.append_printf ("XORI\t0x%x, 0x%x, %d", inst.rt, inst.rs, inst.immediate);
    }

    public override void visit_clo (Clo inst)
    {
      builder.append_printf ("CLO\t0x%x, 0x%x", inst.rd, inst.rs);
    }

    public override void visit_mul (Mul inst)
    {
      builder.append_printf ("MUL\t0x%x, 0x%x, 0x%x", inst.rd, inst.rs, inst.rt);
    }

    public override void visit_nor (Nor inst)
    {
      builder.append_printf ("NOR\t0x%x, 0x%x, 0x%x", inst.rd, inst.rs, inst.rt);
    }

    public override void visit_xor (Xor inst)
    {
      builder.append_printf ("XOR\t0x%x, 0x%x, 0x%x", inst.rd, inst.rs, inst.rt);
    }

    public override void visit_srlv (Srlv inst)
    {
      if (inst.is_rotr ())
        builder.append_printf ("ROTRV\t0x%x, 0x%x, 0x%x", inst.rd, inst.rt, inst.rs);
      else
        builder.append_printf ("SRLV\t0x%x, 0x%x, 0x%x", inst.rd, inst.rs, inst.rt);
    }

    public override void visit_srav (Srav inst)
    {
      builder.append_printf ("SRAV\t0x%x, 0x%x, 0x%x", inst.rd, inst.rt, inst.rs);
    }

    public override void visit_divu (Divu inst)
    {
      builder.append_printf ("DIVU\t0x%x, 0x%x", inst.rs, inst.rt);
    }

    public override void visit_break (Break inst)
    {
      builder.append_printf ("BREAK");
    }

    public override void visit_mflo (Mflo inst)
    {
      builder.append_printf ("MFLO\t0x%x", inst.rd);
    }

    public override void visit_movz (Movz inst)
    {
      builder.append_printf ("MOVZ\t0x%x, 0x%x, 0x%x", inst.rd, inst.rs, inst.rt);
    }

    public override void visit_movn (Movn inst)
    {
      builder.append_printf ("MOVN\t0x%x, 0x%x, 0x%x", inst.rd, inst.rs, inst.rt);
    }

    public override void visit_div (Div inst)
    {
      builder.append_printf ("DIV\t0x%x, 0x%x", inst.rs, inst.rt);
    }

    public override void visit_blezl (Blezl inst)
    {
      builder.append_printf ("BLEZL\t0x%x, 0x%x", inst.rs, inst.offset);
    }
  }
}