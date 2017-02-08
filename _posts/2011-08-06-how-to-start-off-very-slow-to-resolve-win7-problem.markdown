---
author: abloz
comments: true
date: 2011-08-06 01:23:09+00:00
layout: post
link: http://abloz.com/index.php/2011/08/06/how-to-start-off-very-slow-to-resolve-win7-problem/
slug: how-to-start-off-very-slow-to-resolve-win7-problem
title: 如何解决win7开机关机很慢的问题(一)
wordpress_id: 1316
categories:
- 技术
---

老婆的同事，两年前买的笔记本，开机时间2分钟以上。说让我给看看。但windows有一点不好，看不到开机详情，所以也不知道什么东西在加载过程中耗费了时间。
所以我就按照通常的方式，做了如下的步骤：
1.将启动里面的程序删除。
2.运行regedit，搜索run，只选“项”，全字匹配。到注册表中将可疑的无用的启动删除。
3.如果可以，还可以看看服务里有没有没必要的服务，可以禁止启动。
4.并且卸载一些看起来无用的自启动程序。

但这样操作完后，开机时间1分30秒，并无多大改观。
一些第三方的软件，如360，QQ电脑管家，会提示一些优化项目，但还是不能从根本上解决问题。启动依然很慢。

补充：网友Alex 在本文的评论附了微软提供的[autoruns程序](http://technet.microsoft.com/en-us/sysinternals/bb963902)，可以很方便管理启动项，服务，右键菜单，IE加载项等。不过没有看到中文版。

能否查看启动的命令行详情呢？开机时用F8进入，有命令行模式。但只显示了一部分命令行，又转入图形界面了，吐血！
那能否用日志记录的方式呢？同样开机用F8进入，选日志记录模式，提示将日志记在windows的ntbtlog.txt,可是该文件打开看到的是：

```
Microsoft (R) Windows (R) Version 6.1 (Build 7600)
8 6 2011 07:44:12.610
Loaded driver SystemRootsystem32ntoskrnl.exe
Loaded driver SystemRootsystem32hal.dll
Loaded driver SystemRootsystem32kdcom.dll
Loaded driver SystemRootsystem32mcupdate_GenuineIntel.dll
Loaded driver SystemRootsystem32PSHED.dll
Loaded driver SystemRootsystem32CLFS.SYS
...
```

记录启动日志居然连时间都没有？？？？何必为我省这点空间？？？？快哭了！

微软提供了日志管理器，其中的Microsoft-Windows-Diagnostics-Performance/Operational 有启动性能监视。

 [![](http://abloz.com/wp-content/uploads/2011/08/perf2.png)](http://abloz.com/wp-content/uploads/2011/08/perf2.png)



点开后，可以设置100-110启动性能事件过滤。如我的100事件，详情。可以通过友好视图和xml视图来显示。

![](http://abloz.com/wp-content/uploads/2011/08/perf3.png)

 各事件耗费的时间（毫秒ms)，都有记录。如我计算机中的数据：

```

<table >
<tbody >
<tr >

<td width="130" nowrap="nowrap" >**EventData**
</td>
</tr>
</tbody>
</table>



<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootTsVersion**
</td>

<td >2
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootStartTime**
</td>

<td >2011-08-09T14:59:50.765200500Z
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootEndTime**
</td>

<td >2011-08-09T15:02:01.298627900Z
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**SystemBootInstance**
</td>

<td >300
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**UserBootInstance**
</td>

<td >145
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootTime**
</td>

<td >95172
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**MainPathBootTime**
</td>

<td >32872
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootKernelInitTime**
</td>

<td >19
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootDriverInitTime**
</td>

<td >2343
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootDevicesInitTime**
</td>

<td >1207
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootPrefetchInitTime**
</td>

<td >67306
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootPrefetchBytes**
</td>

<td >391528448
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootAutoChkTime**
</td>

<td >0
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootSmssInitTime**
</td>

<td >11345
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootCriticalServicesInitTime**
</td>

<td >621
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootUserProfileProcessingTime**
</td>

<td >1613
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootMachineProfileProcessingTime**
</td>

<td >29
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootExplorerInitTime**
</td>

<td >12577
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootNumStartupApps**
</td>

<td >13
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootPostBootTime**
</td>

<td >62300
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootIsRebootAfterInstall**
</td>

<td >false
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootRootCauseStepImprovementBits**
</td>

<td >0
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootRootCauseGradualImprovementBits**
</td>

<td >0
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootRootCauseStepDegradationBits**
</td>

<td >2097152
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootRootCauseGradualDegradationBits**
</td>

<td >2097152
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootIsDegradation**
</td>

<td >false
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootIsStepDegradation**
</td>

<td >false
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootIsGradualDegradation**
</td>

<td >false
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootImprovementDelta**
</td>

<td >0
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootDegradationDelta**
</td>

<td >0
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootIsRootCauseIdentified**
</td>

<td >true
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**OSLoaderDuration**
</td>

<td >3095
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootPNPInitStartTimeMS**
</td>

<td >19
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**BootPNPInitDuration**
</td>

<td >2544
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**OtherKernelInitDuration**
</td>

<td >1751
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**SystemPNPInitStartTimeMS**
</td>

<td >4194
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**SystemPNPInitDuration**
</td>

<td >1006
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**SessionInitStartTimeMS**
</td>

<td >5302
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**Session0InitDuration**
</td>

<td >4027
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**Session1InitDuration**
</td>

<td >1388
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**SessionInitOtherDuration**
</td>

<td >5929
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**WinLogonStartTimeMS**
</td>

<td >16647
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**OtherLogonInitActivityDuration**
</td>

<td >2004
</td>
</tr>
</tbody>
</table>
<table cellspacing="0" border="0" >
<tbody >
<tr >

<td width="15" nowrap="nowrap" > 
</td>

<td width="15" nowrap="nowrap" > 
</td>

<td width="130" nowrap="nowrap" >**UserLogonWaitDuration**
</td>

<td >13873
</td>
</tr>
</tbody>
</table>



```

各个项目的意思，在OnOffTrans.docx中有解释。[OnOffTransPerf](http://abloz.com/wp-content/uploads/2011/08/OnOffTransPerf.docx)由微软提供, 讲如何将启动时间提高到10秒。官方下载地址：[http://msdn.microsoft.com/en-us/performance/cc825801](http://msdn.microsoft.com/en-us/performance/cc825801)

因为系统启动时，分两个阶段。第一阶段是到加载关键路径代码以启动桌面进程，第二阶段是到系统进入idle，期间系统加载很多后台服务。

微软其实有诊断程序。在win7的sdk里自带。
 

[![](http://abloz.com/wp-content/uploads/2011/08/perf1.png)](http://abloz.com/wp-content/uploads/2011/08/perf1.png)

（待续...）
