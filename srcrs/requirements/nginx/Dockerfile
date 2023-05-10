FROM debian:buster-slim

RUN  apt-get update && apt-get install -y nginx openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/key.pem -out /etc/nginx/cert.pem \
    -subj "/C=US/ST=California/L=San Francisco/O=My Organization/OU=My Unit/CN=mydomain.com"

COPY conf/nginx.conf /etc/nginx/sites-available/default
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
