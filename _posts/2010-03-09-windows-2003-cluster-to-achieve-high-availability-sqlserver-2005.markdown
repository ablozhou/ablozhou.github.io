---
author: abloz
comments: true
date: 2010-03-09 06:05:00+00:00
layout: post
link: http://abloz.com/index.php/2010/03/09/windows-2003-cluster-to-achieve-high-availability-sqlserver-2005/
slug: windows-2003-cluster-to-achieve-high-availability-sqlserver-2005
title: Windows 2003 上实现Sqlserver 2005 群集高可用性
wordpress_id: 1153
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) / 文

[http://blog.csdn.net/ablo_zhou](http://blog.csdn.net/ablo_zhou)

2010.3.9

# 需求：

需要实现SQLServer 2005 数据库的高可用性，实现双机热备。

1. 安装SQLServer 2005 的设备实现双击热备。一台失效另一台能立即启用。无额外的域控制器和DNS 服务器。

2. 数据库数据实现Raid5 ，保证一块硬盘损坏不会丢失数据。

3. 操作系统群集对外一个统一IP 地址

4.Sqlserver 群集对外一个统一的IP 地址。

# 基本步骤：

1. 准备硬件，做好磁盘阵列的物理连接

2. 规划系统

3. 安装操作系统

4. 安装操作系统群集

5. 测试群集的可用性

6. 安装sqlserver

7. 测试sqlserver 可用性

# 硬件准备 ：

IBM eserver 346 服务器主，73GB 硬盘，4GB 内存，两块千兆自适应网卡

IBM eserver 346 服务器备，73GB 硬盘，4GB 内存，两块千兆自适应网卡

一台磁盘阵列，含3 块146GB 的硬盘，已经由厂方实现raid5 ，总容量270GB

将磁盘阵列和两台服务器的数据线连接好，可能是数据线或网线。

网线连接，外网的网卡连外网网络，内网的可以采用hub ，交换机或直接用直连线相连（两台）

# 规划系统IP ：

<table cellpadding="4" cellspacing="0" style="page-break-before: always; width: 100%;" border="1" > 	 	 	 		 <tr valign="TOP" >    
			

外网（pub)

			

内网(heartbeat)

		 </tr> 	 <tbody > <tr valign="TOP" >
<td width="24%" >

主服务器(dbmain)

</td>
<td width="44%" >

192.168.0.1/255.255.255.0

gateway ：192.168.0.10 				( 根据实际情况）

dns:192.168.0.1

  
</td>
<td width="33%" >

10.1.0.1/255.0.0.0

gateway 和dns 都不设

</td> </tr> <tr valign="TOP" >
<td width="24%" >

备服务器(dbback)

</td>
<td width="44%" >

192.168.0.2/255.255.255.0

gateway ：192.168.0.10 				( 根据实际情况）

dns:192.168.0.2

dns:192.168.0.1 ( 配两个）

</td>
<td width="33%" >

10.1.0.2

gateway 和dns 都不设

</td> </tr> <tr valign="TOP" >
<td width="24%" >

群集

</td>
<td width="44%" >

192.168.0.100

</td>
<td width="33%" >    

</td> </tr> <tr valign="TOP" >
<td width="24%" >

数据库

</td>
<td width="44%" >

192.168.0.200

</td>
<td width="33%" >    

</td> </tr> </tbody> </table>

# 安装操作系统 ：

先给其中一台装windows 2003 enterprise server 操作系统，打好补丁。

安装IIS ，消息队列，DNS ，网络DTC ，COM+ 服务，msdtc(distribute transaction coordinator 分布式事务协调器）,WMI （windows management instrument).  后三者应该是缺省安装。在服务中检查各服务是否正常。并将其设为自动启动。重启检查各服务是否正常。

将计算机更名为dbmain. 配置IP 地址。网卡连接心跳网卡改名为heartbeat, 外网改为pub.

这是一台干净的操作系统。

将该硬盘ghost 出来备份，用于安装更多操作系统。

另一台操作系统可以采用ghost 方式安装，直接硬盘对拷，节省时间，减少出错。

重启后修改IP/DNS ，计算机名为dbback

# 安装域：

在dbmain 服务器，win+r 运行里输入dcpromo 进行域管理器提升。创建新域。域设定为mydb.adomain.com  由于dns 不会解析外网域名，所以随便配置域名。全部缺省。

最好规划出域管理员帐号密码，数据库及相关服务运行帐号密码，安全组等。我这里偷懒全部用的是域管理员帐号。但会有安全隐患。

重启。

在dbback 运行dcpromo ，但选择额外域控制器控制已存在域。重启。

检查域名解析是否正常。在管理工具里有DNS ，检查是否有记录，是否正常。

# 挂载磁盘阵列：

两台服务器进行同样操作。在磁盘管理里，将原磁盘阵列分配驱动器，格式化。规划上可以将磁盘阵列规划为仲裁盘quorum 1GB,msdtc 盘5GB,Sqlserver 数据盘。但我没有区分，只分了一个区db(F:) 。但安装时系统强烈建议将仲裁盘和数据盘分在不同分区。

测试磁盘阵列是否可以读写。

# 安装群集 ：

在dbmain 的管理工具里，找到群集管理器，创建新群集。群集名dbgroup, 配IP 192.168.0.100 ，配置完毕可以用dbgroup.mydb.adomain.com 访问.

在dbback 的管理工具里，找到群集管理器，选打开现有群集。输入dbgroup.mydb.adomain.com 。打开。应该和dbmain 看到的一致。

通过ping dbgroup.mydb.adomain.com 应该可以看到 192.168.0.100 可以ping 通。

检查msdtc,wmi,com+ 服务是否正常启动。

在群集管理器里可以看到dbmain,dbback 的资源。只有一台可用。包括磁盘阵列，也只有一台可以访问。

此时需反复重启主备服务器，看群集管理是否能顺利切换。

在群集管理器里，新建msdtc 资源组，将IP 地址，网络名称，msdtc 资源加入。

此时需反复重启主备服务器，看群集管理是否能顺利切换。如msdtc 启动不了，检查启动网络dtc 访问是否安装。两台服务器只有一台可以启动msdtc 服务。可能需要在“服务”里配置服务重启的次数和时间间隔。服务切换需要一定时间。期间还会有假死现象。

最好在此时再给两台服务器做一个ghost. 否则可能随后安装sqlserver 不顺利的话，导致操作系统重装。

# 安装数据库

在dbmain 控制资源后，在这一台上安装sqlserver 2005 ，会同时安装到dbback 。

确认没有错误和警告。数据库群集命名为db, Ip 为192.168.0.200 ，可以通过db.mydb.adomain.com 进行访问。

向导全部用缺省。远程安装账户选用域管理员。数据库群集服务域组全部用系统域管理员组。当然，最好是做好域组的分工。这种笼统的管理虽然方便，但也会埋下隐患。

身份验证，选择混合模式。

数据库数据库放在F 盘。仲裁也放F 盘。如果有警告，忽略。

打数据库补丁。

再反复重启测试，看是否能正确切换。如无问题，则sqlserver2005  高科用性和热备安装完毕。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=46cd5757-1f30-800c-805a-cfa3a8af67a4)
