FROM ubuntu:18.04

WORKDIR /app
RUN apt-get update \
    && apt-get install libopus0 openssl -y \
    && rm -rf /var/lib/apt/lists/*
COPY build/tg2sip build/gen_db build/settings.ini ./

RUN useradd -u 1000 -ms /bin/bash gateway
RUN chown -R gateway /app
USER gateway

VOLUME /app/db

CMD ["./tg2sip"]
