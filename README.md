# Go + PHP FFI Integration

Go kutubxonani PHP FFI orqali ishlatish.

## Kerakli narsalar

- Go 1.21+
- PHP 8+ with FFI
- Linux

## Ishlatish

```bash
# Build va test
make

# Faqat build
make build

# Tozalash
make clean
```

## Kod misoli

**Go (main.go):**
```go
//export add_numbers
func add_numbers(a, b C.int) C.int {
    return a + b
}
```

**PHP (test_ffi.php):**
```php
$go = new GoLib();
echo $go->addNumbers(15, 27); // 42
```

## Fayllar

- `main.go` - Go source code
- `simple.h` - C header file  
- `test_ffi.php` - PHP test
- `Makefile` - Build automation

## Muhim

- `//export` Go funksiyalar uchun
- `php -d ffi.enable=1` ishlatish
- Memory leak'lardan saqlaning
