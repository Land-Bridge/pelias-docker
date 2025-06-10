#!/bin/bash
set -x

# remove network if it exists
docker network rm pelias_seattle_default

# go to the project directory
cd $(dirname $0)

# install pelias script
# make sure that /usr/local/bin is in your $PATH
sudo ln -s "$(pwd)/pelias" /usr/local/bin/pelias

# create data directory
mkdir -p ./data

# create .env file
# Create default .env if it doesn't exist
if [ ! -f .env ]; then
    echo "COMPOSE_PROJECT_NAME=pelias_seattle" > .env
    echo "DATA_DIR=/tmp/pelias/" >> .env
    echo "Created default .env file"
fi


# run build
pelias compose pull
pelias elastic start
pelias elastic wait
pelias elastic drop
pelias elastic create
pelias download all
pelias prepare all
pelias import osm
pelias compose up

# # optionally run tests
# pelias test run
