FROM alpine:latest

MAINTAINER Bartuer Zhou <bartuer@bartuer.com>

# SSH
RUN apk update && \
    apk add --no-cache ca-certificates bash gcc g++ git linux-headers paxctl libgcc libstdc++ gnupg \
    curl ncurses-dev aspell aspell-en luajit python ruby sqlite openssh rsync sudo vim coreutils make && \
    apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ shadow  && \
    mkdir -p ~root/.ssh && chmod 700 ~root/.ssh/ && \
    echo -e "Port 22\n" >> /etc/ssh/sshd_config && \
    cp -a /etc/ssh /etc/ssh.cache && \
    adduser -G root -s /bin/bash -h /home/vagrant -u 1006 -D vagrant && \
    addgroup -g 1006 vagrant && addgroup vagrant vagrant &&\
    mkdir -p /home/vagrant/.ssh && \
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > /home/vagrant/.ssh/authorized_keys && \
    chown -R vagrant: /home/vagrant/.ssh && \
    echo -n 'vagrant:vagrant' | chpasswd && \
    echo 'vagrant ALL=NOPASSWD: ALL' >> /etc/sudoers && \
    mkdir -p /ml && touch /ml/x && rm /ml/x && chown -R vagrant:vagrant /ml

EXPOSE 2222

# Install SBCL from the tarball binaries.
RUN wget http://prdownloads.sourceforge.net/sbcl/sbcl-1.3.7-x86-64-linux-binary.tar.bz2 -O /tmp/sbcl.tar.bz2 && \
    tar jxvf /tmp/sbcl.tar.bz2 -C /tmp/ && \
    cd /tmp/sbcl-1.3.7-x86-64-linux/ && sh install.sh && \
    cd /tmp && rm -rf /tmp/sbcl/

# Install R
RUN curl --silent \
    --location https://github.com/sgerrand/alpine-pkg-R/releases/download/v3.2.3-r0/R-3.2.3-r0.apk --output /var/cache/apk/R-3.2.3-r0.apk \
    --location https://github.com/sgerrand/alpine-pkg-R/releases/download/v3.2.3-r0/R-dev-3.2.3-r0.apk --output /var/cache/apk/R-dev-3.2.3-r0.apk \
    --location https://github.com/sgerrand/alpine-pkg-R/releases/download/v3.2.3-r0/R-doc-3.2.3-r0.apk --output /var/cache/apk/R-doc-3.2.3-r0.apk \
    && apk add --allow-untrusted  /var/cache/apk/R-3.2.3-r0.apk  /var/cache/apk/R-dev-3.2.3-r0.apk  /var/cache/apk/R-doc-3.2.3-r0.apk 


# Compile & Install Emacs
RUN mkdir -p /home/vagrant/etc && \
    cd /home/vagrant/etc && git clone https://github.com/bartuer/dot-emacs.git el && \
    apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ emacs  && \
    mkdir -p /home/vagrant/local/bin && \
    cp /usr/bin/ebrowse /home/vagrant/local/bin/ebrowse && \
    cp /usr/bin/emacs-25.0.50 /home/vagrant/local/bin/emacs-25.0.50 && \
    ln -s /home/vagrant/local/bin/emacs-25.0.50 /home/vagrant/local/bin/emacs && \
    cp /usr/bin/emacsclient /home/vagrant/local/bin/emacsclient && \
    cp /home/vagrant/etc/el/install/pbcopy.xlicp.sh /home/vagrant/local/bin/pbcopy && \
    chmod +x /home/vagrant/local/bin/pbcopy && \
    cp /home/vagrant/etc/el/install/killemacs /home/vagrant/local/bin/killemacs && \
    cp /home/vagrant/etc/el/install/quote0 /home/vagrant/local/bin/quote0 && \
    mkdir -p /home/vagrant/local/share && \
    cp -r /usr/share/emacs /home/vagrant/local/share/ && \
    ln -s /home/vagrant/local/share/emacs/25.0.50 /home/vagrant/local/share/emacs/current && \
    ln -s /home/vagrant/etc/el/.emacs.el /home/vagrant/.emacs.el && \
    cat /home/vagrant/etc/el/install/bashrc_alpine.sh >> /home/vagrant/.bashrc && \
    chown vagrant:vagrant -R /home/vagrant && \
    rm -rf /home/vagrant/etc/el/.git

# Compile & Install NodeJS
ENV VERSION=v6.7.0 NPM_VERSION=3 CFLAGS="-D__USE_MISC" NPM_VERSION=2
ENV CONFIG_FLAGS="--without-npm" RM_DIRS=/usr/include

RUN curl -o node-${VERSION}.tar.gz -sSL https://nodejs.org/dist/${VERSION}/node-${VERSION}.tar.gz && \
    tar -zxf node-${VERSION}.tar.gz && \
    cd node-${VERSION} && \
    export GYP_DEFINES="linux_use_gold_flags=0" && \
    ./configure --prefix=/usr ${CONFIG_FLAGS} && \
    NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
    make -j${NPROC} -C out mksnapshot BUILDTYPE=Release && \
    paxctl -cm out/Release/mksnapshot && \
    make -j${NPROC} && \
    make install && \
    paxctl -cm /usr/bin/node && \
    cd / && \
    rm -rf /node-${VERSION}.tar.gz /SHASUMS256.txt.asc /node-${VERSION} ${RM_DIRS} \
    /usr/share/man /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp /root/.gnupg \
    /usr/lib/node_modules/npm/man /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html
    
WORKDIR /home/vagrant
VOLUME /ml
COPY entry.sh /entry.sh
RUN chmod +x /entry.sh
COPY node_modules.tbz /home/vagrant/etc/el/vendor
RUN cd /home/vagrant/etc/el/vendor && \
    tar -jxf node_modules.tbz && rm node_modules.tbz
ENTRYPOINT ["/entry.sh"]
CMD ["/usr/sbin/sshd", "-D", "-f", "/etc/ssh/sshd_config"]
