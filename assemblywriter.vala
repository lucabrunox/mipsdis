namespace Mips
{
  public errordomain OpcodeError
  {
    INVALID_OPCODE,
    INVALID_FPU_FORMAT,
    INVALID_REGISTER,
  }

  public class AssemblyWriter : Visitor
  {
    private StringBuilder builder = new StringBuilder ();

    public string write (BinaryCode binary_code)
    {
      foreach (var binary_instruction in binary_code.text_section.binary_instructions)
        {
          if (binary_instruction.label != null)
            {
              if (binary_instruction.is_func_start)
                builder.append_printf ("# function <%s>:\n", binary_instruction.label);
              else
                builder.append_printf ("%s:\n", binary_instruction.label);
            }
          builder.append_printf ("%.8x:\t%.8x\t", binary_instruction.virtual_address, binary_instruction.file_value);
          binary_instruction.instruction.accept (this);
          builder.append_c ('\n');
        }
      return builder.str;
    }

    public override void visit_cop1_abs (Cop1.Abs inst)
    {
      builder.append_printf ("ABS.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_movz (Cop1.Movz inst)
    {
      builder.append_printf ("MOVZ.%s\t%s, %s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string(), inst.rt.to_string());
    }

    public override void visit_cop1_sqrt (Cop1.Sqrt inst)
    {
      builder.append_printf ("SQRT.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_truncw (Cop1.Truncw inst)
    {
      builder.append_printf ("TRUNC.W.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_truncl (Cop1.Truncl inst)
    {
      builder.append_printf ("TRUNC.L.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_ceilw (Cop1.Ceilw inst)
    {
      builder.append_printf ("CEIL.W.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_floorw (Cop1.Floorw inst)
    {
      builder.append_printf ("FLOOR.W.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_roundl (Cop1.Roundl inst)
    {
      builder.append_printf ("ROUND.L.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_roundw (Cop1.Roundw inst)
    {
      builder.append_printf ("ROUND.W.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_rsqrt (Cop1.Rsqrt inst)
    {
      builder.append_printf ("RQSRT.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_cvtd (Cop1.Cvtd inst)
    {
      builder.append_printf ("CVT.D.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_cvtw (Cop1.Cvtw inst)
    {
      builder.append_printf ("CVT.W.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_cvts (Cop1.Cvts inst)
    {
      if (inst.fmt == 0x16)
            builder.append_printf ("CVT.S.PU\t%s, %s", inst.fd.to_string(), inst.fs.to_string());
          else
            builder.append_printf ("CVT.S.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_mov (Cop1.Mov inst)
    {
      builder.append_printf ("MOV.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_neg (Cop1.Neg inst)
    {
      builder.append_printf ("NEG.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_mul (Cop1.Mul inst)
    {
      builder.append_printf ("MUL.%s\t%s, %s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_div (Cop1.Div inst)
    {
      builder.append_printf ("DIV.%s\t%s, %s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_add (Cop1.Add inst)
    {
      builder.append_printf ("ADD.%s\t%s, %s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_sub (Cop1.Sub inst)
    {
      builder.append_printf ("SUB.%s\t%s, %s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_pll (Cop1.Pll inst)
    {
      builder.append_printf ("PLL.PS\t%s, %s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_plu (Cop1.Plu inst)
    {
      builder.append_printf ("PLU.PS\t%s, %s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_pul (Cop1.Pul inst)
    {
      builder.append_printf ("PUL.PS\t%s, %s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_puu (Cop1.Puu inst)
    {
      builder.append_printf ("PUU.PS\t%s, %s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_ccond (Cop1.Ccond inst)
    {
      if (inst.cc == 0)
            builder.append_printf ("C.%s.%s\t%s, %s\t(cc = 0 implied)", inst.cond.to_string (), inst.fmt.to_string(), inst.fs.to_string(), inst.ft.to_string());
          else
            builder.append_printf ("C.%s.%s\t%d, %s, %s", inst.cond.to_string (), inst.fmt.to_string(), inst.cc, inst.fs.to_string(), inst.ft.to_string());  
    }

    public override void visit_cop1_bc (Cop1.Bc inst)
    {
      if (inst.branch == Cop1.Bc.Branch.FALSE)
        builder.append_printf ("BC1F\t0x%x, 0x%x", inst.cc, inst.offset);
      else if (inst.branch == Cop1.Bc.Branch.FALSE_LIKELY)
        builder.append_printf ("BC1FL\t0x%x, 0x%x", inst.cc, inst.offset);
      else if (inst.branch == Cop1.Bc.Branch.TRUE)
        builder.append_printf ("BC1T\t0x%x, 0x%x", inst.cc, inst.offset);
      else if (inst.branch == Cop1.Bc.Branch.TRUE_LIKELY)
        builder.append_printf ("BC1TL\t0x%x, 0x%x", inst.cc, inst.offset);
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
      builder.append_printf ("MFC1\t%s, %s", inst.rt.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_mfh (Cop1.Mfh inst)
    {
      builder.append_printf ("MFHC1\t%s, %s", inst.rt.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_mth (Cop1.Mth inst)
    {
      builder.append_printf ("MTHC1\t%s, %s", inst.rt.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_cf (Cop1.Cf inst)
    {
      builder.append_printf ("CFC1\t%s, %s", inst.rt.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_ct (Cop1.Ct inst)
    {
      builder.append_printf ("CTC1\t%s, %s", inst.rt.to_string(), inst.fs.to_string());
    }

    public override void visit_cop2_cf (Cop2.Cf inst)
    {
      builder.append_printf ("CFC2\t%s, %s", inst.rt.to_string(), inst.rd.to_string());
    }

    public override void visit_cop2_ct (Cop2.Ct inst)
    {
      builder.append_printf ("CTC2\t%s, %s", inst.rt.to_string(), inst.rd.to_string());
    }

    public override void visit_cop2_mf (Cop2.Mf inst)
    {
      builder.append_printf ("MFC2\t%s, 0x%x", inst.rt.to_string(), inst.impl);
    }

    public override void visit_cop2_mt (Cop2.Mt inst)
    {
      builder.append_printf ("MTC2\t%s, 0x%x", inst.rt.to_string(), inst.impl);
    }

    public override void visit_cop2_mfh (Cop2.Mfh inst)
    {
      builder.append_printf ("MFHC2\t%s, 0x%x", inst.rt.to_string(), inst.impl);
    }

    public override void visit_cop2_mth (Cop2.Mth inst)
    {
      builder.append_printf ("MTHC2\t%s, 0x%x", inst.rt.to_string(), inst.impl);
    }

    public override void visit_cop1_mt (Cop1.Mt inst)
    {
      builder.append_printf ("MTC1\t%s, %s", inst.rt.to_string(), inst.fs.to_string());
    }

    public override void visit_movci (Movci inst)
    {
      if (inst.test_true)
        builder.append_printf ("MOVT %s, %s, %d", inst.rd.to_string(), inst.rs.to_string(), inst.cc);
      else
        builder.append_printf ("MOVF %s, %s, %d", inst.rd.to_string(), inst.rs.to_string(), inst.cc);
    }

    public override void visit_cop1_movcf (Cop1.Movcf inst)
    {
      if (inst.test_true)
        builder.append_printf ("MOVT.%s\t%s, %s, %d", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string(), inst.cc);
      else
        builder.append_printf ("MOVF.%s\t%s, %s, %d", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string(), inst.cc);
    }

    public override void visit_cop1x_madd (Cop1x.Madd inst)
    {
      builder.append_printf ("MADD.%s\t%s, %s, %s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fr.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1x_nmadd (Cop1x.Nmadd inst)
    {
      builder.append_printf ("NMADD.%s\t%s, %s, %s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fr.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1x_nmsub (Cop1x.Nmsub inst)
    {
      builder.append_printf ("NMSUB.%s\t%s, %s, %s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fr.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1x_msub (Cop1x.Msub inst)
    {
      builder.append_printf ("MSUB.%s\t%s, %s, %s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fr.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_add (Add inst)
    {
      builder.append_printf ("ADD\t%s, %s, %s", inst.rs.to_string(), inst.rt.to_string(), inst.rd.to_string());
    }

    public override void visit_madd (Madd inst)
    {
      builder.append_printf ("MADD\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_msub (Msub inst)
    {
      builder.append_printf ("MSUB\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_msubu (Msubu inst)
    {
      builder.append_printf ("MSUBU\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_maddu (Maddu inst)
    {
      builder.append_printf ("MADDU\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_lui (Lui inst)
    {
      builder.append_printf ("LUI\t%s, %d", inst.rt.to_string (), inst.immediate);
    }

    public override void visit_addiu (Addiu inst)
    {
      builder.append_printf ("ADDIU\t%s, %s, %u", inst.rt.to_string (), inst.rs.to_string (), inst.immediate);
      if (inst.reference != null)
        builder.append_printf ("\t# %s", inst.reference.to_string ());
    }

    public override void visit_addi (Addi inst)
    {
      builder.append_printf ("ADDI\t%s, %s, %d", inst.rs.to_string(), inst.rt.to_string(), inst.immediate);
    }

    public override void visit_addu (Addu inst)
    {
      builder.append_printf ("ADDU\t%s, %s, %s", inst.rd.to_string (), inst.rs.to_string (), inst.rt.to_string ());
    }

    public override void visit_rdhwr (Rdhwr inst)
    {
      builder.append_printf ("RDHWR\t%s, %s", inst.rt.to_string(), inst.rd.to_string());
    }

    public override void visit_sw (Sw inst)
    {
      builder.append_printf ("SW\t%s, %d(%s)", inst.rt.to_string (), inst.offset, inst.@base.to_string ());
    }

    public override void visit_cache (Cache inst)
    {
      builder.append_printf ("CACHE\t0x%x, %d(%s)", inst.op, inst.offset, inst.@base.to_string());
    }

    public override void visit_pref (Pref inst)
    {
      builder.append_printf ("PREF\t0x%x, %d(%s)", inst.hint, inst.offset, inst.@base.to_string());
    }

    public override void visit_cop1x_prefx (Cop1x.Prefx inst)
    {
      builder.append_printf ("PREFX\t0x%x, %d(%s)", inst.hint, inst.index, inst.@base.to_string());
    }

    public override void visit_sync (Sync inst)
    {
      builder.append_printf ("SYNC");
    }

    public override void visit_swl (Swl inst)
    {
      builder.append_printf ("SWL\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_swr (Swr inst)
    {
      builder.append_printf ("SWR\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_regimm_bgezal (Regimm.Bgezal inst)
    {
      if (inst.rs == 0)
        builder.append_printf ("BAL\t%s\t# if GPR[r0] ≥ 0 then procedure_call", inst.reference.to_string());
      else
        builder.append_printf ("BGEZAL\t%s, %s# if GPR[%s] ≥ 0 then procedure_call", inst.rs.to_string(),
                               inst.reference.to_string(), inst.rs.to_string());
    }

    public override void visit_regimm_bgezall (Regimm.Bgezall inst)
    {
      builder.append_printf ("BGEZALL\t%s, %s\t# if GPR[%s] ≥ 0 then procedure_call", inst.rs.to_string(),
                             inst.reference.to_string(), inst.rs.to_string());
    }

    public override void visit_regimm_synci (Regimm.Synci inst)
    {
      builder.append_printf ("SYNCI\t%d(%s)", inst.offset, inst.@base.to_string());
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
      builder.append_printf ("MFC0 %s, %s, %d", inst.rt.to_string(), inst.rd.to_string(), inst.sel);
    }

    public override void visit_cop0_mt (Cop0.Mt inst)
    {
      builder.append_printf ("MTC0 %s, %s, %d", inst.rt.to_string(), inst.rd.to_string(), inst.sel);
    }

    public override void visit_cop0_rdpgpr (Cop0.Rdpgpr inst)
    {
      builder.append_printf ("RDPGPR %s, %s", inst.rd.to_string(), inst.rt.to_string());
    }

    public override void visit_cop0_wrpgpr (Cop0.Wrpgpr inst)
    {
      builder.append_printf ("WRPGPR %s, %s", inst.rd.to_string(), inst.rt.to_string());
    }

    public override void visit_cop1_recip (Cop1.Recip inst)
    {
      builder.append_printf ("RECIP.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_lw (Lw inst)
    {
      if (inst.reference != null)
        {
          if (inst.reference is BinaryInstruction || inst.reference is BinaryObject)
            builder.append_printf ("LW\t%s, %s", inst.rt.to_string (), inst.reference.to_string ());
          else
            builder.append_printf ("LW\t%s, %d(%s)\t# %s", inst.rt.to_string (), inst.offset, inst.@base.to_string (), inst.reference.to_string ().to_string ());
        }
      else
        builder.append_printf ("LW\t%s, %d(%s)", inst.rt.to_string (), inst.offset, inst.@base.to_string ());
    }

    public override void visit_lwl (Lwl inst)
    {
      builder.append_printf ("LWL\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_lwr (Lwr inst)
    {
      builder.append_printf ("LWR\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_jalr (Jalr inst)
    {
      if (inst.has_hint ())
        builder.append_printf ("JALR.HB\t%s, %s", inst.rd.to_string (), inst.rs.to_string ());
      else
        builder.append_printf ("JALR\t%s, %s", inst.rd.to_string (), inst.rs.to_string ());
    }

    public override void visit_jr (Jr inst)
    {
      if (inst.has_hint ())
        builder.append_printf ("JR.HB\t%s", inst.rs.to_string());
      else
        builder.append_printf ("JR\t%s", inst.rs.to_string());
    }

    public override void visit_regimm_bltzal (Regimm.Bltzal inst)
    {
      builder.append_printf ("BLTZAL\t%s, %s\t# if GPR[%s] < 0 then procedure_call", inst.rs.to_string(),
                             inst.reference.to_string(), inst.rs.to_string());
    }

    public override void visit_regimm_bltzall (Regimm.Bltzall inst)
    {
      builder.append_printf ("BLTZALL\t%s, %s\t# if GPR[%s] < 0 then procedure_call_likely", inst.rs.to_string(),
                             inst.reference.to_string(), inst.rs.to_string());
    }

    public override void visit_sll (Sll inst)
    {
      builder.append_printf ("SLL\t%s, %s, 0x%x", inst.rd.to_string(), inst.rt.to_string(), inst.sa);
    }

    public override void visit_beq (Beq inst)
    {
      if (inst.is_unconditional ())
        builder.append_printf ("B\t%s", inst.reference.to_string());
      else
        builder.append_printf ("BEQ\t%s, %s, %s\t# if GPR[%s] = GPR[%s] then branch", inst.rs.to_string(),
                               inst.rt.to_string(), inst.reference.to_string (), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_beql (Beql inst)
    {
      builder.append_printf ("BEQ\t%s, %s, %s\t# if GPR[%s] = GPR[%s] then branch_likely", inst.rs.to_string(),
                             inst.rt.to_string(), inst.reference.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_bne (Bne inst)
    {
      builder.append_printf ("BNE\t%s, %s, %s\t# if GPR[%s] ≠ GPR[%s] then branch", inst.rs.to_string(),
                             inst.rt.to_string(), inst.reference.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_bnel (Bnel inst)
    {
      builder.append_printf ("BNEL\t%s, %s, %s\t# if GPR[%s] ≠ GPR[%s] then branch_likely", inst.rs.to_string(),
                             inst.rt.to_string(), inst.reference.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_lbu (Lbu inst)
    {
      builder.append_printf ("LBU\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_sb (Sb inst)
    {
      builder.append_printf ("SB\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_seb (Seb inst)
    {
      builder.append_printf ("SEB\t%s, %s", inst.rd.to_string(), inst.rt.to_string());
    }

    public override void visit_wsbh (Wsbh inst)
    {
      builder.append_printf ("WSBH\t%s, %s", inst.rd.to_string(), inst.rt.to_string());
    }

    public override void visit_seh (Seh inst)
    {
      builder.append_printf ("SEH\t%s, %s", inst.rd.to_string(), inst.rt.to_string());
    }

    public override void visit_sc (Sc inst)
    {
      builder.append_printf ("SC\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_sltiu (Sltiu inst)
    {
      builder.append_printf ("SLTIU\t%s, %s, %d", inst.rs.to_string(), inst.rt.to_string(), inst.immediate);
    }

    public override void visit_slti (Slti inst)
    {
      builder.append_printf ("SLTI\t%s, %s, %d", inst.rs.to_string(), inst.rt.to_string(), inst.immediate);
    }

    public override void visit_ori (Ori inst)
    {
      builder.append_printf ("ORI\t%s, %s, %d", inst.rs.to_string(), inst.rt.to_string(), inst.immediate);
    }

    public override void visit_sltu (Sltu inst)
    {
      builder.append_printf ("SLTU\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_sllv (Sllv inst)
    {
      builder.append_printf ("SLLV\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_and (And inst)
    {
      builder.append_printf ("AND\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_or (Or inst)
    {
      builder.append_printf ("OR\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_lhu (Lhu inst)
    {
      builder.append_printf ("LHU\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_subu (Subu inst)
    {
      builder.append_printf ("SUBU\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_sh (Sh inst)
    {
      builder.append_printf ("SH\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_lh (Lh inst)
    {
      builder.append_printf ("LH\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_srl (Srl inst)
    {
      if (inst.is_rotr ())
        builder.append_printf ("ROTR\t%s, %s, 0x%x", inst.rd.to_string(), inst.rt.to_string(), inst.sa);
      else
        builder.append_printf ("SRL\t%s, %s, 0x%x", inst.rd.to_string(), inst.rt.to_string(), inst.sa);
    }

    public override void visit_andi (Andi inst)
    {
      builder.append_printf ("ANDI\t%s, %s, %d", inst.rs.to_string(), inst.rt.to_string(), inst.immediate);
    }

    public override void visit_regimm_bgez (Regimm.Bgez inst)
    {
      builder.append_printf ("BGEZ\t%s, %s\t# if GPR[%s] ≥ 0 then branch", inst.rs.to_string(), inst.reference.to_string(),
                             inst.rs.to_string());
    }

    public override void visit_sra (Sra inst)
    {
      builder.append_printf ("SRA\t%s, %s, 0x%x", inst.rd.to_string(), inst.rt.to_string(), inst.sa);
    }

    public override void visit_lb (Lb inst)
    {
      builder.append_printf ("LB\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_ll (Ll inst)
    {
      builder.append_printf ("LL\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_regimm_bltz (Regimm.Bltz inst)
    {
      builder.append_printf ("BLTZ\t%s, %s\t# if GPR[%s] < 0 then branch", inst.rs.to_string(), inst.reference.to_string(),
                             inst.rs.to_string());
    }

    public override void visit_regimm_bltzl (Regimm.Bltzl inst)
    {
      builder.append_printf ("BLTZL\t%s, %s\t# if GPR[%s] < 0 then branch_likely", inst.rs.to_string(),
                             inst.reference.to_string(), inst.rs.to_string());
    }

    public override void visit_regimm_bgezl (Regimm.Bgezl inst)
    {
      builder.append_printf ("BGEZL\t%s, %s\t# if GPR[%s] ≥ 0 then branch_likely", inst.rs.to_string(),
                             inst.reference.to_string(), inst.rs.to_string());
    }

    public override void visit_slt (Slt inst)
    {
      builder.append_printf ("SLT\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_mult (Mult inst)
    {
      builder.append_printf ("MULT\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_multu (Multu inst)
    {
      builder.append_printf ("MULTU\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_mfhi (Mfhi inst)
    {
      builder.append_printf ("MFHI\t%s", inst.rd.to_string());
    }

    public override void visit_mthi (Mthi inst)
    {
      builder.append_printf ("MTHI\t%s", inst.rs.to_string());
    }

    public override void visit_blez (Blez inst)
    {
      builder.append_printf ("BLEZ\t%s, %s\t# if GPR[%s] ≤ 0 then branch", inst.rs.to_string(), inst.reference.to_string(),
                             inst.rs.to_string());
    }

    public override void visit_bgtz (Bgtz inst)
    {
      builder.append_printf ("BGTZ\t%s, %s\t# if GPR[%s] > 0 then branch", inst.rs.to_string(), inst.reference.to_string(),
                             inst.rs.to_string());
    }

    public override void visit_bgtzl (Bgtzl inst)
    {
      builder.append_printf ("BGTZL\t%s, %s\t# if GPR[%s] > 0 then branch_likely", inst.rs.to_string(),
                             inst.reference.to_string(), inst.rs.to_string());
    }

    public override void visit_xori (Xori inst)
    {
      builder.append_printf ("XORI\t%s, %s, %d", inst.rt.to_string(), inst.rs.to_string(), inst.immediate);
    }

    public override void visit_clo (Clo inst)
    {
      builder.append_printf ("CLO\t%s, %s", inst.rd.to_string(), inst.rs.to_string());
    }

    public override void visit_clz (Clz inst)
    {
      builder.append_printf ("CLZ\t%s, %s", inst.rd.to_string(), inst.rs.to_string());
    }

    public override void visit_mul (Mul inst)
    {
      builder.append_printf ("MUL\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_nor (Nor inst)
    {
      builder.append_printf ("NOR\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_xor (Xor inst)
    {
      builder.append_printf ("XOR\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_srlv (Srlv inst)
    {
      if (inst.is_rotr ())
        builder.append_printf ("ROTRV\t%s, %s, %s", inst.rd.to_string(), inst.rt.to_string(), inst.rs.to_string());
      else
        builder.append_printf ("SRLV\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_srav (Srav inst)
    {
      builder.append_printf ("SRAV\t%s, %s, %s", inst.rd.to_string(), inst.rt.to_string(), inst.rs.to_string());
    }

    public override void visit_divu (Divu inst)
    {
      builder.append_printf ("DIVU\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_break (Break inst)
    {
      builder.append_printf ("BREAK");
    }

    public override void visit_mflo (Mflo inst)
    {
      builder.append_printf ("MFLO\t%s", inst.rd.to_string());
    }

    public override void visit_mtlo (Mtlo inst)
    {
      builder.append_printf ("MTLO\t%s", inst.rs.to_string());
    }

    public override void visit_movz (Movz inst)
    {
      builder.append_printf ("MOVZ\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_movn (Movn inst)
    {
      builder.append_printf ("MOVN\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_div (Div inst)
    {
      builder.append_printf ("DIV\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_blezl (Blezl inst)
    {
      builder.append_printf ("BLEZL\t%s, %s\t# if GPR[%s] ≤ 0 then branch_likely", inst.rs.to_string(),
                             inst.reference.to_string(), inst.rs.to_string());
    }

    public override void visit_sdc1 (Sdc1 inst)
    {
      builder.append_printf ("SDC1\t%s, %d(%s)", inst.ft.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_sdc2 (Sdc2 inst)
    {
      builder.append_printf ("SDC2\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_cop1x_sdxc1 (Cop1x.Sdxc1 inst)
    {
      builder.append_printf ("SDXC1\t%s, %d(%s)", inst.fs.to_string(), inst.index, inst.@base.to_string());
    }

    public override void visit_cop1x_suxc1 (Cop1x.Suxc1 inst)
    {
      builder.append_printf ("SUXC1\t%s, %d(%s)", inst.fs.to_string(), inst.index, inst.@base.to_string());
    }

    public override void visit_cop1x_swxc1 (Cop1x.Swxc1 inst)
    {
      builder.append_printf ("SWXC1\t%s, %d(%s)", inst.fs.to_string(), inst.index, inst.@base.to_string());
    }

    public override void visit_ldc1 (Ldc1 inst)
    {
      builder.append_printf ("LDC1\t%s, %d(%s)", inst.ft.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_ldc2 (Ldc2 inst)
    {
      builder.append_printf ("LDC2\t%s, %d(%s)", inst.ft.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_lwc1 (Lwc1 inst)
    {
      builder.append_printf ("LWC1\t%s, %d(%s)", inst.ft.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_lwc2 (Lwc2 inst)
    {
      builder.append_printf ("LWC2\t%s, %d(%s)", inst.ft.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_swc1 (Swc1 inst)
    {
      builder.append_printf ("SWC1\t%s, %d(%s)", inst.ft.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_swc2 (Swc2 inst)
    {
      builder.append_printf ("SWC2\t%s, %d(%s)", inst.ft.to_string(), inst.offset, inst.@base.to_string());
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
      builder.append_printf ("TEQ\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_regimm_teqi (Regimm.Teqi inst)
    {
      builder.append_printf ("TEQI\t%s, %d", inst.rs.to_string(), inst.immediate);
    }

    public override void visit_tge (Tge inst)
    {
      builder.append_printf ("TGE\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_regimm_tgei (Regimm.Tgei inst)
    {
      builder.append_printf ("TGEI\t%s, %u", inst.rs.to_string(), inst.immediate);
    }

    public override void visit_regimm_tgeiu (Regimm.Tgeiu inst)
    {
      builder.append_printf ("TGEIU\t%s, %u", inst.rs.to_string(), inst.immediate);
    }

    public override void visit_tgeu (Tgeu inst)
    {
      builder.append_printf ("TGEU\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
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
      builder.append_printf ("TLT\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_regimm_tlti (Regimm.Tlti inst)
    {
      builder.append_printf ("TLTI\t%s, %u", inst.rs.to_string(), inst.immediate);
    }

    public override void visit_regimm_tltiu (Regimm.Tltiu inst)
    {
      builder.append_printf ("TLTIU\t%s, %u", inst.rs.to_string(), inst.immediate);
    }
   
    public override void visit_tltu (Tltu inst)
    {
      builder.append_printf ("TLTU\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_tne (Tne inst)
    {
      builder.append_printf ("TNE\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_regimm_tnei (Regimm.Tnei inst)
    {
      builder.append_printf ("TNEI\t%s, %u", inst.rs.to_string(), inst.immediate);
    }
  }
}
