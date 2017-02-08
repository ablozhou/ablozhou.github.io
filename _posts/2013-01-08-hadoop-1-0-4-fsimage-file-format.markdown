---
author: abloz
comments: true
date: 2013-01-08 10:41:33+00:00
layout: post
link: http://abloz.com/index.php/2013/01/08/hadoop-1-0-4-fsimage-file-format/
slug: hadoop-1-0-4-fsimage-file-format
title: hadoop 1.0.4 fsimage 文件格式分析
wordpress_id: 2057
categories:
- 技术
tags:
- fsimage
- hadoop
---





周海汉 2013.1.8

http://abloz.com/2013/01/08/hadoop-1-0-4-fsimage-file-format.html

fsimage文件存放在NameNode中，保存HDFS中文件的meta信息。fsimage和edits 文件格式是一样的。都是二进制存储。具有文件头，目录信息，文件信息。本文分析一下fsimage文件的格式。不同版本的fsimage文件格式会略有差异。

我的hdfs的一个目录和一个文件信息如下：

目录信息

drwxr-xr-x   - zhouhh supergroup          0 2012-12-25 18:37 /hbase

文件信息

-rw-r--r--   2 zhouhh supergroup       1381 2012-09-26 14:03 /user/zhouhh/README.txt

**fsimage文件描述：**

**一、首先是一个image head，其中包含：**

1．imgVersion(int)：当前image的版本信息

2．namespaceID(int)：用来确保别的HDFS instance中的datanode不会误连上当前NN。

3．numFiles(long)：整个文件系统中包含有多少文件和目录

4．genStamp(long)：生成该image时的时间戳信息。

文件头的imgVersion，namespaceID在新版的fsImage中准备移除。

文件头，顺序格式
<table >
<tbody >
<tr >

<td width="63" valign="top" >名称
</td>

<td width="125" valign="top" >imgVersion

(int)
</td>

<td width="92" valign="top" >namespaceID

(int)
</td>

<td width="140" valign="top" >numFiles

(long)
</td>

<td width="146" valign="top" >genstamp

(long)
</td>
</tr>
<tr >

<td width="63" valign="top" >值举例
</td>

<td width="125" valign="top" >ffff ffe0
</td>

<td width="92" valign="top" >4e0a 6aed
</td>

<td width="140" valign="top" >0000 0000 0000 0046
</td>

<td width="146" valign="top" >0000 0000 0000 044f

(Thu Jan 01 08:00:01 CST 1970)
</td>
</tr>
</tbody>
</table>


**二、目录**

接下来便是目录和文件的元数据信息

而且紧跟文件头的是一个无名目录，即目录名称长度为0的根目录。

目录包含以下信息：

1．namelen(short)：该目录的路径长度

2．Name(bytes): 该目录的路径，如"/user/zhouhh/data"

3．replications(short)：副本数，目录为0

4．mtime(long)：该目录的修改时间的时间戳信息

5．atime(long)：该目录的访问时间的时间戳信息

6．blocksize(long)：目录的blocksize都为0

7．numBlocks(int)：实际有多少个文件块，目录的该值都为-1，即ffff ffff表示目录

8．nsQuota(long)：namespace Quota值，若没加Quota限制则为-1

9．dsQuota(long)：disk Quota值，若没加限制则也为-1

10．username(String)：该目录的所属用户名，前面有个可变长度的长度描述，最长为int

11．group(String)：该目录的所属组，前面有个可变长度的长度描述，最长为int

12．permission(short)：该目录的权限信息，如644等，和POSIX权限保持一致。



目录，按顺序格式
<table >
<tbody >
<tr >

<td width="59" valign="top" >名称
</td>

<td width="70" valign="top" >nameLen

(short)
</td>

<td width="94" valign="top" >name

(bytes)
</td>

<td width="83" valign="top" >Replication

(short)
</td>

<td width="140" valign="top" >ModificationTime

(long)
</td>

<td width="120" valign="top" >access time

(long)
</td>
</tr>
<tr >

<td width="59" valign="top" >值举例
</td>

<td width="70" valign="top" >0006
</td>

<td width="94" valign="top" >2f 6862 6173 65(/hbase)
</td>

<td width="83" valign="top" >0000
</td>

<td width="140" valign="top" >00 0001 3c0a df04 30

("Sat Jan 05 21:20:53 CST 2013")
</td>

<td width="120" valign="top" >0000 0000 0000 0000
</td>
</tr>
</tbody>
</table>

<table >
<tbody >
<tr >

<td width="41" valign="top" >名称
</td>

<td width="190" valign="top" >preferred block size

(long)
</td>

<td width="53" valign="top" >Blocks

(int)
</td>

<td width="91" valign="top" >NsQuota

(long)
</td>

<td width="191" valign="top" >DsQuota

(long)
</td>
</tr>
<tr >

<td width="41" valign="top" >值举例
</td>

<td width="190" valign="top" >0000 0000 0000 0000
</td>

<td width="53" valign="top" >ffff ffff
</td>

<td width="91" valign="top" >ffff ffff ffff ffff
</td>

<td width="191" valign="top" >ffff ffff ffff ffff
</td>
</tr>
</tbody>
</table>

<table >
<tbody >
<tr >

<td width="43" valign="top" >名称
</td>

<td width="75" valign="top" >UsernameLen(var)
</td>

<td width="105" valign="top" >Username

(bytes)


</td>

<td width="89" valign="top" >Groupname Len(var)
</td>

<td width="131" valign="top" >Groupname

(bytes)
</td>

<td width="123" valign="top" >Permission

(short)
</td>
</tr>
<tr >

<td width="43" valign="top" >值举例
</td>

<td width="75" valign="top" >06
</td>

<td width="105" valign="top" >7a68 6f75 6868

(zhouhh)
</td>

<td width="89" valign="top" >0a
</td>

<td width="131" valign="top" >7375 7065 7267 726f 7570

(supergroup)
</td>

<td width="123" valign="top" >01ed
</td>
</tr>
</tbody>
</table>




**三、若从fsimage中读到的item是一个文件，则还会额外包含如下信息：**

1．namelen(short)：该文件的路径长度

2．Name(bytes): 该文件的路径，如"/user/zhouhh/README.txt"

3．replications(short)：副本数，为dfs.replication配置数目，缺省为3

4．mtime(long)：该文件的修改时间戳信息

5．atime(long)：该文件的访问时间戳信息

6．blocksize(long)：文件的blocksize，由dfs.block.size配置，缺省67108864，即0x4000000

7．numBlocks(int)：实际有多少个文件块，文件的该值都>=1，-1表示目录

8．blockid(long)：属于该文件的block的blockid，

9．numBytes(long)：该block的大小

10．genStamp(long)：该block的时间戳

11．username(String)：该文件的所属用户名，前面有个可变长度的长度描述，最长为int

12．group(String)：该文件的所属组，前面有个可变长度的长度描述，最长为int

13．permission(short)：该文件的permission信息，如644等，和POSIX权限保持一致。



其中7，8，9三个部分是可以循环的，因为一个文件可以存在于多个block。文件没有配额信息。

文件，按顺序格式

我配的dfs.replication为2
<table >
<tbody >
<tr >

<td width="59" valign="top" >名称
</td>

<td width="70" valign="top" >nameLen

(short)
</td>

<td width="108" valign="top" >name

(bytes)
</td>

<td width="78" valign="top" >Replication

(short)
</td>

<td width="132" valign="top" >ModificationTime

(long)
</td>

<td width="120" valign="top" >access time

(long)
</td>
</tr>
<tr >

<td width="59" valign="top" >值举例
</td>

<td width="70" valign="top" >0017
</td>

<td width="108" valign="top" >2f75 7365 722f 7a68 6f75 6868 2f52 4541 444d 452e 7478 74 (/user/zhouhh/README.txt)
</td>

<td width="78" valign="top" >0002
</td>

<td width="132" valign="top" >00 0001 3a01 2c3f 78
</td>

<td width="120" valign="top" >00 0001 3bcb aba6 ca
</td>
</tr>
</tbody>
</table>



<table >
<tbody >
<tr >

<td width="41" valign="top" >名称
</td>

<td width="190" valign="top" >preferred block size

(long)
</td>

<td width="189" valign="top" >Blocklen

(int)
</td>
</tr>
<tr >

<td width="41" valign="top" >值举例
</td>

<td width="190" valign="top" >00 0000 0004 0000 00
</td>

<td width="189" valign="top" >0000 0001
</td>
</tr>
</tbody>
</table>


Block 数据，循环 Blocklen次数
<table >
<tbody >
<tr >

<td width="41" valign="top" >名称
</td>

<td width="91" valign="top" >blockId(long)
</td>

<td width="191" valign="top" >numBytes(long)
</td>

<td width="190" valign="top" >generationStamp(long)
</td>
</tr>
<tr >

<td width="41" valign="top" >值举例
</td>

<td width="91" valign="top" >00 0200 0001 3a01 2c
</td>

<td width="191" valign="top" >00 0001 3a01 2c3f 78
</td>

<td width="190" valign="top" >00 0001 3bcb aba6 ca
</td>
</tr>
</tbody>
</table>



<table >
<tbody >
<tr >

<td width="43" valign="top" >名称
</td>

<td width="75" valign="top" >Usernamlen(var)
</td>

<td width="94" valign="top" >Username

(bytes)


</td>

<td width="87" valign="top" >Groupnamelen(var)
</td>

<td width="112" valign="top" >Groupname

(bytes)
</td>

<td width="103" valign="top" >Permission

(short)
</td>
</tr>
<tr >

<td width="43" valign="top" >值举例
</td>

<td width="75" valign="top" >06
</td>

<td width="94" valign="top" >7a68 6f75 6868

(zhouhh)
</td>

<td width="87" valign="top" >0a
</td>

<td width="112" valign="top" >7375 7065 7267 726f 7570

(supergroup)
</td>

<td width="103" valign="top" >01 a4
</td>
</tr>
</tbody>
</table>


**一个fsimage 16进制文件的一部分：**

    
    0000000: ffff ffe0 4e0a 6aed 0000 0000 0000 0046  ....N.j........F
    0000010: 0000 0000 0000 044f 0000 0000 0000 013c  .......O.......<
    0000020: 0adf 0430 0000 0000 0000 0000 0000 0000  ...0............
    0000030: 0000 0000 ffff ffff 0000 0000 7fff ffff  ................
    0000040: ffff ffff ffff ffff 067a 686f 7568 680a  .........zhouhh.
    0000050: 7375 7065 7267 726f 7570 01ed 0005 2f64  supergroup..../d
    0000060: 6174 6100 0000 0001 3c08 82c4 7e00 0000  ata.....


其中版本-32的值打印如下：

    
    >>> vs=-32
    >>> print "0x%08x"%(vs&0xffffffff)
    0xffffffe0
    public interface FSConstants {
    public static int MAX_PATH_LENGTH = 8000;
      public static final int LAYOUT_VERSION = -32;
    }
