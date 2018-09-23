FROM debian:jessie

ENV CJOSE_VERSION 0.5.1
ENV CJOSE_PKG libcjose0_${CJOSE_VERSION}-1.jessie.1_amd64.deb

RUN mkdir -p /var/lib/apt/lists/partial && \
    apt-get update && apt-get install -y \
    --no-install-recommends curl ca-certificates libjansson4 apache2 libhiredis0.10 jq && \
    curl -s -L -o /tmp/${CJOSE_PKG} https://github.com/zmartzone/mod_auth_openidc/releases/download/v2.3.0/${CJOSE_PKG} && \
    curl -L -o /tmp/libapache2-mod-auth-openidc.deb $( \
        curl --silent "https://api.github.com/repos/zmartzone/mod_auth_openidc/releases/latest" | \
        jq -r '.assets[] | select(.name | contains("jessie")).browser_download_url' \
    )
RUN dpkg -i /tmp/${CJOSE_PKG} && echo ok || echo ko
RUN dpkg -i /tmp/libapache2-mod-auth-openidc.deb && echo ok || echo ko

RUN apt-get purge -y curl jq && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lock/apache2 /var/run/apache2 a2enmod headers

EXPOSE 80
ENTRYPOINT ["httpd-foreground"]

ADD httpd-foreground /usr/local/bin/
