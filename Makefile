SRC=${PWD}/src
SRCS=${PWD}/../agda-stdlib/src ${SRC}
OUT=${PWD}/dist
LIB=${OUT}/libhello.o
GHC=-I${PWD}/include -i${SRC} -outputdir=${OUT} ${LIB}

all: ${OUT}/Hello

${OUT}:
	@mkdir ${OUT}

${LIB}: ${OUT}
	@gcc -c ${SRC}/hello.c -o ${LIB}

${OUT}/Hello: ${LIB}
	@agda $(SRCS:%=-i%) -c --compile-dir=${OUT} $(GHC:%=--ghc-flag=%) ${SRC}/Hello.agda

clean:
	@find ${SRC} -name '*.*i' -delete
	@rm -rf ${OUT}
