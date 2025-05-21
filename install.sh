#!/bin/bash
FREEDOS="fdbasews.iso" #$(ls FD*LGCY.iso | head -n 1)
dosbox-x -noautoexec -c "IMGMAKE hdd.img -t hd -size 2048" -c "IMGMOUNT C hdd.img" -c "IMGMOUNT D $FREEDOS" -c "IMGMOUNT A -bootcd D" -c "BOOT A:"

