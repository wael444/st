# st - simple terminal
# See LICENSE file for copyright and license details.
.POSIX:

# st version
VERSION = 0.8.5

# paths
PREFIX = /usr/local

# flags
STCPPFLAGS = -DVERSION=\"$(VERSION)\" -D_XOPEN_SOURCE=600
STCFLAGS = -I/usr/include/freetype2 $(STCPPFLAGS) $(CPPFLAGS) $(CFLAGS)
STLDFLAGS = -lm -lrt -lX11 -lutil -lXft -lfontconfig -lfreetype $(LDFLAGS)

# compiler and linker
CC = tcc

SRC = st.c x.c
OBJ = $(SRC:.c=.o)

all: st

.c.o:
	$(CC) $(STCFLAGS) -c $<

st.o: config.h st.h win.h
x.o: arg.h config.h st.h win.h

$(OBJ): config.h

st: $(OBJ)
	$(CC) -o $@ $(OBJ) $(STLDFLAGS)

clean:
	rm -f st $(OBJ)

install: st
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f st $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/st
	tic -sx st.info

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/st

.PHONY: all clean install uninstall
