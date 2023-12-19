
# First stage: builder
FROM python:3.12 as builder

ARG TAKY_VERSION=0.9

WORKDIR /build

RUN git clone --depth 1 https://github.com/tkuester/taky.git -b ${TAKY_VERSION}

WORKDIR /build/taky

RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install -r requirements.txt && \
    python3 setup.py install && \
    find /usr/local -name '*.pyc' -delete && \
    find /usr/local -name '__pycache__' -type d -exec rm -rf {} +

# Second stage: runtime
FROM python:3.12-slim as runtime

ARG TAKY_VERSION=0.9
ARG PGID=999
ARG PUID=999

LABEL maintainer="https://github.com/nerdalertdk"
LABEL org.opencontainers.image.description="taky - A simple COT server for ATAK"
LABEL org.opencontainers.image.authors="Tim K - https://github.com/tkuester"
LABEL org.opencontainers.image.source="https://github.com/tkuester/taky"
LABEL org.opencontainers.image.version=${TAKY_VERSION}
LABEL org.opencontainers.image.licenses="MIT"

RUN groupadd -g ${PGID:-999} -r taky && \
    useradd -r -u ${PUID:-999} -g ${PGID:-999} taky

RUN mkdir /var/taky /etc/taky &&\
    chown -R taky:taky /var/taky /etc/taky

WORKDIR /var/taky

COPY --from=builder /usr/local /usr/local

USER taky

CMD ["takyctl"]
