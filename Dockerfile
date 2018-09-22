FROM debian:jessie

ENV CJOSE_VERSION 0.5.1
ENV CJOSE_PKG libcjose0_${CJOSE_VERSION}-1.jessie.1_amd64.deb

RUN apt-get update && apt-get install -y \
    curl jq libhiredis0.10 apache2 libjansson4 && \
    curl -s -L -o /tmp/${CJOSE_PKG} https://github.com/zmartzone/mod_auth_openidc/releases/download/v2.3.0/${CJOSE_PKG} && \
    curl -L -o /tmp/libapache2-mod-auth-openidc.deb $( \
        curl --silent "https://api.github.com/repos/zmartzone/mod_auth_openidc/releases/latest" | \
        jq -r '.assets[] | select(.name | contains("jessie")).browser_download_url' \
    ) && \
    dpkg -i /tmp/${CJOSE_PKG} && \
    dpkg -i /tmp/libapache2-mod-auth-openidc.deb && \
    apt-get purge -y curl jq && \
    rm -rf /var/lib/apt/lists/*
    
