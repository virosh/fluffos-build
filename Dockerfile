### FluffOS Docker build file
FROM debian:stable
LABEL Description="This is a Docker image for building FluffOS driver binaries." 
LABEL Vendor="Virosh Labs" 
LABEL Version="1.0-v2019" 
LABEL Instructions="To run: docker run --rm -v /path/to/source:/usr/src/fluffos --env BUILD_FLAGS virlab/fluffos-build:v2019"
LABEL Filesystem="/usr/src/fluffos: directory where the fluffos source resides."
LABEL Build_Flags="In order to enable/disable packages during build you need to add these flags to an environment variable BUILD_FLAGS. Please see the README.md."

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
apt-get -y install build-essential bison python3 python-pip pkg-config doxygen graphviz git libevent-2.1-6 libevent-dev libjemalloc-dev libicu-dev \
default-libmysqlclient-dev libpcre3-dev libpq-dev libsqlite3-dev libssl-dev libz-dev libgtest-dev libboost-dev libdw-dev binutils-dev && \
apt-get clean && \
apt-get -y autoremove --purge && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*_* && \
pip install --upgrade cmake

### Set the user which wich we will run the service
USER $USR

### Start the build
CMD cd build && \
rm -rf CMakeCache.txt  CMakeFiles  cmake_install.cmake  Makefile  src && \
echo $BUILD_FLAGS && \
cmake .. $BUILD_FLAGS && \
make -j4 install

