#!/bin/bash
########################################
#   Ahthor:枫之谷                      #
#   Email:chenshanqiang@mixlinker.com  #
#   Version:v4.0 去除重复可疑地址      #
########################################
#将ss命令里面的IP地址解析出来后输出到文件/tmp/output.txt
echo > /tmp/output.txt
echo > /tmp/suspicious.txt
ss -a | awk '{print $5}' > ss.txt
sed -i "1d" /tmp/ss.txt
cat ss.txt | awk -F ':' '{print $1}' > ipa.txt
cat ipa.txt | sed -e '/^$/d' > ipb.txt
lines=`awk 'END{print NR}' /tmp/ipb.txt`
for((i=1;i<=$lines;i++))
do 
ip=`head -$i /tmp/ipb.txt | tail -1`
if [[ $ip = "*" ]];
then
a=1
else
curl ip.cn/$ip >> /tmp/output.txt
fi
done
sleep 3
cat /tmp/output.txt
#分析output.txt里面的地址是否为可疑地址，如果是的话输出到文件/tmp/suspicious.txt
sed -i "1d" /tmp/output.txt
outputlines=`awk 'END{print NR}' /tmp/output.txt`
for((i=1;i<=$outputlines;i++))
do
head -$i /tmp/output.txt | tail -1 > /tmp/net.txt
net=`cat /tmp/net.txt | awk -F '：' '{print $3}'`
if [[ $net == "本地局域网 " ]];
then
b=1
elif [[ $net == "本地主机 localhost" ]];
then
b=1
else
echo "可疑地址为:"`cat /tmp/net.txt` >> /tmp/suspicious.txt
fi
done
#将重复的可疑地址去掉，并重新输出到文件/tmp/suspiciousIP.txt
cat /tmp/suspicious.txt | sort | uniq > /tmp/suspiciousIP.txt
cat /tmp/suspiciousIP.txt
