#!/bin/bash
username="admin"       
password="123456"    
address="192.168.1.163"       
#######################backup record
cd /var/spool/asterisk/monitor/
day=`date +%m%d`
date1=`date +%Y`
date2=`date -d "1 day ago" +%m%d` 
Date2=`date -d "1 day ago" +%Y%m%d` 
if [ "$day" = "0101" ];
then
date1=`date -d last-year +%Y`
cd $date1
cd $date2
ls > /tmp/a.txt
noftpfiles=`grep "*" /tmp/a.txt | wc -l`
monitorfiles=`ls | wc -l`
ftp -n<<!                
open $address
user $username $password
binary
hash
prompt
mkdir $date1
cd $date1
mkdir $Date2
cd $Date2
mkdir $Date2
cd $Date2
mput *
mls ./ /tmp/b.txt
close
bye
!
txtlines=`awk 'END{print NR}' /tmp/b.txt`
ftpfiles=`expr $txtlines + $noftpfiles`
echo $ftpfiles
time=`date`
if [[ $ftpfiles -eq $monitorfiles ]];
then
echo $time >> /opt/singhead/ftplog.txt
echo "All files($Date2) had been transmited to the ftpserver!!!" >> /opt/singhead/ftplog.txt
echo "########" >> /opt/singhead/ftplog.txt
else
failfiles=`expr $monitorfiles - $ftpfiles`
echo $time >> /opt/singhead/ftplog.txt >> /opt/singhead/ftplog.txt
echo "There are $failfiles files($Date2) not being transmited to the ftpserver!" >> /opt/singhead/ftplog.txt
sleep 2h
echo "sleeping 2h transmit again......" >> /opt/singhead/ftplog.txt
/opt/ftpmassback.sh
echo "########" >> /opt/singhead/ftplog.txt
fi
else
cd $date1
cd $date2
ls > /tmp/a.txt
noftpfiles=`grep "*" /tmp/a.txt | wc -l`
monitorfiles=`ls | wc -l`
ftp -n<<!                
open $address
user $username $password
binary
hash
prompt
mkdir $date1
cd $date1
mkdir $Date2
cd $Date2
mkdir $Date2
cd $Date2
mput *
mls ./ /tmp/b.txt
close
bye
!
txtlines=`awk 'END{print NR}' /tmp/b.txt`
ftpfiles=`expr $txtlines + $noftpfiles`
echo $ftpfiles
time=`date`
if [[ $ftpfiles -eq $monitorfiles ]];
then
echo $time >> /opt/singhead/ftplog.txt
echo "All files($Date2) had been transmited to the ftpserver!!!" >> /opt/singhead/ftplog.txt
echo "########" >> /opt/singhead/ftplog.txt
else
failfiles=`expr $monitorfiles - $ftpfiles`
echo $time >> /opt/singhead/ftplog.txt >> /opt/singhead/ftplog.txt
echo "There are $failfiles files($Date2) not being transmited to the ftpserver!" >> /opt/singhead/ftplog.txt
sleep 2h
echo "sleeping 2h transmit again......" >> /opt/singhead/ftplog.txt
/opt/ftpmassback.sh
echo "########" >> /opt/singhead/ftplog.txt
fi
fi


