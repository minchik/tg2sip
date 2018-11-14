#!/bin/sh

if [ -z "$DB_LOCATION" ]; then
    echo "provide 'DB_LOCATION' env variable"
    exit 1
fi

echo "[Build docker image]"
docker-compose build
echo "[Preparing]"
docker run -i --rm -v ${DB_LOCATION}:/app/db --user root tg2sip /bin/chown -R gateway /app
echo "[Interactive telegram authentication]"
docker run -it --rm -v ${DB_LOCATION}:/app/db tg2sip ./gen_db
echo "[Starting up]"
docker-compose up -d
