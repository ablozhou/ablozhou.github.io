---
author: abloz
comments: true
date: 2010-01-03 06:51:00+00:00
layout: post
link: http://abloz.com/index.php/2010/01/03/transfer-python-sort-chinese/
slug: transfer-python-sort-chinese
title: '[转]Python中文排序'
wordpress_id: 1005
categories:
- 技术
- 转载
---

from: http://gerry.lamost.org/blog/?p=338

 

Python比较字符串大小时，[根据的是ord函数得到的编码值](http://docs.python.org/reference/expressions.html#notin) 。基于它的排序函数sort可以很容易为数字和英文字母排序，因为它们在编码表中就是顺序排列的。


```
 

print ‘,’< '1'<'A'<'a'<'阿'  
True


```
 

但要很处理中文就没那么容易了。中文通常有拼音和笔画两种排序方式，在最常用中文标准字符集GB2312中，3755个一级中文汉字是按照拼音序进行编码的，而3008个二级汉字则是按部首笔画排列，


```
 

print ‘曙’< '鲑','曾'<'怡'  
True True


```
 

出现这样的结果是因为‘曙’和‘曾’都是常用字，而‘鲑’和‘怡’都是次常用字，但无论从笔画还是拼音来看，这两对顺序都应该反过来。后来扩充的GBK和GB18030编码为了向下兼容，都没有更改之前的汉字顺序，于是sort之后的次序就很乱了。  
  
另一方面unicode编码的中文是[按《康熙字典》的偏旁部首和笔画数来排列的](http://www.pkucn.com/viewthread.php?tid=189522&extra=&page=1) ，所以排序结果和GB编码又不一样。

  1. # encoding=utf8
  2. char=['赵','钱','孙','李','佘']
  3. char.sort()
  4. for item in char:
  5. print item.decode('utf-8').encode('gb2312')

的输出是：”佘孙李赵钱”；而保存成gb2312编码后

  1. # encoding=gb2312
  2. char=['赵','钱','孙','李','佘']
  3. char.sort()
  4. for item in char:
  5. print item

输出是：“李钱孙赵佘”。显然，这两个结果都不是我们想要的。那我们究竟怎样才能对中文正确排序呢？

先要弄清楚中文词典的排序规则：先按拼音排列，区分四声，拼音相同的就看笔画数目多少，笔画数也相同的再按笔顺中的具体笔划类型来区分，新华字典采用的顺序是一丨丿丶乙，[也称作“天上人间”](http://blog.cathayan.org/item/1537) ，应该没有笔划类型也完全一样的。所以中文排序不仅需要带音调的汉字拼音对照表，还需要有具体笔顺的数据。

本以为有现成的模块，试了几个都不理想。[pyzh](http://code.google.com/p/pyzh/) 的转换代码只支持不到7千字，而且还没有音调。[水木的roy的代码](http://www.newsmth.net/bbscon.php?bid=284&id=33938) 涵盖了2万多字符，但需要pysqlite支持……还是自立更生吧～

我找到最全的数据是slowwind9999上传到csdn的[unicode汉字编码表](http://download.csdn.net/source/291213) ，包括全部20902个汉字的全拼、五笔、郑码、UNICODE、GBK、笔画数    部首，以及笔顺编号（拼音部分没有音调，而且个别注音有误，如 囍，猤，啹等字，使用需注意。）我提取了其中的笔顺数据，又用江志键的“[实用汉字转拼音](http://sites.google.com/site/keniamafool/syhzzpy) ”程序制作了unicode汉字音调版，其中中文汉字用四声标注，319个日韩汉字没有音调以示区别，并根据汉典的数据略作修正（但仍可能存在错误）。有了这两个对照表，下面的工作就简单了。

  1. # 建立拼音辞典
  2. dic_py = dict()
  3. f_py = open('py.txt',"r")
  4. content_py = f_py.read()
  5. lines_py = content_py.split('n')
  6. n=len(lines_py)
  7. for i in range(0,n-1):
  8. word_py, mean_py = lines_py[i].split('t', 1)
  9. dic_py[word_py]=mean_py
  10. f_py.close()

笔顺字典的处理方法也完全相同，虽然文本有两万行，导入还是很快的，0.5秒左右。如果把这两个文件合并起来统一处理，应该可以更快。

  1. # 辞典查找函数
  2. def searchdict(dic,uchar):
  3. if isinstance(uchar, str):
  4. uchar = unicode(uchar,'utf-8')
  5. if uchar >= u'u4e00' and uchar< =u'u9fa5':
  6. value=dic.get(uchar.encode('utf-8'))
  7. if value == None:
  8. value = '*'
  9. else:
  10. value = uchar
  11. return value

查找中文，一律转为UTF8字符串，汉字外的其他字符不做处理，原样输出。如果需要声母，只输出拼音的第一个字符就是了。只要资料准确，比较起来就 很轻松了。数字在字母之前，爱（ai4）便会比昂（ang2）靠前，而笔顺值的位数代表了笔画数，数值对应笔划权重，直接比较数字大小就可以得到正确的顺 序。代码如下：

  1. #比较单个字符
  2. def comp_char_PY(A,B):
  3. if A==B:
  4. return -1
  5. pyA=searchdict(dic_py,A)
  6. pyB=searchdict(dic_py,B)
  7. if pyA > pyB:
  8. return 1
  9. elif pyA < pyB:
  10. return 0
  11. else:
  12. bhA=eval(searchdict(dic_bh,A))
  13. bhB=eval(searchdict(dic_bh,B))
  14. if bhA > bhB:
  15. return 1
  16. elif bhA < bhB:
  17. return 0
  18. else:
  19. return "Are you kidding?"
  20.   21. #比较字符串
  22. def comp_char(A,B):
  23. charA = A.decode("utf-8")
  24. charB = B.decode("utf-8")
  25. n=min(len(charA),len(charB))
  26. i=0
  27. while i < n:
  28. dd=comp_char_PY(charA[i],charB[i])
  29. if dd == -1:
  30. i=i+1
  31. if i==n:
  32. dd=len(charA)>len(charB)
  33. else:
  34. break
  35. return dd
  36.   37. # 排序函数
  38. def cnsort(nline):
  39. n = len(nline)
  40. lines="n".join(nline)
  41. for i in range(1, n): #插入法
  42. tmp = nline[i]
  43. j = i
  44. while j > 0 and comp_char(nline[j-1],tmp):
  45. nline[j] = nline[j-1]
  46. j -= 1
  47. nline[j] = tmp
  48. return nline

现在我们就可以按照字典的规范给中文排序了。

  1. char=['赵','钱','孙','李','佘']
  2. char=cnsort(char)
  3. for item in char:
  4. print item.decode('utf-8').encode('gb2312')

终于得到了“李钱佘孙赵”，样例文件[点此下载](http://gerry.lamost.org/upload/rar/cnsort.zip) 。  
这里我没有考虑多音字的情况。如果想让程序自动识别，可以增加多音词组对照表，通过上下文来判断。我不知道哪里有这样的数据，反正对于多音字不太多的情形，手动调整也就够了。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=3f8e9f35-0a17-8803-94a0-3f9e4d31455d)
