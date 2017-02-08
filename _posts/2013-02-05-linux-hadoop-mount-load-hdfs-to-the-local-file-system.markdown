---
author: abloz
comments: true
date: 2013-02-05 08:25:08+00:00
layout: post
link: http://abloz.com/index.php/2013/02/05/linux-hadoop-mount-load-hdfs-to-the-local-file-system/
slug: linux-hadoop-mount-load-hdfs-to-the-local-file-system
title: linux hadoop mount 加载HDFS到本地文件系统
wordpress_id: 2120
categories:
- 技术
tags:
- fuse
- hadoop
- hdfs
- mount
- 文件系统
---

周海汉
2013.2.5
上一篇文章《[编译hadoop 1.0.4的 libhdfs库](http://abloz.com/2013/02/04/compile-hadoop-1-0-4-libhdfs-library.html)》，完成了libhdfs的编译。在此基础上，完成fuse_dfs的生成。

编译fuse_dfs
[zhouhh@Hadoop48 hadoop-1.0.4]$ ant compile-contrib -Dlibhdfs=1 -Dfusedfs=1

     [exec] gcc  -Wall -O3 -L/home/zhouhh/hadoop-1.0.4/build/libhdfs -lhdfs -L/lib -lfuse -L/usr/java/jdk1.7.0/jre/lib/amd64/server -ljvm  -o fuse_dfs  fuse_dfs.o fuse_options.o fuse_trash.o fuse_stat_struct.o fuse_users.o fuse_init.o fuse_connect.o fuse_impls_access.o fuse_impls_chmod.o fuse_impls_chown.o fuse_impls_create.o fuse_impls_flush.o fuse_impls_getattr.o fuse_impls_mkdir.o fuse_impls_mknod.o fuse_impls_open.o fuse_impls_read.o fuse_impls_release.o fuse_impls_readdir.o fuse_impls_rename.o fuse_impls_rmdir.o fuse_impls_statfs.o fuse_impls_symlink.o fuse_impls_truncate.o fuse_impls_utimens.o fuse_impls_unlink.o fuse_impls_write.o
     [exec] make[1]: Leaving directory `/home/zhouhh/hadoop-1.0.4/src/contrib/fuse-dfs/src'
     [exec] /usr/bin/ld: cannot find -lhdfs

找不到hdfs库，因为其查找的路径在-L/home/zhouhh/hadoop-1.0.4/build/libhdfs，建立链接。
[zhouhh@Hadoop48 hadoop-1.0.4]$ cd  build
[zhouhh@Hadoop48 build]$ ln -s c++/Linux-amd64-64/lib/ libhdfs

再编译：
[zhouhh@Hadoop48 hadoop-1.0.4]$ ant compile-contrib -Dlibhdfs=1 -Dfusedfs=1
BUILD SUCCESSFUL
Total time: 32 seconds

修改生成的shell脚本，否则会找不到可执行程序
[zhouhh@Hadoop48 hadoop-1.0.4]$ vi build/contrib/fuse-dfs/fuse_dfs_wrapper.sh
-./fuse_dfs $@
+fuse_dfs $@

[zhouhh@Hadoop48 hadoop-1.0.4]$ chmod +x build/contrib/fuse-dfs/fuse_dfs_wrapper.sh


[zhouhh@Hadoop48 hadoop-1.0.4]$ fuse_dfs_wrapper.sh
fuse_dfs: error while loading shared libraries: libhdfs.so.0: cannot open shared object file: No such file or directory

[zhouhh@Hadoop48 ~]$ vi .bashrc
export OS_ARCH=amd64
export OS_BIT=64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$JAVA_HOME/jre/lib/$OS_ARCH/server:${HADOOP_HOME}/build/c++/Linux-$OS_ARCH-$OS_BIT/lib

export FUSE_HOME=/home/zhouhh/hadoop-1.0.4/build/contrib/fuse-dfs
export PATH=$PATH:$FUSE_HOME

[zhouhh@Hadoop48 ~]$ source .bashrc

[zhouhh@Hadoop48 ~]$ fuse_dfs_wrapper.sh
USAGE: fuse_dfs [debug] [--help] [--version] [-oprotected=] [-oport=] [-oentry_timeout=] [-oattribute_timeout=] [-odirect_io] [-onopoermissions] [-o]  [fuse options]
NOTE: debugging option for fuse is -debug

[zhouhh@Hadoop48 ~]$ fuse_dfs_wrapper.sh dfs://192.168.10.48:54310 /data/zhouhh/mnt/hdfs
port=54310,server=192.168.10.48
fuse-dfs didn't recognize /data/zhouhh/mnt/hdfs,-2
fuse: failed to exec fusermount: Permission denied

[zhouhh@Hadoop48 hadoop-1.0.4]$ sudo fuse_dfs_wrapper.sh  dfs://Hadoop48:54310 /data/zhouhh/mnt/hdfs
fuse_dfs: error while loading shared libraries: libhdfs.so.0: cannot open shared object file: No such file or directory

[zhouhh@Hadoop48 hadoop-1.0.4]$ sudo cp build/c++/Linux-amd64-64/lib/* /usr/local/lib
[zhouhh@Hadoop48 hadoop-1.0.4]$ sudo fuse_dfs_wrapper.sh  dfs://Hadoop48:54310 /data/zhouhh/mnt/hdfs
port=54310,server=Hadoop48
fuse-dfs didn't recognize /data/zhouhh/mnt/hdfs,-2


[zhouhh@Hadoop48 hadoop-1.0.4]$ df
...
fuse                 1572929536  39321600 1533607936   3% /data/zhouhh/mnt/hdfs

[zhouhh@Hadoop48 hadoop-1.0.4]$ cd /data/zhouhh/mnt/hdfs
[zhouhh@Hadoop48 hdfs]$ ls
data  hbase  tmp  user


开机自动挂载hdfs文件系统

[zhouhh@Hadoop48 ~]$ sudo vi /etc/fstab
fuse_dfs_wrapper.sh dfs://Hadoop48:54310 /data/zhouhh/mnt/hdfs    fuse rw,auto 0 0

[zhouhh@Hadoop48 ~]$ cd /data/zhouhh/mnt/hdfs

[zhouhh@Hadoop48 hdfs]$ cd user
[zhouhh@Hadoop48 user]$ ls
flume  zhouhh
[zhouhh@Hadoop48 user]$ cd zhouhh
[zhouhh@Hadoop48 zhouhh]$ pwd
/data/zhouhh/mnt/hdfs/user/zhouhh
[zhouhh@Hadoop48 zhouhh]$ ls
a  fsimage  gz  README.txt  test.txt  t.py


测试
[zhouhh@Hadoop48 zhouhh]$ vi mytest.txt
hello
你好
中国

[zhouhh@Hadoop48 zhouhh]$ ls
a  fsimage  gz  mytest.txt  README.txt  test.txt  t.py

[zhouhh@Hadoop48 zhouhh]$ cat mytest.txt //注意，立即cat没有东西
[zhouhh@Hadoop48 zhouhh]$ vi mytest.txt  //vi查看有东西
[zhouhh@Hadoop48 zhouhh]$ cat mytest.txt //再cat内容出来了
hello
你好
中国
[zhouhh@Hadoop48 zhouhh]$ hadoop fs -ls
Found 7 items
-rw-r--r--   2 zhouhh supergroup       1399 2013-02-01 10:56 /user/zhouhh/README.txt
-rw-r--r--   3 zhouhh supergroup          0 2013-02-05 16:08 /user/zhouhh/a
-rw-r--r--   2 zhouhh supergroup       9358 2013-01-10 17:52 /user/zhouhh/fsimage
drwxr-xr-x   - zhouhh supergroup          0 2013-02-01 10:30 /user/zhouhh/gz
-rw-r--r--   3 zhouhh supergroup         20 2013-02-05 16:09 /user/zhouhh/mytest.txt
-rw-r--r--   2 zhouhh supergroup       4771 2013-02-01 19:09 /user/zhouhh/t.py
-rw-r--r--   2 zhouhh supergroup         22 2013-02-01 19:37 /user/zhouhh/test.txt

[zhouhh@Hadoop48 zhouhh]$ hadoop fs -cat mytest.txt
hello
你好
中国
[zhouhh@Hadoop48 zhouhh]$ grep hell mytest.txt
hello
[zhouhh@Hadoop48 zhouhh]$ grep -n 你 mytest.txt
2:你好
[zhouhh@Hadoop48 zhouhh]$ tail mytest.txt
hello
你好
中国
[zhouhh@Hadoop48 zhouhh]$ grep -n hello *
mytest.txt:1:hello

[zhouhh@Hadoop48 ~]$ ln -s /data/zhouhh/mnt/hdfs .
