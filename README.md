# v2ray_server
v2ray反向代理脚本，该脚本中的v2ray脚本及config.json文件均来自v2ray官网

该脚本为v2ray反向代理脚本，作用为穿透内网，非科学上网脚本

使用方法：

1、vps服务端（vps服务端脚本中已包含v2ray官方下载脚本，不需要单独下载v2ray）：

wget https://raw.githubusercontent.com/kakaruoterl/v2ray_server/master/server.tar && tar xvf server.tar && chmod +x gogogo.sh && bash gogogo.sh

2、内网中的服务器（本脚本中不包含v2ray安装脚本，需要先将v2ray安装到服务器后再运行下面的脚本。如果在安装好v2ray的docker中运行则可直接运行此脚本）：

wget https://raw.githubusercontent.com/kakaruoterl/v2ray_server/master/client/client.tar && tar xvf client.tar && chmod +x gogo.sh && sh gogo.sh

3、docker服务器端

在服务器端用docker同时安装科学上网及反向代理(9.16更新，可选择安装)：

wget https://raw.githubusercontent.com/kakaruoterl/v2ray_server/master/docker/docker.tar && tar xvf docker.tar && chmod +x gogogo.sh && bash gogogo.sh
