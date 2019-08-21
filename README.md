# v2ray_server
v2ray反向代理脚本，该脚本中的v2ray脚本及config.json文件均来自v2ray官网

该脚本为v2ray反向代理脚本，穿透内网利器，非科学上网脚本

使用方法：
vps服务端（vps服务端脚本中已包含v2ray官方下载脚本，不需要单独下载v2ray）：
wget https://raw.githubusercontent.com/kakaruoterl/v2ray_server/master/server.tar && tar xvf server.tar && chmod +x gogogo.sh && bash gogogo.sh

内网中的服务器（本脚本中不包含v2ray安装脚本，需要先将v2ray安装到服务器后再运行下面的脚本。如果在安装好v2ray的docker中运行则可直接运行此脚本）：
wget https://raw.githubusercontent.com/kakaruoterl/v2ray_server/master/client/client.tar && tar xvf client.tar && chmod +x gogo.sh && bash gogo.sh
