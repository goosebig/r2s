#!/bin/bash
#
#部署环境
cd && \
#
sudo apt-get update && \
#
sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3.5 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf
wget -O - https://raw.githubusercontent.com/friendlyarm/build-env-on-ubuntu-bionic/master/install.sh | bash && \
#
cd /tmp/ && \
#
rm -rf repo;\
#
git clone https://github.com/friendlyarm/repo && \
#
sudo cp repo/repo /usr/bin/ && \
#
#删除历史包
rm -rf ~/friendlywrt-rk3328 && \
#
#解压r2s包
cd && \
#
tar xvf friendlywrt-rk3328-20200415.tar && \
#
#更新r2s源码
cd ~/friendlywrt-rk3328/ && \
#
repo sync -l --no-clone-bundle && \
#
repo sync --no-clone-bundle && \
#
#修改路由器ip
sed -i 's/192.168.2.1/192.168.1.1/g' ~/friendlywrt-rk3328/friendlywrt/package/base-files/files/bin/config_generate && \
#
#下载lean源
#
cd ~/friendlywrt-rk3328 && \
#
git clone https://github.com/coolsnowwolf/lede && \
#
cd ~/friendlywrt-rk3328/lede/ && \
#
git pull && \
#
./scripts/feeds update -a && \
#
./scripts/feeds install -a && \
#
#拷贝lean相关文件到r2s源内
cp -rf ~/friendlywrt-rk3328/lede/feeds.conf.default ~/friendlywrt-rk3328/friendlywrt/feeds.conf.default && \
#
cp -rf ~/friendlywrt-rk3328/lede/package/lean ~/friendlywrt-rk3328/friendlywrt/package/ && \
#
cp -rf ~/friendlywrt-rk3328/lede/tools/ucl ~/friendlywrt-rk3328/friendlywrt/tools/ && \
#
cp -rf ~/friendlywrt-rk3328/lede/tools/upx ~/friendlywrt-rk3328/friendlywrt/tools/ && \
#
cp -rf ~/friendlywrt-rk3328/lede/tools/gptfdisk ~/friendlywrt-rk3328/friendlywrt/tools/ && \
#
cp -rf ~/friendlywrt-rk3328/lede/tools/popt ~/friendlywrt-rk3328/friendlywrt/tools/ && \
#
cp -rf ~/friendlywrt-rk3328/lede/tools/Makefile ~/friendlywrt-rk3328/friendlywrt/tools/Makefile && \
#
cp -rf ~/friendlywrt-rk3328/lede/package/libs/librpc ~/friendlywrt-rk3328/friendlywrt/package/libs/ && \
#
cp -rf ~/friendlywrt-rk3328/lede/package/libs/libcxx ~/friendlywrt-rk3328/friendlywrt/package/libs/ && \
#
#修改lean源文件
sed -i 's/#src-git helloworld/src-git helloworld/g' ~/friendlywrt-rk3328/friendlywrt/feeds.conf.default && \
#
#更新融合后的源码
cd ~/friendlywrt-rk3328/friendlywrt/ && \
#
./scripts/feeds update -a && \
#
./scripts/feeds install -a && \
#
#编译固件
cd ~/friendlywrt-rk3328/friendlywrt && \
#
make -j1 download v=s && \
#
cd ~/friendlywrt-rk3328 && \
#
./build.sh nanopi_r2s.mk && \
#
cp -rf ~/friendlywrt-rk3328/scripts/sd-fuse/out/FriendlyWrt_*_NanoPi-R2S_arm64_sd.img ~/ && \
#
#备份配置文件
cp -rf ~/friendlywrt-rk3328/friendlywrt/.config ~/friendlywrt-rk3328/configs/r2s.config && \
#
cp -rf ~/friendlywrt-rk3328/friendlywrt/.config ~/r2s.config && \
#
#删除编译数据
cd ~/friendlywrt-rk3328/ && \
#
./build.sh cleanall && \
#
rm -rf ~/friendlywrt-rk3328/friendlywrt/tmp/ && \
#
exit 0
