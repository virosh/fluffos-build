### FluffOS Docker build file
FROM debian:latest
MAINTAINER Veselin Mihaylov vm@angband.eu
LABEL Description="This is a Docker image for building FluffOS driver binaries." 
LABEL Vendor="Virosh Labs" 
LABEL Version="1.0-v2017" 
LABEL Instructions="To run: docker run --rm -v /path/to/source:/usr/src/fluffos --env BUILD_FLAGS virlab/fluffos-build:v2017"
LABEL Filesystem="/usr/src/fluffos: directory where the fluffos source resides."
LABEL Build_Flags="In order to build \"develop\" version you need to add this flag to the environment variable BUILD_FLAGS. eg. \"export BUILD_FLAGS=develop\""

### Environment variables
ENV USR user
ENV GRP user
ENV GID 1000
ENV UID 1000

### Set the workdir
WORKDIR /usr/src/fluffos

### Create the user which will run FluffOS
RUN groupadd -g $GID $GRP && \
useradd -u $UID -g $GID -G users -d /usr/src/fluffos $USR

### Install the needed packages.
RUN apt-get update && \
apt-get -y install build-essential bison autoconf automake git libevent-dev libjemalloc-dev \
default-libmysqlclient-dev libpcre3-dev libpq-dev libsqlite3-dev libssl-dev libz-dev libgtest-dev && \
apt-get -y autoremove --purge && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*_*


### Set the user which wich we will run the service
USER $USR

### Start the build
CMD cd src && \
make clean && \
./build.FluffOS $BUILD_FLAGS && \
make && \
echo "Build Done!"

