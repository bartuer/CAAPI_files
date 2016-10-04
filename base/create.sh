#!/bin/bash
sudo mkdir -p /ml/{local,storage} && sudo chmod -R g+w /ml
cd /ml
sudo git clone https://github.com/bartuer/CAAPI_files.git vms
sudo chown -R $(whoami):root /ml/vms
cd /ml/vms/base
vagrant up
