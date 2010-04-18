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
      builder.append_printf ("abs.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_movz (Cop1.Movz inst)
    {
      builder.append_printf ("movz.%s\t%s, %s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string(), inst.rt.to_string());
    }

    public override void visit_cop1_sqrt (Cop1.Sqrt inst)
    {
      builder.append_printf ("sqrt.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_truncw (Cop1.Truncw inst)
    {
      builder.append_printf ("trunc.w.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_truncl (Cop1.Truncl inst)
    {
      builder.append_printf ("trunc.l.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_ceilw (Cop1.Ceilw inst)
    {
      builder.append_printf ("ceil.w.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_floorw (Cop1.Floorw inst)
    {
      builder.append_printf ("floor.w.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_roundl (Cop1.Roundl inst)
    {
      builder.append_printf ("round.l.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_roundw (Cop1.Roundw inst)
    {
      builder.append_printf ("round.w.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_rsqrt (Cop1.Rsqrt inst)
    {
      builder.append_printf ("rqsrt.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_cvtd (Cop1.Cvtd inst)
    {
      builder.append_printf ("cvt.d.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_cvtw (Cop1.Cvtw inst)
    {
      builder.append_printf ("cvt.w.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_cvts (Cop1.Cvts inst)
    {
      if (inst.fmt == 0x16)
            builder.append_printf ("cvt.s.pu\t%s, %s", inst.fd.to_string(), inst.fs.to_string());
          else
            builder.append_printf ("cvt.s.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_mov (Cop1.Mov inst)
    {
      builder.append_printf ("mov.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_neg (Cop1.Neg inst)
    {
      builder.append_printf ("neg.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_mul (Cop1.Mul inst)
    {
      builder.append_printf ("mul.%s\t%s, %s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_div (Cop1.Div inst)
    {
      builder.append_printf ("div.%s\t%s, %s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_add (Cop1.Add inst)
    {
      builder.append_printf ("add.%s\t%s, %s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_sub (Cop1.Sub inst)
    {
      builder.append_printf ("sub.%s\t%s, %s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_pll (Cop1.Pll inst)
    {
      builder.append_printf ("pll.ps\t%s, %s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_plu (Cop1.Plu inst)
    {
      builder.append_printf ("plu.ps\t%s, %s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_pul (Cop1.Pul inst)
    {
      builder.append_printf ("pul.ps\t%s, %s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_puu (Cop1.Puu inst)
    {
      builder.append_printf ("puu.ps\t%s, %s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_ccond (Cop1.Ccond inst)
    {
      if (inst.cc == 0)
            builder.append_printf ("c.%s.%s\t%s, %s\t(cc = 0 implied)", inst.cond.to_string (), inst.fmt.to_string(), inst.fs.to_string(), inst.ft.to_string());
          else
            builder.append_printf ("c.%s.%s\t%d, %s, %s", inst.cond.to_string (), inst.fmt.to_string(), inst.cc, inst.fs.to_string(), inst.ft.to_string());  
    }

    public override void visit_cop1_bc (Cop1.Bc inst)
    {
      builder.append_printf ("%s\t0x%x, 0x%x", inst.branch.to_string(), inst.cc, inst.offset);
    }

    public override void visit_cop2_bc (Cop2.Bc inst)
    {
      builder.append_printf ("%s\t0x%x, 0x%x", inst.branch.to_string(), inst.cc, inst.offset);
    }

    public override void visit_cop1_mf (Cop1.Mf inst)
    {
      builder.append_printf ("mfc1\t%s, %s", inst.rt.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_mfh (Cop1.Mfh inst)
    {
      builder.append_printf ("mfhc1\t%s, %s", inst.rt.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_mth (Cop1.Mth inst)
    {
      builder.append_printf ("mthc1\t%s, %s", inst.rt.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_cf (Cop1.Cf inst)
    {
      builder.append_printf ("cfc1\t%s, %s", inst.rt.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_ct (Cop1.Ct inst)
    {
      builder.append_printf ("ctc1\t%s, %s", inst.rt.to_string(), inst.fs.to_string());
    }

    public override void visit_cop2_cf (Cop2.Cf inst)
    {
      builder.append_printf ("cfc2\t%s, %s", inst.rt.to_string(), inst.rd.to_string());
    }

    public override void visit_cop2_ct (Cop2.Ct inst)
    {
      builder.append_printf ("ctc2\t%s, %s", inst.rt.to_string(), inst.rd.to_string());
    }

    public override void visit_cop2_mf (Cop2.Mf inst)
    {
      builder.append_printf ("mfc2\t%s, 0x%x", inst.rt.to_string(), inst.impl);
    }

    public override void visit_cop2_mt (Cop2.Mt inst)
    {
      builder.append_printf ("mtc2\t%s, 0x%x", inst.rt.to_string(), inst.impl);
    }

    public override void visit_cop2_mfh (Cop2.Mfh inst)
    {
      builder.append_printf ("mfhc2\t%s, 0x%x", inst.rt.to_string(), inst.impl);
    }

    public override void visit_cop2_mth (Cop2.Mth inst)
    {
      builder.append_printf ("mthc2\t%s, 0x%x", inst.rt.to_string(), inst.impl);
    }

    public override void visit_cop1_mt (Cop1.Mt inst)
    {
      builder.append_printf ("mtc1\t%s, %s", inst.rt.to_string(), inst.fs.to_string());
    }

    public override void visit_movci (Movci inst)
    {
      if (inst.test_true)
        builder.append_printf ("movt %s, %s, %d", inst.rd.to_string(), inst.rs.to_string(), inst.cc);
      else
        builder.append_printf ("movf %s, %s, %d", inst.rd.to_string(), inst.rs.to_string(), inst.cc);
    }

    public override void visit_cop1_movcf (Cop1.Movcf inst)
    {
      if (inst.test_true)
        builder.append_printf ("movt.%s\t%s, %s, %d", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string(), inst.cc);
      else
        builder.append_printf ("movf.%s\t%s, %s, %d", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string(), inst.cc);
    }

    public override void visit_cop1x_madd (Cop1x.Madd inst)
    {
      builder.append_printf ("madd.%s\t%s, %s, %s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fr.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1x_nmadd (Cop1x.Nmadd inst)
    {
      builder.append_printf ("nmadd.%s\t%s, %s, %s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fr.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1x_nmsub (Cop1x.Nmsub inst)
    {
      builder.append_printf ("nmsub.%s\t%s, %s, %s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fr.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1x_msub (Cop1x.Msub inst)
    {
      builder.append_printf ("msub.%s\t%s, %s, %s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fr.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_add (Add inst)
    {
      builder.append_printf ("add\t%s, %s, %s", inst.rs.to_string(), inst.rt.to_string(), inst.rd.to_string());
    }

    public override void visit_madd (Madd inst)
    {
      builder.append_printf ("madd\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_msub (Msub inst)
    {
      builder.append_printf ("msub\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_msubu (Msubu inst)
    {
      builder.append_printf ("msubu\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_maddu (Maddu inst)
    {
      builder.append_printf ("maddu\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_lui (Lui inst)
    {
      builder.append_printf ("lui\t%s, %d", inst.rt.to_string (), inst.immediate);
    }

    public override void visit_addiu (Addiu inst)
    {
      builder.append_printf ("addiu\t%s, %s, %u", inst.rt.to_string (), inst.rs.to_string (), inst.immediate);
      if (inst.reference != null)
        builder.append_printf ("\t# %s", inst.reference.to_string ());
    }

    public override void visit_addi (Addi inst)
    {
      builder.append_printf ("addi\t%s, %s, %d", inst.rs.to_string(), inst.rt.to_string(), inst.immediate);
    }

    public override void visit_addu (Addu inst)
    {
      builder.append_printf ("addu\t%s, %s, %s", inst.rd.to_string (), inst.rs.to_string (), inst.rt.to_string ());
    }

    public override void visit_rdhwr (Rdhwr inst)
    {
      builder.append_printf ("rdhwr\t%s, %s", inst.rt.to_string(), inst.rd.to_string());
    }

    public override void visit_sw (Sw inst)
    {
      builder.append_printf ("sw\t%s, %d(%s)", inst.rt.to_string (), inst.offset, inst.@base.to_string ());
    }

    public override void visit_cache (Cache inst)
    {
      builder.append_printf ("cache\t0x%x, %d(%s)", inst.op, inst.offset, inst.@base.to_string());
    }

    public override void visit_pref (Pref inst)
    {
      builder.append_printf ("pref\t0x%x, %d(%s)", inst.hint, inst.offset, inst.@base.to_string());
    }

    public override void visit_cop1x_prefx (Cop1x.Prefx inst)
    {
      builder.append_printf ("prefx\t0x%x, %d(%s)", inst.hint, inst.index, inst.@base.to_string());
    }

    public override void visit_sync (Sync inst)
    {
      builder.append_printf ("sync");
    }

    public override void visit_swl (Swl inst)
    {
      builder.append_printf ("swl\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_swr (Swr inst)
    {
      builder.append_printf ("swr\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_regimm_bgezal (Regimm.Bgezal inst)
    {
      if (inst.rs == 0)
        builder.append_printf ("bal\t%s\t# if GPR[r0] ≥ 0 then procedure_call", inst.reference.to_string());
      else
        builder.append_printf ("bgezal\t%s, %s# if GPR[%s] ≥ 0 then procedure_call", inst.rs.to_string(),
                               inst.reference.to_string(), inst.rs.to_string());
    }

    public override void visit_regimm_bgezall (Regimm.Bgezall inst)
    {
      builder.append_printf ("bgezall\t%s, %s\t# if GPR[%s] ≥ 0 then procedure_call", inst.rs.to_string(),
                             inst.reference.to_string(), inst.rs.to_string());
    }

    public override void visit_regimm_synci (Regimm.Synci inst)
    {
      builder.append_printf ("synci\t%d(%s)", inst.offset, inst.@base.to_string());
    }

    public override void visit_nop (Nop inst)
    {
      builder.append ("nop");
    }

    public override void visit_ssnop (Ssnop inst)
    {
      builder.append ("ssnop");
    }

    public override void visit_cop0_deret (Cop0.Deret inst)
    {
      builder.append ("deret");
    }

    public override void visit_cop0_eret (Cop0.Eret inst)
    {
      builder.append ("eret");
    }

    public override void visit_cop0_mf (Cop0.Mf inst)
    {
      builder.append_printf ("mfc0 %s, %s, %d", inst.rt.to_string(), inst.rd.to_string(), inst.sel);
    }

    public override void visit_cop0_mt (Cop0.Mt inst)
    {
      builder.append_printf ("mtc0 %s, %s, %d", inst.rt.to_string(), inst.rd.to_string(), inst.sel);
    }

    public override void visit_cop0_rdpgpr (Cop0.Rdpgpr inst)
    {
      builder.append_printf ("rdpgpr %s, %s", inst.rd.to_string(), inst.rt.to_string());
    }

    public override void visit_cop0_wrpgpr (Cop0.Wrpgpr inst)
    {
      builder.append_printf ("wrpgpr %s, %s", inst.rd.to_string(), inst.rt.to_string());
    }

    public override void visit_cop1_recip (Cop1.Recip inst)
    {
      builder.append_printf ("recip.%s\t%s, %s", inst.fmt.to_string(), inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_lw (Lw inst)
    {
      if (inst.reference != null)
        {
          if (inst.reference is BinaryInstruction || inst.reference is BinaryObject)
            builder.append_printf ("lw\t%s, %s", inst.rt.to_string (), inst.reference.to_string ());
          else
            builder.append_printf ("lw\t%s, %d(%s)\t# %s", inst.rt.to_string (), inst.offset, inst.@base.to_string (), inst.reference.to_string ().to_string ());
        }
      else
        builder.append_printf ("lw\t%s, %d(%s)", inst.rt.to_string (), inst.offset, inst.@base.to_string ());
    }

    public override void visit_lwl (Lwl inst)
    {
      builder.append_printf ("lwl\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_lwr (Lwr inst)
    {
      builder.append_printf ("lwr\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_jalr (Jalr inst)
    {
      if (inst.has_hint ())
        builder.append_printf ("jalr.hb\t%s, %s", inst.rd.to_string (), inst.rs.to_string ());
      else
        builder.append_printf ("jalr\t%s, %s", inst.rd.to_string (), inst.rs.to_string ());
    }

    public override void visit_jr (Jr inst)
    {
      if (inst.has_hint ())
        builder.append_printf ("jr.hb\t%s", inst.rs.to_string());
      else
        builder.append_printf ("jr\t%s", inst.rs.to_string());
    }

    public override void visit_regimm_bltzal (Regimm.Bltzal inst)
    {
      builder.append_printf ("bltzal\t%s, %s\t# if GPR[%s] < 0 then procedure_call", inst.rs.to_string(),
                             inst.reference.to_string(), inst.rs.to_string());
    }

    public override void visit_regimm_bltzall (Regimm.Bltzall inst)
    {
      builder.append_printf ("bltzall\t%s, %s\t# if GPR[%s] < 0 then procedure_call_likely", inst.rs.to_string(),
                             inst.reference.to_string(), inst.rs.to_string());
    }

    public override void visit_sll (Sll inst)
    {
      builder.append_printf ("sll\t%s, %s, 0x%x", inst.rd.to_string(), inst.rt.to_string(), inst.sa);
    }

    public override void visit_beq (Beq inst)
    {
      if (inst.is_unconditional ())
        builder.append_printf ("b\t%s", inst.reference.to_string());
      else
        builder.append_printf ("beq\t%s, %s, %s\t# if GPR[%s] = GPR[%s] then branch", inst.rs.to_string(),
                               inst.rt.to_string(), inst.reference.to_string (), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_beql (Beql inst)
    {
      builder.append_printf ("beq\t%s, %s, %s\t#if GPR[%s] = GPR[%s] then branch_likely", inst.rs.to_string(),
                             inst.rt.to_string(), inst.reference.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_bne (Bne inst)
    {
      builder.append_printf ("bne\t%s, %s, %s\t# if GPR[%s] ≠ GPR[%s] then branch", inst.rs.to_string(),
                             inst.rt.to_string(), inst.reference.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_bnel (Bnel inst)
    {
      builder.append_printf ("bnel\t%s, %s, %s\t# if GPR[%s] ≠ GPR[%s] then branch_likely", inst.rs.to_string(),
                             inst.rt.to_string(), inst.reference.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_lbu (Lbu inst)
    {
      builder.append_printf ("lbu\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_sb (Sb inst)
    {
      builder.append_printf ("sb\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_seb (Seb inst)
    {
      builder.append_printf ("seb\t%s, %s", inst.rd.to_string(), inst.rt.to_string());
    }

    public override void visit_wsbh (Wsbh inst)
    {
      builder.append_printf ("wsbh\t%s, %s", inst.rd.to_string(), inst.rt.to_string());
    }

    public override void visit_seh (Seh inst)
    {
      builder.append_printf ("seh\t%s, %s", inst.rd.to_string(), inst.rt.to_string());
    }

    public override void visit_sc (Sc inst)
    {
      builder.append_printf ("sc\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_sltiu (Sltiu inst)
    {
      builder.append_printf ("sltiu\t%s, %s, %d", inst.rs.to_string(), inst.rt.to_string(), inst.immediate);
    }

    public override void visit_slti (Slti inst)
    {
      builder.append_printf ("slti\t%s, %s, %d", inst.rs.to_string(), inst.rt.to_string(), inst.immediate);
    }

    public override void visit_ori (Ori inst)
    {
      builder.append_printf ("ori\t%s, %s, %d", inst.rs.to_string(), inst.rt.to_string(), inst.immediate);
    }

    public override void visit_sltu (Sltu inst)
    {
      builder.append_printf ("sltu\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_sllv (Sllv inst)
    {
      builder.append_printf ("sllv\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_and (And inst)
    {
      builder.append_printf ("and\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_or (Or inst)
    {
      builder.append_printf ("or\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_lhu (Lhu inst)
    {
      builder.append_printf ("lhu\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_subu (Subu inst)
    {
      builder.append_printf ("subu\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_sh (Sh inst)
    {
      builder.append_printf ("sh\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_lh (Lh inst)
    {
      builder.append_printf ("lh\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_srl (Srl inst)
    {
      if (inst.is_rotr ())
        builder.append_printf ("rotr\t%s, %s, 0x%x", inst.rd.to_string(), inst.rt.to_string(), inst.sa);
      else
        builder.append_printf ("srl\t%s, %s, 0x%x", inst.rd.to_string(), inst.rt.to_string(), inst.sa);
    }

    public override void visit_andi (Andi inst)
    {
      builder.append_printf ("andi\t%s, %s, %d", inst.rs.to_string(), inst.rt.to_string(), inst.immediate);
    }

    public override void visit_regimm_bgez (Regimm.Bgez inst)
    {
      builder.append_printf ("bgez\t%s, %s\t#if GPR[%s] ≥ 0 then branch", inst.rs.to_string(), inst.reference.to_string(),
                             inst.rs.to_string());
    }

    public override void visit_sra (Sra inst)
    {
      builder.append_printf ("sra\t%s, %s, 0x%x", inst.rd.to_string(), inst.rt.to_string(), inst.sa);
    }

    public override void visit_lb (Lb inst)
    {
      builder.append_printf ("lb\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_ll (Ll inst)
    {
      builder.append_printf ("ll\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_regimm_bltz (Regimm.Bltz inst)
    {
      builder.append_printf ("bltz\t%s, %s\t#if GPR[%s] < 0 then branch", inst.rs.to_string(), inst.reference.to_string(),
                             inst.rs.to_string());
    }

    public override void visit_regimm_bltzl (Regimm.Bltzl inst)
    {
      builder.append_printf ("bltzl\t%s, %s\t# if GPR[%s] < 0 then branch_likely", inst.rs.to_string(),
                             inst.reference.to_string(), inst.rs.to_string());
    }

    public override void visit_regimm_bgezl (Regimm.Bgezl inst)
    {
      builder.append_printf ("bgezl\t%s, %s\t#if GPR[%s] ≥ 0 then branch_likely", inst.rs.to_string(),
                             inst.reference.to_string(), inst.rs.to_string());
    }

    public override void visit_slt (Slt inst)
    {
      builder.append_printf ("slt\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_mult (Mult inst)
    {
      builder.append_printf ("mult\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_multu (Multu inst)
    {
      builder.append_printf ("multu\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_mfhi (Mfhi inst)
    {
      builder.append_printf ("mfhi\t%s", inst.rd.to_string());
    }

    public override void visit_mthi (Mthi inst)
    {
      builder.append_printf ("mthi\t%s", inst.rs.to_string());
    }

    public override void visit_blez (Blez inst)
    {
      builder.append_printf ("blez\t%s, %s\t#if GPR[%s] ≤ 0 then branch", inst.rs.to_string(), inst.reference.to_string(),
                             inst.rs.to_string());
    }

    public override void visit_bgtz (Bgtz inst)
    {
      builder.append_printf ("bgtz\t%s, %s\t# if GPR[%s] > 0 then branch", inst.rs.to_string(), inst.reference.to_string(),
                             inst.rs.to_string());
    }

    public override void visit_bgtzl (Bgtzl inst)
    {
      builder.append_printf ("bgtzl\t%s, %s\t# if GPR[%s] > 0 then branch_likely", inst.rs.to_string(),
                             inst.reference.to_string(), inst.rs.to_string());
    }

    public override void visit_xori (Xori inst)
    {
      builder.append_printf ("xori\t%s, %s, %d", inst.rt.to_string(), inst.rs.to_string(), inst.immediate);
    }

    public override void visit_clo (Clo inst)
    {
      builder.append_printf ("clo\t%s, %s", inst.rd.to_string(), inst.rs.to_string());
    }

    public override void visit_clz (Clz inst)
    {
      builder.append_printf ("clz\t%s, %s", inst.rd.to_string(), inst.rs.to_string());
    }

    public override void visit_mul (Mul inst)
    {
      builder.append_printf ("mul\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_nor (Nor inst)
    {
      builder.append_printf ("nor\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_xor (Xor inst)
    {
      builder.append_printf ("xor\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_srlv (Srlv inst)
    {
      if (inst.is_rotr ())
        builder.append_printf ("rotrv\t%s, %s, %s", inst.rd.to_string(), inst.rt.to_string(), inst.rs.to_string());
      else
        builder.append_printf ("srlv\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_srav (Srav inst)
    {
      builder.append_printf ("srav\t%s, %s, %s", inst.rd.to_string(), inst.rt.to_string(), inst.rs.to_string());
    }

    public override void visit_divu (Divu inst)
    {
      builder.append_printf ("divu\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_break (Break inst)
    {
      builder.append_printf ("break");
    }

    public override void visit_mflo (Mflo inst)
    {
      builder.append_printf ("mflo\t%s", inst.rd.to_string());
    }

    public override void visit_mtlo (Mtlo inst)
    {
      builder.append_printf ("mtlo\t%s", inst.rs.to_string());
    }

    public override void visit_movz (Movz inst)
    {
      builder.append_printf ("movz\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_movn (Movn inst)
    {
      builder.append_printf ("movn\t%s, %s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_div (Div inst)
    {
      builder.append_printf ("div\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_blezl (Blezl inst)
    {
      builder.append_printf ("blezl\t%s, %s\t#if GPR[%s] ≤ 0 then branch_likely", inst.rs.to_string(),
                             inst.reference.to_string(), inst.rs.to_string());
    }

    public override void visit_sdc1 (Sdc1 inst)
    {
      builder.append_printf ("sdc1\t%s, %d(%s)", inst.ft.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_sdc2 (Sdc2 inst)
    {
      builder.append_printf ("sdc2\t%s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_cop1x_sdxc1 (Cop1x.Sdxc1 inst)
    {
      builder.append_printf ("sdxc1\t%s, %d(%s)", inst.fs.to_string(), inst.index, inst.@base.to_string());
    }

    public override void visit_cop1x_suxc1 (Cop1x.Suxc1 inst)
    {
      builder.append_printf ("suxc1\t%s, %d(%s)", inst.fs.to_string(), inst.index, inst.@base.to_string());
    }

    public override void visit_cop1x_swxc1 (Cop1x.Swxc1 inst)
    {
      builder.append_printf ("swxc1\t%s, %d(%s)", inst.fs.to_string(), inst.index, inst.@base.to_string());
    }

    public override void visit_ldc1 (Ldc1 inst)
    {
      builder.append_printf ("ldc1\t%s, %d(%s)", inst.ft.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_ldc2 (Ldc2 inst)
    {
      builder.append_printf ("ldc2\t%s, %d(%s)", inst.ft.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_lwc1 (Lwc1 inst)
    {
      builder.append_printf ("lwc1\t%s, %d(%s)", inst.ft.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_lwc2 (Lwc2 inst)
    {
      builder.append_printf ("lwc2\t%s, %d(%s)", inst.ft.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_swc1 (Swc1 inst)
    {
      builder.append_printf ("swc1\t%s, %d(%s)", inst.ft.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_swc2 (Swc2 inst)
    {
      builder.append_printf ("swc2\t%s, %d(%s)", inst.ft.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_jump (Jump inst)
    {
      builder.append_printf ("j\t0x%x", inst.instr_index);
    }

    public override void visit_jal (Jal inst)
    {
      builder.append_printf ("jal\t0x%x", inst.instr_index);
    }

    public override void visit_sdbbp (Sdbbp inst)
    {
      builder.append_printf ("sdbbp\t0x%x", inst.code);
    }

    public override void visit_syscall (Syscall inst)
    {
      builder.append_printf ("syscall\t0x%x", inst.code);
    }

    public override void visit_teq (Teq inst)
    {
      builder.append_printf ("teq\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_regimm_teqi (Regimm.Teqi inst)
    {
      builder.append_printf ("teqi\t%s, %d", inst.rs.to_string(), inst.immediate);
    }

    public override void visit_tge (Tge inst)
    {
      builder.append_printf ("tge\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_regimm_tgei (Regimm.Tgei inst)
    {
      builder.append_printf ("tgei\t%s, %u", inst.rs.to_string(), inst.immediate);
    }

    public override void visit_regimm_tgeiu (Regimm.Tgeiu inst)
    {
      builder.append_printf ("tgeiu\t%s, %u", inst.rs.to_string(), inst.immediate);
    }

    public override void visit_tgeu (Tgeu inst)
    {
      builder.append_printf ("tgeu\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_cop0_tlbp (Cop0.Tlbp inst)
    {
      builder.append_printf ("tlbp");
    }

    public override void visit_cop0_tlbr (Cop0.Tlbr inst)
    {
      builder.append_printf ("tlbr");
    }

    public override void visit_cop0_tlbwi (Cop0.Tlbwi inst)
    {
      builder.append_printf ("tlbwi");
    }

    public override void visit_cop0_tlbwr (Cop0.Tlbwr inst)
    {
      builder.append_printf ("tlbwr");
    }

    public override void visit_cop0_wait (Cop0.Wait inst)
    {
      builder.append_printf ("wait");
    }

    public override void visit_tlt (Tlt inst)
    {
      builder.append_printf ("tlt\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_regimm_tlti (Regimm.Tlti inst)
    {
      builder.append_printf ("tlti\t%s, %u", inst.rs.to_string(), inst.immediate);
    }

    public override void visit_regimm_tltiu (Regimm.Tltiu inst)
    {
      builder.append_printf ("tltiu\t%s, %u", inst.rs.to_string(), inst.immediate);
    }
   
    public override void visit_tltu (Tltu inst)
    {
      builder.append_printf ("tltu\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_tne (Tne inst)
    {
      builder.append_printf ("tne\t%s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_regimm_tnei (Regimm.Tnei inst)
    {
      builder.append_printf ("tnei\t%s, %u", inst.rs.to_string(), inst.immediate);
    }
  }
}
