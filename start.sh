#/bin/bash
#date: 2020/06/18
#author: Pedro Expedito De Oliveira
#func: Record and save RTSP video

DATA=`date | sed 's/ /:/g'`
EXECTIME=11
RODEI=0
HORAS=24
DIRECTORY="$HOME"
PASSWORD=$RTSPPASSOWOD #sua senha de RTSP aqui no caso sem o $ é porque estou usando variavel de ambiente
echo $DIRECTORY
while :
do

RODEI=$(($RODEI+1))

echo $RODEI

#if [ $RODEI -gt $HORAS  ]; then
#  echo "Movendo Arquivos.."

#else
  echo "Não"
#fi

#Camera 1 titiu
cvlc -vvv  rtsp://admin:$PASSWORD@192.168.1.100:554/onvif1\
  --sout="#transcode{vcodec=mp4v,vfilter=canvas{width=1280,height=720}}:std{access=file,mux=mp4,\
  dst=$DIRECTORY/record/cam1/arquivo.mp4}" &> /dev/null &

PID1="$!"

#Camera 2 mangueira

cvlc -vvv  rtsp://admin:$PASSWORD@192.168.1.102:554/onvif1\
  --sout="#transcode{vcodec=mp4v,vfilter=canvas{width=1280,height=720}}:std{access=file,mux=mp4,\
  dst=$DIRECTORY/record/cam2/arquivo.mp4}" &>/dev/null &

PID2="$!"

#Camera 3 Camera barracão interno

cvlc -vvv  rtsp://admin:$PASSWORD@192.168.1.103:554/onvif1\
  --sout="#transcode{vcodec=mp4v,vfilter=canvas{width=1280,height=720}}:std{access=file,mux=mp4,\
  dst=$DIRECTORY/record/cam3/arquivo.mp4}" &> /dev/null &

PID3="$!"

#Camera 4
cvlc -vvv  rtsp://admin:$PASSWORD@192.168.1.104:554/onvif1\
  --sout="#transcode{vcodec=mp4v,vfilter=canvas{width=1280,height=720}}:std{access=file,mux=mp4,\
  dst=$DIRECTORY/record/cam4/arquivo.mp4}" &> /dev/null &

PID4="$!"



sleep $EXECTIME

kill $PID3 $PID4 $PID1 $PID2


mv ~/record/cam1/arquivo.mp4 ~/record/cam1/$DATA.mp4
mv ~/record/cam2/arquivo.mp4 ~/record/cam2/$DATA.mp4
mv ~/record/cam3/arquivo.mp4 ~/record/cam3/$DATA.mp4
mv ~/record/cam4/arquivo.mp4 ~/record/cam4/$DATA.mp4


done

