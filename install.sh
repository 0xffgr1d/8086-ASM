#!/bin/bash
dosbox-x -noautoexec -c 'IMGMAKE ms-dos.img -t hd -size 2048' -c 'IMGMOUNT C ms-dos.img' -c 'BOOT "Disk 1.img" "Disk 2.img" "Disk 3.img"'
