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

cp ./Tasm/* ./ms-dos/DOS
cp ./ms-dos/AUTOEXEC.BAT ./AUTOEXEC.BAT.BKP

sed -i '/@ECHO OFF/d' ./ms-dos/AUTOEXEC.BAT
printf "D:\r\n" >> ./ms-dos/AUTOEXEC.BAT
EMULATED_PATH="${EMULATED_PATH//\//\\}"
printf "cd $EMULATED_PATH\r\n" >> ./ms-dos/AUTOEXEC.BAT
printf "tasm $FILENAME\r\n" >> ./ms-dos/AUTOEXEC.BAT
printf "tlink $FILENAME\r\n" >> ./ms-dos/AUTOEXEC.BAT
printf "$FILENAME $ARGUMENTS\r\n" >> ./ms-dos/AUTOEXEC.BAT


unix2dos ./ms-dos/AUTOEXEC.BAT
umount ./ms-dos
dosbox-x --noautoexec -c "imgmount 0 -fs none -t floppy empty" -c "imgmount C ms-dos.img -ide 1m" -c "mount d ./Prog" -c "boot C:"
mount -o loop,offset=32256,uid=$UID ms-dos.img ./ms-dos

cp ./AUTOEXEC.BAT.BKP ./ms-dos/AUTOEXEC.BAT
rm ./AUTOEXEC.BAT.BKP
umount ./ms-dos
