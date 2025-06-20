# Use a lightweight Nginx base image
FROM nginx:alpine

# Set the working directory
WORKDIR /usr/share/nginx/html

RUN mkdir -p /mnt/volumes/configuration /mnt/volumes/data

# Copy static HTML files for multiple domains
# COPY ./static /usr/share/nginx/html/static
COPY ./static /mnt/volumes/data/static

# Copy custom Nginx configuration file
# COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY default.conf /mnt/volumes/configuration/default.conf

RUN ln -fsv /mnt/volumes/configuration/default.conf /etc/nginx/conf.d/default.conf \
 && ln -fsv /mnt/volumes/data/static /usr/share/nginx/html/static \
 && apk add bind-tools openssl \
 && openssl req -x509 -nodes -days 365 \
 -subj "/C=US/ST=North Carolina/L=Charlotte/O=Self-Signed Auto-Generated Certificate/OU=nginx/CN=localhost/emailAddress=nginx@fqdn.tld" \
 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key \
 -out /etc/ssl/certs/nginx-selfsigned.crt


# Exposeport htt and https
EXPOSE 80
EXPOSE 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

