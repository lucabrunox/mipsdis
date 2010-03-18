namespace Mips
{
  static const uint8 SPECIAL = 0x00;
  static const uint8 REGIMM = 0x01;
  static const uint8 COP1 = 0x11;
  static const uint8 COP1X = 0x13;
  static const uint8 COP2 = 0x12;
  static const uint8 SPECIAL2 = 0x1C;

  static const int FIVE_MASK = 0x1F;
  static const int FIVE1_BITS = 21;
  static const int FIVE2_BITS = 16;
  static const int FIVE3_BITS = 11;
  static const int FIVE4_BITS = 6;
  static const int HALF_MASK = 0xFFFF;

  public inline static uint8 get_five1 (int code)
  {
    return (uint8)((code >> FIVE1_BITS) & FIVE_MASK);
  }

  public inline static uint8 get_five2 (int code)
  {
    return (uint8)((code >> FIVE2_BITS) & FIVE_MASK);
  }

  public inline static uint8 get_five3 (int code)
  {
    return (uint8)((code >> FIVE3_BITS) & FIVE_MASK);
  }

  public inline static uint8 get_five4 (int code)
  {
    return (uint8)((code >> FIVE4_BITS) & FIVE_MASK);
  }

  public inline static uint16 get_half (int code)
  {
    return (uint16)(code & HALF_MASK);
  }

  public abstract class Visitor
  {
    public abstract void visit_cop1_abs (Cop1.Abs inst);
    public abstract void visit_cop1_cf (Cop1.Cf inst);
    public abstract void visit_cop1_ct (Cop1.Ct inst);
    public abstract void visit_cop2_cf (Cop2.Cf inst);
    public abstract void visit_cop2_ct (Cop2.Ct inst);
    public abstract void visit_cop1_sqrt (Cop1.Sqrt inst);
    public abstract void visit_cop1_mov (Cop1.Mov inst);
    public abstract void visit_cop1_sub (Cop1.Sub inst);
    public abstract void visit_cop1_mul (Cop1.Mul inst);
    public abstract void visit_cop1_div (Cop1.Div inst);
    public abstract void visit_cop1_truncw (Cop1.Truncw inst);
    public abstract void visit_cop1_ceilw (Cop1.Ceilw inst);
    public abstract void visit_cop1_cvtd (Cop1.Cvtd inst);
    public abstract void visit_cop1_cvts (Cop1.Cvts inst);
    public abstract void visit_cop1_add (Cop1.Add inst);
    public abstract void visit_cop1_ccond (Cop1.Ccond inst);
    public abstract void visit_cop1_bc (Cop1.Bc inst);
    public abstract void visit_cop2_bc (Cop2.Bc inst);
    public abstract void visit_cop1_mtc1 (Cop1.Mtc1 inst);
    public abstract void visit_cop1_mfc1 (Cop1.Mfc1 inst);
    public abstract void visit_cop1_movci (Cop1.Movci inst);
    public abstract void visit_cop1_movcf (Cop1.Movcf inst);
    public abstract void visit_add (Add inst);
    public abstract void visit_lui (Lui inst);
    public abstract void visit_addiu (Addiu inst);
    public abstract void visit_addi (Addi inst);
    public abstract void visit_addu (Addu inst);
    public abstract void visit_subu (Subu inst);
    public abstract void visit_sw (Sw inst);
    public abstract void visit_cache (Cache inst);
    public abstract void visit_sync (Sync inst);
    public abstract void visit_swl (Swl inst);
    public abstract void visit_swr (Swr inst);
    public abstract void visit_lb (Lb inst);
    public abstract void visit_sh (Sh inst);
    public abstract void visit_lh (Lh inst);
    public abstract void visit_regimm_bgezal (Regimm.Bgezal inst);
    public abstract void visit_regimm_bgezall (Regimm.Bgezall inst);
    public abstract void visit_nop (Nop inst);
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
    public abstract void visit_mflo (Mflo inst);
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
    public abstract void visit_movn (Movn inst);
    public abstract void visit_sdc1 (Sdc1 inst);
    public abstract void visit_ldc1 (Ldc1 inst);
    public abstract void visit_lwc1 (Lwc1 inst);
    public abstract void visit_swc1 (Swc1 inst);
    public abstract void visit_swc2 (Swc2 inst);
  }

  public abstract class Instruction
  {
    public abstract void accept (Visitor visitor);
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
    public uint8 rt;
    public uint16 immediate;

    public Lui (uint8 rt, uint16 immediate)
    {
      this.rt = rt;
      this.immediate = immediate;
    }

    public Lui.from_code (int code)
    {
      this (get_five2 (code), get_half (code));
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

    public uint8 rs;
    public uint8 rt;
    public uint16 immediate;

    public Addiu (uint8 rs, uint8 rt, uint16 immediate)
    {
      this.rs = rs;
      this.rt = rt;
      this.immediate = immediate;
    }

    public Addiu.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
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

    public uint8 rs;
    public uint8 rt;
    public uint8 rd;

    public Addu (uint8 rs, uint8 rt, uint8 rd)
      {
        this.rs = rs;
        this.rt = rt;
        this.rd = rd;
      }

    public Addu.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_five3 (code));
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

    public uint8 @base;
    public uint8 rt;
    public uint16 offset;

    public Sw (uint8 @base, uint8 rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Sw.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
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

  public class Lw : Instruction
  {
    /* SW
       101011 base(5) rt(5) offset(16)
    */

    public uint8 @base;
    public uint8 rt;
    public uint16 offset;

    public Lw (uint8 @base, uint8 rt, uint16 offset)
      {
        this.@base = @base;
        this.rt = rt;
        this.offset = offset;
      }

    public Lw.from_code (int code)
    {
      this (get_five1 (code), get_five2 (code), get_half (code));
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

  public class Xor : Instruction
  {
    /*
      001001 rs(5) rt(5) immediate(16)
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

  public class Cop1.Mtc1 : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 rt;
    public uint8 fs;

    public Mtc1 (uint8 rt, uint8 fs)
    {
      this.rt = rt;
      this.fs = fs;
    }

    public Mtc1.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_mtc1 (this);
    }
  }

  public class Cop1.Mfc1 : Instruction
  {
    /* COP1
       010001 01000 cc(3) nd(1) tf(1) offset(16)
    */

    public uint8 rt;
    public uint8 fs;

    public Mfc1 (uint8 rt, uint8 fs)
    {
      this.rt = rt;
      this.fs = fs;
    }

    public Mfc1.from_code (int code)
    {
      this (get_five2 (code), get_five3 (code));
    }

    public override void accept (Visitor visitor)
    {
      visitor.visit_cop1_mfc1 (this);
    }
  }

  public class Cop1.Movci : Instruction
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
      visitor.visit_cop1_movci (this);
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
}
