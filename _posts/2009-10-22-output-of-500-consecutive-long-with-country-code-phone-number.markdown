---
author: abloz
comments: true
date: 2009-10-22 06:45:00+00:00
layout: post
link: http://abloz.com/index.php/2009/10/22/output-of-500-consecutive-long-with-country-code-phone-number/
slug: output-of-500-consecutive-long-with-country-code-phone-number
title: 输出500个连续的带国家区号的长电话号码
wordpress_id: 935
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

2009.10.22

 

因为要批量处理电话号码，需要文本一行一个电话。

 

1. bash 处理，很直接

[zhouhh@p-ssw-2 ~]$ vi for.sh

 

[  
](http://blog.csdn.net/ablo_zhou/archive/2009/10/22/4713148.aspx#)[](http://blog.csdn.net/ablo_zhou/archive/2009/10/22/4713148.aspx#)

  1. #!/bin/sh
  2.   3. for (( x = 8601060000000; x < 8601060000500; x++))
  4. do
  5. echo "$x"
  6. done

#!/bin/sh  for (( x = 8601060000000; x < 8601060000500; x++)) do  echo "$x" done    

[zhouhh@p-ssw-2 ~]$chmod +x for.sh

[zhouhh@p-ssw-2 ~]$ ./for.sh  
8601060000000  
8601060000001  
8601060000002  
8601060000003  
...

8601060000498  
8601060000499

[zhouhh@p-ssw-2 ~]$ ./for.sh >telcode

 

2. python 处理

 

[zhouhh@p-ssw-2 ~]$ vi code.py

[  
](http://blog.csdn.net/ablo_zhou/archive/2009/10/22/4713148.aspx#)[](http://blog.csdn.net/ablo_zhou/archive/2009/10/22/4713148.aspx#)

  1. for x in range(8601060000000,8601060000500):
  2. print x

for x in range(8601060000000,8601060000500):        print x    

[zhouhh@p-ssw-2 ~]$ python code.py 

8601060000000  
8601060000001  
8601060000002  
8601060000003  
...

8601060000498  
8601060000499

 

3. python另一种处理，使用xrange

[  
](http://blog.csdn.net/ablo_zhou/archive/2009/10/22/4713148.aspx#)[](http://blog.csdn.net/ablo_zhou/archive/2009/10/22/4713148.aspx#)

  1. for x in xrange(0,500):
  2. print 8601060000000+x

for x in xrange(0,500):        print 8601060000000+x    

OverflowError: long int too large to convert to int

 

因为xrange 的参数太大会导致溢出，所以修改了一下写法。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=cca2271a-b69b-8e87-9945-065eb33bf49c)
