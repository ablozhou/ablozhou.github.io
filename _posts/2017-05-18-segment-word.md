---
layout: post
title:  ""
date:   2017-05-18 20:18:26 +0800
categories: tech
tags:
    - 分词
    - 自然语言处理
---

# 分词代码

```python

# -*- coding:utf-8 -*-
   
#简单的支持中文的正向最大匹配的机械分词
   
import string
__dict = {}
   
def load_dict(dict_file='words.dic'):
    #加载词库，把词库加载成一个key为首字符，value为相关词的列表的字典
   
    words = [line.split() for line in open(dict_file)]
    
    for word in words:
        
        first_char = word[0][0]
        __dict.setdefault(first_char, [])
        __dict[first_char].append(word[0])
      
    #按词的长度倒序排列
    for first_char, twords in __dict.items():
        __dict[first_char] = sorted(twords, key=lambda x:len(x), reverse=True)
   
def __match_ascii(i, input):
    #返回连续的英文字母，数字，符号, 对英文,字母,符号不处理
    result = ''
    for i in range(i, len(input)):
        if  input[i] in string.printable: # and input[i] not in string.whitespace: #string.ascii_letters or input[i] in string.digits: 
            result += input[i]
        else:
            break
    
    return result.strip()
   
   
def __match_word(first_char, i , input):
    #根据当前位置进行分词，ascii的直接读取连续字符，中文的读取词库
   
    if not __dict.get(first_char):
        try:
            if first_char in string.printable: #string.ascii_letters or first_char in string.digits:

                return __match_ascii(i, input)
        except:
            print('except:',first_char,chr(first_char))
        return first_char
   
    words = __dict[first_char]
    for word in words:
        if input[i:i+len(word)] == word:
            return word
   
    return first_char
   
def tokenize(input):
    #对input进行分词
   
    if not input: return []
   
    tokens = []
    i = 0
    while i < len(input):
        first_char = input[i]
        matched_word = __match_word(first_char, i, input)
        tokens.append(matched_word)
        i += len(matched_word)
   
    return tokens
   
   
if __name__ == '__main__':
    def get_test_text():
        import requests
        url = "http://www.zhb.gov.cn/xxgk/gzdt/201703/t20170321_408538.shtml"
        #url="http://mil.news.sina.com.cn/2016-12-30/doc-ifxzczff3445251.shtml"
        #text = requests.get(url).content
        text = requests.get(url,'utf8').content
        #return text.decode('gbk')
        #print(text.decode('utf8'))
        return text.decode('utf8')
   
    def load_dict_test():
        load_dict()
        i=0;
        for first_char, words in __dict.items():
            print('%d. %s:%s' % (i,first_char, ' '.join(words)))
            i=i+1
            if i>10:
                break
            
   
    def tokenize_test(text):
        load_dict()
        tokens = tokenize(text)
        for token in tokens:
            print(token)
            
    #load_dict_test()
    tokenize_test('美丽的花园里有各种各样的小动物')
    tokenize_test('他购买了一盒Rosetta Stone品牌的SHA-PA型号24/6的订书钉，总价￥24.3元.')
    tokenize_test('1949年10月1日，毛主席站在天安门城楼上庄严宣布：中华人民共和国中央人民政府成立了！');
    tokenize_test('A Happy New Yeear and a Merry Christmas💕')
    tokenize_test('他们俩有意见分歧')
    tokenize_test('登上海南公司的航班')
    
    tokenize_test('季莫申科拒监禁期间穿囚服和服劳役')
    tokenize_test('南京市长江大桥')
    tokenize_test('李克强调研长春市长春药店')
    #tokenize_test(get_test_text())
    
```

# 结果
美丽
的
花园里
有
各种各样
的
小动物

他
购买了
一盒
Rosetta Stone
品牌
的
SHA-PA
型号
24/6
的
订书钉
，
总价
￥
24.3
元
.

1949
年
10
月
1
日
，
毛主席
站在
天安门城楼
上
庄严
宣布
：
中华人民共和国
中央人民政府
成立了
！

A Happy New Yeear and a Merry Christmas
💕

他们
俩
有意见
分歧

登上
海南
公司
的
航班

季莫申科
拒
监禁
期间
穿
囚服
和服
劳役

南京市
长江大桥

李克强
调研
长春市
长春
药店

# 分析
机械分词很容易出错,尤其是前后能连起来的词. 但实现起来非常简单.
一本词典,用于查询即可实现

# 词典下载
[词典下载](http://abloz.com/uploads/201705/words.dic)
