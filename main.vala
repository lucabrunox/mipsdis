public class Mips.Disassembler
{
  static bool version;
  static int offset;
  [CCode (array_length = false, array_null_terminated = true)]
  static string[] binary;

  const OptionEntry[] options = {
    { "offset", 'o', 0, OptionArg.INT, ref offset, "Start disassemble at given offset", "OFFSET" },
    { "version", 0, 0, OptionArg.NONE, ref version, "Display version number", null },
    { "", 0, 0, OptionArg.FILENAME_ARRAY, ref binary, null, "FILE" },
    { null }
  };

  public int run ()
  {
    try
      {
        var fstream = File.new_for_path(binary[0]).read (null);
        fstream.seek (offset, SeekType.SET, null);
        var stream = new DataInputStream (fstream);
        var parser = new Parser (stream);
        var writer = new AssemblyWriter ();
        bool has_next = true;
        while (has_next)
          {
            int code;
            try
              {
                var instruction = parser.next_instruction (out has_next, out code);
                var result = writer.write_instruction (instruction);
                stdout.printf ("%x:\t%.8x\t%s\n", (uint)(parser.offset + offset), code, result);
              }
            catch (Error e)
            {
              stderr.printf ("%x:\t%.8x\t%s\n", (uint)(parser.offset + offset), code, e.message);
              return 1;
            }
          }
      }
    catch (Error e)
    {
      stderr.printf ("%s\n", e.message);
      return 1;
    }
    return 0;
  }

  public static int main (string[] args)
  {
    try {
      var opt_context = new OptionContext ("- Mips Disassembler");
      opt_context.set_help_enabled (true);
      opt_context.add_main_entries (options, null);
      opt_context.parse (ref args);
    } catch (OptionError e) {
      stdout.printf ("%s\n", e.message);
      stdout.printf ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
      return 1;
    }
	
    if (version) {
      stdout.printf ("mipsdis 1.0\n");
      return 0;
    }
	
    if (binary == null) {
      stderr.printf ("No binary file specified.\n");
      return 1;
    }
    
    var dis = new Disassembler ();
    return dis.run ();
  }
}