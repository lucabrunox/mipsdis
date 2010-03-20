namespace Mips
{
  public errordomain ParserError
  {
    UNKNOWN_INSTRUCTION,
  }

  public class Parser
  {
    private DataInputStream stream;
    private BinaryCode binary_code = new BinaryCode ();

    public Parser (DataInputStream stream)
    {
      this.stream = stream;
    }

    public BinaryCode parse () throws Error
    {
      uint offset = 0;
      stream.set_byte_order (DataStreamByteOrder.BIG_ENDIAN);
      var elfh = new ELFHeader.from_stream (stream);
      offset += elfh.ehsize;

      stream.skip (elfh.phoff-offset, null);
      ProgramHeader? dynamic = null;
      for (int i=0; i < elfh.phnum; i++)
        {
          var phdr = new ProgramHeader.from_stream (stream);
          if (phdr.type == ProgramHeader.Type.DYNAMIC)
            dynamic = phdr;
        }
      offset += elfh.phentsize * elfh.phnum;

      stream.skip (dynamic.offset - offset, null);
      offset = dynamic.offset;
      var dynamic_header = new DynamicHeader.from_stream (stream);
      var base_address = dynamic_header.get_section_by_type(DynamicSection.Type.MIPS_BASE_ADDRESS).value;
      offset += dynamic_header.get_size() * 8;

      var symtab_offset = dynamic_header.get_section_by_type(DynamicSection.Type.SYMTAB).value - base_address;
      stream.skip (symtab_offset - offset, null);
      offset = symtab_offset;
      binary_code.symbol_table = new SymbolTable.from_stream (stream, dynamic_header);
      offset += binary_code.symbol_table.get_size ();

      var strtab_offset = dynamic_header.get_section_by_type(DynamicSection.Type.STRTAB).value - base_address;
      stream.skip (strtab_offset - offset, null);
      offset = strtab_offset;
      binary_code.string_table = new StringTable.from_stream (stream, dynamic_header);
      offset += binary_code.string_table.get_size ();

      // Start disassembling from (INIT) to (FINI)
      var init_address = dynamic_header.get_section_by_type(DynamicSection.Type.INIT).value;
      var fini_address = dynamic_header.get_section_by_type(DynamicSection.Type.FINI).value;
      var init_file_offset = init_address - base_address;
      var fini_file_offset = fini_address - base_address;
      stream.skip (init_file_offset - offset, null);
      offset = init_file_offset;

      binary_code.text_section = new TextSection (init_file_offset, init_address);
      binary_code.text_section.set_instructions ((int)((fini_file_offset - init_file_offset)/4));
      while (offset < fini_file_offset)
        {
          var code = stream.read_int32 (null);
          Instruction instruction;
          try
            {
              instruction = instruction_from_code (code);
            }
          catch (Error e)
          {
            stderr.printf ("At file offset 0x%x\n", offset);
            throw e;
          }
          binary_code.text_section.add_instruction (new BinaryInstruction (instruction, offset, code, offset + base_address));
          offset += 4;
        }

      return binary_code;
    }

    private Instruction instruction_from_code (int code) throws ParserError
    {
      if (code == 0)
        return new Nop ();
      else if (code == 0x40)
        return new Ssnop ();

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
              throw new ParserError.UNKNOWN_INSTRUCTION ("MOV bit 17 != 0");
            return new Movci.from_code (code);
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
          case 0x0C:
            return new Syscall.from_code (code);
          case 0x0D:
            return new Break.from_code (code);
          case 0x0F:
            return new Sync.from_code (code);
          case 0x10:
            if (get_five1 (code) != 0 || get_five2 (code) != 0 || get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("MFHI 25-16 or 10-6 not zero");
            return new Mfhi.from_code (code);
          case 0x11:
            if (get_five2 (code) != 0 || get_five3 (code) != 0 || get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("MTHI 25-6 not zero");
            return new Mthi.from_code (code);
          case 0x12:
            if (get_five1 (code) != 0 || get_five2 (code) != 0 || get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("MFLO 25-16 or 10-6 not zero");
            return new Mflo.from_code (code);
          case 0x13:
            if (get_five2 (code) != 0 || get_five3 (code) != 0 || get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("MTLO 25-6 not zero");
            return new Mtlo.from_code (code);
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
          case 0x32:
            return new Tlt.from_code (code);
          case 0x33:
            return new Tltu.from_code (code);
          case 0x34:
            return new Teq.from_code (code);
          case 0x36:
            return new Tne.from_code (code);
          case 0x38:
            return new Tge.from_code (code);
          case 0x39:
            return new Tgeu.from_code (code);
          default:
            throw new ParserError.UNKNOWN_INSTRUCTION ("Unknown SPECIAL instruction 0x%x (0x%x)", func, code);
          }

      case REGIMM:
        int func = get_five2 (code);
        switch (func)
          {
          case 0x00:
            return new Regimm.Bltz.from_code (code);
          case 0x01:
            return new Regimm.Bgez.from_code (code);
          case 0x02:
            return new Regimm.Bltzl.from_code (code);
          case 0x03:
            return new Regimm.Bgezl.from_code (code);
          case 0x08:
            return new Regimm.Tgei.from_code (code);
          case 0x09:
            return new Regimm.Tgeiu.from_code (code);
          case 0x10:
            return new Regimm.Bltzal.from_code (code);
          case 0x11:
            return new Regimm.Bgezal.from_code (code);
          case 0x12:
            return new Regimm.Bltzall.from_code (code);
          case 0x13:
            return new Regimm.Bgezall.from_code (code);
          case 0x0A:
            return new Regimm.Tlti.from_code (code);
          case 0x0B:
            return new Regimm.Tltiu.from_code (code);
          case 0x0C:
            return new Regimm.Teqi.from_code (code);
          case 0x0E:
            return new Regimm.Tnei.from_code (code);
          case 0x1F:
            return new Regimm.Synci.from_code (code);
          default:
            throw new ParserError.UNKNOWN_INSTRUCTION ("Unknown REGIMM instruction 0x%x (0x%x)", func, code);
          }

      case COP0:
        int func = get_five1 (code);
        switch (func)
          {
          case 0x00:
            if (((code >> 3) & 0xFF) == 0)
              return new Cop0.Mf.from_code (code);
            break;
          case 0x04:
            if (((code >> 3) & 0xFF) == 0)
              return new Cop0.Mt.from_code (code);
            break;
          case 0x0A:
            if ((code & 0x7FF) == 0)
              return new Cop0.Rdpgpr.from_code (code);
            break;
          case 0x0E:
            if ((code & 0x7FF) == 0)
              return new Cop0.Wrpgpr.from_code (code);
            break;
          }

        func = code & 0x3F;
        switch (func)
          {
          case 0x01:
            if (code != 0x42000001)
              throw new ParserError.UNKNOWN_INSTRUCTION ("Invalid TLBR");
            return new Cop0.Tlbr ();
          case 0x02:
            if (code != 0x42000001)
              throw new ParserError.UNKNOWN_INSTRUCTION ("Invalid TLBWI");
            return new Cop0.Tlbwi ();
          case 0x06:
            if (code != 0x42000006)
              throw new ParserError.UNKNOWN_INSTRUCTION ("Invalid TLBWR");
            return new Cop0.Tlbwr ();
          case 0x08:
            if (code != 0x42000008)
              throw new ParserError.UNKNOWN_INSTRUCTION ("Invalid TLBP");
            return new Cop0.Tlbp ();
          case 0x18:
            if (code != 0x42000018)
              throw new ParserError.UNKNOWN_INSTRUCTION ("Invalid ERET");
            return new Cop0.Eret ();
          case 0x20:
            if (((code >> 24) & 1) != 1)
              throw new ParserError.UNKNOWN_INSTRUCTION ("Invalid WAIT");
            return new Cop0.Eret ();
          case 0x1F:
            if (code != 0x4200001F)
              throw new ParserError.UNKNOWN_INSTRUCTION ("Invalid DERET");
            return new Cop0.Deret ();
          default:
            throw new ParserError.UNKNOWN_INSTRUCTION ("Unknown COP0 instruction 0x%x (0x%x)", func, code);
          }

      case COP1:
        if (((code >> 4) & 0x0F) == 0x03) // 7-4
          return new Cop1.Ccond.from_code (code);

        int func = get_five1 (code);
        switch (func)
          {
          case 0x00:
            if ((code & 0x3FF) == 0)
              return new Cop1.Mf.from_code (code);
            break;
          case 0x02:
            if ((code & 0x3FF) == 0)
              return new Cop1.Cf.from_code (code);
            break;
          case 0x03:
            if ((code & 0x3FF) == 0)
              return new Cop1.Mfh.from_code (code);
            break;
          case 0x04:
            if ((code & 0x3FF) == 0)
              return new Cop1.Mt.from_code (code);
            break;
          case 0x06:
            if ((code & 0x3FF) == 0)
              return new Cop1.Ct.from_code (code);
            break;
          case 0x07:
            if ((code & 0x3FF) == 0)
              return new Cop1.Mth.from_code (code);
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
          case 0x07:
            if (get_five2 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("NEG 20-16 not zero");
            return new Cop1.Neg.from_code (code);
          case 0x08:
            if (get_five2 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("ROUND.L 20-16 not zero");
            return new Cop1.Roundl.from_code (code);
          case 0x09:
            if (get_five2 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("TRUNC.L 20-16 not zero");
            return new Cop1.Truncl.from_code (code);
          case 0x0C:
            if (get_five2 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("ROUND.W 20-16 not zero");
            return new Cop1.Roundw.from_code (code);
          case 0x0D:
            if (get_five2 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("TRUNC.W 20-16 not zero");
            return new Cop1.Truncw.from_code (code);
          case 0x0E:
            if (get_five2 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("CEIL.W 20-16 not zero");
            return new Cop1.Ceilw.from_code (code);
          case 0x0F:
            if (get_five2 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("FLOOR.W 20-16 not zero");
            return new Cop1.Floorw.from_code (code);
          case 0x11:
            return new Cop1.Movcf.from_code (code);
          case 0x12:
            return new Cop1.Movz.from_code (code);
          case 0x15:
            return new Cop1.Recip.from_code (code);
          case 0x16:
            if (get_five2 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("RQSRT 20-16 not zero");
            return new Cop1.Rsqrt.from_code (code);
          case 0x20:
            if (get_five2 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("CVT.S 20-16 not zero");
            return new Cop1.Cvts.from_code (code);
          case 0x21:
            if (get_five2 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("CVT.D 20-16 not zero");
            return new Cop1.Cvtd.from_code (code);
          case 0x24:
            if (get_five2 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("CVT.W 20-16 not zero");
            return new Cop1.Cvtw.from_code (code);
          case 0x2C:
            if (get_five1 (code) != 0x16)
              throw new ParserError.UNKNOWN_INSTRUCTION ("PLL.PS 20-16 not 0x16");
            return new Cop1.Pll.from_code (code);
          case 0x2D:
            if (get_five1 (code) != 0x16)
              throw new ParserError.UNKNOWN_INSTRUCTION ("PLU.PS 20-16 not 0x16");
            return new Cop1.Plu.from_code (code);
          case 0x2E:
            if (get_five1 (code) != 0x16)
              throw new ParserError.UNKNOWN_INSTRUCTION ("PUL.PS 20-16 not 0x16");
            return new Cop1.Pul.from_code (code);
          case 0x2F:
            if (get_five1 (code) != 0x16)
              throw new ParserError.UNKNOWN_INSTRUCTION ("PUU.PS 20-16 not 0x16");
            return new Cop1.Puu.from_code (code);
          default:
            throw new ParserError.UNKNOWN_INSTRUCTION ("Unknown COP1 instruction 0x%x (0x%x)", func, code);
          }

      case SPECIAL2:
        int func = code & 0x3F;
        switch (func)
          {
          case 0x00:
            if (get_five3 (code) != 0 || get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("MADD 15-6 not zero");
            return new Madd.from_code (code);
          case 0x01:
            if (get_five3 (code) != 0 || get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("MADDU 15-6 not zero");
            return new Maddu.from_code (code);
          case 0x02:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("MUL 10-6 not zero");
            return new Mul.from_code (code);
          case 0x04:
            if (get_five3 (code) != 0 || get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("MSUB 15-6 not zero");
            return new Msub.from_code (code);            
          case 0x05:
            if (get_five3 (code) != 0 || get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("MSUBU 15-6 not zero");
            return new Msubu.from_code (code);            
          case 0x20:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("CLZ 10-6 not zero");
            return new Clz.from_code (code);
          case 0x21:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("CLO 10-6 not zero");
            return new Clo.from_code (code);
          case 0x3F:
            return new Sdbbp.from_code (code);
          default:
            throw new ParserError.UNKNOWN_INSTRUCTION ("Unknown SPECIAL2 instruction 0x%x (0x%x)", func, code);
          }

      case COP2:
        int func = get_five1 (code);
        switch (func)
          {
          case 0x00:
            return new Cop2.Mf.from_code (code);
          case 0x02:
            if ((code & 0x3FF) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("CFC2 10-0 not zero");
            return new Cop2.Cf.from_code (code);
          case 0x03:
            return new Cop2.Mfh.from_code (code);
          case 0x04:
            return new Cop2.Mt.from_code (code);
          case 0x06:
            if ((code & 0x3FF) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("CTC2 10-0 not zero");
            return new Cop2.Ct.from_code (code);
          default:
            throw new ParserError.UNKNOWN_INSTRUCTION ("Unknown COP2 instruction 0x%x (0x%x)", func, code);
          }

      case COP1X:
        int func = (code >> 3) & 0x07;
        switch (func)
          {
          case 0x04:
            return new Cop1x.Madd.from_code (code);
          case 0x05:
            return new Cop1x.Msub.from_code (code);
          case 0x06:
            return new Cop1x.Nmadd.from_code (code);
          case 0x07:
            return new Cop1x.Nmsub.from_code (code);
          case 0x08:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("SWXC1 5-0 not zero");
            return new Cop1x.Swxc1.from_code (code);
          case 0x09:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("SDXC1 5-0 not zero");
            return new Cop1x.Sdxc1.from_code (code);
          case 0x0D:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("SUXC1 5-0 not zero");
            return new Cop1x.Suxc1.from_code (code);
          case 0x0F:
            if (get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("PREFX 10-6 not zero");
            return new Cop1x.Prefx.from_code (code);
          default:
            throw new ParserError.UNKNOWN_INSTRUCTION ("Unknown COP1X instruction 0x%x (0x%x)", func, code);
          }

      case SPECIAL3:
        int func = code & 0x3F;
        switch (func)
          {
          case 0x20:
            if (get_five1 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("BSHFL 25-21 not zerO");
            if (get_five4 (code) == 0x04)
              return new Wsbh.from_code (code);
            else if (get_five4 (code) == 0x10)
              return new Seb.from_code (code);
            else if (get_five4 (code) == 0x18)
              return new Seh.from_code (code);
            else
              throw new ParserError.UNKNOWN_INSTRUCTION ("Unknown BSHFL instruction");
          case 0x3B:
            if (get_five1 (code) != 0 || get_five4 (code) != 0)
              throw new ParserError.UNKNOWN_INSTRUCTION ("RDHWR either 25-21 or 10-6 not zero");
            return new Rdhwr.from_code (code);
          default:
            throw new ParserError.UNKNOWN_INSTRUCTION ("Unknown SPECIAL3 instruction 0x%x (0x%x)", func, code);
          }

      case 0x02:
        return new Jump.from_code (code);

      case 0x03:
        return new Jal.from_code (code);

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

      case 0x15:
        return new Bnel.from_code (code);

      case 0x16:
        if (get_five2 (code) != 0)
          throw new ParserError.UNKNOWN_INSTRUCTION ("BLEZL 20-16 not zero");
        return new Blezl.from_code (code);

      case 0x17:
        if (get_five2 (code) != 0)
          throw new ParserError.UNKNOWN_INSTRUCTION ("BGTZL 20-16 not zero");
        return new Bgtzl.from_code (code);

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

      case 0x2F:
        return new Cache.from_code (code);

      case 0x30:
        return new Ll.from_code (code);

      case 0x31:
        return new Lwc1.from_code (code);

      case 0x32:
        return new Lwc2.from_code (code);

      case 0x33:
        return new Pref.from_code (code);

      case 0x35:
        return new Ldc1.from_code (code);

      case 0x36:
        return new Ldc2.from_code (code);

      case 0x38:
        return new Sc.from_code (code);

      case 0x39:
        return new Swc1.from_code (code);

      case 0x3A:
        return new Swc2.from_code (code);

      case 0x3D:
        return new Sdc1.from_code (code);

      case 0x3E:
        return new Sdc2.from_code (code);

      default:
        throw new ParserError.UNKNOWN_INSTRUCTION ("Unknown instruction 0x%x (0x%x)", opcode, code);
      }
    }
  }
}
