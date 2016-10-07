#!/bin/sh
sudo -u vagrant /home/vagrant/local/bin/emacs-25.0.50 -u vagrant --daemon -nw -fg yellow &
/usr/sbin/sshd -D -f /etc/ssh/sshd_config

