FROM node:12-alpine AS gulp

RUN apk update \
  && apk add gcc g++ zlib-dev make autoconf automake git file nasm

COPY code /var/build
WORKDIR /var/build

# Remove node_modules and web directory if present from development
# Then reinstall node modules and gulp build
RUN rm -Rf node_modules web \
  && yarn install \
  && npm install --global gulp \
  && gulp build
###################################################################
###################################################################
FROM nginx:stable-alpine

COPY --from=gulp /var/build/web /srv/sitediff.io
COPY configs/nginx-prod /etc/nginx
