# spy的使用

spy工具用来查看core的一些运行时信息，比如通道状态、内存使用情况等。

我们可以使用以下方法来获取其基本用法和功能：

```shell
	[root@HISOME-DX000 buffer]$spy 
	Enter help to get help
	spy> help
	ls info set loglevel expose
	spy> help ls
	ls [ch:N] - list all or Nth channel info
	spy> help info
	info streams 	 - list all streams
	info consumer 	 - list all consumers
	info time 	 - show stream online/offline time
	info mqtt 	 - show MQTT request statics
	info sequence 	 - list sequence status
	info subcpu 	 - list subcpu address
	info shmem [N] 	 - print shared memory of ch-N
	info socket 	 - show stream socket details
	info recycle 	 - list stream struct recycle
	info modsip [N]	 - show all or ch:N stream
	info sipcfg 	 - show sip configurations
	info link 	 - show master/slave link status
	info gbchan 	 - show gb stream channel info
	info rec 	 - show picure delivery
	info disk 	 - show disk status
	info plan 	 - show exam plan time
	info bufpool 	 - show usage of buffer pool
	info dropbytes 	 - show detail of dropped bytes
```
