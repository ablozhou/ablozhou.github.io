---
author: abloz
comments: true
date: 2012-07-05 05:39:19+00:00
layout: post
link: http://abloz.com/index.php/2012/07/05/use-rsync-to-synchronize-hadoop-server-configuration/
slug: use-rsync-to-synchronize-hadoop-server-configuration
title: 用rsync来同步Hadoop各服务器配置
wordpress_id: 1759
categories:
- 技术
tags:
- hadoop
- rsync
- scp
---

http://abloz.com
date:2012.7.5
update:2012.8.8

rsync是一个很好用远程同步工具。相较scp而言，在Hadoop类似的分布式部署中，rsync更加强大好用。

示例，同步hbase-env.sh配置。

    
    
    [zhouhh@Hadoop48 ~]$ cd hbase-0.94.0/conf
    [zhouhh@Hadoop48 conf]$ vi hbase-env.sh
    
    #将HBase缺省内存改为4G
    # The maximum amount of heap to use, in MB. Default is 1000.
    export HBASE_HEAPSIZE=4000
    



同步到Hadoop46，47,-v参数可以看到详细情况：

    
    
    [zhouhh@Hadoop48 conf]$ rsync -v hbase-env.sh Hadoop46:~/hbase-0.94.0/conf/.
    [zhouhh@Hadoop48 conf]$ rsync -v hbase-env.sh Hadoop47:~/hbase-0.94.0/conf/.
    



还可以同步目录

    
    
    [zhouhh@Hadoop48 conf]$ rsync -ave ssh ./ Hadoop46:~/hbase-0.94.0/conf/.
    building file list ... done
    ./
    hadoop-metrics.properties
    hbase-env.sh
    hbase-policy.xml
    hbase-site.xml
    log4j.properties
    regionservers
    
    sent 563 bytes  received 284 bytes  1694.00 bytes/sec
    total size is 12833  speedup is 15.15
    
    


可以指定协议和端口。如指定ssh协议的50022端口.-a 参数表示归档文件archive：

    
    
    rsync -av -e 'ssh -p 50022' hbase-env.sh Hadoop47:~/hbase-0.94.0/conf/.
    


同步目录,注意尾部的“/”。源目录尾部不加"/"，会在目标中创建源的目录。源目录尾部加“/”，则复制的是源目录中的内容，不会在目标中创建相应目录

    
    
    [zhouhh@Hadoop48 ~]$ rsync -uavz   ./hbase-0.94.0 h185:~/
    


-u: update,没变的文件不更新。
-a: archive，相当于-rlptgoD
-z:压缩
该命令相当于将hbase-0.94.0整个目录都移到h185的zhouhh目录下。
相当于

    
    
    [zhouhh@Hadoop48 ~]$ rsync -uavz   ./hbase-0.94.0/ h185:~/hbase-0.94.0/
    



包含和布包含多个目录或文件：
--include, --exclude
如果从远端同步到本地，还可以用
rsync -av host:'dir1/file1 dir2/file2' /dest

写成make脚本Makefile,同步test目录

    
    
    [zhouhh@h185 test]$ vi Makefile
    get:
        rsync -avuzb --exclude '*~' Hadoop48:~/test/ .
    put:
        rsync -Cavuzb ./ Hadoop48:~/test/
    sync: get put
    
    [zhouhh@h185 test]$ make get
    rsync -avuzb --exclude '*~' Hadoop48:~/test/ .
    ...
    sent 654 bytes  received 25839 bytes  5887.33 bytes/sec
    total size is 85601  speedup is 3.23
    
    


-C 表示不同步cvs获取文件时的做法。会忽略一些cvs自动生成的文件，适合做cvs目录同步备份。

相关参数说明，也可以用man获得：

```

客户端同步命令
v, –verbose 详细模式输出
-q, –quiet 精简输出模式
-c, –checksum 打开校验开关，强制对文件传输进行校验
-a, –archive 归档模式，表示以递归方式传输文件，并保持所有文件属性，等于-rlptgoD
-r, –recursive 对子目录以递归模式处理
-R, –relative 使用相对路径信息

rsync foo/bar/foo.c remote:/tmp/

则在/tmp目录下创建foo.c文件，而如果使用-R参数：

rsync -R foo/bar/foo.c remote:/tmp/

则会创建文件/tmp/foo/bar/foo.c，也就是会保持完全路径信息。

-b, –backup 创建备份，也就是对于目的已经存在有同样的文件名时，将老的文件重新命名为~filename。可以使用–suffix选项来指定不同的备份文件前缀。
–backup-dir 将备份文件(如~filename)存放在在目录下。
-suffix=SUFFIX 定义备份文件前缀
-u, –update 仅仅进行更新，也就是跳过所有已经存在于DST，并且文件时间晚于要备份的文件。(不覆盖更新的文件)
-l, –links 保留软链结
-L, –copy-links 想对待常规文件一样处理软链结
–copy-unsafe-links 仅仅拷贝指向SRC路径目录树以外的链结
–safe-links 忽略指向SRC路径目录树以外的链结
-H, –hard-links 保留硬链结
-p, –perms 保持文件权限
-o, –owner 保持文件属主信息
-g, –group 保持文件属组信息
-D, –devices 保持设备文件信息
-t, –times 保持文件时间信息
-S, –sparse 对稀疏文件进行特殊处理以节省DST的空间
-n, –dry-run现实哪些文件将被传输
-W, –whole-file 拷贝文件，不进行增量检测
-x, –one-file-system 不要跨越文件系统边界
-B, –block-size=SIZE 检验算法使用的块尺寸，默认是700字节
-e, –rsh=COMMAND 指定替代rsh的shell程序
–rsync-path=PATH 指定远程服务器上的rsync命令所在路径信息
-C, –cvs-exclude 使用和CVS一样的方法自动忽略文件，用来排除那些不希望传输的文件
–existing 仅仅更新那些已经存在于DST的文件，而不备份那些新创建的文件
–delete 删除那些DST中SRC没有的文件
–delete-excluded 同样删除接收端那些被该选项指定排除的文件
–delete-after 传输结束以后再删除
–ignore-errors 及时出现IO错误也进行删除
–max-delete=NUM 最多删除NUM个文件
–partial 保留那些因故没有完全传输的文件，以是加快随后的再次传输
–force 强制删除目录，即使不为空
–numeric-ids 不将数字的用户和组ID匹配为用户名和组名
–timeout=TIME IP超时时间，单位为秒
-I, –ignore-times 不跳过那些有同样的时间和长度的文件
–size-only 当决定是否要备份文件时，仅仅察看文件大小而不考虑文件时间
–modify-window=NUM 决定文件是否时间相同时使用的时间戳窗口，默认为0
-T –temp-dir=DIR 在DIR中创建临时文件
–compare-dest=DIR 同样比较DIR中的文件来决定是否需要备份
-P 等同于 –partial
–progress 显示备份过程
-z, –compress 对备份的文件在传输时进行压缩处理
–exclude=PATTERN 指定排除不需要传输的文件模式
–include=PATTERN 指定不排除而需要传输的文件模式
–exclude-from=FILE 排除FILE中指定模式的文件
–include-from=FILE 不排除FILE指定模式匹配的文件
–version 打印版本信息
–address 绑定到特定的地址
–config=FILE 指定其他的配置文件，不使用默认的rsyncd.conf文件
–port=PORT 指定其他的rsync服务端口
–blocking-io 对远程shell使用阻塞IO
-stats 给出某些文件的传输状态
–progress 在传输时现实传输过程
–log-format=formAT 指定日志文件格式
–password-file=FILE 从FILE中得到密码
–bwlimit=KBPS 限制I/O带宽，KBytes per second
-h, –help 显示帮助信息

```



