#!/bin/sh
#checking AVX2 support
if [ -n "$(cat /proc/cpuinfo | grep avx2)" ]; then
	echo Starting CPU miner with AVX2 support
	/usr/local/bin/cpuminer-avx2 $@
else
# checking AVX support
if [ -n "$(cat /proc/cpuinfo | grep avx)" ]; then
	echo Starting CPU miner with AVX support
	/usr/local/bin/cpuminer-avx $@
# no features found
else
	echo Starting CPU miner simple
	/usr/local/bin/cpuminer $@
fi
fi
