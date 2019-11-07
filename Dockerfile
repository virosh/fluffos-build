### FluffOS Docker build file
FROM debian:stable
MAINTAINER Veselin Mihaylov vm@angband.eu
LABEL Description="This is a Docker image for building FluffOS driver binaries." 
LABEL Vendor="Virosh Labs" 
LABEL Version="1.0-v2019" 
LABEL Instructions="To run: docker run --rm -v /path/to/source:/usr/src/fluffos --env BUILD_FLAGS virlab/fluffos-build:v2019"
LABEL Filesystem="/usr/src/fluffos: directory where the fluffos source resides."
LABEL Build_Flags="By default the build type is 'Debug'. In order to build for production you need to add '--release' to an environment variable BUILD_FLAGS."

### Environment variables
ENV USR user
ENV GRP user
ENV GID 1000
ENV UID 1000

### Set the workdir
WORKDIR /usr/src/fluffos

### Create the user which will build FluffOS
RUN groupadd -g $GID $GRP && \
useradd -u $UID -g $GID -G users -d /usr/src/fluffos $USR

### Install the needed packages.
RUN apt-get update && \
apt-get -y install build-essential bison python3 cargo python-pip pkg-config libevent-2.1-6 libevent-dev libjemalloc-dev libicu-dev \
default-libmysqlclient-dev libpcre3-dev libpq-dev libsqlite3-dev libssl-dev libz-dev libgtest-dev libboost-dev && \
apt-get clean && \
apt-get -y autoremove --purge && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*_* && \
pip install --upgrade cmake

### Set the user which wich we will run the service
USER $USR

### Start the build
CMD cd target && \
rm -rf debug release && \
cd /usr/src/fluffos && \
cargo build $BUILD_FLAGS && \
echo "Build Done!"

