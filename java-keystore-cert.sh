#!/bin/bash

#
#
# Create keystore to sign https-certificate and code-signer
# Andre Luna - 2022

# Run is script after generate the certificate with Let's Encrypt Authority X3 cert
# Example:
#	/etc/letsencrypt/live/updates.losenolove.com/cert.pem 
#	/etc/letsencrypt/live/updates.losenolove.com/privkey.pem
# 
# 

CERT_DOMAIN_NAME="updates.losenolove.com" 		# domain 
CERT_PASSWORD="uGFP0x80bBdt60o!su%PWi" 			# cert password

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

#
#
# Malleable C2 Cobalt Strike profile configuration
#
#

#https-certificate {
#     set keystore "updates.losenolove.com.keystore";
#     set password "uGFP0x80bBdt60o!su%PWi";
#}

#code-signer {
#    set keystore "updates.losenolove.com.keystore";
#    set password "uGFP0x80bBdt60o!su%PWi";
#    set alias    "updates.losenolove.com";
#    set timestamp "true";
#    #set timestamp_url "set://timestamp.digicert.com";
#}
