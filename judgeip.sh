#!/bin/bash
cd /tmp 
curl ip.cn/$1 > ipcn.txt
awk -F '：' '{print $3}' ipcn.txt | awk -F ' ' '{print $1}' > ip.txt
cat ip.txt
localhost=`cat ip.txt | grep 本地主机 | wc -l`
echo $localhost
localnet=`cat ip.txt | grep 本地局域网 | wc -l`
echo $localnet
a=`cat ip.txt | grep 省 | wc -l`
echo $a
b=`cat ip.txt | grep 自治区 | wc -l`
echo $b
beijing=`cat ip.txt | grep 北京市 | wc -l`
echo $beijing
shanghai=`cat ip.txt | grep 上海市 | wc -l`
echo $shanghai
chongqing=`cat ip.txt | grep 重庆市 | wc -l`
echo $chongqing
tianjin=`cat ip.txt | grep 天津市 | wc -l`
echo $tianjin
cloudflare=`cat ipcn.txt | grep CloudFlare | wc -l`
echo $cloudflare 
if [ $cloudflare = 1 ];
then
cat ipcn.txt >> /tmp/suspiciousip.txt
echo "这个地址属于CloudFlare地址"
elif [ $localhost = 1 -o $localnet = 1 ];
then
cat ipcn.txt >> /tmp/local.txt
echo "这个地址属于本地网段地址"
elif [ $a = 1 -o $b = 1 -o $beijing = 1 -o $tianjin = 1 -o $shanghai = 1 -o $chongqing = 1 ];
then
cat ipcn.txt >> /tmp/dalu.txt
echo "这个地址属于大陆地址"
else
echo "这个地址属于外国地址"
cat ipcn.txt >> /tmp/suspiciousip.txt
fi
echo > /tmp/ipcn.txt
