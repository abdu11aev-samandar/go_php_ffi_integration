# Go + PHP FFI Integration Project

Bu loyiha Go shared library'ni PHP FFI orqali ishlatish uchun yaratilgan. Docker orqali to'liq ishlaydi.

## 🚀 Tezkor ishga tushirish

### Docker orqali (Tavsiya etiladi)

```bash
# Testni ishga tushirish
./docker-run.sh test

# Yoki
make docker-test
```

### Barcha mavjud commandlar

#### Docker Run Script
```bash
./docker-run.sh test      # Testlarni ishga tushirish
./docker-run.sh run       # Asosiy dasturni ishga tushirish  
./docker-run.sh dev       # Development container (bash shell)
./docker-run.sh build     # Docker image'ni build qilish
./docker-run.sh clean     # Docker resurslarini tozalash
./docker-run.sh go-build  # Faqat Go library'ni build qilish
./docker-run.sh rebuild   # Hamma narsani qaytadan build qilish
```

#### Makefile
```bash
make help             # Barcha targetlar ro'yxati
make docker-test      # Docker'da testlar
make docker-run       # Docker'da dastur ishga tushirish
make docker-dev       # Development shell
make docker-build     # Docker build
make docker-clean     # Docker tozalash
make docker-rebuild   # Hamma narsani qaytadan build qilish
```

## 🏗️ Arxitektura

- **Go**: Shared library (C-shared mode)
- **PHP**: FFI extension orqali Go library'ga murojaat
- **Docker**: Multi-stage build (Go + PHP)
- **Base Images**: Ubuntu Bullseye (Alpine'dan o'tish)

## 📁 Fayl tuzilmasi

```
.
├── main.go              # Go shared library source
├── test_ffi.php         # PHP FFI test
├── go.mod              # Go module
├── Dockerfile          # Multi-stage build
├── docker-compose.yml  # Docker services
├── docker-run.sh       # Docker run script  
├── Makefile           # Build automation
└── README.md          # Bu fayl
```

## 🔧 Development

### Docker Development Environment

```bash
# Interactive development shell
./docker-run.sh dev

# Container ichida:
# - golib.so va golib.h mavjud
# - PHP FFI enabled
# - Barcha development tools
# - bash shell access
```

### Local Development (PHP FFI support kerak)

```bash
# Go library build qilish
make build

# Test qilish (faqat PHP FFI support bo'lsa)
make test
```

**Eslatma**: Local PHP'da FFI support bo'lmasligi mumkin. Docker environment ishlatish tavsiya etiladi.

## 🧪 Test

Go + PHP integration testi:
- Go'da `add_numbers` va `create_user` function'lari
- PHP'da FFI orqali chaqirish
- JSON serializatsiya

Test natijasi:
```
Go + PHP FFI Test
=================

Adding: 15 + 27 = 42

User: {"id":1,"name":"Ali","age":25}

✅ Success!
```

## 🐳 Docker Services

- **app**: Asosiy dastur (test)
- **dev**: Development shell  
- **test**: Test runner
- **go-build**: Faqat Go library builder
- **dev-live**: Live development with source mounting

## 🚨 Xatolik bartaraf etish

### "Dynamic loading not supported" 
- Local PHP'da FFI to'g'ri konfiguratsiya qilinmagan
- Docker environment ishlatish tavsiya etiladi: `make docker-test`

### "golib.so not found"
- Container'da build qilinmagan
- `./docker-run.sh build` yoki `make docker-build` ishlatish

### Segmentation fault (exit code 139)
- Alpine va glibc/musl uyushmovchiligi
- Ubuntu base image ishlatildi (hal qilindi)

## 📝 Yangilanishlar

- ✅ Multi-stage Docker build
- ✅ PHP FFI to'liq support  
- ✅ Development environment
- ✅ Automated build scripts
- ✅ Ubuntu base (Alpine'dan o'tish)
- ✅ Docker-compose services yangilandi
- ✅ Makefile va docker-run.sh yangilandi
