export PATH := /usr/local/go/bin:$(PATH)

.PHONY: all build test clean docker-build docker-test docker-run docker-dev docker-dev-live docker-clean docker-rebuild help

# Local commands
all: test

build:
	@echo "🔨 Building Go library..."
	@CGO_ENABLED=1 go build -buildmode=c-shared -o golib.so main.go
	@echo "✅ Build complete: golib.so and golib.h created"

test: build
	@echo "🧪 Testing locally..."
	@if command -v php >/dev/null 2>&1; then \
		php -d ffi.enable=1 test_ffi.php; \
	else \
		echo "❌ PHP not found. Use 'make docker-test' instead."; \
		false; \
	fi

clean:
	@echo "🧹 Cleaning build artifacts..."
	@rm -f golib.so golib.h

# Docker commands
docker-build:
	@echo "🔨 Building Docker image..."
	@docker-compose build app

docker-test:
	@echo "🧪 Running tests in Docker..."
	@docker-compose up test

docker-run:
	@echo "🚀 Running application in Docker..."
	@docker-compose up app

docker-dev:
	@echo "💻 Starting development container..."
	@docker-compose run --rm dev bash

docker-dev-live:
	@echo "🔥 Starting live development environment..."
	@docker-compose up dev-live

docker-go-build:
	@echo "🏗️  Building Go library only in Docker..."
	@docker-compose run --rm go-build

docker-clean:
	@echo "🧹 Cleaning Docker resources..."
	@docker-compose down --rmi all --volumes --remove-orphans 2>/dev/null || true
	@docker system prune -f

docker-rebuild:
	@echo "🔄 Rebuilding everything from scratch..."
	@docker-compose build --no-cache

help:
	@echo "Available targets:"
	@echo ""
	@echo "Local development:"
	@echo "  build       - Build Go shared library locally"
	@echo "  test        - Run tests locally (requires PHP with FFI)"
	@echo "  clean       - Clean build artifacts"
	@echo ""
	@echo "Docker development:"
	@echo "  docker-build     - Build Docker images"
	@echo "  docker-test      - Run tests in Docker"
	@echo "  docker-run       - Run application in Docker"
	@echo "  docker-dev       - Interactive development container"
	@echo "  docker-dev-live  - Live development with source mounting"
	@echo "  docker-go-build  - Build Go library only in Docker"
	@echo "  docker-clean     - Clean Docker resources"
	@echo "  docker-rebuild   - Rebuild everything from scratch"
	@echo ""
	@echo "Examples:"
	@echo "  make test              # Test locally"
	@echo "  make docker-test       # Test in Docker"
	@echo "  make docker-dev        # Development shell"
	@echo "  make docker-dev-live   # Live development"
