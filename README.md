# nginx

This is a simple nginx container image.  It can be used in static mode where
the content comes from a ConfigMap.  Or in proxy mode where the content comes
from another source

## Build

```
podman build --file Containerfile --tag proxy:dev
```

## Local Deploy

```
podman run --detach --name proxy --publish 8888:80 --publish 8443:443 --rm \
 --volume Configuration:/mnt/volumes/configuration \
 --volume Data:/mnt/volumes/data proxy:dev 
```


```
openssl req -x509 -nodes \
 -days 365 \
 -subj "/C=US/ST=North Carolina/L=Charlotte/O=Self-Signed Auto-Generated Certificate/OU=nginx/CN=*.cluster.local/emailAddress=nginx@fqdn.tld" \
 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key \
 -out /etc/ssl/certs/nginx-selfsigned.crt
```


