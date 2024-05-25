#!/bin/bash

# Set default theme to luci-theme-argon
uci set luci.main.mediaurlbase='/luci-static/argon'
uci commit luci

# Disable IPV6 ula prefix
# sed -i 's/^[^#].*option ula/#&/' /etc/config/network

# Check file system during boot
# uci set fstab.@global[0].check_fs=1
# uci commit fstab



# openssh 允许root登录

openssh_config="/etc/ssh/sshd_config"

if [ -e "$openssh_config" ]; then
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' $openssh_config
else
    echo "文件不存在"
fi

#code='\\tsed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g"  $(1)/etc/ssh/sshd_config'
#`sed -i "227a\${code}" openwrt/feeds/packages/net/openssh/Makefile`




exit 0
