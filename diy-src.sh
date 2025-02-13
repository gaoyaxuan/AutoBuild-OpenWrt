#!/bin/bash

#echo "src-git packages https://github.com/coolsnowwolf/packages" > ./feeds.conf.default
#echo "src-git luci https://github.com/coolsnowwolf/luci.git;openwrt-23.05" >> ./feeds.conf.default
#echo "src-git routing https://github.com/coolsnowwolf/routing" >> ./feeds.conf.default
#echo "src-git telephony https://git.openwrt.org/feed/telephony.git" >> ./feeds.conf.default

echo 'src-git istore https://github.com/linkease/istore;main' >> feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install -a


# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}


# 移除要替换的包
rm -rf feeds/packages/net/mosdns
rm -rf feeds/luci/applications/luci-app-mosdns
#rm -rf feeds/packages/net/msd_lite
#rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/themes/luci-theme-argon
#rm -rf feeds/luci/themes/luci-theme-argon-mod
#rm -rf feeds/luci/themes/luci-theme-netgear
rm -rf feeds/luci/applications/luci-app-serverchan
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/applications/luci-app-passwall2
rm -rf feeds/luci/applications/luci-app-pushbot


# 添加额外插件
#git clone --depth=1 https://github.com/kongfl888/luci-app-adguardhome package/luci-app-adguardhome
git clone --depth=1 https://github.com/tty228/luci-app-wechatpush package/luci-app-serverchan
git clone --depth=1 https://github.com/brvphoenix/luci-app-wrtbwmon package/luci-app-wrtbwmon
git clone --depth=1 https://github.com/brvphoenix/wrtbwmon package/wrtbwmon

git clone --depth=1  https://github.com/gaoyaxuan/luci-app-pushbot package/luci-app-pushbot
#git clone --depth=1 https://github.com/ilxp/luci-app-ikoolproxy package/luci-app-ikoolproxy
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
git clone --depth=1 https://github.com/destan19/OpenAppFilter package/OpenAppFilter
#git clone --depth=1 https://github.com/Jason6111/luci-app-netdata package/luci-app-netdata
#git_sparse_clone main https://github.com/Lienol/openwrt-package luci-app-filebrowser luci-app-ssr-mudb-server
#git_sparse_clone openwrt-18.06 https://github.com/immortalwrt/luci applications/luci-app-eqos
# git_sparse_clone master https://github.com/syb999/openwrt-19.07.1 package/network/services/msd_lite

# MosDNS
git clone --depth=1 https://github.com/sbwml/luci-app-mosdns -b v5 package/luci-app-mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# msd_lite
#git clone --depth=1 https://github.com/ximiTech/luci-app-msd_lite package/luci-app-msd_lite
#git clone --depth=1 https://github.com/ximiTech/msd_lite package/msd_lite


# 科学上网插件
git clone --depth=1  https://github.com/fw876/helloworld package/luci-app-ssr-plus
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall package/luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2 package/luci-app-passwall2
git_sparse_clone master https://github.com/vernesong/OpenClash luci-app-openclash

# Themes
#git clone --depth=1  https://github.com/kiddin9/luci-theme-edge package/luci-theme-edge
git clone --depth=1  https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config
#git clone --depth=1 https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
#git_sparse_clone main https://github.com/haiibo/packages luci-theme-atmaterial luci-theme-opentomcat luci-theme-netgear



# 在线用户
#git_sparse_clone main https://github.com/haiibo/packages luci-app-onliner
#sed -i '$i uci set nlbwmon.@nlbwmon[0].refresh_interval=2s' package/lean/default-settings/files/zzz-default-settings
#sed -i '$i uci commit nlbwmon' package/lean/default-settings/files/zzz-default-settings
#chmod 755 package/luci-app-onliner/root/usr/share/onliner/setnlbw.sh



