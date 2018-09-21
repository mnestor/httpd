FROM httpd

RUN apt-get update && apt-get install -y \
    curl jq libcjose0 libhiredis0.10 apache2-api-20120211 && \
    curl -L -o /tmp/libapache2-mod-auth-openidc.dev $( \
        curl --silent "https://api.github.com/repos/zmartzone/mod_auth_openidc/releases/latest" | \
        jq -r '.assets[] | select(.name | contains("jessie")).browser_download_url' \
    ) && \
    dpkg -i /tmp/libapache2-mod-auth-openidc.deb && \
    apt-get purge -y curl jq && \
    rm -rf /var/lib/apt/lists/*
    
