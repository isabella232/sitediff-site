# Sitediff-Site

## Deployment

```
docker-compose up --build -d prod
```

You may then access the site by visiting https://localhost:18180


## Development

```
docker-compose up --build -d dev
docker-compose exec dev yarn install
docker-compose exec dev gulp build
```

You may then visit http://localhost:18180 to access the site.

Two containers are defined in `docker-compose.yml`. One for the purpose of production and/or distributing this site as a docker image independent of any code. This is referrer to as `prod`. It does not mount volumes, all code lives as a static assets within the image. Code is compiled by Docker during the build process and assets used only for the purpose of compiling are discarded and not committed in the resulting image. Updates to the code require a rebuild of the image.

A second container for the purpose of development referred to as `dev`. This container includes the build dependencies of `npm`/`yarn` and `gulp`. Here we mount the codebase in `./code` and can run `gulp watch` to actively develop the site by modifying the contents of the `code` directory. Hard refreshing the page in the browser will then update the site.

### Opening a Shell in the Dev Container


```
docker-compose exec dev sh

```

**Notes:** `npm install` does not work in volume mounts. Instead we must use `yarn install` in it's place. `yarn` version locks dependencies with the `yarn.lock` file. To install the latest version of these dependencies while still respecting the version constrains in `package.json` run `yarn upgrade` within the container.

### Layout

All custom code goes into `code/src/` folder. The `web/` folder is generated during the build process and is excluded from the repo.

- code/src
  - images
  - pug
  - sass

### Gulp

To run `gulp watch` open a dedicated terminal window and run the below command. Once you are done you may run `Ctrl + C` to exit `gulp watch`.

```
docker-compose exec dev gulp watch

```

#### Images

All images/assets such as .png .jpg .svg goes into this folder. It will be copied over to `web/images` on build.

#### Pug

Template engine Pug will be used to generate HTML. All files within root of `code/src/pug/` directory will be made into a .html file of the same name over the `web` folder and can be accessed by visiting `http://localhost/<file_name>.html`. All internal folders won't be compiled and will serve only as resources for includes. `gulp watch` will watch for changes in any `.pug` file in `src/pug` or it's subfolders.

#### Sass

Gulp will compile only `code/src/sass/styles.scss` into `web/css/styles.css`. This file should only have includes for other resources. Gulp watch will trigger for changes in any `.scss` file in `src/sass/` or it's subfolders.
