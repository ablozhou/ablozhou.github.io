---
layout: post
title:  "python爬虫图片抓取失败和乱码问题"
date:   2017-03-2 12:17:26 +0800
categories: 技术
---

# 图片下载失败
网址:http://news.xinhuanet.com/politics/2017-03/01/c_1120551648.htm

```bash
curl http://news.xinhuanet.com/politics/2017-03/01/1120551648_14883580941071n.gif -o c.gif

curl --head http://news.xinhuanet.com/politics/2017-03/01/1120551648_14883580941071n.gif
HTTP/1.1 200 OK
Vary: Accept-Encoding
Content-Encoding: gzip
Accept-Ranges: bytes
Content-Length: 171418
Date: Wed, 01 Mar 2017 09:51:47 GMT
Content-Type: image/gif
Expires: Wed, 01 Mar 2017 10:51:47 GMT
Last-Modified: Wed, 01 Mar 2017 09:56:08 GMT
ETag: W/"58b69ab8-2a5a5"
Powered-By-ChinaCache: HIT from 010104b3W6.4
Age: 57239
Powered-By-ChinaCache: HIT from 01017623gD.6
```
原来是gzip的格式.

下载后需要解压.

用python urllib2 下载, 需要对gzip格式进行设置.
requests可以直接设置header模拟浏览器, 自动解压.
用requests可以直接解压.

```json
import requests
url1='http://news.xinhuanet.com/politics/2017-03/01/1120551648_14883580941071n.gif'
req1=requests.get(url1)
# req1=requests.get(url1,headers={'Accept-Encoding': 'gzip, deflate'})
open('a.gif','wb').write(req1.content)
```
---

# python requests环球网部分抓取乱码问题
抓下来的 是这时候使用r.encoding输出抓取的页面编码总是iso-8859-1，而不是gbk或者gb2312

原文链接： http://ent.huanqiu.com/article/2017-02/10204718.html

```python
import requests
url='http://ent.huanqiu.com/article/2017-02/10204718.html'
req=requests.get(url)

open('a.html','wb').write(req.content)
encodings='utf8'
if req.encoding == 'ISO-8859-1':
    encodings = requests.utils.get_encodings_from_content(req.text)
    if encodings:
        encoding = encodings[0]
    else:
        encoding = req.apparent_encoding
    if encoding.startswith('ISO'):
        encoding='utf8'

content = req.content.decode(encoding, 'replace').encode('utf-8', 'replace')
```

```python
>>> req.encoding
'ISO-8859-1'
>>> req.apparent_encoding
'ISO-8859-2'
```

## 判断原始编码:
- html5

```html
<html lang="zh-CN"><head><meta charset="utf-8" /> </head>
```

- 旧的html标准

```html
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
```

python判断网页内容编码,缺省设为utf8:

```python
encodings='utf8'
if req.encoding == 'ISO-8859-1':
    encodings = requests.utils.get_encodings_from_content(req.text)
    if encodings:
        encoding = encodings[0]
    else:
        encoding = req.apparent_encoding
    if encoding.startswith('ISO'):
        encoding='utf8'
```

# 参考
http://blog.chinaunix.net/uid-13869856-id-5747417.html

