/* instruction.vala
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

  [CCode (has_type_id = false)]
  public struct FpuRegister : uint8
  {
    public new string to_string ()
      requires (this >= 0)
      requires (this < 32)
    {
      return "f%d".printf (this);
    }
  }

  public enum Cop1.Format
    {
      S = 0x10,
        D,
        W = 0x14,
        L,
        PS;

      public string to_string ()
      {
        switch (this)
          {
          case S:
            return "s";
          case D:
            return "d";
          case W:
            return "w";
          case L:
            return "l";
          case PS:
            return "ps";
          default:
            assert_not_reached ();
          }
      }
    }

  public enum Cop1x.Format
    {
      S,
        D,
        W = 4,
        L,
        PS;

      public string to_string ()
      {
        switch (this)
          {
          case S:
            return "s";
          case D:
            return "d";
          case W:
            return "w";
          case L:
            return "l";
          case PS:
            return "ps";
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
    return (Register)get_five1(code);
  }

  public inline static FpuRegister get_five1_fpr (int code)
  {
    return (FpuRegister)get_five1(code);
  }

  public inline static uint8 get_five2 (int code)
  {
    return (uint8)((code >> FIVE2_BITS) & FIVE_MASK);
  }

  public inline static Register get_five2_gpr (int code)
  {
    return (Register)get_five2(code);
  }

  public inline static FpuRegister get_five2_fpr (int code)
  {
    return (FpuRegister)get_five2(code);
  }

  public inline static uint8 get_five3 (int code)
  {
    return (uint8)((code >> FIVE3_BITS) & FIVE_MASK);
  }

  public inline static Register get_five3_gpr (int code)
  {
    return (Register)get_five3(code);
  }

  public inline static FpuRegister get_five3_fpr (int code)
  {
    return (FpuRegister)get_five3(code);
  }

  public inline static uint8 get_five4 (int code)
  {
    return (uint8)((code >> FIVE4_BITS) & FIVE_MASK);
  }

  public inline static Register get_five4_gpr (int code)
  {
    return (Register)get_five4(code);
  }

  public inline static FpuRegister get_five4_fpr (int code)
  {
    return (FpuRegister)get_five4(code);
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
    public abstract void visit_cop2_co (Cop2.Co inst);
    public abstract void visit_cop2_cf (Cop2.Cf inst);
    public abstract void visit_cop2_ct (Cop2.Ct inst);
    public abstract void visit_cop2_mf (Cop2.Mf inst);
    public abstract void visit_cop2_mfh (Cop2.Mfh inst);
    public abstract void visit_cop2_mth (Cop2.Mth inst);
    public abstract void visit_cop1_sqrt (Cop1.Sqrt inst);
    public abstract void visit_cop1_mov (Cop1.Mov inst);
    public abstract void visit_cop1_movn (Cop1.Movn inst);
    public abstract void visit_cop1_neg (Cop1.Neg inst);
    public abstract void visit_cop1_sub (Cop1.Sub inst);
    public abstract void visit_cop1_mul (Cop1.Mul inst);
    public abstract void visit_cop1_div (Cop1.Div inst);
    public abstract void visit_cop1_truncw (Cop1.Truncw inst);
    public abstract void visit_cop1_ceill (Cop1.Ceill inst);
    public abstract void visit_cop1_ceilw (Cop1.Ceilw inst);
    public abstract void visit_cop1_floorl (Cop1.Floorl inst);
    public abstract void visit_cop1_floorw (Cop1.Floorw inst);
    public abstract void visit_cop1_roundl (Cop1.Roundl inst);
    public abstract void visit_cop1_roundw (Cop1.Roundw inst);
    public abstract void visit_cop1_rsqrt (Cop1.Rsqrt inst);
    public abstract void visit_cop1_cvtd (Cop1.Cvtd inst);
    public abstract void visit_cop1_cvtl (Cop1.Cvtl inst);
    public abstract void visit_cop1_cvtw (Cop1.Cvtw inst);
    public abstract void visit_cop1_cvts (Cop1.Cvts inst);
    public abstract void visit_cop1_cvtspl (Cop1.Cvtspl inst);
    public abstract void visit_cop1_cvtspu (Cop1.Cvtspu inst);
    public abstract void visit_cop1_cvtps (Cop1.Cvtps inst);
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
    public abstract void visit_cop1x_alnv (Cop1x.Alnv inst);
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
    public abstract void visit_sub (Sub inst);
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
    public abstract void visit_cop1x_ldxc1 (Cop1x.Ldxc1 inst);
    public abstract void visit_cop1x_luxc1 (Cop1x.Luxc1 inst);
    public abstract void visit_cop1x_lwxc1 (Cop1x.Lwxc1 inst);
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
    public abstract void visit_cop0_mfmc0 (Cop0.Mfmc0 inst);
    public abstract void visit_cop0_wrpgpr (Cop0.Wrpgpr inst);
    public abstract void visit_wsbh (Wsbh inst);
    public abstract void visit_ext (Ext inst);
    public abstract void visit_ins (Ins inst);
  }

  public abstract class Instruction
  {
    public abstract void accept (Visitor visitor);
    public abstract string get_mnemonic ();
    public virtual string? get_description () { return null; }
  }

  public class Cop1.Abs : Instruction
  {
    public Format fmt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Abs (Format fmt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Abs.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_abs (this);
    }

    public override string get_mnemonic ()
    {
      return @"abs.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← abs(FPR[$fs])";
    }
  }

  public class Add : Instruction
  {
    public Register rs;
    public Register rt;
    public Register rd;

    public Add (Register rs, Register rt, Register rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public Add.from_code (int code)
      {
        this (get_five1_gpr (code), get_five2_gpr (code), get_five3_gpr (code));
      }

    public override void accept (Visitor visitor)
    {
      visitor.visit_add (this);
    }

    public override string get_mnemonic ()
    {
      return "add";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← GPR[$rs] + GPR[$rt]";
    }
  }

  public class Cop1.Add : Instruction
  {
    public Format fmt;
    public FpuRegister ft;
    public FpuRegister fs;
    public FpuRegister fd;

    public Add (Format fmt, FpuRegister ft, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
    }

    public Add.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five2_fpr (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_add (this);
    }

    public override string get_mnemonic ()
    {
      return @"add.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← FPR[$fs] + FPR[$ft]";
    }
  }

  public class Addi : Instruction
  {
    public Register rs;
    public Register rt;
    public int16 immediate;

    public Addi (Register rs, Register rt, int16 immediate)
    {
      this.rs = rs;
      this.rt = rt;
      this.immediate = immediate;
    }

    public Addi.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), (int16)get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_addi (this);
    }

    public override string get_mnemonic ()
    {
      return "addi";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← GPR[$rs] + $immediate";
    }
  }

  public class Addiu : Instruction
  {
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

    public override string get_mnemonic ()
    {
      return "addiu";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← GPR[$rs] + $immediate";
    }
  }

  public class Addu : Instruction
  {
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

    public override string get_mnemonic ()
    {
      return "addu";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← GPR[$rs] + GPR[$rt]";
    }
  }

  public class Cop1x.Alnv : Instruction
  {
    public Register rs;
    public FpuRegister ft;
    public FpuRegister fs;
    public FpuRegister fd;

    public Alnv (Register rs, FpuRegister ft, FpuRegister fs, FpuRegister fd)
      {
        this.rs = rs;
        this.ft = ft;
        this.fs = fs;
        this.fd = fd;
      }

    public Alnv.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_fpr (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_alnv (this);
    }

    public override string get_mnemonic ()
    {
      return "alnv.ps";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← ByteAlign(GPR[$rs]2..0, FPR[$fs], FPR[$ft])";
    }
  }

  public class And : Instruction
  {
    public Register rs;
    public Register rt;
    public Register rd;

    public And (Register rs, Register rt, Register rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public And.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_and (this);
    }

    public override string get_mnemonic ()
    {
      return "and";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← GPR[$rs] AND GPR[$rt]";
    }
  }

  public class Andi : Instruction
  {
    public Register rs;
    public Register rt;
    public int16 immediate;

    public Andi (Register rs, Register rt, int16 immediate)
    {
      this.rs = rs;
      this.rt = rt;
      this.immediate = immediate;
    }

    public Andi.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), (int16)get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_andi (this);
    }

    public override string get_mnemonic ()
    {
      return "andi";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← GPR[$rs] AND $immediate";
    }
  }

  public class Cop1.Bc : Instruction
  {
    public enum Branch
    {
      FALSE,
      FALSE_LIKELY,
      TRUE,
      TRUE_LIKELY;

      public string to_string ()
      {
        switch (this)
          {
          case FALSE:
            return "bc1f";
          case FALSE_LIKELY:
            return "bc1fl";
          case TRUE:
            return "bc1t";
          case TRUE_LIKELY:
            return "bc1tl";
          default:
            assert_not_reached ();
          }
      }
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

    public override string get_mnemonic ()
    {
      return branch.to_string ();
    }

    public override string? get_description ()
    {
      return @"if FPConditionCode($cc) = 0 then branch";
    }
  }

  public class Cop2.Bc : Instruction
  {
    public enum Branch
    {
      FALSE,
      FALSE_LIKELY,
      TRUE,
      TRUE_LIKELY;

      public string to_string ()
      {
        switch (this)
          {
          case FALSE:
            return "bc2f";
          case FALSE_LIKELY:
            return "bc2fl";
          case TRUE:
            return "bc2t";
          case TRUE_LIKELY:
            return "bc2tl";
          default:
            assert_not_reached ();
          }
      }
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

    public override string get_mnemonic ()
    {
      return branch.to_string ();
    }

    public override string? get_description ()
    {
      return @"if COP2Condition($cc) = 0 then branch";
    }
  }

  public class Beq : Instruction
  {
    public Register rs;
    public Register rt;
    public int16 offset;
    public BinaryInstruction reference;

    public Beq (Register rs, Register rt, int16 offset)
    {
      this.rs = rs;
      this.rt = rt;
      this.offset = offset;
    }

    public Beq.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), (int16)get_half (code));
    }

    public bool is_unconditional ()
    {
      return rs == 0 && rt == 0;
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_beq (this);
    }

    public override string get_mnemonic ()
    {
      if (is_unconditional ())
        return "b";
      return "beq";
    }

    public override string? get_description ()
    {
      if (is_unconditional ())
        return "branch";
      return @"if GPR[$rs] = GPR[$rt] then branch";
    }
  }

  public class Beql : Instruction
  {
    public Register rs;
    public Register rt;
    public int16 offset;
    public BinaryInstruction reference;

    public Beql (Register rs, Register rt, int16 offset)
    {
      this.rs = rs;
      this.rt = rt;
      this.offset = offset;
    }

    public Beql.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), (int16)get_half (code));
    }

    public bool is_unconditional ()
    {
      return rs == 0 && rt == 0;
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_beql (this);
    }

    public override string get_mnemonic ()
    {
      return "beql";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] = GPR[$rt] then branch_likely";
    }
  }

  public class Regimm.Bgez : Instruction
  {
    public Register rs;
    public int16 offset;
    public BinaryInstruction reference;

    public Bgez (Register rs, int16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bgez.from_code (int code)
    {
      this (get_five1_gpr (code), get_halfi (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_bgez (this);
    }

    public override string get_mnemonic ()
    {
      return "bgez";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] ≥ 0 then branch";
    }
  }

  public class Regimm.Bgezal : Instruction
  {
    public Register rs;
    public int16 offset;
    public BinaryInstruction reference;

    public Bgezal (Register rs, int16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bgezal.from_code (int code)
    {
      this (get_five1_gpr (code), get_halfi (code));
    }

    public bool is_unconditional ()
    {
      return rs == 0;
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_bgezal (this);
    }

    public override string get_mnemonic ()
    {
      if (is_unconditional ())
        return "bal";
      return "bgezal";
    }

    public override string? get_description ()
    {
      if (is_unconditional ())
        return "procedure_call";
      return @"if GPR[$rs] ≥ 0 then procedure_call";
    }
  }

  public class Regimm.Bgezall : Instruction
  {
    public Register rs;
    public int16 offset;
    public BinaryInstruction reference;

    public Bgezall (Register rs, int16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bgezall.from_code (int code)
    {
      this (get_five1_gpr (code), get_halfi (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_bgezall (this);
    }

    public override string get_mnemonic ()
    {
      return "bgezall";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] ≥ 0 then procedure_call";
    }
  }

  public class Regimm.Bgezl : Instruction
  {
    public Register rs;
    public int16 offset;
    public BinaryInstruction reference;

    public Bgezl (Register rs, int16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bgezl.from_code (int code)
    {
      this (get_five1_gpr (code), get_halfi (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_bgezl (this);
    }

    public override string get_mnemonic ()
    {
      return "bgezl";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] ≥ 0 then branch_likely";
    }
  }

  public class Bgtz : Instruction
  {
    public Register rs;
    public int16 offset;
    public BinaryInstruction reference;

    public Bgtz (Register rs, int16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bgtz.from_code (int code)
    {
      this (get_five1_gpr (code), get_halfi (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_bgtz (this);
    }

    public override string get_mnemonic ()
    {
      return "bgtz";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] > 0 then branch";
    }
  }

  public class Bgtzl : Instruction
  {
    public Register rs;
    public int16 offset;
    public BinaryInstruction reference;

    public Bgtzl (Register rs, int16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bgtzl.from_code (int code)
    {
      this (get_five1_gpr (code), get_halfi (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_bgtzl (this);
    }

    public override string get_mnemonic ()
    {
      return "bgtzl";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] > 0 then branch_likely";
    }
  }

  public class Blez : Instruction
  {
    public Register rs;
    public int16 offset;
    public BinaryInstruction reference;

    public Blez (Register rs, int16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Blez.from_code (int code)
    {
      this (get_five1_gpr (code), get_halfi (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_blez (this);
    }

    public override string get_mnemonic ()
    {
      return "blez";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] ≤ 0 then branch";
    }
  }

  public class Blezl : Instruction
  {
    public Register rs;
    public int16 offset;
    public BinaryInstruction reference;

    public Blezl (Register rs, int16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Blezl.from_code (int code)
    {
      this (get_five1_gpr (code), get_halfi (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_blezl (this);
    }

    public override string get_mnemonic ()
    {
      return "blezl";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] ≤ 0 then branch_likely";
    }
  }

  public class Regimm.Bltz : Instruction
  {
    public Register rs;
    public int16 offset;
    public BinaryInstruction reference;

    public Bltz (Register rs, int16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bltz.from_code (int code)
    {
      this (get_five1_gpr (code), get_halfi (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_bltz (this);
    }

    public override string get_mnemonic ()
    {
      return "bltz";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] < 0 then branch";
    }
  }

  public class Regimm.Bltzal : Instruction
  {
    public Register rs;
    public int16 offset;
    public BinaryInstruction reference;

    public Bltzal (Register rs, int16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bltzal.from_code (int code)
    {
      this (get_five1_gpr (code), get_halfi (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_bltzal (this);
    }

    public override string get_mnemonic ()
    {
      return "bltzal";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] < 0 then procedure_call";
    }
  }

  public class Regimm.Bltzall : Instruction
  {
    public Register rs;
    public int16 offset;
    public BinaryInstruction reference;

    public Bltzall (Register rs, int16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bltzall.from_code (int code)
    {
      this (get_five1_gpr (code), get_halfi (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_bltzall (this);
    }

    public override string get_mnemonic ()
    {
      return "bltzall";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] < 0 then procedure_call_likely";
    }
  }

  public class Regimm.Bltzl : Instruction
  {
    public Register rs;
    public int16 offset;
    public BinaryInstruction reference;

    public Bltzl (Register rs, int16 offset)
      {
        this.rs = rs;
        this.offset = offset;
      }

    public Bltzl.from_code (int code)
    {
      this (get_five1_gpr (code), get_halfi (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_bltzl (this);
    }

    public override string get_mnemonic ()
    {
      return "bltzl";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] < 0 then branch_likely";
    }
  }

  public class Bne : Instruction
  {
    public Register rs;
    public Register rt;
    public int16 offset;
    public BinaryInstruction reference;

    public Bne (Register rs, Register rt, int16 offset)
    {
      this.rs = rs;
      this.rt = rt;
      this.offset = offset;
    }

    public Bne.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), (int16)get_half (code));
    }

    public bool is_unconditional ()
    {
      return rs == 0 && rt == 0;
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_bne (this);
    }

    public override string get_mnemonic ()
    {
      return "bne";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] ≠ GPR[$rt] then branch";
    }
  }

  public class Bnel : Instruction
  {
    public Register rs;
    public Register rt;
    public int16 offset;
    public BinaryInstruction reference;

    public Bnel (Register rs, Register rt, int16 offset)
    {
      this.rs = rs;
      this.rt = rt;
      this.offset = offset;
    }

    public Bnel.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), (int16)get_half (code));
    }

    public bool is_unconditional ()
    {
      return rs == 0 && rt == 0;
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_bnel (this);
    }

    public override string get_mnemonic ()
    {
      return "bnel";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] ≠ GPR[$rt] then branch likely";
    }
  }

  public class Break : Instruction
  {
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

    public override string get_mnemonic ()
    {
      return "break";
    }

    public override string? get_description ()
    {
      return "breakpoint";
    }
  }

  public class Cop1.Ccond : Instruction
  {
    public enum ConditionType
    {
      F,
        UN,
        EQ,
        UEQ,
        OLT,
        ULT,
        OLE,
        ULE,
        SF,
        NGLE,
        SEQ,
        NGL,
        LT,
        NGE,
        LE,
        NGT;

      public string to_string ()
      {
        switch (this)
          {
          case F:
            return "f";
          case UN:
            return "un";
          case EQ:
            return "eq";
          case UEQ:
            return "ueq";
          case OLT:
            return "olt";
          case ULT:
            return "ult";
          case OLE:
            return "ole";
          case ULE:
            return "ule";
          case SF:
            return "sf";
          case NGLE:
            return "ngle";
          case SEQ:
            return "seq";
          case NGL:
            return "ngl";
          case LT:
            return "lt";
          case NGE:
            return "nge";
          case LE:
            return "le";
          case NGT:
            return "ngt";
          default:
            assert_not_reached ();
          }
      }
    }

    public Format fmt;
    public FpuRegister ft;
    public FpuRegister fs;
    public uint8 cc;
    public ConditionType cond;

    public Ccond (Format fmt, FpuRegister ft, FpuRegister fs, uint8 cc, ConditionType cond)
    {
      this.fmt = fmt;
      this.ft = ft;
      this.fs = fs;
      this.cc = cc;
      this.cond = cond;
    }

    public Ccond.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five2_fpr (code), get_five3_fpr (code), get_five4 (code) >> 2, (ConditionType)(code & 0x0F));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_ccond (this);
    }

    public override string get_mnemonic ()
    {
      return @"c.$cond.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPUConditionCode($cc) ← FPR[$fs] compare_cond FPR[$ft]";
    }
  }

  public class Cache : Instruction
  {
    public Register @base;
    public uint8 op;
    public uint16 offset;

    public Cache (Register @base, uint8 op, uint16 offset)
      {
        this.@base = @base;
        this.op = op;
        this.offset = offset;
      }

    public Cache.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cache (this);
    }

    public override string get_mnemonic ()
    {
      return "cache";
    }

    public override string? get_description ()
    {
      return @"perform the cache operation $op";
    }
  }

  public class Cop1.Ceill : Instruction
  {
    public Format fmt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Ceill (Format fmt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Ceill.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_ceill (this);
    }

    public override string get_mnemonic ()
    {
      return @"ceil.l.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← convert_and_round(FPR[$fs])";
    }
  }

  public class Cop1.Ceilw : Instruction
  {
    public Format fmt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Ceilw (Format fmt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Ceilw.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_ceilw (this);
    }

    public override string get_mnemonic ()
    {
      return @"ceil.w.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← convert_and_round(FPR[$fs])";
    }
  }

  public class Cop1.Cf : Instruction
  {
    public Register rt;
    public FpuRegister fs;

    public Cf (Register rt, FpuRegister fs)
    {
      this.rt = rt;
      this.fs = fs;
    }

    public Cf.from_code (int code)
    {
      this (get_five2_gpr (code), get_five3_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_cf (this);
    }

    public override string get_mnemonic ()
    {
      return "cfc1";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← FP_Control[FPR[$fs]]";
    }
  }

  public class Cop2.Cf : Instruction
  {
    public Register rt;
    public Register rd;

    public Cf (Register rt, Register rd)
    {
      this.rt = rt;
      this.rd = rd;
    }

    public Cf.from_code (int code)
    {
      this (get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop2_cf (this);
    }

    public override string get_mnemonic ()
    {
      return "cfc2";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← CP2CCR[Impl]";
    }
  }

  public class Clo : Instruction
  {
    public Register rs;
    public Register rt;
    public Register rd;

    public Clo (Register rs, Register rt, Register rd)
    {
      this.rs = rs;
      this.rt = rt;
      this.rd = rd;
    }

    public Clo.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_clo (this);
    }

    public override string get_mnemonic ()
    {
      return "clo";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← count_leading_ones GPR[$rs]";
    }
  }

  public class Clz : Instruction
  {
    public Register rs;
    public Register rt;
    public Register rd;

    public Clz (Register rs, Register rt, Register rd)
    {
      this.rs = rs;
      this.rt = rt;
      this.rd = rd;
    }

    public Clz.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_clz (this);
    }

    public override string get_mnemonic ()
    {
      return "clz";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← count_leading_zeros GPR[$rs]";
    }
  }

  public class Cop2.Co : Instruction
  {
    public int cofun;

    public Co (int cofun)
    {
      this.cofun = cofun;
    }

    public Co.from_code (int code)
    {
      this (code & 0x1FFFFFF);
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop2_co (this);
    }

    public override string get_mnemonic ()
    {
      return "cop2";
    }

    public override string? get_description ()
    {
      return @"CoprocessorOperation(2, cofun)";
    }
  }

  public class Cop1.Ct : Instruction
  {
    public Register rt;
    public FpuRegister fs;

    public Ct (Register rt, FpuRegister fs)
    {
      this.rt = rt;
      this.fs = fs;
    }

    public Ct.from_code (int code)
    {
      this (get_five2_gpr (code), get_five3_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_ct (this);
    }

    public override string get_mnemonic ()
    {
      return "ctc1";
    }

    public override string? get_description ()
    {
      return @"FP_Control[$fs] ← GPR[$rt]";
    }
  }

  public class Cop2.Ct : Instruction
  {
    public Register rt;
    public Register rd;

    public Ct (Register rt, Register rd)
    {
      this.rt = rt;
      this.rd = rd;
    }

    public Ct.from_code (int code)
    {
      this (get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop2_ct (this);
    }

    public override string get_mnemonic ()
    {
      return "ctc2";
    }

    public override string? get_description ()
    {
      return @"CP2CCR[Impl] ← GPR[$rt]";
    }
  }

  public class Cop1.Cvtd : Instruction
  {
    public Format fmt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Cvtd (Format fmt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Cvtd.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_cvtd (this);
    }

    public override string get_mnemonic ()
    {
      return @"cvt.d.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← convert_and_round(FPR[$fs])";
    }
  }

  public class Cop1.Cvtl : Instruction
  {
    public Format fmt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Cvtl (Format fmt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Cvtl.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_cvtl (this);
    }

    public override string get_mnemonic ()
    {
      return @"cvt.l.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← convert_and_round(FPR[$fs])";
    }
  }

  public class Cop1.Cvtps : Instruction
  {
    public FpuRegister ft;
    public FpuRegister fs;
    public FpuRegister fd;

    public Cvtps (FpuRegister ft, FpuRegister fs, FpuRegister fd)
    {
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
    }

    public Cvtps.from_code (int code)
    {
      this (get_five2_fpr (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_cvtps (this);
    }

    public override string get_mnemonic ()
    {
      return "cvt.ps.s";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← FPR[$fs]31..0 || FPR[$ft]31..0";
    }
  }

  public class Cop1.Cvts : Instruction
  {
    public Format fmt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Cvts (Format fmt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Cvts.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_cvts (this);
    }

    public override string get_mnemonic ()
    {
      return @"cvt.s.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← convert_and_round(GPR[$fs])";
    }
  }

  public class Cop1.Cvtspl : Instruction
  {
    public FpuRegister fs;
    public FpuRegister fd;

    public Cvtspl (FpuRegister fs, FpuRegister fd)
    {
      this.fs = fs;
      this.fd = fd;
    }

    public Cvtspl.from_code (int code)
    {
      this (get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_cvtspl (this);
    }

    public override string get_mnemonic ()
    {
      return "cvt.s.pl";
    }

    public override string? get_description ()
    {
      return @"GPR[$fd] ← convert_and_round(GPR[$fs])";
    }
  }

  public class Cop1.Cvtspu : Instruction
  {
    public FpuRegister fs;
    public FpuRegister fd;

    public Cvtspu (FpuRegister fs, FpuRegister fd)
    {
      this.fs = fs;
      this.fd = fd;
    }

    public Cvtspu.from_code (int code)
    {
      this (get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_cvtspu (this);
    }

    public override string get_mnemonic ()
    {
      return "cvt.s.pu";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← convert_and_round(FPR[$fs])";
    }
  }

  public class Cop1.Cvtw : Instruction
  {
    public Format fmt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Cvtw (Format fmt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Cvtw.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_cvtw (this);
    }

    public override string get_mnemonic ()
    {
      return @"cvt.w.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← convert_and_round(FPR[$fs])";
    }
  }

  public class Cop0.Deret : Instruction
  {
    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_deret (this);
    }

    public override string get_mnemonic ()
    {
      return "deret";
    }

    public override string? get_description ()
    {
      return "return from a debug exception";
    }
  }

  public class Div : Instruction
  {
    public Register rs;
    public Register rt;

    public Div (Register rs, Register rt)
      {
        this.rs = rs;
        this.rt = rt;
      }

    public Div.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_div (this);
    }

    public override string get_mnemonic ()
    {
      return "div";
    }

    public override string? get_description ()
    {
      return @"(HI, LO) ← GPR[$rs] / GPR[$rt]";
    }
  }

  public class Cop1.Div : Instruction
  {
    public Format fmt;
    public FpuRegister ft;
    public FpuRegister fs;
    public FpuRegister fd;

    public Div (Format fmt, FpuRegister ft, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
    }

    public Div.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five2_fpr (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_div (this);
    }

    public override string get_mnemonic ()
    {
      return @"div.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← FPR[$fs] / FPR[$ft]";
    }
  }

  public class Divu : Instruction
  {
    public Register rs;
    public Register rt;

    public Divu (Register rs, Register rt)
    {
      this.rs = rs;
      this.rt = rt;
    }

    public Divu.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_divu (this);
    }

    public override string get_mnemonic ()
    {
      return "divu";
    }

    public override string? get_description ()
    {
      return @"(HI, LO) ← GPR[$rs] / GPR[$rt]";
    }
  }

  public class Cop0.Eret : Instruction
  {
    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_eret (this);
    }

    public override string get_mnemonic ()
    {
      return "eret";
    }

    public override string? get_description ()
    {
      return "return from interrupt, exception, or error trap";
    }
  }

  public class Ext : Instruction
  {
    public Register rs;
    public Register rt;
    public uint8 msbd;
    public uint8 lsb;

    public Ext (Register rs, Register rt, uint8 msbd, uint8 lsb)
      {
        this.rs = rs;
        this.rt = rt;
        this.msbd = msbd;
        this.lsb = lsb;
      }

    public Ext.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_ext (this);
    }

    public override string get_mnemonic ()
    {
      return "ext";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← ExtractField(GPR[$rs], $msbd, $lsb)";
    }
  }

  public class Cop1.Floorl : Instruction
  {
    public Format fmt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Floorl (Format fmt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Floorl.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_floorl (this);
    }

    public override string get_mnemonic ()
    {
      return @"floor.l.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← convert_and_round(FPR[$fs])";
    }
  }

  public class Cop1.Floorw : Instruction
  {
    public Format fmt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Floorw (Format fmt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Floorw.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_floorw (this);
    }

    public override string get_mnemonic ()
    {
      return @"floor.w.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← convert_and_round(FPR[$fs])";
    }
  }

  public class Ins : Instruction
  {
    public Register rs;
    public Register rt;
    public uint8 msb;
    public uint8 lsb;

    public Ins (Register rs, Register rt, uint8 msb, uint8 lsb)
      {
        this.rs = rs;
        this.rt = rt;
        this.msb = msb;
        this.lsb = lsb;
      }

    public Ins.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3 (code), get_five4 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_ins (this);
    }

    public override string get_mnemonic ()
    {
      return "ins";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← InsertField(GPR[$rt], GPR[$rs], $msb, $lsb)";
    }
  }

  public class Jump : Instruction
  {
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

    public override string get_mnemonic ()
    {
      return "j";
    }

    public override string? get_description ()
    {
      return "branch within the current 256 MB-aligned region";
    }
  }

  public class Jal : Instruction
  {
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

    public override string get_mnemonic ()
    {
      return "jal";
    }

    public override string? get_description ()
    {
      return "execute a procedure call within the current 256 MB-aligned region";
    }
  }

  public class Jalr : Instruction
  {
    public Register rs;
    public Register rd;
    public uint8 hint;

    public Jalr (Register rs, Register rd, uint8 hint)
      {
        this.rs = rs;
        this.rd = rd;
        this.hint = hint;
      }

    public Jalr.from_code (int code)
      {
        this (get_five1_gpr (code), get_five3_gpr (code), get_five4 (code));
      }

    public bool has_hint ()
    {
      return hint >> 4 == 1;
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_jalr (this);
    }

    public override string get_mnemonic ()
    {
      if (has_hint ())
        return "jalr.hb";
      return "jalr";
    }

    public override string? get_description ()
    {
      if (has_hint ())
        return @"GPR[$rd] ← return_addr, PC ← GPR[$rs], clear execution and instruction hazards";
      return @"GPR[$rd] ← return_addr, PC ← GPR[$rs]";
    }
  }

  public class Jr : Instruction
  {
    public Register rs;
    public uint8 hint;

    public Jr (Register rs, uint8 hint)
      {
        this.rs = rs;
        this.hint = hint;
      }

    public Jr.from_code (int code)
      {
        this (get_five1_gpr (code), get_five4 (code));
      }

    public bool has_hint ()
    {
      return hint >> 4 == 1;
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_jr (this);
    }

    public override string get_mnemonic ()
    {
      if (has_hint ())
        return "jr.hb";
      return "jr";
    }

    public override string? get_description ()
    {
      if (has_hint ())
        return @"PC ← GPR[$rs], clear execution and instruction hazards";
      return @"PC ← GPR[$rs]";
    }
  }

  public class Lb : Instruction
  {
    public Register @base;
    public Register rt;
    public uint16 offset;

    public Lb (Register @base, Register rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Lb.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_lb (this);
    }

    public override string get_mnemonic ()
    {
      return "lb";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← memory[GPR[$base] + $offset]";
    }
  }

  public class Lbu : Instruction
  {
    public Register @base;
    public Register rt;
    public uint16 offset;

    public Lbu (Register @base, Register rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Lbu.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_lbu (this);
    }

    public override string get_mnemonic ()
    {
      return "lbu";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← memory[GPR[$base] + $offset]";
    }
  }

  public class Ldc1 : Instruction
  {
    public Register @base;
    public FpuRegister ft;
    public uint16 offset;

    public Ldc1 (Register @base, FpuRegister ft, uint16 offset)
      {
        this.@base = @base;
        this.ft = ft;
        this.offset = offset;
      }

    public Ldc1.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_fpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_ldc1 (this);
    }

    public override string get_mnemonic ()
    {
      return "ldc1";
    }

    public override string? get_description ()
    {
      return @"FPR[$ft] ← memory[GPR[$base] + $offset]";
    }
  }

  public class Ldc2 : Instruction
  {
    public Register @base;
    public Register rt;
    public uint16 offset;

    public Ldc2 (Register @base, Register rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Ldc2.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_ldc2 (this);
    }

    public override string get_mnemonic ()
    {
      return "ldc2";
    }

    public override string? get_description ()
    {
      return @"CPR[2,$rt,0] ← memory[GPR[$base] + $offset]";
    }
  }

  public class Cop1x.Ldxc1 : Instruction
  {
    public Register @base;
    public uint8 index;
    public FpuRegister fd;

    public Ldxc1 (Register @base, uint8 index, FpuRegister fd)
      {
        this.@base = @base;
        this.index = index;
        this.fd = fd;
      }

    public Ldxc1.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2 (code), get_five3_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_ldxc1 (this);
    }

    public override string get_mnemonic ()
    {
      return "ldxc1";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← memory[GPR[$base] + GPR[$index]]";
    }
  }

  public class Lh : Instruction
  {
    public Register @base;
    public Register rt;
    public uint16 offset;

    public Lh (Register @base, Register rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Lh.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_lh (this);
    }

    public override string get_mnemonic ()
    {
      return "lh";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← memory[GPR[$base] + $offset]";
    }
  }

  public class Lhu : Instruction
  {
    public Register @base;
    public Register rt;
    public uint16 offset;

    public Lhu (Register @base, Register rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Lhu.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_lhu (this);
    }

    public override string get_mnemonic ()
    {
      return "lhu";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← memory[GPR[$base] + $offset]";
    }
  }

  public class Ll : Instruction
  {
    public Register @base;
    public Register rt;
    public uint16 offset;

    public Ll (Register @base, Register rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Ll.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_ll (this);
    }

    public override string get_mnemonic ()
    {
      return "ll";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← memory[GPR[$base] + $offset]";
    }
  }

  public class Lui : Instruction
  {
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

    public override string get_mnemonic ()
    {
      return "lui";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← $immediate || 0^16";
    }
  }

  public class Cop1x.Luxc1 : Instruction
  {
    public Register @base;
    public uint8 index;
    public FpuRegister fd;

    public Luxc1 (Register @base, uint8 index, FpuRegister fd)
      {
        this.@base = @base;
        this.index = index;
        this.fd = fd;
      }

    public Luxc1.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2 (code), get_five3_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_luxc1 (this);
    }

    public override string get_mnemonic ()
    {
      return "luxc1";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← memory[(GPR[$base] + GPR[$index])PSIZE-1..3]";
    }
  }

  public class Lw : Instruction
  {
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

    public override string get_mnemonic ()
    {
      return "lw";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← memory[GPR[$base] + $offset]";
    }
  }

  public class Lwc1 : Instruction
  {
    public Register @base;
    public FpuRegister ft;
    public uint16 offset;

    public Lwc1 (Register @base, FpuRegister ft, uint16 offset)
      {
        this.@base = @base;
        this.ft = ft;
        this.offset = offset;
      }

    public Lwc1.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_fpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_lwc1 (this);
    }

    public override string get_mnemonic ()
    {
      return "lwc1";
    }

    public override string? get_description ()
    {
      return @"FPR[$ft] ← memory[GPR[$base] + $offset]";
    }
  }

  public class Lwc2 : Instruction
  {
    public Register @base;
    public Register rt;
    public uint16 offset;

    public Lwc2 (Register @base, Register rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Lwc2.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_lwc2 (this);
    }

    public override string get_mnemonic ()
    {
      return "lwc2";
    }

    public override string? get_description ()
    {
      return @"CPR[2,$rt,0] ← memory[GPR[$base] + $offset]";
    }
  }

  public class Lwl : Instruction
  {
    public Register @base;
    public Register rt;
    public uint16 offset;

    public Lwl (Register @base, Register rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Lwl.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_lwl (this);
    }

    public override string get_mnemonic ()
    {
      return "lwl";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← GPR[$rt] MERGE memory[GPR[$base] + $offset]";
    }
  }

  public class Lwr : Instruction
  {
    public Register @base;
    public Register rt;
    public uint16 offset;

    public Lwr (Register @base, Register rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Lwr.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_lwr (this);
    }

    public override string get_mnemonic ()
    {
      return "lwr";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← GPR[$rt] MERGE memory[GPR[$base] + $offset]";
    }
  }

  public class Cop1x.Lwxc1 : Instruction
  {
    public Register @base;
    public uint8 index;
    public FpuRegister fd;

    public Lwxc1 (Register @base, uint8 index, FpuRegister fd)
      {
        this.@base = @base;
        this.index = index;
        this.fd = fd;
      }

    public Lwxc1.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2 (code), get_five3_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_lwxc1 (this);
    }

    public override string get_mnemonic ()
    {
      return "lwxc1";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← memory[GPR[$base] + GPR[$index]]";
    }
  }

  public class Madd : Instruction
  {
    public Register rs;
    public Register rt;

    public Madd (Register rs, Register rt)
    {
      this.rs = rs;
      this.rt = rt;
    }

    public Madd.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_madd (this);
    }

    public override string get_mnemonic ()
    {
      return "madd";
    }

    public override string? get_description ()
    {
      return @"(HI,LO) ← (HI,LO) + (GPR[$rs] × GPR[$rt])";
    }
  }

  public class Cop1x.Madd : Instruction
  {
    public FpuRegister fr;
    public FpuRegister ft;
    public FpuRegister fs;
    public FpuRegister fd;
    public Format fmt;

    public Madd (FpuRegister fr, FpuRegister ft, FpuRegister fs, FpuRegister fd, Format fmt)
    {
      this.fr = fr;
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
      this.fmt = fmt;
    }

    public Madd.from_code (int code)
    {
      this (get_five1_fpr (code), get_five2_fpr (code), get_five3_fpr (code), get_five4_fpr (code), (Format)get_three (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_madd (this);
    }

    public override string get_mnemonic ()
    {
      return @"madd.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← (FPR[$fs] × FPR[$ft]) + FPR[$fr]";
    }
  }

  public class Maddu : Instruction
  {
    public Register rs;
    public Register rt;

    public Maddu (Register rs, Register rt)
    {
      this.rs = rs;
      this.rt = rt;
    }

    public Maddu.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_maddu (this);
    }

    public override string get_mnemonic ()
    {
      return "maddu";
    }

    public override string? get_description ()
    {
      return @"(HI,LO) ← (HI,LO) + (GPR[$rs] × GPR[$rt])";
    }
  }

  public class Cop0.Mf : Instruction
  {
    public Register rt;
    public Register rd;
    public uint8 sel;

    public Mf (Register rt, Register rd, uint8 sel)
    {
      this.rt = rt;
      this.rd = rd;
      this.sel = sel;
    }

    public Mf.from_code (int code)
    {
      this (get_five2_gpr (code), get_five3_gpr (code), get_three (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_mf (this);
    }

    public override string get_mnemonic ()
    {
      return "mfc0";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← CPR[0,$rd,$sel]";
    }
  }

  public class Cop1.Mf : Instruction
  {
    public Register rt;
    public FpuRegister fs;

    public Mf (Register rt, FpuRegister fs)
    {
      this.rt = rt;
      this.fs = fs;
    }

    public Mf.from_code (int code)
    {
      this (get_five2_gpr (code), get_five3_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_mf (this);
    }

    public override string get_mnemonic ()
    {
      return "mfc1";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← FPR[$fs]";
    }
  }

  public class Cop2.Mf : Instruction
  {
    public Register rt;
    public uint16 impl;

    public Mf (Register rt, uint16 impl)
    {
      this.rt = rt;
      this.impl = impl;
    }

    public Mf.from_code (int code)
    {
      this (get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop2_mf (this);
    }

    public override string get_mnemonic ()
    {
      return "mfc2";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← CP2CPR[$impl]";
    }
  }

  public class Cop1.Mfh : Instruction
  {
    public Register rt;
    public FpuRegister fs;

    public Mfh (Register rt, FpuRegister fs)
    {
      this.rt = rt;
      this.fs = fs;
    }

    public Mfh.from_code (int code)
    {
      this (get_five2_gpr (code), get_five3_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_mfh (this);
    }

    public override string get_mnemonic ()
    {
      return "mfhc1";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← FPR[$fs]63..32";
    }
  }

  public class Cop2.Mfh : Instruction
  {
    public Register rt;
    public uint16 impl;

    public Mfh (Register rt, uint16 impl)
    {
      this.rt = rt;
      this.impl = impl;
    }

    public Mfh.from_code (int code)
    {
      this (get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop2_mfh (this);
    }

    public override string get_mnemonic ()
    {
      return "mfhc2";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← CP2CPR[$impl]63..32";
    }
  }

  public class Mfhi : Instruction
  {
    public Register rd;

    public Mfhi (Register rd)
      {
        this.rd = rd;
      }

    public Mfhi.from_code (int code)
    {
      this (get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_mfhi (this);
    }

    public override string get_mnemonic ()
    {
      return "mfhi";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← HI";
    }
  }

  public class Mflo : Instruction
  {
    public Register rd;

    public Mflo (Register rd)
      {
        this.rd = rd;
      }

    public Mflo.from_code (int code)
    {
      this (get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_mflo (this);
    }

    public override string get_mnemonic ()
    {
      return "mflo";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← LO";
    }
  }

  public class Cop0.Mfmc0 : Instruction
  {
    public Register rt;
    public bool sc;

    public Mfmc0 (Register rt, bool sc)
    {
      this.rt = rt;
      this.sc = sc;
    }

    public Mfmc0.from_code (int code)
    {
      this (get_five2_gpr (code), (bool)(code & 0x20));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_mfmc0 (this);
    }

    public override string get_mnemonic ()
    {
      if (!sc)
        return "di";
      else
        return "ei";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← Status; StatusIE ← $sc";
    }
  }

  public class Cop1.Mov : Instruction
  {
    public Format fmt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Mov (Format fmt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Mov.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_mov (this);
    }

    public override string get_mnemonic ()
    {
      return @"mov.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← FPR[$fs]";
    }
  }

  public class Movci : Instruction
  {
    public Register rs;
    public uint8 cc;
    public bool test_true;
    public Register rd;

    public Movci (Register rs, uint8 cc, bool test_true, Register rd)
    {
      this.rs = rs;
      this.cc = cc;
      this.test_true = test_true;
      this.rd = rd;
    }

    public Movci.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2 (code) >> 2, (code & 0x10000) == 1, get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_movci (this);
    }

    public override string get_mnemonic ()
    {
      if (test_true)
        return "movt";
      else
        return "movf";
    }

    public override string? get_description ()
    {
      return @"if FPConditionCode($cc) = $test_true then GPR[$rd] ← GPR[$rs]";
    }
  }

  public class Cop1.Movcf : Instruction
  {
    public Format fmt;
    public uint8 cc;
    public bool test_true;
    public FpuRegister fs;
    public FpuRegister fd;

    public Movcf (Format fmt, uint8 cc, bool test_true, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.cc = cc;
      this.test_true = test_true;
      this.fs = fs;
      this.fd = fd;
    }

    public Movcf.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five2 (code) >> 2, (code & 0x10000) == 1, get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_movcf (this);
    }

    public override string get_mnemonic ()
    {
      if (test_true)
        return @"movt.$fmt";
      else
        return @"movf.$fmt";
    }

    public override string? get_description ()
    {
      return @"if FPConditionCode($cc) = $test_true then FPR[$fd] ← FPR[$fs]";
    }
  }

  public class Movn : Instruction
  {
    public Register rs;
    public Register rt;
    public Register rd;

    public Movn (Register rs, Register rt, Register rd)
    {
      this.rs = rs;
      this.rt = rt;
      this.rd = rd;
    }

    public Movn.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_movn (this);
    }

    public override string get_mnemonic ()
    {
      return "movn";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rt] ≠ 0 then GPR[$rd] ← GPR[$rs]";
    }
  }

  public class Cop1.Movn : Instruction
  {
    public Format fmt;
    public Register rt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Movn (Format fmt, Register rt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.rt = rt;
      this.fs = fs;
      this.fd = fd;
    }

    public Movn.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five2_gpr (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_movn (this);
    }

    public override string get_mnemonic ()
    {
      return @"movn.$fmt";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rt] ≠ 0 then FPR[$fd] ← FPR[$fs]";
    }
  }

  public class Movz : Instruction
  {
    public Register rs;
    public Register rt;
    public Register rd;

    public Movz (Register rs, Register rt, Register rd)
    {
      this.rs = rs;
      this.rt = rt;
      this.rd = rd;
    }

    public Movz.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_movz (this);
    }

    public override string get_mnemonic ()
    {
      return "movz";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rt] = 0 then GPR[$rd] ← GPR[$rs]";
    }
  }

  public class Cop1.Movz : Instruction
  {
    public Format fmt;
    public Register rt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Movz (Format fmt, Register rt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.rt = rt;
      this.fs = fs;
      this.fd = fd;
    }

    public Movz.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five2_gpr (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_movz (this);
    }

    public override string get_mnemonic ()
    {
      return @"movz.$fmt";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rt] = 0 then FPR[$fd] ← FPR[$fs]";
    }
  }

  public class Msub : Instruction
  {
    public Register rs;
    public Register rt;

    public Msub (Register rs, Register rt)
    {
      this.rs = rs;
      this.rt = rt;
    }

    public Msub.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_msub (this);
    }

    public override string get_mnemonic ()
    {
      return "msub";
    }

    public override string? get_description ()
    {
      return @"(HI,LO) ← (HI,LO) - (GPR[$rs] × GPR[$rt])";
    }
  }

  public class Cop1x.Msub : Instruction
  {
    public FpuRegister fr;
    public FpuRegister ft;
    public FpuRegister fs;
    public FpuRegister fd;
    public Format fmt;

    public Msub (FpuRegister fr, FpuRegister ft, FpuRegister fs, FpuRegister fd, Format fmt)
    {
      this.fr = fr;
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
      this.fmt = fmt;
    }

    public Msub.from_code (int code)
    {
      this (get_five1_fpr (code), get_five2_fpr (code), get_five3_fpr (code), get_five4_fpr (code), (Format)get_three (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_msub (this);
    }

    public override string get_mnemonic ()
    {
      return @"msub.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← (FPR[$fs] × FPR[$ft]) − FPR[$fr]";
    }
  }

  public class Msubu : Instruction
  {
    public Register rs;
    public Register rt;

    public Msubu (Register rs, Register rt)
    {
      this.rs = rs;
      this.rt = rt;
    }

    public Msubu.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_msubu (this);
    }

    public override string get_mnemonic ()
    {
      return "msubu";
    }

    public override string? get_description ()
    {
      return @"(HI,LO) ← (HI,LO) - (GPR[$rs] × GPR[$rt])";
    }
  }

  public class Cop0.Mt : Instruction
  {
    public Register rt;
    public Register rd;
    public uint8 sel;

    public Mt (Register rt, Register rd, uint8 sel)
    {
      this.rt = rt;
      this.rd = rd;
      this.sel = sel;
    }

    public Mt.from_code (int code)
    {
      this (get_five2_gpr (code), get_five3_gpr (code), get_three (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_mt (this);
    }

    public override string get_mnemonic ()
    {
      return "mtc0";
    }

    public override string? get_description ()
    {
      return @"CPR[0, $rd, $sel] ← GPR[$rt]";
    }
  }

  public class Cop1.Mt : Instruction
  {
    public Register rt;
    public FpuRegister fs;

    public Mt (Register rt, FpuRegister fs)
    {
      this.rt = rt;
      this.fs = fs;
    }

    public Mt.from_code (int code)
    {
      this (get_five2_gpr (code), get_five3_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_mt (this);
    }

    public override string get_mnemonic ()
    {
      return "mtc1";
    }

    public override string? get_description ()
    {
      return @"FPR[$fs] ← GPR[$rt]";
    }
  }

  public class Cop2.Mt : Instruction
  {
    public Register rt;
    public uint16 impl;

    public Mt (Register rt, uint16 impl)
    {
      this.rt = rt;
      this.impl = impl;
    }

    public Mt.from_code (int code)
    {
      this (get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop2_mt (this);
    }

    public override string get_mnemonic ()
    {
      return "mtc2";
    }

    public override string? get_description ()
    {
      return @"CP2CPR[$impl] ← GPR[$rt]";
    }
  }

  public class Cop1.Mth : Instruction
  {
    public Register rt;
    public FpuRegister fs;

    public Mth (Register rt, FpuRegister fs)
    {
      this.rt = rt;
      this.fs = fs;
    }

    public Mth.from_code (int code)
    {
      this (get_five2_gpr (code), get_five3_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_mth (this);
    }

    public override string get_mnemonic ()
    {
      return "mthc1";
    }

    public override string? get_description ()
    {
      return @"FPR[$fs]63..32 ← GPR[$rt]";
    }
  }

  public class Cop2.Mth : Instruction
  {
    public Register rt;
    public uint16 impl;

    public Mth (Register rt, uint16 impl)
    {
      this.rt = rt;
      this.impl = impl;
    }

    public Mth.from_code (int code)
    {
      this (get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop2_mth (this);
    }

    public override string get_mnemonic ()
    {
      return "mthc2";
    }

    public override string? get_description ()
    {
      return @"CP2CPR[$impl]63..32 ← GPR[$rt]";
    }
  }

  public class Mthi : Instruction
  {
    public Register rs;

    public Mthi (Register rs)
      {
        this.rs = rs;
      }

    public Mthi.from_code (int code)
    {
      this (get_five1_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_mthi (this);
    }

    public override string get_mnemonic ()
    {
      return "mthi";
    }

    public override string? get_description ()
    {
      return @"HI ← GPR[$rs]";
    }
  }

  public class Mtlo : Instruction
  {
    public Register rs;

    public Mtlo (Register rs)
      {
        this.rs = rs;
      }

    public Mtlo.from_code (int code)
    {
      this (get_five1_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_mtlo (this);
    }

    public override string get_mnemonic ()
    {
      return "mtlo";
    }

    public override string? get_description ()
    {
      return @"LO ← GPR[$rs]";
    }
  }

  public class Mul : Instruction
  {
    public Register rs;
    public Register rt;
    public Register rd;

    public Mul (Register rs, Register rt, Register rd)
    {
      this.rs = rs;
      this.rt = rt;
      this.rd = rd;
    }

    public Mul.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_mul (this);
    }

    public override string get_mnemonic ()
    {
      return "mul";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← GPR[$rs] × GPR[$rt]";
    }
  }

  public class Cop1.Mul : Instruction
  {
    public Format fmt;
    public FpuRegister ft;
    public FpuRegister fs;
    public FpuRegister fd;

    public Mul (Format fmt, FpuRegister ft, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
    }

    public Mul.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five2_fpr (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_mul (this);
    }

    public override string get_mnemonic ()
    {
      return @"mul.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← FPR[$fs] × FPR[$ft]";
    }
  }

  public class Mult : Instruction
  {
    public Register rs;
    public Register rt;

    public Mult (Register rs, Register rt)
      {
        this.rs = rs;
        this.rt = rt;
      }

    public Mult.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_mult (this);
    }

    public override string get_mnemonic ()
    {
      return "mult";
    }

    public override string? get_description ()
    {
      return @"(HI, LO) ← GPR[$rs] × GPR[$rt]";
    }
  }

  public class Multu : Instruction
  {
    public Register rs;
    public Register rt;

    public Multu (Register rs, Register rt)
      {
        this.rs = rs;
        this.rt = rt;
      }

    public Multu.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_multu (this);
    }

    public override string get_mnemonic ()
    {
      return "multu";
    }

    public override string? get_description ()
    {
      return @"(HI, LO) ← GPR[$rs] × GPR[$rt]";
    }
  }

  public class Cop1.Neg : Instruction
  {
    public Format fmt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Neg (Format fmt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Neg.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_neg (this);
    }

    public override string get_mnemonic ()
    {
      return @"neg.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← −FPR[$fs]";
    }
  }

  public class Cop1x.Nmadd : Instruction
  {
    public FpuRegister fr;
    public FpuRegister ft;
    public FpuRegister fs;
    public FpuRegister fd;
    public Format fmt;

    public Nmadd (FpuRegister fr, FpuRegister ft, FpuRegister fs, FpuRegister fd, Format fmt)
    {
      this.fr = fr;
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
      this.fmt = fmt;
    }

    public Nmadd.from_code (int code)
    {
      this (get_five1_fpr (code), get_five2_fpr (code), get_five3_fpr (code), get_five4_fpr (code), (Format)get_three (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_nmadd (this);
    }

    public override string get_mnemonic ()
    {
      return @"nmadd.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← − ((FPR[$fs] × FPR[$ft]) + FPR[$fr])";
    }
  }

  public class Cop1x.Nmsub : Instruction
  {
    public FpuRegister fr;
    public FpuRegister ft;
    public FpuRegister fs;
    public FpuRegister fd;
    public Format fmt;

    public Nmsub (FpuRegister fr, FpuRegister ft, FpuRegister fs, FpuRegister fd, Format fmt)
    {
      this.fr = fr;
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
      this.fmt = fmt;
    }

    public Nmsub.from_code (int code)
    {
      this (get_five1_fpr (code), get_five2_fpr (code), get_five3_fpr (code), get_five4_fpr (code), (Format)get_three (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_nmsub (this);
    }

    public override string get_mnemonic ()
    {
      return @"nmsub.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← - ((FPR[$fs] × FPR[$ft]) - FPR[$fr])";
    }
  }

  public class Nor : Instruction
  {
    public Register rs;
    public Register rt;
    public Register rd;

    public Nor (Register rs, Register rt, Register rd)
    {
      this.rs = rs;
      this.rt = rt;
      this.rd = rd;
    }

    public Nor.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_nor (this);
    }

    public override string get_mnemonic ()
    {
      return "nor";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← GPR[$rs] NOR GPR[$rt]";
    }
  }

  public class Or : Instruction
  {
    public Register rs;
    public Register rt;
    public Register rd;

    public Or (Register rs, Register rt, Register rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public Or.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_or (this);
    }

    public override string get_mnemonic ()
    {
      return "or";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← GPR[$rs] or GPR[$rt]";
    }
  }

  public class Ori : Instruction
  {
    public Register rs;
    public Register rt;
    public int16 immediate;

    public Ori (Register rs, Register rt, int16 immediate)
    {
      this.rs = rs;
      this.rt = rt;
      this.immediate = immediate;
    }

    public Ori.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), (int16)get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_ori (this);
    }

    public override string get_mnemonic ()
    {
      return "ori";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← GPR[$rs] or $immediate";
    }
  }

  public class Cop1.Pll : Instruction
  {
    public FpuRegister ft;
    public FpuRegister fs;
    public FpuRegister fd;

    public Pll (FpuRegister ft, FpuRegister fs, FpuRegister fd)
    {
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
    }

    public Pll.from_code (int code)
    {
      this (get_five2_fpr (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_pll (this);
    }

    public override string get_mnemonic ()
    {
      return "pll.ps";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← lower(FPR[$fs]) || lower(FPR[$ft])";
    }
  }

  public class Cop1.Plu : Instruction
  {
    public FpuRegister ft;
    public FpuRegister fs;
    public FpuRegister fd;

    public Plu (FpuRegister ft, FpuRegister fs, FpuRegister fd)
    {
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
    }

    public Plu.from_code (int code)
    {
      this (get_five2_fpr (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_plu (this);
    }

    public override string get_mnemonic ()
    {
      return "plu.ps";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← lower(FPR[$fs]) || upper(FPR[$ft])";
    }
  }

  public class Pref : Instruction
  {
    public Register @base;
    public uint8 hint;
    public uint16 offset;

    public Pref (Register @base, uint8 hint, uint16 offset)
      {
        this.@base = @base;
        this.hint = hint;
        this.offset = offset;
      }

    public Pref.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2 (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_pref (this);
    }

    public override string get_mnemonic ()
    {
      return "pref";
    }

    public override string? get_description ()
    {
      return @"prefetch_memory(GPR[$base] + $offset)";
    }
  }

  public class Cop1x.Prefx : Instruction
  {
    public Register @base;
    public uint8 index;
    public uint8 hint;

    public Prefx (Register @base, uint8 index, uint8 hint)
    {
      this.@base = @base;
      this.index = index;
      this.hint = hint;
    }

    public Prefx.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_prefx (this);
    }

    public override string get_mnemonic ()
    {
      return "prefx";
    }

    public override string? get_description ()
    {
      return @"prefetch_memory[GPR[$base] + GPR[$index]]";
    }
  }

  public class Cop1.Pul : Instruction
  {
    public FpuRegister ft;
    public FpuRegister fs;
    public FpuRegister fd;

    public Pul (FpuRegister ft, FpuRegister fs, FpuRegister fd)
    {
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
    }

    public Pul.from_code (int code)
    {
      this (get_five2_fpr (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_pul (this);
    }

    public override string get_mnemonic ()
    {
      return "pul.ps";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← upper(FPR[$fs]) || lower(FPR[$ft])";
    }
  }

  public class Cop1.Puu : Instruction
  {
    public FpuRegister ft;
    public FpuRegister fs;
    public FpuRegister fd;

    public Puu (FpuRegister ft, FpuRegister fs, FpuRegister fd)
    {
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
    }

    public Puu.from_code (int code)
    {
      this (get_five2_fpr (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_puu (this);
    }

    public override string get_mnemonic ()
    {
      return "puu.ps";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← upper(FPR[$fs]) || upper(FPR[$ft])";
    }
  }

  public class Rdhwr : Instruction
  {
    public Register rt;
    public Register rd;

    public Rdhwr (Register rt, Register rd)
    {
      this.rt = rt;
      this.rd = rd;
    }

    public Rdhwr.from_code (int code)
    {
      this (get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_rdhwr (this);
    }

    public override string get_mnemonic ()
    {
      return "rdhwr";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← HWR[$rd]";
    }
  }

  public class Cop0.Rdpgpr : Instruction
  {
    public Register rt;
    public Register rd;

    public Rdpgpr (Register rt, Register rd)
    {
      this.rt = rt;
      this.rd = rd;
    }

    public Rdpgpr.from_code (int code)
    {
      this (get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_rdpgpr (this);
    }

    public override string get_mnemonic ()
    {
      return "rdpgpr";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← SGPR[SRSCtlPSS, $rt]";
    }
  }

  public class Cop1.Recip : Instruction
  {
    public Format fmt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Recip (Format fmt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Recip.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_recip (this);
    }

    public override string get_mnemonic ()
    {
      return @"recip.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← 1.0 / FPR[$fs]";
    }
  }

  public class Cop1.Roundl : Instruction
  {
    public Format fmt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Roundl (Format fmt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Roundl.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_roundl (this);
    }

    public override string get_mnemonic ()
    {
      return @"round.l.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← convert_and_round(FPR[$fs])";
    }
  }

  public class Cop1.Roundw : Instruction
  {
    public Format fmt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Roundw (Format fmt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Roundw.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_roundw (this);
    }

    public override string get_mnemonic ()
    {
      return @"round.w.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← convert_and_round(FPR[$fs])";
    }
  }

  public class Cop1.Rsqrt : Instruction
  {
    public Format fmt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Rsqrt (Format fmt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Rsqrt.from_code (int code)
    {
      this ((Format)(Format)get_five1 (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_rsqrt (this);
    }

    public override string get_mnemonic ()
    {
      return @"rsqrt.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← 1.0 / sqrt(FPR[$fs])";
    }
  }

  public class Sb : Instruction
  {
    public Register @base;
    public Register rt;
    public uint16 offset;

    public Sb (Register @base, Register rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Sb.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sb (this);
    }

    public override string get_mnemonic ()
    {
      return "sb";
    }

    public override string? get_description ()
    {
      return @"memory[GPR[$base] + $offset] ← GPR[$rt]";
    }
  }

  public class Sc : Instruction
  {
    public Register @base;
    public Register rt;
    public uint16 offset;

    public Sc (Register @base, Register rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Sc.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sc (this);
    }

    public override string get_mnemonic ()
    {
      return "sc";
    }

    public override string? get_description ()
    {
      return @"if atomic_update then memory[GPR[$base] + $offset] ← GPR[$rt], GPR[$rt] ← 1 else GPR[$rt] ← 0";
    }
  }

  public class Sdbbp : Instruction
  {
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

    public override string get_mnemonic ()
    {
      return "sdbbp";
    }

    public override string? get_description ()
    {
      return @"debug breakpoint";
    }
  }

  public class Sdc1 : Instruction
  {
    public Register @base;
    public FpuRegister ft;
    public uint16 offset;

    public Sdc1 (Register @base, FpuRegister ft, uint16 offset)
      {
        this.@base = @base;
        this.ft = ft;
        this.offset = offset;
      }

    public Sdc1.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_fpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sdc1 (this);
    }

    public override string get_mnemonic ()
    {
      return "sdc1";
    }

    public override string? get_description ()
    {
      return @"memory[GPR[$base] + $offset] ←FPR[$ft]";
    }
  }

  public class Sdc2 : Instruction
  {
    public Register @base;
    public Register rt;
    public uint16 offset;

    public Sdc2 (Register @base, Register rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Sdc2.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sdc2 (this);
    }

    public override string get_mnemonic ()
    {
      return "sdc2";
    }

    public override string? get_description ()
    {
      return @"memory[GPR[$base] + $offset] ← CPR[2,$rt,0]";
    }
  }

  public class Cop1x.Sdxc1 : Instruction
  {
    public Register @base;
    public uint8 index;
    public FpuRegister fs;

    public Sdxc1 (Register @base, uint8 index, FpuRegister fs)
      {
        this.@base = @base;
        this.index = index;
        this.fs = fs;
      }

    public Sdxc1.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2 (code), get_five3_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_sdxc1 (this);
    }

    public override string get_mnemonic ()
    {
      return "sdxc1";
    }

    public override string? get_description ()
    {
      return @"memory[GPR[$base] + GPR[$index]] ← FPR[$fs]";
    }
  }

  public class Seb : Instruction
  {
    public Register rt;
    public Register rd;

    public Seb (Register rt, Register rd)
      {
        this.rt = rt;
        this.rd = rd;
      }

    public Seb.from_code (int code)
    {
      this (get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_seb (this);
    }

    public override string get_mnemonic ()
    {
      return "seb";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← SignExtend(GPR[$rt]7..0)";
    }
  }

  public class Seh : Instruction
  {
    public Register rt;
    public Register rd;

    public Seh (Register rt, Register rd)
      {
        this.rt = rt;
        this.rd = rd;
      }

    public Seh.from_code (int code)
    {
      this (get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_seh (this);
    }

    public override string get_mnemonic ()
    {
      return "seh";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← SignExtend(GPR[$rt]15..0)";
    }
  }

  public class Sh : Instruction
  {
    public Register @base;
    public Register rt;
    public uint16 offset;

    public Sh (Register @base, Register rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Sh.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sh (this);
    }

    public override string get_mnemonic ()
    {
      return "sh";
    }

    public override string? get_description ()
    {
      return @"memory[GPR[$base] + $offset] ← GPR[$rt]";
    }
  }

  public class Sll : Instruction
  {
    public Register rt;
    public Register rd;
    public uint8 sa;

    public Sll (Register rt, Register rd, uint8 sa)
      {
        this.rt = rt;
        this.rd = rd;
        this.sa = sa;
      }

    public Sll.from_code (int code)
      {
        this (get_five2_gpr (code), get_five3_gpr (code), get_five4_gpr (code));
      }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sll (this);
    }

    public bool is_nop ()
    {
      return rt == 0 && rd == 0 && sa == 0;
    }

    public bool is_ssnop ()
    {
      return rt == 0 && rd == 0 && sa == 1;
    }

    public bool is_ehb ()
    {
      return rt == 0 && rd == 0 && sa == 3;
    }

    public bool is_normal ()
    {
      return !is_nop() && !is_ehb() && !is_ssnop();
    }

    public override string get_mnemonic ()
    {
      if (is_ehb ())
        return "ehb";
      else if (is_nop ())
        return "nop";
      else if (is_ssnop ())
        return "ssnop";
      return "sll";
    }

    public override string? get_description ()
    {
      if (is_ehb ())
        return @"stop instruction execution until all execution hazards have been cleared";
      else if (is_ssnop ())
        return @"break superscalar issue on a superscalar processor";
      else if (!is_nop ())
        return @"GPR[$rd] ← GPR[$rt] << $sa";
      return null;
    }
  } 

  public class Sllv : Instruction
  {
    public Register rs;
    public Register rt;
    public Register rd;

    public Sllv (Register rs, Register rt, Register rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public Sllv.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sllv (this);
    }

    public override string get_mnemonic ()
    {
      return "sllv";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← GPR[$rt] << rs";
    }
  }

  public class Slt : Instruction
  {
    public Register rs;
    public Register rt;
    public Register rd;

    public Slt (Register rs, Register rt, Register rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public Slt.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_slt (this);
    }

    public override string get_mnemonic ()
    {
      return "slt";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← (GPR[$rs] < GPR[$rt])";
    }
  }

  public class Slti : Instruction
  {
    public Register rs;
    public Register rt;
    public int16 immediate;

    public Slti (Register rs, Register rt, int16 immediate)
    {
      this.rs = rs;
      this.rt = rt;
      this.immediate = immediate;
    }

    public Slti.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), (int16)get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_slti (this);
    }

    public override string get_mnemonic ()
    {
      return "slti";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← (GPR[$rs] < $immediate)";
    }
  }

  public class Sltiu : Instruction
  {
    public Register rs;
    public Register rt;
    public uint16 immediate;

    public Sltiu (Register rs, Register rt, uint16 immediate)
    {
      this.rs = rs;
      this.rt = rt;
      this.immediate = immediate;
    }

    public Sltiu.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sltiu (this);
    }

    public override string get_mnemonic ()
    {
      return "sltiu";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← (GPR[$rs] < $immediate)";
    }
  }

  public class Sltu : Instruction
  {
    public Register rs;
    public Register rt;
    public Register rd;

    public Sltu (Register rs, Register rt, Register rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public Sltu.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sltu (this);
    }

    public override string get_mnemonic ()
    {
      return "sltu";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← (GPR[$rs] < GPR[$rt])";
    }
  }

  public class Cop1.Sqrt : Instruction
  {
    public Format fmt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Sqrt (Format fmt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Sqrt.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_sqrt (this);
    }

    public override string get_mnemonic ()
    {
      return @"sqrt.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← SQRT(FPR[$fs])";
    }
  }

  public class Sra : Instruction
  {
    public Register rt;
    public Register rd;
    public uint8 sa;

    public Sra (Register rt, Register rd, uint8 sa)
      {
        this.rt = rt;
        this.rd = rd;
        this.sa = sa;
      }

    public Sra.from_code (int code)
      {
        this (get_five2_gpr (code), get_five3_gpr (code), get_five4 (code));
      }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sra (this);
    }

    public override string get_mnemonic ()
    {
      return "sra";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← GPR[$rt] >> $sa (arithmetic)";
    }
  }

  public class Srav : Instruction
  {
    public Register rs;
    public Register rt;
    public Register rd;

    public Srav (Register rs, Register rt, Register rd)
    {
      this.rs = rs;
      this.rt = rt;
      this.rd = rd;
    }

    public Srav.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_srav (this);
    }

    public override string get_mnemonic ()
    {
      return "srav";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← GPR[$rt] >> $rs (arithmetic)";
    }
  }

  public class Srl : Instruction
  {
    public bool rotr;
    public Register rt;
    public Register rd;
    public uint8 sa;

    public Srl (bool rotr, Register rt, Register rd, uint8 sa)
      {
        this.rotr = rotr;
        this.rt = rt;
        this.rd = rd;
        this.sa = sa;
      }

    public Srl.from_code (int code)
      {
        this ((bool) get_five1 (code), get_five2_gpr (code), get_five3_gpr (code), get_five4 (code));
      }

    public bool is_rotr ()
    {
      return rotr;
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_srl (this);
    }

    public override string get_mnemonic ()
    {
      if (is_rotr ())
        return "rotr";
      return "srl";
    }

    public override string? get_description ()
    {
      if (is_rotr ())
        return @"GPR[$rd] ← GPR[$rt] ↔(right) $sa";
      return @"GPR[$rd] ← GPR[$rt] >> $sa (logical)";
    }
  } 

  public class Srlv : Instruction
  {
    public Register rs;
    public Register rt;
    public Register rd;
    public bool rotr;

    public Srlv (Register rs, Register rt, Register rd, bool rotr)
    {
      this.rs = rs;
      this.rt = rt;
      this.rd = rd;
      this.rotr = rotr;
    }

    public Srlv.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3_gpr (code), (bool) get_five4 (code));
    }

    public bool is_rotr ()
    {
      return rotr;
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_srlv (this);
    }

    public override string get_mnemonic ()
    {
      if (is_rotr ())
        return "rotrv";
      return "srlv";
    }

    public override string? get_description ()
    {
      if (is_rotr ())
        return @"GPR[$rd] ← GPR[$rt] ↔(right) GPR[$rs]";
      return @"GPR[$rd] ← GPR[$rt] >> GPR[$rs] (logical)";
    }
  }

  public class Sub : Instruction
  {
    public Register rs;
    public Register rt;
    public Register rd;

    public Sub (Register rs, Register rt, Register rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public Sub.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_sub (this);
    }

    public override string get_mnemonic ()
    {
      return "sub";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← GPR[$rs] - GPR[$rt]";
    }
  }

  public class Cop1.Sub : Instruction
  {
    public Format fmt;
    public FpuRegister ft;
    public FpuRegister fs;
    public FpuRegister fd;

    public Sub (Format fmt, FpuRegister ft, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.ft = ft;
      this.fs = fs;
      this.fd = fd;
    }

    public Sub.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five2_fpr (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_sub (this);
    }

    public override string get_mnemonic ()
    {
      return @"sub.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← FPR[$fs] - FPR[$ft]";
    }
  }

  public class Subu : Instruction
  {
    public Register rs;
    public Register rt;
    public Register rd;

    public Subu (Register rs, Register rt, Register rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public Subu.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_subu (this);
    }

    public override string get_mnemonic ()
    {
      return "subu";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← GPR[$rs] - GPR[$rt]";
    }
  }

  public class Cop1x.Suxc1 : Instruction
  {
    public Register @base;
    public uint8 index;
    public FpuRegister fs;

    public Suxc1 (Register @base, uint8 index, FpuRegister fs)
      {
        this.@base = @base;
        this.index = index;
        this.fs = fs;
      }

    public Suxc1.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2 (code), get_five3_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_suxc1 (this);
    }

    public override string get_mnemonic ()
    {
      return "suxc1";
    }

    public override string? get_description ()
    {
      return @"memory[(GPR[$base] + GPR[$index])PSIZE-1..3] ← FPR[$fs]";
    }
  }

  public class Sw : Instruction
  {
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

    public override string get_mnemonic ()
    {
      return "sw";
    }

    public override string? get_description ()
    {
      return @"memory[GPR[$base] + $offset] ← GPR[$rt]";
    }
  }

  public class Swc1 : Instruction
  {
    public Register @base;
    public FpuRegister ft;
    public uint16 offset;

    public Swc1 (Register @base, FpuRegister ft, uint16 offset)
      {
        this.@base = @base;
        this.ft = ft;
        this.offset = offset;
      }

    public Swc1.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_fpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_swc1 (this);
    }

    public override string get_mnemonic ()
    {
      return "swc1";
    }

    public override string? get_description ()
    {
      return @"memory[GPR[$base] + $offset] ← FPR[$ft]";
    }
  }

  public class Swc2 : Instruction
  {
    public Register @base;
    public Register rt;
    public uint16 offset;

    public Swc2 (Register @base, Register rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Swc2.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_swc2 (this);
    }

    public override string get_mnemonic ()
    {
      return "swc2";
    }

    public override string? get_description ()
    {
      return @"memory[GPR[$base] + $offset] ← CPR[2,$rt,0]";
    }
  }

  public class Swl : Instruction
  {
    public Register @base;
    public Register rt;
    public uint16 offset;

    public Swl (Register @base, Register rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Swl.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_swl (this);
    }

    public override string get_mnemonic ()
    {
      return "swl";
    }

    public override string? get_description ()
    {
      return @"memory[GPR[$base] + $offset] ← GPR[$rt]";
    }
  }

  public class Swr : Instruction
  {
    public Register @base;
    public Register rt;
    public uint16 offset;

    public Swr (Register @base, Register rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Swr.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_swr (this);
    }

    public override string get_mnemonic ()
    {
      return "swr";
    }

    public override string? get_description ()
    {
      return @"memory[GPR[$base] + $offset] ← GPR[$rt]";
    }
  }

  public class Cop1x.Swxc1 : Instruction
  {
    public Register @base;
    public uint8 index;
    public FpuRegister fs;

    public Swxc1 (Register @base, uint8 index, FpuRegister fs)
      {
        this.@base = @base;
        this.index = index;
        this.fs = fs;
      }

    public Swxc1.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2 (code), get_five3_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1x_swxc1 (this);
    }

    public override string get_mnemonic ()
    {
      return "swxc1";
    }

    public override string? get_description ()
    {
      return @"memory[GPR[$base] + GPR[$index]] ← FPR[$fs]";
    }
  }

  public class Sync : Instruction
  {
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

    public override string get_mnemonic ()
    {
      return "sync";
    }

    public override string? get_description ()
    {
      return "order loads and stores";
    }
  }

  public class Regimm.Synci : Instruction
  {
    public Register @base;
    public uint16 offset;

    public Synci (Register @base, uint16 offset)
      {
        this.@base = @base;
        this.offset = offset;
      }

    public Synci.from_code (int code)
    {
      this (get_five1_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_synci (this);
    }

    public override string get_mnemonic ()
    {
      return "synci";
    }

    public override string? get_description ()
    {
      return "synchronize all caches to make instruction writes effective";
    }
  }

  public class Syscall : Instruction
  {
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

    public override string get_mnemonic ()
    {
      return "syscall";
    }

    public override string? get_description ()
    {
      return "cause a System Call exception";
    }
  }

  public class Teq : Instruction
  {
    public Register rs;
    public Register rt;
    public uint16 code;

    public Teq (Register rs, Register rt, uint16 code)
    {
      this.rs = rs;
      this.rt = rt;
      this.code = code;
    }

    public Teq.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_ten (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_teq (this);
    }

    public override string get_mnemonic ()
    {
      return "teq";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] = GPR[$rt] then Trap";
    }
  }

  public class Regimm.Teqi : Instruction
  {
    public Register rs;
    public uint16 immediate;

    public Teqi (Register rs, uint16 immediate)
      {
        this.rs = rs;
        this.immediate = immediate;
      }

    public Teqi.from_code (int code)
    {
      this (get_five1_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_teqi (this);
    }

    public override string get_mnemonic ()
    {
      return "teqi";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] = $immediate then Trap";
    }
  }

  public class Tge : Instruction
  {
    public Register rs;
    public Register rt;
    public uint16 code;

    public Tge (Register rs, Register rt, uint16 code)
    {
      this.rs = rs;
      this.rt = rt;
      this.code = code;
    }

    public Tge.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_ten (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_tge (this);
    }

    public override string get_mnemonic ()
    {
      return "tge";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] ≥ GPR[$rt] then Trap";
    }
  }

  public class Regimm.Tgei : Instruction
  {
    public Register rs;
    public uint16 immediate;

    public Tgei (Register rs, uint16 immediate)
      {
        this.rs = rs;
        this.immediate = immediate;
      }

    public Tgei.from_code (int code)
    {
      this (get_five1_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_tgei (this);
    }

    public override string get_mnemonic ()
    {
      return "tgei";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] ≥ $immediate then Trap";
    }
  }

  public class Regimm.Tgeiu : Instruction
  {
    public Register rs;
    public uint16 immediate;

    public Tgeiu (Register rs, uint16 immediate)
      {
        this.rs = rs;
        this.immediate = immediate;
      }

    public Tgeiu.from_code (int code)
    {
      this (get_five1_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_tgeiu (this);
    }

    public override string get_mnemonic ()
    {
      return "tgeiu";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] ≥ $immediate then Trap";
    }
  }

  public class Tgeu : Instruction
  {
    public Register rs;
    public Register rt;
    public uint16 code;

    public Tgeu (Register rs, Register rt, uint16 code)
    {
      this.rs = rs;
      this.rt = rt;
      this.code = code;
    }

    public Tgeu.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_ten (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_tgeu (this);
    }

    public override string get_mnemonic ()
    {
      return "tgeu";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] ≥ GPR[$rt] then Trap";
    }
  }

  public class Cop0.Tlbp : Instruction
  {
    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_tlbp (this);
    }

    public override string get_mnemonic ()
    {
      return "tlbp";
    }

    public override string? get_description ()
    {
      return "find a matching entry in the TLB";
    }
  }

  public class Cop0.Tlbr : Instruction
  {
    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_tlbr (this);
    }

    public override string get_mnemonic ()
    {
      return "tlbr";
    }

    public override string? get_description ()
    {
      return "read an entry from the TLB";
    }
  }

  public class Cop0.Tlbwi : Instruction
  {
    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_tlbwi (this);
    }

    public override string get_mnemonic ()
    {
      return "tlbwi";
    }

    public override string? get_description ()
    {
      return "write a TLB entry indexed by the Index register";
    }
  }

  public class Cop0.Tlbwr : Instruction
  {
    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_tlbwr (this);
    }

    public override string get_mnemonic ()
    {
      return "tlbwr";
    }

    public override string? get_description ()
    {
      return "write a TLB entry indexed by the Random register";
    }
  }

  public class Tlt : Instruction
  {
    public Register rs;
    public Register rt;
    public uint16 code;

    public Tlt (Register rs, Register rt, uint16 code)
    {
      this.rs = rs;
      this.rt = rt;
      this.code = code;
    }

    public Tlt.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_ten (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_tlt (this);
    }

    public override string get_mnemonic ()
    {
      return "tlt";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] < GPR[$rt] then Trap";
    }
  }

  public class Regimm.Tlti : Instruction
  {
    public Register rs;
    public uint16 immediate;

    public Tlti (Register rs, uint16 immediate)
      {
        this.rs = rs;
        this.immediate = immediate;
      }

    public Tlti.from_code (int code)
    {
      this (get_five1_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_tlti (this);
    }

    public override string get_mnemonic ()
    {
      return "tlti";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] < $immediate then Trap";
    }
  }

  public class Regimm.Tltiu : Instruction
  {
    public Register rs;
    public uint16 immediate;

    public Tltiu (Register rs, uint16 immediate)
      {
        this.rs = rs;
        this.immediate = immediate;
      }

    public Tltiu.from_code (int code)
    {
      this (get_five1_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_tltiu (this);
    }

    public override string get_mnemonic ()
    {
      return "tltiu";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] < $immediate then Trap";
    }
  }

  public class Tltu : Instruction
  {
    public Register rs;
    public Register rt;
    public uint16 code;

    public Tltu (Register rs, Register rt, uint16 code)
    {
      this.rs = rs;
      this.rt = rt;
      this.code = code;
    }

    public Tltu.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_ten (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_tltu (this);
    }

    public override string get_mnemonic ()
    {
      return "tltu";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] < GPR[$rt] then Trap";
    }
  }

  public class Tne : Instruction
  {
    public Register rs;
    public Register rt;
    public uint16 code;

    public Tne (Register rs, Register rt, uint16 code)
    {
      this.rs = rs;
      this.rt = rt;
      this.code = code;
    }

    public Tne.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_ten (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_tne (this);
    }

    public override string get_mnemonic ()
    {
      return "tne";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] ≠ GPR[$rt] then Trap";
    }
  }

  public class Regimm.Tnei : Instruction
  {
    public Register rs;
    public uint16 immediate;

    public Tnei (Register rs, uint16 immediate)
      {
        this.rs = rs;
        this.immediate = immediate;
      }

    public Tnei.from_code (int code)
    {
      this (get_five1_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_regimm_tnei (this);
    }

    public override string get_mnemonic ()
    {
      return "tnei";
    }

    public override string? get_description ()
    {
      return @"if GPR[$rs] ≠ $immediate then Trap";
    }
  }

  public class Cop1.Truncl : Instruction
  {
    public Format fmt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Truncl (Format fmt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Truncl.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_truncl (this);
    }

    public override string get_mnemonic ()
    {
      return @"trunc.l.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← convert_and_round(FPR[$fs])";
    }
  }

  public class Cop1.Truncw : Instruction
  {
    public Format fmt;
    public FpuRegister fs;
    public FpuRegister fd;

    public Truncw (Format fmt, FpuRegister fs, FpuRegister fd)
    {
      this.fmt = fmt;
      this.fs = fs;
      this.fd = fd;
    }

    public Truncw.from_code (int code)
    {
      this ((Format)get_five1 (code), get_five3_fpr (code), get_five4_fpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_truncw (this);
    }

    public override string get_mnemonic ()
    {
      return @"trunc.w.$fmt";
    }

    public override string? get_description ()
    {
      return @"FPR[$fd] ← convert_and_round(FPR[$fs])";
    }
  }

  public class Cop0.Wait : Instruction
  {
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

    public override string get_mnemonic ()
    {
      return "wait";
    }

    public override string? get_description ()
    {
      return "Wait for Event";
    }
  }

  public class Cop0.Wrpgpr : Instruction
  {
    public Register rt;
    public Register rd;

    public Wrpgpr (Register rt, Register rd)
    {
      this.rt = rt;
      this.rd = rd;
    }

    public Wrpgpr.from_code (int code)
    {
      this (get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop0_wrpgpr (this);
    }

    public override string get_mnemonic ()
    {
      return "wrpgpr";
    }

    public override string? get_description ()
    {
      return @"SGPR[SRSCtlPSS, $rd] ← GPR[$rt]";
    }
  }

  public class Wsbh : Instruction
  {
    public Register rt;
    public Register rd;

    public Wsbh (Register rt, Register rd)
      {
        this.rt = rt;
        this.rd = rd;
      }

    public Wsbh.from_code (int code)
    {
      this (get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_wsbh (this);
    }

    public override string get_mnemonic ()
    {
      return "wsbh";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← SwapBytesWithinHalfwords(GPR[$rt])";
    }
  }

  public class Xor : Instruction
  {
    public Register rs;
    public Register rt;
    public Register rd;

    public Xor (Register rs, Register rt, Register rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public Xor.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_five3_gpr (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_xor (this);
    }

    public override string get_mnemonic ()
    {
      return "xor";
    }

    public override string? get_description ()
    {
      return @"GPR[$rd] ← GPR[$rs] XOR GPR[$rt]";
    }
  }

  public class Xori : Instruction
  {
    public Register rs;
    public Register rt;
    public uint16 immediate;

    public Xori (Register rs, Register rt, uint16 immediate)
    {
      this.rs = rs;
      this.rt = rt;
      this.immediate = immediate;
    }

    public Xori.from_code (int code)
    {
      this (get_five1_gpr (code), get_five2_gpr (code), get_half (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_xori (this);
    }

    public override string get_mnemonic ()
    {
      return "xori";
    }

    public override string? get_description ()
    {
      return @"GPR[$rt] ← GPR[$rs] XOR $immediate";
    }
  }
}
