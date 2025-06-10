
# Seattle Metro Area

This project is configured to download/prepare/build a complete Pelias installation for Seattle, Washington.

# Setup

Please refer to the instructions at https://github.com/pelias/docker in order to install and configure your docker environment.

The minimum configuration required in order to run this project are [installing prerequisites](https://github.com/pelias/docker#prerequisites), [install the pelias command](https://github.com/pelias/docker#installing-the-pelias-command) and [configure the environment](https://github.com/pelias/docker#configure-environment).

Please ensure that's all working fine before continuing.

# Run a Build

To run a complete build, execute the following commands in this directory:

```bash
./build.sh
```

# Make an Example Query

You can now make queries against your new Pelias build:

http://localhost:4000/v1/search?text=seattle

http://localhost:4000/v1/search?text=3665%20Interlaken%20Ave%20N%20Seattle%20WA%2098103

http://localhost:4000/v1/search?text=fremont

http://localhost:4000/v1/autocomplete?focus.point.lat=47.6062&focus.point.lon=-122.3321&text=3665%20interlake

# Run Tests

```bash
pelias test run
```