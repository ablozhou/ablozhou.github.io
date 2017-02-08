---
author: abloz
comments: true
date: 2010-06-09 07:34:00+00:00
layout: post
link: http://abloz.com/index.php/2010/06/09/windows-and-linux-time-synchronization-methods-do/
slug: windows-and-linux-time-synchronization-methods-do
title: windows 和linux做时间同步方法
wordpress_id: 1232
categories:
- 技术
---

周海汉 /文

2010.6.9

 

此前写了篇《[linux设置时间 服务器](http://blog.csdn.net/ablo_zhou/archive/2010/03/31/5433267.aspx) 》，解决了Linux之间时间同步的问题。windows系统想偷懒，用windows自带的internet时间同步，向time.windows.com进行同步。双击任务栏右下角的时间，弹出时间设置，可以选择用哪些时间服务器更新。

 

![](http://hi.csdn.net/attachment/201006/9/0_1276071792BT9j.gif)

 

但如果windows系统不能上公网时，必须使用本地的时间服务器。由于我linux局域网的时间服务器地址是192.168.12.31.如果直 接将时间服务器的IP修改为192.168.12.31,  更新时间会失败。加入域的windows缺省的时间同步类型是nt5ds，没有加入域的是ntp.

可以在windows直接安装一个ntp时间服务器。比如[到此下载](http://www.meinberg.de/english/sw/ntp.htm) ：http://www.meinberg.de/english/sw/ntp.htm

 

现在既然linux已经有了时间服务器，就不必再安装时间服务器了。

 

由于windows自带时间同步客户端，可以直接修改注册表配置。

方便起见，直接导入注册表文件。

[](http://blog.csdn.net/ablo_zhou/archive/2010/06/09/5658916.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2010/06/09/5658916.aspx#)

  1. Windows Registry Editor Version 5.00
  2. [HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32Time]
  3. "Description"="维护在网络上的所有客户端和服务器的时间和日期同步。如果此服务被停止，时间和日期的同步将不可用。如果此服务被禁用，任何明确依赖它的服务都将不能启动。
  4. "
  5. "DisplayName"="Windows Time"
  6. "ErrorControl"=dword:00000001
  7. "FailureActions"=hex:05,00,00,00,00,00,00,00,00,00,00,00,02,00,00,00,64,00,20,
  8. 00,01,00,00,00,60,ea,00,00,01,00,00,00,60,ea,00,00
  9. "Group"=""
  10. "ImagePath"=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,
  11. 74,00,25,00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,
  12. 00,76,00,63,00,68,00,6f,00,73,00,74,00,2e,00,65,00,78,00,65,00,20,00,2d,00,
  13. 6b,00,20,00,4c,00,6f,00,63,00,61,00,6c,00,53,00,65,00,72,00,76,00,69,00,63,
  14. 00,65,00,00,00
  15. "Objectname"="NT AUTHORITY\LocalService"
  16. "Start"=dword:00000004
  17. "Type"=dword:00000020
  18. [HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32TimeConfig]
  19. "LastClockRate"=dword:0002625a
  20. "MinClockRate"=dword:000260d4
  21. "MaxClockRate"=dword:000263e0
  22. "FrequencyCorrectRate"=dword:00000004
  23. "PollAdjustFactor"=dword:00000005
  24. "LargePhaseOffset"=dword:02faf080
  25. "SpikeWatchPeriod"=dword:00000384
  26. "HoldPeriod"=dword:00000005
  27. "LocalClockDispersion"=dword:0000000a
  28. "EventLogFlags"=dword:00000002
  29. "PhaseCorrectRate"=dword:00000001
  30. "MinPollInterval"=dword:0000000a
  31. "MaxPollInterval"=dword:0000000f
  32. "UpdateInterval"=dword:00057e40
  33. "MaxNegPhaseCorrection"=dword:0000d2f0
  34. "MaxPosPhaseCorrection"=dword:0000d2f0
  35. "AnnounceFlags"=dword:00000005
  36. "MaxAllowedPhaseOffset"=dword:00000001
  37. [HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32TimeParameters]
  38. "ServiceMain"="SvchostEntry_W32Time"
  39. "ServiceDll"=hex(2):43,00,3a,00,5c,00,57,00,49,00,4e,00,44,00,4f,00,57,00,53,
  40. 00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,77,00,33,00,
  41. 32,00,74,00,69,00,6d,00,65,00,2e,00,64,00,6c,00,6c,00,00,00
  42. "NtpServer"="192.168.12.31,0x1"
  43. "Type"="NTP"
  44. [HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32TimeSecurity]
  45. "Security"=hex:01,00,14,80,a8,00,00,00,b4,00,00,00,14,00,00,00,30,00,00,00,02,
  46. 00,1c,00,01,00,00,00,02,80,14,00,ff,01,0f,00,01,01,00,00,00,00,00,01,00,00,
  47. 00,00,02,00,78,00,05,00,00,00,00,00,14,00,8d,00,02,00,01,01,00,00,00,00,00,
  48. 05,0b,00,00,00,00,00,18,00,ff,01,0f,00,01,02,00,00,00,00,00,05,20,00,00,00,
  49. 20,02,00,00,00,00,18,00,8d,00,02,00,01,02,00,00,00,00,00,05,20,00,00,00,23,
  50. 02,00,00,00,00,14,00,9d,00,00,00,01,01,00,00,00,00,00,05,04,00,00,00,00,00,
  51. 18,00,9d,00,00,00,01,02,00,00,00,00,00,05,20,00,00,
00,21,02,00,00,01,01,00,
  52. 00,00,00,00,05,12,00,00,00,01,01,00,00,00,00,00,05,12,00,00,00
  53. [HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32TimeTimeProviders]
  54. [HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32TimeTimeProvidersNtpClient]
  55. "Enabled"=dword:00000001
  56. "InputProvider"=dword:00000001
  57. "AllowNonstandardModeCombinations"=dword:00000001
  58. "CrossSiteSyncFlags"=dword:00000002
  59. "ResolvePeerBackoffMinutes"=dword:0000000f
  60. "ResolvePeerBackoffMaxTimes"=dword:00000007
  61. "CompatibilityFlags"=dword:80000000
  62. "EventLogFlags"=dword:00000001
  63. "LargeSampleSkew"=dword:00000003
  64. "DllName"="C:\WINDOWS\system32\w32time.dll"
  65. "SpecialPollTimeRemaining"=hex(7):00,00
  66. "SpecialPollInterval"=dword:00000e10
  67. [HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32TimeTimeProvidersNtpServer]
  68. "InputProvider"=dword:00000000
  69. "AllowNonstandardModeCombinations"=dword:00000001
  70. "DllName"="C:\WINDOWS\system32\w32time.dll"
  71. "Enabled"=dword:00000001
  72. [HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32TimeEnum]
  73. "0"="Root\LEGACY_W32TIME\0000"
  74. "Count"=dword:00000001
  75. "NextInstance"=dword:00000001

Windows Registry Editor Version 5.00 [HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32Time] "Description"="维护在网络上的所有客户端和服务器的时间和日期同步。如果此服务被停止，时间和日期的同步将不可用。如果此服务被禁用，任何明确依赖它的服务都将不能启动。 " "DisplayName"="Windows Time" "ErrorControl"=dword:00000001 "FailureActions"=hex:05,00,00,00,00,00,00,00,00,00,00,00,02,00,00,00,64,00,20,  00,01,00,00,00,60,ea,00,00,01,00,00,00,60,ea,00,00 "Group"="" "ImagePath"=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,  74,00,25,00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,  00,76,00,63,00,68,00,6f,00,73,00,74,00,2e,00,65,00,78,00,65,00,20,00,2d,00,  6b,00,20,00,4c,00,6f,00,63,00,61,00,6c,00,53,00,65,00,72,00,76,00,69,00,63,  00,65,00,00,00 "Objectname"="NT AUTHORITY\LocalService" "Start"=dword:00000004 "Type"=dword:00000020 [HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32TimeConfig] "LastClockRate"=dword:0002625a "MinClockRate"=dword:000260d4 "MaxClockRate"=dword:000263e0 "FrequencyCorrectRate"=dword:00000004 "PollAdjustFactor"=dword:00000005 "LargePhaseOffset"=dword:02faf080 "SpikeWatchPeriod"=dword:00000384 "HoldPeriod"=dword:00000005 "LocalClockDispersion"=dword:0000000a "EventLogFlags"=dword:00000002 "PhaseCorrectRate"=dword:00000001 "MinPollInterval"=dword:0000000a "MaxPollInterval"=dword:0000000f "UpdateInterval"=dword:00057e40 "MaxNegPhaseCorrection"=dword:0000d2f0 "MaxPosPhaseCorrection"=dword:0000d2f0 "AnnounceFlags"=dword:00000005 "MaxAllowedPhaseOffset"=dword:00000001 [HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32TimeParameters] "ServiceMain"="SvchostEntry_W32Time" "ServiceDll"=hex(2):43,00,3a,00,5c,00,57,00,49,00,4e,00,44,00,4f,00,57,00,53,  00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,77,00,33,00,  32,00,74,00,69,00,6d,00,65,00,2e,00,64,00,6c,00,6c,00,00,00 "NtpServer"="192.168.12.31,0x1" "Type"="NTP" [HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32TimeSecurity] "Security"=hex:01,00,14,80,a8,00,00,00,b4,00,00,00,14,00,00,00,30,00,00,00,02,  00,1c,00,01,00,00,00,02,80,14,00,ff,01,0f,00,01,01,00,00,00,00,00,01,00,00,  00,00,02,00,78,00,05,00,00,00,00,00,14,00,8d,00,02,00,01,01,00,00,00,00,00,  05,0b,00,00,00,00,00,18,00,ff,01,0f,00,01,02,00,00,00,00,00,05,20,00,00,00,  20,02,00,00,00,00,18,00,8d,00,02,00,01,02,00,00,00,00,00,05,20,00,00,00,23,  02,00,00,00,00,14,00,9d,00,00,00,01,01,00,00,00,00,00,05,04,00,00,00,00,00,  18,00,9d,00,00,00,01,02,00,00,00,00,00,05,20,00,00,00,21,02,00,00,01,01,00,  00,00,00,00,05,12,00,00,00,01,01,00,00,00,00,00,05,12,00,00,00 [HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32TimeTimeProviders] [HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32TimeTimeProvidersNtpClient] "Enabled"=dword:00000001 "InputProvider"=dword:00000001 "AllowNonstandardModeCombinations"=dword:00000001 "CrossSiteSyncFlags"=dword:00000002 "ResolvePeerBackoffMinutes"=dword:0000000f "ResolvePeerBackoffMaxTimes"=dword:00000007 "CompatibilityFlags"=dword:80000000 "EventLogFlags"=dword:00000001 "LargeSampleSkew"=dword:00000003 "DllName"="C:\WINDOWS\system32\w32time.dll" "SpecialPollTimeRemaining"=hex(7):00,00 "SpecialPollInterval"=dword:00000e10 [HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32TimeTimeProvidersNtpServer] "InputProvider"=dword:00000000 "AllowNonstandardModeCombinations"=dword:00000001 "DllName"="C:\WINDOWS\system32\w32time.dll" "Enabled"=dword:00000001 [HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32TimeEnum] "0"="Root\LEGACY_W32TIME\0000" "Count"=dword:00000001 "NextInstance"=dword:00000001   

将以上脚本另存为ntp.reg, 192.168.12.31修改为你要的ntp服务器地址，然后导入。

 

**Windows** **ntp客户端配置**

除标准时钟服务器外，其它的Windows 平台都作为客户端，不需要安装程序，只作注册表配置。导入压缩包里的注册表ntp.reg ，打开注册表，根据需要做以下修改：

1 ．如果导入前没有修改ntp地址，则必须进入注册表编辑如下键值

**HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32TimeParametersNtpServer**

这一项是设置标准时钟源IP 地址的。将192.168.12.31 替换为选定的时钟服务器的IP 地址，后面的,0x1 留着不要改。

2 ．（根据需要更改）

**HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32TimeTimeProvidersNtpClientSpecialPollInterval**

这一项是设置客户端向服务器同步的轮询间隔，单位为秒，默认设为1 小时，可根据需要做修改。

3 ．（ 根据需要更改 ）

**HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32TimeConfigMaxPosPhaseCorrection**

这一项是设置最大的正时间校准量，单位为秒，默认设为15 小时，可根据需要修改。

4 ．（ 根据需要更改）

**HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesW32TimeConfigMaxNegPhaseCorrection **

这一项是设置最大的负时间校准量，单位为秒，默认设为15 小时，可根据需要修改。

5 ． 退出注册表编辑器。  

6 ．在命令提示符处，键入以下命令以重新启动 Windows  时间服务，然后按 Enter ：  

net stop w32time && net start w32time

也可以到系统的服务里找到windows time服务，重启该服务。对集群服务器，会引起集群服务的关闭。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=0d67a62a-36e5-80c9-8d10-b3003fd30e78)
