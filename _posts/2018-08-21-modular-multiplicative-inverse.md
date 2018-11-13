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

一整数a对 同余n之`模反元素`是指满足以下公式的整数 b:

$$
a^{-1} \equiv b \pmod{n}.
$$

也可以写成以下的式子
$$ ab \equiv 1 \pmod{n}.$$

如果不看mod运算，这类似于ab=1,那么a和b互为倒数。a、b为整数。
例如，对于模12来说，5和5互为模12的逆元。这是因为5*5=25 mod 12 = 1


整数 a 对模数 n 之模反元素存在的`充分必要条件`是 a 和 n `互质`，若此模反元素存在，在模数 n 下的除法可以用和对应模反元素的乘法来达成，此概念和实数除法的概念相同。

## 求模反元素 `
### 用扩展欧几里得算法(Extended Euclidean algorithm)

设exgcd(a,n)为扩展欧几里得算法的函数，则可得到ax+ny=g，g是a,n的最大公因数。

#### 若 $ g=1$ 
则该模反元素存在，根据结果$ ax+ny=1$

在 mod n 之下，$ ax+ny \equiv ax \equiv 1$，根据模反元素的定义$ a \cdot a^{-1} \equiv 1$，此时x即为a关于模n的其中一个模反元素。

事实上，$ x+kn(k \in \mathbb{Z})$ 都是a关于模n的模反元素，这里我们取最小的正整数解x mod n（x<n）。

#### 若 $ g\ne 1$ 
则该模反元素''不存在''。

因为根据结果$ ax+ny\ne 1$，在 mod n 之下，$ ax \equiv g(g<n)$不会同余于$ 1$，因此满足$ a \cdot a^{-1} \equiv 1$的$ a^{-1}$不存在。

#### 示例
已知整数a、b，扩展欧几里得算法可以在求得a、b的最大公约数的同时，能找到整数x、y（其中一个很可能是负数），使它们满足贝祖等式

$ ax + by = \gcd(a, b)$
通常谈到最大公约数时，我们都会提到一个非常基本的事实：给予二个整数a、b，必存在整数x、y使得ax + by = gcd(a,b)

用类似辗转相除法，求二元一次不定方程 $ \textstyle 47x+30y=1$ 的整数解。

$\displaystyle 47=30\times 1+17$

$\displaystyle 30=17\times 1+13$

$\displaystyle 17=13\times 1+4$

$\displaystyle 13=4\times 3+1$$

然后把它们改写成“余数等于”的形式

$\displaystyle 17=47\times 1+30\times (-1)$ //式1

$\displaystyle 13=30\times 1+17\times (-1)$ //式2

$\displaystyle 4=17\times 1+13\times (-1)$ //式3

$\displaystyle 1=13\times 1+4\times (-3)$

然后把它们“倒回去”

$\displaystyle 1=13\times 1+4\times (-3)$

$\displaystyle 1=13\times 1+[17\times 1+13\times (-1)]*(-3)$ //应用式3

$\displaystyle 1=17\times (-3)+13\times 4$

$\displaystyle 1=17\times (-3)+[30\times 1+17\times (-1)]\times 4$//应用式2

$\displaystyle 1=30\times 4+17\times (-7)$

$\displaystyle 1=30\times 4+[47\times 1+30\times (-1)]\times (-7)$ //应用式1

$\displaystyle 1=47\times (-7)+30\times 11$

得解 $\displaystyle x=-7,y=11$。

### 用欧拉定理 (数论)|欧拉定理 

欧拉定理证明当$ a,n$为两个`互质`的`正整数`时，则有$ a^{\varphi(n)} \equiv 1 \pmod n$，其中$ \varphi(n)$为`欧拉函数`（小于等于$ n$且与$ n$互质的正整数个数）。

上述结果可分解为$ a^{\varphi(n)} = a \cdot a^{\varphi(n) - 1} \equiv 1 \pmod n$，其中$ a^{\varphi(n) - 1}$即为$ a$关于模$ n$之模反元素。

## 举例 
求整数3对同余11的模逆元素''x'',
$ x \equiv 3^{-1} \pmod{11}$
上述方程可变换为
$ 3x \equiv 1 \pmod{11}$
在整数范围 $ \mathbb{Z}_{11} $ 内，可以找到满足该同余等式的x值为4，如下式所示
$$ 3  (4) = 12 \equiv 1 \pmod{11} $$
并且，在整数范围 $ \mathbb{Z}_{11} $ 内不存在其他满足此同余等式的值。

故，整数3对同余11的模逆元素为4。

一旦在整数范围 $ \mathbb{Z}_{11} $ 内找到3的模逆元素，其他在整数范围 $ \mathbb{Z}_{11} $ 内满足此同余等式的模逆元素值便可很容易地写出——只需加上m = 11 的倍数便可。<br />

综上，所有整数3对同余11的模逆元素 x 可表示为

$ 4 + (11 \cdot z ), z \in \mathbb{Z}$

即 {..., −18, −7, 4, 15, 26, ...}.

# 参考
- [wiki 模逆元](https://zh.wikipedia.org/wiki/%E6%A8%A1%E5%8F%8D%E5%85%83%E7%B4%A0)
- [wiki Modular_multiplicative_inverse](https://en.wikipedia.org/wiki/Modular_multiplicative_inverse)
- [wiki 扩展欧几里德算法](https://zh.wikipedia.org/wiki/%E6%89%A9%E5%B1%95%E6%AC%A7%E5%87%A0%E9%87%8C%E5%BE%97%E7%AE%97%E6%B3%95)
- [阮一峰 RSA算法原理(一)](http://www.ruanyifeng.com/blog/2013/06/rsa_algorithm_part_one.html)
- [阮一峰 RSA算法原理(二)](http://www.ruanyifeng.com/blog/2013/07/rsa_algorithm_part_two.html)

