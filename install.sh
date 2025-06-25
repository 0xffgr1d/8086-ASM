#!/bin/bash

case $(id -u) in
	0 )	;;
	* )	echo "this script needs root privileges, please run this script with sudo"; exit ;;
esac

dosbox-x -noautoexec -c 'IMGMAKE ms-dos.img -t hd -size 2048' -c 'IMGMOUNT C ms-dos.img' -c 'BOOT "Disk 1.img" "Disk 2.img" "Disk 3.img"'

mount -o loop,offset=32256,uid=$UID ms-dos.img ./ms-dos
sed -i '1s/^/SHELL=C:\\DOS\\COMMAND.COM C:\\DOS \/P \/E:512\r\n/' ./ms-dos/CONFIG.SYS
unix2dos ./ms-dos/CONFIG.SYS
umount ./ms-dos
