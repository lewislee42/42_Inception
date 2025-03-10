Remember to source the env or find a way to get the users username to get
the directory

# Generating a dhparam.key for Diffie-Hellman (DH) parameter which is used in ephemeral key exchange when establishing TLS (SSL) connections.
openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048
* then move this file to the secrets directory replacing the one already there

# Generating a self-signed cert for running with nginx
Step 1: Generate a Private Key (using modern genpkey)
`openssl genpkey -algorithm RSA -out cert.key -pkeyopt rsa_keygen_bits:2048`
(If you still want to use genrsa, it's fine but not best practice.)
Step 2: Generate a Certificate Signing Request (CSR)
`openssl req -new -key cert.key -out cert.csr`
(You'll be asked to enter details like Common Name (CN), Organization, etc.)
Step 3: Generate a Self-Signed Certificate (Valid for 10 years)
`openssl x509 -req -days 3650 -in cert.csr -signkey cert.key -out cert.pem`
* the csr is no longer needed so you can delete that
* then move these file to the secrets directory replacing the one already there
