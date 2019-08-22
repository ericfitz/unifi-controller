# unifi-controller
Ubuntu Linux management scripts for AWS EC2-based Ubiquiti Networks Unifi controller server

* __ubuntu-letsencrypt-renewal.sh__ - _renews the letsencrypt certificate for local (Apache) web server_

* __ubuntu-letsencrypt-unifi-cert-install.sh__ - _Copies local letsencrypt certificate and key to Unifi controller JKS_

* __ubuntu-patch-management-with-unifi.sh__ - _Updates Ubuntu and Unifi apt repositories_, _applies all patches, suppressing user interaction_, _and reboots if necessary_

All scripts are installed in the /opt/efitz directory
