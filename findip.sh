#!/bin/bash
########################################
#   Ahthor:枫之谷                      #
#   Email:chenshanqiang@mixlinker.com  #
#   Version:v4.0 去除重复可疑地址      #
########################################
#将ss命令里面的IP地址解析出来后输出到文件/tmp/output.txt
cd /tmp
echo > /tmp/local.txt
echo > /tmp/dalu.txt
echo > /tmp/suspiciousip.txt
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
echo $ip
cd /data/shell/linuxshell/
./judgeip.sh $ip
fi
done
sleep 3
cat /tmp/local.txt | sort | uniq > /tmp/Local.txt
cat /tmp/dalu.txt | sort | uniq > /tmp/Dalu.txt
cat /tmp/suspiciousip.txt | sort | uniq > /tmp/Suspiciousip.txt
cat /tmp/Local.txt
cat /tmp/Dalu.txt
cat /tmp/Suspiciousip.txt
