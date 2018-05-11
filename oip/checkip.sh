#!/bin/sh

workdir=/home/wangxb/misc/myApp/dotfiles/oip
cd $workdir
oldip=`cat ip.txt`
newip=`/home/wangxb/.lasypig/oip | head -n 1`

if [ "$newip" != "$oldip" ]; then
	echo $oldip > ip.txt
fi
