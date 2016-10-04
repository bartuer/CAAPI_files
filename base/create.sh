#!/bin/bash
sudo mkdir -p /ml/{local,storage} && sudo chmod g+w ml
cd /ml
git clone https://github.com/bartuer/CAAPI_files.git vms
cd vms/base
vagrant reload
