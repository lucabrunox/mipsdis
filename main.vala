/* main.vala
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

public class Mips.Disassembler
{
  static bool version;
  [CCode (array_length = false, array_null_terminated = true)]
  static string[] binary;

  const OptionEntry[] options = {
    { "version", 0, 0, OptionArg.NONE, ref version, "Display version number", null },
    { "", 0, 0, OptionArg.FILENAME_ARRAY, ref binary, null, "FILE" },
    { null }
  };

  public int run ()
  {
    try
      {
        var fstream = File.new_for_path(binary[0]).read (null);
        var stream = new DataInputStream (fstream);

        var parser = new Parser (stream);
        var binary_code = parser.parse ();

        var resolver = new SymbolResolver (binary_code);
        resolver.resolve ();

        var writer = new AssemblyWriter ();
        var result = writer.write (binary_code);
        stdout.puts (result);
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
    try
    {
      var opt_context = new OptionContext ("- Mips Disassembler");
      opt_context.set_help_enabled (true);
      opt_context.add_main_entries (options, null);
      opt_context.parse (ref args);
    }
    catch (OptionError e)
    {
      stdout.printf ("%s\n", e.message);
      stdout.printf ("Run '%s --help' to see a full list of available command line options.\n", args[0]);
      return 1;
    }
	
    if (version)
      {
        stdout.printf ("mipsdis 1.0\n");
        return 0;
      }
	
    if (binary == null)
      {
        stderr.printf ("No binary file specified.\n");
        return 1;
      }
    
    var dis = new Disassembler ();
    return dis.run ();
  }
}