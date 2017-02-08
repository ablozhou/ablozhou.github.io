---
author: abloz
comments: true
date: 2010-07-11 23:37:45+00:00
layout: post
link: http://abloz.com/index.php/2010/07/12/a-talk-on-the-diy-release-of-ubuntu/
slug: a-talk-on-the-diy-release-of-ubuntu
title: '[转]简谈ubuntu之DIY发行版'
wordpress_id: 19
categories:
- 技术
- 转载
---

二十一世纪到了，每个人都强调自己的个性，于是一种叫做DIY的东西悄然兴起。

操作系统作为全人类智慧的结晶，自然DIY起来难度极大，因而DIY出一个操作系统成就感绝对比买宜家的东西的成就感大。

为了不至于从头开始编写一个操作系统，我们当然把采用现成的操作系统作为一个底线。

当然，我们可以通过LFS让我们爽到底，但是，能够做到LFS的人可真的是凤毛麟角。而且更重要的是LFS简直在挑战我的忍耐程度。

我的这篇文章，教大家如何DIY一个自己的ubuntu发行版。在非常节省时间的情况下，达到耍酷的目的。

就好比LFS一样，我们需要一个创作基地。我们首先建立一个变量。建立这个变量的好处很明显，即使你不用~/diy_ubuntu这个目录，一样可以照着这个文章继续做下去。

` $ export WORK=~/diy_ubuntu`

$ mkdir -p $WORK

然后我们把光盘镜像文件挂到/mnt

` $ sudo mount -t iso9660 -o loop dapper-live-i386.iso /mnt`

$ cd $WORK

复制文件光盘文件

` $ mkdir ubuntu-livecd`

$ cp -a /mnt/. ubuntu-livecd

$ chmod -R u+w ubuntu-livecd

$ sudo umount /mnt

由于光盘中包含了很多windows下面的自由软件，我们来把不必要的文件删除。当然你可以保留。

` $ rm -rf $WORK/ubuntu-livecd/programs`

把光盘中的压缩文件挂起来，这个样子以后你可以在$WORK/old目录中看到一个完整的linux操作系统的目录。

` $ mkdir $WORK/old`

$ sudo mount -t squashfs -o loop,ro $WORK/ubuntu-livecd/casper/filesystem.squashfs $WORK/old

我们建立一个2GB大小的文件系统,然后把这个文件当作一个设备文件格式化，结果系统给出了一个警告，别理会它，选择是就是。

` $ sudo dd if=/dev/zero of=$WORK/ubuntu-fs.ext2 bs=1M count=2147`

$ sudo mke2fs $WORK/ubuntu-fs.ext2

然后我们把这个空文件系统挂起来。
`
$ mkdir $WORK/new`

$ sudo mount -o loop $WORK/ubuntu-fs.ext2 $WORK/new

复制linux操作系统的文件.由于我们事先得到的linux是压缩的，所以我们把它解压了。

` $ sudo cp -a $WORK/old/. $WORK/new`

当然现在$WORK/old就没有用处了。废掉它

` $ sudo umount $WORK/old`

我们首先进入刚才得到的那个操作系统

` $ sudo cp /etc/resolv.conf $WORK/new/etc/`

$ sudo mount -t proc -o bind /proc $WORK/new/proc

$ sudo chroot $WORK/new /bin/bash

现在你就进入系统了，高喊linux for human beings，大炼ubuntu，想干什么就干什么。

` # vi /etc/apt/sources.list #选择适合你的源`

# apt-get update

# apt-get dist-upgrade

# apt-get install 你想装的软件

# apt-get clean

.... #更多的配置

最后离开你的那个操作系统

` # exit`

$ sudo umount $WORK/new/proc

$ sudo rm $WORK/new/etc/resolv.conf

现在你已经回到了你的初始状态中

把manifest重新整一遍

` $ sudo chroot $WORK/new dpkg-query -W --showformat='${Package} ${Version}n' > $WORK/ubuntu-livecd/casper/filesystem.manifest`

然后做一下“磁盘清理”
`
$ sudo dd if=/dev/zero of=$WORK/new/dummyfile`

$ sudo rm $WORK/new/dummyfile

重新压缩系统

` $ sudo rm $WORK/ubuntu-livecd/casper/filesystem.squashfs`

$ cd $WORK/new

$ sudo mksquashfs . $WORK/ubuntu-livecd/casper/filesystem.squashfs

你的改动都保存了。现在把$WORK/new废掉

` $ cd $WORK`

$ sudo umount $WORK/new

把文件的md5重新算一下

` $ cd $WORK/ubuntu-livecd`

$ sudo find . -type f -print0 |xargs -0 md5sum |sudo tee md5sum.txt

建立光盘镜像，命令很长，忍受着点。

` $ cd $WORK`

$ sudo mkisofs -o ubuntu-new.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -r -V "My Cool Ubuntu Live CD" -cache-inodes -J -l ubuntu-livecd

然后你就可以用iso把光盘烧了
