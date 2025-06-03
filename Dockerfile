FROM alpine

ARG NGINX_VERSION
ARG RTMP_VERSION

ADD https://github.com/nginx/nginx/archive/refs/tags/release-${NGINX_VERSION}.zip /tmp/nginx.zip
ADD https://github.com/winshining/nginx-http-flv-module/archive/refs/tags/v${RTMP_VERSION}.zip /tmp/rtmp.zip

RUN apk add --no-cache pcre2 && \
    apk add --no-cache --virtual /tmp/.build-deps gcc libc-dev make openssl-dev pcre2-dev && \
    cd tmp && \
    unzip nginx.zip -d nginx && \
    unzip rtmp.zip -d rtmp && \
    cd nginx/nginx-release-${NGINX_VERSION} && \
    ./auto/configure \
    --add-module=/tmp/rtmp/nginx-http-flv-module-${RTMP_VERSION} && \
    make && \
    make install && \
    apk del --no-network /tmp/.build-deps && \
    rm -rf /tmp/* && \
    ln -sf /dev/stdout /usr/local/nginx/logs/access.log && \
    ln -sf /dev/stderr /usr/local/nginx/logs/error.log

COPY nginx.conf /usr/local/nginx/conf/nginx.conf

EXPOSE 1935

ENTRYPOINT ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]