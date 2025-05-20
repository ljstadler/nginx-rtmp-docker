FROM alpine:latest

ARG NGINX_VERSION
ARG RTMP_VERSION

ADD https://github.com/nginx/nginx/archive/refs/tags/release-${NGINX_VERSION}.zip /tmp/nginx.zip
ADD https://github.com/winshining/nginx-http-flv-module/archive/refs/tags/v${RTMP_VERSION}.zip /tmp/rtmp.zip

RUN apk add --no-cache build-base envsubst openssl-dev pcre2-dev zlib-dev && \
    cd tmp && \
    unzip nginx.zip -d nginx && \
    unzip rtmp.zip -d rtmp && \
    cd nginx/nginx-release-${NGINX_VERSION} && \
    ./auto/configure \
    --add-module=/tmp/rtmp/nginx-http-flv-module-${RTMP_VERSION} && \
    make && \
    make install && \
    rm -rf /tmp/* && \
    apk del build-base && \
    ln -sf /dev/stdout /usr/local/nginx/logs/access.log && \
    ln -sf /dev/stderr /usr/local/nginx/logs/error.log

COPY nginx.conf.template /usr/local/nginx/templates/nginx.conf.template

EXPOSE 1935

CMD ["sh", \
    "-c", \
    "envsubst '$AUTH' < /usr/local/nginx/templates/nginx.conf.template > /usr/local/nginx/conf/nginx.conf && \
    /usr/local/nginx/sbin/nginx -g 'daemon off;'" \
    ]