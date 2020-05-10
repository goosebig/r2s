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

脚本将原192.168.2.1更改成192.168.1.1，如想更改成其他ip，请按照以下命令操作。

假如您想更改成192.168.3.1

命令：cd r2s && sed -i 's/192.168.2.1/192.168.3.1/g' 1.首次编译.sh

二.首次编译

1.进入脚本目录

命令：cd r2s

2.授权并运行脚本

命令：chmod +x 1.首次编译.sh && ./1.首次编译.sh

3.编译过程

(1)会要求输入root密码

(2)会要求配置固件

基本选项设置(选项框需要空格选成*才生效)
Target System               选择 ockchip rk3328 (aarch64)
Target Images               选择 squashfs
Base system                 取消 dnsmasq
                            选择 dnsmasq-full
LuCI
     Themes                 选择 luci-theme-bootstrap
     Applications           选择 自己想要的
Network
     File Transfer          选择 wget
     IP Addresses and Names 选择 ddns-scripts
                            选择 ddns-scripts_aliyun
                            选择 dns-scripts_no-ip_com
                            
(3)固件和配置文件会自动拷贝到用户根目录下，请妥善保存

固件名：FriendlyWrt_xxx_NanoPi-R2S_arm64_sd.img
配置文件名：r2s.config
