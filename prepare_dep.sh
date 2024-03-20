#/bin/bash
set -ex
sudo apt update && sudo apt install docker.io postgresql-client make --yes
sudo usermod -aG docker $USER && echo "NOW RELOGIN"