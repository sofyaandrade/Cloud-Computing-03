FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN apt-get update && apt-get install -y \
    bash \
    curl \
    procps \
    tar \
    gzip \
    coreutils \
    apache2 \
    ffmpeg \
    sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY scripts/ /app/scripts/
COPY source/ /app/source/
COPY README.md /app/README.md

RUN mkdir -p /app/backups /app/logs /app/evidencias /app/plataforma-treinos \
    && chmod +x /app/scripts/*.sh \
    && mkdir -p /var/www/html

EXPOSE 80

CMD ["bash", "-c", "apachectl -D FOREGROUND"]
