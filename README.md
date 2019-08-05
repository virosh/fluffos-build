# FluffOS Build Image
This docker image is intended to be used to build [FluffOS MUD driver](https://www.fluffos.info/) without the need of installing compiler on your server.

Please note that the driver binaries are dynamically linked and built using a Debian image. If your MUD is not running on a Debian based distribution there maybe issues running the driver.

# Build steps
## v2019 tag
 * Clone the [FluffOS repo](https://github.com/fluffos/fluffos).
 * Checkout the **v2019** tag.
 * Create the directory **build** inside it.
 * Enter **src** directory and edit the **local_options** file to suit your mudlib.
 * Export the environment variable **BUILD_FLAGS** with the packages you want to disable/enable during the build eg. `export BUILD_FLAGS="-DPACKAGE_DB=OFF"` (For more information about packages, please review the FluffOS documentation).
 * Run the build by executing `docker run --rm -v /path/to/fluffos-repo:/usr/src/fluffos --env BUILD_FLAGS virlab/fluffos-build:v2019`
 * When the build is done you will find the binaries inside **build/src** directory.

## v2017 tag
 * Clone the [FluffOS repo](https://github.com/fluffos/fluffos).
 * Checkout the **v2017** tag.
 * Enter **src** directory and edit the **local_options** file to suit your mudlib.
 * Run the build by executing `docker run --rm -v /path/to/fluffos-repo:/usr/src/fluffos virlab/fluffos-build:v2017`
 * When the build is done you will find the binaries inside **src** directory.

## v2017 "develop" tag
 * Clone the [FluffOS repo](https://github.com/fluffos/fluffos).
 * Checkout the **v2017** tag.
 * Enter **src** directory and edit the **local_options** file to suit your mudlib.
 * Export the environment variable **BUILD_FLAGS** with the "develop" flag eg. `export BUILD_FLAGS="develop"`.
 * Run the build by executing `docker run --rm -v /path/to/fluffos-repo:/usr/src/fluffos --env BUILD_FLAGS virlab/fluffos-build:v2017-dev`
 * When the build is done you will find the binaries inside **src** directory.