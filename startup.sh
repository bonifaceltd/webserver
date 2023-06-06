#!/bin/bash

# Install Nginx
apt-get update
apt-get install -y nginx

openssl req -x509 -newkey rsa:4096 -keyout /etc/key.pem -out /etc/cert.pem -sha256 -days 3650 -nodes -subj "/C=XX/ST=StateName/L=CityName/O=CompanyName/OU=CompanySectionName/CN=CommonNameOrHostname"

# Configure Nginx to listen on port 443 and respond with the plaintext response
cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80;
    server_name _;

    location /hello/ {
        return 301 https://\$host\$request_uri;
    }
}

server {
    listen 443 ssl;
    server_name _;

    ssl_certificate /etc/cert.pem;
    ssl_certificate_key /etc/key.pem;

    location /hello/ {
        return 200 "world";
    }
}
EOF

# Restart Nginx to apply the configuration
systemctl restart nginx
