curl -o- http://caapi.blob.core.windows.net/docker/tar/flower.deps.code.tar.gz |tar -zxf -
docker build -t caapi/flower:latest .