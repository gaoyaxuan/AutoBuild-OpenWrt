#!/bin/bash
readonly script_dir=$(cd "$(dirname $0)" && pwd)
#1. Modify default IP
sed -i 's/192.168.1.1/10.0.0.1/g' openwrt/package/base-files/files/bin/config_generate
# 使用1.1.1j , 1.1.1k会导致openssh 无法连接
#cp -f files/openssl-Makefile   openwrt/package/libs/openssl/Makefile
#cp -f files/430-e_devcrypto-make-the-dev-crypto-engine-dynamic.patch  openwrt/package/libs/openssl/patches/430-e_devcrypto-make-the-dev-crypto-engine-dynamic.patch
cd openwrt && git checkout  7436d6866f9dcc1cdf4154b4e9cee9ce9b4faf5a  package/libs/openssl/   && cd $script_dir

# 默认还是使用uhttpd
cp -f files/60_nginx-luci-support   openwrt/feeds/packages/net/nginx/files-luci-support/60_nginx-luci-support

#openssh 降级到8.6p1版本
cd openwrt/feeds/packages && git checkout    0a23629419e267cc7e07c2f87a5301c8875ef9a3   net/openssh/  && cd $script_dir

#openssh 更改PermitRootLogin yes
code='\\tsed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g"  $(1)/etc/ssh/sshd_config'
`sed -i "227a\${code}" openwrt/feeds/packages/net/openssh/Makefile`

cd "$script_dir"