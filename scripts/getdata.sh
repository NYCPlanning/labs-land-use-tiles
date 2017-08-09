
#!/bin/sh

rm -rf tmp && \
[[ -d tmp ]] || mkdir tmp && \
rm -rf data && \
[[ -d data ]] || mkdir data && \
cd tmp && \
wget --no-check-certificate -O pluto.zip "https://cartoprod.capitalplanning.nyc/user/cpp/api/v2/sql?format=SHP&filename=pluto&q=SELECT a.the_geom_webmercator as the_geom, b.description as landuse, address FROM support_mappluto a LEFT JOIN support_landuse_lookup b ON a.landuse::integer = b.code" && \
ls && \
unzip pluto.zip && \
rm pluto.zip
mv * ../data/
cd .. && \
rm -rf tmp
