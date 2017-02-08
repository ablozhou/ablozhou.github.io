---
author: abloz
comments: true
date: 2011-12-28 12:21:06+00:00
layout: post
link: http://abloz.com/index.php/2011/12/28/python-shi-xian-he-c-di-ip-socket-tong-xin/
slug: python-shi-xian-he-c-di-ip-socket-tong-xin
title: python 实现和 C的IP socket通信如何打包数据？
wordpress_id: 1469
categories:
- 技术
tags:
- c
- python
- struct
---

服务器端是C/C++写的，python用于客户端发送消息，进行通信。这种模式可以用于压力测试，方便修改协议。

**问题：**

1.python 对于组包和二进制的操作没有C语言那么方便，如何针对数据类型打包？

python作为方便的脚本语言，提供了很少的几种数据类型，和C语言不能一一对应。打通信包时，不能做到像C语言那样移动和操作指针。

2.对于变长的字符串变量如何打到python包中

struct中格式化字符串需指定长度，但如果字符串长度不是固定的，如何打包和解包呢？

解决办法： 用python 的struct来进行打包。struct提供pack,unpack,pack_into,unpack_from函数，提供与C语言对应的数据format。

3.二进制数据如何打包？



**1. 格式化二进制数据**

示例：

    
    import struct
    fmt="ii"
    buf = struct.pack(fmt,1,2)
    print repr(buf)


会将两个整形以二进制打到包中。程序执行结果：

    
    'x01x00x00x00x02x00x00x00'


格式和C语言类型的对应关系：
<table border="1" > 

<tr >
Format
C Type
Python type
Standard size
Notes
</tr>

<tbody valign="top" >
<tr >

<td >x
</td>

<td >pad byte
</td>

<td >no value
</td>

<td >
</td>

<td >
</td>
</tr>
<tr >

<td >c
</td>

<td >char
</td>

<td >string of length 1
</td>

<td >1
</td>

<td >
</td>
</tr>
<tr >

<td >b
</td>

<td >signed char
</td>

<td >integer
</td>

<td >1
</td>

<td >(3)
</td>
</tr>
<tr >

<td >B
</td>

<td >unsigned char
</td>

<td >integer
</td>

<td >1
</td>

<td >(3)
</td>
</tr>
<tr >

<td >?
</td>

<td >_Bool
</td>

<td >bool
</td>

<td >1
</td>

<td >(1)
</td>
</tr>
<tr >

<td >h
</td>

<td >short
</td>

<td >integer
</td>

<td >2
</td>

<td >(3)
</td>
</tr>
<tr >

<td >H
</td>

<td >unsigned short
</td>

<td >integer
</td>

<td >2
</td>

<td >(3)
</td>
</tr>
<tr >

<td >i
</td>

<td >int
</td>

<td >integer
</td>

<td >4
</td>

<td >(3)
</td>
</tr>
<tr >

<td >I
</td>

<td >unsigned int
</td>

<td >integer
</td>

<td >4
</td>

<td >(3)
</td>
</tr>
<tr >

<td >l
</td>

<td >long
</td>

<td >integer
</td>

<td >4
</td>

<td >(3)
</td>
</tr>
<tr >

<td >L
</td>

<td >unsigned long
</td>

<td >integer
</td>

<td >4
</td>

<td >(3)
</td>
</tr>
<tr >

<td >q
</td>

<td >long long
</td>

<td >integer
</td>

<td >8
</td>

<td >(2), (3)
</td>
</tr>
<tr >

<td >Q
</td>

<td >unsigned long long
</td>

<td >integer
</td>

<td >8
</td>

<td >(2), (3)
</td>
</tr>
<tr >

<td >f
</td>

<td >float
</td>

<td >float
</td>

<td >4
</td>

<td >(4)
</td>
</tr>
<tr >

<td >d
</td>

<td >double
</td>

<td >float
</td>

<td >8
</td>

<td >(4)
</td>
</tr>
<tr >

<td >s
</td>

<td >char[]
</td>

<td >string
</td>

<td >
</td>

<td >
</td>
</tr>
<tr >

<td >p
</td>

<td >char[]
</td>

<td >string
</td>

<td >
</td>

<td >
</td>
</tr>
<tr >

<td >P
</td>

<td >void *
</td>

<td >integer
</td>

<td >
</td>

<td >(5), (3)
</td>
</tr>
</tbody>
</table>
其中 p是pascal 类型的字符串，s是c语言类型字符串。format中可以增加一个长度描述。如"6i"表示6个整形。"20s"表示20个字节长度的字符串，而“20c”表示20个字节。format还可以指定字节序。
<table border="1" > 

<tr >
Character
Byte order
Size
Alignment
</tr>

<tbody valign="top" >
<tr >

<td >@
</td>

<td >native
</td>

<td >native
</td>

<td >native
</td>
</tr>
<tr >

<td >=
</td>

<td >native
</td>

<td >standard
</td>

<td >none
</td>
</tr>
<tr >

<td ><
</td>

<td >little-endian
</td>

<td >standard
</td>

<td >none
</td>
</tr>
<tr >

<td >>
</td>

<td >big-endian
</td>

<td >standard
</td>

<td >none
</td>
</tr>
<tr >

<td >!
</td>

<td >network (= big-endian)
</td>

<td >standard
</td>

<td >none
</td>
</tr>
</tbody>
</table>
网络字节序一般用“!”打头。

**2.给字符串变量打包**

可以对格式化字符串再格式化，填写变量长度

示例

    
    >>> a="test buf"
    >>> leng=len(a)
    >>> fmt="i%ds"%leng
    >>> buf=struct.pack(fmt,1,a)



    
    >>> print repr(buf)
    'x01x00x00x00test buf'


如果是单纯打包，stackoverflow给出一种方式，可以用于打变量字符串：

    
    #给字符串变量打包，给出长度
    struct.pack("I%ds" % (len(s),), len(s), s)
    
    #解包
    def unpack_helper(self,fmt, data):
        size = struct.calcsize(fmt)
        return struct.unpack(fmt, data[:size]), data[size:]
    
    fmt_head="!6i"
    head,probuf = self.unpack_helper(fmt_head,buf)






**3.打包二进制**

二进制包可以直接将二进制坠在格式化数据后面，可以用字符串的方式处理。

    
    >>> fmt1="!i"
    >>> buf2=struct.pack(fmt1,2)+buf1
    >>> print repr(buf2)
    'x00x00x00x02x01x00x00x00x02x00x00x00'




**4.实例 给一个二进制header后缀二进制数据**

suffix是后缀的二进制或字符串，leng 是header中用于描述后缀长度的变量，type是cmdtype

    
    def getheader(msgtype,leng,suffix):
        magic = 0
        sn=0
        ori_res=0
        # mtype=msgtype
        param = 0
        #mleng = leng
    
        fmt="!6i"
        buf = struct.pack(fmt,magic,sn,ori_res,msgtype,param,leng)+suffix




或者pack_into，可以pack到一个buf中

    
    def getheader(msgtype,leng,suffix):
        magic = 0
        sn=0
        ori_res=0
        # mtype=msgtype
        param = 0
        #mleng = leng
    
        buf = create_string_buffer(24+leng)
    
        fmt = "!6i%ds"%leng
        print fmt
        struct.pack_into(fmt,buf,0,magic,sn,ori_res,msgtype,param,leng,suffix)
        #print repr(buf.raw)
    
        #for test
        #b = struct.unpack_from(fmt,buf)
        #print b
        return buf


**总结：**

可以用python 库struct 来完全对应C语言的二进制通信，解决跨语言通信问题

**参考：**

[http://docs.python.org/library/struct.html#module-struct](http://docs.python.org/library/struct.html#module-struct)

[http://stackoverflow.com/questions/3753589/packing-and-unpacking-variable-length-array-string-using-the-struct-module-in-py](http://stackoverflow.com/questions/3753589/packing-and-unpacking-variable-length-array-string-using-the-struct-module-in-py)
