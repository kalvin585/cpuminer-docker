#
# Dockerfile for JayDDee/cpuminer-opt with automatic SSE/AVX/AVX2 detection
# usage: docker run kalvin585/cpuminer --url xxxx --user xxxx --pass xxxx
# ex: docker run kalvin585/cpuminer -a yescrypt -o stratum+tcp://yescrypt.mine.zpool.ca:6233 -u 1P9uwDkvPhzp6rheW8Tzmd4GaYvSxcSSFE -p c=BTC,stats,d=2,id=`hostname -s`
#

FROM debian:stretch
MAINTAINER Kalvin Harris <harriskalvin585@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

RUN echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf.d/zz-local-tame
RUN apt-get update && apt-get dist-upgrade -y \
 && apt-get install -y git ca-certificates build-essential autoconf automake \
    libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev zlib1g-dev \
 && apt-get --purge autoremove \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean -y

COPY entrypoint.sh /usr/local/bin/

WORKDIR /tmp

RUN git clone https://github.com/JayDDee/cpuminer-opt \
 && cd cpuminer-opt && autoreconf -f -i -v \
 && CFLAGS="-O3 -maes -mssse3 -mavx -mavx2 -mtune=intel -DUSE_ASM -DFOUR_WAY" CXXFLAGS="$CFLAGS -std=gnu++11" ./configure --with-curl \
 && make clean && make -j8 && strip ./cpuminer && mv ./cpuminer /usr/local/bin/cpuminer-avx2 \
 && CFLAGS="-O3 -maes -mssse3 -mavx -mtune=intel -DUSE_ASM" CXXFLAGS="$CFLAGS -std=gnu++11" ./configure --with-curl \
 && make clean && make -j8 && strip ./cpuminer && mv ./cpuminer /usr/local/bin/cpuminer-avx \
 && CFLAGS="-O3 -maes -mssse3 -mtune=intel -DUSE_ASM" CXXFLAGS="$CFLAGS -std=gnu++11" ./configure --with-curl \
 && make clean && make -j8 && strip ./cpuminer && mv ./cpuminer /usr/local/bin/cpuminer \
 && chmod +x /usr/local/bin/* && rm -rf /tmp/*

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
