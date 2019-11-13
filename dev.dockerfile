FROM node:12-alpine

RUN apk update \
  && apk add gcc g++ zlib-dev make autoconf automake git file nasm nginx \
  && mkdir -p /run/nginx \
  && npm install --global gulp

COPY configs/nginx-dev /etc/nginx
WORKDIR /srv/sitediff.io

CMD ["nginx", "-g", "daemon off;"]
