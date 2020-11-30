FROM golang:1.15-alpine

# Insert import environment variables here.


# Insert environment variables here.


# Insert packages to install here.


# Copy from source to the container.
WORKDIR /app/sample
COPY ./go.mod /app/go.mod
COPY ./go.sum /app/go.sum
COPY ./cmd/sample /app/sample/cmd
COPY ./internal/sample /app/sample/internal
COPY ./pkg/sample /app/sample/pkg
COPY ./test/sample /app/sample/test
COPY ./api/sample /app/sample/api
COPY ./tools /app/sample/tools


# Install go package for live-reload tool.
RUN go get github.com/cespare/reflex

# Open the port for API server.
EXPOSE 8080
