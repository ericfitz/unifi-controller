#!/bin/bash

# use EFF's "certbot" script to check if letsencrypt certificate needs renewal
# renewal requires letsencrypt to access local web site
# we have to open port 443 tcp inbound for web verification
# this script only works when running on an AWS EC2 instance

# get instance ID from instance metadata service
INSTANCEID=$(curl http://169.254.169.254/1.0/meta-data/instance-id)

# sg-049fb2239760192c0 "unifi", allow inbound udp 3478 (STUN) and tcp 8080 from anywhere for devices to report to controller - required for device control
# sg-08474552d715b885f "home", allow any inbound traffic from my home IP - used for remote management
# sg-0efadd2c907d7e98c "default", allow any inbound traffic from any host in this VPC - future connectivity within vpc
# sg-0f2bd1e26d0238cfc "web", allow inbound TCP 80 (HTTP) and TCP 443 (HTTPS) from anywhere - required for LetsEncrypt to verify ownership for cert renewal

echo Opening security group for inbound HTTPS to enable web site validation...
aws ec2 modify-instance-attribute  --instance-id $INSTANCEID --groups "sg-049fb2239760192c0" "sg-08474552d715b885f" "sg-0efadd2c907d7e98c" "sg-0f2bd1e26d0238cfc"

echo Renewing certificate...
# certbot will run the "deploy-hook" command if any cert is actually renewed 
certbot -q renew --apache --deploy-hook "/opt/efitz/ubuntu-letsencrypt-unifi-cert-install.sh" -n >> /var/log/le-renew.log

echo Restoring normal security groups...
aws ec2 modify-instance-attribute  --instance-id $INSTANCEID --groups "sg-049fb2239760192c0" "sg-08474552d715b885f" "sg-0efadd2c907d7e98c"
