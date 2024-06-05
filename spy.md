# 超脑工具spy的使用

spy工具用来查看core的一些运行时信息，比如通道状态、内存使用情况等。spy有两种用法，一种是命令行式，比如`spy ls`，展示完信息随即退出；另一种是交互式，不加任何参数即进入交互模式，可以根据输入的部分字符通过TAB键自动补全。进入交互模式后，显示如下：
```shell
root@HISOME-DX000 buffer]$spy 
Enter help to get help
```

它会提醒我们输入`help`来获取帮助，那么我们输入`help`，输出如下：

```shell
spy> help
ls info set loglevel expose
```

由上可以看到当输入`help`时，有`ls info set loglevel expose`这几个一级命令。此时我们可以输入`help 一级命令`来显示其帮助信息。下面我们逐个详细说明：

## 1. ls
首先我们help一下这个命令：
```shell
[root@HISOME-DX000 buffer]$spy
Enter help to get help
spy> help ls
ls [ch:N] - list all or Nth channel info
````
由上可以看到`ls`可以用来展示所有通道的基本信息以及单个通道的详细信息。当仅输入`ls`时，spy会展示所有通道的基本信息，比如：
```shell
spy> ls
----------------------------------------------------------
screen-00: enable(1) chip(1) wins(4)
  CH-000: Real(UDP-1-M), rtsp://baihaiyan:a123456789@192.168.160.135:554/St,  on
  CH-001: Real(UDP-1-M), rtsp://baihaiyan:a123456789@192.168.160.136:554/St,  on
  CH-002: Real(UDP-1-M), rtsp://admin:hisome123456@192.168.175.181:554/cam/,  on
```
其中`screen-XX`表示屏号，00表示第一屏，以此类推；`enable`表示该屏的使能状态，1表示使能，0表示禁用；`chip`表示该屏所在子cpu的在线状态，子cpu会定时给主cpu发送心跳包，如果心跳包正常，那么这里值为1，否则为0；`wins`为该屏目前的窗口个数。

再往下每行展示一个通道的基本信息，其中`CH-XXX`为通道号，000为该屏的第一通道，以此类推；`Real`字段表示通道类型，可能的值有Real（实时流）、File（历史流）、Seq（序列）；接下来的括号中有三个值，第一个为拉流所使用的协议（UDP/RTP/PORT/PASV），第二个为该通道的使能状态，1表示使能，0表示禁用，第三个表示该通道流的类型，M表示主码流，S表示子码流；接下来为该通道的Url，由于spy工具的行长度限制，这里的Url可能未展示完整；最后一个字段表示该通道的拉流状态，on表示拉流成功，off表示拉流失败。

如果输入`ls`时，后面跟了参数（通道号），那么spy会展示该通道的详细信息及状态，比如：
```shell
spy> ls 0
CH-0: rtsp://baihaiyan:a123456789@192.168.160.135:554/Streaming/Channels/101, Running(0), Active(1), UID(1), S(3)
 V-RTP: 39(192.168.160.135:8276->192.168.160.90:43478)
V-RTCP: 40(192.168.160.135:8277->192.168.160.90:43479)
 A-RTP: 41(192.168.160.135:8286->192.168.160.90:43480)
A-RTCP: 42(192.168.160.135:8287->192.168.160.90:43481)
VBuf(0x7f00000c10): pos(128) len(0) size(65536)
ABuf(0x7f00010c20): pos(128) len(0) size(4096)
baihaiyan:a123456789
bps: 1667kb, dropped: 0
lost packets: 1494
alarm_trigger: 0, dur: 0, mode: 0
```
第一行是通道基本信息及状态：`CH-X`为通道号；接下来是通道Url，同样的这里可能未展示完全；`Running`表示目前通道状态，可能出现的值有Running/Reseting/Stopping/Stopped/Starting；`Active`表示通道使能状态；`UID`表示该通道流的stream id，因为如果多个通道拉了同一路流，那么实际上core也只拉了一路，然后发给不同的通道，这里的stream id在后面`info streams`命令中会再次碰到；`S`表示给avManager发流的socket的状态，0表示未建立连接，2表示正在连接，3表示建立连接成功。

接下来一或数行为拉流所用的socket信息，如果是rtsp通道且用的rtp over udp的话会有个socket，其他情况仅有一个socket，信息会有源地址、源端口、目的地址、目的端口信息。

`VBuf`和`ABuf`展示了rtsp拉流时所用接收缓冲区的信息，当然仅仅rtsp通道才会展示这个。

接下来一行为rtsp通道当前的用户名和密码。

`bps`表示当前通道收流的码率，其值2秒更新一次。`dropped`表示当前通道core收到数据后由于一些意外主动丢弃的数据字节数。

`lost packets`仅rtsp通道才会展示，展示了通过解析rtp索引不连续性判断出来的rtp网络丢包个数。

`alarm_trigger`这一行为调试矩阵报警功能而添加的，意义不过多解释。

最后如果该通道是序列的话，还会展示该通道序列的所有流的Url信息。

## 2. info
首先我们还是`help`一下这个命令。
```shell
root@HISOME-DX000 buffer]$spy
Enter help to get help
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
可以看出这个命令的内容比较丰满。下面我们逐条详细解释。

### 2.1 info streams
该命令用来展示当前core所拉流的状态信息，比如：
```shell
spy> info streams 
file:/mnt/ext/74F98D0A7F9FC947/test1.mp4(ST:0,ID:37,PGT:0,IDX:0,RC:0), Running(0), NOT
      |-channel-296, screen-8, s:3
file:/mnt/ext/74F98D0A7F9FC947/test2.mp4(ST:0,ID:25,PGT:0,IDX:0,RC:0), Running(0), NOT
      |-channel-220, screen-6, s:3
      |-channel-221, screen-6, s:3
```
首行为流状态信息，开头为流的Url；接下来是一个括号，其中`ST`为stream type首字母，即流类型，0表示主码流，1表示子码流；`ID`为stream id，即`ls`小节中的`UID`，可以相互对应。`PGT`作调试用，不解释；`IDX`为当前流处于第几个收数据线程；`RC`为Reply code首字母，表示拉流时对方的返回代码，比如sip拉流；接下来是拉流状态，可以是Running/Closing/Closed/Reseting/Starting；后面括号里的数表示了拉流异常时的异常原因，0表示无异常，其他值这里不做解释。

往下有一或数行以`|——`开头的行，表示了这个流目前发往了那些窗口（通道），`channel-xxx`表示通道号，`screen-x`表示屏号，`s`表示给avManager发流所用socket的状态，和`ls`小节所述一致。

### 2.2 info consumer
该命令用来展示所拉流都转发到了哪里（对于矩阵和超脑来说是avManager）。比如：
```shell
spy> info consumer 
Screen-00:
    channel-000, TCP, 268(127.0.0.1:42890->127.0.0.1:40000), s:3
    channel-001, TCP, 267(127.0.0.1:43410->127.0.0.1:40001), s:3
    channel-002, TCP, 266(127.0.0.1:39074->127.0.0.1:40002), s:3
    channel-003, TCP, 265(127.0.0.1:58744->127.0.0.1:40003), s:3
Screen-01:
Screen-02:
    channel-072, TCP, 261(10.10.0.3:57878->10.10.0.4:40000), s:3
    channel-073, TCP, 262(10.10.0.3:59842->10.10.0.4:40001), s:3
    channel-074, TCP, 259(10.10.0.3:51264->10.10.0.4:40002), s:3
    channel-075, TCP, 260(10.10.0.3:54096->10.10.0.4:40003), s:3
```
其中`Screen-xx`为屏号，以下分别为该屏上的各个通道的流都发往了哪里。`channel-xx`表示通道号，接下来是发流协议，TCP/UDP/RTP；接下来是socket信息，括号前的数字是发流socket的fd，括号里是socket的地址和端口信息，括号后面的`s`是socket的状态。

### 2.3 info time
该命令用于展示通道拉流成功或失败后至今的时长。比如：
```shell
spy> info time 
----------------------------------------------------------
screen-00: 
CH-00: 0 days, 22:46:40 online
CH-01: 0 days, 22:46:34 online
CH-02: 0 days, 22:46:32 online
CH-03: 0 days, 22:46:32 online
----------------------------------------------------------
screen-02: 
CH-00: 0 days, 22:46:32 online
CH-01: 0 days, 22:46:32 online
```
其中`screen-xx`仍然表示屏号，下面为该屏上各个通道的时长信息，`online`表示通道在线时长，`-`表示通道离线时长。仅展示最近的一次的在线或离线时长，而非累加时长。

### 2.4 info mqtt
该命令用于展示core接收到的MQTT请求的统计信息。比如：
```shell
spy> info mqtt 
DEV/CORE/STATUS: GET(13706), POST(0), QUERY(0), DELETE(0), LOSS(0)
DEV/CORE/Disk: GET(5), POST(0), QUERY(0), DELETE(0), LOSS(0)
DEV/CORE/EventDataReq: GET(51), POST(0), QUERY(0), DELETE(0), LOSS(0)
DEV/SYSMGT/ALARMACTION: GET(0), POST(2), QUERY(0), DELETE(0), LOSS(0)
```
每行展示一个主题的统计信息，行首为MQTT主题，后面依次为不同请求类型的请求次数。

### 2.5 info sequence
该命令用于展示当前序列通道的状态信息。比如：
```shell
spy> info sequence 
CH-001(A): T-20-3, Q-718831, S-25-15, sip:ip11c07@zzjy.henjy.cnjy:9902
CH-038(A): T-20-3, Q-718831, S-3-0, hisome://admin:111111@192.168.154.2
CH-288(A): T-30-10, Q-718824, S-8-0, sip:ip11c00@zzjy.henjy.cnjy:9902
CH-360(A): T-30-10, Q-718824, S-8-0, sip:ip11c00@zzjy.henjy.cnjy:9902
```
其中`CH-xxx`为通道号，`T`表示time，后面第一个值是序列的切换间隔，以秒为单位，第二个值是自上次切换后的已过时长；`Q`表示上次切换（QieHuan）流的时间，为设备启动后的时长，而非北京时间，单位秒；`S`为序列（Seqence）索引信息，后面第一个值表示这个序列有多少个流，第二个值表示当前流是其中的第几个；最后是当前所拉流的Url。

### 2.6 info subcpu
该命令展示子cpu的ip地址及状态信息。比如：
```shell
spy> info subcpu 
CPU0: 127.0.0.1
CPU1: 10.10.0.4
CPU2: 10.10.0.5
CPU3: 10.10.0.6
CPU4: 10.10.0.7
CPU5: 10.10.0.8
CPU6: (null)
```
如果是null，说明该cpu没有发过心跳，或者很久没发了。否则会展示该cpu的ip地址，给avManager发流也依据于此。

### 2.7 info shmem
该命令用于展示由core维护的共享内存信息。比如：
```shell
spy> info shmem 
[SCREEN: 0, WIN: 0]
     url: rtsp://baihaiyan:a123456789@192.168.160.135:554/Streaming/Channels/101
     osd: 
    name: 
  status: 1
   speed: 109984
    type: 0
  stream: 0
sz_total: 0
sz_rcved: 0
```
如果不加参数，默认展示通道0的共享内存信息，后面加数字的话展示对应通道的共享内存信息。由于该命令多用于使用这块共享内存的其他程序的调试，所以意义不过多解释，其实也不难猜哈。

### 2.8 info socket
该命令已经背弃了其名字的含义，目前仅仅用于内部调试，不作解释。

### 2.9 info recycle
该命令仅仅用于内部调试，不作解释。

### 2.10 info modsip
该命令用于展示modsip的注册状态以及通过sip协议拉的流的一些信息，信息由modsip模块提供。比如：
```shell
spy> info modsip 
gb35114_en: 0
Registration status: 1
Total streams: 2
libxemod_sip:compiled time:Nov  7 2023 10:06:16
01 : Main  192.168.157.11:16197<RTP/TCP>192.168.157.40:25795 keep time:27h43min33s --channel 508
02 : Main  192.168.157.11:16929<RTP/TCP>192.168.157.40:26183 keep time:03h51min16s --channel 511
```
其中`gb35114_en`表示35114是否使能；`Registration status`表示modsip模块的注册状态；`Total streams`表示通过sip协议拉到的流的总个数；下一行为modsip模块的版本信息；接下里就是流信息了，不过多解释。

### 2.11 info sipcfg
该命令用于展示sip配置的一些信息。比如：
```shell
spy> info sipcfg 
protocol: TCP_PORT
sip mode: Educational
local ip: 192.168.150.128
distributed: Yes
gb_verify: No
local port: 5060
remote port: 5060
dev id: 34020000001180000001
gb35114_en: No
```
其中`protocol`表示整个设备拉流协议的总开关，不仅仅影响sip协议拉的流，私有和rtsp的也依据于此，可取UDP/TCP_PORT/TCP_PASSIVE/RTP；`sip mode`表示当前的sip模式：Educational/Gb28181/Gb35114/Edusecurity；`local ip`表示sip拉流所用的本地ip地址，如果本机有多个地址的话，当前用的哪个；`distributed`表示当前拉流是否过分发；`gb_verify`表示ipc通过国标协议接入设备时，是否需要用户名密码认证；`local port`表示modsip用的本地端口；`remote port`表示modsip信令发往sip服务器的目的端口；`dev id`表示modsip作为国标服务器时，其设备ID；`gb35114_en`表示当前35114是否使能。

### 2.12 info link
该命令仅用于大规模矩阵，对于超脑无意义。

### 2.13 info gbchan
该命令用于展示以国标协议介入本设备的摄像机的设备ID列表。

### 2.14 info rec
该命令用于展示超脑设备图片和视频存储的一些状态和统计信息。比如：
```shell
spy> info rec
CH-0: sock: 117, err: 0, pic: 17/66640, drop: 0.00B, vid: 6/148855
CH-1: sock: 299, err: 0, pic: 8/66663, drop: 0.00B, vid: 55/145562
CH-2: sock: 109, err: 102, pic: 20/67139, drop: 0.00B, vid: 92/324241
CH-3: sock: 132, err: 0, pic: 18/57109, drop: 0.00B, vid: 68/242653
```
只需详细解释其中一行即可。`CH-x`表示AI检测的通道号；`sock`表示用于接收图片的socket的fd；`err`表示图片存储过程中的异常；`pic`表示图片存储的张数统计，斜杠前为存储失败的张数，斜杠后面为提交给存储库的总张数；`drop`表示由于异常而导致的丢弃的图片数据的数据量，如果这里非0，请运行`info dropbytes`进一步诊断；`vid`表示视频存储的统计信息，斜杠前表示给存储库提交数据失败的次数，斜杠后面表示该通道提交给存储库的总次数。

该命令通常用于定位图片存储和视频存储是否存在异常。可多运行几次看其中一些值的变化，看是否有某个通道的`pic`的值不增，`drop`的值反而一直增。比如我们发现web上的实时预览上某个通道卡住了，就应该用这个命令查看其存储情况。

### 2.15 info disk
该命令用于展示存储库初始化成功的硬盘以及其状态。比如
```shell
spy> info disk 
[/dev/sda1] status: 0x00001000, hangup: 0
[/dev/sdb1] status: 0x00001000, hangup: 0
disk_num: 2, hangup_disk_num: 0
```
其中中括号里是设备文件，`status`为硬盘状态，其值请参考存储库中的定义，`hangup`表示硬盘是否被禁用。

最后一行展示了硬盘的总个数和被禁用的硬盘个数。

如果通过`info rec`发现存储统计均为0，那么应该首先需要运行这个命令来判断是否为硬盘异常或者无硬盘所致。

### 2.16 info plan
该命令用来展示当前是否正处于某个场次的考试期间，如果是那么存储和AI检测均应该正常进行，否则存储会停止。比如：
```shell
spy> info plan 
now in exam plan: 1/1
PLAN: 2024-06-04 17:30:00 => 2024-06-04 20:10:00
PLAN: 2024-06-04 20:30:00 => 2024-06-04 23:10:00
PLAN: 2024-06-04 23:30:00 => 2024-06-05 02:10:00
PLAN: 2024-06-05 02:30:00 => 2024-06-05 05:10:00
PLAN: 2024-06-05 05:30:00 => 2024-06-05 08:10:00
```
第一行中如果数字是0，那么目前没有考试，如果是1，那么正在考试。接下来的行展示的是考试的场次时间信息，存储会据此自动停止和开始。

如果web上发现所有通道实时预览均停止了，那么应该首先用该命令来查看考试是否已经结束。


### 2.17 info bufpool
该命令用于展示各个AI通道的图片存储以及视频存储的内存使用情况。比如：
```shell
spy> info bufpool 
jpeg buffer pool:
[pic_0] cur:447.00K, max:3.89M, total:4.00M
[pic_1] cur:60.00K, max:3.80M, total:4.00M
[pic_2] cur:207.00K, max:2.08M, total:4.00M
[pic_3] cur:396.00K, max:2.17M, total:4.00M
------------------------------
video buffer pool:
[video_0]: cur:64.00K, max:3.06M, total:4.00M
[video_1]: cur:192.00K, max:2.69M, total:4.00M
[video_2]: cur:64.00K, max:4.00M, total:4.00M
[video_3]: cur:320.00K, max:3.19M, total:4.00M
```
其中`jpeg buffer pool`下面的行展示了通道图片缓冲区的使用情况。`video buffer pool`下面的行展示了视频存储的缓冲区使用情况。

缓冲区使用详情中第一列为AI检测的通道号；`cur`表示当前缓冲区的使用量，`max`表示缓冲区的历史最大使用量，`total`表示该通道所分配的缓冲区总大小。`cur`的值过大则意味着存储慢或者存储异常。也意味着该通道即将或者已经开始丢数据。

### 2.18 info dropbytes
该命令用于展示通道由于异常情况而主动丢失的图片数据。比如：
```shell
spy> info dropbytes 
CH-11: total(1395763497), oom(1395763497), bof(0), loss(0), pof(0)
CH-26: total(1491815547), oom(1491815547), bof(0), loss(0), pof(0)
```
如果没有数据丢失，那么该命令不会输出任何东西，如果有数据丢失，那么输入如上所示。`CH-xx`表示IA检测通道号，`total`表示主动丢失的数据总量，`oom`表示由于申请不到缓冲区而丢弃的数据量，如果这个值一家独大，那么就应该运行`info bufpool`去查看缓冲区使用情况了，`bof`表示缓冲区溢出（buffer overflow）丢失的数据，接收数据的时候会首先申请一个512k大小的dex，如果图片大小大于512k，那么会丢失数据，`loss`表示网络丢包造成的丢失，比如数据为硬未达到预定图片长度却遇到了下一个图片头，那么肯定是网络丢包造成的，`pof`表示由于文件头丢失（picture overflow）造成的丢数据，按照预定长度已经收够了数据，但接下来并不是图片头，此时在寻找下一个图片头期间丢弃的数据就算在`pof`头上了。

目前出现最多的就是`oom`，具体原因还不明朗，可能是dex库的问题，也可能是存储库的问题，悬而未决。

## 3. set
首先，我们仍是先`help`一下：
```shell
spy> help set                            
set seqsync      - sequence sync
```
我没看到该命令下面仅有一个二级命令，就是`set seqsync`，该命令用于手动的序列同步。web上也有这个功能，因此作用不大，不再多说。

## 4. loglevel
先`help`一下不香嘛：
```shell
spy> help loglevel 
loglevel [N]  - get loglevel or set loglevel to N
```
我们看到`loglevel·可以不带参数用，此时会返回当前日志的级别；也可以带参数用，参数`N`的范围为0-7，此时会设置日志级别为`N`。比如：
```shell
spy> loglevel 
loglevel is 5
spy> loglevel 5
loglevel set to 5
```
需要注意的是，这里的日志级别调整并不会被保存，因此core重启或者设备重启后，日志级别仍会恢复到默认的级别（5）。

## 5. expose
这是要暴漏啥，`help`一下先：
```shell
spy> help expose 
expose [sth] - toggle debug info about [sth]
```
因此如上所示，这是要动态的打开或者关闭一些调试信息，用于程序调试或者问题查因。那么`sth`都有啥呢？我们不带参数运行`expose`，得到如下信息：
```shell
spy> expose 
available prints: MQTT,EPOLL,LIST
```
我们看到目前仅仅支持3个打印开关，`MQTT`是mqtt请求和回应内容的打印开关，`LIST`是内部一个链表调试的打印开关，除了我之外应该用不到，`EPOLL`是epoll异常时调试信息的打印开关，不是我也用不到。

因此最可能最有用的就是`MQTT`了，其用法是，先运行`expose MQTT`，此时MQTT的调试开关已经打开，有新的mqtt请求时其内容会打印到当前终端，当不需要时，再次运行`expose MQTT`，就会关闭调试开关。
