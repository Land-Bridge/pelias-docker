#!/bin/bash
set -x # Enable command tracing for debugging

pelias compose down -v

rm -rf data
mkdir -p data/csv

# Exports data from land_db as csv to import into pelias
ogr2ogr \
  -f CSV data/csv/parcels.csv \
  PG:"host=localhost port=5432 user=postgres dbname=land_db password=password" \
  -sql "SELECT \
    spatial_parcel_point_id AS id, \
    address AS name, \
    city AS city, \
    state AS state, \
    zip AS postcode, \
    ST_X(ST_Transform(ST_Centroid(geom), 4326)) AS lon, \
    ST_Y(ST_Transform(ST_Centroid(geom), 4326)) AS lat, \
    'custom' AS source, \
    'address' AS layer \
  FROM gis.property_analysis_combined" \
  -lco "SEPARATOR=COMMA"

pelias compose pull
pelias elastic start
pelias elastic wait
pelias elastic create
pelias download osm
pelias download wof
pelias download csv
pelias import osm
pelias import wof
pelias import csv
pelias compose up

# --- Optional: Run Tests ---
# Uncomment the line below if you want to run Pelias acceptance tests after building.
# pelias test run