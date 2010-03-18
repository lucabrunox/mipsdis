namespace Mips
{
  public errordomain OpcodeError
  {
    INVALID_OPCODE,
    INVALID_FPU_FORMAT,
    INVALID_FPU_COND,
  }

  public static string fpu_cond_to_string (int cond, int opcode) throws OpcodeError
  {
    if (opcode == COP1)
      {
        switch (cond)
          {
          case 0:
            return "F";
          case 1:
            return "UN";
          case 2:
            return "EQ";
          case 3:
            return "UEQ";
          case 4:
            return "OLT";
          case 5:
            return "ULT";
          case 6:
            return "OLE";
          case 7:
            return "ULE";
          case 8:
            return "SF";
          case 9:
            return "NGLE";
          case 10:
            return "SEQ";
          case 11:
            return "NGL";
          case 12:
            return "LT";
          case 13:
            return "NGE";
          case 14:
            return "LE";
          case 15:
            return "NGT";
          default:
            throw new OpcodeError.INVALID_FPU_COND ("Unknown cond %d for COP1", cond);
          }
      }
    else
      throw new OpcodeError.INVALID_OPCODE ("Unknown opcode %d\n", opcode);
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
            throw new OpcodeError.INVALID_FPU_FORMAT ("Unknown format %d for COP1", fmt);
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
            throw new OpcodeError.INVALID_FPU_FORMAT ("Unknown format %d for COP1X", fmt);
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

    public override void visit_fpu_abs (Fpu.Abs inst)
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

    public override void visit_fpu_sqrt (Fpu.Sqrt inst)
    {
      try
        {
          builder.append_printf ("SQRT.%s 0x%x, 0x%x", fpu_fmt_to_string (inst.fmt, COP1), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_fpu_truncw (Fpu.Truncw inst)
    {
      try
        {
          builder.append_printf ("TRUNC.W.%s 0x%x, 0x%x", fpu_fmt_to_string (inst.fmt, COP1), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_fpu_cvtd (Fpu.Cvtd inst)
    {
      try
        {
          builder.append_printf ("CVT.D.%s 0x%x, 0x%x", fpu_fmt_to_string (inst.fmt, COP1), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_fpu_cvts (Fpu.Cvts inst)
    {
      try
        {
          if (inst.fmt == 0x16)
            builder.append_printf ("CVT.S.PU 0x%x, 0x%x", inst.fd, inst.fs);
          else
            builder.append_printf ("CVT.S.%s 0x%x, 0x%x", fpu_fmt_to_string (inst.fmt, COP1), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_fpu_mov (Fpu.Mov inst)
    {
      try
        {
          builder.append_printf ("MOV.%s 0x%x, 0x%x", fpu_fmt_to_string (inst.fmt, COP1), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_fpu_sub (Fpu.Sub inst)
    {
      try
        {
          builder.append_printf ("SUB.%s 0x%x, 0x%x, 0x%x", fpu_fmt_to_string (inst.fmt, COP1), inst.fd, inst.fs, inst.ft);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_fpu_mul (Fpu.Mul inst)
    {
      try
        {
          builder.append_printf ("MUL.%s 0x%x, 0x%x, 0x%x", fpu_fmt_to_string (inst.fmt, COP1), inst.fd, inst.fs, inst.ft);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_fpu_div (Fpu.Div inst)
    {
      try
        {
          builder.append_printf ("DIV.%s 0x%x, 0x%x, 0x%x", fpu_fmt_to_string (inst.fmt, COP1), inst.fd, inst.fs, inst.ft);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_fpu_add (Fpu.Add inst)
    {
      try
        {
          builder.append_printf ("ADD.%s 0x%x, 0x%x, 0x%x", fpu_fmt_to_string (inst.fmt, COP1), inst.fd, inst.fs, inst.ft);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_fpu_ccond (Fpu.Ccond inst)
    {
      try
        {
          if (inst.cc == 0)
            builder.append_printf ("C.%s.%s 0x%x, 0x%x\t(cc = 0 implied)", fpu_cond_to_string (inst.cond, COP1), fpu_fmt_to_string (inst.fmt, COP1), inst.fs, inst.ft);
          else
            builder.append_printf ("C.%s.%s %d, 0x%x, 0x%x", fpu_cond_to_string (inst.cond, COP1), fpu_fmt_to_string (inst.fmt, COP1), inst.cc, inst.fs, inst.ft);  
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_fpu_bc (Fpu.Bc inst)
    {
      if (inst.branch == Fpu.Bc.Branch.FALSE)
        builder.append_printf ("BC1F 0x%x, 0x%x", inst.cc, inst.offset);
      else if (inst.branch == Fpu.Bc.Branch.FALSE_LIKELY)
        builder.append_printf ("BC1FL 0x%x, 0x%x", inst.cc, inst.offset);
      else if (inst.branch == Fpu.Bc.Branch.TRUE)
        builder.append_printf ("BC1T 0x%x, 0x%x", inst.cc, inst.offset);
      else if (inst.branch == Fpu.Bc.Branch.TRUE_LIKELY)
        builder.append_printf ("BC1TL 0x%x, 0x%x", inst.cc, inst.offset);
      else
        assert_not_reached ();
    }

    public override void visit_fpu_mfc1 (Fpu.Mfc1 inst)
    {
      builder.append_printf ("MFC1\t0x%x, 0x%x", inst.rt, inst.fs);
    }

    public override void visit_fpu_mtc1 (Fpu.Mtc1 inst)
    {
      builder.append_printf ("MTC1\t0x%x, 0x%x", inst.rt, inst.fs);
    }

    public override void visit_fpu_movci (Fpu.Movci inst)
    {
      if (inst.test_true)
        builder.append_printf ("MOVT 0x%x, 0x%x, %d", inst.rd, inst.rs, inst.cc);
      else
        builder.append_printf ("MOVF 0x%x, 0x%x, %d", inst.rd, inst.rs, inst.cc);
    }

    public override void visit_fpu_movcf (Fpu.Movcf inst)
    {
      try
        {
          if (inst.test_true)
            builder.append_printf ("MOVT.%s 0x%x, 0x%x, %d", fpu_fmt_to_string (inst.fmt, COP1), inst.fd, inst.fs, inst.cc);
          else
            builder.append_printf ("MOVF.%s 0x%x, 0x%x, %d", fpu_fmt_to_string (inst.fmt, COP1), inst.fd, inst.fs, inst.cc);
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

    public override void visit_swl (Swl inst)
    {
      builder.append_printf ("SWL\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
    }

    public override void visit_swr (Swr inst)
    {
      builder.append_printf ("SWR\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
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

    public override void visit_sdc1 (Sdc1 inst)
    {
      builder.append_printf ("SDC1\t0x%x, %d(0x%x)", inst.ft, inst.offset, inst.@base);
    }

    public override void visit_ldc1 (Ldc1 inst)
    {
      builder.append_printf ("LDC1\t0x%x, %d(0x%x)", inst.ft, inst.offset, inst.@base);
    }

    public override void visit_lwc1 (Lwc1 inst)
    {
      builder.append_printf ("LWC1\t0x%x, %d(0x%x)", inst.ft, inst.offset, inst.@base);
    }

    public override void visit_swc1 (Swc1 inst)
    {
      builder.append_printf ("SWC1\t0x%x, %d(0x%x)", inst.ft, inst.offset, inst.@base);
    }
  }
}
