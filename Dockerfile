FROM python:3.6-alpine

ARG IRRD_VERSION=4.0.8

RUN apk update \
 && apk add --no-cache --virtual .build-deps \
        build-base musl-dev gcc python3 python3-dev postgresql-dev \
 && pip install --no-cache-dir cython irrd==$IRRD_VERSION \
 && rm -rf /var/cache/irrd \
 && apk del --no-cache .build-deps \
 && apk add gnupg postgresql

CMD ["/usr/local/bin/twistd -n irrd"]
