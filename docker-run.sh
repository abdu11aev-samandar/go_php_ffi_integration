#!/bin/bash

# Docker run script for Go+PHP FFI project

set -e

echo "🐳 Go + PHP FFI Docker Runner"
echo "============================="

case "$1" in
    "build")
        echo "🔨 Building Docker image..."
        docker-compose build app
        ;;
    "test")
        echo "🧪 Running tests in Docker..."
        docker-compose up test
        ;;
    "run")
        echo "🚀 Running main application..."
        docker-compose up app
        ;;
    "dev")
        echo "💻 Starting development container..."
        docker-compose run --rm dev bash
        ;;
    "dev-live")
        echo "🔥 Starting live development environment..."
        docker-compose up dev-live
        ;;
    "clean")
        echo "🧹 Cleaning Docker resources..."
        docker-compose down --rmi all --volumes --remove-orphans 2>/dev/null || true
        docker system prune -f
        ;;
    "go-build")
        echo "🏗️  Building Go library only..."
        docker-compose run --rm go-build
        ;;
    "shell")
        echo "🐚 Starting shell in built container..."
        docker-compose run --rm dev bash
        ;;
    "rebuild")
        echo "🔄 Rebuilding everything..."
        docker-compose build --no-cache
        ;;
    *)
        echo "Usage: $0 {build|test|run|dev|dev-live|clean|go-build|shell|rebuild}"
        echo ""
        echo "Commands:"
        echo "  build     - Build Docker image"
        echo "  test      - Run tests in container"
        echo "  run       - Run main application"
        echo "  dev       - Start development container with bash shell"
        echo "  dev-live  - Start live development with source mounting"
        echo "  clean     - Clean Docker resources"
        echo "  go-build  - Build Go library only"
        echo "  shell     - Quick bash shell access in dev container"
        echo "  rebuild   - Rebuild everything from scratch"
        echo ""
        echo "Examples:"
        echo "  ./docker-run.sh run"
        echo "  ./docker-run.sh test"
        echo "  ./docker-run.sh dev"
        echo "  ./docker-run.sh dev-live"
        exit 1
        ;;
esac

echo "✅ Done!"
