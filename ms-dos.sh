#!/bin/bash
PROJECT_PATH=$1
EMULATED_PATH=$2
FILENAME=$3
shift
shift
shift
ARGUMENTS=$@

cd $PROJECT_PATH
[[ -d "ms-dos" ]] || mkdir "ms-dos"
mount -o loop,offset=32256,uid=$UID ms-dos.img ./ms-dos
cp ./ms-dos/AUTOEXEC.BAT ./ms-dos/AUTOEXEC.BAT.BKP

printf "D:\r\n" >> ./ms-dos/AUTOEXEC.BAT
printf "@ECHO ON\r\n" >> ./ms-dos/AUTOEXEC.BAT
printf "cd $EMULATED_PATH\r\n" >> ./ms-dos/AUTOEXEC.BAT
printf "tasm $FILENAME\r\n" >> ./ms-dos/AUTOEXEC.BAT
printf "tlink $FILENAME\r\n" >> ./ms-dos/AUTOEXEC.BAT
printf "$FILENAME $ARGUMENTS\r\n" >> ./ms-dos/AUTOEXEC.BAT

dosbox-x --noautoexec -c "imgmount 0 -fs none -t floppy empty" -c "imgmount C ms-dos.img -ide 1m" -c "mount d ./Tasm" -c "copy d:\\ c:\\dos\\" -c "mount d -u" -c "mount d ./Prog" -c "boot C:"

cp ./ms-dos/AUTOEXEC.BAT.BKP ./ms-dos/AUTOEXEC.BAT
rm ./ms-dos/AUTOEXEC.BAT.BKP
umount ./ms-dos
