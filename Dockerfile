FROM debian:13-slim AS downloader

ARG CLI_VERSION

RUN apt-get update && \
    apt-get install -y unzip ca-certificates jq && \
    rm -rf /var/lib/apt/lists/*
ADD "https://github.com/bitwarden/clients/releases/download/cli-v$CLI_VERSION/bw-linux-$CLI_VERSION.zip" /tmp/bw.zip
RUN unzip /tmp/bw.zip -d /tmp/bw && \
    chmod +x /tmp/bw/bw

RUN --mount=type=bind,source=build.sh,target=/build.sh \
    mkdir /tmp/dst && \
    /build.sh /tmp/bw/bw /tmp/dst



FROM scratch AS minimal

COPY --from=downloader /tmp/dst/ /

ENTRYPOINT ["/usr/local/bin/bw"]


FROM debian:13-slim AS app

RUN apt-get update && \
    apt-get install -y ca-certificates jq && \
    rm -rf /var/lib/apt/lists/*

COPY --from=downloader /tmp/bw/bw /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/bw"]

