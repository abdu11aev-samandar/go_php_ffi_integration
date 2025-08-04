export PATH := /usr/local/go/bin:$(PATH)

.PHONY: all build test clean

all: test

build:
	@echo "Building Go library..."
	go build -buildmode=c-shared -o golib.so main.go

test: build
	@echo "Testing..."
	/usr/bin/php -d ffi.enable=1 test_ffi.php

clean:
	rm -f golib.so golib.h
