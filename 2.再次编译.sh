#!/bin/bash

#删除固件配置
rm -rf ~/friendlywrt-rk3328/friendlywrt/.config

#更新r2s源码
cd ~/friendlywrt-rk3328/

repo sync --no-clone-bundle

#更新lean源
cd ~/friendlywrt-rk3328/lede/

git pull

./scripts/feeds update -a

./scripts/feeds install -a

#拷贝lean相关文件到r2s源内
cp ~/friendlywrt-rk3328/lede/feeds.conf.default ~/friendlywrt-rk3328/friendlywrt/feeds.conf.default

cp -rf ~/friendlywrt-rk3328/lede/package/lean ~/friendlywrt-rk3328/friendlywrt/package/

cp -rf ~/friendlywrt-rk3328/lede/tools/ucl ~/friendlywrt-rk3328/friendlywrt/tools/

cp -rf ~/friendlywrt-rk3328/lede/tools/upx ~/friendlywrt-rk3328/friendlywrt/tools/

cp -rf ~/friendlywrt-rk3328/lede/tools/gptfdisk ~/friendlywrt-rk3328/friendlywrt/tools/

cp -rf ~/friendlywrt-rk3328/lede/tools/popt ~/friendlywrt-rk3328/friendlywrt/tools/

cp -rf ~/friendlywrt-rk3328/lede/tools/Makefile ~/friendlywrt-rk3328/friendlywrt/tools/Makefile

cp -rf ~/friendlywrt-rk3328/lede/package/libs/librpc ~/friendlywrt-rk3328/friendlywrt/package/libs/

cp -rf ~/friendlywrt-rk3328/lede/package/libs/libcxx ~/friendlywrt-rk3328/friendlywrt/package/libs/

#修改lean源文件
sed -i 's/#src-git helloworld/src-git helloworld/g' ~/friendlywrt-rk3328/friendlywrt/feeds.conf.default

#更新融合后的源码
cd ~/friendlywrt-rk3328/friendlywrt

./scripts/feeds update -a

./scripts/feeds install -a

#导入配置文件(有配置文件时取消#)
cat ~/friendlywrt-rk3328/configs/r2s.config > ~/friendlywrt-rk3328/friendlywrt/.config

#编译固件
cd ~/friendlywrt-rk3328/friendlywrt

make -j1 download v=s

cd ~/friendlywrt-rk3328

./build.sh nanopi_r2s.mk

cp ~/friendlywrt-rk3328/scripts/sd-fuse/out/FriendlyWrt_*_NanoPi-R2S_arm64_sd.img ~/

#备份配置文件
cp -rf ~/friendlywrt-rk3328/friendlywrt/.config ~/friendlywrt-rk3328/configs/r2s.config

cp -rf ~/friendlywrt-rk3328/friendlywrt/.config ~/r2s.config

#删除编译数据

cd ~/friendlywrt-rk3328

./build.sh cleanall

rm -rf ~/friendlywrt-rk3328/friendlywrt/tmp/

exit 0
