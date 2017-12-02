
#!/bin/sh

rm -rf tmp && \
[[ -d tmp ]] || mkdir tmp && \
rm -rf data && \
[[ -d data ]] || mkdir data && \
cd tmp && \
wget --no-check-certificate -O pluto.zip "https://carto.planninglabs.nyc/user/cpp/api/v2/sql?format=SHP&filename=pluto&q=SELECT%20a.the_geom_webmercator%20as%20the_geom,%20a.landuse,%20b.description,%20address%20FROM%20support_mappluto%20a%20LEFT%20JOIN%20support_landuse_lookup%20b%20ON%20a.landuse::integer%20=%20b.code" && \
ls && \
unzip pluto.zip && \
rm pluto.zip
mv * ../data/
cd .. && \
rm -rf tmp
