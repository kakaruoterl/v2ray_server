#!/usr/bin/bash
#v2ray科学上网及反向代理服务器端
#v1.0 for docker by kakaruoter 2019.8.20
docker
if [ $? != 0 ];then
        yum -y install docker
fi
systemctl restart docker
systemctl enable docker
docker pull v2ray/official

mkdir -p /docker/v2
mkdir /docker/ofv2

read -p "请输入用来上网的端口号：" pt1 
read -p "请输入反向代理的第一个端口号：" pt2 
read -p "请输入反向代理的第二个端口号：" pt3 

uuid1=`cat /proc/sys/kernel/random/uuid`
uuid2=`cat /proc/sys/kernel/random/uuid`
uuid3=`cat /proc/sys/kernel/random/uuid`

sed -ri '8s/.*/      "port":'$pt1',/' /root/v2.txt
sed -ri '13s/.*/            "id":"'$uuid1'",/' /root/v2.txt

cp v2.txt /docker/v2/config.json

docker run --name v2 -d -v /docker/v2:/etc/v2ray -p $pt1:$pt1 v2ray/official

sed -ri '14s/.*/      "port":'$pt2',/' /root/ofv2.txt
sed -ri '19s/.*/            "id":"'$uuid2'",/' /root/ofv2.txt
sed -ri '28s/.*/      "port":'$pt3',/' /root/v2.txt
sed -ri '33s/.*/            "id":"'$uuid3'",/' /root/v2.txt
cp ofv2.txt /docker/ofv2/config.json

docker run --name ofv2 -d -v /docker/ofv2:/etc/v2ray -p $pt2:$pt2 -p $pt3:$pt3 v2ray/official
docker container restart v2
docker container restart ofv2
docker update --restart=always v2
docker update --restart=always ofv2

clear

echo ""
echo "科学上网的端口号为： $pt1"
echo "科学上网的uuid为： $uuid1"

echo ""
echo "写入内网服务器的端口号为： $pt3"
echo "写入内网服务器的uuid为：$uuid3"

echo ""
echo "外网终端上使用的端口号为： $pt2"
echo "外网终端上使用的uuid为： $uuid3"