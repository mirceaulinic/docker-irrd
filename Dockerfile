FROM pypy:3.9-slim-buster

ARG IRRD_VERSION=4.2.8

COPY run.sh /opt/irrd/run

RUN apt-get update \
 && apt-get install -y build-essential gcc gnupg libpq-dev dumb-init \
 && pip install --no-cache-dir -U pip \
 && pip install --no-cache-dir irrd==$IRRD_VERSION \
 && apt-get clean autoclean \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/opt/irrd/run"]
