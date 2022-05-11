FROM alpine:3.15.4

WORKDIR /root

COPY repositories /etc/apk/repositories
RUN apk update && apk add --no-cache --virtual .runtime-deps perl-module-runtime wget nginx

COPY apt-mirror /usr/local/bin/
COPY entrypoint.sh /entrypoint.sh
COPY mirror.list /etc/apt/mirror.list

RUN echo "0 1 * * 1,3,5    root    /usr/bin/apt-mirror > /root/cron.log" >> /etc/crontabs/root

COPY apt-mirror.conf /etc/nginx/http.d/apt-mirror.conf

CMD [ "/entrypoint.sh" ]
