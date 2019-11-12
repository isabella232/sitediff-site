FROM node:12-alpine AS gulp

RUN apk update \
  && apk add gcc g++ zlib-dev make autoconf automake git file nasm

COPY code /var/build
WORKDIR /var/build

RUN npm install \
  && npm install --global gulp

RUN gulp build
###################################################################
###################################################################
FROM nginx:stable-alpine
COPY --from=gulp /var/build/web /usr/share/nginx/html
