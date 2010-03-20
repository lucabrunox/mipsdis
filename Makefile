VALAC = valac
SRCS = main.vala parser.vala instruction.vala assemblywriter.vala header.vala binarycode.vala
PREFIX = /usr/local
DESTDIR = $(PREFIX)

all: mipsdis

mipsdis: $(SRCS)
	$(VALAC) -g --thread --pkg gio-2.0 --vapidir . -o mipsdis $+

clean:
	rm -f mipsdis *.c