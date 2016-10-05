#!/bin/bash
sudo mkdir -p /ml/{local,storage} && sudo chmod -R g+w /ml
cd /ml
cd /ml/vms/toruch
vagrant up
