MAIN = ndwm
BIN = bin
SRCDIR = src

# Install directory
INSTALLDIR = /usr/local/bin

# X11
X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

# Freetype
FREETYPELIBS = -lfontconfig -lXft
FREETYPEINC = /usr/include/freetype2

# Includes and libs
INCS = -I${X11INC} -I${FREETYPEINC}
LDFLAGS = -L${X11LIB} -lX11 ${FREETYPELIBS}

# Flags
COPTIONS = -pedantic -Wall -Wextra -Wunused -Wunused-function -Wunused-local-typedefs -Wunused-macros -Os
CPPFLAGS = -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=700L  
CFLAGS   = -std=c99 ${COPTIONS} ${INCS} ${CPPFLAGS}

# Compiler
CC = cc

SRC = ${SRCDIR}/*.c
OBJ = ${SRC:.c=.o}

all: dirs options ${MAIN}

dirs:
	mkdir -p bin

options:
	@echo ${MAIN} build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	${CC} -c ${CFLAGS} ${SRC}

${MAIN}: ${OBJ}
	${CC} -o ${BIN}/$@ *.o ${LDFLAGS}

clean:
	rm -f ${BIN}/${MAIN} *.o

install: all
	mkdir -p ${DESTDIR}${INSTALLDIR}
	install -m 0755 ${BIN}/${MAIN} ${DESTDIR}${INSTALLDIR}/${MAIN}

uninstall:
	rm -f ${DESTDIR}${INSTALLDIR}/${MAIN}

.PHONY: all options clean install uninstall

