---
layout: post
title:  "a^b≡c(mod m)知二求一"
author: "周海汉"
date:   2018-06-28 19:28:26 +0800
categories: tech
tags:
    - 群论
    - 区块链
    - 加密
    - 抽象代数
    - 离散对数
    - 同余
    - 扩展欧几里德算法
    - 欧拉函数

---

# 概述 
$a^b\equiv c \pmod m$ 对已知m，知二求一。


## 1. 快速幂 求同余数
$a^b\equiv x \pmod m$,求x

如果a，b均较小，计算机可以直接计算。但如果a，b和m都比较大，需要进行简化。

两个性质：
### 性质1：

设

$$
a \equiv c \pmod m
$$

则

$$
a\times b \equiv c\times b \pmod m
$$

证明：

$$
a=km+c
a\times b = (km+c) \times b = kbm+cb

\equiv cb \pmod m
$$

### 性质2

设

$$
a \equiv c \pmod m
$$

则

$$
a^2 \equiv c^2 \pmod m
$$

证明

$$
a=km+c
a^2 = (km+c)^2 = (km)^2+2kcm+c^2

\equiv c^2\pmod m
$$


### 求解
如果(a，m)=1 互质，根据欧拉$a^{\phi m}\equiv 1 \pmod m$则可设


$$
b=k\phi(m)+c,c=b\mod {\phi(m)}

a^b = a^{k\phi(m)+b\mod {\phi(m)}}=a^{\phi(m)}\times a^{\phi(m)} \ldots a^{\phi(m)}\times a^{b\mod {\phi(m)}}
$$

取模后，


$$
a^b= a^{k\phi(m)+b\mod {\phi(m)}}=a^{\phi(m)}\times a^{\phi(m)} \ldots a^{\phi(m)}\times a^{b\mod {\phi(m)}}

\equiv 1\times 1 \times \ldots \times 1 \times  a^{b\mod {\phi(m)}} \pmod m

\equiv a^{b \mod {\phi m} } \pmod m
$$


# 2. 求指数
$a^x \equiv c \pmod m  $ 求x，x为整数。
如果a是m的原根，则是求$Ind_a m$
最简单的方式，就是将x的值从0开始尝试，不成功则+1再计算。但这种方式很低效。

BSGB(Baby step，Giant-step)算法采用空间换时间的方法。
问题可以转化为对阶数为m的循环群G，a是生成数，c是G的一个元素，转化为求
$a^x = c $
令$x=ki+j$ 其中$ k = \left\lceil \sqrt{m} \right\rceil , 0 \leq i < k ,   0 \leq j < k $
则可得到


$$
{\displaystyle c \left(\alpha ^{-k}\right)^{i}=\alpha ^{j}\,.}
$$

预先计算$a^j$各值,然后尝试i值。

## 计算步骤：
令 x=ki+j
求解 


$$
a^{ki+j}\equiv c \pmod m

(a^k)^i\times a^j \equiv c \pmod m
$$


1. 计算k值: k = Ceiling(√m)
2. 对每个 0 ≤ j < k:
计算 $a^j \mod m$ 并且保存键值对 $(j, a^j \mod m)$到一个Hashtable。 
3. 计算 $a^{k}$.
4. 对每个 i,  0 ≤ i < k:
检查 $(a^k)^i\times a^j \mod m$是否和c相等。 
如果相等，则返回 $ik + j$.
如果不等则 $i=i+1$,继续计算.

# 3. 求底数

## 欧几里德算法
欧几里德算法又叫辗转相除法，用于求最大公约数。
gcd(m,n)=gcd(n,m mod n)

证明：
假设m，n为整数，有最大公约数整数d, 且m>n


$$
m=kn+r

r=m \mod n

d|m,d|n

n=jd,m=ld

m=ld=kn+r=kjd+r

r=ld-kjd=(l-kj)d

\to
d|r

$$

## 裴蜀定理 Bézout's identity
裴蜀定理（或贝祖定理）得名于法国数学家艾蒂安·裴蜀，说明了对任何整数a、b和它们的最大公约
数d，关于未知数x和y的线性不定方程（称为裴蜀等式）：若a,b是整数,且（a,b)=d，那么对于任意的整数x,y,ax+by都一定是d的倍数，特别地，一定存在整数x,y，使ax+by=d成立。
它的一个重要推论是：a,b互质的充要条件是存在整数x,y使ax+by=1.

## 扩展欧几里德算法(Extended Euclidean algorithm)
对于不完全为 0 的非负整数 a，b，gcd（a，b）表示 a，b 的最大公约数，必然存在整数对 x，y ，使得 gcd（a，b）=ax+by。

根据欧几里德算法，我们设每次辗转相除是商数为$q_i$,余数为$r_i$,斐蜀系数$s_i,t_i$. 如果$r_{k+1}=0$,则$r_k=gcd(a,b)$,有$gcd(a,b)=r_k=as_k+bt_k$

设 $a=r_0,b=r_1$ 则有 $ s_{k+1}=\pm {\frac  {b}{\gcd(a,b)}} ,  t_{k+1}=\pm {\frac  {a}{\gcd(a,b)}}$

证明：
设 $a=r_0,b=r_1,s_0=1,s_1=0,t_0=0,t_1=1$，当i=0和1时，$  as_{i}+bt_{i}=r_{i}$ 成立。对所有i>1有:



$$
r_{i+1}=r_{i-1}-r_{i}q_{i}=(as_{{i-1}}+bt_{{i-1}})-(as_{i}+bt_{i})q_{i}=(as_{{i-1}}-as_{i}q_{i})+(bt_{{i-1}}-bt_{i}q_{i})=as_{i+1}+bt_{i+1}.
$$

辗转相除法一定会导致最后的余数为0.
令i+1 = k+1 时余数为0，$r_{i+1}=0$,则$r_{{i-1}}-r_{i}q_{i}=(as_{{i-1}}+bt_{{i-1}})-(as_{i}+bt_{i})q_{i}=0$ 得到
$(as_{{i-1}}+bt_{{i-1}})=(as_{i}+bt_{i})q_{i}$
此时 $gcd(a,b)=r_k=as_{i}+bt_{i},(i=k)$

## 推算
假设m为质数，用p代替，g为p的原根


$$
x^b\equiv c \pmod p

b*ind_gx \equiv ind_gc \pmod {\phi(p)}

t1=ind_gc 

g^{t1}\equiv c \pmod p

$$

t1可以由第二种情况解出。

令$t2=ind_gx$,则


$$
b*t2\equiv t1 \pmod {\phi(p)}
$$

由扩展欧几里得求出所有t2的值

$$
g^{t2}\equiv x \pmod p

$$

变成第一种情况，可以由快速幂求出x的值。


# 参考
[维基 大步小步BSGS算法](https://en.wikipedia.org/wiki/Baby-step_giant-step)

[维基 扩展欧几里德](https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm)


