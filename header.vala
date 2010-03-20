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
    public class Entry
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
          MIPS_BASE_ADDRESS = 0x70000006
        }
      public Type type;
      public uint value;
    }
    private Entry[] entries;

    public DynamicSection.from_stream (DataInputStream stream) throws Error
    {
      while (true)
        {
          var type = (Entry.Type)stream.read_uint32 (null);
          if (type == Entry.Type.NULL)
            break;

          var entry = new Entry ();
          entry.type = type;
          entry.value = stream.read_uint32 (null);
          entries.resize (entries.length+1);
          entries[entries.length-1] = entry;
        }
      if (stream.read_uint32(null) != 0)
        throw new HeaderError.INVALID_SECTION ("Invalid NULL entry in dynamic section");
    }

    public Entry? get_entry_by_type (Entry.Type type)
    {
      foreach (var entry in entries)
        {
          if (entry.type == type)
            return entry;
        }
      return null;
    }

    public int get_size ()
    {
      return entries.length + 1;
    }
  }
}