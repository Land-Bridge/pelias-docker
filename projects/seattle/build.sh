#!/bin/bash
set -x # Enable command tracing for debugging

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