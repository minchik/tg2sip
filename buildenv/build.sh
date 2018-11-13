#!/bin/sh

if [ -z "$DOCKER_IMAGE" ]; then
    echo "Error: provide 'DOCKER_IMAGE' env vairable" 1>&2
    exit 1
fi

if [ -f build ]; then
    mkdir build;
fi

docker run --rm -v $(pwd):/src $DOCKER_IMAGE /bin/bash -c "
        mkdir build && cd build;
        cmake -DCMAKE_BUILD_TYPE=Release /src;
        cmake --build .;
        chmod +x tg2sip;
        chmod +x gen_db;
        cp tg2sip /src/build;
        cp gen_db /src/build;" 
