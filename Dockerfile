FROM golang:1.10-alpine3.8 AS golang

WORKDIR /go/src/api
COPY hello.go .

RUN go get -d -v \
    && go install -v \
    && GOOS=linux go build cmd/go \
    && apk add --no-cache upx\
    && upx --brute go
##

FROM scratch
COPY --from=golang /go/bin/api/ /go/bin/
CMD ["/go/bin/api"]
