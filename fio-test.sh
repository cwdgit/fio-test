#!/bin/sh
FILENAME=/root/test
#RW=$(cat ioengine.list.txt)
PIOENGINE=psync
LIOENGINE=libaio
BS=16k
SIZE=2G
NUMJOBS=30
RUNTIME=1000
NAME=$PIOENGINE.$(date +%Y%m%d)
NAME1=$LIOENGINE.$(date +%Y%m%d)
#同步测试
echo "###########$(date)###########同步i/o########################################" >iotest.result.$NAME.txt
for i in $(cat ./ioengine.list.txt);do 
         printf $i"\n"
echo ------$i.$NAME--begin--$(date)----- >>iotest.result.$NAME.txt;
fio -filename=$FILENAME -direct=1 -iodepth=1  -rw=$i -ioengine=$PIOENGINE -bs=$BS -size=$SIZE -numjobs=$NUMJOBS -runtime=$RUNTIME -group_reporting -name=$i.$NAME >> iotest.result.$NAME.txt;
echo ------$i.$NAME--end---$(date)----- >>iotest.result.$NAME.txt;
echo "" >>iotest.result.$NAME.txt;
echo "" >>iotest.result.$NAME.txt;
done
#异步测试
echo "###########$(date)###########异步i/o########################################" >iotest.result.$NAME1.txt
for i in $(cat ./ioengine.list.txt);do 
echo ------$i.$NAME--begin--$(date)----- >>iotest.result.$NAME1.txt;
fio -filename=$FILENAME -direct=1 -iodepth=1 -rw=$i -ioengine=$LIOENGINE -bs=$BS -size=$SIZE -numjobs=$NUMJOBS -runtime=$RUNTIME -group_reporting -name=$i.$NAME >>iotest.result.$NAME1.txt;
echo ------$i.$NAME--end---$(date)----- >>iotest.result.$NAME1.txt;
echo "" >>iotest.result.$NAME1.txt;
echo "" >>iotest.result.$NAME1.txt;
done

