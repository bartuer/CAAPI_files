# pull code
curl -o- http://caapi.blob.core.windows.net/docker/tar/flower.deps.code.tar.gz |tar -zxf -
or
docker pull caapi/flower
# build
./build.sh
# debug
./debug.sh
# run
./run.sh

