#!/bin/bash
#
#部署环境
cd && \
#
sudo apt-get update && \
#
sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3.5 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf && \
#
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
echo 部署环境完毕
#
exit 0
