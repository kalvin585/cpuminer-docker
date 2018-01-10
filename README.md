# cpuminer-docker

The repository contains Dockerfile for JayDDee/cpuminer-opt build
with automatic AES/SSE2/SSE4.2/AVX/AVX2 optimizations detection at container startup.

Usage: docker run kalvin585/cpuminer --url xxxx --user xxxx --pass xxxx

Example:
  docker run kalvin585/cpuminer -a yescrypt -o stratum+tcp://yescrypt.mine.zpool.ca:6233 \
    -u 1P9uwDkvPhzp6rheW8Tzmd4GaYvSxcSSFE -p c=BTC,stats,d=2,id=$(hostname -s)

