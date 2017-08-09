const express = require('express');
const tilestrata = require('tilestrata');
const vtile = require('tilestrata-vtile');
const mapnik = require('tilestrata-mapnik');
const disk = require('tilestrata-disk');

const app = express();
const strata = tilestrata();

const vectorConfig = {
  xml: 'config/vector.xml',
  tileSize: 256,
  metatile: 1,
  bufferSize: 128,
  overrideRenderOptions: (opts) => {
    const newOpts = opts;
    newOpts.simplify_distance = 1;
    return newOpts;
  },
};

const rasterConfig = {
  pathname: 'config/raster.xml',
  scale: 1,
  tileSize: 256,
};

strata
  .layer('pluto')
  .route('tile.mvt')
  .use(vtile(vectorConfig))
  .route('tile.png')
  .use(mapnik(rasterConfig))
  .use(disk.cache({ dir: './cache/' }));

app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
  next();
});

app.use(tilestrata.middleware({
  server: strata,
}));

module.exports = app;
