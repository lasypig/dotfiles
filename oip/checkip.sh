#!/bin/sh

workdir=/home/wangxb/misc/myApp/dotfiles/oip
cd $workdir
oldip=`cat ip.txt`
newip=`/home/wangxb/.lasypig/oip | head -n 1`

if [ "$newip" != "$oldip" ]; then
	echo $newip > ip.txt
	cd ..
	git add oip/ip.txt
	git commit . -m "ip changed to $newip"
	git push origin master
fi

