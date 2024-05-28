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
fi

#code='\\tsed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g"  $(1)/etc/ssh/sshd_config'
#`sed -i "227a\${code}" openwrt/feeds/packages/net/openssh/Makefile`

#Firewall屏蔽
if which ipset > /dev/null; then
      cat /etc/blacklist/firewall.user >> /etc/firewall.user
      sed -i '/exit/i\sh  /etc/blacklist/create_blacklist_ipset.sh' /etc/rc.local
      chown -R root:root /etc/blacklist
      chmod -R 644 /etc/blacklist/
      chmod +x /etc/rc.local
fi


exit 0
