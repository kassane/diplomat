.DEFAULT_GOAL := main
.PHONY: build main

ALL_HEADERS := $(wildcard *.zig)
ALL_RUST := $(wildcard ../src/*.rs)

CC=zig

$(ALL_RUST):

$(ALL_HEADERS):


../../target/debug/libdiplomat_example.a: $(ALL_RUST)
	cargo build

# For rust static lib need llvm-demangle using libc++ linking (c++ rules [a.k.a zig c++])
fixeddecimal: ../../target/debug/libdiplomat_example.a $(ALL_HEADERS) main.zig
	$(CC) build-exe main.zig -O Debug --name fixeddecimal ../../target/debug/libdiplomat_example.a -fno-omit-frame-pointer -lc++

build: fixeddecimal

clean: fixeddecimal
	rm fixeddecimal*

main: build
	./fixeddecimal
