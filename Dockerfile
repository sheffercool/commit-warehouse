## -*- docker-image-name: "docker-crate" -*-
#
# Crate Dockerfile
# https://github.com/crate/docker-crate
#

FROM alpine:3.8

RUN addgroup -g 1000 -S crate \
    && adduser -u 1000 -G crate -h /crate -S crate

# install crate
RUN apk add --no-cache --virtual .crate-rundeps \
        openjdk8-jre-base \
        python3 \
        openssl \
        curl \
        coreutils \
    && apk add --no-cache --virtual .build-deps \
        gnupg \
        tar \
    && curl -fSL -O https://cdn.crate.io/downloads/releases/crate-3.1.6.tar.gz \
    && curl -fSL -O https://cdn.crate.io/downloads/releases/crate-3.1.6.tar.gz.asc \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 90C23FC6585BC0717F8FBFC37FAAE51A06F6EAEB \
    && gpg --batch --verify crate-3.1.6.tar.gz.asc crate-3.1.6.tar.gz \
    && rm -rf "$GNUPGHOME" crate-3.1.6.tar.gz.asc \
    && tar -xf crate-3.1.6.tar.gz -C /crate --strip-components=1 \
    && rm crate-3.1.6.tar.gz \
    && ln -sf /usr/bin/python3 /usr/bin/python \
    && apk del .build-deps

# install crash
RUN apk add --no-cache --virtual .build-deps \
        gnupg \
    && curl -fSL -O https://cdn.crate.io/downloads/releases/crash_standalone_0.21.5\
    && curl -fSL -O https://cdn.crate.io/downloads/releases/crash_standalone_0.21.5.asc \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 90C23FC6585BC0717F8FBFC37FAAE51A06F6EAEB \
    && gpg --batch --verify crash_standalone_0.21.5.asc crash_standalone_0.21.5 \
    && rm -rf "$GNUPGHOME" crash_standalone_0.21.5.asc \
    && mv crash_standalone_0.21.5 /usr/local/bin/crash \
    && chmod +x /usr/local/bin/crash \
    && apk del .build-deps

ENV PATH /crate/bin:$PATH
# Default heap size for Docker, can be overwritten by args
ENV CRATE_HEAP_SIZE 512M

# This healthcheck indicates if a CrateDB node is up and running. It will fail
# if we cannot get any response from the CrateDB (connection refused, timeout
# etc). If any response is received (regardless of http status code) we
# consider the node as running.
HEALTHCHECK --timeout=30s --interval=30s CMD curl --max-time 25 $(hostname):4200 || exit 1

RUN mkdir -p /data/data /data/log

VOLUME /data

WORKDIR /data

# http: 4200 tcp
# transport: 4300 tcp
# postgres protocol ports: 5432 tcp
EXPOSE 4200 4300 5432

LABEL maintainer="Crate.io <office@crate.io>" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date="2019-02-05T14:52:32.724581774+00:00" \
    org.label-schema.name="crate" \
    org.label-schema.description="CrateDB is a distributed SQL database handles massive amounts of machine data in real-time." \
    org.label-schema.url="https://crate.io/products/cratedb/" \
    org.label-schema.vcs-url="https://github.com/crate/docker-crate" \
    org.label-schema.vendor="Crate.io" \
    org.label-schema.version="3.1.6"

COPY --chown=1000:0 config/crate.yml /crate/config/crate.yml
COPY --chown=1000:0 config/log4j2.properties /crate/config/log4j2.properties
COPY docker-entrypoint_3.1.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["crate"]
