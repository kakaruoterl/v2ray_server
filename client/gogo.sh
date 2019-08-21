#!/bin/sh
#基于linux的客户端服务器或者docker可用
#by kakaruoter
read -p "请输入您的vps服务器IP地址：" ip
read -p "请输入与vps服务器端对应的端口号：" pt
read -p "请输入与该端口对应的uuid：" uuid

sed -ri '19s/.*/            "address":"'$ip'",/' cli_config.json
sed -ri '20s/.*/            "port":'$pt',/' cli_config.json
sed -ri '23s/.*/                "id":"'$uuid'",/' cli_config.json

cat cli_config.json > /etc/v2ray/config.json

clear 

echo "配置已完成，去你的终端上试试吧"
