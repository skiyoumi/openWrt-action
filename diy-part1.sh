#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
#sed -i '/src-git packages / s/^\(.*\)$/#\1/g' feeds.conf.default
#sed -i '/src-git luci / s/^\(.*\)$/#\1/g' feeds.conf.default
#sed -i '/src-git routing / s/^\(.*\)$/#\1/g' feeds.conf.default
#sed -i '/src-git telephony / s/^\(.*\)$/#\1/g' feeds.conf.default
# Add a feed source
#echo 'src-git packages https://github.com/coolsnowwolf/packages' >>feeds.conf.default
#echo 'src-git luci https://github.com/coolsnowwolf/luci.git;openwrt-23.05' >>feeds.conf.default
#echo 'src-git routing https://github.com/coolsnowwolf/routing' >>feeds.conf.default
#echo 'src-git telephony https://github.com/coolsnowwolf/telephony.git' >>feeds.conf.default
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
cd package
git clone https://github.com/jerrykuku/luci-theme-argon.git

mkdir luci-app-openclash
cd luci-app-openclash
git init
git remote add -f origin https://github.com/vernesong/OpenClash.git
git config core.sparsecheckout true
echo "luci-app-openclash" >> .git/info/sparse-checkout
git pull --depth 1 origin master
git branch --set-upstream-to=origin/master master

# 编译 po2lmo (如果有po2lmo可跳过)
pushd luci-app-openclash/tools/po2lmo
make && sudo make install
popd

cd luci-app-openclash/luci-app-openclash
git pull
cd ../../../
