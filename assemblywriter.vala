namespace Mips
{
  public errordomain OpcodeError
  {
    INVALID_OPCODE,
    INVALID_FPU_FORMAT,
    INVALID_FPU_COND,
  }

  public static string cond_to_string (int cond) throws OpcodeError
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

  public static string cop1_fmt_to_string (int fmt) throws OpcodeError
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

  public static string cop1x_fmt_to_string (int fmt) throws OpcodeError
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

    public override void visit_cop1_abs (Cop1.Abs inst)
    {
      try
        {
          builder.append_printf ("ABS.%s 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_movz (Cop1.Movz inst)
    {
      try
        {
          builder.append_printf ("MOVZ.%s 0x%x, 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs, inst.rt);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_sqrt (Cop1.Sqrt inst)
    {
      try
        {
          builder.append_printf ("SQRT.%s 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_truncw (Cop1.Truncw inst)
    {
      try
        {
          builder.append_printf ("TRUNC.W.%s 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_truncl (Cop1.Truncl inst)
    {
      try
        {
          builder.append_printf ("TRUNC.L.%s 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_ceilw (Cop1.Ceilw inst)
    {
      try
        {
          builder.append_printf ("CEIL.W.%s 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_floorw (Cop1.Floorw inst)
    {
      try
        {
          builder.append_printf ("FLOOR.W.%s 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_roundl (Cop1.Roundl inst)
    {
      try
        {
          builder.append_printf ("ROUND.L.%s 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_roundw (Cop1.Roundw inst)
    {
      try
        {
          builder.append_printf ("ROUND.W.%s 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_rsqrt (Cop1.Rsqrt inst)
    {
      try
        {
          builder.append_printf ("RQSRT.%s 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_cvtd (Cop1.Cvtd inst)
    {
      try
        {
          builder.append_printf ("CVT.D.%s 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_cvtw (Cop1.Cvtw inst)
    {
      try
        {
          builder.append_printf ("CVT.W.%s 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_cvts (Cop1.Cvts inst)
    {
      try
        {
          if (inst.fmt == 0x16)
            builder.append_printf ("CVT.S.PU 0x%x, 0x%x", inst.fd, inst.fs);
          else
            builder.append_printf ("CVT.S.%s 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_mov (Cop1.Mov inst)
    {
      try
        {
          builder.append_printf ("MOV.%s 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_neg (Cop1.Neg inst)
    {
      try
        {
          builder.append_printf ("NEG.%s 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_mul (Cop1.Mul inst)
    {
      try
        {
          builder.append_printf ("MUL.%s 0x%x, 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs, inst.ft);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_div (Cop1.Div inst)
    {
      try
        {
          builder.append_printf ("DIV.%s 0x%x, 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs, inst.ft);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_add (Cop1.Add inst)
    {
      try
        {
          builder.append_printf ("ADD.%s 0x%x, 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs, inst.ft);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_sub (Cop1.Sub inst)
    {
      try
        {
          builder.append_printf ("SUB.%s 0x%x, 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs, inst.ft);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_pll (Cop1.Pll inst)
    {
      builder.append_printf ("PLL.PS 0x%x, 0x%x, 0x%x", inst.fd, inst.fs, inst.ft);
    }

    public override void visit_cop1_plu (Cop1.Plu inst)
    {
      builder.append_printf ("PLU.PS 0x%x, 0x%x, 0x%x", inst.fd, inst.fs, inst.ft);
    }

    public override void visit_cop1_pul (Cop1.Pul inst)
    {
      builder.append_printf ("PUL.PS 0x%x, 0x%x, 0x%x", inst.fd, inst.fs, inst.ft);
    }

    public override void visit_cop1_puu (Cop1.Puu inst)
    {
      builder.append_printf ("PUU.PS 0x%x, 0x%x, 0x%x", inst.fd, inst.fs, inst.ft);
    }

    public override void visit_cop1_ccond (Cop1.Ccond inst)
    {
      try
        {
          if (inst.cc == 0)
            builder.append_printf ("C.%s.%s 0x%x, 0x%x\t(cc = 0 implied)", cond_to_string (inst.cond), cop1_fmt_to_string (inst.fmt), inst.fs, inst.ft);
          else
            builder.append_printf ("C.%s.%s %d, 0x%x, 0x%x", cond_to_string (inst.cond), cop1_fmt_to_string (inst.fmt), inst.cc, inst.fs, inst.ft);  
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1_bc (Cop1.Bc inst)
    {
      if (inst.branch == Cop1.Bc.Branch.FALSE)
        builder.append_printf ("BC1F 0x%x, 0x%x", inst.cc, inst.offset);
      else if (inst.branch == Cop1.Bc.Branch.FALSE_LIKELY)
        builder.append_printf ("BC1FL 0x%x, 0x%x", inst.cc, inst.offset);
      else if (inst.branch == Cop1.Bc.Branch.TRUE)
        builder.append_printf ("BC1T 0x%x, 0x%x", inst.cc, inst.offset);
      else if (inst.branch == Cop1.Bc.Branch.TRUE_LIKELY)
        builder.append_printf ("BC1TL 0x%x, 0x%x", inst.cc, inst.offset);
      else
        assert_not_reached ();
    }

    public override void visit_cop2_bc (Cop2.Bc inst)
    {
      if (inst.branch == Cop2.Bc.Branch.FALSE)
        builder.append_printf ("BC2F 0x%x, 0x%x", inst.cc, inst.offset);
      else if (inst.branch == Cop2.Bc.Branch.FALSE_LIKELY)
        builder.append_printf ("BC2FL 0x%x, 0x%x", inst.cc, inst.offset);
      else if (inst.branch == Cop2.Bc.Branch.TRUE)
        builder.append_printf ("BC2T 0x%x, 0x%x", inst.cc, inst.offset);
      else if (inst.branch == Cop2.Bc.Branch.TRUE_LIKELY)
        builder.append_printf ("BC2TL 0x%x, 0x%x", inst.cc, inst.offset);
      else
        assert_not_reached ();
    }

    public override void visit_cop1_mf (Cop1.Mf inst)
    {
      builder.append_printf ("MFC1\t0x%x, 0x%x", inst.rt, inst.fs);
    }

    public override void visit_cop1_mfh (Cop1.Mfh inst)
    {
      builder.append_printf ("MFHC1\t0x%x, 0x%x", inst.rt, inst.fs);
    }

    public override void visit_cop1_mth (Cop1.Mth inst)
    {
      builder.append_printf ("MTHC1\t0x%x, 0x%x", inst.rt, inst.fs);
    }

    public override void visit_cop1_cf (Cop1.Cf inst)
    {
      builder.append_printf ("CFC1\t0x%x, 0x%x", inst.rt, inst.fs);
    }

    public override void visit_cop1_ct (Cop1.Ct inst)
    {
      builder.append_printf ("CTC1\t0x%x, 0x%x", inst.rt, inst.fs);
    }

    public override void visit_cop2_cf (Cop2.Cf inst)
    {
      builder.append_printf ("CFC2\t0x%x, 0x%x", inst.rt, inst.rd);
    }

    public override void visit_cop2_ct (Cop2.Ct inst)
    {
      builder.append_printf ("CTC2\t0x%x, 0x%x", inst.rt, inst.rd);
    }

    public override void visit_cop2_mf (Cop2.Mf inst)
    {
      builder.append_printf ("MFC2\t0x%x, 0x%x", inst.rt, inst.impl);
    }

    public override void visit_cop2_mt (Cop2.Mt inst)
    {
      builder.append_printf ("MTC2\t0x%x, 0x%x", inst.rt, inst.impl);
    }

    public override void visit_cop2_mfh (Cop2.Mfh inst)
    {
      builder.append_printf ("MFHC2\t0x%x, 0x%x", inst.rt, inst.impl);
    }

    public override void visit_cop2_mth (Cop2.Mth inst)
    {
      builder.append_printf ("MTHC2\t0x%x, 0x%x", inst.rt, inst.impl);
    }

    public override void visit_cop1_mt (Cop1.Mt inst)
    {
      builder.append_printf ("MTC1\t0x%x, 0x%x", inst.rt, inst.fs);
    }

    public override void visit_movci (Movci inst)
    {
      if (inst.test_true)
        builder.append_printf ("MOVT 0x%x, 0x%x, %d", inst.rd, inst.rs, inst.cc);
      else
        builder.append_printf ("MOVF 0x%x, 0x%x, %d", inst.rd, inst.rs, inst.cc);
    }

    public override void visit_cop1_movcf (Cop1.Movcf inst)
    {
      try
      {
        if (inst.test_true)
          builder.append_printf ("MOVT.%s 0x%x, 0x%x, %d", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs, inst.cc);
        else
          builder.append_printf ("MOVF.%s 0x%x, 0x%x, %d", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs, inst.cc);
      }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1x_madd (Cop1x.Madd inst)
    {
      try
        {
          builder.append_printf ("MADD.%s 0x%x, 0x%x, 0x%x, 0x%x", cop1x_fmt_to_string (inst.fmt), inst.fd, inst.fr, inst.fs, inst.ft);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1x_nmadd (Cop1x.Nmadd inst)
    {
      try
        {
          builder.append_printf ("NMADD.%s 0x%x, 0x%x, 0x%x, 0x%x", cop1x_fmt_to_string (inst.fmt), inst.fd, inst.fr, inst.fs, inst.ft);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1x_nmsub (Cop1x.Nmsub inst)
    {
      try
        {
          builder.append_printf ("NMSUB.%s 0x%x, 0x%x, 0x%x, 0x%x", cop1x_fmt_to_string (inst.fmt), inst.fd, inst.fr, inst.fs, inst.ft);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
    }

    public override void visit_cop1x_msub (Cop1x.Msub inst)
    {
      try
        {
          builder.append_printf ("MSUB.%s 0x%x, 0x%x, 0x%x, 0x%x", cop1x_fmt_to_string (inst.fmt), inst.fd, inst.fr, inst.fs, inst.ft);
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

    public override void visit_madd (Madd inst)
    {
      builder.append_printf ("MADD\t0x%x, 0x%x", inst.rs, inst.rt);
    }

    public override void visit_msub (Msub inst)
    {
      builder.append_printf ("MSUB\t0x%x, 0x%x", inst.rs, inst.rt);
    }

    public override void visit_msubu (Msubu inst)
    {
      builder.append_printf ("MSUBU\t0x%x, 0x%x", inst.rs, inst.rt);
    }

    public override void visit_maddu (Maddu inst)
    {
      builder.append_printf ("MADDU\t0x%x, 0x%x", inst.rs, inst.rt);
    }

    public override void visit_lui (Lui inst)
    {
      builder.append_printf ("LUI\t0x%x, %d", inst.rt, inst.immediate);
    }

    public override void visit_addiu (Addiu inst)
    {
      builder.append_printf ("ADDIU\t0x%x, 0x%x, %u", inst.rs, inst.rt, inst.immediate);
    }

    public override void visit_addi (Addi inst)
    {
      builder.append_printf ("ADDI\t0x%x, 0x%x, %d", inst.rs, inst.rt, inst.immediate);
    }

    public override void visit_addu (Addu inst)
    {
      builder.append_printf ("ADDU\t0x%x, 0x%x, 0x%x", inst.rd, inst.rs, inst.rt);
    }

    public override void visit_rdhwr (Rdhwr inst)
    {
      builder.append_printf ("RDHWR\t0x%x, 0x%x", inst.rt, inst.rd);
    }

    public override void visit_sw (Sw inst)
    {
      builder.append_printf ("SW\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
    }

    public override void visit_cache (Cache inst)
    {
      builder.append_printf ("CACHE\t0x%x, %d(0x%x)", inst.op, inst.offset, inst.@base);
    }

    public override void visit_pref (Pref inst)
    {
      builder.append_printf ("PREF\t0x%x, %d(0x%x)", inst.hint, inst.offset, inst.@base);
    }

    public override void visit_cop1x_prefx (Cop1x.Prefx inst)
    {
      builder.append_printf ("PREFX\t0x%x, %d(0x%x)", inst.hint, inst.index, inst.@base);
    }

    public override void visit_sync (Sync inst)
    {
      builder.append_printf ("SYNC");
    }

    public override void visit_swl (Swl inst)
    {
      builder.append_printf ("SWL\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
    }

    public override void visit_swr (Swr inst)
    {
      builder.append_printf ("SWR\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
    }

    public override void visit_regimm_bgezal (Regimm.Bgezal inst)
    {
      if (inst.rs == 0)
        builder.append_printf ("BAL\t%d", inst.offset);
      else
        builder.append_printf ("BGEZAL\t0x%x, %d", inst.rs, inst.offset);
    }

    public override void visit_regimm_bgezall (Regimm.Bgezall inst)
    {
      builder.append_printf ("BGEZALL\t0x%x, %d", inst.rs, inst.offset);
    }

    public override void visit_regimm_synci (Regimm.Synci inst)
    {
      builder.append_printf ("SYNCI\t0x%x(0x%x)", inst.offset, inst.@base);
    }

    public override void visit_nop (Nop inst)
    {
      builder.append ("NOP");
    }

    public override void visit_ssnop (Ssnop inst)
    {
      builder.append ("SSNOP");
    }

    public override void visit_cop0_deret (Cop0.Deret inst)
    {
      builder.append ("DERET");
    }

    public override void visit_cop0_eret (Cop0.Eret inst)
    {
      builder.append ("ERET");
    }

    public override void visit_cop0_mf (Cop0.Mf inst)
    {
      builder.append_printf ("MFC0 0x%x, 0x%x, %d", inst.rt, inst.rd, inst.sel);
    }

    public override void visit_cop0_mt (Cop0.Mt inst)
    {
      builder.append_printf ("MTC0 0x%x, 0x%x, %d", inst.rt, inst.rd, inst.sel);
    }

    public override void visit_cop0_rdpgpr (Cop0.Rdpgpr inst)
    {
      builder.append_printf ("RDPGPR 0x%x, 0x%x", inst.rd, inst.rt);
    }

    public override void visit_cop0_wrpgpr (Cop0.Wrpgpr inst)
    {
      builder.append_printf ("WRPGPR 0x%x, 0x%x", inst.rd, inst.rt);
    }

    public override void visit_cop1_recip (Cop1.Recip inst)
    {
      try
        {
          builder.append_printf ("RECIP.%s 0x%x, 0x%x", cop1_fmt_to_string (inst.fmt), inst.fd, inst.fs);
        }
      catch (OpcodeError e)
      {
        builder.append (e.message);
      }
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

    public override void visit_regimm_bltzal (Regimm.Bltzal inst)
    {
      builder.append_printf ("BLTZAL\t0x%x, 0x%x", inst.rs, inst.offset);
    }

    public override void visit_regimm_bltzall (Regimm.Bltzall inst)
    {
      builder.append_printf ("BLTZALL\t0x%x, 0x%x", inst.rs, inst.offset);
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

    public override void visit_beql (Beql inst)
    {
      builder.append_printf ("BEQ\t0x%x, 0x%x, %d", inst.rs, inst.rt, inst.offset);
    }

    public override void visit_bne (Bne inst)
    {
      builder.append_printf ("BNE\t0x%x, 0x%x, %d", inst.rs, inst.rt, inst.offset);
    }

    public override void visit_bnel (Bnel inst)
    {
      builder.append_printf ("BNEL\t0x%x, 0x%x, %d", inst.rs, inst.rt, inst.offset);
    }

    public override void visit_lbu (Lbu inst)
    {
      builder.append_printf ("LBU\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
    }

    public override void visit_sb (Sb inst)
    {
      builder.append_printf ("SB\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
    }

    public override void visit_seb (Seb inst)
    {
      builder.append_printf ("SEB\t0x%x, 0x%x", inst.rd, inst.rt);
    }

    public override void visit_wsbh (Wsbh inst)
    {
      builder.append_printf ("WSBH\t0x%x, 0x%x", inst.rd, inst.rt);
    }

    public override void visit_seh (Seh inst)
    {
      builder.append_printf ("SEH\t0x%x, 0x%x", inst.rd, inst.rt);
    }

    public override void visit_sc (Sc inst)
    {
      builder.append_printf ("SC\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
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

    public override void visit_regimm_bgez (Regimm.Bgez inst)
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

    public override void visit_ll (Ll inst)
    {
      builder.append_printf ("LL\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
    }

    public override void visit_regimm_bltz (Regimm.Bltz inst)
    {
      builder.append_printf ("BLTZ\t0x%x, 0x%x", inst.rs, inst.offset);
    }

    public override void visit_regimm_bltzl (Regimm.Bltzl inst)
    {
      builder.append_printf ("BLTZL\t0x%x, 0x%x", inst.rs, inst.offset);
    }

    public override void visit_regimm_bgezl (Regimm.Bgezl inst)
    {
      builder.append_printf ("BGEZL\t0x%x, 0x%x", inst.rs, inst.offset);
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

    public override void visit_mthi (Mthi inst)
    {
      builder.append_printf ("MTHI\t0x%x", inst.rs);
    }

    public override void visit_blez (Blez inst)
    {
      builder.append_printf ("BLEZ\t0x%x, 0x%x", inst.rs, inst.offset);
    }

    public override void visit_bgtz (Bgtz inst)
    {
      builder.append_printf ("BGTZ\t0x%x, 0x%x", inst.rs, inst.offset);
    }

    public override void visit_bgtzl (Bgtzl inst)
    {
      builder.append_printf ("BGTZL\t0x%x, 0x%x", inst.rs, inst.offset);
    }

    public override void visit_xori (Xori inst)
    {
      builder.append_printf ("XORI\t0x%x, 0x%x, %d", inst.rt, inst.rs, inst.immediate);
    }

    public override void visit_clo (Clo inst)
    {
      builder.append_printf ("CLO\t0x%x, 0x%x", inst.rd, inst.rs);
    }

    public override void visit_clz (Clz inst)
    {
      builder.append_printf ("CLZ\t0x%x, 0x%x", inst.rd, inst.rs);
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

    public override void visit_mtlo (Mtlo inst)
    {
      builder.append_printf ("MTLO\t0x%x", inst.rs);
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

    public override void visit_sdc2 (Sdc2 inst)
    {
      builder.append_printf ("SDC2\t0x%x, %d(0x%x)", inst.rt, inst.offset, inst.@base);
    }

    public override void visit_cop1x_sdxc1 (Cop1x.Sdxc1 inst)
    {
      builder.append_printf ("SDXC1\t0x%x, %d(0x%x)", inst.fs, inst.index, inst.@base);
    }

    public override void visit_cop1x_suxc1 (Cop1x.Suxc1 inst)
    {
      builder.append_printf ("SUXC1\t0x%x, %d(0x%x)", inst.fs, inst.index, inst.@base);
    }

    public override void visit_cop1x_swxc1 (Cop1x.Swxc1 inst)
    {
      builder.append_printf ("SWXC1\t0x%x, %d(0x%x)", inst.fs, inst.index, inst.@base);
    }

    public override void visit_ldc1 (Ldc1 inst)
    {
      builder.append_printf ("LDC1\t0x%x, %d(0x%x)", inst.ft, inst.offset, inst.@base);
    }

    public override void visit_ldc2 (Ldc2 inst)
    {
      builder.append_printf ("LDC2\t0x%x, %d(0x%x)", inst.ft, inst.offset, inst.@base);
    }

    public override void visit_lwc1 (Lwc1 inst)
    {
      builder.append_printf ("LWC1\t0x%x, %d(0x%x)", inst.ft, inst.offset, inst.@base);
    }

    public override void visit_lwc2 (Lwc2 inst)
    {
      builder.append_printf ("LWC2\t0x%x, %d(0x%x)", inst.ft, inst.offset, inst.@base);
    }

    public override void visit_swc1 (Swc1 inst)
    {
      builder.append_printf ("SWC1\t0x%x, %d(0x%x)", inst.ft, inst.offset, inst.@base);
    }

    public override void visit_swc2 (Swc2 inst)
    {
      builder.append_printf ("SWC2\t0x%x, %d(0x%x)", inst.ft, inst.offset, inst.@base);
    }

    public override void visit_jump (Jump inst)
    {
      builder.append_printf ("J\t0x%x", inst.instr_index);
    }

    public override void visit_jal (Jal inst)
    {
      builder.append_printf ("JAL\t0x%x", inst.instr_index);
    }

    public override void visit_sdbbp (Sdbbp inst)
    {
      builder.append_printf ("SDBBP\t0x%x", inst.code);
    }

    public override void visit_syscall (Syscall inst)
    {
      builder.append_printf ("SYSCALL\t0x%x", inst.code);
    }

    public override void visit_teq (Teq inst)
    {
      builder.append_printf ("TEQ\t0x%x, 0x%x", inst.rs, inst.rt);
    }

    public override void visit_regimm_teqi (Regimm.Teqi inst)
    {
      builder.append_printf ("TEQI\t0x%x, %d", inst.rs, inst.immediate);
    }

    public override void visit_tge (Tge inst)
    {
      builder.append_printf ("TGE\t0x%x, 0x%x", inst.rs, inst.rt);
    }

    public override void visit_regimm_tgei (Regimm.Tgei inst)
    {
      builder.append_printf ("TGEI\t0x%x, %u", inst.rs, inst.immediate);
    }

    public override void visit_regimm_tgeiu (Regimm.Tgeiu inst)
    {
      builder.append_printf ("TGEIU\t0x%x, %u", inst.rs, inst.immediate);
    }

    public override void visit_tgeu (Tgeu inst)
    {
      builder.append_printf ("TGEU\t0x%x, 0x%x", inst.rs, inst.rt);
    }

    public override void visit_cop0_tlbp (Cop0.Tlbp inst)
    {
      builder.append_printf ("TLBP");
    }

    public override void visit_cop0_tlbr (Cop0.Tlbr inst)
    {
      builder.append_printf ("TLBR");
    }

    public override void visit_cop0_tlbwi (Cop0.Tlbwi inst)
    {
      builder.append_printf ("TLBWI");
    }

    public override void visit_cop0_tlbwr (Cop0.Tlbwr inst)
    {
      builder.append_printf ("TLBWR");
    }

    public override void visit_cop0_wait (Cop0.Wait inst)
    {
      builder.append_printf ("WAIT");
    }

    public override void visit_tlt (Tlt inst)
    {
      builder.append_printf ("TLT\t0x%x, 0x%x", inst.rs, inst.rt);
    }

    public override void visit_regimm_tlti (Regimm.Tlti inst)
    {
      builder.append_printf ("TLTI\t0x%x, %u", inst.rs, inst.immediate);
    }

    public override void visit_regimm_tltiu (Regimm.Tltiu inst)
    {
      builder.append_printf ("TLTIU\t0x%x, %u", inst.rs, inst.immediate);
    }
   
    public override void visit_tltu (Tltu inst)
    {
      builder.append_printf ("TLTU\t0x%x, 0x%x", inst.rs, inst.rt);
    }

    public override void visit_tne (Tne inst)
    {
      builder.append_printf ("TNE\t0x%x, 0x%x", inst.rs, inst.rt);
    }

    public override void visit_regimm_tnei (Regimm.Tnei inst)
    {
      builder.append_printf ("TNEI\t0x%x, %u", inst.rs, inst.immediate);
    }
  }
}
