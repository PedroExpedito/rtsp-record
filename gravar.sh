#/bin/bash

EXECTIME=10
while :
do
#Camera 1

cvlc -vvv  rtsp://admin:6d61723f@192.168.1.102:554/onvif1\
  --sout="#transcode{vcodec=mp4v,vfilter=canvas{width=1280,height=720}}:std{access=file,mux=mp4,\
  dst=/home/casa/record/cam1/arquivo.mp4}" 2> /dev/null &

PID1="$!"

sleep $EXECTIME

kill $PID1

DATA=`date | sed 's/ /:/g'`

mv /home/casa/record/cam1/arquivo.mp4 /home/casa/record/cam1/$DATA.mp4

done

