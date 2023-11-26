.DEFAULT_GOAL := test
.PHONY: build test

ALL_HEADERS := $(wildcard *.d)
ALL_RUST := $(wildcard ../src/*.rs)

DMD=ldmd

FORCE:

$(ALL_HEADERS):

../../target/debug/libdiplomat_example.a: FORCE
	cargo build

fixeddecimal.out: ../../target/debug/libdiplomat_example.a $(ALL_HEADERS) main.d
	$(DMD) --betterC main.d ../../target/debug/libdiplomat_example.a -of=fixeddecimal.out

test: ./fixeddecimal.out
	./fixeddecimal.out

clean:
	rm fixeddecimal*
