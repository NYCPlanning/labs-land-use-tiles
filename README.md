# labs-land-use-tiles
A microservice for MapPluto-based raster and vector tiles

## Overview
This is a standalone microservice that serves Raster and Vector tiles based on NYC's MapPLUTO parcel dataset.  Tiles are served at `{domain}/pluto/{z}/{x}/{y}/tile.[png|mvt]`, and may be consumed by any modern web mapping library.

When deployed, a `postinstall` npm script fetches a MapPLUTO shapefile with custom attributes from our carto server, unzips the shapefile and moves it to `/data`.  

The app uses [tilestrata](https://github.com/naturalatlas/tilestrata), an open source node.js tileserver.  tilestrata serves tiles directly from the shapefile without a database.

## Development
- Have `node-mapnik` dependencies already installed for your OS
- Clone this repo.
- Install dependencies `npm install`
- Start the app `npm devstart`

## Raster Style

The rasters created are styled to reflect the `landuse` column in MapPLUTO, using DCP's standard colors for land use codes.

![tile](https://user-images.githubusercontent.com/1833820/29149689-c959b7ee-7d43-11e7-8c3f-9521c3bd123b.png)

The mapnik XML configuration for these colors is in [config.xml](https://github.com/NYCPlanning/labs-land-use-tiles/blob/master/config/raster.xml)

## Deployment
The microservice is designed to be deployed using `dokku`.  It contains two additional files (`apt-packages` and `apt-repositories`) that work with the `dokku-apt` plugin to install low-level dependencies in the container.  

## Why?
We have had success using a [self-hosted carto server](https://github.com/chriswhong/docker-cartodb) for mapping apps, but our installation had issues rendering tiles of NYC parcels at medium zoom levels, where a tile could contain many thousands of features.  A microservice for land us tiles is a good alternative that doesn't require a lot of work to configure and deploy, and can be updated quickly when the data changes.  No databases, no complex servers, just a simple node app using tilestrata.

