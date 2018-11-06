#!/bin/bash
#Many Thanks: https://www.sslshopper.com/article-most-common-openssl-commands.html
echo "Creating a ROOT CA"
openssl genrsa -aes256 -out CA.key 8196
openssl req -new -x509 -key CA.key -out CA.cer -days 3652 -sha256 -subj "/C=US/ST=SomeState/L=SomeCity/O=SomeOffice/CN=InternalTrustedCASignerRoot"
openssl x509 -inform der -in CA.cer -out CA.pem
echo "Your ROOT CA is"
openssl x509 -text < CA.cer
echo "SSL Cert Req Generation"
for i in `echo $@`
do
openssl req -nodes -newkey rsa:4096 -keyout $i.key -out $i.csr -subj "/C=US/ST=SomeState/L=SomeCity/O=SomeOffice/CN=$i"
openssl x509 -req -in $i.csr -out $i.cer -CA CA.cer -CAkey CA.key  -sha256 -CAcreateserial
openssl x509 -inform der -in $i.cer -out $i.pem
#mv $i.csr $i.certificate_request_file_Can_be_deleted
rm $i.csr
done
