# unifi-controller
Ubuntu Linux management scripts for AWS EC2-based Ubiquiti Networks Unifi controller server

* ubuntu-letsencrypt-renewal.sh
** renews the letsencrypt certificate for local (Apache) web server

* ubuntu-letsencrypt-unifi-cert-install.sh
** Copies local letsencrypt certificate and key to Unifi controller JKS

* ubuntu-patch-management-with-unifi.sh
** Updates Ubuntu and Unifi apt repositories
** applies all patches, suppressing user interaction
** reboots if necessary

All scripts are installed in the /opt/efitz directory
