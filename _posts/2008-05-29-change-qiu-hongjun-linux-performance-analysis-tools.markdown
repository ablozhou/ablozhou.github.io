---
author: abloz
comments: true
date: 2008-05-29 09:29:35+00:00
layout: post
link: http://abloz.com/index.php/2008/05/29/change-qiu-hongjun-linux-performance-analysis-tools/
slug: change-qiu-hongjun-linux-performance-analysis-tools
title: '[转]裘宏骏:Linux 相关性能分析工具'
wordpress_id: 313
categories:
- 技术
- 转载
tags:
- iostat
- linux
- sar
- vmstat
- 性能
---

from: [http://dev2dev.bea.com.cn/blog/QiuHj/200804/22_1002.html](http://dev2dev.bea.com.cn/blog/QiuHj/200804/22_1002.html)
裘宏骏的联系方式：QiuHj1978@hotmail.com

iostat


iostat命令是另一个研究磁盘吞吐量 的工具。和sar类似，iostat可以使用间隔和计数参数。第一个间隔的输出包含Linux总运行时间的指标。与其他性能命令比较，这可能是 iostat最独特的功能。例如，以下是一个大部分时间处于空闲的系统的输出。可见，从启动以来hda设备已经读取大约9 158MB（18 755  572*512/1 024/1 024）。Blk列是512字节块。




![](http://book.csdn.net/BookFiles/331/img/image152.jpg)




![](http://book.csdn.net/BookFiles/331/img/image153.jpg)




不使用选项，iostat只显示覆盖启动以来全部时间的一组指标。




CPU信息包含基本上和top一样的字段。iostat CPU输出显示在用户模式中执行、执行正常进程、在内核（系统）模式中执行，进程等待I/O完成时处于空闲和没有等待进程时处于空闲的CPU时间的百分比。CPU行是所有CPU的摘要。




磁盘信息与sar -d提供的信息类似。输出包括每秒传输数（tps）、每秒512字节块读取数（Blk_read/s）、每秒512字节块写入数（Blk_wrtn/s）和512字节块读取（Blk_read）和写入（Blk_wrtn）的总数量。




iostat提供几个用于定制输出的开关。最有用的有：




-c 只显示CPU行




-d 显示磁盘行




-k 以千字节为单位显示磁盘输出




-t 在输出中包括时间戳




-x 在输出中包括扩展的磁盘指标




这些选项可以组合。iostat -tk 5 2的输出是：




![](http://book.csdn.net/BookFiles/331/img/image154.jpg)




![](http://book.csdn.net/BookFiles/331/img/image155.jpg)




vmstat


vmstat命令也是显示Linux性能指标的方法，它报告了许多信息，理解这些信息有一定难度。

输出分为6个类别：进程、内存、交换区、I/O、系统和CPU。与iostat类似，第一个样本是从最近重新启动以来的平均值。以下是一个典型的vmstat输出：

![](http://book.csdn.net/BookFiles/331/img/image151.jpg)

-m选项使内存字段以兆字节为单位显示。vmstat和许多其他性能命令一样使用取样间隔和计数参数。

进程（procs）信息有两列。r列是可运行进程的数量，b列是阻塞进程的数量。

内存部分有4个报告虚拟内存如何使用的字段。表3-7列出这些字段及其意义。

表3-7 vmstat内存字段



<table cellpadding="0" cellspacing="0" border="1" width="561" >
<tbody >
<tr >

<td width="238" valign="top" >字 段
</td>

<td width="323" valign="top" >说 明
</td>
</tr>
<tr >

<td width="238" valign="top" >Swpd
</td>

<td width="323" valign="top" >已用的交换空间数量
</td>
</tr>
<tr >

<td width="238" valign="top" >free
</td>

<td width="323" valign="top" >自由RAM数量
</td>
</tr>
<tr >

<td width="238" valign="top" >buff
</td>

<td width="323" valign="top" >缓冲使用的RAM数量
</td>
</tr>
<tr >

<td width="238" valign="top" >cache
</td>

<td width="323" valign="top" >文件系统缓存使用的RAM数量
</td>
</tr>
</tbody>
</table>



接下来是交换（swap）指标。交换只是一个古老术语，但是显然不会消失。交换涉及分页读取或写入磁盘 的进程所消耗的所有内存。它将显示系统达到的性能指标水平。而Linux所做的是，以小块方式按照需要对磁盘空间进行分页操作。因此，我们可能应该停止说 交换到磁盘的内存，并开始说分页到磁盘的内存。对于任何一种方法，表3-8解释了相关字段。

表3-8 vmstat交换字段



<table cellpadding="0" cellspacing="0" border="1" width="562" >
<tbody >
<tr >

<td width="238" valign="top" >字 段
</td>

<td width="324" valign="top" >说 明
</td>
</tr>
<tr >

<td width="238" valign="top" >si
</td>

<td width="324" valign="top" >从磁盘分页到内存的数量
</td>
</tr>
<tr >

<td width="238" valign="top" >so
</td>

<td width="324" valign="top" >从内存分页到磁盘的数量
</td>
</tr>
</tbody>
</table>



在交换之后是两个I/O字段。这部分提供了一个简略介绍以帮助确定Linux是否正忙于完成许多磁盘I/O。vmstat只提供两个字段，显示出入磁盘的数据量（参见表3-9）。

表3-9 vmstat io字段



<table cellpadding="0" cellspacing="0" border="1" width="562" >
<tbody >
<tr >

<td width="238" valign="top" >字 段
</td>

<td width="324" valign="top" >说 明
</td>
</tr>
<tr >

<td width="238" valign="top" >bi
</td>

<td width="324" valign="top" >从磁盘读入的块
</td>
</tr>
<tr >

<td width="238" valign="top" >bo
</td>

<td width="324" valign="top" >写入磁盘的块
</td>
</tr>
</tbody>
</table>



系统字段提供Linux内核进行进程管理的繁忙程度的摘要。中断和上下文开关参见表3-10。上下文开关指进程移出CPU或者移入CPU。

表3-10 vmstat系统字段



<table cellpadding="0" cellspacing="0" border="1" width="562" >
<tbody >
<tr >

<td width="240" valign="top" >字 段
</td>

<td width="322" valign="top" >说 明
</td>
</tr>
<tr >

<td width="240" valign="top" >in
</td>

<td width="322" valign="top" >系统中断
</td>
</tr>
<tr >

<td width="240" valign="top" >cs
</td>

<td width="322" valign="top" >进程上下文开关
</td>
</tr>
</tbody>
</table>



最后，CPU状态信息用总CPU时间的百分比来表示，如表3-11所示。

表3-11 vmstat cpu字段



<table cellpadding="0" cellspacing="0" border="1" width="562" >
<tbody >
<tr >

<td width="240" valign="top" >字 段
</td>

<td width="322" valign="top" >说 明
</td>
</tr>
<tr >

<td width="240" valign="top" >us
</td>

<td width="322" valign="top" >用户模式
</td>
</tr>
<tr >

<td width="240" valign="top" >sy
</td>

<td width="322" valign="top" >内核模式
</td>
</tr>
<tr >

<td width="240" valign="top" >wa
</td>

<td width="322" valign="top" >等待I/O
</td>
</tr>
<tr >

<td width="240" valign="top" >id
</td>

<td width="322" valign="top" >空闲
</td>
</tr>
</tbody>
</table>








sarsar是一个优秀的一般性能监视工具，它可以输出Linux所完成的几乎所有工作的数据。sar命令在sysetat  rpm中提供。示例中使用sysstat版本5.0.5，这是稳定的最新版本之一。关于版本和下载信息，请访问sysstat主页 http://perso.wanadoo.fr/sebastien.godard/。

sar可以显示CPU、运行队列、磁盘I/O、分页（交换区）、内存、CPU中断、网络等性能数据。最重要的sar功能是创建数据文件。每一个 Linux系统都应该通过cron工作收集sar数据。该sar数据文件为系统管理员提供历史性能信息。这个功能非常重要，它将sar和其他性能工具区分 开。如果一个夜晚批处理工作正常运行两次，直到下一个早上才会发现这种情况（除非被叫醒）。我们需要具备研究12小时以前的性能数据的能力。sar数据收 集器提供了这种能力。有许多报告语法，我们首先讨论数据收集。


### 3.2.1 sar数据收集器


sar数据收集通过/usr/lib/sa中的一个二进制可执行文件和两个脚本来完成。sar数据收集器是一个位于/usr/lib/sa /sadc的二进制可执行文件。sadc的工作是写入数据收集文件/var/1og/sa/。可以为sadc提供几个选项。常见语法是：

![](http://book.csdn.net/BookFiles/331/img/image135.jpg)

间隔是取样间的秒数，iterations是要取得的样本数量，file  name定义输出文件。简单的sadc语法是/usr/lib/sa/sadc 360  5/tmp/sadc.out。这个命令在5分钟间隔取得5个样本并将它们保存在/tmp/sadc.out。我们应该定期收集样本，因此需要一个由 cron运行的脚本。应该把样本放在一个有意义的地方，如在前一节中使用top脚本时那样。sysstat  rpm提供/usr/lib/sa/sa1脚本来完成所有这些事情。

sa1（8）手册页比sa1脚本本身要长得多。/usr/lib/sa/sa1是一个非常简单的脚本，使用语法sadc -F -L 1 1  /var/log/sa/sa##来运行sadc，其中##是某月的日期。较老版本的sa1使用date+.%Y_%m_%d的输出作为文件后缀。如果需 要，可以使用-F选项使sadc强制创建输出文件。-L在写入输出文件之前锁定它，以防止两个sadc进程同时运行时损坏该文件。较老版本的sadc没有 -L选项，因此sa1脚本执行手工锁定。sa1脚本的选项只是样本之间的间隔和取样迭代的次量。cron文件（/etc/cron.d/sysstat） 和sysstat一起提供，在各sysstat版本之间它有所不同。以下是5.0.5版本的sysstat的条目：

![](http://book.csdn.net/BookFiles/331/img/image136.jpg)

可见，在sysstat rpm安装之后，sadc开始取得样本。sysstat主页是http://perso.wanadoo.fr/ sebastien.godard/2。文档链接提供以下类似2006年1月14日的crontab方案：

![](http://book.csdn.net/BookFiles/331/img/image137.jpg)

Sebastien  Godard的网站的crontab示例建议周一至周五从早晨8点到下午6点每10分钟取一次样本，其他时间每小时取得一个样本（注意，crontab注 释为下午7点，但实际上是18:00，即下午6点）。如果/var中的磁盘空间足够，可以每天都每小时的每10分钟取样一次。如果周末备份较慢，每小时一 次sadc取样可能帮助不大。

现在让我们研究更流行的报告语法。


### 3.2.2 CPU统计数据


sar -u输出显示CPU信息。-u选项是sar的默认选项。该输出以百分比显示CPU的使用情况。表3-2解释该输出。

表3-2 sar -u字段
<table cellpadding="0" cellspacing="0" border="1" width="561" >
<tbody >
<tr >

<td width="203" valign="top" >字 段
</td>

<td width="357" valign="top" >说 明
</td>
</tr>
<tr >

<td width="203" valign="top" >CPU
</td>

<td width="357" valign="top" >CPU编号
</td>
</tr>
<tr >

<td width="203" valign="top" >%user
</td>

<td width="357" valign="top" >在用户模式中运行进程所花的时间
</td>
</tr>
<tr >

<td width="203" valign="top" >%nice
</td>

<td width="357" valign="top" >运行正常进程所花的时间
</td>
</tr>
<tr >

<td width="203" valign="top" >%system
</td>

<td width="357" valign="top" >在内核模式（系统）中运行进程所花的时间
</td>
</tr>
<tr >

<td width="203" valign="top" >%iowait
</td>

<td width="357" valign="top" >没有进程在该CPU上执行时，处理器等待I/O完成的时间
</td>
</tr>
<tr >

<td width="203" valign="top" >%idle
</td>

<td width="357" valign="top" >没有进程在该CPU上执行的时间
</td>
</tr>
</tbody>
</table>
这些看起来应该比较熟悉，它和top报告中的CPU信息内容相同。以下显示输出格式：

![](http://book.csdn.net/BookFiles/331/img/image138.jpg)

其中的5 10导致sar以5秒钟间隔取得10个样本。任何sar报告的第一列都是时间戳。

我们本来可以研究使用-f选项通过sadc创建的文件。这个sar语法显示sar -f/var/log/ sa/sa21的输出：

![](http://book.csdn.net/BookFiles/331/img/image139.jpg)

![](http://book.csdn.net/BookFiles/331/img/image140.jpg)

在多CPU Linux系统中，sar命令也可以为每个CPU分解该信息，如以下sar -u -P ALL 5 5输出所示：

![](http://book.csdn.net/BookFiles/331/img/image141.jpg)

![](http://book.csdn.net/BookFiles/331/img/image142.jpg)


### 3.2.3 磁盘I/O统计数据


sar是一个研究磁盘I/O的优秀工具。以下是sar磁盘I/O输出的一个示例。

![](http://book.csdn.net/BookFiles/331/img/image143.jpg)

第一行-d显示磁盘I/O信息，5 2选项是间隔和迭代，就像sar数据收集器那样。表3-3列出了字段和说明。

表3-3 sar -d字段
<table cellpadding="0" cellspacing="0" border="1" width="561" >
<tbody >
<tr >

<td width="245" valign="top" >字 段
</td>

<td width="316" valign="top" >说 明
</td>
</tr>
<tr >

<td width="245" valign="top" >DEV
</td>

<td width="316" valign="top" >磁盘设备
</td>
</tr>
<tr >

<td width="245" valign="top" >tps
</td>

<td width="316" valign="top" >每秒传输数（或者每秒IO数）
</td>
</tr>
<tr >

<td width="245" valign="top" >rd_sec/s
</td>

<td width="316" valign="top" >每秒512字节读取数
</td>
</tr>
<tr >

<td width="245" valign="top" >wr_sec/s
</td>

<td width="316" valign="top" >每秒512字节写入数
</td>
</tr>
</tbody>
</table>
512只是一个测量单位，不表示所有磁盘I/O均使用512字节块。DEV列是dev#-#格式的磁盘设备，其中第一个#是设备主编号，第二个#是 次编号或者连续编号。对于大于2.5的内核，sar使用次编号。例如，在sar  -d输出中看到的dev3-0和dev3-1。它们对应于/dev/hda和/dev/hdal。请看/dev中的以下各项：

![](http://book.csdn.net/BookFiles/331/img/image144.jpg)

/dev/hda有主编号3和次编号0。hda1有主编号3和次编号1。


### 3.2.4 网络统计数据


sar提供四种不同的语法选项来显示网络信息。-n选项使用四个不同的开关：DEV、EDEV、SOCK和FULL。DEV显示网络接口信 息，EDEV显示关于网络错误的统计数据，SOCK显示套接字信息，FULL显示所有三个开关。它们可以单独或者一起使用。表3-4显示通过-n  DEV选项报告的字段。

表3-4 sar -n DEV字段
<table cellpadding="0" cellspacing="0" border="1" width="561" >
<tbody >
<tr >

<td width="244" valign="top" >字 段
</td>

<td width="317" valign="top" >说 明
</td>
</tr>
<tr >

<td width="244" valign="top" >IFACE
</td>

<td width="317" valign="top" >LAN接口
</td>
</tr>
<tr >

<td width="244" valign="top" >rxpck/s
</td>

<td width="317" valign="top" >每秒钟接收的数据包
</td>
</tr>
<tr >

<td width="244" valign="top" >txpck/s
</td>

<td width="317" valign="top" >每秒钟发送的数据包
</td>
</tr>
<tr >

<td width="244" valign="top" >rxbyt/s
</td>

<td width="317" valign="top" >每秒钟接收的字节数
</td>
</tr>
<tr >

<td width="244" valign="top" >txbyt/s
</td>

<td width="317" valign="top" >每秒钟发送的字节数
</td>
</tr>
<tr >

<td width="244" valign="top" >rxcmp/s
</td>

<td width="317" valign="top" >每秒钟接收的压缩数据包
</td>
</tr>
<tr >

<td width="244" valign="top" >txcmp/s
</td>

<td width="317" valign="top" >每秒钟发送的压缩数据包
</td>
</tr>
<tr >

<td width="244" valign="top" >rxmcst/s
</td>

<td width="317" valign="top" >每秒钟接收的多播数据包
</td>
</tr>
</tbody>
</table>
以下是使用-n DEV选项的sar输出：

![](http://book.csdn.net/BookFiles/331/img/image145.jpg)

![](http://book.csdn.net/BookFiles/331/img/image146.jpg)

关于网络错误的信息可以用sar -n EDEV显示。表3-5列出了显示的字段。

![](http://book.csdn.net/BookFiles/331/img/image147.jpg)

![](http://book.csdn.net/BookFiles/331/img/image148.jpg)

表3-5 sar -n EDEV字段
<table cellpadding="0" cellspacing="0" border="1" width="562" >
<tbody >
<tr >

<td width="219" valign="top" >字 段
</td>

<td width="342" valign="top" >说 明
</td>
</tr>
<tr >

<td width="219" valign="top" >IFACE
</td>

<td width="342" valign="top" >LAN接口
</td>
</tr>
<tr >

<td width="219" valign="top" >rxerr/s
</td>

<td width="342" valign="top" >每秒钟接收的坏数据包
</td>
</tr>
<tr >

<td width="219" valign="top" >txerr/s
</td>

<td width="342" valign="top" >每秒钟发送的坏数据包
</td>
</tr>
<tr >

<td width="219" valign="top" >coll/s
</td>

<td width="342" valign="top" >每秒冲突数
</td>
</tr>
<tr >

<td width="219" valign="top" >rxdrop/s
</td>

<td width="342" valign="top" >因为缓冲充满，每秒钟丢弃的已接收数据包数
</td>
</tr>
<tr >

<td width="219" valign="top" >txdrop/s
</td>

<td width="342" valign="top" >因为缓冲充满，每秒钟丢弃的已发送数据包数
</td>
</tr>
<tr >

<td width="219" valign="top" >txcarr/s
</td>

<td width="342" valign="top" >发送数据包时，每秒载波错误数
</td>
</tr>
<tr >

<td width="219" valign="top" >rxfram/s
</td>

<td width="342" valign="top" >每秒接收数据包的帧对齐错误数
</td>
</tr>
<tr >

<td width="219" valign="top" >rxfifo/s
</td>

<td width="342" valign="top" >接收的数据包每秒FIFO过速的错误数
</td>
</tr>
<tr >

<td width="219" valign="top" >txfifo/s
</td>

<td width="342" valign="top" >发送的数据包每秒FIFO过速的错误数
</td>
</tr>
</tbody>
</table>
SOCK参数显示IPCS套接字信息。表3-6列出显示的字段及其意义。

表3-6 sar -n SOCK字段
<table cellpadding="0" cellspacing="0" border="1" width="562" >
<tbody >
<tr >

<td width="219" valign="top" >字 段
</td>

<td width="342" valign="top" >说 明
</td>
</tr>
<tr >

<td width="219" >totsck
</td>

<td width="342" >使用的套接字总数量
</td>
</tr>
<tr >

<td width="219" >tcpsck
</td>

<td width="342" >使用的TCP套接字数量
</td>
</tr>
<tr >

<td width="219" >udpsck
</td>

<td width="342" >使用的UDP套接字数量
</td>
</tr>
<tr >

<td width="219" >rawsck
</td>

<td width="342" >使用的raw套接字数量
</td>
</tr>
<tr >

<td width="219" >ip-frag
</td>

<td width="342" >使用的IP段数量
</td>
</tr>
</tbody>
</table>
![](http://book.csdn.net/BookFiles/331/img/image149.jpg)

sar可以产生许多其他报告。我们有必要仔细阅读sar（1）手册页，查看是否有自己需要的其他报告。


