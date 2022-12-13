FROM node:19-slim

RUN  apt-get update \
    && apt-get install -y wget curl chromium \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]