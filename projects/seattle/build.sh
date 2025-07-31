#!/bin/bash
set -x # Enable command tracing for debugging

mkdir -p ./data
echo "COMPOSE_PROJECT_NAME=pelias_seattle" > .env
# IMPORTANT: Set DATA_DIR to the persistent './data' directory
echo "DATA_DIR=$(pwd)/data/" >> .env # Use absolute path for clarity and robustness
echo "Created default .env file"

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