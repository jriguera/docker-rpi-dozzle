# Dozzle in Docker: https://dozzle.dev/

# docker build . -t dozzle
# docker run --name logging -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock -d dozzle

ARG ARCH=arm32v6
FROM "${ARCH}/alpine:3.11"

ARG VERSION=1.20.21
ARG MYVERSION=jose0
ARG PORT=8080
ARG UID=1000
ARG GUID=1000
ARG TZ=Europe/Amsterdam
ARG ARCH

LABEL org.label-schema.description="Dozzle Docker image based on Alpine for the Raspberry Pi."
LABEL org.label-schema.name="rpi-dozzle"
LABEL org.label-schema.version="${VERSION}-${MYVERSION}"
LABEL org.label-schema.usage="/README.md"
LABEL org.label-schema.url="https://hub.docker.com/r/jriguera/rpi-dozzle"
LABEL org.label-schema.vcs-url="https://github.com/jriguera/docker-rpi-dozzle"
LABEL maintainer="Jose Riguera <jriguera@gmail.com>"
LABEL architecture="${ARCH}"

ENV PORT="${PORT}"
ENV DOCKER_API_VERSION=1.39
ENV LANG=en_US.utf8
ENV LC_ALL=C.UTF-8

RUN set -xe                                                                 && \
    apk -U upgrade                                                          && \
    # User/group
    addgroup -g "${GUID}" -S dozzle                                         && \
    adduser -h "/tmp" -D -G dozzle -s /sbin/nologin -u "${UID}" dozzle      && \
    # Installing Alpine packages
    apk add --no-cache \
        ca-certificates \
        pwgen \
        su-exec \
        tzdata \
        socat \
        net-tools \
        curl \
        bash \
                                                                            && \
    # Timezone
    cp "/usr/share/zoneinfo/${TZ}" /etc/localtime                           && \
    echo "${TZ}" > /etc/timezone                                            && \
    # clean up
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*


COPY *.sh /usr/local/bin/

RUN set -xe                                                                 && \
    chmod a+x /usr/local/bin/*                                              && \
    ln -s /usr/local/bin/dozzle.sh /usr/local/bin/docker-entrypoint.sh   && \
    ln -s /usr/local/bin/dozzle.sh /docker-entrypoint.sh                 && \
    ln -s /usr/local/bin/dozzle.sh /run.sh                               && \
    mkdir -p /docker-entrypoint-initdb.d

RUN set -ex                                                                 && \
    [ "${ARCH}" == "arm32v6" ] && wget --quiet -O /tmp/dozzle.tgz "https://github.com/amir20/dozzle/releases/download/v${VERSION}/dozzle_${VERSION}_Linux_ARM_32-bitv6.tar.gz"; \
    [ "${ARCH}" == "amd64" ] && wget --quiet -O /tmp/dozzle.tgz "https://github.com/amir20/dozzle/releases/download/v${VERSION}/dozzle_${VERSION}_Linux_64-bit.tar.gz"; \
    tar -C /usr/bin -xvf /tmp/dozzle.tgz dozzle                             && \
    chmod +x /usr/bin/dozzle                                                && \
    rm -f /tmp/dozzle.tgz

EXPOSE "${PORT}"
HEALTHCHECK --interval=1m --timeout=3s CMD curl -f http://127.0.0.1:$PORT/ || exit 1

ENTRYPOINT ["/run.sh"]
CMD ["dozzle"]
