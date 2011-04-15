/* assemblywriter.vala
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

namespace Mips {
  public errordomain OpcodeError
  {
    INVALID_OPCODE,
    INVALID_FPU_FORMAT,
    INVALID_REGISTER,
  }

  public class AssemblyWriter : Visitor {
	  private StringBuilder builder = new StringBuilder ();

	  [PrintfFormat]
	  private void write_line (string format, ...) {
		  va_list ap = va_list ();
		  builder.append_printf ("%-30s", format.vprintf (ap));
	  }

	  public string write (BinaryCode binary_code) {
		  foreach (var binary_instruction in binary_code.text_section.binary_instructions) {
			  if (binary_instruction.label != null) {
				  if (binary_instruction.is_func_start)
					  builder.append_printf ("# function <%s>:\n", binary_instruction.label);
				  else
					  builder.append_printf ("%s:\n", binary_instruction.label);
			  }
			  builder.append_printf ("%.8x: %.8x  %-10s ", binary_instruction.virtual_address, binary_instruction.file_value, binary_instruction.instruction.get_mnemonic ());
			  binary_instruction.instruction.accept (this);
			  var desc = binary_instruction.instruction.get_description ();
			  if (desc != null) {
				  builder.append_printf ("\t# %s", desc);
			  }
			  builder.append_c ('\n');
		  }
		  return builder.str;
	  }

    public override void visit_cop1_abs (Cop1.Abs inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_movz (Cop1.Movz inst)
    {
      write_line ("%4s, %4s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.rt.to_string());
    }

    public override void visit_cop1_movn (Cop1.Movn inst)
    {
      write_line ("%4s, %4s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.rt.to_string());
    }

    public override void visit_cop1_sqrt (Cop1.Sqrt inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_truncw (Cop1.Truncw inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_truncl (Cop1.Truncl inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_ceilw (Cop1.Ceilw inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_ceill (Cop1.Ceill inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_floorw (Cop1.Floorw inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_floorl (Cop1.Floorl inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_roundl (Cop1.Roundl inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_roundw (Cop1.Roundw inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_rsqrt (Cop1.Rsqrt inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_cvtd (Cop1.Cvtd inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_cvtl (Cop1.Cvtl inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_cvtps (Cop1.Cvtps inst)
    {
      write_line ("%4s, %4s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string ());
    }

    public override void visit_cop1_cvtw (Cop1.Cvtw inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_cvts (Cop1.Cvts inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_cvtspl (Cop1.Cvtspl inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_cvtspu (Cop1.Cvtspu inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_mov (Cop1.Mov inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_neg (Cop1.Neg inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_mul (Cop1.Mul inst)
    {
      write_line ("%4s, %4s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_div (Cop1.Div inst)
    {
      write_line ("%4s, %4s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_add (Cop1.Add inst)
    {
      write_line ("%4s, %4s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_sub (Cop1.Sub inst)
    {
      write_line ("%4s, %4s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_pll (Cop1.Pll inst)
    {
      write_line ("%4s, %4s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_plu (Cop1.Plu inst)
    {
      write_line ("%4s, %4s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_pul (Cop1.Pul inst)
    {
      write_line ("%4s, %4s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_puu (Cop1.Puu inst)
    {
      write_line ("%4s, %4s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1_ccond (Cop1.Ccond inst)
    {
      if (inst.cc == 0)
        write_line ("%4s, %s", inst.fs.to_string(), inst.ft.to_string());
      else
        write_line ("%d, %4s, %s", inst.cc, inst.fs.to_string(), inst.ft.to_string());  
    }

    public override void visit_cop1_bc (Cop1.Bc inst)
    {
      write_line ("0x%x, 0x%x", inst.cc, inst.offset);
    }

    public override void visit_cop2_bc (Cop2.Bc inst)
    {
      write_line ("0x%x, 0x%x", inst.cc, inst.offset);
    }

    public override void visit_cop2_co (Cop2.Co inst)
    {
      write_line ("0x%x", inst.cofun);
    }

    public override void visit_cop1_mf (Cop1.Mf inst)
    {
      write_line ("%4s, %s", inst.rt.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_mfh (Cop1.Mfh inst)
    {
      write_line ("%4s, %s", inst.rt.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_mth (Cop1.Mth inst)
    {
      write_line ("%4s, %s", inst.rt.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_cf (Cop1.Cf inst)
    {
      write_line ("%4s, %s", inst.rt.to_string(), inst.fs.to_string());
    }

    public override void visit_cop1_ct (Cop1.Ct inst)
    {
      write_line ("%4s, %s", inst.rt.to_string(), inst.fs.to_string());
    }

    public override void visit_cop2_cf (Cop2.Cf inst)
    {
      write_line ("%4s, %s", inst.rt.to_string(), inst.rd.to_string());
    }

    public override void visit_cop2_ct (Cop2.Ct inst)
    {
      write_line ("%4s, %s", inst.rt.to_string(), inst.rd.to_string());
    }

    public override void visit_cop2_mf (Cop2.Mf inst)
    {
      write_line ("%4s, 0x%x", inst.rt.to_string(), inst.impl);
    }

    public override void visit_cop2_mt (Cop2.Mt inst)
    {
      write_line ("%4s, 0x%x", inst.rt.to_string(), inst.impl);
    }

    public override void visit_cop2_mfh (Cop2.Mfh inst)
    {
      write_line ("%4s, 0x%x", inst.rt.to_string(), inst.impl);
    }

    public override void visit_cop2_mth (Cop2.Mth inst)
    {
      write_line ("%4s, 0x%x", inst.rt.to_string(), inst.impl);
    }

    public override void visit_cop1_mt (Cop1.Mt inst)
    {
      write_line ("%4s, %s", inst.rt.to_string(), inst.fs.to_string());
    }

    public override void visit_movci (Movci inst)
    {
      if (inst.test_true)
        write_line ("%4s, %4s, %d", inst.rd.to_string(), inst.rs.to_string(), inst.cc);
      else
        write_line ("%4s, %4s, %d", inst.rd.to_string(), inst.rs.to_string(), inst.cc);
    }

    public override void visit_cop1_movcf (Cop1.Movcf inst)
    {
      if (inst.test_true)
        write_line ("%4s, %4s, %d", inst.fd.to_string(), inst.fs.to_string(), inst.cc);
      else
        write_line ("%4s, %4s, %d", inst.fd.to_string(), inst.fs.to_string(), inst.cc);
    }

    public override void visit_cop1x_alnv (Cop1x.Alnv inst)
    {
      write_line ("%4s, %4s, %4s, %s", inst.fd.to_string(), inst.fs.to_string(), inst.ft.to_string(), inst.rs.to_string ());
    }

    public override void visit_cop1x_madd (Cop1x.Madd inst)
    {
      write_line ("%4s, %4s, %4s, %s", inst.fd.to_string(), inst.fr.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1x_nmadd (Cop1x.Nmadd inst)
    {
      write_line ("%4s, %4s, %4s, %s", inst.fd.to_string(), inst.fr.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1x_nmsub (Cop1x.Nmsub inst)
    {
      write_line ("%4s, %4s, %4s, %s", inst.fd.to_string(), inst.fr.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_cop1x_msub (Cop1x.Msub inst)
    {
      write_line ("%4s, %4s, %4s, %s", inst.fd.to_string(), inst.fr.to_string(), inst.fs.to_string(), inst.ft.to_string());
    }

    public override void visit_add (Add inst)
    {
      write_line ("%4s, %4s, %s", inst.rs.to_string(), inst.rt.to_string(), inst.rd.to_string());
    }

    public override void visit_madd (Madd inst)
    {
      write_line ("%4s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_msub (Msub inst)
    {
      write_line ("%4s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_msubu (Msubu inst)
    {
      write_line ("%4s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_maddu (Maddu inst)
    {
      write_line ("%4s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_lui (Lui inst)
    {
      write_line ("%4s, %d", inst.rt.to_string (), inst.immediate);
    }

    public override void visit_addiu (Addiu inst)
    {
      write_line ("%4s, %4s, %u", inst.rt.to_string (), inst.rs.to_string (), inst.immediate);
      if (inst.reference != null)
        builder.append_printf ("\t# %s", inst.reference.to_string ());
    }

    public override void visit_addi (Addi inst)
    {
      write_line ("%4s, %4s, %d", inst.rs.to_string(), inst.rt.to_string(), inst.immediate);
    }

    public override void visit_addu (Addu inst)
    {
      write_line ("%4s, %4s, %s", inst.rd.to_string (), inst.rs.to_string (), inst.rt.to_string ());
    }

    public override void visit_rdhwr (Rdhwr inst)
    {
      write_line ("%4s, %s", inst.rt.to_string(), inst.rd.to_string());
    }

    public override void visit_sw (Sw inst)
    {
      write_line ("%4s, %d(%s)", inst.rt.to_string (), inst.offset, inst.@base.to_string ());
    }

    public override void visit_cache (Cache inst)
    {
      write_line ("0x%x, %d(%s)", inst.op, inst.offset, inst.@base.to_string());
    }

    public override void visit_pref (Pref inst)
    {
      write_line ("0x%x, %d(%s)", inst.hint, inst.offset, inst.@base.to_string());
    }

    public override void visit_cop1x_prefx (Cop1x.Prefx inst)
    {
      write_line ("0x%x, %d(%s)", inst.hint, inst.index, inst.@base.to_string());
    }

    public override void visit_sync (Sync inst)
    {
    }

    public override void visit_swl (Swl inst)
    {
      write_line ("%4s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_swr (Swr inst)
    {
      write_line ("%4s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_regimm_bgezal (Regimm.Bgezal inst) {
		if (inst.is_unconditional ()) {
			if (inst.reference != null) {
				write_line ("%s", inst.reference.to_string());
			} else {
				write_line ("0x%x", inst.offset);
			}
		} else {
			if (inst.reference != null) {
				write_line ("%4s, %s", inst.rs.to_string(), inst.reference.to_string());
			} else {
				write_line ("%4s, 0x%x", inst.rs.to_string(), inst.offset);
			}
		}
    }

    public override void visit_regimm_bgezall (Regimm.Bgezall inst) {
		if (inst.reference != null) {
			write_line ("%4s, %s", inst.rs.to_string(), inst.reference.to_string());
		} else {
			write_line ("%4s, 0x%x", inst.rs.to_string(), inst.offset);
		}
    }

    public override void visit_regimm_synci (Regimm.Synci inst)
    {
      write_line ("%d(%s)", inst.offset, inst.@base.to_string());
    }

    public override void visit_cop0_mfmc0 (Cop0.Mfmc0 inst)
    {
      if (!inst.sc && inst.rt != 0)
        write_line ("%s", inst.rt.to_string ());
      else if (inst.sc && inst.rt != 0)
        write_line ("%s", inst.rt.to_string ());
    }

    public override void visit_cop0_deret (Cop0.Deret inst)
    {
    }

    public override void visit_cop0_eret (Cop0.Eret inst)
    {
    }

    public override void visit_cop0_mf (Cop0.Mf inst)
    {
      write_line ("%4s, %4s, %d", inst.rt.to_string(), inst.rd.to_string(), inst.sel);
    }

    public override void visit_cop0_mt (Cop0.Mt inst)
    {
      write_line ("%4s, %4s, %d", inst.rt.to_string(), inst.rd.to_string(), inst.sel);
    }

    public override void visit_cop0_rdpgpr (Cop0.Rdpgpr inst)
    {
      write_line ("%4s, %s", inst.rd.to_string(), inst.rt.to_string());
    }

    public override void visit_cop0_wrpgpr (Cop0.Wrpgpr inst)
    {
      write_line ("%4s, %s", inst.rd.to_string(), inst.rt.to_string());
    }

    public override void visit_cop1_recip (Cop1.Recip inst)
    {
      write_line ("%4s, %s", inst.fd.to_string(), inst.fs.to_string());
    }

    public override void visit_lw (Lw inst)
    {
      if (inst.reference != null)
        {
          if (inst.reference is BinaryInstruction || inst.reference is BinaryObject)
            write_line ("%4s, %s", inst.rt.to_string (), inst.reference.to_string ());
          else
            write_line ("%4s, %d(%s)\t# %s", inst.rt.to_string (), inst.offset, inst.@base.to_string (), inst.reference.to_string ());
        }
      else
        write_line ("%4s, %d(%s)", inst.rt.to_string (), inst.offset, inst.@base.to_string ());
    }

    public override void visit_lwl (Lwl inst)
    {
      write_line ("%4s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_ext (Ext inst)
    {
      write_line ("%4s, %4s, %d, %d", inst.rt.to_string(), inst.rs.to_string(), inst.lsb, inst.msbd+1);
    }

    public override void visit_ins (Ins inst)
    {
      write_line ("%4s, %4s, %d, %d", inst.rt.to_string(), inst.rs.to_string(), inst.lsb, inst.msb+1);
    }

    public override void visit_lwr (Lwr inst)
    {
      write_line ("%4s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_jalr (Jalr inst)
    {
      if (inst.has_hint ())
        write_line ("%4s, %s", inst.rd.to_string (), inst.rs.to_string ());
      else
        write_line ("%4s, %s", inst.rd.to_string (), inst.rs.to_string ());
    }

    public override void visit_jr (Jr inst)
    {
      if (inst.has_hint ())
        write_line ("%s", inst.rs.to_string());
      else
        write_line ("%s", inst.rs.to_string());
    }

    public override void visit_regimm_bltzal (Regimm.Bltzal inst) {
		if (inst.reference != null) {
			write_line ("%4s, %s", inst.rs.to_string(), inst.reference.to_string());
		} else {
			write_line ("%4s, 0x%x", inst.rs.to_string(), inst.offset);
		}
    }

    public override void visit_regimm_bltzall (Regimm.Bltzall inst) {
		if (inst.reference != null) {
			write_line ("%4s, %s", inst.rs.to_string(), inst.reference.to_string());
		} else {
			write_line ("%4s, 0x%x", inst.rs.to_string(), inst.offset);
		}
    }

    public override void visit_sll (Sll inst)
    {
      if (inst.is_normal ())
        write_line ("%4s, %4s, 0x%x", inst.rd.to_string(), inst.rt.to_string(), inst.sa);
    }

    public override void visit_beq (Beq inst) {
		if (inst.is_unconditional ()) {
			if (inst.reference != null) {
				write_line ("%4s", inst.reference.to_string());
			} else {
				write_line ("0x%x", inst.offset);
			}
		} else {
			if (inst.reference != null) {
				write_line ("%4s, %4s, %s", inst.rs.to_string(), inst.rt.to_string(), inst.reference.to_string ());
			} else {
				write_line ("%4s, %4s, 0x%x", inst.rs.to_string(), inst.rt.to_string(), inst.offset);
			}
		}
    }

    public override void visit_beql (Beql inst) {
		if (inst.reference != null) {
			write_line ("%4s, %4s, %s", inst.rs.to_string(), inst.rt.to_string(), inst.reference.to_string());
		} else {
			write_line ("%4s, %4s, 0x%x", inst.rs.to_string(), inst.rt.to_string(), inst.offset);
		}
    }

    public override void visit_bne (Bne inst) {
		if (inst.reference != null) {
			write_line ("%4s, %4s, %s", inst.rs.to_string(), inst.rt.to_string(), inst.reference.to_string());
		} else {
			write_line ("%4s, %4s, 0x%x", inst.rs.to_string(), inst.rt.to_string(), inst.offset);
		}
    }

    public override void visit_bnel (Bnel inst) {
		if (inst.reference != null) {
			write_line ("%4s, %4s, %s", inst.rs.to_string(), inst.rt.to_string(), inst.reference.to_string());
		} else {
			write_line ("%4s, %4s, 0x%x", inst.rs.to_string(), inst.rt.to_string(), inst.offset);
		}
    }

    public override void visit_lbu (Lbu inst)
    {
      write_line ("%4s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_sb (Sb inst)
    {
      write_line ("%4s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_seb (Seb inst)
    {
      write_line ("%4s, %s", inst.rd.to_string(), inst.rt.to_string());
    }

    public override void visit_wsbh (Wsbh inst)
    {
      write_line ("%4s, %s", inst.rd.to_string(), inst.rt.to_string());
    }

    public override void visit_seh (Seh inst)
    {
      write_line ("%4s, %s", inst.rd.to_string(), inst.rt.to_string());
    }

    public override void visit_sc (Sc inst)
    {
      write_line ("%4s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_sltiu (Sltiu inst)
    {
      write_line ("%4s, %4s, %d", inst.rs.to_string(), inst.rt.to_string(), inst.immediate);
    }

    public override void visit_slti (Slti inst)
    {
      write_line ("%4s, %4s, %d", inst.rs.to_string(), inst.rt.to_string(), inst.immediate);
    }

    public override void visit_ori (Ori inst)
    {
      write_line ("%4s, %4s, %d", inst.rs.to_string(), inst.rt.to_string(), inst.immediate);
    }

    public override void visit_sltu (Sltu inst)
    {
      write_line ("%4s, %4s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_sllv (Sllv inst)
    {
      write_line ("%4s, %4s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_and (And inst)
    {
      write_line ("%4s, %4s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_or (Or inst)
    {
      write_line ("%4s, %4s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_lhu (Lhu inst)
    {
      write_line ("%4s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_sub (Sub inst)
    {
      write_line ("%4s, %4s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_subu (Subu inst)
    {
      write_line ("%4s, %4s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_sh (Sh inst)
    {
      write_line ("%4s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_lh (Lh inst)
    {
      write_line ("%4s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_srl (Srl inst)
    {
      if (inst.is_rotr ())
        write_line ("%4s, %4s, 0x%x", inst.rd.to_string(), inst.rt.to_string(), inst.sa);
      else
        write_line ("%4s, %4s, 0x%x", inst.rd.to_string(), inst.rt.to_string(), inst.sa);
    }

    public override void visit_andi (Andi inst)
    {
      write_line ("%4s, %4s, %d", inst.rs.to_string(), inst.rt.to_string(), inst.immediate);
    }

    public override void visit_regimm_bgez (Regimm.Bgez inst) {
		if (inst.reference != null) {
			write_line ("%4s, %s", inst.rs.to_string(), inst.reference.to_string());
		} else {
			write_line ("%4s, 0x%x", inst.rs.to_string(), inst.offset);
		}
    }

    public override void visit_sra (Sra inst)
    {
      write_line ("%4s, %4s, 0x%x", inst.rd.to_string(), inst.rt.to_string(), inst.sa);
    }

    public override void visit_lb (Lb inst)
    {
      write_line ("%4s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_ll (Ll inst)
    {
      write_line ("%4s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_regimm_bltz (Regimm.Bltz inst) {
		if (inst.reference != null) {
			write_line ("%4s, %s", inst.rs.to_string(), inst.reference.to_string());
		} else {
			write_line ("%4s, 0x%x", inst.rs.to_string(), inst.offset);
		}
    }

    public override void visit_regimm_bltzl (Regimm.Bltzl inst) {
		if (inst.reference != null) {
			write_line ("%4s, %s", inst.rs.to_string(), inst.reference.to_string());
		} else {
			write_line ("%4s, 0x%x", inst.rs.to_string(), inst.offset);
		}
    }

    public override void visit_regimm_bgezl (Regimm.Bgezl inst) {
		if (inst.reference != null) {
			write_line ("%4s, %s", inst.rs.to_string(), inst.reference.to_string());
		} else {
			write_line ("%4s, 0x%x", inst.rs.to_string(), inst.offset);
		}
    }

    public override void visit_slt (Slt inst)
    {
      write_line ("%4s, %4s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_mult (Mult inst)
    {
      write_line ("%4s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_multu (Multu inst)
    {
      write_line ("%4s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_mfhi (Mfhi inst)
    {
      write_line ("%s", inst.rd.to_string());
    }

    public override void visit_mthi (Mthi inst)
    {
      write_line ("%s", inst.rs.to_string());
    }

    public override void visit_blez (Blez inst) {
		if (inst.reference != null) {
			write_line ("%4s, %s", inst.rs.to_string(), inst.reference.to_string());
		} else {
			write_line ("%4s, 0x%x", inst.rs.to_string(), inst.offset);
		}
    }

    public override void visit_bgtz (Bgtz inst) {
		if (inst.reference != null) {
			write_line ("%4s, %s", inst.rs.to_string(), inst.reference.to_string());
		} else {
			write_line ("%4s, 0x%x", inst.rs.to_string(), inst.offset);
		}
    }

    public override void visit_bgtzl (Bgtzl inst) {
		if (inst.reference != null) {
			write_line ("%4s, %s", inst.rs.to_string(), inst.reference.to_string());
		} else {
			write_line ("%4s, 0x%x", inst.rs.to_string(), inst.offset);
		}
    }

    public override void visit_xori (Xori inst)
    {
      write_line ("%4s, %4s, %d", inst.rt.to_string(), inst.rs.to_string(), inst.immediate);
    }

    public override void visit_clo (Clo inst)
    {
      write_line ("%4s, %s", inst.rd.to_string(), inst.rs.to_string());
    }

    public override void visit_clz (Clz inst)
    {
      write_line ("%4s, %s", inst.rd.to_string(), inst.rs.to_string());
    }

    public override void visit_mul (Mul inst)
    {
      write_line ("%4s, %4s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_nor (Nor inst)
    {
      write_line ("%4s, %4s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_xor (Xor inst)
    {
      write_line ("%4s, %4s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_srlv (Srlv inst)
    {
      if (inst.is_rotr ())
        write_line ("%4s, %4s, %s", inst.rd.to_string(), inst.rt.to_string(), inst.rs.to_string());
      else
        write_line ("%4s, %4s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_srav (Srav inst)
    {
      write_line ("%4s, %4s, %s", inst.rd.to_string(), inst.rt.to_string(), inst.rs.to_string());
    }

    public override void visit_divu (Divu inst)
    {
      write_line ("%4s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_break (Break inst)
    {
    }

    public override void visit_mflo (Mflo inst)
    {
      write_line ("%s", inst.rd.to_string());
    }

    public override void visit_mtlo (Mtlo inst)
    {
      write_line ("%s", inst.rs.to_string());
    }

    public override void visit_movz (Movz inst)
    {
      write_line ("%4s, %4s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_movn (Movn inst)
    {
      write_line ("%4s, %4s, %s", inst.rd.to_string(), inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_div (Div inst)
    {
      write_line ("%4s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_blezl (Blezl inst) {
		if (inst.reference != null) {
			write_line ("%4s, %s", inst.rs.to_string(), inst.reference.to_string());
		} else {
			write_line ("%4s, 0x%x", inst.rs.to_string(), inst.offset);
		}
    }

    public override void visit_sdc1 (Sdc1 inst)
    {
      write_line ("%4s, %d(%s)", inst.ft.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_sdc2 (Sdc2 inst)
    {
      write_line ("%4s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_cop1x_sdxc1 (Cop1x.Sdxc1 inst)
    {
      write_line ("%4s, %d(%s)", inst.fs.to_string(), inst.index, inst.@base.to_string());
    }

    public override void visit_cop1x_ldxc1 (Cop1x.Ldxc1 inst)
    {
      write_line ("%4s, %d(%s)", inst.fd.to_string(), inst.index, inst.@base.to_string());
    }

    public override void visit_cop1x_luxc1 (Cop1x.Luxc1 inst)
    {
      write_line ("%4s, %d(%s)", inst.fd.to_string(), inst.index, inst.@base.to_string());
    }

    public override void visit_cop1x_lwxc1 (Cop1x.Lwxc1 inst)
    {
      write_line ("%4s, %d(%s)", inst.fd.to_string(), inst.index, inst.@base.to_string());
    }

    public override void visit_cop1x_suxc1 (Cop1x.Suxc1 inst)
    {
      write_line ("%4s, %d(%s)", inst.fs.to_string(), inst.index, inst.@base.to_string());
    }

    public override void visit_cop1x_swxc1 (Cop1x.Swxc1 inst)
    {
      write_line ("%4s, %d(%s)", inst.fs.to_string(), inst.index, inst.@base.to_string());
    }

    public override void visit_ldc1 (Ldc1 inst)
    {
      write_line ("%4s, %d(%s)", inst.ft.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_ldc2 (Ldc2 inst)
    {
      write_line ("%4s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_lwc1 (Lwc1 inst)
    {
      write_line ("%4s, %d(%s)", inst.ft.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_lwc2 (Lwc2 inst)
    {
      write_line ("%4s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_swc1 (Swc1 inst)
    {
      write_line ("%4s, %d(%s)", inst.ft.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_swc2 (Swc2 inst)
    {
      write_line ("%4s, %d(%s)", inst.rt.to_string(), inst.offset, inst.@base.to_string());
    }

    public override void visit_jump (Jump inst)
    {
      write_line ("0x%x", inst.instr_index);
    }

    public override void visit_jal (Jal inst)
    {
      write_line ("0x%x", inst.instr_index);
    }

    public override void visit_sdbbp (Sdbbp inst)
    {
      write_line ("0x%x", inst.code);
    }

    public override void visit_syscall (Syscall inst)
    {
      write_line ("0x%x", inst.code);
    }

    public override void visit_teq (Teq inst)
    {
      write_line ("%4s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_regimm_teqi (Regimm.Teqi inst)
    {
      write_line ("%4s, %d", inst.rs.to_string(), inst.immediate);
    }

    public override void visit_tge (Tge inst)
    {
      write_line ("%4s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_regimm_tgei (Regimm.Tgei inst)
    {
      write_line ("%4s, %u", inst.rs.to_string(), inst.immediate);
    }

    public override void visit_regimm_tgeiu (Regimm.Tgeiu inst)
    {
      write_line ("%4s, %u", inst.rs.to_string(), inst.immediate);
    }

    public override void visit_tgeu (Tgeu inst)
    {
      write_line ("%4s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_cop0_tlbp (Cop0.Tlbp inst)
    {
    }

    public override void visit_cop0_tlbr (Cop0.Tlbr inst)
    {
    }

    public override void visit_cop0_tlbwi (Cop0.Tlbwi inst)
    {
    }

    public override void visit_cop0_tlbwr (Cop0.Tlbwr inst)
    {
    }

    public override void visit_cop0_wait (Cop0.Wait inst)
    {
    }

    public override void visit_tlt (Tlt inst)
    {
      write_line ("%4s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_regimm_tlti (Regimm.Tlti inst)
    {
      write_line ("%4s, %u", inst.rs.to_string(), inst.immediate);
    }

    public override void visit_regimm_tltiu (Regimm.Tltiu inst)
    {
      write_line ("%4s, %u", inst.rs.to_string(), inst.immediate);
    }
   
    public override void visit_tltu (Tltu inst)
    {
      write_line ("%4s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_tne (Tne inst)
    {
      write_line ("%4s, %s", inst.rs.to_string(), inst.rt.to_string());
    }

    public override void visit_regimm_tnei (Regimm.Tnei inst)
    {
      write_line ("%4s, %u", inst.rs.to_string(), inst.immediate);
    }
  }
}
