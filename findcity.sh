#!/bin/bash
cd /tmp
echo "Please input your phonenumber:"
read phonenumber
curl ip.cn/db.php?num=$phonenumber > a.txt
head -39 a.txt | tail -1 > b.txt
awk -F ': ' '{print $2}' b.txt > c.txt
echo "你输入的手机号码是$phonenumber,归属地是：" 
awk -F '<' '{print $1}' c.txt > belongtocity.txt
cat belongtocity.txt

