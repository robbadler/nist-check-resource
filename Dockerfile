FROM alpine:latest

RUN apk add --no-cache \
      coreutils \
      curl \
      git \
      jq

COPY check in out /opt/resource/
