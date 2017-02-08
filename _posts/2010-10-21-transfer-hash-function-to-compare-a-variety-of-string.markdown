---
author: abloz
comments: true
date: 2010-10-21 03:41:11+00:00
layout: post
link: http://abloz.com/index.php/2010/10/21/transfer-hash-function-to-compare-a-variety-of-string/
slug: transfer-hash-function-to-compare-a-variety-of-string
title: '[转]各种字符串Hash函数比较'
wordpress_id: 881
categories:
- 技术
- 转载
---






from http://hi.baidu.com/whuwinnie/blog/item/4c24e54c1410b5f1d62afc61.html




常用的字符串Hash函数还有ELFHash，APHash等等，都是十分简单有效的方法。这些函数使用

位运算使得每一个字符都对最后的函数值产生影响。另外还有以MD5和SHA1为代表的杂凑函数，

这些函数几乎不可能找到碰撞。

常用字符串哈希函数有BKDRHash，APHash，DJBHash，JSHash，RSHash，SDBMHash，

PJWHash，ELFHash等等。对于以上几种哈希函数，我对其进行了一个小小的评测。
<table border="1" > 
<tbody >
<tr height="19" >

<td >Hash函数
</td>

<td >数据1
</td>

<td >数据2
</td>

<td >数据3
</td>

<td >数据4
</td>

<td >数据1得分
</td>

<td >数据2得分
</td>

<td >数据3得分
</td>

<td >数据4得分
</td>

<td >平均分
</td>
</tr>
<tr height="19" >

<td >BKDRHash
</td>

<td align="right" >2
</td>

<td align="right" >0
</td>

<td align="right" >4774
</td>

<td align="right" >481
</td>

<td align="right" >96.55
</td>

<td align="right" >100
</td>

<td align="right" >90.95
</td>

<td align="right" >82.05
</td>

<td align="right" >92.64
</td>
</tr>
<tr height="19" >

<td >APHash
</td>

<td align="right" >2
</td>

<td align="right" >3
</td>

<td align="right" >4754
</td>

<td align="right" >493
</td>

<td align="right" >96.55
</td>

<td align="right" >88.46
</td>

<td align="right" >100
</td>

<td align="right" >51.28
</td>

<td align="right" >86.28
</td>
</tr>
<tr height="19" >

<td >DJBHash
</td>

<td align="right" >2
</td>

<td align="right" >2
</td>

<td align="right" >4975
</td>

<td align="right" >474
</td>

<td align="right" >96.55
</td>

<td align="right" >92.31
</td>

<td align="right" >0
</td>

<td align="right" >100
</td>

<td align="right" >83.43
</td>
</tr>
<tr height="19" >

<td >JSHash
</td>

<td align="right" >1
</td>

<td align="right" >4
</td>

<td align="right" >4761
</td>

<td align="right" >506
</td>

<td align="right" >100
</td>

<td align="right" >84.62
</td>

<td align="right" >96.83
</td>

<td align="right" >17.95
</td>

<td align="right" >81.94
</td>
</tr>
<tr height="19" >

<td >RSHash
</td>

<td align="right" >1
</td>

<td align="right" >0
</td>

<td align="right" >4861
</td>

<td align="right" >505
</td>

<td align="right" >100
</td>

<td align="right" >100
</td>

<td align="right" >51.58
</td>

<td align="right" >20.51
</td>

<td align="right" >75.96
</td>
</tr>
<tr height="19" >

<td >SDBMHash
</td>

<td align="right" >3
</td>

<td align="right" >2
</td>

<td align="right" >4849
</td>

<td align="right" >504
</td>

<td align="right" >93.1
</td>

<td align="right" >92.31
</td>

<td align="right" >57.01
</td>

<td align="right" >23.08
</td>

<td align="right" >72.41
</td>
</tr>
<tr height="19" >

<td >PJWHash
</td>

<td align="right" >30
</td>

<td align="right" >26
</td>

<td align="right" >4878
</td>

<td align="right" >513
</td>

<td align="right" >0
</td>

<td align="right" >0
</td>

<td align="right" >43.89
</td>

<td align="right" >0
</td>

<td align="right" >21.95
</td>
</tr>
<tr height="19" >

<td >ELFHash
</td>

<td align="right" >30
</td>

<td align="right" >26
</td>

<td align="right" >4878
</td>

<td align="right" >513
</td>

<td align="right" >0
</td>

<td align="right" >0
</td>

<td align="right" >43.89
</td>

<td align="right" >0
</td>

<td align="right" >21.95
</td>
</tr>
</tbody>
</table>
其中数据1为100000个字母和数字组成的随机串哈希冲突个数。数据2为100000个有意义的英文句

子哈希冲突个数。数据3为数据1的哈希值与1000003(大素数)求模后存储到线性表中冲突的个数。

数据4为数据1的哈希值与10000019(更大素数)求模后存储到线性表中冲突的个数。

经过比较，得出以上平均得分。平均数为平方平均数。可以发现，BKDRHash无论是在实际效果还是

编码实现中，效果都是最突出的。APHash也是较为优秀的算法。DJBHash,JSHash,RSHash与

SDBMHash各有千秋。PJWHash与ELFHash效果最差，但得分相似，其算法本质是相似的。

在信息修竞赛中，要本着易于编码调试的原则，个人认为BKDRHash是最适合记忆和使用的。

CmYkRgB123原创，欢迎建议、交流、批评和指正。

附：各种哈希函数的C语言程序代码





    
    
    unsigned int SDBMHash(char *str)
    {
        unsigned int hash = 0;
    
        while (*str)
        {
            // equivalent to: hash = 65599*hash + (*str++);
            hash = (*str++) + (hash << 6) + (hash << 16) - hash;
        }
    
        return (hash & 0x7FFFFFFF);
    }
    
    // RS Hash
    unsigned int RSHash(char *str)
    {
        unsigned int b = 378551;
        unsigned int a = 63689;
        unsigned int hash = 0;
    
        while (*str)
        {
            hash = hash * a + (*str++);
            a *= b;
        }
    
        return (hash & 0x7FFFFFFF);
    }
    
    // JS Hash
    unsigned int JSHash(char *str)
    {
        unsigned int hash = 1315423911;
    
        while (*str)
        {
            hash ^= ((hash << 5) + (*str++) + (hash >> 2));
        }
    
        return (hash & 0x7FFFFFFF);
    }
    
    // P. J. Weinberger Hash
    unsigned int PJWHash(char *str)
    {
        unsigned int BitsInUnignedInt = (unsigned int)(sizeof(unsigned int) * 8);
        unsigned int ThreeQuarters = (unsigned int)((BitsInUnignedInt * 3) / 4);
        unsigned int OneEighth = (unsigned int)(BitsInUnignedInt / 8);
        unsigned int HighBits = (unsigned int)(0xFFFFFFFF) << (BitsInUnignedInt
    
                                                               - OneEighth);
        unsigned int hash = 0;
        unsigned int test = 0;
    
        while (*str)
        {
            hash = (hash << OneEighth) + (*str++);
            if ((test = hash & HighBits) != 0)
            {
                hash = ((hash ^ (test >> ThreeQuarters)) & (~HighBits));
            }
        }
    
        return (hash & 0x7FFFFFFF);
    }
    
    // ELF Hash
    unsigned int ELFHash(char *str)
    {
        unsigned int hash = 0;
        unsigned int x = 0;
    
        while (*str)
        {
            hash = (hash << 4) + (*str++);
            if ((x = hash & 0xF0000000L) != 0)
            {
                hash ^= (x >> 24);
                hash &= ~x;
            }
        }
    
        return (hash & 0x7FFFFFFF);
    }
    
    // BKDR Hash
    unsigned int BKDRHash(char *str)
    {
        unsigned int seed = 131; // 31 131 1313 13131 131313 etc..
        unsigned int hash = 0;
    
        while (*str)
        {
            hash = hash * seed + (*str++);
        }
    
        return (hash & 0x7FFFFFFF);
    }
    
    // DJB Hash
    unsigned int DJBHash(char *str)
    {
        unsigned int hash = 5381;
    
        while (*str)
        {
            hash += (hash << 5) + (*str++);
        }
    
        return (hash & 0x7FFFFFFF);
    }
    
    // AP Hash
    unsigned int APHash(char *str)
    {
        unsigned int hash = 0;
        int i;
    
        for (i=0; *str; i++)
        {
            if ((i & 1) == 0)
            {
                hash ^= ((hash << 7) ^ (*str++) ^ (hash >> 3));
            }
            else
            {
                hash ^= (~((hash << 11) ^ (*str++) ^ (hash >> 5)));
            }
        }
    
        return (hash & 0x7FFFFFFF);
    }
    
    
