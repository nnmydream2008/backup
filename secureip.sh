#!/bin/bash
cd /data/shell/tmp
echo  > suspicious_secureip.log
cat /var/log/secure | grep Accepted | awk -F ' ' '{print $11}' > secureip.txt
cat /var/log/secure | grep Accepted | awk -F ' ' '{print $1,$2,$3}' > securetime.txt
secureiplines=`awk 'END{print NR}' secureip.txt`
for((i=1;i<=$secureiplines;i++))
do
secureip=`head -$i secureip.txt | tail -1`
curl ip.cn/$secureip > ipcn.txt
awk -F '：' '{print $3}' ipcn.txt | awk -F ' ' '{print $1}' > ip.txt
cat ip.txt
localhost=`cat ip.txt | grep 本地主机 | wc -l`
echo $localhost
localnet=`cat ip.txt | grep 本地局域网 | wc -l`
echo $localnet
if [ $localnet = 1 ];
then
a=1
else
time=`head -$i securetime.txt | tail -1`
echo "可疑地址：$secureip,在：$time，通过ssh登录过服务器" >> suspicious_secureip.log
fi
done
cat suspicious_secureip.log
