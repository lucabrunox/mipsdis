VALAC = valac
SRCS = main.vala parser.vala instruction.vala assemblywriter.vala
PREFIX = /usr/local
DESTDIR = $(PREFIX)

all: mipsdis

mipsdis: $(SRCS)
	$(VALAC) -g --pkg gio-2.0 -o mipsdis $+

clean:
	rm -f mipsdis *.c