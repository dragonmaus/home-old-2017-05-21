.include <bsd.own.mk>

.include "Makefile.inc.${SYSTEM}"

BINOWN=	dragon
BINDIR?=	${HOME}/bin
WARNS=	6

.SUFFIXES: .calc .execline .hs .py .rb .sed

HC		?=	ghc -outputdir ${.OBJDIR}
HCFLAGS		?=	-O
HLFLAGS		?=

CFLAGS		+=	-I${HOME}/lib/c
LDFLAGS		+=	-L${HOME}/lib/c

.calc:
	cp ${.IMPSRC} ${.TARGET}
	chmod a+x ${.TARGET}

.execline:
	cp ${.IMPSRC} ${.TARGET}
	chmod a+x ${.TARGET}

.hs:
	${HC} ${HCFLAGS} ${HLFLAGS} -o ${.TARGET} ${.IMPSRC}

.py:
	cp ${.IMPSRC} ${.TARGET}
	chmod a+x ${.TARGET}

.rb:
	cp ${.IMPSRC} ${.TARGET}
	chmod a+x ${.TARGET}

.sed:
	cp ${.IMPSRC} ${.TARGET}
	chmod a+x ${.TARGET}

.if defined(PROG_HS)
PROG=	${PROG_HS}
SRCS=	${PROG}.hs

${PROG}: ${SRCS}
	${HC} ${HCFLAGS} ${HLFLAGS} -o ${.TARGET} ${.IMPSRC}

.endif
