FROM golang:1.22.5 as base

WORKDIR /app

COPY go.mod .

RUN go mod download
 #downloads the requires libraries to run the go app

COPY . .   
 #copies the code

RUN go build -o main . 
 #an artifact is created after this command is run

FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080


CMD ["./main"]