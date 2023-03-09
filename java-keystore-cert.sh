#!/bin/bash

#
#
# Create keystore to sign https-certificate and code-signer
# Andre Luna - 2023
# https://github.com/andreluna/code-signer-cobaltstrike
#
#

# Tested on Ubuntu 18.04.06 LTS.

# Run is script after generate the certificate with Let's Encrypt Authority X3 cert
# Example:
#	/etc/letsencrypt/live/updates.losenolove.com/cert.pem 
#	/etc/letsencrypt/live/updates.losenolove.com/privkey.pem
# 

# ###########################################################
# ###########################################################
# ################## VARIABLES HERE #########################

# domain name
CERT_DOMAIN_NAME="updates.losenolove.com"

# cert password to java keystore
CERT_PASSWORD="uGFP0x910299201t60o!su%PWi"

# e-mail to generate cert with let's encrypt
EMAIL="email@gmail.com"

# ###########################################################
# ###########################################################
# ###########################################################

#
# Generating Let's Encrypt certificate SSL with Apache2
#

# installing apache2 cerbot and python-certbot-apache
apt update
apt install apache2
apt install certbot python3-certbot-apache -y

systemctl stop apache2
systemctl start apache2

# generating cert let's encrypt
# https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu-20-04

certbot -n --apache -d $CERT_DOMAIN_NAME --agree-tos --email $EMAIL --no-eff-email --hsts --redirect

# Generating valid SSL Cert to assign exe, dll beacon and artifact
# https://hstechdocs.helpsystems.com/manuals/cobaltstrike/current/userguide/content/topics/malleable-c2_valid-ssl-certificates.htm

#https-certificate {
#     set keystore "updates.losenolove.com.keystore";
#     set password "uGFP0x910299201t60o!su%PWi";
#}

#code-signer {
#    set keystore "updates.losenolove.com.keystore";
#    set password "uGFP0x910299201t60o!su%PWi";
#    set alias    "updates.losenolove.com";
#    set timestamp "false";
#    # set timestamp_url "set://timestamp.digicert.com";
#}

openssl pkcs12 -export \
	 -in /etc/letsencrypt/live/$CERT_DOMAIN_NAME/cert.pem \
	 -inkey /etc/letsencrypt/live/$CERT_DOMAIN_NAME/privkey.pem \
	 -out /tmp/$CERT_DOMAIN_NAME.p12 \
	 -name $CERT_DOMAIN_NAME \
	 -CAfile /etc/letsencrypt/live/$CERT_DOMAIN_NAME/fullchain.pem \
	 -caname "Let's Encrypt Authority X3" \
	 -password pass:$CERT_PASSWORD

keytool -importkeystore \
	-deststorepass $CERT_PASSWORD \
	-destkeypass $CERT_PASSWORD \
	-deststoretype pkcs12 \
	-srckeystore /tmp/$CERT_DOMAIN_NAME.p12 \
	-srcstoretype PKCS12 \
	-srcstorepass $CERT_PASSWORD \
	-destkeystore /tmp/$CERT_DOMAIN_NAME.keystore \
	-alias $CERT_DOMAIN_NAME

# move cert file to current path directory
mv /tmp/$CERT_DOMAIN_NAME.p12 .
mv /tmp/$CERT_DOMAIN_NAME.keystore .

# stoping apache2
systemctl stop apache2

# show files
echo "###########################################################"
echo "###########################################################"
echo "apache2 - /etc/apache2/sites-available/000-default-le-ssl.conf"
ls -lsht /etc/apache2/sites-available

echo ""
echo "###########################################################"
echo "###########################################################"
echo "letsencrypt - /etc/letsencrypt/live/"
ls -lsht /etc/letsencrypt/live/