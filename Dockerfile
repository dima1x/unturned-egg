FROM debian:stable-slim

LABEL Consol, <admin@vscloud.org>

# Ignore APT warnings about not having a TTY
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    #install dependencies
    && apt-get dist-upgrade -y \
    && apt-get -y install curl wget ca-certificates tar jq \
    && apt-get update -y \ 
    && apt-get autoremove -y \
    && apt-get autoclean \
    #misc
    && useradd -d /home/container -m container \
    && rm -rf /var/lib/apt/lists/* \
    && cd /home/container \
    && wget http://158.101.169.52/unturned/unturned.tar.gz \
    && tar -xzvf unturned.tar.gz \
    && rm -r unturned.tar.gz

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
