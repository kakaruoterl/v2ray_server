#!/usr/bin/bash
#v2ray反向代理脚本服务器端
#v1.0 by kakaruoter 2019.8.20

read -p "请输入服务器防火墙中已添加的端口号：" pt

wget https://install.direct/go.sh

chmod +x go.sh

./go.sh
#此乃v2ray官方脚本

uuid1=`/usr/bin/v2ray/v2ctl uuid`

sed -ri '/"port":/c\      "port":'$pt',' /root/sys_config.txt

sed -ri '/"id":/c\          "id":'$uuid1',' /root/sys_config.txt

cat sys_config.txt >/etc/v2ray/config.json

clear

echo ""
echo "请确定端口已添加到防火墙：$pt"
echo ""
echo "您的uuid是：$uuid1"
echo ""
echo "服务端配置已完成，请完善内网服务器配置！"

