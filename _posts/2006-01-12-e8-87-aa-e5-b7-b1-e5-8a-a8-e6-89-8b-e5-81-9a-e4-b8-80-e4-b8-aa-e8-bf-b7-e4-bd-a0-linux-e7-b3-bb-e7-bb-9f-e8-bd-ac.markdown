---
author: abloz
comments: true
date: 2006-01-12 01:47:30+00:00
layout: post
link: http://abloz.com/index.php/2006/01/12/e8-87-aa-e5-b7-b1-e5-8a-a8-e6-89-8b-e5-81-9a-e4-b8-80-e4-b8-aa-e8-bf-b7-e4-bd-a0-linux-e7-b3-bb-e7-bb-9f-e8-bd-ac/
slug: e8-87-aa-e5-b7-b1-e5-8a-a8-e6-89-8b-e5-81-9a-e4-b8-80-e4-b8-aa-e8-bf-b7-e4-bd-a0-linux-e7-b3-bb-e7-bb-9f-e8-bd-ac
title: 自己动手做一个迷你 Linux 系统[转]
wordpress_id: 579
categories:
- 技术
- 转载
---


<table cellpadding="0" width="95%" align="center" border="0" cellspacing="0" >
  <tbody >
  <tr >
    
<td >DIY：自己动手做一个迷你 Linux 系统  
赵蔚
      (zhaoway@public1.ptt.js.cn)  
自由职业者  
2002 年 9 月
      


      

  本文将带领大家构建一个迷你型的 Linux 系统。它占用的硬盘空间远小于 16M 字节，但是却包括了 XFree86
      的 X Window 窗口系统。


      

目标


      

本文要构建的这个迷你型的 Linux
      系统只能在一台特定的单机上运行，如果读者朋友们有兴趣的话，在这个系统的基础上加以改进，是可以构建出通用的、可以在大多数常规 PC
      机上即插即用的系统来的。但是这已经不在本文的话题之内了，读者朋友们如果有兴趣，可以通过我的电子邮件和我讨论其中的细节问题。


      

我们的目标 Linux 系统运行在一台普通的 Intel 386 PC 机上，可以有硬盘，也可以不要硬盘，而用 Flash Disk
      来代替。如果是用 Flash 盘的话，需要能够支持从 Flash 盘启动，而且 Flash 盘的大小要在 16M
      字节或者以上。我们希望用户一开机启动，就直接进入 X Window 图形界面，运行事先指定好的程序。不需要用户输入用户名和密码进行登录。


      

我们设定的这个目标有点像一个 X Terminal 终端工作站。稍加改进，还可以做成干脆无盘的形式，也就是说，连 16M 的 Flash
      盘也不要了。不过，这也超出了本文的话题了。读者朋友们如果有兴趣，可以来信和我进行讨论。


      

系统启动


      

因为我们要考虑从 Flash 盘进行启动，所以我们选择用 LILO 作为我们的 Boot Loader，而不选用 GRUB。这是考虑到
      GRUB 有较强的对硬盘和文件系统的识别能力，而 Flash 盘到底不是标准的硬盘，并且我们选用的文件系统 GRUB 又不一定认识，搞不好的话
      GRUB 反 会弄巧成拙。而 LILO 就简单的多了，它在硬盘开始的 MBR 写入一个小程序，这个小程序不经过文件系统，直接从硬盘扇区号，读出
      Kernel Image 装入内存。这样，保险系数就大大增加。并且也给了我们自由选用文件系统的余地。那么，我们要如何安装 LILO 呢？


      

首先，我们要找一块普通的 800M 左右的 IDE 硬盘，连在目标机器的 IDE 线上。这样在我们的目标机器上，IDE1 上挂的是 Flash
      盘，IDE2 上挂的是一块工作硬盘。我们用标准的步骤在 IDE2 的标准硬盘上装上一个 Debian GNU/Linux
      系统。当然，如果读者朋友们手头没有 Debian，也可以装 Red Hat 系统。装好工作系统之后，要首先做一些裁减工作，把不必要的 Service
      和 X Window
      等等东西都删掉。这样做的目的是增进系统启动速度，因为我们在后面的工作中，肯定要不停的重新启动机器，所以启动速度对我们的工作效率是很关键的。


      

装好工作系统之后，在 Falsh 盘上做一个 Ext2 文件系统，这个用 mke2fs 这个命令就可以完成。由于 Flash 盘是接在
      IDE1 上的，所以在 Linux 里面，它的身份是 /dev/hda。本文作者在操作的时候，把整个 Flash 盘划分了一个整个的分区，所以，调用
      mke2fs 的时候，处理的是 /dev/hda1。读者朋友们应该可以直接在 /dev/hda 上做一个 Ext2
文件系统，而不用事先分区。


      

在 Flash 盘上做好了文件系统之后，就可以把一个编译好的内核映像文件 vmlinuz 拷贝到 Flash 盘上了。注意，必须要先把这个
      vmlinuz 映像文件拷贝到 Flash 盘上，然后才能在 Flash 盘上安装 LILO。不然的话，LILO 到时候可是会 LILILILI
      打结巴的，因为它会找不到 Kernel Image 在 Flash 盘上的位置的，那样的话 Flash 盘也就启动不起来了。还有，如果读者朋友们在
      Flash 盘上用的是一个压缩的文件系统的话，到时候 LILO 也会出问题，它虽然能正确的找到 Kernel Image
      在硬盘上的起始位置，但是它却没有办法处理被文件系统重新压缩过的这个 Kernel Image，不知道该如何把它展开到内存中去。


      

把 Kernel Image 拷贝过去以后，我们就可以动手编辑一份 lilo.conf 文件，这份文件可以就放在工作系统上就行了。但是注意在
      lilo.conf 中索引的文件名的路径可要写对。这些路径名都是在工作系统上看上去的路径名。比如，如果 Flash 盘 Mount 在 /mnt
      目录下面，那么，在 lilo.conf 中，vmlinuz 的路径名就是
      /mnt/vmlinuz。注意这一点千万不要搞错。不然的话，如果一不小心把工作系统的 LILO 给破坏掉了，那就麻烦了。编辑好了
      lilo.conf，然后再运行 lilo 命令，注意，要告诉它用这个新的 lilo.conf 文件，而不要用 /etc/lilo.conf。


      

安装好 LILO 之后，我们可以立即重新启动，测试一下。首先在 BIOS 里面，设置成从 IDE1 开始启动，如果我们看到 LILO
      的提示符，按回车后还能看到 Kernel 输出的消息，这就算是 LILO 的安装成功了。记得这个操作的方法，以后每次我们更新 Flash 盘上的
      Kernel Image，都记得要更新 LILO。也就是说，要重新运行一遍 lilo 命令。


      

编译内核


      

试验成功 LILO
      的安装以后，我们开始考虑编译一个新的内核。当然，要编译新的内核，我们首先要进入我们的工作系统。这里有两个办法进入工作系统，一是在 BIOS
      里面设置从 IDE2 启动，当然，这就要求当初安装工作系统的时候，要把 LILO 安装在 /dev/hdb 上；另一个办法是还是从 IDE1
      启动，不改变 BIOS 的设置，但是在看到 LILO 的提示符的时候，要键入 linux root=/dev/hdb1，最前面的 linux 是在
      lilo.conf 里面定义的一个 entry，我们只采用这个 entry 所指定的 Kernel Image，但是用 /dev/hdb1 作为
      root 文件系统。两个办法可能有的时候一个比另一个好，更方便一些。这就要看具体的情况了。不过，它们的设置并不是互相冲突的。


      

在编译内核的时候，由于我们的内核是只有一台机器使用的，所以我们应该对它的情况了如指掌；另外一方面，为了减低不必要的复杂性，我们决定不用
      kernel module 的支持，而把所有需要的东西直接编译到内核的里面。这样编译出来的内核，在一台普通的 586
      主板上，把所有必要的功能都加进去，一般也不到 800K 字节。所以，这个办法是可行的。而且减低了 init scripts
      的复杂程度。从运行方面来考虑，由于需要的 kernel 代码反正是要装载到内存中的，所以并不会引起内存的浪费。


      

在我们的目标平台上，我们希望使用 USB 存储设备。还有一点要注意的，就是对 Frame buffer 的支持。这主要是为了支持
      XFree86。一般说来，如果我们的显卡是 XFree86 直接支持的，那当然最好，也就不需要 frame buffer 的内核支持。但是如果
      XFree86 不支持我们的显卡，我们可以考虑用 VESA 模式。但是 XFree86 的 VESA
      卡支持运行起来不太漂亮，还有安全方面的问题，有时在启动和退出 X Window 的时候会出现花屏。所以我们可以采用 kernel 的 vesa
      模式的 frame buffer，然后用 xfree86 的 linux frame buffer
      的驱动程序。这样一般就看不到花屏的现象了，而且安全方面也没有任何问题。


      

devfs 也是我们感兴趣的话题。如果 kernel 不使用 devfs，那么系统上的 root 文件系统就要有 /dev
      目录下面的所有内容。这些内容可以用 /dev/MAKEDEV 脚本来建立，也可以用 mknod
      手工一个一个来建。这个方法有其自身的好处。但是它的缺点是麻烦，而且和 kernel 的状态又并不一致。相反的，如果使用了
      devfs，我们就再也不用担心 /dev 目录下面的任何事情了。/dev 目录下面的项目会有 kernel
      的代码自己负责。实际使用起来的效果，对内存的消耗并不明显。所以我们选择 devfs。


      

busybox


      

有了 LILO 和 kernel image 之后，接下来，我们要安排 root 文件系统。由于 flash 盘的空间只有 16M
      字节，可以说，这是对我们最大的挑战。这里首先要向大家介绍小型嵌入式 Linux 系统安排 root
      文件系统时的一个常用的利器：BusyBox。


      

Busybox 是 Debian GNU/Linux 的大名鼎鼎的 Bruce Perens 首先开发，使用在 Debian
      的安装程序中。后来又有许多 Debian developers 贡献力量，这其中尤推 busybox 目前的维护者 Erik
      Andersen，他患有癌症，可是却是一名优秀的自由软件开发者。


      

Busybox 编译出一个单个的独立执行程序，就叫做 busybox。但是它可以根据配置，执行 ash shell
      的功能，以及几十个各种小应用程序的功能。这其中包括有一个迷你的 vi 编辑器，系统不可或缺的 /sbin/init 程序，以及其他诸如 sed,
      ifconfig, halt, reboot, mkdir, mount, ln, ls, echo, cat ...
      等等这些都是一个正常的系统上必不可少的，但是如果我们把这些程序的原件拿过来的话，它们的体积加在一起，让人吃不消。可是 busybox
      有全部的这么多功能，大小也不过 100K 左右。而且，用户还可以根据自己的需要，决定到底要在 busybox
      中编译进哪几个应用程序的功能。这样的话，busybox 的体积就可以进一步缩小了。


      

使用 busybox 也很简单。只要建一个符号链接，比方 ln -s /bin/busybox /bin/ls，那么，执行 /bin/ls
      的时候，busybox 就会执行 ls 的功能，也会按照 ls 的方式处理命令行参数。又比如 ln -s /bin/busybox
      /sbin/init，这样我们就有了系统运行不可或缺的 /sbin/init 程序了。当然，这里的前提是，你在 busybox
      中编译进去了这两个程序的功能。


      

这里面要提出注意的一点是，busybox 的 init 程序所认识的 /etc/inittab 的格式非常简单，而且和常规的 inittab
      文件的格式不一样。所以读者朋友们在为这个 busybox 的 init 写 inittab
      的时候，要注意一下不同的语法。至于细节，就不在我们这里多说了，请大家参考 Busybox 的用户手册。


      

从启动到进入 shell


      

busybox 安装好以后，我们就可以考虑重新启动，一直到进入 shell 提示符了。这之前，我们要准备一下 /etc
      目录下的几个重要的文件，而且要把 busybox 用到的 library 也拷贝过来。


      

用 ldd 命令，后面跟要分析的二进制程序的路径名，就可以知道一个二进制程序，或者是一个 library 文件之间的互相依赖关系，比如
      busybox 就依赖于 libc.so 和 ld-linux.so ，我们有了这些知识，就可把动手把所有需要的 library 拷贝到 flash
      盘上。由于我们的 flash 盘说大不大，说小倒也不小，有 16M 字节之多。我们直接就用 Glibc
      的文件也没有太多问题。如果读者朋友们有特殊的需要，觉得 Glibc 太庞大了的话，可以考虑用 uClibc，这是一个非常小巧的 libc
      库，功能当然没有 Glibc 全，但是足够一个嵌入式系统使用了。本文就不再介绍 uClibc 了。


      

库程序拷贝过来以后，我们就可以考虑系统启动的步骤了。启动的时候，先是 lilo，接下来就是 kernel，kernel 初始化之后，就调用
      /sbin/init，然后由 init 解释 /etc/inittab 运行各种各样的东西。inittab 会指导 init
      去调用一个最重要的系统初始化程序 /etc/init.d/rcS，我们将要在 rcS 中完成各个文件系统的 mount，此外，还有在 rcS 中调用
      dhcp 程序，把网络架起来。rcS 执行完了以后，init 就会在一个 console 上，按照 inittab 的指示开一个
      shell，或者是开 getty + login，这样用户就会看到提示输入用户名的提示符。我们这里为了简单起见，先直接进入
      shell，然后等到调试成功以后，再改成直接进入 X Window。


      

关于 inittab 的语法，我们上面已经提到过了，希望读者朋友们去查权威的 busybox
      的用户手册。这里，我们先要讲一下文件系统的构成情况。


      

安排文件系统


      

大家已经看到，我们的 root 文件系统为了避免麻烦，用的是标准的 ext2 文件系统。由于我们的硬盘空间很小，只有不到
      16M，而且我们还要在上面放上 X Window，所以，如果我们全部用 ext2 的话，Flash
      盘的有限空间会很快耗尽。我们唯一的选择是采用一个适当的压缩文件系统。考虑到 /usr
      目录下面的内容在系统运行的时候，是不需要被改写的。我们决定选择只读的压缩文件系统 cramfs 来容纳 /usr 目录下面的全部内容。


      

cramfs 是 Linus Torvalds 本人开发的一个适用于嵌入式系统的小文件系统。由于它是只读的，所以，虽然它采取了 zlib
      做压缩，但是它还是可以做到高效的随机读取。既然 cramfs
      不会影响系统读取文件的速度，又是一个高度压缩的文件系统，对于我们，它就是一个相当不错的选择了。


      

我们首先把 /usr 目录下的全部内容制成一个 cramfs 的 image 文件。这可以用 mkcramfs 命令完成。得到了这个
      usr.img 文件之后，我们还要考虑怎样才能在系统运行的时候，把这个 image 文件 mount 上来，成为一个可用的文件系统。由于这个
      image 文件不是一个通常意义上的 block 设备，我们必须采用 loopback 设备来完成这一任务。具体说来，就是在前面提到的
      /etc/init.d/rcS 脚本的前面部分，加上一行 mount 命令：


      

  
mount -o loop -t cramfs /usr.img /usr


      

这样，就可以经由 loopback 设备，把 usr.img 这个 cramfs 的 image 文件 mount 到 /usr
      目录上去了。哦，对了，由于要用到 loopback 设备，读者朋友们在编译内核的时候，别忘了加入内核对这个设备的支持。对于系统今后的运行来说，这个
      mount 的效果是透明的。cramfs 的压缩效率一般都能达到将近 50%，而我们的系统上绝大部分的内容是位于 /usr
      目录下面，这样一来，原本可能要用到 18M 的 Flash 盘，现在可能只需要 11M 就可以了。一个 14M 的 /usr 目录，给压缩成了仅仅
      7M。


      

上面考虑了压缩问题，下面还要考虑到，Flash
      盘毕竟不像普通硬盘，多次的擦写毕竟不太好，所以我们考虑，在需要多次擦写的地方，使用内存来做。这个任务，我们考虑用 tmpfs 来完成。至于
      tmpfs 和经典的 ramdisk 的比较，我们这里就不多说了。一般说来，tmpfs 更加灵活一些，tmpfs 的大小不像
      ramdisk，可以顺着用户的需要增长或者缩小。我们选择把 /tmp、/var 等几个目录做成 tmpfs。这只需要我们在 /etc/fstab
      里面加上两行类似下面的文字就可以了：


      

  
none /var tmpfs default 0 0


      

  
然后别忘了在 /etc/init.d/rcS 里面靠近开头的地方，加上 mount -a。这样，就可以把 /etc/fstab
      里面指定的所有的文件系统都 mount 上来了。


      

X Window


      

进行到这里，读者朋友们可能会以为，X Window 的安装可能会很复杂。其实不然，由于我们上面的架子搭好了，X Window
      的安装非常简单，只需要把几个关键的程序拷贝过来就可以了。一般说来，只需要 /usr/X11R6 目录下面的 bin 和 lib
      两个目录。然后，根据用户各自的需要，还可以做大幅的裁减。比如，如果你的局域网上有一个开放的 xfs
      字体服务器的话，你可以把所有本地的字体都删掉，而使用远端的字体服务器。如果只需要运行有限的程序，别忘了把没有用的 library
      都删掉。此外，还可以把多余的 X Window 的 driver 都删掉，只保留本机的显示卡所需要的 driver 就可以了。


      

当然，这一关免不了要做多次测试。


      

其它技巧


      

如果你的工作系统式在另外一台机器上，通过局域网和本机互联的话，ssh 是一个不错的工具。此外，ssh 中带的 scp 用起来和普通的 cp
      拷贝程序差不多，非常方便。用 ssh 和 scp 来共享文件，远程试验，你就可以不需要在办公室里跑来跑去的了。


      

如果你需要一个 MS Windows 上运行的 X Server 和 xfs 字体服务器，可以考虑包括在 Red Hat 的 Cygwin
      工具箱中的 XFree86 系统。


      

参考资料


      

  1. BusyBox 的站点：[http://www.busybox.net](http://www.busybox.net/)  
  2. Linux From
      Scratch，自己动手，从头开始做一个 Linux 系统：[http://www.linuxfromscratch.org](http://www.linuxfromscratch.org/)  
  3.
      uClibc 的站点：[http://www.uclibc.org](http://www.uclibc.org/)  
  4. Cygwin 的站点：[http://www.cygwin.com](http://www.cygwin.com/)


      

关于作者


      

赵蔚，自由职业者。我的网络日记位于 [http://www.advogato.org/person/zhaoway/](http://www.advogato.org/person/zhaoway/)
      。上面列有我在网络上发表的其它的文章。欢迎读者朋友们来信和我讨论问题。  


</td></tr></tbody></table>
