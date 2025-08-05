# Multi-stage build: Build Go library first, then create PHP runtime

# Stage 1: Build Go shared library
FROM golang:1.21-bullseye AS go-builder

# Install build dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    libc6-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /build

# Copy Go source files
COPY go.mod main.go ./

# Build shared library with CGO enabled
ENV CGO_ENABLED=1
RUN go build -buildmode=c-shared -o golib.so main.go

# Stage 2: PHP runtime with FFI
FROM php:8.3-cli-bullseye

# Install PHP FFI dependencies and bash for development
RUN apt-get update && apt-get install -y \
    gcc \
    libc6-dev \
    make \
    libffi-dev \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Install and enable PHP FFI extension
RUN docker-php-ext-install ffi \
    && docker-php-ext-enable ffi

# Set PHP FFI configuration
RUN echo "ffi.enable=1" > /usr/local/etc/php/conf.d/ffi.ini

# Create app directory
WORKDIR /app

# Copy Go library and header from builder stage
COPY --from=go-builder /build/golib.so /build/golib.h ./

# Copy PHP files
COPY test_ffi.php ./

# Create a simplified header for PHP FFI (based on Go-generated header)
RUN echo '#include <stddef.h>' > simple.h && \
    echo 'typedef struct { const char *p; ptrdiff_t n; } _GoString_;' >> simple.h && \
    echo 'extern int add_numbers(int a, int b);' >> simple.h && \
    echo 'extern char* create_user(char* name, int age);' >> simple.h && \
    echo 'extern void free_string(char* str);' >> simple.h

# Run tests by default
CMD ["php", "test_ffi.php"]
