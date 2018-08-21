---
layout: post
title:  "模逆元"
author: "周海汉"
date:   2018-08-21 19:28:26 +0800
categories: tech
tags:
    - 模逆元
    - 区块链
    - 加密
    - 抽象代数
    - 离散对数
    - 同余
    - 扩展欧几里德算法
    - 欧拉函数

---

模反元素也称为`模倒数`，或者`模逆元`。

一整数a对 同余n之`模反元素`是指满足以下公式的整数 b
$
a^{-1} \equiv b \pmod{n}.
$
也可以写成以下的式子
$ ab \equiv 1 \pmod{n}.$

整数 a 对模数 n 之模反元素存在的`充分必要条件`是 a 和 n `互质`，若此模反元素存在，在模数 n 下的除法可以用和对应模反元素的乘法来达成，此概念和实数除法的概念相同。

## 求模反元素 `
### 用扩展欧几里得算法

设exgcd(a,n)为扩展欧几里得算法的函数，则可得到ax+ny=g，g是a,n的最大公因数。

#### 若 $ g=1$ 
则该模反元素存在，根据结果$ ax+ny=1$

在 mod n 之下，$ ax+ny \equiv ax \equiv 1$，根据模反元素的定义$ a \cdot a^{-1} \equiv 1$，此时x即为a关于模n的其中一个模反元素。

事实上，$ x+kn(k \in \mathbb{Z})$ 都是a关于模n的模反元素，这里我们取最小的正整数解x mod n（x<n）。

#### 若 $ g\ne 1$ 
则该模反元素''不存在''。

因为根据结果$ ax+ny\ne 1$，在 mod n 之下，$ ax \equiv g(g<n)$不会同余于$ 1$，因此满足$ a \cdot a^{-1} \equiv 1$的$ a^{-1}$不存在。


### 用欧拉定理 (数论)|欧拉定理 

欧拉定理证明当$ a,n$为两个`互质`的`正整数`时，则有$ a^{\varphi(n)} \equiv 1 \pmod n$，其中$ \varphi(n)$为`欧拉函数`（小于等于$ n$且与$ n$互质的正整数个数）。

上述结果可分解为$ a^{\varphi(n)} = a \cdot a^{\varphi(n) - 1} \equiv 1 \pmod n$，其中$ a^{\varphi(n) - 1}$即为$ a$关于模$ n$之模反元素。

## 举例 
求整数3对同余11的模逆元素''x'',
$ x \equiv 3^{-1} \pmod{11}$
上述方程可变换为
$ 3x \equiv 1 \pmod{11}$
在整数范围$ \mathbb{Z}_{11}$内，可以找到满足该同余等式的''x''值为4，如下式所示
$ 3 (4) = 12 \equiv 1 \pmod{11}$
并且，在整数范围$ \mathbb{Z}_{11}$内不存在其他满足此同余等式的值。<br />

故，整数3对同余11的模逆元素为4。<br />

一旦在整数范围$ \mathbb{Z}_{11}$内找到3的模逆元素，其他在整数范围$ \mathbb{Z}_{11}$ 内满足此同余等式的模逆元素值便可很容易地写出——只需加上{{nowrap|1=''m'' # ''11''}} 的倍数便可。<br />

综上，所有整数3对同余11的模逆元素''x''可表示为

$ 4 + (11 \cdot z ), z \in \mathbb{Z}$

即 {..., −18, −7, `4`, 15, 26, ...}.

# 参考
[wiki 模逆元](https://zh.wikipedia.org/wiki/%E6%A8%A1%E5%8F%8D%E5%85%83%E7%B4%A0)
[wiki Modular_multiplicative_inverse](https://en.wikipedia.org/wiki/Modular_multiplicative_inverse)

