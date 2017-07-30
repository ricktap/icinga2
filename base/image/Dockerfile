FROM phusion/baseimage:0.9.11

# set variables
ENV ICINGA_VERSION 2.6.3
ENV NAGIOS_PLUGINS_VERSION 2.2.1

# install dependencies
RUN apt-get update && \
    apt-get install -y curl cmake make build-essential pkg-config libssl-dev \
        libboost-all-dev bison flex libmysqlclient-dev mysql-client-core-5.6 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add icinga user and groups
RUN groupadd icinga && \
    groupadd icingacmd && \
    useradd -c "icinga" -s /sbin/nologin -G icingacmd -g icinga icinga

# make icinga from sources
RUN curl -sSL "https://github.com/Icinga/icinga2/archive/v${ICINGA_VERSION}.tar.gz" | tar xz -C /tmp
RUN cd "/tmp/icinga2-${ICINGA_VERSION}" && \
    mkdir -p build && \
    cd build && \
    cmake .. -DICINGA2_WITH_MYSQL=ON -DICINGA2_WITH_PGSQL=OFF -DCMAKE_INSTALL_PREFIX= && \
    make && \
    make install

# move the config directory
RUN mv /etc/icinga2 /config && \
    ln -s /config /etc/icinga2

# make nagios plugins from sources
RUN curl -sSL "http://www.nagios-plugins.org/download/nagios-plugins-${NAGIOS_PLUGINS_VERSION}.tar.gz" | tar xz -C /tmp
RUN cd "/tmp/nagios-plugins-${NAGIOS_PLUGINS_VERSION}" && \
    ./configure --prefix=/usr/lib/nagios --libexecdir=/usr/lib/nagios/plugins && \
    make && \
    make install

# enable icinga features
RUN icinga2 feature enable ido-mysql command api

# setup start scripts
RUN mkdir -p /etc/my_init.d
COPY src/mysql_init.sh /etc/my_init.d/01_mysql_init.sh
COPY src/run.sh /etc/my_init.d/10_run.sh
RUN chmod +x /etc/my_init.d/*.sh

# fix cache permissions
RUN chown icinga:icinga /var/cache/icinga2

VOLUME /config

EXPOSE 5665

# set the start command
CMD ["/sbin/my_init"]
