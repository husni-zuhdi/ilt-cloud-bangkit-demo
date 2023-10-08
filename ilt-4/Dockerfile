FROM golang:1.19

# Set Working directory of this container
WORKDIR /app
# Copy go.mod and go.sum to container working directory
COPY go.mod go.sum ./
# Download all go package needed
RUN go mod download

# Copy all source code to container
COPY . ./

# Build the ilt4 binary
RUN CGO_ENABLED=0 GOOS=linux go build -pkgdir pkg -o /ilt4 ./cmd/ilt-4/main.go
# Expose port 8080
EXPOSE 8080

# Run ilt4 binary
CMD ["/ilt4"]
