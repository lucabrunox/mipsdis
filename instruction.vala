namespace Mips
{
  public enum Register
    {
      ZERO,
      AT,
      V0, V1,
      A0, A1, A2, A3,
      T0, T1, T2, T3, T4, T5, T6, T7,
      S0, S1, S2, S3, S4, S5, S6, S7,
      T8, T9,
      K0, K1,
      GP,
      SP,
      FP,
      RA;

      public string to_string ()
      {
        switch (this)
        {
        case Register.ZERO:
          return "zero";
        case Register.AT:
          return "at";
        case Register.V0:
          return "v0";
        case Register.V1:
          return "v1";
        case Register.A0:
          return "a0";
        case Register.A1:
          return "a1";
        case Register.A2:
          return "a2";
        case Register.A3:
          return "a3";
        case Register.T0:
          return "t0";
        case Register.T1:
          return "t1";
        case Register.T2:
          return "t2";
        case Register.T3:
          return "t3";
        case Register.T4:
          return "t4";
        case Register.T5:
          return "t5";
        case Register.T6:
          return "t6";
        case Register.T7:
          return "t7";
        case Register.S0:
          return "s0";
        case Register.S1:
          return "s1";
        case Register.S2:
          return "s2";
        case Register.S3:
          return "s3";
        case Register.S4:
          return "s4";
        case Register.S5:
          return "s5";
        case Register.S6:
          return "s6";
        case Register.S7:
          return "s7";
        case Register.T8:
          return "t8";
        case Register.T9:
          return "t9";
        case Register.K0:
          return "k0";
        case Register.K1:
          return "k1";
        case Register.GP:
          return "gp";
        case Register.SP:
          return "sp";
        case Register.FP:
          return "fp";
        case Register.RA:
          return "ra";
        default:
          assert_not_reached ();
        }
      }
    }

  static const uint8 SPECIAL = 0x00;
  static const uint8 REGIMM = 0x01;
  static const uint8 COP0 = 0x10;
  static const uint8 COP1 = 0x11;
  static const uint8 COP1X = 0x13;
  static const uint8 COP2 = 0x12;
  static const uint8 SPECIAL2 = 0x1C;
  static const uint8 SPECIAL3 = 0x1F;

  static const int FIVE_MASK = 0x1F;
  static const int FIVE1_BITS = 21;
  static const int FIVE2_BITS = 16;
  static const int FIVE3_BITS = 11;
  static const int FIVE4_BITS = 6;
  static const int HALF_MASK = 0xFFFF;
  static const int THREE_MASK = 0x7;
  static const int TEN_MASK = 0x3FF;
  static const int TEN_BITS = 6;

  public inline static uint8 get_five1 (int code)
  {
    return (uint8)((code >> FIVE1_BITS) & FIVE_MASK);
  }

  public inline static Register get_five1_gpr (int code)
  {
    return (Register)((code >> FIVE1_BITS) & FIVE_MASK);
  }

  public inline static uint8 get_five2 (int code)
  {
    return (uint8)((code >> FIVE2_BITS) & FIVE_MASK);
  }

  public inline static Register get_five2_gpr (int code)
  {
    return (Register)((code >> FIVE2_BITS) & FIVE_MASK);
  }

  public inline static uint8 get_five3 (int code)
  {
    return (uint8)((code >> FIVE3_BITS) & FIVE_MASK);
  }

  public inline static Register get_five3_gpr (int code)
  {
    return (Register)((code >> FIVE3_BITS) & FIVE_MASK);
  }

  public inline static uint8 get_five4 (int code)
  {
    return (uint8)((code >> FIVE4_BITS) & FIVE_MASK);
  }

  public inline static uint16 get_half (int code)
  {
    return (uint16)(code & HALF_MASK);
  }

  public inline static int16 get_halfi (int code)
  {
    return (int16)(code & HALF_MASK);
  }

  public inline static uint8 get_three (int code)
  {
    return (uint8)(code & THREE_MASK);
  }

  public inline static uint16 get_ten (int code)
  {
    return (uint16)((code >> TEN_BITS) & TEN_MASK);
  }

  public abstract class Visitor
  {
    public abstract void visit_cop0_eret (Cop0.Eret inst);
    public abstract void visit_cop0_deret (Cop0.Deret inst);
    public abstract void visit_cop0_mf (Cop0.Mf inst);
    public abstract void visit_cop0_mt (Cop0.Mt inst);
    public abstract void visit_cop1_abs (Cop1.Abs inst);
    public abstract void visit_cop1_cf (Cop1.Cf inst);
    public abstract void visit_cop1_ct (Cop1.Ct inst);
    public abstract void visit_cop2_cf (Cop2.Cf inst);
    public abstract void visit_cop2_ct (Cop2.Ct inst);
    public abstract void visit_cop2_mf (Cop2.Mf inst);
    public abstract void visit_cop2_mfh (Cop2.Mfh inst);
    public abstract void visit_cop2_mth (Cop2.Mth inst);
    public abstract void visit_cop1_sqrt (Cop1.Sqrt inst);
    public abstract void visit_cop1_mov (Cop1.Mov inst);
    public abstract void visit_cop1_neg (Cop1.Neg inst);
    public abstract void visit_cop1_sub (Cop1.Sub inst);
    public abstract void visit_cop1_mul (Cop1.Mul inst);
    public abstract void visit_cop1_div (Cop1.Div inst);
    public abstract void visit_cop1_truncw (Cop1.Truncw inst);
    public abstract void visit_cop1_ceilw (Cop1.Ceilw inst);
    public abstract void visit_cop1_floorw (Cop1.Floorw inst);
    public abstract void visit_cop1_roundl (Cop1.Roundl inst);
    public abstract void visit_cop1_roundw (Cop1.Roundw inst);
    public abstract void visit_cop1_rsqrt (Cop1.Rsqrt inst);
    public abstract void visit_cop1_cvtd (Cop1.Cvtd inst);
    public abstract void visit_cop1_cvtw (Cop1.Cvtw inst);
    public abstract void visit_cop1_cvts (Cop1.Cvts inst);
    public abstract void visit_cop1_add (Cop1.Add inst);
    public abstract void visit_cop1_pll (Cop1.Pll inst);
    public abstract void visit_cop1_plu (Cop1.Plu inst);
    public abstract void visit_cop1_pul (Cop1.Pul inst);
    public abstract void visit_cop1_puu (Cop1.Puu inst);
    public abstract void visit_cop1_ccond (Cop1.Ccond inst);
    public abstract void visit_cop1_bc (Cop1.Bc inst);
    public abstract void visit_cop1_movz (Cop1.Movz inst);
    public abstract void visit_cop2_bc (Cop2.Bc inst);
    public abstract void visit_cop2_mt (Cop2.Mt inst);
    public abstract void visit_cop1_mt (Cop1.Mt inst);
    public abstract void visit_cop1_mf (Cop1.Mf inst);
    public abstract void visit_cop1_mfh (Cop1.Mfh inst);
    public abstract void visit_cop1_mth (Cop1.Mth inst);
    public abstract void visit_cop1_recip (Cop1.Recip inst);
    public abstract void visit_movci (Movci inst);
    public abstract void visit_cop1_movcf (Cop1.Movcf inst);
    public abstract void visit_cop1x_madd (Cop1x.Madd inst);
    public abstract void visit_cop1x_nmadd (Cop1x.Nmadd inst);
    public abstract void visit_cop1x_nmsub (Cop1x.Nmsub inst);
    public abstract void visit_cop1x_msub (Cop1x.Msub inst);
    public abstract void visit_cop1x_prefx (Cop1x.Prefx inst);
    public abstract void visit_jump (Jump inst);
    public abstract void visit_jal (Jal inst);
    public abstract void visit_sdbbp (Sdbbp inst);
    public abstract void visit_syscall (Syscall inst);
    public abstract void visit_add (Add inst);
    public abstract void visit_lui (Lui inst);
    public abstract void visit_addiu (Addiu inst);
    public abstract void visit_addi (Addi inst);
    public abstract void visit_addu (Addu inst);
    public abstract void visit_subu (Subu inst);
    public abstract void visit_cop0_rdpgpr (Cop0.Rdpgpr inst);
    public abstract void visit_sw (Sw inst);
    public abstract void visit_cache (Cache inst);
    public abstract void visit_pref (Pref inst);
    public abstract void visit_sync (Sync inst);
    public abstract void visit_regimm_synci (Regimm.Synci inst);
    public abstract void visit_swl (Swl inst);
    public abstract void visit_swr (Swr inst);
    public abstract void visit_lb (Lb inst);
    public abstract void visit_ll (Ll inst);
    public abstract void visit_sh (Sh inst);
    public abstract void visit_lh (Lh inst);
    public abstract void visit_regimm_bgezal (Regimm.Bgezal inst);
    public abstract void visit_regimm_bgezall (Regimm.Bgezall inst);
    public abstract void visit_nop (Nop inst);
    public abstract void visit_ssnop (Ssnop inst);
    public abstract void visit_lw (Lw inst);
    public abstract void visit_lwl (Lwl inst);
    public abstract void visit_lwr (Lwr inst);
    public abstract void visit_jalr (Jalr inst);
    public abstract void visit_jr (Jr inst);
    public abstract void visit_regimm_bltzal (Regimm.Bltzal inst);
    public abstract void visit_regimm_bltzall (Regimm.Bltzall inst);
    public abstract void visit_regimm_bgez (Regimm.Bgez inst);
    public abstract void visit_regimm_bgezl (Regimm.Bgezl inst);
    public abstract void visit_regimm_bltz (Regimm.Bltz inst);
    public abstract void visit_regimm_bltzl (Regimm.Bltzl inst);
    public abstract void visit_sll (Sll inst);
    public abstract void visit_sra (Sra inst);
    public abstract void visit_srl (Srl inst);
    public abstract void visit_beq (Beq inst);
    public abstract void visit_beql (Beql inst);
    public abstract void visit_bne (Bne inst);
    public abstract void visit_bnel (Bnel inst);
    public abstract void visit_lbu (Lbu inst);
    public abstract void visit_sb (Sb inst);
    public abstract void visit_seb (Seb inst);
    public abstract void visit_seh (Seh inst);
    public abstract void visit_sc (Sc inst);
    public abstract void visit_rdhwr (Rdhwr inst);
    public abstract void visit_sltiu (Sltiu inst);
    public abstract void visit_slti (Slti inst);
    public abstract void visit_ori (Ori inst);
    public abstract void visit_andi (Andi inst);
    public abstract void visit_sltu (Sltu inst);
    public abstract void visit_mult (Mult inst);
    public abstract void visit_div (Div inst);
    public abstract void visit_slt (Slt inst);
    public abstract void visit_sllv (Sllv inst);
    public abstract void visit_and (And inst);
    public abstract void visit_or (Or inst);
    public abstract void visit_lhu (Lhu inst);
    public abstract void visit_mfhi (Mfhi inst);
    public abstract void visit_mthi (Mthi inst);
    public abstract void visit_mflo (Mflo inst);
    public abstract void visit_mtlo (Mtlo inst);
    public abstract void visit_multu (Multu inst);
    public abstract void visit_blez (Blez inst);
    public abstract void visit_blezl (Blezl inst);
    public abstract void visit_bgtz (Bgtz inst);
    public abstract void visit_bgtzl (Bgtzl inst);
    public abstract void visit_xori (Xori inst);
    public abstract void visit_clo (Clo inst);
    public abstract void visit_clz (Clz inst);
    public abstract void visit_mul (Mul inst);
    public abstract void visit_nor (Nor inst);
    public abstract void visit_xor (Xor inst);
    public abstract void visit_srlv (Srlv inst);
    public abstract void visit_srav (Srav inst);
    public abstract void visit_divu (Divu inst);
    public abstract void visit_break (Break inst);
    public abstract void visit_movz (Movz inst);
    public abstract void visit_madd (Madd inst);
    public abstract void visit_msub (Msub inst);
    public abstract void visit_msubu (Msubu inst);
    public abstract void visit_maddu (Maddu inst);
    public abstract void visit_movn (Movn inst);
    public abstract void visit_sdc1 (Sdc1 inst);
    public abstract void visit_sdc2 (Sdc2 inst);
    public abstract void visit_cop1x_sdxc1 (Cop1x.Sdxc1 inst);
    public abstract void visit_cop1x_suxc1 (Cop1x.Suxc1 inst);
    public abstract void visit_cop1x_swxc1 (Cop1x.Swxc1 inst);
    public abstract void visit_ldc1 (Ldc1 inst);
    public abstract void visit_ldc2 (Ldc2 inst);
    public abstract void visit_lwc1 (Lwc1 inst);
    public abstract void visit_lwc2 (Lwc2 inst);
    public abstract void visit_swc1 (Swc1 inst);
    public abstract void visit_swc2 (Swc2 inst);
    public abstract void visit_teq (Teq inst);
    public abstract void visit_regimm_teqi (Regimm.Teqi inst);
    public abstract void visit_tge (Tge inst);
    public abstract void visit_regimm_tgei (Regimm.Tgei inst);
    public abstract void visit_regimm_tgeiu (Regimm.Tgeiu inst);
    public abstract void visit_tgeu (Tgeu inst);
    public abstract void visit_cop0_tlbp (Cop0.Tlbp inst);
    public abstract void visit_cop0_tlbr (Cop0.Tlbr inst);
    public abstract void visit_cop0_tlbwi (Cop0.Tlbwi inst);
    public abstract void visit_cop0_tlbwr (Cop0.Tlbwr inst);
    public abstract void visit_tlt (Tlt inst);
    public abstract void visit_regimm_tlti (Regimm.Tlti inst);
    public abstract void visit_regimm_tltiu (Regimm.Tltiu inst);
    public abstract void visit_tltu (Tltu inst);
    public abstract void visit_tne (Tne inst);
    public abstract void visit_regimm_tnei (Regimm.Tnei inst);
    public abstract void visit_cop1_truncl (Cop1.Truncl inst);
    public abstract void visit_cop0_wait (Cop0.Wait inst);
    public abstract void visit_cop0_wrpgpr (Cop0.Wrpgpr inst);
    public abstract void visit_wsbh (Wsbh inst);
  }

  public abstract class Instruction
  {
    public abstract void accept (Visitor visitor);
  }

  public class Cop0.Deret : Instruction
  {
    /* COP0
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_deret (this);
    }
  }

  public class Cop0.Eret : Instruction
  {
    /* COP0
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_eret (this);
    }
  }

  public class Cop1.Abs : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 fs;
    public uint8 fd;

    public Abs (uint8 fmt, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Abs.from_code (int code)
    {
      this (get_five1 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_abs (this);
    }
  }

  public class Cop0.Mf : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 rt;
    public uint8 rd;
    public uint8 sel;

    public Mf (uint8 rt, uint8 rd, uint8 sel)
    {
      this.rt = rt;
      this.rd = rd;
      this.sel = sel;
    }

    public Mf.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code), get_three (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_mf (this);
    }
  }

  public class Cop0.Mt : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 rt;
    public uint8 rd;
    public uint8 sel;

    public Mt (uint8 rt, uint8 rd, uint8 sel)
    {
      this.rt = rt;
      this.rd = rd;
      this.sel = sel;
    }

    public Mt.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code), get_three (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_mt (this);
    }
  }

  public class Cop1.Cf : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 rt;
    public uint8 fs;

    public Cf (uint8 rt, uint8 fs)
    {
      this.rt = rt;
      this.fs = fs;
    }

    public Cf.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_cf (this);
    }
  }

  public class Cop1.Ct : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 rt;
    public uint8 fs;

    public Ct (uint8 rt, uint8 fs)
    {
      this.rt = rt;
      this.fs = fs;
    }

    public Ct.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_ct (this);
    }
  }

  public class Cop2.Cf : Instruction
  {
    /* COP2
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 rt;
    public uint8 rd;

    public Cf (uint8 rt, uint8 rd)
    {
      this.rt = rt;
      this.rd = rd;
    }

    public Cf.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop2_cf (this);
    }
  }

  public class Cop2.Ct : Instruction
  {
    /* COP2
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 rt;
    public uint8 rd;

    public Ct (uint8 rt, uint8 rd)
    {
      this.rt = rt;
      this.rd = rd;
    }

    public Ct.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop2_ct (this);
    }
  }

  public class Cop2.Mf : Instruction
  {
    /* COP2
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 rt;
    public uint16 impl;

    public Mf (uint8 rt, uint16 impl)
    {
      this.rt = rt;
      this.impl = impl;
    }

    public Mf.from_code (int code)
    {
      this (get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop2_mf (this);
    }
  }

  public class Cop2.Mfh : Instruction
  {
    /* COP2
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 rt;
    public uint16 impl;

    public Mfh (uint8 rt, uint16 impl)
    {
      this.rt = rt;
      this.impl = impl;
    }

    public Mfh.from_code (int code)
    {
      this (get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop2_mfh (this);
    }
  }

  public class Cop2.Mth : Instruction
  {
    /* COP2
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 rt;
    public uint16 impl;

    public Mth (uint8 rt, uint16 impl)
    {
      this.rt = rt;
      this.impl = impl;
    }

    public Mth.from_code (int code)
    {
      this (get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop2_mth (this);
    }
  }

  public class Cop1.Sqrt : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 fs;
    public uint8 fd;

    public Sqrt (uint8 fmt, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Sqrt.from_code (int code)
    {
      this (get_five1 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_sqrt (this);
    }
  }

  public class Cop1.Movz : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 rt;
    public uint8 fs;
    public uint8 fd;

    public Movz (uint8 fmt, uint8 rt, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.rt = rt;
      this.fs = fs;
      this.fd = fd;
    }

    public Movz.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_movz (this);
    }
  }

  public class Add : Instruction
  {
    /* SPECIAL
       000000 rs(5) rt(5) rd(5) 00000 100000
    */
    public uint8 rs;
    public uint8 rt;
    public uint8 rd;

    public Add (uint8 rs, uint8 rt, uint8 rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public Add.from_code (int code)
      {
        this (get_five1 (code), get_five2 (code), get_five3 (code));
      }

    public override void accept (Visitor visitor)
    {
      visitor.visit_add (this);
    }
  }

  public class Lui : Instruction
  {
    /*
      001111 00000 rt(5) immediate(16)
    */
    public Register rt;
    public uint16 immediate;

    public Lui (Register rt, uint16 immediate)
    {
      this.rt = rt;
      this.immediate = immediate;
    }

    public Lui.from_code (int code)
    {
      this (get_five2_gpr (code), get_half (code));
    }
    
    public override void accept (Visitor visitor)
    {
      visitor.visit_lui (this);
    }
  }

  public class Addiu : Instruction
  {
    /*
      001001 rs(5) rt(5) immediate(16)
    */

    public Register rs;
    public Register rt;
    public uint16 immediate;
    public BinaryReference reference;

    public Addiu (Register rs, Register rt, uint16 immediate)
    {
      this.rs = rs;
      this.rt = rt;
      this.immediate = immediate;
    }

    public Addiu.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_addiu (this);
    }
  }

  public class Addi : Instruction
  {
    /*
      001001 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;
    public int16 immediate;

    public Addi (uint8 rs, uint8 rt, int16 immediate)
    {
      this.rs = rs;
      this.rt = rt;
      this.immediate = immediate;
    }

    public Addi.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), (int16)get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_addi (this);
    }
  }

  public class Addu : Instruction
  {
    /* SPECIAL
       000000 rs(5) rt(5) rd(5) 00000 100001
    */

    public Register rs;
    public Register rt;
    public Register rd;

    public Addu (Register rs, Register rt, Register rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public Addu.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_addu (this);
    }
  }

  public class Sw : Instruction
  {
    /* SW
       101011 base(5) rt(5) offset(16)
    */

    public Register @base;
    public Register rt;
    public uint16 offset;

    public Sw (Register @base, Register rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Sw.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sw (this);
    }
  }

  public class Cache : Instruction
  {
    /* CACHE
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 op;
    public uint16 offset;

    public Cache (uint8 @base, uint8 op, uint16 offset)
      {
        this.@base = @base;
        this.op = op;
        this.offset = offset;
      }

    public Cache.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cache (this);
    }
  }

  public class Pref : Instruction
  {
    /* PREF
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 hint;
    public uint16 offset;

    public Pref (uint8 @base, uint8 hint, uint16 offset)
      {
        this.@base = @base;
        this.hint = hint;
        this.offset = offset;
      }

    public Pref.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_pref (this);
    }
  }

  public class Sync : Instruction
  {
    /* SYNC
       101011 base(5) rt(5) offset(16)
    */

    public uint8 stype;

    public Sync (uint8 stype)
      {
        this.stype = stype;
      }

    public Sync.from_code (int code)
    {
      this (get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sync (this);
    }
  }

  public class Regimm.Synci : Instruction
  {
    /* SYNCI
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint16 offset;

    public Synci (uint8 @base, uint16 offset)
      {
        this.@base = @base;
        this.offset = offset;
      }

    public Synci.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_synci (this);
    }
  }

  public class Regimm.Teqi : Instruction
  {
    /* TEQI
       101011 base(5) rt(5) offset(16)
    */

    public uint8 rs;
    public uint16 immediate;

    public Teqi (uint8 rs, uint16 immediate)
      {
        this.rs = rs;
        this.immediate = immediate;
      }

    public Teqi.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_teqi (this);
    }
  }

  public class Regimm.Tnei : Instruction
  {
    /* TNEI
       101011 base(5) rt(5) offset(16)
    */

    public uint8 rs;
    public uint16 immediate;

    public Tnei (uint8 rs, uint16 immediate)
      {
        this.rs = rs;
        this.immediate = immediate;
      }

    public Tnei.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_tnei (this);
    }
  }

  public class Regimm.Tlti : Instruction
  {
    /* TLTI
       101011 base(5) rt(5) offset(16)
    */

    public uint8 rs;
    public uint16 immediate;

    public Tlti (uint8 rs, uint16 immediate)
      {
        this.rs = rs;
        this.immediate = immediate;
      }

    public Tlti.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_tlti (this);
    }
  }

  public class Regimm.Tltiu : Instruction
  {
    /* TLTIU
       101011 base(5) rt(5) offset(16)
    */

    public uint8 rs;
    public uint16 immediate;

    public Tltiu (uint8 rs, uint16 immediate)
      {
        this.rs = rs;
        this.immediate = immediate;
      }

    public Tltiu.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_tltiu (this);
    }
  }

  public class Regimm.Tgei : Instruction
  {
    /* TGEI
       101011 base(5) rt(5) offset(16)
    */

    public uint8 rs;
    public uint16 immediate;

    public Tgei (uint8 rs, uint16 immediate)
      {
        this.rs = rs;
        this.immediate = immediate;
      }

    public Tgei.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_tgei (this);
    }
  }

  public class Regimm.Tgeiu : Instruction
  {
    /* TGEIU
       101011 base(5) rt(5) offset(16)
    */

    public uint8 rs;
    public uint16 immediate;

    public Tgeiu (uint8 rs, uint16 immediate)
      {
        this.rs = rs;
        this.immediate = immediate;
      }

    public Tgeiu.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_tgeiu (this);
    }
  }

  public class Regimm.Bgezal : Instruction
  {
    /* REGIMM
       000001 00000 10001 offset(16)
    */
    public uint8 rs;
    public uint16 offset;

    public Bgezal (uint8 rs, uint16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bgezal.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_bgezal (this);
    }
  }

  public class Regimm.Bgezall : Instruction
  {
    /* REGIMM
       000001 00000 10001 offset(16)
    */
    public uint8 rs;
    public uint16 offset;

    public Bgezall (uint8 rs, uint16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bgezall.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_bgezall (this);
    }
  }

  public class Nop : Instruction
  {
    public override void accept (Visitor visitor)
    {
      visitor.visit_nop (this);
    }
  }

  public class Ssnop : Instruction
  {
    public override void accept (Visitor visitor)
    {
      visitor.visit_ssnop (this);
    }
  }

  public class Lw : Instruction
  {
    /* SW
       101011 base(5) rt(5) offset(16)
    */

    public Register @base;
    public Register rt;
    public int16 offset;
    public BinaryReference reference;

    public Lw (Register @base, Register rt, int16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Lw.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_halfi (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_lw (this);
    }
  }

  public class Jalr : Instruction
  {
    /* SPECIAL
       000000 rs(5) 00000 rd(5) hint(5) 001001
    */
    public uint8 rs;
    public uint8 rd;
    public uint8 hint;

    public Jalr (uint8 rs, uint8 rd, uint8 hint)
      {
        this.rs = rs;
        this.rd = rd;
        this.hint = hint;
      }

    public Jalr.from_code (int code)
      {
        this (get_five1 (code), get_five3 (code), get_five4 (code));
      }

    public bool has_hint ()
    {
      return hint >> 4 == 1;
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_jalr (this);
    }
  }

  public class Jr : Instruction
  {
    /* SPECIAL
       000000 rs(5) 00000 00000 hint(5) 001000
    */
    public uint8 rs;
    public uint8 hint;

    public Jr (uint8 rs, uint8 hint)
      {
        this.rs = rs;
        this.hint = hint;
      }

    public Jr.from_code (int code)
      {
        this (get_five1 (code), get_five4 (code));
      }

    public bool has_hint ()
    {
      return hint >> 4 == 1;
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_jr (this);
    }
  }

  public class Regimm.Bltzal : Instruction
  {
    /* REGIMM
       000001 rs(5) 10000 offset(16)
    */

    public uint8 rs;
    public uint16 offset;

    public Bltzal (uint8 rs, uint16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bltzal.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_bltzal (this);
    }
  }

  public class Regimm.Bltzall : Instruction
  {
    /* REGIMM
       000001 rs(5) 10000 offset(16)
    */

    public uint8 rs;
    public uint16 offset;

    public Bltzall (uint8 rs, uint16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bltzall.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_bltzall (this);
    }
  }

  public class Sll : Instruction
  {
    /* SPECIAL
       000000 00000 rt(5) rd(5) sa(5) 000000
    */
    public uint8 rt;
    public uint8 rd;
    public uint8 sa;

    public Sll (uint8 rt, uint8 rd, uint8 sa)
      {
        this.rt = rt;
        this.rd = rd;
        this.sa = sa;
      }

    public Sll.from_code (int code)
      {
        this (get_five2 (code), get_five3 (code), get_five4 (code));
      }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sll (this);
    }
  } 

  public class Beq : Instruction
  {
    /* BEQ
       000100 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;
    public int16 offset;

    public Beq (uint8 rs, uint8 rt, int16 offset)
    {
      this.rs = rs;
      this.rt = rt;
      this.offset = offset;
    }

    public Beq.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), (int16)get_half (code));
    }

    public bool is_unconditional ()
    {
      return rs == 0 && rt == 0;
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_beq (this);
    }
  }

  public class Beql : Instruction
  {
    /* BEQL
       000100 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;
    public int16 offset;

    public Beql (uint8 rs, uint8 rt, int16 offset)
    {
      this.rs = rs;
      this.rt = rt;
      this.offset = offset;
    }

    public Beql.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), (int16)get_half (code));
    }

    public bool is_unconditional ()
    {
      return rs == 0 && rt == 0;
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_beql (this);
    }
  }

  public class Bne : Instruction
  {
    /* BNE
       000101 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;
    public int16 offset;

    public Bne (uint8 rs, uint8 rt, int16 offset)
    {
      this.rs = rs;
      this.rt = rt;
      this.offset = offset;
    }

    public Bne.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), (int16)get_half (code));
    }

    public bool is_unconditional ()
    {
      return rs == 0 && rt == 0;
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_bne (this);
    }
  }

  public class Bnel : Instruction
  {
    /* BNEL
       000101 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;
    public int16 offset;

    public Bnel (uint8 rs, uint8 rt, int16 offset)
    {
      this.rs = rs;
      this.rt = rt;
      this.offset = offset;
    }

    public Bnel.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), (int16)get_half (code));
    }

    public bool is_unconditional ()
    {
      return rs == 0 && rt == 0;
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_bnel (this);
    }
  }

  public class Lbu : Instruction
  {
    /* LBU
       100100 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 rt;
    public uint16 offset;

    public Lbu (uint8 @base, uint8 rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Lbu.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_lbu (this);
    }
  }

  public class Sb : Instruction
  {
    /* SB
       101000 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 rt;
    public uint16 offset;

    public Sb (uint8 @base, uint8 rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Sb.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sb (this);
    }
  }

  public class Seb : Instruction
  {
    /* SEB
       101000 base(5) rt(5) offset(16)
    */

    public uint8 rt;
    public uint8 rd;

    public Seb (uint8 rt, uint8 rd)
      {
        this.rt = rt;
        this.rd = rd;
      }

    public Seb.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_seb (this);
    }
  }

  public class Wsbh : Instruction
  {
    /* WSBH
       101000 base(5) rt(5) offset(16)
    */

    public uint8 rt;
    public uint8 rd;

    public Wsbh (uint8 rt, uint8 rd)
      {
        this.rt = rt;
        this.rd = rd;
      }

    public Wsbh.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_wsbh (this);
    }
  }

  public class Seh : Instruction
  {
    /* SEH
       101000 base(5) rt(5) offset(16)
    */

    public uint8 rt;
    public uint8 rd;

    public Seh (uint8 rt, uint8 rd)
      {
        this.rt = rt;
        this.rd = rd;
      }

    public Seh.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_seh (this);
    }
  }

  public class Sc : Instruction
  {
    /* SB
       101000 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 rt;
    public uint16 offset;

    public Sc (uint8 @base, uint8 rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Sc.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sc (this);
    }
  }

  public class Sltiu : Instruction
  {
    /*
      001011 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;
    public uint16 immediate;

    public Sltiu (uint8 rs, uint8 rt, uint16 immediate)
    {
      this.rs = rs;
      this.rt = rt;
      this.immediate = immediate;
    }

    public Sltiu.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sltiu (this);
    }
  }

  public class Slti : Instruction
  {
    /*
      001011 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;
    public int16 immediate;

    public Slti (uint8 rs, uint8 rt, int16 immediate)
    {
      this.rs = rs;
      this.rt = rt;
      this.immediate = immediate;
    }

    public Slti.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), (int16)get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_slti (this);
    }
  }

  public class Ori : Instruction
  {
    /*
      001011 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;
    public int16 immediate;

    public Ori (uint8 rs, uint8 rt, int16 immediate)
    {
      this.rs = rs;
      this.rt = rt;
      this.immediate = immediate;
    }

    public Ori.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), (int16)get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_ori (this);
    }
  }

  public class Sltu : Instruction
  {
    /* SPECIAL
       000000 rs(5) rt(5) rd(5) 00000 100001
    */

    public uint8 rs;
    public uint8 rt;
    public uint8 rd;

    public Sltu (uint8 rs, uint8 rt, uint8 rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public Sltu.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sltu (this);
    }
  }

  public class Sllv : Instruction
  {
    /* SPECIAL
       000000 rs(5) rt(5) rd(5) 00000 100001
    */

    public uint8 rs;
    public uint8 rt;
    public uint8 rd;

    public Sllv (uint8 rs, uint8 rt, uint8 rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public Sllv.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sllv (this);
    }
  }

  public class And : Instruction
  {
    /* SPECIAL
       000000 rs(5) rt(5) rd(5) 00000 100001
    */

    public uint8 rs;
    public uint8 rt;
    public uint8 rd;

    public And (uint8 rs, uint8 rt, uint8 rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public And.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_and (this);
    }
  }

  public class Or : Instruction
  {
    /* SPECIAL
       000000 rs(5) rt(5) rd(5) 00000 100001
    */

    public uint8 rs;
    public uint8 rt;
    public uint8 rd;

    public Or (uint8 rs, uint8 rt, uint8 rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public Or.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_or (this);
    }
  }

  public class Xor : Instruction
  {
    /* SPECIAL
       000000 rs(5) rt(5) rd(5) 00000 100001
    */

    public uint8 rs;
    public uint8 rt;
    public uint8 rd;

    public Xor (uint8 rs, uint8 rt, uint8 rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public Xor.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_xor (this);
    }
  }

  public class Lhu : Instruction
  {
    /* LHU
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 rt;
    public uint16 offset;

    public Lhu (uint8 @base, uint8 rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Lhu.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_lhu (this);
    }
  }

  public class Subu : Instruction
  {
    /* SPECIAL
       000000 rs(5) rt(5) rd(5) 00000 100001
    */

    public uint8 rs;
    public uint8 rt;
    public uint8 rd;

    public Subu (uint8 rs, uint8 rt, uint8 rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public Subu.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_subu (this);
    }
  }

  public class Sh : Instruction
  {
    /* SH
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 rt;
    public uint16 offset;

    public Sh (uint8 @base, uint8 rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Sh.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sh (this);
    }
  }

  public class Lh : Instruction
  {
    /* LH
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 rt;
    public uint16 offset;

    public Lh (uint8 @base, uint8 rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Lh.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_lh (this);
    }
  }

  public class Srl : Instruction
  {
    /* SPECIAL
       000000 00000 rt(5) rd(5) sa(5) 000000
    */
    public uint8 rotr;
    public uint8 rt;
    public uint8 rd;
    public uint8 sa;

    public Srl (uint8 rotr, uint8 rt, uint8 rd, uint8 sa)
      {
        this.rotr = rotr;
        this.rt = rt;
        this.rd = rd;
        this.sa = sa;
      }

    public Srl.from_code (int code)
      {
        this (get_five1 (code), get_five2 (code), get_five3 (code), get_five4 (code));
      }

    public bool is_rotr ()
    {
      return rotr == 1;
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_srl (this);
    }
  } 

  public class Andi : Instruction
  {
    /*
      001011 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;
    public int16 immediate;

    public Andi (uint8 rs, uint8 rt, int16 immediate)
    {
      this.rs = rs;
      this.rt = rt;
      this.immediate = immediate;
    }

    public Andi.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), (int16)get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_andi (this);
    }
  }

  public class Regimm.Bgez : Instruction
  {
    /* REGIMM
       000001 rs(5) 10000 offset(16)
    */

    public uint8 rs;
    public uint16 offset;

    public Bgez (uint8 rs, uint16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bgez.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_bgez (this);
    }
  }

  public class Regimm.Bgezl : Instruction
  {
    /* REGIMM
       000001 rs(5) 10000 offset(16)
    */

    public uint8 rs;
    public uint16 offset;

    public Bgezl (uint8 rs, uint16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bgezl.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_bgezl (this);
    }
  }

  public class Sra : Instruction
  {
    /* SPECIAL
       000000 00000 rt(5) rd(5) sa(5) 000000
    */
    public uint8 rt;
    public uint8 rd;
    public uint8 sa;

    public Sra (uint8 rt, uint8 rd, uint8 sa)
      {
        this.rt = rt;
        this.rd = rd;
        this.sa = sa;
      }

    public Sra.from_code (int code)
      {
        this (get_five2 (code), get_five3 (code), get_five4 (code));
      }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sra (this);
    }
  }

  public class Lb : Instruction
  {
    /* LB
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 rt;
    public uint16 offset;

    public Lb (uint8 @base, uint8 rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Lb.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_lb (this);
    }
  }

  public class Ll : Instruction
  {
    /* LL
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 rt;
    public uint16 offset;

    public Ll (uint8 @base, uint8 rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Ll.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_ll (this);
    }
  }

  public class Regimm.Bltz : Instruction
  {
    /* REGIMM
       000001 rs(5) 10000 offset(16)
    */

    public uint8 rs;
    public uint16 offset;

    public Bltz (uint8 rs, uint16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bltz.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_bltz (this);
    }
  }

  public class Regimm.Bltzl : Instruction
  {
    /* REGIMM
       000001 rs(5) 10000 offset(16)
    */

    public uint8 rs;
    public uint16 offset;

    public Bltzl (uint8 rs, uint16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bltzl.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_bltzl (this);
    }
  }

  public class Slt : Instruction
  {
    /* SPECIAL
       000000 rs(5) rt(5) rd(5) 00000 100001
    */

    public uint8 rs;
    public uint8 rt;
    public uint8 rd;

    public Slt (uint8 rs, uint8 rt, uint8 rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public Slt.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_slt (this);
    }
  }

  public class Mult : Instruction
  {
    /* SPECIAL
       000000 rs(5) rt(5) rd(5) 00000 100001
    */

    public uint8 rs;
    public uint8 rt;

    public Mult (uint8 rs, uint8 rt)
      {
        this.rs = rs;
        this.rt = rt;
      }

    public Mult.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_mult (this);
    }
  }

  public class Multu : Instruction
  {
    /* SPECIAL
       000000 rs(5) rt(5) rd(5) 00000 100001
    */

    public uint8 rs;
    public uint8 rt;

    public Multu (uint8 rs, uint8 rt)
      {
        this.rs = rs;
        this.rt = rt;
      }

    public Multu.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_multu (this);
    }
  }

  public class Mfhi : Instruction
  {
    /* SPECIAL
       000000 rs(5) rt(5) rd(5) 00000 100001
    */

    public uint8 rd;

    public Mfhi (uint8 rd)
      {
        this.rd = rd;
      }

    public Mfhi.from_code (int code)
    {
      this (get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_mfhi (this);
    }
  }

  public class Mthi : Instruction
  {
    /* SPECIAL
       000000 rs(5) rt(5) rd(5) 00000 100001
    */

    public uint8 rs;

    public Mthi (uint8 rs)
      {
        this.rs = rs;
      }

    public Mthi.from_code (int code)
    {
      this (get_five1 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_mthi (this);
    }
  }

  public class Blez : Instruction
  {
    /* REGIMM
       000001 rs(5) 10000 offset(16)
    */

    public uint8 rs;
    public uint16 offset;

    public Blez (uint8 rs, uint16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Blez.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_blez (this);
    }
  }

  public class Bgtz : Instruction
  {
    /* REGIMM
       000001 rs(5) 10000 offset(16)
    */

    public uint8 rs;
    public uint16 offset;

    public Bgtz (uint8 rs, uint16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bgtz.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_bgtz (this);
    }
  }

  public class Bgtzl : Instruction
  {
    /* REGIMM
       000001 rs(5) 10000 offset(16)
    */

    public uint8 rs;
    public uint16 offset;

    public Bgtzl (uint8 rs, uint16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bgtzl.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_bgtzl (this);
    }
  }

  public class Xori : Instruction
  {
    /*
      001001 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;
    public uint16 immediate;

    public Xori (uint8 rs, uint8 rt, uint16 immediate)
    {
      this.rs = rs;
      this.rt = rt;
      this.immediate = immediate;
    }

    public Xori.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_xori (this);
    }
  }

  public class Clo : Instruction
  {
    /*
      001001 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;
    public uint8 rd;

    public Clo (uint8 rs, uint8 rt, uint8 rd)
    {
      this.rs = rs;
      this.rt = rt;
      this.rd = rd;
    }

    public Clo.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_clo (this);
    }
  }

  public class Clz : Instruction
  {
    /*
      001001 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;
    public uint8 rd;

    public Clz (uint8 rs, uint8 rt, uint8 rd)
    {
      this.rs = rs;
      this.rt = rt;
      this.rd = rd;
    }

    public Clz.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_clz (this);
    }
  }

  public class Mul : Instruction
  {
    /*
      001001 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;
    public uint8 rd;

    public Mul (uint8 rs, uint8 rt, uint8 rd)
    {
      this.rs = rs;
      this.rt = rt;
      this.rd = rd;
    }

    public Mul.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_mul (this);
    }
  }

  public class Nor : Instruction
  {
    /*
      001001 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;
    public uint8 rd;

    public Nor (uint8 rs, uint8 rt, uint8 rd)
    {
      this.rs = rs;
      this.rt = rt;
      this.rd = rd;
    }

    public Nor.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_nor (this);
    }
  }

  public class Srlv : Instruction
  {
    /*
      001001 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;
    public uint8 rd;
    public uint8 rotr;

    public Srlv (uint8 rs, uint8 rt, uint8 rd, uint8 rotr)
    {
      this.rs = rs;
      this.rt = rt;
      this.rd = rd;
      this.rotr = rotr;
    }

    public Srlv.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code), get_five4 (code));
    }

    public bool is_rotr ()
    {
      return rotr == 1;
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_srlv (this);
    }
  }

  public class Srav : Instruction
  {
    /*
      001001 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;
    public uint8 rd;

    public Srav (uint8 rs, uint8 rt, uint8 rd)
    {
      this.rs = rs;
      this.rt = rt;
      this.rd = rd;
    }

    public Srav.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_srav (this);
    }
  }

  public class Divu : Instruction
  {
    /*
      001001 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;

    public Divu (uint8 rs, uint8 rt)
    {
      this.rs = rs;
      this.rt = rt;
    }

    public Divu.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_divu (this);
    }
  }

  public class Break : Instruction
  {
    /* SPECIAL
       000000 code(20) 001101
    */

    public uint code;

    public Break (uint code)
    {
      this.code = code;
    }

    public Break.from_code (int code)
    {
      this ((code >> 6) & 0xFFFFF);
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_break (this);
    }
  }

  public class Cop0.Tlbp : Instruction
  {
    /* SPECIAL
       000000 code(20) 001101
    */

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_tlbp (this);
    }
  }

  public class Cop0.Tlbr : Instruction
  {
    /* SPECIAL
       000000 code(20) 001101
    */

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_tlbr (this);
    }
  }

  public class Cop0.Tlbwi : Instruction
  {
    /* SPECIAL
       000000 code(20) 001101
    */

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_tlbwi (this);
    }
  }

  public class Cop0.Tlbwr : Instruction
  {
    /* SPECIAL
       000000 code(20) 001101
    */

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_tlbwr (this);
    }
  }

  public class Mflo : Instruction
  {
    /* SPECIAL
       000000 rs(5) rt(5) rd(5) 00000 100001
    */

    public uint8 rd;

    public Mflo (uint8 rd)
      {
        this.rd = rd;
      }

    public Mflo.from_code (int code)
    {
      this (get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_mflo (this);
    }
  }

  public class Mtlo : Instruction
  {
    /* SPECIAL
       000000 rs(5) rt(5) rd(5) 00000 100001
    */

    public uint8 rs;

    public Mtlo (uint8 rs)
      {
        this.rs = rs;
      }

    public Mtlo.from_code (int code)
    {
      this (get_five1 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_mtlo (this);
    }
  }

  public class Lwl : Instruction
  {
    /* SW
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 rt;
    public uint16 offset;

    public Lwl (uint8 @base, uint8 rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Lwl.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_lwl (this);
    }
  }

  public class Lwr : Instruction
  {
    /* SW
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 rt;
    public uint16 offset;

    public Lwr (uint8 @base, uint8 rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Lwr.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_lwr (this);
    }
  }

  public class Movz : Instruction
  {
    /*
      001001 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;
    public uint8 rd;

    public Movz (uint8 rs, uint8 rt, uint8 rd)
    {
      this.rs = rs;
      this.rt = rt;
      this.rd = rd;
    }

    public Movz.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_movz (this);
    }
  }

  public class Madd : Instruction
  {
    /*
      001001 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;

    public Madd (uint8 rs, uint8 rt)
    {
      this.rs = rs;
      this.rt = rt;
    }

    public Madd.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_madd (this);
    }
  }

  public class Msub : Instruction
  {
    /*
      001001 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;

    public Msub (uint8 rs, uint8 rt)
    {
      this.rs = rs;
      this.rt = rt;
    }

    public Msub.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_msub (this);
    }
  }

  public class Msubu : Instruction
  {
    /*
      001001 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;

    public Msubu (uint8 rs, uint8 rt)
    {
      this.rs = rs;
      this.rt = rt;
    }

    public Msubu.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_msubu (this);
    }
  }

  public class Maddu : Instruction
  {
    /*
      001001 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;

    public Maddu (uint8 rs, uint8 rt)
    {
      this.rs = rs;
      this.rt = rt;
    }

    public Maddu.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_maddu (this);
    }
  }

  public class Movn : Instruction
  {
    /*
      001001 rs(5) rt(5) immediate(16)
    */

    public uint8 rs;
    public uint8 rt;
    public uint8 rd;

    public Movn (uint8 rs, uint8 rt, uint8 rd)
    {
      this.rs = rs;
      this.rt = rt;
      this.rd = rd;
    }

    public Movn.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_movn (this);
    }
  }

  public class Div : Instruction
  {
    /* SPECIAL
       000000 rs(5) rt(5) rd(5) 00000 100001
    */

    public uint8 rs;
    public uint8 rt;

    public Div (uint8 rs, uint8 rt)
      {
        this.rs = rs;
        this.rt = rt;
      }

    public Div.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_div (this);
    }
  }

  public class Blezl : Instruction
  {
    /* REGIMM
       000001 rs(5) 10000 offset(16)
    */

    public uint8 rs;
    public uint16 offset;

    public Blezl (uint8 rs, uint16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Blezl.from_code (int code)
    {
      this (get_five1 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_blezl (this);
    }
  }

  public class Swl : Instruction
  {
    /* SWL
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 rt;
    public uint16 offset;

    public Swl (uint8 @base, uint8 rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Swl.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_swl (this);
    }
  }

  public class Swr : Instruction
  {
    /* SWR
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 rt;
    public uint16 offset;

    public Swr (uint8 @base, uint8 rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Swr.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_swr (this);
    }
  }

  public class Sdc1 : Instruction
  {
    /* SDC1
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 ft;
    public uint16 offset;

    public Sdc1 (uint8 @base, uint8 ft, uint16 offset)
      {
        this.@base = @base;
        this.ft = ft;
        this.offset = offset;
      }

    public Sdc1.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sdc1 (this);
    }
  }

  public class Sdc2 : Instruction
  {
    /* SDC2
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 rt;
    public uint16 offset;

    public Sdc2 (uint8 @base, uint8 rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Sdc2.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sdc2 (this);
    }
  }

  public class Cop1x.Sdxc1 : Instruction
  {
    /* SDXC1
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 index;
    public uint8 fs;

    public Sdxc1 (uint8 @base, uint8 index, uint8 fs)
      {
        this.@base = @base;
        this.index = index;
        this.fs = fs;
      }

    public Sdxc1.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_sdxc1 (this);
    }
  }

  public class Cop1x.Suxc1 : Instruction
  {
    /* SUXC1
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 index;
    public uint8 fs;

    public Suxc1 (uint8 @base, uint8 index, uint8 fs)
      {
        this.@base = @base;
        this.index = index;
        this.fs = fs;
      }

    public Suxc1.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_suxc1 (this);
    }
  }

  public class Cop1x.Swxc1 : Instruction
  {
    /* SWXC1
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 index;
    public uint8 fs;

    public Swxc1 (uint8 @base, uint8 index, uint8 fs)
      {
        this.@base = @base;
        this.index = index;
        this.fs = fs;
      }

    public Swxc1.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_swxc1 (this);
    }
  }

  public class Ldc1 : Instruction
  {
    /* LDC1
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 ft;
    public uint16 offset;

    public Ldc1 (uint8 @base, uint8 ft, uint16 offset)
      {
        this.@base = @base;
        this.ft = ft;
        this.offset = offset;
      }

    public Ldc1.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_ldc1 (this);
    }
  }

  public class Ldc2 : Instruction
  {
    /* LDC2
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 ft;
    public uint16 offset;

    public Ldc2 (uint8 @base, uint8 ft, uint16 offset)
      {
        this.@base = @base;
        this.ft = ft;
        this.offset = offset;
      }

    public Ldc2.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_ldc2 (this);
    }
  }

  public class Lwc1 : Instruction
  {
    /* LWC1
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 ft;
    public uint16 offset;

    public Lwc1 (uint8 @base, uint8 ft, uint16 offset)
      {
        this.@base = @base;
        this.ft = ft;
        this.offset = offset;
      }

    public Lwc1.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_lwc1 (this);
    }
  }

  public class Lwc2 : Instruction
  {
    /* LWC2
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 ft;
    public uint16 offset;

    public Lwc2 (uint8 @base, uint8 ft, uint16 offset)
      {
        this.@base = @base;
        this.ft = ft;
        this.offset = offset;
      }

    public Lwc2.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_lwc2 (this);
    }
  }

  public class Swc1 : Instruction
  {
    /* SWC1
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 ft;
    public uint16 offset;

    public Swc1 (uint8 @base, uint8 ft, uint16 offset)
      {
        this.@base = @base;
        this.ft = ft;
        this.offset = offset;
      }

    public Swc1.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_swc1 (this);
    }
  }

  public class Swc2 : Instruction
  {
    /* SWC2
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 ft;
    public uint16 offset;

    public Swc2 (uint8 @base, uint8 ft, uint16 offset)
      {
        this.@base = @base;
        this.ft = ft;
        this.offset = offset;
      }

    public Swc2.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_swc2 (this);
    }
  }

  public class Cop1.Mov : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 fs;
    public uint8 fd;

    public Mov (uint8 fmt, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Mov.from_code (int code)
    {
      this (get_five1 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_mov (this);
    }
  }

  public class Cop1.Neg : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 fs;
    public uint8 fd;

    public Neg (uint8 fmt, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Neg.from_code (int code)
    {
      this (get_five1 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_neg (this);
    }
  }

  public class Cop1.Truncw : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 fs;
    public uint8 fd;

    public Truncw (uint8 fmt, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Truncw.from_code (int code)
    {
      this (get_five1 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_truncw (this);
    }
  }

  public class Cop1.Truncl : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 fs;
    public uint8 fd;

    public Truncl (uint8 fmt, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Truncl.from_code (int code)
    {
      this (get_five1 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_truncl (this);
    }
  }

  public class Cop1.Ceilw : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 fs;
    public uint8 fd;

    public Ceilw (uint8 fmt, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Ceilw.from_code (int code)
    {
      this (get_five1 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_ceilw (this);
    }
  }

  public class Cop1.Floorw : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 fs;
    public uint8 fd;

    public Floorw (uint8 fmt, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Floorw.from_code (int code)
    {
      this (get_five1 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_floorw (this);
    }
  }

  public class Cop1.Roundl : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 fs;
    public uint8 fd;

    public Roundl (uint8 fmt, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Roundl.from_code (int code)
    {
      this (get_five1 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_roundl (this);
    }
  }

  public class Cop1.Roundw : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 fs;
    public uint8 fd;

    public Roundw (uint8 fmt, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Roundw.from_code (int code)
    {
      this (get_five1 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_roundw (this);
    }
  }

  public class Cop1.Rsqrt : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 fs;
    public uint8 fd;

    public Rsqrt (uint8 fmt, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Rsqrt.from_code (int code)
    {
      this (get_five1 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_rsqrt (this);
    }
  }

  public class Cop1.Sub : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 ft;
    public uint8 fs;
    public uint8 fd;

    public Sub (uint8 fmt, uint8 ft, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
    }

    public Sub.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_sub (this);
    }
  }

  public class Cop1.Mul : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 ft;
    public uint8 fs;
    public uint8 fd;

    public Mul (uint8 fmt, uint8 ft, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
    }

    public Mul.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_mul (this);
    }
  }

  public class Cop1.Div : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 ft;
    public uint8 fs;
    public uint8 fd;

    public Div (uint8 fmt, uint8 ft, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
    }

    public Div.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_div (this);
    }
  }

  public class Cop1.Add : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 ft;
    public uint8 fs;
    public uint8 fd;

    public Add (uint8 fmt, uint8 ft, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
    }

    public Add.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_add (this);
    }
  }

  public class Cop1.Pll : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 ft;
    public uint8 fs;
    public uint8 fd;

    public Pll (uint8 ft, uint8 fs, uint8 fd)
    {
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
    }

    public Pll.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_pll (this);
    }
  }

  public class Cop1.Plu : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 ft;
    public uint8 fs;
    public uint8 fd;

    public Plu (uint8 ft, uint8 fs, uint8 fd)
    {
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
    }

    public Plu.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_plu (this);
    }
  }

  public class Cop1.Pul : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 ft;
    public uint8 fs;
    public uint8 fd;

    public Pul (uint8 ft, uint8 fs, uint8 fd)
    {
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
    }

    public Pul.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_pul (this);
    }
  }

  public class Cop1.Puu : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 ft;
    public uint8 fs;
    public uint8 fd;

    public Puu (uint8 ft, uint8 fs, uint8 fd)
    {
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
    }

    public Puu.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_puu (this);
    }
  }

  public class Cop1.Cvtd : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 fs;
    public uint8 fd;

    public Cvtd (uint8 fmt, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Cvtd.from_code (int code)
    {
      this (get_five1 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_cvtd (this);
    }
  }

  public class Cop1.Cvtw : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 fs;
    public uint8 fd;

    public Cvtw (uint8 fmt, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Cvtw.from_code (int code)
    {
      this (get_five1 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_cvtw (this);
    }
  }

  public class Cop1.Cvts : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 fs;
    public uint8 fd;

    public Cvts (uint8 fmt, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Cvts.from_code (int code)
    {
      this (get_five1 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_cvts (this);
    }
  }

  public class Cop1.Ccond : Instruction
  {
    /* COP1
       010001 fmt(5) 00000 fs(5) fd(5) 000101
    */
    public uint8 fmt;
    public uint8 ft;
    public uint8 fs;
    public uint8 cc;
    public uint8 cond;

    public Ccond (uint8 fmt, uint8 ft, uint8 fs, uint8 cc, uint8 cond)
    {
      this.fmt = fmt;
      this.ft = ft;
      this.fs = fs;
      this.cc = cc;
      this.cond = cond;
    }

    public Ccond.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code), get_five4 (code) >> 2, (uint8)(code & 0x0F));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_ccond (this);
    }
  }

  public class Cop1.Bc : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */
    public enum Branch
    {
      FALSE,
      FALSE_LIKELY,
      TRUE,
      TRUE_LIKELY
    }

    public uint8 cc;
    public Branch branch;
    public uint16 offset;

    public Bc (uint8 cc, Branch branch, uint16 offset)
    {
      this.cc = cc;
      this.branch = branch;
      this.offset = offset;
    }

    public Bc.from_code (int code)
    {
      this (get_five2 (code) >> 2, (Branch)(get_five2 (code) & 0x03), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_bc (this);
    }
  }

  public class Cop2.Bc : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */
    public enum Branch
    {
      FALSE,
      FALSE_LIKELY,
      TRUE,
      TRUE_LIKELY
    }

    public uint8 cc;
    public Branch branch;
    public uint16 offset;

    public Bc (uint8 cc, Branch branch, uint16 offset)
    {
      this.cc = cc;
      this.branch = branch;
      this.offset = offset;
    }

    public Bc.from_code (int code)
    {
      this (get_five2 (code) >> 2, (Branch)(get_five2 (code) & 0x03), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop2_bc (this);
    }
  }

  public class Cop2.Mt : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 rt;
    public uint16 impl;

    public Mt (uint8 rt, uint16 impl)
    {
      this.rt = rt;
      this.impl = impl;
    }

    public Mt.from_code (int code)
    {
      this (get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop2_mt (this);
    }
  }

  public class Cop1.Mt : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 rt;
    public uint8 fs;

    public Mt (uint8 rt, uint8 fs)
    {
      this.rt = rt;
      this.fs = fs;
    }

    public Mt.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_mt (this);
    }
  }

  public class Cop1.Mf : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 rt;
    public uint8 fs;

    public Mf (uint8 rt, uint8 fs)
    {
      this.rt = rt;
      this.fs = fs;
    }

    public Mf.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_mf (this);
    }
  }

  public class Cop1.Mfh : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 rt;
    public uint8 fs;

    public Mfh (uint8 rt, uint8 fs)
    {
      this.rt = rt;
      this.fs = fs;
    }

    public Mfh.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_mfh (this);
    }
  }

  public class Cop1.Mth : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 rt;
    public uint8 fs;

    public Mth (uint8 rt, uint8 fs)
    {
      this.rt = rt;
      this.fs = fs;
    }

    public Mth.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_mth (this);
    }
  }

  public class Cop1.Recip : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */
    public uint8 fmt;
    public uint8 fs;
    public uint8 fd;

    public Recip (uint8 fmt, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Recip.from_code (int code)
    {
      this (get_five1 (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_recip (this);
    }
  }

  public class Movci : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 rs;
    public uint8 cc;
    public bool test_true;
    public uint8 rd;

    public Movci (uint8 rs, uint8 cc, bool test_true, uint8 rd)
    {
      this.rs = rs;
      this.cc = cc;
      this.test_true = test_true;
      this.rd = rd;
    }

    public Movci.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code) >> 2, (code & 0x10000) == 1, get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_movci (this);
    }
  }

  public class Cop1.Movcf : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 fmt;
    public uint8 cc;
    public bool test_true;
    public uint8 fs;
    public uint8 fd;

    public Movcf (uint8 fmt, uint8 cc, bool test_true, uint8 fs, uint8 fd)
    {
      this.fmt = fmt;
      this.cc = cc;
      this.test_true = test_true;
      this.fs = fs;
      this.fd = fd;
    }

    public Movcf.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code) >> 2, (code & 0x10000) == 1, get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_movcf (this);
    }
  }

  public class Jump : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint instr_index;

    public Jump (uint instr_index)
    {
      this.instr_index = instr_index;
    }

    public Jump.from_code (int code)
    {
      this (code & 0x3FFFFFF);
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_jump (this);
    }
  }

  public class Cop0.Wait : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint code;

    public Wait (uint code)
    {
      this.code = code;
    }

    public Wait.from_code (int code)
    {
      this (code & 0x7FFFF);
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_wait (this);
    }
  }

  public class Jal : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint instr_index;

    public Jal (uint instr_index)
    {
      this.instr_index = instr_index;
    }

    public Jal.from_code (int code)
    {
      this (code & 0x3FFFFFF);
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_jal (this);
    }
  }

  public class Sdbbp : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint code;

    public Sdbbp (uint code)
    {
      this.code = code;
    }

    public Sdbbp.from_code (int code)
    {
      this ((code >> 6) & 0xFFFFF);
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sdbbp (this);
    }
  }

  public class Syscall : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint code;

    public Syscall (uint code)
    {
      this.code = code;
    }

    public Syscall.from_code (int code)
    {
      this ((code >> 6) & 0xFFFFF);
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_syscall (this);
    }
  }

  public class Teq : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 rs;
    public uint8 rt;
    public uint16 code;

    public Teq (uint8 rs, uint8 rt, uint16 code)
    {
      this.rs = rs;
      this.rt = rt;
      this.code = code;
    }

    public Teq.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_ten (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_teq (this);
    }
  }

  public class Tltu : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 rs;
    public uint8 rt;
    public uint16 code;

    public Tltu (uint8 rs, uint8 rt, uint16 code)
    {
      this.rs = rs;
      this.rt = rt;
      this.code = code;
    }

    public Tltu.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_ten (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_tltu (this);
    }
  }

  public class Tne : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 rs;
    public uint8 rt;
    public uint16 code;

    public Tne (uint8 rs, uint8 rt, uint16 code)
    {
      this.rs = rs;
      this.rt = rt;
      this.code = code;
    }

    public Tne.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_ten (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_tne (this);
    }
  }

  public class Tlt : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 rs;
    public uint8 rt;
    public uint16 code;

    public Tlt (uint8 rs, uint8 rt, uint16 code)
    {
      this.rs = rs;
      this.rt = rt;
      this.code = code;
    }

    public Tlt.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_ten (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_tlt (this);
    }
  }

  public class Tgeu : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 rs;
    public uint8 rt;
    public uint16 code;

    public Tgeu (uint8 rs, uint8 rt, uint16 code)
    {
      this.rs = rs;
      this.rt = rt;
      this.code = code;
    }

    public Tgeu.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_ten (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_tgeu (this);
    }
  }

  public class Tge : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 rs;
    public uint8 rt;
    public uint16 code;

    public Tge (uint8 rs, uint8 rt, uint16 code)
    {
      this.rs = rs;
      this.rt = rt;
      this.code = code;
    }

    public Tge.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_ten (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_tge (this);
    }
  }

  public class Cop1x.Madd : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 fr;
    public uint8 ft;
    public uint8 fs;
    public uint8 fd;
    public uint8 fmt;

    public Madd (uint8 fr, uint8 ft, uint8 fs, uint8 fd, uint8 fmt)
    {
      this.fr = fr;
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
      this.fmt = fmt;
    }

    public Madd.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code), get_five4 (code), get_three (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_madd (this);
    }
  }

  public class Cop1x.Nmadd : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 fr;
    public uint8 ft;
    public uint8 fs;
    public uint8 fd;
    public uint8 fmt;

    public Nmadd (uint8 fr, uint8 ft, uint8 fs, uint8 fd, uint8 fmt)
    {
      this.fr = fr;
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
      this.fmt = fmt;
    }

    public Nmadd.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code), get_five4 (code), get_three (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_nmadd (this);
    }
  }

  public class Cop1x.Nmsub : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 fr;
    public uint8 ft;
    public uint8 fs;
    public uint8 fd;
    public uint8 fmt;

    public Nmsub (uint8 fr, uint8 ft, uint8 fs, uint8 fd, uint8 fmt)
    {
      this.fr = fr;
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
      this.fmt = fmt;
    }

    public Nmsub.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code), get_five4 (code), get_three (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_nmsub (this);
    }
  }

  public class Cop1x.Msub : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 fr;
    public uint8 ft;
    public uint8 fs;
    public uint8 fd;
    public uint8 fmt;

    public Msub (uint8 fr, uint8 ft, uint8 fs, uint8 fd, uint8 fmt)
    {
      this.fr = fr;
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
      this.fmt = fmt;
    }

    public Msub.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code), get_five4 (code), get_three (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_msub (this);
    }
  }

  public class Cop1x.Prefx : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 @base;
    public uint8 index;
    public uint8 hint;

    public Prefx (uint8 @base, uint8 index, uint8 hint)
    {
      this.@base = @base;
      this.index = index;
      this.hint = hint;
    }

    public Prefx.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_prefx (this);
    }
  }

  public class Rdhwr : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 rt;
    public uint8 rd;

    public Rdhwr (uint8 rt, uint8 rd)
    {
      this.rt = rt;
      this.rd = rd;
    }

    public Rdhwr.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_rdhwr (this);
    }
  }

  public class Cop0.Rdpgpr : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 rt;
    public uint8 rd;

    public Rdpgpr (uint8 rt, uint8 rd)
    {
      this.rt = rt;
      this.rd = rd;
    }

    public Rdpgpr.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_rdpgpr (this);
    }
  }

  public class Cop0.Wrpgpr : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 rt;
    public uint8 rd;

    public Wrpgpr (uint8 rt, uint8 rd)
    {
      this.rt = rt;
      this.rd = rd;
    }

    public Wrpgpr.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_wrpgpr (this);
    }
  }
}
