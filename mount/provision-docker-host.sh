#!/usr/bin/env bash

if [[ $UID -ne 0 ]]; then
  echo "$0 must be run as root"
  exit 1
fi

package_exists() {
   return $(dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed")
};

apt_install() {
  local package=$1
  package_exists $package
  if [[ $? -eq 1 ]]; then
    echo "Skipping $@"
  else
    echo
    echo Installing $@
    echo
    DEBIAN_FRONTEND=noninteractive apt-get -fqy install $@
  fi
}


update_sources() {
  echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
  apt-get update
}

install_packages() {
  apt_install apt-transport-https
  apt_install ca-certificates
  apt_install lxc
  apt_install iptables
  apt_install lxc-docker
}

install_daemon() {
  cp -r /host/wrapdocker /etc/service/wrapdocker
}


update_sources
install_packages
install_daemon

## Install the magic wrapper.
#ADD ./wrapdocker /usr/local/bin/wrapdocker
#RUN chmod +x /usr/local/bin/wrapdocker

