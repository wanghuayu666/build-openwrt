#!/bin/bash
#========================================================================================================================
# OpenWrt 自动编译脚本
#========================================================================================================================

# 设置 root 默认密码（改为空）
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.::0:99999:7:::/g' package/base-files/files/etc/shadow

# 设置 OpenWrt 版本号
sed -i "s|DISTRIB_REVISION='.*'|DISTRIB_REVISION='R$(date +%Y.%m.%d)'|g" package/base-files/files/etc/openwrt_release
echo "DISTRIB_SOURCECODE='Lienol'" >>package/base-files/files/etc/openwrt_release

# 修改默认 IP 地址
sed -i 's/192.168.[0-9]\{1,3\}.[0-9]\{1,3\}/192.168.99.1/g' package/base-files/files/bin/config_generate

# 添加常用 feed 源
echo 'src-git argon https://github.com/jerrykuku/luci-theme-argon' >>feeds.conf.default
echo 'src-git argon-config https://github.com/jerrykuku/luci-app-argon-config' >>feeds.conf.default

# 安装 luci-i18n-base-zh-cn（Luci 中文语言包）
./scripts/feeds install luci-i18n-base-zh-cn

# 下载 PassWall 依赖
./scripts/feeds install -a -p passwall_packages









# ------------------------------- Other started -------------------------------
#

# coolsnowwolf default software package replaced with Lienol related software package
# rm -rf feeds/packages/utils/{containerd,libnetwork,runc,tini}
# svn co https://github.com/Lienol/openwrt-packages/trunk/utils/{containerd,libnetwork,runc,tini} feeds/packages/utils

# Add third-party software packages (The entire repository)
# git clone https://dl.openwrt.ai/packages-24.10/x86_64/kiddin9/
# Add third-party software packages (Specify the package)
# svn co https://dl.openwrt.ai/packages-24.10/x86_64/kiddin9/
# Add to compile options (Add related dependencies according to the requirements of the third-party software package Makefile)
# sed -i "/DEFAULT_PACKAGES/ s/$/ pirania-app pirania ip6tables-mod-nat ipset shared-state-pirania uhttpd-mod-lua/" target/linux/armvirt/Makefile

# Apply patch
# git apply ../config/patches/{0001*,0002*}.patch --directory=feeds/luci
#
# ------------------------------- Other ends -------------------------------
