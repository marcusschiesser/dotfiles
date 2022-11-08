#!/bin/sh

multipass launch -c 2 -m 8G -d 128G -n docker 22.04 --cloud-init - <<EOF
---
users:
  - name: ubuntu
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh-authorized-keys:
      - $(cat ~/.ssh/id_rsa.pub)
package_update: true
packages:
  - docker
  - avahi-daemon
  - apt-transport-https
  - ca-certificates
  - curl
  - gnupg
  - lsb-release
runcmd:
  - sudo curl -fsSL https://get.docker.com | sudo bash
  - sudo systemctl enable docker
  - sudo systemctl enable -s HUP ssh
  - sudo groupadd docker
  - sudo usermod -aG docker ubuntu
EOF
