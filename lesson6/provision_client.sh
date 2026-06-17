#!/bin/bash
mkdir -p /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
[ ! -f /home/vagrant/.ssh/id_rsa ] && ssh-keygen -t rsa -b 2048 -f /home/vagrant/.ssh/id_rsa -N ""
chown -R vagrant:vagrant /home/vagrant/.ssh
