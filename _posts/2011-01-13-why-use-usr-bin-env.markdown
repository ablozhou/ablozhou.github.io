---
author: abloz
comments: true
date: 2011-01-13 03:48:01+00:00
layout: post
link: http://abloz.com/index.php/2011/01/13/why-use-usr-bin-env/
slug: why-use-usr-bin-env
title: 为何用/usr/bin/env
wordpress_id: 1123
categories:
- 技术
tags:
- env
- zimbu
---

from : http://abloz.com
周海汉 2010.1.13

在linux的一些bash的脚本，需在开头一行指定脚本的解释程序，如：
#!/usr/bin/env python
再如：
#!/usr/bin/env perl
#!/usr/bin/env zimbu
但有时候也用
#!/usr/bin/python
和
#!/usr/bin/perl
那么 env到底有什么用？何时用这个呢？
脚本用env启动的原因，是因为脚本解释器在linux中可能被安装于不同的目录，env可以在系统的PATH目录中查找。同时，env还规定一些系统环境变量。
如我系统里env程序执行后打印结果：

    
    zhouhh@zhh64:~$ env
    ORBIT_SOCKETDIR=/tmp/orbit-zhouhh
    SSH_AGENT_PID=1690
    GPG_AGENT_INFO=/tmp/gpg-mtL1Zu/S.gpg-agent:1691:1
    TERM=xterm
    SHELL=/bin/bash
    XDG_SESSION_COOKIE=d5d84d25809d4bece35534e04b42f288-1294880359.975147-1087503175
    WINDOWID=79719698
    GNOME_KEYRING_CONTROL=/tmp/keyring-UNhAyN
    GTK_MODULES=canberra-gtk-module
    USER=zhouhh
    LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:
    SSH_AUTH_SOCK=/tmp/keyring-UNhAyN/ssh
    DEFAULTS_PATH=/usr/share/gconf/gnome.default.path
    SESSION_MANAGER=local/zhh64:@/tmp/.ICE-unix/1396,unix/zhh64:/tmp/.ICE-unix/1396
    USERNAME=zhouhh
    XDG_CONFIG_DIRS=/etc/xdg/xdg-gnome:/etc/xdg
    MAIL=/home/zhouhh/maildir
    DESKTOP_SESSION=gnome
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
    QT_IM_MODULE=ibus
    PWD=/home/zhouhh
    XMODIFIERS=@im=ibus
    GDM_KEYBOARD_LAYOUT=cn
    LANG=zh_CN.UTF-8
    MANDATORY_PATH=/usr/share/gconf/gnome.mandatory.path
    GDM_LANG=zh_CN.UTF-8
    GDMSESSION=gnome
    SPEECHD_PORT=7560
    SHLVL=1
    HOME=/home/zhouhh
    LANGUAGE=zh_CN:zh
    GNOME_DESKTOP_SESSION_ID=this-is-deprecated
    LOGNAME=zhouhh
    XDG_DATA_DIRS=/usr/share/gnome:/usr/local/share/:/usr/share/
    DBUS_SESSION_BUS_ADDRESS=unix:abstract=/tmp/dbus-sy1TrQPCWB,guid=777f902513b924b985c5ce5e0000001c
    LESSOPEN=| /usr/bin/lesspipe %s
    WINDOWPATH=7
    DISPLAY=:0.0
    GTK_IM_MODULE=ibus
    LESSCLOSE=/usr/bin/lesspipe %s %s
    XAUTHORITY=/var/run/gdm/auth-for-zhouhh-9Wko4S/database
    COLORTERM=gnome-terminal
    _=/usr/bin/env
    



可以用env来执行程序：

    
    
    zhouhh@zhh64:~$ env python
    Python 2.6.6 (r266:84292, Sep 15 2010, 16:22:56)
    [GCC 4.4.5] on linux2
    Type "help", "copyright", "credits" or "license" for more information.
    >>>
    
    



而如果直接将解释器路径写死在脚本里，可能在某些系统就会存在找不到解释器的兼容性问题。有时候我们执行一些脚本时就碰到这种情况。

话说，vim作者Bram Moolenaar推出了一种脚本语言叫zimbu，放在google code上。地址：http://code.google.com/p/zimbu/
下载编译后，执行它的示例程序，报错：

    
    
    zhouhh@zhh64:~/zimbu$ cat hello.zu
    #!/usr/bin/env zimbush
    
    FUNC int MAIN()
      IO.write("Hello World!n")
      RETURN 0
    }
    zhouhh@zhh64:~/zimbu$ ./hello.zu
    /usr/bin/env: zimbush: 没有那个文件或目录
    


显然没有设置环境变量。


