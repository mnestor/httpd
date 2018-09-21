FROM httpd

# We can't just do version because they don't name these the same always
ENV OPENIDC_DEB=v2.3.8/libapache2-mod-auth-openidc_2.3.8-1.jessie+1_amd64.deb

RUN apt-get update && apt-get install -y \
    curl libcjose0 libhiredis0.10 apache2-api-20120211 && \
    curl -L -o /tmp/libapache2-mod-auth-openidc.deb https://github.com/zmartzone/mod_auth_openidc/releases/download/$OPENIDC_DEB && \
    dpkg -i /tmp/libapache2-mod-auth-openidc.deb && \
    apt-get purge -y curl && \
    rm -rf /var/lib/apt/lists/*
    