FROM alpine:3.15.4 AS builder

WORKDIR /root

COPY repositories /etc/apk/repositories

COPY trojan-1.16.0.tar.gz /root/

RUN apk update && \
    apk add --no-cache --virtual .build-deps build-base cmake boost-dev openssl-dev mariadb-connector-c-dev

RUN tar -zxvf trojan-1.16.0.tar.gz && \
    cd trojan-1.16.0 && cmake . && make -j$(nproc) && strip -s trojan && \
    mv trojan /usr/local/bin/trojan

# 多阶构建

FROM alpine:3.15.4

WORKDIR /root

COPY --from=builder /etc/apk/repositories /etc/apk/repositories
COPY --from=builder /usr/local/bin/trojan /usr/local/bin/trojan
COPY config.json /usr/local/bin/

RUN apk update && \
    apk add --no-cache --virtual .trojan-rundeps \
        libstdc++ \
        boost-system \
        boost-program_options \
        mariadb-connector-c
CMD ["trojan", "/usr/local/bin/config.json"]
