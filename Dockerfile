ARG BASE=slim
ARG VERSION=latest

FROM ubuntu@sha256:104ae83764a5119017b8e8d6218fa0832b09df65aae7d5a6de29a85d813da2fb AS ubuntu_base
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3 python3-pip wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

FROM python:3.10-slim AS slim_base
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

FROM ${BASE}_base

WORKDIR /app

ARG VERSION

RUN set -e; \
    if [ "$VERSION" = "latest" ]; then \
        REF="refs/heads/main"; \
        RAW_REF="main"; \
    elif [ "$VERSION" = "develop" ]; then \
        REF="refs/heads/main"; \
        RAW_REF="main"; \
    else \
        REF="refs/tags/$VERSION"; \
        RAW_REF="$VERSION"; \
    fi; \
    wget -q -O /tmp/app.tar.gz "https://github.com/MrDave/StaticJinjaPlus/archive/$REF.tar.gz"; \
    tar -xzf /tmp/app.tar.gz --strip-components=1 -C /app; \
    rm /tmp/app.tar.gz; \
    if [ "$VERSION" = "develop" ]; then \
        REQ_FILE="requirements-dev.txt"; \
    else \
        REQ_FILE="requirements.txt"; \
    fi; \
    wget -q -O $REQ_FILE "https://raw.githubusercontent.com/MrDave/StaticJinjaPlus/$RAW_REF/$REQ_FILE"; \
    pip3 install --no-cache-dir -r requirements.txt

RUN mv templates_example templates
COPY script.js templates/assets/script.js

ENV RUN_FILE=main.py
RUN if [ "$VERSION" = "develop" ]; then \
        echo 'RUN_FILE=test_sample.py' >> /etc/environment; \
    fi

CMD ["sh", "-c", "exec python3 -u \"$RUN_FILE\""]
