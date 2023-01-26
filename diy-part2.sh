#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 1.修改默认ip
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 2.修改主机名
# sed -i 's/OpenWrt/K2P/g' package/base-files/files/bin/config_generate

# 4.修改版本号
sed -i "s/OpenWrt /0012h build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# 6.设置ttyd免登录
# sed -i 's/\/bin\/login/\/bin\/login -f root/' /etc/config/ttyd

# Install theme
rm -rf package/lean/luci-theme-*
#git clone -b 18.06 https://github.com/iboytech/luci-theme-edge.git package/lean/luci-theme-edge
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  
git clone https://github.com/jerrykuku/luci-app-argon-config.git  package/lean/luci-theme-argon-config

# 5.修改默认主题
sed -i ' s/luci-theme-bootstrap/luci-theme-argon/g ' feeds/luci/collections/luci/Makefile

# 7.修正连接数（by ベ七秒鱼ベ）
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

# Change opkg source
echo "sed -i 's#https://mirrors.cloud.tencent.com/lede/snapshots#https://k2p.dreamwalkerxz.workers.dev/k2p-repo#g' /etc/opkg/distfeeds.conf" >> package/lean/default-settings/files/zzz-default-settings

# 设置默认SSID的名称
sed -i 's|OpenWRT-2.4G.*|OpenWrt-2.4G\"|g' package/lean/mt/drivers/mt7615d/files/lib/wifi/mt_dbdc.sh

# 设置默认SSID的名称
sed -i 's|OpenWRT-5G.*|OpenWrt-5G\"|g' package/lean/mt/drivers/mt7615d/files/lib/wifi/mt_dbdc.sh 
