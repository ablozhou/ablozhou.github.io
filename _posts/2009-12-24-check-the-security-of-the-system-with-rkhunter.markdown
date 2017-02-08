---
author: abloz
comments: true
date: 2009-12-24 06:41:00+00:00
layout: post
link: http://abloz.com/index.php/2009/12/24/check-the-security-of-the-system-with-rkhunter/
slug: check-the-security-of-the-system-with-rkhunter
title: 用rkhunter检查系统安全性
wordpress_id: 997
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou)  
/文

  
  


rkhunter是搜索本机漏洞以及查找是否有rootkit的程序。对关注安全的系统管理员很重要。

  
  


sudo apt-get install rkhunter

  
  


zhouhh@zhhofs:~$ sudo rkhunter --checkall  
  
[ Rootkit Hunter version 1.3.4 ]  
  
  
  
Checking system commands...  
  
  
  
Performing 'strings' command checks  
  
Checking 'strings' command [ OK ]  
  
  
  
Performing 'shared libraries' checks  
  
Checking for preloading variables [ None found ]  
  
Checking for preload file [ Not found ]  
  
Checking LD_LIBRARY_PATH variable [ Not found ]  
  
  
  
Performing file properties checks  
  
Checking for prerequisites [ OK ]  
  
/bin/bash [ OK ]  
  
/bin/cat [ OK ]  
  
/bin/chmod [ OK ]  
  
/bin/chown [ OK ]  
  
/bin/cp [ OK ]  
  
/bin/date [ OK ]  
  
/bin/df [ OK ]  
  
/bin/dmesg [ OK ]  
  
/bin/echo [ OK ]  
  
/bin/ed [ OK ]  
  
/bin/egrep [ OK ]  
  
/bin/fgrep [ OK ]  
  
/bin/fuser [ OK ]  
  
/bin/grep [ OK ]  
  
/bin/ip [ OK ]  
  
/bin/kill [ OK ]  
  
/bin/less [ OK ]  
  
/bin/login [ OK ]  
  
/bin/ls [ OK ]  
  
/bin/lsmod &nb;
sp; [ OK ]  
  
/bin/mktemp [ OK ]  
  
/bin/more [ OK ]  
  
/bin/mount [ OK ]  
  
/bin/mv [ OK ]  
  
/bin/netstat [ OK ]  
  
/bin/ps [ OK ]  
  
/bin/pwd [ OK ]  
  
/bin/readlink [ OK ]  
  
/bin/sed [ OK ]  
  
/bin/sh [ OK ]  
  
/bin/su [ OK ]  
  
/bin/touch [ OK ]  
  
/bin/uname [ OK ]  
  
/bin/which [ OK ]  
  
/bin/dash [ OK ]  
  
/usr/bin/awk [ OK ]  
  
/usr/bin/basename [ OK ]  
  
/usr/bin/chattr [ OK ]  
  
/usr/bin/curl [ OK ]  
  
/usr/bin/cut [ OK ]  
  
/usr/bin/diff [ OK ]  
  
/usr/bin/dirname [ OK ]  
  
/usr/bin/dpkg [ OK ]  
  
/usr/bin/dpkg-query [ OK ]  
  
/usr/bin/du [ OK ]  
  
/usr/bin/env [ OK ]  
  
/usr/bin/file [ OK ]  
  
/usr/bin/find [ OK ]  
  
/usr/bin/GET [ OK ]  
  
/usr/bin/groups [ OK ]  
  
/usr/bin/head [ OK ]  
  
/usr/bin/id [ OK ]  
  
/usr/bin/killall [ OK ]  
  
/usr/bin/last [ OK ]  
  
/usr/bin/lastlog [ OK ]  
  
/usr/bin/ldd [ OK ]  
  
/usr/bin/less [ OK ]  
  
/usr/bin/locate [ OK ]  
  
/usr/bin/logger [ OK ]  
  
/usr/bin/lsattr [ OK ]  
  
/usr/bin/lsof [ OK ]  
  
/usr/bin/mail [ OK ]  
  
/usr/bin/md5sum [ OK ]  
  
/usr/bin/mlocate [ OK ]  
  
/usr/bin/newgrp [ OK ]  
  
/usr/bin/passwd [ OK ]  
  
/usr/bin/perl [ OK ]  
  
/usr/bin/pstree [ OK ]  
  
/usr/bin/rkhunter [ OK ]  
  
/usr/bin/runcon [ OK ]  
  
/usr/bin/sha1sum [ OK ]  
  
/usr/bin/size [ OK ]  
  
/usr/bin/sort [ OK ]  
  
/usr/bin/stat [ OK ]  
  
/usr/bin/strace [ OK ]  
  
/usr/bin/strings [ OK ]  
  
/usr/bin/sudo [ OK ]  
  
/usr/bin/tail [ OK ]  
  
/usr/bin/test [ OK ]  
  
/usr/bin/top [ OK ]  
  
/usr/bin/touch [ OK ]  
  
/usr/bin/tr [ OK ]  
  
/usr/bin/uniq [ OK ]  
  
/usr/bin/users [ OK ]  
  
/usr/bin/vmstat [ OK ]  
  
/usr/bin/w [ OK ]  
  
/usr/bin/watch [ OK ]  
  
/usr/bin/wc [ OK ]  
  
/usr/bin/wget [ OK ]  
  
/usr/bin/whatis [ OK ]  
  
/usr/bin/whereis [ OK ]  
  
/usr/bin/which [ OK ]  
  
/usr/bin/who [ OK ]  
  
/usr/bin/whoami [ OK ]  
  
/usr/bin/mawk [ OK ]  
  
/usr/bin/lwp-request [ OK ]  
  
/usr/bin/w.procps [ OK ]  
  
/sbin/depmod [ OK ]  
  
/sbin/ifconfig 
[ OK ]  
  
/sbin/ifdown [ OK ]  
  
/sbin/ifup [ OK ]  
  
/sbin/init [ OK ]  
  
/sbin/insmod [ OK ]  
  
/sbin/ip [ OK ]  
  
/sbin/lsmod [ OK ]  
  
/sbin/modinfo [ OK ]  
  
/sbin/modprobe [ OK ]  
  
/sbin/rmmod [ OK ]  
  
/sbin/runlevel [ OK ]  
  
/sbin/sulogin [ OK ]  
  
/sbin/sysctl [ OK ]  
  
/usr/sbin/adduser [ OK ]  
  
/usr/sbin/chroot [ OK ]  
  
/usr/sbin/cron [ OK ]  
  
/usr/sbin/groupadd [ OK ]  
  
/usr/sbin/groupdel [ OK ]  
  
/usr/sbin/groupmod [ OK ]  
  
/usr/sbin/grpck [ OK ]  
  
/usr/sbin/nologin [ OK ]  
  
/usr/sbin/pwck [ OK ]  
  
/usr/sbin/rsyslogd [ OK ]  
  
/usr/sbin/tcpd [ OK ]  
  
/usr/sbin/unhide [ Warning ]  
  
/usr/sbin/useradd [ OK ]  
  
/usr/sbin/userdel [ OK ]  
  
/usr/sbin/usermod 
[ OK ]  
  
/usr/sbin/vipw [ OK ]  
  
/usr/sbin/unhide-linux26 [ Warning ]  
  
  
  
[Press <ENTER> to continue]  
  
  
  
  
  
Checking for rootkits...  
  
  
  
Performing check of known rootkit files and directories  
  
55808 Trojan - Variant A [ Not found ]  
  
ADM Worm [ Not found ]  
  
AjaKit Rootkit [ Not found ]  
  
aPa Kit [ Not found ]  
  
Apache Worm [ Not found ]  
  
Ambient (ark) Rootkit [ Not found ]  
  
Balaur Rootkit [ Not found ]  
  
BeastKit Rootkit [ Not found ]  
  
beX2 Rootkit [ Not found ]  
  
BOBKit Rootkit [ Not found ]  
  
CiNIK Worm (Slapper.B variant) [ Not found ]  
  
Danny-Boy's Abuse Kit [ Not found ]  
  
Devil RootKit [ Not found ]  
  
Dica-Kit Rootkit [ Not found ]  
  
Dreams Rootkit [ Not found ]  
  
Duarawkz Rootkit [ Not found ]  
  
Enye LKM [ Not found ]  
  
Flea Linux Rootkit [ Not found ]  
  
FreeBSD Rootkit [ Not found ]  
  
Fuck`it Rootkit [ Not found ]  
  
GasKit Rootkit [ Not found ]  
  
Heroin LKM [ Not found ]  
  
HjC Kit [ Not found ]  
  
ignoKit Rootkit [ Not found ]  
  
&nb;
sp; ImperalsS-FBRK Rootkit [ Not found ]  
  
IntoXonia-NG Rootkit [ Not found ]  
  
Irix Rootkit [ Not found ]  
  
Kitko Rootkit [ Not found ]  
  
Knark Rootkit [ Not found ]  
  
Li0n Worm [ Not found ]  
  
Lockit / LJK2 Rootkit [ Not found ]  
  
Mood-NT Rootkit [ Not found ]  
  
MRK Rootkit [ Not found ]  
  
Ni0 Rootkit [ Not found ]  
  
Ohhara Rootkit [ Not found ]  
  
Optic Kit (Tux) Worm [ Not found ]  
  
Oz Rootkit [ Not found ]  
  
Phalanx Rootkit [ Not found ]  
  
Phalanx Rootkit (strings) [ Not found ]  
  
Phalanx2 Rootkit [ Not found ]  
  
Phalanx2 Rootkit (extended tests) [ Not found ]  
  
Portacelo Rootkit [ Not found ]  
  
R3dstorm Toolkit [ Not found ]  
  
RH-Sharpe's Rootkit [ Not found ]  
  
RSHA's Rootkit [ Not found ]  
  
Scalper Worm [ Not found ]  
  
Sebek LKM [ Not found ]  
  
Shutdown Rootkit [ Not found ]  
  
SHV4 Rootkit [ Not found ]  
  
SHV5 Rootkit [ Not found ]  
  
Sin Rootkit [ Not found ]  
  
Slapper Worm [ Not found ]  
  
Sneakin Rootkit [ Not found ]  
  
Suckit Rootkit [ Not found ]  
  
SunOS Rootkit [ Not found ]  
  
SunOS / NSDAP Rootkit [ Not found ]  
  
Superkit Rootkit [ Not found ]  
  
TBD (Telnet BackDoor) [ Not found ]  
  
TeLeKiT Rootkit [ Not found ]  
  
T0rn Rootkit [ Not found ]  
  
Trojanit Kit [ Not found ]  
  
Tuxtendo Rootkit [ Not found ]  
  
URK Rootkit [ Not found ]  
  
Vampire Rootkit [ Not found ]  
  
VcKit Rootkit [ Not found ]  
  
Volc Rootkit [ Not found ]  
  
X-Org SunOS Rootkit [ Not found ]  
  
zaRwT.KiT Rootkit [ Not found ]  
  
  
  
Performing additional rootkit checks  
  
Suckit Rookit additional checks [ OK ]  
  
Checking for possible rootkit files and directories [ None found ]  
  
Checking for possible rootkit strings [ None found ]  
  
  
  
Performing malware checks  
  
Checking running processes for suspicious files [ None found ]  
  
Checking for login backdoors [ None found ]  
  
Checking for suspicious directories [ None found ]  
  
Checking for sniffer log files [ None found ]  
  
  
  
Performing trojan specific checks  
  
Checking for enabled inetd services [ OK ]  
  
  
  
Performing Linux specific checks  
  
Checking loaded kernel modules [ OK ]  
  
Checking kernel module names [ OK ]  
  
  
  
[Press <ENTER> to continue]  
  
  
  
Checking the network...  
  
  
  
Performing check for backdoor ports  
  
Checking for UDP port 2001 [ Not found ]  
  
Checking for TCP port 2006 [ Not found ]  
  
Checking for
 TCP port 2128 [ Not found ]  
  
Checking for TCP port 14856 [ Not found ]  
  
Checking for TCP port 47107 [ Not found ]  
  
Checking for TCP port 60922 [ Not found ]  
  
  
  
Performing checks on the network interfaces  
  
Checking for promiscuous interfaces [ None found ]  
  
  
  
[Press <ENTER> to continue]

  
  


Checking the local host...  
  
  
  
Performing system boot checks  
  
Checking for local host name [ Found ]  
  
Checking for system startup files [ Found ]  
  
Checking system startup files for malware [ None found ]  
  
  
  
Performing group and account checks  
  
Checking for passwd file [ Found ]  
  
Checking for root equivalent (UID 0) accounts [ None found ]  
  
Checking for passwordless accounts [ None found ]  
  
Checking for passwd file changes [ None found ]  
  
Checking for group file changes [ None found ]  
  
Checking root account shell history files [ OK ]  
  
  
  
Performing system configuration file checks  
  
Checking for SSH configuration file [ Not found ]  
  
Checking for running syslog daemon [ Found ]  
  
Checking for syslog configuration file [ Found ]  
  
Checking if syslog remote logging is allowed [ Not allowed ]  
  
  
  
Performing filesystem checks  
  
Checking /dev for suspicious file types [ Warning ]  
  
Checking for hidden files and directories [ Warning ]  
  
  
  
[Press <ENTER> to continue]

  
  


Checking application versions...  
  
  
  
Checking version of Exim MTA [ OK ]  
  
Checking version of GnuPG [ OK ]  
  
Checking version of OpenSSL [ OK ]  
  
  
  
  
  
System checks summary  
  
=====================  
  
  
  
File properties checks...  
  
Files checked: 128  
  
Suspect files: 2  
  
  
  
Rootkit checks...  
  
Rootkits checked : 111  
  
Possible rootkits: 0  
  
  
  
Applications checks...  
  
Applications checked: 3  
  
Suspect applications: 0  
  
  
  
The system checks took: 7 minutes and 25 seconds  
  
  
  
All results have been written to the logfile (/var/log/rkhunter.log)  
  
  
  
One or more warnings have been found while checking the system.  
  
Please check the log file (/var/log/rkhunter.log)

  


我的系统还是比较安全的。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=cb71bd1e-defa-88c3-a3bd-2cc8cede978b)
