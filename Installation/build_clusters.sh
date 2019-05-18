#!/usr/bin/env bash
python create_host_file.py
ansible-playbook -i dremio_hosts hdp-yarn-dremio-tarball.yml
terraform output