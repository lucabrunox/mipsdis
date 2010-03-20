namespace Mips
{
  public errordomain HeaderError
  {
    NOT_ELF,
    UNSUPPORTED_PROGRAM_HEADER,
    INVALID_SECTION,
  }

  public class ELFHeader
  {
    public uint16 type;
    public uint16 machine;
    public uint32 version;
    public uint32 entry;
    public uint32 phoff;
    public uint32 shoff;
    public uint32 flags;
    public uint16 ehsize;
    public uint16 phentsize;
    public uint16 phnum;
    public uint16 shentsize;
    public uint16 shnum;
    public uint16 shstrndx;

    public ELFHeader.from_stream (DataInputStream stream) throws Error
    {
      char[] magic = new char[16];
      stream.read (magic, 16, null);
      if (magic[0] != 0x7f || magic[1] != 'E' || magic[2] != 'L' || magic[3] != 'F')
        throw new HeaderError.NOT_ELF ("Unknown magic value");

      type = stream.read_uint16 (null);
      machine = stream.read_uint16 (null);
      version = stream.read_uint32 (null);
      entry = stream.read_uint32 (null);
      phoff = stream.read_uint32 (null);
      shoff = stream.read_uint32 (null);
      flags = stream.read_uint32 (null);
      ehsize = stream.read_uint16 (null);
      phentsize = stream.read_uint16 (null);
      phnum = stream.read_uint16 (null);
      shentsize = stream.read_uint16 (null);
      shnum = stream.read_uint16 (null);
      shstrndx = stream.read_uint16 (null);

      if (phentsize != 32)
        throw new HeaderError.UNSUPPORTED_PROGRAM_HEADER ("Unsupported program header size %d\n", phentsize);
    }
  }

  public class ProgramHeader
  {
    public enum Type
      {
        NULL,
        LOAD,
        DYNAMIC,
        INTERP,
        NOTE,
        SHLIB,
        PHDR,
        TLS,
        NUM,
      }

    public Type type;
    public uint offset;
    public uint virtual_addr;
    public uint physical_addr;
    public uint file_size;
    public uint mem_size;
    public uint flags;
    public uint align;

    public ProgramHeader.from_stream (DataInputStream stream) throws Error
    {
      type = (Type)stream.read_uint32 (null);
      offset = stream.read_uint32 (null);
      virtual_addr = stream.read_uint32 (null);
      physical_addr = stream.read_uint32 (null);
      file_size = stream.read_uint32 (null);
      mem_size = stream.read_uint32 (null);
      flags = stream.read_uint32 (null);
      align = stream.read_uint32 (null);
    }
  }

  public class DynamicSection
  {
    public enum Type
      {
        NULL,
        STRTAB=5,
        SYMTAB,
        STRSZ=10,
        SYMENT,
        INIT,
        FINI,
        MIPS_BASE_ADDRESS = 0x70000006,
        MIPS_LOCAL_GOTNO = 0x7000000a,
        MIPS_SYMTABNO = 0x70000011,
        MIPS_GOTSYM = 0x70000013
      }   
      public Type type;
      public uint value;
  }

  public class DynamicHeader
  {
    private DynamicSection[] sections;

    public DynamicHeader.from_stream (DataInputStream stream) throws Error
    {
      while (true)
        {
          var type = (DynamicSection.Type)stream.read_uint32 (null);
          if (type == DynamicSection.Type.NULL)
            break;

          var section = new DynamicSection ();
          section.type = type;
          section.value = stream.read_uint32 (null);
          sections.resize (sections.length+1);
          sections[sections.length-1] = section;
        }
      if (stream.read_uint32(null) != 0)
        throw new HeaderError.INVALID_SECTION ("Invalid NULL dynamic section");
    }

    public DynamicSection get_section_by_type (DynamicSection.Type type)
    {
      foreach (var section in sections)
        {
          if (section.type == type)
            return section;
        }
      assert_not_reached ();
    }

    public int get_size ()
    {
      return sections.length + 1;
    }
  }

  public class Symbol
  {
    public enum Info
      {
        NOTYPE = 0,
        OBJECT = 0x11,
        FUNC = 0x12,
      }
    public enum Other
      {
        DEFAULT,
        INTERNAL,
        HIDDEN,
        PROTECTED
      }

    public uint name;
    public uint value;
    public uint size;
    public Info info;
    public Other other;
    public uint16 shndx;

    public Symbol.from_stream (DataInputStream stream) throws Error
    {
      name = stream.read_uint32 (null);
      value = stream.read_uint32 (null);
      size = stream.read_uint32 (null);
      info = (Info) stream.read_byte (null);
      other = (Other) stream.read_byte (null);
      shndx = stream.read_uint16 (null);
    }
  }

  public class SymbolTable
  {
    static const int16 BASE_GP = -0x7ff0;

    private Symbol[] symbols;
    private uint first_got_index;
    private int16 global_gp;

    public SymbolTable.from_stream (DataInputStream stream, DynamicHeader dh) throws Error
    {
      var sym_no = dh.get_section_by_type(DynamicSection.Type.MIPS_SYMTABNO).value;
      symbols = new Symbol[sym_no];

      var local_gotno = dh.get_section_by_type(DynamicSection.Type.MIPS_LOCAL_GOTNO).value;
      global_gp = (int16)(BASE_GP + local_gotno * 4);
      first_got_index = dh.get_section_by_type(DynamicSection.Type.MIPS_GOTSYM).value;

      for (int i=0; i < sym_no; i++)
        {
          var symbol = new Symbol.from_stream (stream);
          symbols[i] = symbol;
        }
    }

    public Symbol symbol_at_gp_offset (int16 offset)
    {
      return symbols[(offset - global_gp)/4 + first_got_index];
    }

    public int get_size ()
    {
      return symbols.length * 16;
    }
  }

  public class StringTable
  {
    private char[] strings;

    public StringTable.from_stream (DataInputStream stream, DynamicHeader dh) throws Error
    {
      var table_size = dh.get_section_by_type(DynamicSection.Type.STRSZ).value;
      strings = new char[table_size];
      stream.read (strings, strings.length, null);
    }

    public unowned string string_at_offset (uint offset)
    {
      return (string)(&strings[offset]);
    }

    public int get_size ()
    {
      return strings.length;
    }
  }
}