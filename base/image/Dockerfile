FROM phusion/baseimage:0.9.11

# set variables
ENV ICINGA_VERSION 2.6.3

# install dependencies
RUN apt-get update && \
    apt-get install -y cmake make build-essential pkg-config libssl-dev \
        libboost-all-dev bison flex && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add icinga user and groups
RUN groupadd icinga && \
    groupadd icingacmd && \
    useradd -c "icinga" -s /sbin/nologin -G icingacmd -g icinga icinga

# make from sources
ADD "https://github.com/Icinga/icinga2/archive/v${ICINGA_VERSION}.tar.gz" /tmp
RUN cd "/tmp/icinga2-${ICINGA_VERSION}" && \
    mkdir -p build && \
    cd build && \
    cmake .. -DICINGA2_WITH_MYSQL=OFF -DICINGA2_WITH_PGSQL=OFF -DCMAKE_INSTALL_PREFIX= && \
    make && \
    make install

RUN chown icinga:icinga /var/cache/icinga2

# set the start command
CMD ["/sbin/my_init"]
