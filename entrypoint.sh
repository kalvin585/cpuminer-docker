#!/bin/sh
test -z "$cpuflags" && cpuflags=$(cat /proc/cpuinfo)
#checking AES+AVX2 support
if [ -n "$(echo "$cpuflags " | grep 'avx2 ')" ]; then
	echo Starting CPU miner with AVX2 support
	/usr/local/bin/cpuminer-avx2 $@
else
# checking AES+AVX support
if [ -n "$(echo "$cpuflags " | grep 'aes ' | grep 'avx ')" ]; then
	echo Starting CPU miner with AES+AVX support
	/usr/local/bin/cpuminer-aes-avx $@
else
# checking AES+SSE4.2 support
if [ -n "$(echo "$cpuflags " | grep 'aes ' | grep 'sse4_2 ')" ]; then
	echo Starting CPU miner with AES+SSE4_2 support
	/usr/local/bin/cpuminer-aes-sse42 $@
else
# checking SSE4.2 support
if [ -n "$(echo "$cpuflags " | grep 'sse4_2 ')" ]; then
	echo Starting CPU miner with SSE4_2 support
	/usr/local/bin/cpuminer-sse42 $@
else
# checking SSSE3 support
if [ -n "$(echo "$cpuflags " | grep 'ssse3 ')" ]; then
	echo Starting CPU miner with SSSE3 support
	/usr/local/bin/cpuminer-ssse3 $@
else
# checking SSE2 support
if [ -n "$(echo "$cpuflags " | grep 'sse2 ')" ]; then
	echo Starting CPU miner with SSE2 support
	/usr/local/bin/cpuminer-sse2 $@
else
# no features found
	echo No suitable CPU features found, there is nothing to launch
fi
fi
fi
fi
fi
fi
