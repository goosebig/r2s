注意事项

不要用 root 用户 git 和编译

国内用户编译前最好准备好梯子

默认登陆IP 192.168.1.1, 密码 空

一.准备工作

1.系统ubuntu18.4 x64系统

2.下载NanoPi-R2S编译包

NanoPi-R2S官方固件参考网址：http://wiki.friendlyarm.com/wiki/index.php/NanoPi_R2S/zh

网页目录4.3.1有包下载地址，文件位于网盘的以下路径：sources/friendlywrt-rk3328-20200415.tar

将包上传至ubuntu系统，用户根目录下

脚本现在用的是friendlywrt-rk3328-20200415.tar包，如有新包，脚本没有及时更新，请按照以下命令更改新包名。

xxx是新包名

命令：cd ~/ && mv friendlywrt-rk3328-20200415.tar xxx

网盘连接：http://download.friendlyarm.com/nanopir2s

3.需要调用LEAN大神的资源(这里膜拜下)

项目地址：https://github.com/coolsnowwolf/lede

4.建议使用screen命令，以防万一。

建立运行窗口命令：screen -S r2s

查看已有窗口命令：screen -ls

返回窗口命令：screen -d -r r2s

退出命令：exit

5.下载代码

git clone https://github.com/tl768/r2s.git

6.固件IP

脚本将原固件192.168.2.1更改成192.168.1.1，如想更改成其他ip，请按照以下命令操作。

假如您想更改成192.168.3.1

命令：cd r2s && sed -i 's/192.168.1.1/192.168.3.1/g' 1.首次编译.sh

二.首次编译

1.进入脚本目录

命令：cd r2s

2.授权并运行脚本

命令：chmod +x 1.首次编译.sh && ./1.首次编译.sh

3.编译过程

(1)会要求输入root密码

(2)会要求配置固件

基本选项设置(选项框需要空格选成*才生效)

Target System选择ockchip rk3328 (aarch64)

Target Images选择squashfs

Base system取消dnsmasq选择 dnsmasq-full

Base system选择dnsmasq-full

LuCI>hemes选择luci-theme-bootstrap

LuCI>Applications选择自己想要的
     
Network>File Transfer选择wget
     
Network>IP Addresses and Names选择 ddns-scripts
     
Network>IP Addresses and Names选择 ddns-scripts_aliyun
                            
Network>IP Addresses and Names选择 dns-scripts_no-ip_com
                            
(3)固件和配置文件会自动拷贝到用户根目录下，请妥善保存

固件名：FriendlyWrt_xxx_NanoPi-R2S_arm64_sd.img

配置文件名：r2s.config

三.再次编译

1.固件配置

如安装首次编译配置请跳过

如想更改配置请删除配置文件，命令如下。

命令：rm -rf ~/friendlywrt-rk3328/configs/r2s.config

编译过程中会要求配置固件

2.更改固件ip

查看ip命令：sed -n '103p' ~/friendlywrt-rk3328/friendlywrt/package/base-files/files/bin/config_generate

假如ip是192.168.1.1
将x.x.x.x替换你想要的ip
修改ip命令：sed -i 's/192.168.1.1/x.x.x.x/g' ~/friendlywrt-rk3328/friendlywrt/package/base-files/files/bin/config_generate

3.授权并运行脚本

进入脚本目录

命令：cd r2s

命令：chmod +x 2.再次编译.sh && ./2.再次编译.sh

4.编译过程

(1)会要求输入root密码
(2)如果删除了固件配置文件，会要求配置固件，请参考首次编译配置固件。

5.固件和配置文件会自动拷贝到用户根目录下，请妥善保存

固件名：FriendlyWrt_xxx_NanoPi-R2S_arm64_sd.img

配置文件名：r2s.config
