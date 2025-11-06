
FROM golang:1.25.3 as base
WORKDIR /app

# Copy go.mod from devops_project
COPY devops_project/go.mod .

RUN go mod download

# Copy all source files from devops_project
COPY devops_project/ .

RUN go build -o main .

FROM gcr.io/distroless/base
COPY --from=base /app/main .
COPY --from=base /app/static ./static

EXPOSE 8080
CMD ["./main"]
