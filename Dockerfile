FROM debian:stable-slim

LABEL Consol, <admin@vscloud.org>

# Ignore APT warnings about not having a TTY
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    #install dependencies
    && apt-get dist-upgrade -y \
    && apt-get -y install curl wget ca-certificates tar gpg \
    && wget https://ryanfortner.github.io/box64-debs/box64.list -O /etc/apt/sources.list.d/box64.list \
    && wget -qO- https://ryanfortner.github.io/box64-debs/KEY.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/box64-debs-archive-keyring.gpg \
    && apt-get update -y \ 
    && apt-get install box64-arm64 -y \
    && apt-get autoremove -y \
    && apt-get autoclean \
    #misc
    && useradd -d /home/container -m container \
    && rm -rf /var/lib/apt/lists/*
USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
