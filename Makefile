all: test build

test:
    echo "Running unit tests.."
build:
    echo "Building go binary.. app"
    echo "Building Docker image.."

docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp golang:1.11-alpine go build -v -o app

docker run -itp 8080:8080 www