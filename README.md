# sitediff-site

## Deployment

```
docker-compose build
docker-compose up -d
```

You may then access the site at http://localhost


## Development

All custom code goes into `code/src/` folder. The `web/` folder is generated during the build process and is excluded from the repo.

- code/src
  - images
  - pug
  - sass

### Images

All images/assets such as .png .jpg .svg goes into this folder. It will be copied over to `web/images` on build.

### Pug

Template engine Pug will be used to generate HTML. All files within root of `code/src/pug/` directory will be made into a .html file of the same name over the `web` folder and can be accessed by visiting `http://localhost/<file_name>.html`. All internal folders won't be compiled and will serve only as resources for includes. Gulp watch will trigger for changes in any .pug file in `src/pug` or it's subfolders.

### Sass

Gulp will compile only `code/src/sass/styles.scss` into `web/css/styles.css`. This file should only have includes for other resources. Gulp watch will trigger for changes in any .scss file in `src/sass/` or it's subfolders.

The current layout of this repo is focused on production deployment. For use as a development environment some changes would need to be made for you to be able to run `gulp watch` as presently this repository expects you to apply any coding changes and then rebuild the Docker image to get the site up and running.
