FROM alpine:latest

MAINTAINER Bartuer Zhou <bartuer@bartuer.com>

RUN apk update && \
    apk add --no-cache bash openssh sudo coreutils && \
    apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ shadow  && \
    mkdir -p ~root/.ssh && chmod 700 ~root/.ssh/ && \
    echo -e "Port 22\n" >> /etc/ssh/sshd_config && \
    cp -a /etc/ssh /etc/ssh.cache && \
    adduser -G root -s /bin/bash -h /home/vagrant -u 1006 -D vagrant && \
    addgroup -g 1006 vagrant && addgroup vagrant vagrant &&\
    mkdir -p /home/vagrant/.ssh && \
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > /home/vagrant/.ssh/authorized_keys && \
    mkdir -p /root/.ssh && \
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCyt7YfUT+2PslSL3n+uXKsezDkBn2cfojfGK7Y3QX4CWxFVOLso3dsnyNEihKzvgXwjxpdfaD4iVbtf49k75ECmgaKIMjHZGlM+fWuXfeA91Wnb3pF0UHzXEKoB77eoVXiMZY06b6zl11HuK5QG/Pk1pXETyuV1Yiltf+ihSnXSh9Zr9Qj7feu9oLkczF8NuSQQC0SHA8jd8oaxgovlRHGFdnUGhPV/DmOHeSX8K26HvKEWT0huWqARxDRV+cZPAnZKG7iZ2DdKkjilZGwfCEFfj70fbbhebUwgkrRQUA6896ZCaulaX6OucEbKR2EQiHSaM0sDHbMphqNfDYWTrBv bartuer public key" > /root/.ssh/authorized_keys && \
    chown -R vagrant: /home/vagrant/.ssh && \
    echo -n 'vagrant:vagrant' | chpasswd && \
    echo 'vagrant ALL=NOPASSWD: ALL' >> /etc/sudoers && \
    mkdir -p /ml && touch /ml/x && rm /ml/x && chown -R vagrant:vagrant /ml

WORKDIR /home/vagrant
VOLUME /ml

COPY entry.sh /entry.sh
RUN chmod +x /entry.sh
ENTRYPOINT ["/entry.sh"]
CMD ["/usr/sbin/sshd", "-D", "-f", "/etc/ssh/sshd_config"]
