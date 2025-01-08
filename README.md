
## Cobalt Strike - Valid SSL Certificate and Code Signing

<br>

#### Documentation references, see at: 
<br>

[Code Signing Certificate](https://hstechdocs.helpsystems.com/manuals/cobaltstrike/current/userguide/content/topics/malleable-c2_code-signing-certificate.htm#_Toc65482849)

[Valid SSL Certificates with SSL Beacon](https://hstechdocs.helpsystems.com/manuals/cobaltstrike/current/userguide/content/topics/malleable-c2_valid-ssl-certificates.htm#_Toc65482847)

<hr>

### Step 0

#### I'm insert new update in the shell script. Now, the script automatic generate Let's Encrypt certificate. Just insert the domain name and e-mail address.

```
# domain name
CERT_DOMAIN_NAME="updates.losenolove.com"
# cert password to java keystore
CERT_PASSWORD="uGFP0x910299201t60o!su%PWi"
# e-mail to generate cert with let's encrypt
EMAIL="email@gmail.com"
```

<hr>

### Step 1



#### Generate an valid certificate with Let`s Encrypt.



#### Certbot Command for Apache2: 



``` 
certbot -n --apache -d updates.losenolove.com --agree-tos --email myaccount@mail --no-eff-email --hsts --redirect
```



![Image](images/001.png)




#### Run certbot command to generate Let`s Encrypt certificate keys.



![Image](images/003.png)



![Image](images/004.png)



### Step 2



#### Configure the Shell Script java-keystore-cert.sh with informations about domain and password and run script to generate certificates in current path directory.


![Image](images/013.png)



![Image](images/005.png)



### Step 3 



#### To use certificates in Malleable C2 Profiles, the files need to stay in same profile directory.



![Image](images/006.png)



![Image](images/007.png)



#### Use C2lint script to check configurations in profile.



![Image](images/008.png)



### Step 4



#### Just test.



![Image](images/009.png)



![Image](images/010.png)



![Image](images/011.png)



![Image](images/012.png)

