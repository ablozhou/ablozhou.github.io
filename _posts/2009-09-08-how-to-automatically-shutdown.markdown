---
author: abloz
comments: true
date: 2009-09-08 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/09/08/how-to-automatically-shutdown/
slug: how-to-automatically-shutdown
title: 如何自动关机
wordpress_id: 929
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou)/文 2009.9.8

[http://blog.csdn.net/ablo_zhou](http://blog.csdn.net/ablo_zhou)

ablozhou#gmail.com

  

摘要：Windows 系统和Linux 系统某些情况下都需要计划中的自动关机。本文介绍定时自动关机的相关方法和命令。

 

我们公司的机房比较特殊，空调没有排水的地方，所以必须人工排水，就是拿一大水桶装水，定期舀空。所以晚上和周末必须关机关空调。早上再开。下面是比较常用的windows和linux的定期关机方法。

 

1. Linux机器

Linux机器使用crontab实现自动关机。对不太了解linux的，可以用root账号在命令行执行下面的代码：

[](http://blog.csdn.net/ablo_zhou/archive/2009/09/08/4530880.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2009/09/08/4530880.aspx#)

  1. (crontab -l ; echo "0 19 * * * /sbin/init 0") | crontab

(crontab -l ; echo "0 19 * * * /sbin/init 0")  | crontab 

实现的是到晚上19点linux自动关机。该命令的意思是先列出crontab的内容，再将19点关机的命令补充后一起放到crontab里。

1.1 crontab的用法

[](http://blog.csdn.net/ablo_zhou/archive/2009/09/08/4530880.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2009/09/08/4530880.aspx#)

  1. 使用方式 :
  2. crontab [ -u user ] file
  3. crontab [-u user] [-l | -r | -e][-i] [-s]
  4. ----------------------
  5. -u user 用户下的crontab，缺省当前用户。Linux每个用户可以有自己的crontab。
  6. file 用指定文件替换当前crontab
  7. -l : 列出用户crontab内容
  8. -r : 删除crontab
  9. -e : 编辑crontab
  10. -i : 配合-r 删除时会有确认信息
  11. -s : 安全模式
  12.   13. 时程表的格式如下 :
  14. f1 f2 f3 f4 f5 program
  15. 分钟 小时 月份中的第几日 月份 星期中的第几天 要执行的程序。
  16.   17. 当 f1 为 * 时表示每分钟都要执行 program，f2 为 * 时表示每小时都要执行程序，其余类推
  18. 当 f1 为 a-b 时表示从第 a 分钟到第 b 分钟这段时间内要执行，f2 为 a-b 时表示从第 a 到第 b 小时都要执行，其余类推
  19. 当 f1 为 */n 时表示每 n 分钟个时间间隔执行一次，f2 为 */n 表示每 n 小时个时间间隔执行一次，其余类推
  20. 当 f1 为 a, b, c,... 时表示第 a, b, c,... 分钟要执行，f2 为 a, b, c,... 时表示第 a, b, c...个小时要执行，其余类推
  21. 使用者也可以将所有的设定先存放在档案 file 中，用 crontab file 的方式来设定时程表。
  22.   23. 例：
  24. 每晚19点关机
  25. #crontab -e
  26. 0 19 * * * /sbin/init 0
  27. 每周1-5 的18：30 备份
  28. 30 18 * * 1-5 /root/backup
  29. 每个月下旬3天清一次log
  30. * * 20-31/3 * * rm -f /var/log/messages
  31.   32. 如果发现crontab 不按设想的执行，请检查脚本和命令是否正确，是否有权限执行，路径和环境变量是否正确。echo 之类的命令并不会输出到屏幕上。

使用方式 :  crontab [ -u user ] file  crontab [-u user] [-l | -r | -e][-i] [-s] ---------------------- -u user 用户下的crontab，缺省当前用户。Linux每个用户可以有自己的crontab。 file 用指定文件替换当前crontab -l : 列出用户crontab内容 -r : 删除crontab -e : 编辑crontab -i : 配合-r 删除时会有确认信息 -s : 安全模式  时程表的格式如下 :  f1        f2              f3           f4         f5                 program  分钟   小时  月份中的第几日  月份  星期中的第几天  要执行的程序。  当 f1 为 * 时表示每分钟都要执行 program，f2 为 * 时表示每小时都要执行程序，其余类推  当 f1 为 a-b 时表示从第 a 分钟到第 b 分钟这段时间内要执行，f2 为 a-b 时表示从第 a 到第 b 小时都要执行，其余类推  当 f1 为 */n 时表示每 n 分钟个时间间隔执行一次，f2 为 */n 表示每 n 小时个时间间隔执行一次，其余类推  当 f1 为 a, b, c,... 时表示第 a, b, c,... 分钟要执行，f2 为 a, b, c,... 时表示第 a, b, c...个小时要执行，其余类推  使用者也可以将所有的设定先存放在档案 file 中，用 crontab file 的方式来设定时程表。  例： 每晚19点关机 #crontab -e 0 19 * * * /sbin/init 0 每周1-5 的18：30 备份 30 18 * * 1-5 /root/backup 每个月下旬3天清一次log * * 20-31/3 * * rm -f /var/log/messages  如果发现crontab 不按设想的执行，请检查脚本和命令是否正确，是否有权限执行，路径和环境变量是否正确。echo 之类的命令并不会输出到屏幕上。  

2 Windows

windows可以用任务计划和at命令来完成定时关机和定时执行任务。

2.1 shutdown 命令

在命令行下，可以执行shutdown命令来关机。

shutd
own用法：

[](http://blog.csdn.net/ablo_zhou/archive/2009/09/08/4530880.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2009/09/08/4530880.aspx#)

  1. C:Documents and Settingszhouhh>shutdown /?
  2. 用法: shutdown [-i | -l | -s | -r | -a] [-f] [-m \computername] [-t xx] [-c "co
  3. mment"] [-d up:xx:yy]
  4.   5. 没有参数 显示此消息(与 ? 相同)
  6. -i 显示 GUI 界面，必须是第一个选项
  7. -l 注销(不能与选项 -m 一起使用)
  8. -s 关闭此计算机
  9. -r 关闭并重启动此计算机
  10. -a 放弃系统关机
  11. -m \computername 远程计算机关机/重启动/放弃
  12. -t xx 设置关闭的超时为 xx 秒
  13. -c "comment" 关闭注释(最大 127 个字符)
  14. -f 强制运行的应用程序关闭而没有警告
  15. -d [u][p]:xx:yy 关闭原因代码
  16. u 是用户代码
  17. p 是一个计划的关闭代码
  18. xx 是一个主要原因代码(小于 256 的正整数)
  19. yy 是一个次要原因代码(小于 65536 的正整数)

C:Documents and Settingszhouhh>shutdown /? 用法: shutdown [-i | -l | -s | -r | -a] [-f] [-m \computername] [-t xx] [-c "co mment"] [-d up:xx:yy]         没有参数                显示此消息(与 ? 相同)        -i                      显示 GUI 界面，必须是第一个选项        -l                      注销(不能与选项 -m 一起使用)        -s                      关闭此计算机        -r                      关闭并重启动此计算机        -a                      放弃系统关机        -m \computername       远程计算机关机/重启动/放弃        -t xx                   设置关闭的超时为 xx 秒        -c "comment"            关闭注释(最大 127 个字符)        -f                      强制运行的应用程序关闭而没有警告        -d [u][p]:xx:yy         关闭原因代码                                u 是用户代码                                p 是一个计划的关闭代码                                xx 是一个主要原因代码(小于 256 的正整数)                                yy 是一个次要原因代码(小于 65536 的正整数)   

2.2 任务计划

windows 2000/xp/2003/vista/7 控制面板里面有任务计划。也可以通过开始菜单-所有程序-附件-系统工具-任务计划找到。点击添加任务计划，找到windows/system32/shutdown.exe

在命令行中添加 shutdown -s，一步一步选好时间计划。

但任务计划有可能没有启动。在命令行下执行

net start

查找是否有“Task Scheduler”

没有则执行

net start "Task Scheduler"

 

2.3 at 命令

at命令是定时执行命令的调度程序，也需用net start检查任务计划是否启动，没有启动需启动。

at用法：

[](http://blog.csdn.net/ablo_zhou/archive/2009/09/08/4530880.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2009/09/08/4530880.aspx#)

  1. C:Documents and Settingszhouhh>at /?
  2. AT 命令安排在特定日期和时间运行命令和程序。
  3. 要使用 AT 命令，计划服务必须已在运行中。
  4.   5. AT [\computername] [ [id] [/DELETE] | /DELETE [/YES]]
  6. AT [\computername] time [/INTERACTIVE]
  7. [ /EVERY:date[,...] | /NEXT:date[,...]] "command"
  8.   9. \computername 指定远程计算机。 如果省略这个参数，
  10. 会计划在本地计算机上运行命令。
  11. id 指定给已计划命令的识别号。 <
/span>
  12. /delete 删除某个已计划的命令。如果省略 id，
  13. 计算机上所有已计划的命令都会被删除。
  14. /yes 不需要进一步确认时，跟删除所有作业
  15. 的命令一起使用。
  16. time 指定运行命令的时间。
  17. /interactive 允许作业在运行时，与当时登录的用户
  18. 桌面进行交互。
  19. /every:date[,...] 每个月或每个星期在指定的日期运行命
  20. 令。如果省略日期，则默认为在每月的
  21. 本日运行。
  22. /next:date[,...] 指定在下一个指定日期(如，下周四)运
  23. 行命令。如果省略日期，则默认为在每
  24. 月的本日运行。
  25. "command" 准备运行的 Windows NT 命令或批处理
  26. 程序。

C:Documents and Settingszhouhh>at /? AT 命令安排在特定日期和时间运行命令和程序。 要使用 AT 命令，计划服务必须已在运行中。  AT [\computername] [ [id] [/DELETE] | /DELETE [/YES]] AT [\computername] time [/INTERACTIVE]    [ /EVERY:date[,...] | /NEXT:date[,...]] "command"  \computername       指定远程计算机。 如果省略这个参数，                     会计划在本地计算机上运行命令。 id                   指定给已计划命令的识别号。 /delete              删除某个已计划的命令。如果省略 id，                     计算机上所有已计划的命令都会被删除。 /yes                 不需要进一步确认时，跟删除所有作业                     的命令一起使用。 time                 指定运行命令的时间。 /interactive         允许作业在运行时，与当时登录的用户                     桌面进行交互。 /every:date[,...]    每个月或每个星期在指定的日期运行命                     令。如果省略日期，则默认为在每月的                     本日运行。 /next:date[,...]     指定在下一个指定日期(如，下周四)运                     行命令。如果省略日期，则默认为在每                     月的本日运行。 "command"            准备运行的 Windows NT 命令或批处理                     程序。   

at 示例：

* 在晚上19点关机

** at 19:00 shudown -s**

* 要想在午夜将“Documents”文件夹中的所有文件复制到“MyDocs”文件夹中，请键入下面一行，然后按 Enter： 

at 00:00 cmd /c copy C:Documents*.* C:MyDocs

* 要想在每个工作日晚上 11:00 备份“Products”服务器，请创建包含备份命令的批处理文件（例如 Backup.bat），键入下面一行，然后按 Enter 安排该备份任务： 

at \products 23:00 /every:M,T,W,Th,F backup

* 要想安排 **net share** 命令上午 6:00 在“Sales”服务器上运行，并将列表重定向到“Corp”服务器上的共享文件夹“Reports”中的“Sales.txt”文件，请键入下面一行，然后按 Enter： 

at \sales 06:00 cmd /c "net share reports=d:Documentsreports >> \corpreportssales.txt"

查看已有计划：

[](http://blog.csdn.net/ablo_zhou/archive/2009/09/08/4530880.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2009/09/08/4530880.aspx#)

  1. C:Documents and Settingszhouhh>at
  2. 状态 ID 日期 时间 命令行
  3. ------------------------------------------------------------------------------
  4. 1 明天 10:30 notepad.exe
  5. 2 今天 10:31 shutdown -i

C:Documents and Settingszhouhh>at 状态 ID     日期                    时间          命令行 ------------------------------------------------------------------------------        1   明天                    10:30         notepad.exe        2   今天                    10:31         shutdown -i 

删除计划：

at 1 /delete

  
  


![](http://img.zemanta.com/pixy.gif?x-id=f57700b5-8afb-826f-9e15-ee32d0496d0d)
