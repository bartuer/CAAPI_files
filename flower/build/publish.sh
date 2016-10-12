docker save caapi/flower:latest |gzip --fast > flower.latest.tar.gz
docker push caapi/flower:latest
azure storage blob upload -q flower.latest.tar.gz docker image/flower.latest.tar.gz