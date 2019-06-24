#!/bin/bash

# install the current letsencrypt certificate in the Unifi application Java key store

echo Restarting Apache...
/etc/init.d/apache2 restart

# translate the letsencrypt cert and keys to Java keystore format
echo Creating Java key store...
openssl pkcs12 -export -in "/etc/letsencrypt/live/$HOSTNAME/cert.pem" -inkey "/etc/letsencrypt/live/$HOSTNAME/privkey.pem" -out /tmp/unifikeystore.p12 -name unifi -CAfile /etc/letsencrypt/live/$HOSTNAME/fullchain.pem -caname root -passout "pass:unifipassword"
keytool -importkeystore -deststorepass aircontrolenterprise -destkeypass aircontrolenterprise -destkeystore /tmp/unifikeystore.jks -srckeystore /tmp/unifikeystore.p12 -srcstoretype PKCS12 -srcstorepass unifipassword -alias unifi -noprompt

# back up old keystore (this probably should only be done if there was a change, but oh well
echo Backing up old key store...
mv /usr/lib/unifi/data/keystore /usr/lib/unifi/data/keystore.original

# put new keystore in place
echo Putting new key store in place...
mv /tmp/unifikeystore.jks /usr/lib/unifi/data/keystore

# new cert doesn't take effect until service is restarted
echo Restarting Unifi controller...
service unifi restart
