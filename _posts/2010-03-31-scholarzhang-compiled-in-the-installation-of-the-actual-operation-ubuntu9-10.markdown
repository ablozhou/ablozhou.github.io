---
author: abloz
comments: true
date: 2010-03-31 07:05:00+00:00
layout: post
link: http://abloz.com/index.php/2010/03/31/scholarzhang-compiled-in-the-installation-of-the-actual-operation-ubuntu9-10/
slug: scholarzhang-compiled-in-the-installation-of-the-actual-operation-ubuntu9-10
title: scholarzhang在ubuntu9.10下编译安装实际操作
wordpress_id: 1187
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

 下载源码：  
xxx@yyy:~/svn checkout http://scholarzhang.googlecode.com/svn/trunk/ scholarzhang-read-only  
  
环境  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ iptables --version  
iptables v1.4.4  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ uname -a  
Linux zhh64 2.6.31-20-generic #58-Ubuntu SMP Fri Mar 12 04:38:19 UTC 2010 x86_64 GNU/Linux  
  
编译：  
需要下载安装autoconf,automake,libtool  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ ./autogen.sh   
./autogen.sh: line 3: autoreconf：找不到命令  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ autoconf  
程序“autoconf”已包含在下列软件包中：  
* autoconf  
* autoconf2.13  
请尝试：sudo apt-get install <选定的软件包>  
autoconf: command not found  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ sudo apt-get install autoconf  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ ./autogen.sh   
Can't exec "libtoolize": 没有那个文件或目录 at /usr/bin/autoreconf line 190.  
Use of uninitialized value $libtoolize in pattern match (m//) at /usr/bin/autoreconf line 190.  
configure.ac:9: error: possibly undefined macro: AC_DISABLE_STATIC  
If this token and others are legitimate, please use m4_pattern_allow.  
See the Autoconf documentation.  
configure.ac:10: error: possibly undefined macro: AC_PROG_LIBTOOL  
autoreconf: /usr/bin/autoconf failed with exit status: 1  
  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ sudo apt-get install libtool  
将会安装下列额外的软件包：  
libltdl-dev  
建议安装的软件包：  
libtool-doc gfortran fortran95-compiler gcj  
下列【新】软件包将被安装：  
libltdl-dev libtool  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ ./autogen.sh   
libtoolize: putting auxiliary files in `.'.  
libtoolize: copying file `./config.guess'  
libtoolize: copying file `./config.sub'  
libtoolize: copying file `./install-sh'  
libtoolize: copying file `./ltmain.sh'  
libtoolize: putting macros in AC_CONFIG_MACRO_DIR, `m4'.  
libtoolize: copying file `m4/libtool.m4'  
libtoolize: copying file `m4/ltoptions.m4'  
libtoolize: copying file `m4/ltsugar.m4'  
libtoolize: copying file `m4/ltversion.m4'  
libtoolize: copying file `m4/lt~obsolete.m4'  
configure.ac:8: installing `./compile'  
configure.ac:6: installing `./missing'  
extensions/ipset/Makefile.am: installing `./depcomp'  
  
configure不加参数，没有看到报错。make和make install也没看到错误。但在增加iptables时发现没有ZHANG这条规则  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ ./configure  
...  
checking for libxtables... configure: error: Package requirements (xtables >= 1.4.3) were not met:  
No package 'xtables' found  
  
Consider adjusting the PKG_CONFIG_PATH environment variable if you  
installed software in a non-standard prefix.  
  
Alternatively, you may set the environment variables libxtables_CFLAGS  
and libxtables_LIBS to avoid the need to call pkg-config.  
See the pkg-config man page for more details.  
  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ sudo apt-cache search xtables  
iptables-dev - iptables development files  
xtables-addons-common - Userspace components of xtables-addons  
xtables-addons-source - Source for the xtables-addons driver  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ sudo apt-get install iptables-dev  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ ./configure  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ make  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ sudo make install  
无报错  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ sudo ipset -R  
-N YOUTUBE nethash --hashsize 50 --probes 1  
-A YOUTUBE 64.15.112.0/20  
-A YOUTUBE 82.129.37.0/24  
-A YOUTUBE 208.65.152.0/22  
-A YOUTUBE 208.117.224.0/19  
-A YOUTUBE 213.146.171.0/24  
COMMIT  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ sudo ipset -R  
-N NOCLIP setlist --size 4  
-A NOCLIP GOOGLE  
-A NOCLIP YOUTUBE  
COMMIT  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ sudo iptables   
> -A INPUT   
> -p tcp --sport 80 --tcp-flags FIN,SYN,RST,ACK SYN,ACK   
> -m state --state ESTABLISHED   
> -m set --match-set NOCLIP src   
> -j ZHANG   
> -m comment --comment "client-side connection obfuscation"  
iptables v1.4.4: Couldn't load target  `ZHANG':/lib/xtables/libipt_ZHANG.so: cannot open shared object file: No such file or directory  
  
根据INSTALL说明重新configure  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ ./configure CFLAGS="" --prefix=/usr --libexecdir=/lib  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ make  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ sudo make install  
没有报错。  
检查一下安装生成的文件，都存在：  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ ls /lib/xtables/ -tl  
总用量 1272  
-rwxr-xr-x 1 root root 13605 2010-03-31 10:24 libipset_setlist.so  
-rwxr-xr-x 1 root root 13367 2010-03-31 10:24 libipset_portmap.so  
-rwxr-xr-x 1 root root 13606 2010-03-31 10:24 libipset_nethash.so  
-rwxr-xr-x 1 root root 13895 2010-03-31 10:24 libipset_macipmap.so  
-rwxr-xr-x 1 root root 13657 2010-03-31 10:24 libipset_iptreemap.so  
-rwxr-xr-x 1 root root 13578 2010-03-31 10:24 libipset_iptree.so  
-rwxr-xr-x 1 root root 18127 2010-03-31 10:24 libipset_ipportnethash.so  
-rwxr-xr-x 1 root root 17955 2010-03-31 10:24 libipset_ipportiphash.so  
-rwxr-xr-x 1 root root 13833 2010-03-31 10:24 libipset_ipporthash.so  
-rwxr-xr-x 1 root root 13610 2010-03-31 10:24 libipset_ipmap.so  
-rwxr-xr-x 1 root root 13404 2010-03-31 10:24 libipset_iphash.so  
-rwxr-xr-x 1 root root 8308 2010-03-31 10:24 libxt_gfw.so  
-rwxr-xr-x 1 root root 8324 2010-03-31 10:24 libxt_ZHANG.so  
-rwxr-xr-x 1 root root 8314 2010-03-31 10:24 libxt_CUI.so  
  
再根据USAGE来配置：  
1.ZHANG 客户端连接混乱  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ sudo iptables -A INPUT -p tcp --sport 80 --tcp-flags FIN,SYN,RST,ACK SYN,ACK -m state --state  ESTABLISHED -m set --match-set NOCLIP src -j ZHANG -m comment --comment  "client-side connection obfuscation"  
2.CUI 服务器端连接混乱  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ sudo iptables -A INPUT -p tcp --dport 80 --tcp-flags FIN,SYN,RST,ACK SYN -m state --state NEW -m  set --match-set CHINA src -j CUI -m comment --comment "server-side  connection obfuscation"  
iptables v1.4.4: Set CHINA doesn't exist.  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ sudo ipset -R < ./examples/CHINA  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ sudo iptables -A INPUT -p tcp --dport 80 --tcp-flags FIN,SYN,RST,ACK SYN -m state --state NEW -m  set --match-set CHINA src -j CUI -m comment --comment "server-side  connection obfuscation"  
3.记录gfw reset到syslog  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ sudo iptables -A INPUT -p tcp --sport 80 -m state --state ESTABLISHED -m gfw -j LOG --log-level  info --log-prefix "gfw: " -m comment --comment "log gfw tcp resets"  
4.反GFW DNS劫持  
可以直接修改/etc/resolve.conf  
增加nameserver 8.8.8.8  
或修改dhclient.conf:  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ sudo vi /etc/dhcp3/dhclient.conf  
找到prepend domain-name-servers，去掉注释，并将8.8.8.8等墙外dns放在后面  
让dhclient生效：ifconfig eth0 down; ifconfig eth0 up  
  
保存iptables成果：  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ sudo iptables-save > /etc/iptables.up.rules  
bash: /etc/iptables.up.rules: 权限不够  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ sudo -s  
root@zhh64:~/scholarzhang-read-only/west-chamber# iptables-save > /etc/iptables.up.rules  
root@zhh64:~/scholarzhang-read-only/west-chamber# exit  
exit  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ sudo vi /etc/network/interfaces   
增加：  
pre-up iptables-restore < /etc/iptables.up.rules  
这样重启系统后防火墙还能生效。  
  
检测：  
xxx@yyy:~/scholarzhang-read-only/west-chamber$ host -tA twitter.com  
twitter.com has address 93.46.8.89  
  


![](http://img.zemanta.com/pixy.gif?x-id=9f9bbb1b-bdee-847f-8137-f619921c9aef)
