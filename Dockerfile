FROM golang:1.17.3-alpine3.14 as builder

# https://github.com/xteve-project/xTeVe/tags
ENV VERSION=2.2.0.200

LABEL maintainer="wilmardo" \
  description="xteve from scratch"

RUN addgroup -S -g 1000 xteve 2>/dev/null && \
  adduser -S -u 1000 -D -H -h /dev/shm -s /sbin/nologin -G xteve -g xteve xteve 2>/dev/null

RUN apk --no-cache add \
  git \
  build-base

RUN git clone --depth 1 --single-branch --branch ${VERSION} https://github.com/xteve-project/xTeVe /xteve

WORKDIR /xteve
RUN go build

# 'Install' upx from image since upx isn't available for aarch64 from Alpine
COPY --from=lansible/upx /usr/bin/upx /usr/bin/upx
# Minify binaries
# no upx: 10.8M
# upx: 5.9M
# --best: 5.9M
# --brute: 4.9M
RUN upx --best /xteve && \
    upx -t /xteve


# Final scratch image
FROM scratch

# Copy users from builder
COPY --from=builder \
  /etc/passwd \
  /etc/group \
  /etc/

# Copy xteve binary 
COPY --from=builder /xteve/xteve /xteve

USER xteve
ENTRYPOINT ["/xteve"]
CMD ["-config", "/config"]
