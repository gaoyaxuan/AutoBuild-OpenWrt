#!/bin/bash
#1. Modify default IP
sed -i 's/192.168.1.1/10.0.0.1/g' openwrt/package/base-files/files/bin/config_generate
# 使用1.1.1j  1.1.1k会导致openssh 无法连接
sed -i 's/PKG_BUGFIX:=k/PKG_BUGFIX:=j/g' openwrt/package/libs/openssl/Makefile
