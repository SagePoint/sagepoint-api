#!/usr/bin/env bash

# apt-get update
# apt-get install -y apache2
# rm -rf /var/www
# ln -fs /vagrant /var/www

set -e

REPO_URL="http://apt.puppetlabs.com/puppetlabs-release-precise.deb"

if [ "$EUID" -ne "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

apt-get update > /dev/null
echo '10.0.2.15 sagepoint-portal dev.sagepoint-portal.com' >> /etc/hosts
# puppet module install puppetlabs/apache > /dev/null
# puppet module install puppetlabs/ruby > /dev/null
# puppet module install puppetlabs/passenger > /dev/null
# puppet module install puppetlabs/mysql > /dev/null