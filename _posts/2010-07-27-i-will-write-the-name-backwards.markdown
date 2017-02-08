---
author: abloz
comments: true
date: 2010-07-27 03:39:39+00:00
layout: post
link: http://abloz.com/index.php/2010/07/27/i-will-write-the-name-backwards/
slug: i-will-write-the-name-backwards
title: 将文本倒过来写防敏感词
wordpress_id: 297
categories:
- 技术
tags:
- gfw
- python
- 敏感词
---

现在GFW凶猛，加上什么自动抓取敏感词，email等手段，的确很烦人。不过，有一种技术手段，可以将文本反过来，但看起来却是正常的。用于抗拒过滤敏感词。

在支持html输入的地方，填写如下的style加反向文本：

    
    
    <span style="unicode-bidi:bidi-override; direction: rtl">moc.liamg@uohzolba</span>
    


效果：



```

moc.liamg@uohzolba

```


可以试着拷贝我的email，粘贴到文本文件，会发现我的email是你不认识的。看到的和实际的不一样。
由此可以所有文本或字符串经过处理颠倒后发表，GFW应该不会发现，流氓软件也不会抓到。

我实现了一个颠倒文本的python程序：

    
    
    #!/usr/bin/env python
    #author:ablozhou
    #date:2010.7.27
    #http://abloz.com
    #email:ablozhou@gmail.com
    #file:reverse.py
    import sys
    import getopt
    
    def usage():
    	print '''	usage: python reverse.py [options[=parameters]] |
    	[to_be_reversed_characters]
    	output: reversed file lines or reversed characters based on input
    	options:
    		-h,--help: display this help.
    		-f,--file=filename: input file name to be reversed.
    		-s, --string="string to reverse":reverse string
    	example:
    		python reverse.py --file=myfile.txt
    		python reverse.py -f myfile.txt
    		python reverse.py -s "ablozhou@gmail.com"
    		this will output "moc.liamg@uohzolba"'''
    
    def reversefile(filename):
    	lines=open(filename,'r').read().split('n')
    	for line in lines:
    		if not line:
    			continue
    		print reverse(line)
    def reverse(string):
    	return string.decode('utf8')[::-1]
    
    def main(argv):
    	try:
    		opts,args= getopt.getopt(argv, "h:f:s:", ["help", "file=", "string="])
    	except getopt.GetoptError:
    		usage()
    		sys.exit(2)
    	for opt, arg in opts:
    		if opt in ("-h", "--help"):
    			usage()
    			sys.exit()
    		elif opt in ("-f", "--file"):
    			reversefile(arg)
    		elif  opt in ("-s", "--string"):
    			r = reverse(arg)
    			print r
    if __name__ == "__main__":
    
    	main(sys.argv[1:])
    


执行示例

    
    
    zhouhh@zhh64:~/python$ python reverse.py -s "中华人民共和国"
    国和共民人华中
    



    
    
    zhouhh@zhh64:~/python$ vi myname.txt
    周海汉很喜欢写blog
    有空看看技术文档
    


保存

    
    
    zhouhh@zhh64:~/python$ python reverse.py --file="myname.txt"
    golb写欢喜很汉海周
    档文术技看看空有
    zhouhh@zhh64:~/python$ python reverse.py -f "myname.txt"
    golb写欢喜很汉海周
    档文术技看看空有
    



再放到style里：


    
    
    <span style="unicode-bidi:bidi-override; direction: rtl">
    golb写欢喜很汉海周
    档文术技看看空有
    </span>
    


可以看到变成了正常的文本：

```


golb写欢喜很汉海周
档文术技看看空有


```


本文在ubuntu 10.04上测试通过，适用于utf8编码。

