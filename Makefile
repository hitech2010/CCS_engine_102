CC 		= clang -g
LIB		= bin/libccs.so
RUN		= test

DEP_pack	= bin/pack.o
DEP_engine	= bin/engine.o
DEP_err		= bin/err.o

SRC_err		= err/ccs_err.c
SRC_engine	= engine.c
SRC_run		= test.c

FLAG_dep	= -fPIC
FLAG_ld		= -lcrypto -L/usr/local/ssl/lib

dir :
	mkdir -p bin

$(LIB) : $(DEP_pack)
	$(CC) -shared -o $@ $<

$(DEP_pack) : $(DEP_engine) $(DEP_err)
	ld -r -o $@ $?

$(DEP_engine) : $(SRC_engine)
	$(CC) $(FLAG_dep) -o $@ -c $<

$(DEP_err) : $(SRC_err)
	$(CC) $(FLAG_dep) -o $@ -c $<

$(RUN) : $(SRC_run)
	$(CC) $(FLAG_ld) -o $@ $<

run : dir $(LIB) $(RUN)

all : clean dir $(LIB) $(RUN)

clean :
	rm -rf bin test
