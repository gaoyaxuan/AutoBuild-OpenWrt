#!/bin/bash
#1. Modify default IP
cd openwrt

sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate
# 使用1.1.1j , 1.1.1k会导致openssh 无法连接
cp -f files/openssl-Makefile   package/libs/openssl/Makefile
cp -f files/430-e_devcrypto-make-the-dev-crypto-engine-dynamic.patch  package/libs/openssl/patches/430-e_devcrypto-make-the-dev-crypto-engine-dynamic.patch

# 默认还是使用uhttpd
cp -f files/60_nginx-luci-support   feeds/packages/net/nginx/files-luci-support/60_nginx-luci-support


#openssh 更改PermitRootLogin yes
code='sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" $(1)/etc/ssh/sshd_config'
`sed -i "227a\${code}" feeds/packages/net/openssh/Makefile`
