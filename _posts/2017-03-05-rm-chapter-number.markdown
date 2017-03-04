---
layout: post
title:  "书籍标题中章节号js正则去除"
date:   2017-03-5 00:17:26 +0800
categories: 技术
---
书籍标题中章节号js正则去除
- 周海汉
- http://abloz.com
- 2017.3.4

书籍中的章节, 经常会有序号. 但有时需要在前端展示时将其隐去.
如"第一篇 开天辟地", 执行后只剩下"开天辟地"

本文主要是用js在前端隐藏序号, 避免直接编辑源文件.
来源:http://abloz.com


章节序号有如下千奇百怪的形式:

1. 第一篇    第一章    第一节
2. 一、（一）
3. 1、1） （1）    
4. utf8字符 ①  ②⑴|⑵ ⒈|⒉  
5. "1." 1.1 1.1.1    1.1.1.1
6. 罗马数字：Ⅰ Ⅱ Ⅲ Ⅳ Ⅴ Ⅵ Ⅶ Ⅷ Ⅸ Ⅹ Ⅺ Ⅻ   ⅰ ⅱ  ⅳ ⅴ ⅵ ⅶ ⅷ ⅸ ⅹ   

# 测试第x篇章节
采用String的replace正则处理
```javascript

a="第十一节 标题"
a.replace(/第.*\ /i,"")
a.replace(/第.*[篇|章|节|页]\ */i,"")

var str1="第十一节 标题"
var patt="^第.*[篇|章|节|页]\ *|^.*[、|）|\)]\ *"
var reg = new RegExp(patt,"i");
str1.replace(reg,"")
//标题
reg.test(str1)
//true
reg.exec(str1)
//["第十一节 "]
str1.match(reg)
//["第十一节 "]
```
# 改写成原型函数
改写成String原型函数,简化调用
```javascript

String.prototype.rmChapNum = function(reg, replaceWith) {  
    if (!RegExp.prototype.isPrototypeOf(reg)) {  
        return this.replace(new RegExp(reg, "i"), replaceWith);  
    } else {  
        return this.replace(reg, replaceWith);  
    }  
} 

```
# 第X篇章节去除
```js
pat= "^第.*[篇|章|节][.|、]{0,1}\\ *"
var str1 = "第十一节 标题"
str1.rmChapNum(pat,"")
//"标题"
str2 = "第十一节、 标题"
str2.rmChapNum(pat,"")
"标题"
```
# 类似1.2.3章节标题去除
```js
pat="^[\\d|\\.]+[、]{0,1}\\ *"
st1='1.1.3.1 标题1.1.3.1'
st1.rmChapNum(pat,"")
"标题1.1.3.1"

```
# 罗马字符章节号去除
```javascript
var romr = "^[I{1,3}|IX|IV|V?I{0,3}|X]+[\.|、]{0,1}\ *"
str2="XII 问题"
str2.rmChapNum(romr,"")
"问题"
str3="XII. 说明"
"XII. 说明"
str3.rmChapNum(romr,"")
"说明"
str4="VI 标题"
"VI 标题"
str4.rmChapNum(romr,"")
"标题"
str5="VIII标题"
"VIII标题"
str5.rmChapNum(romr,"")
"标题"
```

# 处理中英文数字
```js
str6='十一、 标题'
di='^[（|一|二|三|四|五|六|七|八|九|十|\\d]+[.|、|）]{0,1}\\ *'
str6.rmChapNum(di,"")
"标题"
str7="（一）标题"
str8="1、标题"
str9="1）标题"
str10="（1）标题"
str8.rmChapNum(di,"")
"标题"
str7.rmChapNum(di,"")
"标题"
str6.rmChapNum(di,"")
"标题"
str9.rmChapNum(di,"")
"标题"
str10.rmChapNum(di,"")
"标题"
```

# 处理特殊字符
① ②等特殊字符, unicode只到⑳止.
utf8编码从'\xe2\x91\xa0'到'\xe2\x91\xb3'. 这里我们处理到⑯. 顺便将⑴-⒃和⒈这样的特殊字符都处理了

```js
di='^[①|②|③|④|⑤|⑥|⑦|⑧|⑨|⑩|⑪|⑫|⑬|⑭|⑮|⑯|⑴|⑵|⑶|⑷|⑸|⑹|⑺|⑻|⑼|⑽|⑾|⑿|⒀|⒁|⒂|⒃|⒈|⒉|⒊|⒋|⒌|⒍|⒎|⒏|⒐|⒑|⒒|⒓|⒔|⒕|⒖|⒗]+[.|、]{0,1}\ *'
s1='① 标题'
"① 标题"
s1.rmChapNum(di,"")
"标题"
s2='①标题'
"①标题"
s1.rmChapNum(di,"")
"标题"
s2.rmChapNum(di,"")
"标题"
s3='①. 标题'
"①. 标题"
s3.rmChapNum(di,"")
"标题"
s4='⒃ 标题16'
"⒃ 标题16"
s4.rmChapNum(di,"")
"标题16"
```
# 统一处理
```js
pat1= "^第.*[篇|章|节][\\.|、]{0,1}\\ *"
//1.2.3, 1).
pat2="^[\\d|\\.]+[、|）]{0,1}\\ *"
pat3 = "^[I{1,3}|IX|IV|V?I{0,3}|X]+[\\.|、]{0,1}\\ *"
pat4='^[（|一|二|三|四|五|六|七|八|九|十|\\d]+[\\.|、|）]{0,1}\\ *'
pat5='^[①|②|③|④|⑤|⑥|⑦|⑧|⑨|⑩|⑪|⑫|⑬|⑭|⑮|⑯|⑴|⑵|⑶|⑷|⑸|⑹|⑺|⑻|⑼|⑽|⑾|⑿|⒀|⒁|⒂|⒃|⒈|⒉|⒊|⒋|⒌|⒍|⒎|⒏|⒐|⒑|⒒|⒓|⒔|⒕|⒖|⒗]+[\\.|、]{0,1}\\ *'
pats=[]
pats.push(pat1)
pats.push(pat2)
pats.push(pat3)
pats.push(pat4)
pats.push(pat5)
pat=pats.join("|")
"^第.*[篇|章|节][\.|、]{0,1}\ *|^[\d|\.]+[、|）]{0,1}\ *|^[I{1,3}|IX|IV|V?I{0,3}|X]+[\.|、]{0,1}\ *|^[（|一|二|三|四|五|六|七|八|九|十|\d]+[\.|、|）]{0,1}\ *|^[①|②|③|④|⑤|⑥|⑦|⑧|⑨|⑩|⑪|⑫|⑬|⑭|⑮|⑯|⑴|⑵|⑶|⑷|⑸|⑹|⑺|⑻|⑼|⑽|⑾|⑿|⒀|⒁|⒂|⒃|⒈|⒉|⒊|⒋|⒌|⒍|⒎|⒏|⒐|⒑|⒒|⒓|⒔|⒕|⒖|⒗]+[\.|、]{0,1}\ *"

//测试
str1
"第十一节 标题"
str1.rmChapNum(pat,"")
str2
"第十一节、 标题"
str2.rmChapNum(pat,"")
"标题"
st1
"1.1.3.1 标题1.1.3.1"
st1.rmChapNum(pat,"")
"标题1.1.3.1"
st2="一、 最后说明"
"一、 最后说明"
st2.rmChapNum(pat,"")
"最后说明"

str3
"XII. 说明"
str3.rmChapNum(pat,"")
"说明"
str5
"VIII标题"
str5.rmChapNum(pat,"")
"标题"

"标题"
str7
"（一）标题"
str7.rmChapNum(pat,"")
"标题"
str8
"1、标题"
str8.rmChapNum(pat,"")
"标题"
str9
"1）标题"
str9.rmChapNum(pat,"")
"标题"
str10
"（1）标题"
str10.rmChapNum(pat,"")
"标题"

s1.rmChapNum(pat,"")
"标题"
s1
"① 标题"
s4
"⒃ 标题16"
s4.rmChapNum(pat,"")
"标题16"
```

