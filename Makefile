# $Id: Makefile,v 1.2 2005/10/25 02:08:15 jcs Exp $
# vim:ts=8

PROG	= blueping
OBJS	= $(PROG).o

CC	= env MACOSX_DEPLOYMENT_TARGET=10.4 cc
CFLAGS	= -O2 -Wall -Wunused -Wmissing-prototypes -Wstrict-prototypes

PREFIX	= /usr/local
BINDIR	= $(DESTDIR)$(PREFIX)/bin

INSTALL_PROGRAM = install -s

INCLUDES=
LDPATH	=
LIBS	= -framework CoreServices -framework IOBluetooth

VERS	:= `grep Id ${PROG}.c | sed -e 's/.*,v //' -e 's/ .*//'`

all: $(PROG)

$(PROG): $(OBJS)
	$(CC) $(OBJS) $(LDPATH) $(LIBS) -o $@

$(OBJS): %.o: %.c
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

install: all
	$(INSTALL_PROGRAM) $(PROG) $(BINDIR)

clean:
	rm -f $(PROG) $(OBJS) 

release: all
	@mkdir $(PROG)-${VERS}
	@cp Makefile README *.c $(PROG) $(PROG)-$(VERS)/
	@tar -czf ../$(PROG)-$(VERS).tar.gz $(PROG)-$(VERS)
	@rm -rf $(PROG)-$(VERS)/
	@echo "made release ${VERS}"

.PHONY: all install clean

