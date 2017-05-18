---
layout: post
title:  "mnist 数据描述"
date:   2017-05-19 00:36:26 +0800
categories: tech
tags:
    - 机器学习
    - mnist
---

# 概述
mnist 是纽约大学lecun教授基于nist数据集准备的一个60000张手写数字, 经常用于机器学习等练习用数据.

MNIST数据集由手写的数字的图像组成，它分为了60,000训练数据和10,000个测试数据。[有人加工过的nist.pkl.gz](http://deeplearning.net/data/mnist/mnist.pkl.gz )里面，官方的训练数据又进一步的分成50,000的训练数据和10,000的验证数据，以便于模型参数的选择。所有的图像都做了规范化的处理，每个图像的大小都是28*28.在原始数据中，图像的像素存成常用的灰度图（灰度区间0~255）。
为了方便在python中调用改数据集，我们对其进行了序列化。序列化后的文件包括三个list，训练数据，验证数据和测试数据。list中的每一个元素都是由图像和相应的标注组成的。其中图像是一个784维（28*28）的numpy数组，标注则是一个0-9之间的数字。下面的代码演示了如何使用这个数据集。

基于mnist.pkl.gz,在python2中处理如下
```python
import cPickle, gzip, numpy

# Load the dataset
f = gzip.open('mnist.pkl.gz', 'rb')
train_set, valid_set, test_set = cPickle.load(f)
f.close()
```
在python3中处理会出错,因为python3 已经不支持cPickle. 处理方式如下:
```python
import gzip
import pickle

# 使用with结构避免手动的文件关闭操作
with gzip.open('./mnist.pkl.gz', 'rb') as f:
    training_data, validation_data, test_data = pickle.load(f)
# 报错:
UnicodeDecodeError: 'ascii' codec can't decode byte 0x90 in position 614: ordinal not in range(128)
# 需添加encoding为latin1
with gzip.open('./mnist.pkl.gz', 'rb') as f:
    training_data, validation_data, test_data = pickle.load(f, encoding='latin1')

# 可以重写为pickle支持的格式
pickle.dump((training_data, validation_data, test_data),open('t.pk','wb'))
td,vd,td=pickle.load(open('t.pk','rb'))

# 压缩存储
>>> g=gzip.GzipFile('a.gz',mode='wb')
>>> g.write(pickle.dumps((training_data, validation_data, test_data)))
220080423
>>> g.close()
# 读取
>>> p = gzip.GzipFile('a.gz','rb')
>>> f = p.read()
>>> type(f)
<class 'bytes'>
>>> (train,valid,test)=pickle.loads(f)
```

ipython中展示数字

```python
In [6]: f=open("t.pk","rb")

In [7]: train,valid,test=pickle.load(f)

In [8]: len(train)
Out[8]: 2

In [9]: len(train[0])
Out[9]: 50000

In [10]: len(train[1])
Out[10]: 50000
In [12]: len(valid[0])
Out[12]: 10000

In [13]: len(test)
Out[13]: 2

In [14]: len(test[0])
Out[14]: 10000

In [16]: train[0].shape
Out[16]: (50000, 784)

In [17]: 28*28
Out[17]: 784

In [18]: digit = train[0][0].reshape(28,28)

In [15]: fig = plt.figure()
In [20]: plotwindow = fig.add_subplot(111)

In [21]: plt.imshow(digit)
Out[21]: <matplotlib.image.AxesImage at 0x1293ef470>

In [22]: plt.show()

In [23]: plt.imshow(digit,cmap='gray')
Out[23]: <matplotlib.image.AxesImage at 0x12a3bf5f8>

In [24]: plt.show()
```
![image](http://abloz.com/img/201705/mnist_1.png)

# 下载地址

## 原版下载地址:
http://yann.lecun.com/exdb/mnist/


包含四个文件
- train-images-idx3-ubyte.gz :training set images,60000 图片
- train-labels-idx1-ubyte.gz: training set labels 60000标签,值为0-9
- t10k-images-idx3-ubyte.gz : test set images 10000 手写数字图片,前5000张较清晰易识别.
- t10k-labels-idx1-ubyte.gz: test set labels 10000标签,值为0-9

## mnist文件格式描述

```
TRAINING SET LABEL FILE (train-labels-idx1-ubyte):
[offset] [type]          [value]          [description] 
0000     32 bit integer  0x00000801(2049) magic number (MSB first) 
0004     32 bit integer  60000            number of items 
0008     unsigned byte   ??               label 
0009     unsigned byte   ??               label 
........ 
xxxx     unsigned byte   ??               label
The labels values are 0 to 9.

TRAINING SET IMAGE FILE (train-images-idx3-ubyte):

[offset] [type]          [value]          [description] 
0000     32 bit integer  0x00000803(2051) magic number 
0004     32 bit integer  60000            number of images 
0008     32 bit integer  28               number of rows 
0012     32 bit integer  28               number of columns 
0016     unsigned byte   ??               pixel 
0017     unsigned byte   ??               pixel 
........ 
xxxx     unsigned byte   ??               pixel
Pixels are organized row-wise. Pixel values are 0 to 255. 0 means background (white), 255 means foreground (black).

TEST SET LABEL FILE (t10k-labels-idx1-ubyte):

[offset] [type]          [value]          [description] 
0000     32 bit integer  0x00000801(2049) magic number (MSB first) 
0004     32 bit integer  10000            number of items 
0008     unsigned byte   ??               label 
0009     unsigned byte   ??               label 
........ 
xxxx     unsigned byte   ??               label
The labels values are 0 to 9.

TEST SET IMAGE FILE (t10k-images-idx3-ubyte):

[offset] [type]          [value]          [description] 
0000     32 bit integer  0x00000803(2051) magic number 
0004     32 bit integer  10000            number of images 
0008     32 bit integer  28               number of rows 
0012     32 bit integer  28               number of columns 
0016     unsigned byte   ??               pixel 
0017     unsigned byte   ??               pixel 
........ 
xxxx     unsigned byte   ??               pixel
Pixels are organized row-wise. Pixel values are 0 to 255. 0 means background (white), 255 means foreground (black). 
```
## 读取原始的mnist文件, 重新加工
```python
import numpy as np
import struct
import gzip
import pickle
import matplotlib.pyplot as plt
 

def uncompress(zip_filename):

  g=gzip.GzipFile(zip_filename,'rb')
  buf = g.read()
  return buf

def packdata(imgbuf,labelbuf):
  
  # 处理img
  indeximg = 0  
  
  imgs=[]
  labels=[]
  #'>IIII'使用大端法读取四个unsigned int32  
  magic, numImages , numRows , numColumns = struct.unpack_from('>IIII' , imgbuf , indeximg)  
  indeximg += struct.calcsize('>IIII') 
  print("magic:{0}, numImages:{1} , numRows:{2} , numColumns:{3}".format(magic, numImages , numRows , numColumns))
  

  # 处理label
  indexlabel = 0  

  #'>II'使用大端法读取两个unsigned int32  
  magiclabel, numLabels = struct.unpack_from('>II' , labelbuf , indexlabel)  
  indexlabel += struct.calcsize('>II') 
  print("magiclabel:{}, numLabels:{}".format(magiclabel, numLabels))
  
  # 组织数据结构
  for i in range(numImages):  
    #name = str(i) + ".jpg"  
    # upack_from从流中截取784位数据（图片像素值）   
    im = struct.unpack_from('>784B' ,imgbuf, indeximg)  
    indeximg += struct.calcsize('>784B')  
  
    im = np.array(  im)  
    im = im.reshape(28,28)  
    imgs.append(im)

    # 处理label
    numtemp = struct.unpack_from('1B' ,labelbuf, indexlabel)  
    # numtemp 为tuple类型，读取其数值  
    num = numtemp[0]
    indexlabel += struct.calcsize('1B')  
    
    labels.append(num)

  print("end pack imgs and labels")  
  return (imgs,labels) 

# format=gzip or pickle
def writefile(obj,filename):
  f = open(filename,'wb')
  if filename[-3:] == '.gz':
    p = pickle.dumps(obj)
    g = gzip.GzipFile(fileobj=f)

    print("begin write zipfile...")
    g.write(p)
    g.close()
    print("write gz file finished.")

  else:
    pickle.dump(obj,f)
    print("write pickle file finished.")

def showimg(im,label):
  print(label)
  fig = plt.figure()  
  #plotwindow = fig.add_subplot(111)  
  plt.imshow(im , cmap='gray')  
  plt.show()  

if __name__ == '__main__':
  trimgfile = "train-images-idx3-ubyte.gz"
  trlabelfile = "train-labels-idx1-ubyte.gz"
  t10kimgfile = "t10k-images-idx3-ubyte.gz"
  t10klabelfile = "t10k-labels-idx1-ubyte.gz"

  trimgbuf = uncompress(trimgfile)
  trlabelbuf = uncompress(trlabelfile)
  t10kimgbuf = uncompress(t10kimgfile)
  t10klabelbuf = uncompress(t10klabelfile)

  trimgdata, trlabeldata = packdata(trimgbuf,trlabelbuf)
  t10kimgdata, t10klabeldata = packdata(t10kimgbuf,t10klabelbuf)

  writefile( ((trimgdata, trlabeldata ), (t10kimgdata, t10klabeldata)),"mnist.pk")
  #writefile( ((trimgdata, trlabeldata ), (t10kimgdata, t10klabeldata)),"mnist.gz")


  #showimg(trimgdata[13],trlabeldata[13])

  x,y=pickle.load(open('mnist.pk','rb'))
  showimg(x[0][13],x[1][13])

```
label为6
图像也为6
![image](http://abloz.com/img/201705/mnist_2.png)

## keras 下载mnist数据
```python
import keras
from keras.datasets import mnist
train,test = mnist.load_data()

# 将其写入文件
pickle.dump((train,test),open('mnist.pk','wb')

```


# 参考
http://yann.lecun.com/exdb/mnist/
http://blog.csdn.net/sinat_31425585/article/details/52678474



