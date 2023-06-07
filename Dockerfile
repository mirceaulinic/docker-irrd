FROM pypy:3.9-slim-buster AS install

ARG IRRD_VERSION=4.2.8

RUN apt-get update \
 && apt-get install -y build-essential gcc gnupg libpq-dev dumb-init \
 && pip install --no-cache-dir -U pip \
 && pip install --no-cache-dir irrd==$IRRD_VERSION \
 && apt-get clean autoclean \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*

FROM pypy:3.9-slim-buster AS base

COPY --from=install /opt/pypy/lib/pypy3.9/site-packages/irrd/ /opt/pypy/lib/pypy3.9/site-packages/irrd/
COPY --from=install /opt/pypy/bin/irrd* /opt/pypy/bin/
COPY --from=install /usr/bin/dumb-init /usr/bin/dumb-init

COPY run.sh /opt/irrd/run

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/opt/irrd/run"]
