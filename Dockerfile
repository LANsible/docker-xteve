FROM golang:1.12.4-alpine as builder

ARG VERSION=master

LABEL maintainer="wilmardo" \
  description="xteve from scratch"

RUN addgroup -S -g 1000 xteve 2>/dev/null && \
  adduser -S -u 1000 -D -H -h /dev/shm -s /sbin/nologin -G xteve -g xteve xteve 2>/dev/null

RUN apk --no-cache add \
  git \
  build-base

RUN git clone --depth 1 --single-branch --branch add-go-mod https://github.com/wilmardo/xTeVe.git /xteve

WORKDIR /xteve
RUN go build

FROM alpine:3.10
ENV TMPDIR=/dev/shm

# Copy users from builder
COPY --from=builder \
  /etc/passwd \
  /etc/group \
  /etc/

# Copy xteve binary 
COPY --from=builder /xteve/xTeVe /xTeVe

USER xteve
ENTRYPOINT ["/xTeVe"]
CMD ["-config", "/config"]
