FROM smebberson/alpine-base

ENV ZAP_RELEASE="2017-04-18"

# Add files
ADD root /

RUN \
    apk upgrade --update && \
    apk add openssl bash ttf-dejavu ca-certificates openjdk8-jre && \
    update-ca-certificates && \

    mkdir /opt && \
    cd /opt && \
    wget -O zap.zip https://github.com/zaproxy/zaproxy/releases/download/w${ZAP_RELEASE}/ZAP_WEEKLY_D-${ZAP_RELEASE}.zip && \
    unzip zap.zip && \
    rm zap.zip && \
    cd / && \
    ln -s /opt/ZAP_D-${ZAP_RELEASE}/zap.sh /usr/local/bin/zap.sh && \

    addgroup zap && \
    adduser -D -G zap zap && \
    chown -R zap:zap /home/zap/.ZAP_D && \

    # cleanup
    rm -rf /var/cache/apk/*