VALAC = valac
SRCS = main.vala parser.vala instruction.vala assemblywriter.vala header.vala binarycode.vala resolver.vala
PREFIX = /usr/local
DESTDIR = $(PREFIX)

all: mipsdis

install: mipsdis
	install mipsdis $(DESTDIR)/bin

mipsdis: $(SRCS)
	$(VALAC) -g --thread --pkg gio-2.0 --vapidir . -o mipsdis $+

dist: mipsdis
	git archive --format=tar --prefix=mipsdis-1.0/ HEAD|gzip > mipsdis-1.0.tar.gz

clean:
	rm -f mipsdis *.c

.PHONY: install dist
