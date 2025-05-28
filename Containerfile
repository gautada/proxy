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
 && ln -fsv /mnt/volumes/data/static /usr/share/nginx/html/static

# Exposeport htt and https
EXPOSE 80
EXPOSE 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

