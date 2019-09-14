#!/usr/bin/bash
#v2ray反向代理脚本服务器端
#v1.0 by kakaruoter 2019.8.20

read -p "请输入服务器防火墙中已添加的一个端口号：" pt1
read -p "请输入第二个已添加的端口号：" pt2

if [ ! -f /etc/v2ray/config.json ];then
    wget https://install.direct/go.sh
    chmod +x go.sh
    ./go.sh
#此乃v2ray官方脚本
fi

uuid1=`/usr/bin/v2ray/v2ctl uuid`
uuid2=`/usr/bin/v2ray/v2ctl uuid`

sed -ri '14s/.*/      "port":'$pt1',/' /root/sys_config.txt

sed -ri '19s/.*/            "id":"'$uuid1'",/' /root/sys_config.txt

sed -ri '28s/.*/      "port":'$pt2',/' /root/sys_config.txt

sed -ri '33s/.*/            "id":"'$uuid2'",/' /root/sys_config.txt

cat sys_config.txt >/etc/v2ray/config.json

clear

echo ""
echo "请为内网服务器json文件配置此端口：$pt2"
echo ""
echo "请为内网服务器json文件配置此uuid：$uuid2"
echo ""
echo "外网终端请配置此端口：$pt1"
echo ""
echo "外网终端请配置此uuid：$uuid1" 
echo "服务端配置已完成，请确保所有端口已添加到防火墙"

systemctl restart v2ray &>/dev/null

systemctl enable v2ray &>/dev/null

service v2ray restart &>/dev/null

service v2ray enalbe &>/dev/null
