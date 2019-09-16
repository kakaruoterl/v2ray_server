#!/usr/bin/bash
#v2ray科学上网及反向代理服务器端
#v1.1 for docker by kakaruoter 2019.9.16
docker_install() {
    docker &>/dev/null
    if [ $? != 0 ];then
        cd /etc/yum.repos.d/
        wget https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
        cd
        yum -y install docker-ce
    fi
    systemctl restart docker
    systemctl enable docker
    docker pull v2ray/official
}

v2_only() {
    mkdir -p /docker/v2
    read -p "请输入用来上网的端口号：" pt1
    uuid1=`cat /proc/sys/kernel/random/uuid`

    sed -ri '8s/.*/      "port":'$pt1',/' /root/v2.txt
    sed -ri '13s/.*/            "id":"'$uuid1'",/' /root/v2.txt

    cp v2.txt /docker/v2/config.json

    docker run --name v2 -d -v /docker/v2:/etc/v2ray -p $pt1:$pt1 v2ray/official

    docker container restart v2
    docker update --restart=always v2
}

ofv2_only() { 
    mkdir -p /docker/ofv2
    read -p "请输入反向代理的第一个端口号：" pt2 
    read -p "请输入反向代理的第二个端口号：" pt3 


    uuid2=`cat /proc/sys/kernel/random/uuid`
    uuid3=`cat /proc/sys/kernel/random/uuid`

    sed -ri '14s/.*/      "port":'$pt2',/' /root/ofv2.txt
    sed -ri '19s/.*/            "id":"'$uuid2'",/' /root/ofv2.txt
    sed -ri '28s/.*/      "port":'$pt3',/' /root/ofv2.txt
    sed -ri '33s/.*/            "id":"'$uuid3'",/' /root/ofv2.txt
    cp ofv2.txt /docker/ofv2/config.json

    docker run --name ofv2 -d -v /docker/ofv2:/etc/v2ray -p $pt2:$pt2 -p $pt3:$pt3 v2ray/official

    docker container restart ofv2
    docker update --restart=always ofv2
}

v2print() {
    echo ""
    echo "科学上网的端口号为： $pt1"
    echo "科学上网的uuid为： $uuid1"
}

ofv2print() {
    echo ""
    echo "写入内网服务器的端口号为： $pt3"
    echo "写入内网服务器的uuid为：$uuid3"

    echo ""
    echo "外网终端上使用的端口号为： $pt2"
    echo "外网终端上使用的uuid为： $uuid2"
}

clear
cat <<-EOF
            #############################
            #    以下安装均基于v2ray      #
            # 1、仅安装科学上网           #
            # 2、仅安装内网穿透           #
            # 3、同时安装科学上网和内网穿透 #
            # 4、退出                   #
            ############################
EOF

read -p "请输入您的选择：" choice
case "$choice" in
1)
    docker_install
    v2_only
    clear
    v2print
    ;;
2)
    docker_install
    ofv2_only
    clear
    ofv2print
    ;;
3)
    docker_install
    v2_only
    ofv2_only
    clear
    v2print
    ofv2print
    ;;
4)
    exit
    ;;
*)
    echo "error"
    exit
esac