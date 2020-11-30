FROM golang:1.15-alpine

# Insert import environment variables here.


# Insert environment variables here.


# Insert packages to install here.


# Copy from source to the container.
WORKDIR /app/{SERVICES}
COPY ./go.mod /app/go.mod
COPY ./go.sum /app/go.sum
COPY ./cmd/{SERVICES} /app/{SERVICES}/cmd
COPY ./internal/{SERVICES} /app/{SERVICES}/internal
COPY ./pkg/{SERVICES} /app/{SERVICES}/pkg
COPY ./test/{SERVICES} /app/{SERVICES}/test
COPY ./api/{SERVICES} /app/{SERVICES}/api
COPY ./tools /app/{SERVICES}/tools

# Install go package for live-reload tool.
RUN go get github.com/cespare/reflex

# Open the port for API server.
EXPOSE 8080
