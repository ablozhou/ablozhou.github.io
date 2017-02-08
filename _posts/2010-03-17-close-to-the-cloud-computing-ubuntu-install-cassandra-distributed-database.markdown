---
author: abloz
comments: true
date: 2010-03-17 06:23:52+00:00
layout: post
link: http://abloz.com/index.php/2010/03/17/close-to-the-cloud-computing-ubuntu-install-cassandra-distributed-database/
slug: close-to-the-cloud-computing-ubuntu-install-cassandra-distributed-database
title: 靠近云计算：ubuntu上安装cassandra分布式数据库
wordpress_id: 1161
categories:
- 技术
---

周海汉 /文

http://blog.csdn.net/ablo_zhou
ablozhou # gmail.com
2010.3.17

cassandra是所谓高可用性第二代分布式数据库。facebook 2008年提交到apache的开源混合非关系数据库。具有amaza 专有分布式key-value数据库dynamo和google bigtable基于列族的数据模型的特点。对于云集算，sns等需求超大数据库，而又随时可能需要更改列等需求，cassandra很适合。我的理解，有了cassandra，就不必费心做数据库集群了，cassandra原生支持分布式节点，一个节点失败了会有其他节点替代。

这么强大的数据库，难怪一推出就受到很大的重视，最近又传出消息，继twitter之后，digg也弃mysql转向了cassandra。
1.直接下载二进制，ubuntu不能运行

到apache官网下载http://cassandra.apache.org/
目前最新版本0.6beta2.
二进制 http://www.apache.org/dyn/closer.cgi?path=/incubator/cassandra/0.6.0/apache-cassandra-0.6.0-beta2-bin.tar.gz
源码：http://www.apache.org/dyn/closer.cgi?path=/incubator/cassandra/0.6.0/apache-cassandra-0.6.0-beta2-src.tar.gz
但我在ubuntu中直接下载二进制执行cassandra出错。

当然，此前必须根据conf/storage-conf.xml和log4j.properties建立相关目录。
zhouhh@zhh64:~$ sudo mkdir /var/lib/cassandra/
zhouhh@zhh64:~$ sudo mkdir /var/lib/cassandra/{commitlog,data,callout,staging}
执行出错：
zhouhh@zhh64:~/cassandra/apache-cassandra-0.6.0-beta2/bin$ ./cassandra -f
./cassandra: 162: -ea: not found

通过apt-cache 搜索不到，因为没有相关源。
zhouhh@zhh64:~$ sudo apt-cache search cassandra
无返回

2.通过apt-get下载

设置源：
root@zhh64:~#sodo vi /etc/apt/sources.list
添加apache官方deb源：
deb http://www.apache.org/dist/cassandra/debian unstable main
deb-src http://www.apache.org/dist/cassandra/debian unstable main

保存，更新
zhouhh@zhh64:~$ sudo apt-get update
此时会提示错误：
W: GPG签名验证错误： http://www.apache.org unstable Release: 由于没有公钥，下列签名无法进行验证： NO_PUBKEY F758CE318D77295D
GPG error: http://www.apache.org unstable Release: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY F758CE318D77295D

没关系，设置public keyserver，增加PUBLIC_KEY：

zhouhh@zhh64:~$ gpg --keyserver wwwkeys.eu.pgp.net --recv-keys F758CE318D77295D
gpg: 下载密钥‘8D77295D’，从 hkp 服务器 wwwkeys.eu.pgp.net

gpg: 密钥 8D77295D：公钥“Eric Evans <eevans@sym-link.com>”已导入
gpg: 没有找到任何绝对信任的密钥
gpg: 合计被处理的数量：1
gpg:               已导入：1  (RSA: 1)

zhouhh@zhh64:~$ gpg --export --armor F758CE318D77295D | sudo apt-key add -
OK
zhouhh@zhh64:~$ sudo apt-get update
不再报错。

3.安装

zhouhh@zhh64:~$ apt-cache search cassandra
cassandra - distributed storage system for structured data
zhouhh@zhh64:~$ sudo apt-get install cassandra
正在读取软件包列表... 完成
正在分析软件包的依赖关系树      
正在读取状态信息... 完成      
将会安装下列额外的软件包：
  ca-certificates-java icedtea-6-jre-cacao java-common jsvc
  libcommons-daemon-java libjline-java openjdk-6-jre-headless
  openjdk-6-jre-lib rhino tzdata-java
建议安装的软件包：
  equivs java-virtual-machine libjline-java-doc sun-java6-fonts
  ttf-kochi-gothic ttf-sazanami-gothic ttf-kochi-mincho ttf-sazanami-mincho
  ttf-telugu-fonts ttf-oriya-fonts ttf-kannada-fonts ttf-bengali-fonts
  rhino-doc
下列【新】软件包将被安装：
  ca-certificates-java cassandra icedtea-6-jre-cacao java-common jsvc
  libcommons-daemon-java libjline-java openjdk-6-jre-headless
  openjdk-6-jre-lib rhino tzdata-java
共升级了 0 个软件包，新安装了 11 个软件包，要卸载 0 个软件包，有 7 个软件未被升级。
需要下载 36.0MB 的软件包。
解压缩后会消耗掉 94.4MB 的额外空间。
您希望继续执行吗？[Y/n]

执行完即安装成功。
再去执行原来的二进制包，提示变了：
zhouhh@zhh64:~/cassandra/apache-cassandra-0.6.0-beta2/bin$ ./cassandra -f
错误: 代理抛出异常 : java.rmi.server.ExportException: Port already in use: 8080; nested exception is:
    java.net.BindException: Address already in use
说明，新安装的cassandra已经起作用了。

用ps -ef 可以看到java 的jsvc启动的cassandra进程。

4.参考
http://wiki.apache.org/cassandra/DebianPackaging
http://wiki.woodpecker.org.cn/moin/ApacheCassandra
http://wiki.apache.org/cassandra/GettingStarted


![](http://img.zemanta.com/pixy.gif?x-id=6842e0a4-34d4-8d6b-b591-53ee9eeba8bd)
