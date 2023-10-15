FROM alpine:latest AS downloader

ARG CLI_VERSION

RUN wget -O /tmp/bw.zip "https://github.com/bitwarden/clients/releases/download/cli-v$CLI_VERSION/bw-linux-$CLI_VERSION.zip"
RUN apk add --no-cache unzip
RUN unzip /tmp/bw.zip -d /tmp/bw && \
    chmod +x /tmp/bw/bw

FROM debian:12-slim

RUN apt-get update && \
    apt-get install -y ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=downloader /tmp/bw/bw /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/bw"]
