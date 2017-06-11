---
layout: post
title:  "用keras训练mnist数据集手写识别"
author: "周海汉"
date:   2017-06-11 20:18:26 +0800
categories: tech
tags:
    - 机器学习
    - Keras
    - theano
---

# 概述
周海汉/文

本文采用keras2的theano后端对mnist手写数字进行训练，得到相应的模型， 并利用模型参数对测试集进行检验。
mnist格式参见另一篇博文[《mnist 数据描述》](http://abloz.com/tech/2017/05/19/mnist-desc/)
# 训练

```python
%matplotlib inline
import pickle
import os
import keras, theano
from keras.models import Sequential

from keras.layers import Dense, Dropout, Flatten
# keras2 用Conv2D 替换 Convolution2D
from keras.layers import Conv2D,MaxPooling2D
from keras.utils import np_utils

from keras.datasets import mnist

from keras import backend as bk
# 可以通过 backend判断是theano还是tensorflow,两者 对图像的channel通道位置不统一
# 本文采用theano,所以配置是"image_data_format": "channels_first", 即input shape是(通道数,宽,高)

# mnist 格式:train集: x=[60000张[28*28的像素值]],y=[60000个(0~9)]. test集x=[10000张[28*28的像素值]],y=[10000个(0~9)].
# train[0]:x_train,train[1]:ytrain
train,test
if os.path.exists('mnist.pkl'):
    f=open('mnist.pkl','rb')


    if f:
        train,test=pickle.load(f)
        print("loading mnist from local")
    else:
        train,test = mnist.load_data()

        #写到本地
        pickle.dump((train,test),open('mnist.pkl','wb'))


print(train[0].shape)
#print(train[0][0]) #[[  0   0   0   0   0   0   0   0   0   0   0   0   3  18  18  18 126 136 175  26 166 255 247 127   0   0   0   0]...]
# print(train[1][:10]) # [5 0 4 1 9 2 1 3 1 4]
from matplotlib import pyplot as plt
plt.imshow(train[0][0])

# 在后端使用 Theano 时, 必须显式地声明一个维度, 用于表示输入图片的深度. 举个例子, 一幅带有 RGB 3 个通道的全彩图片, 深度为 3.
# MNIST 图片的深度为 1, 因此必须显式地进行声明.
# 要将数据集从 (n, width, height) 转换成 (n, depth, width, height).

trainx=train[0].reshape(train[0].shape[0],1,28,28)
testx=test[0].reshape(test[0].shape[0],1,28,28)
print(trainx.shape)
print(testx.shape)

# 由于颜色值都是0-255的值,将其归一化,浮点化
#print(trainx[0])
trainx=trainx.astype('float32')
testx=testx.astype('float32')
trainx /=255
testx /=255

# 处理标签, 将值转为分类标签二维表,共60000行,10列. 第一个数5 置矩阵第一行的第6列为1. 0 放在第二行第0列为1
trainy = np_utils.to_categorical(train[1],10)
testy = np_utils.to_categorical(test[1],10)

#print(train[1][:10]) #[5 0 4 1 9 2 1 3 1 4]
#print(trainy[:10]) #[[ 0.  0.  0.  0.  0.  1.  0.  0.  0.  0.] [ 1.  0.  0.  0.  0.  0.  0.  0.  0.  0.]...]
print(trainy.shape,testy.shape) #(60000, 10) (10000, 10)


# 模型处理
# 创建序列模型
model = Sequential()
# 创建卷积输入层. 
model.add(Conv2D(32,kernel_size=(3, 3),activation='relu', input_shape=(1,28,28)))
print(model.output_shape) #(None, 32, 26, 26)

# 添加卷积层
model.add(Conv2D(64,kernel_size=(3, 3),activation='relu'))

# 添加pooling层
model.add(MaxPooling2D(pool_size=(2,2)))

# 添加Drop out层,防止过拟合。0.25表示随机丢掉1/4的点
model.add(Dropout(0.25))

# 添加全输出层
# 必须平面化
model.add(Flatten())
model.add(Dense(128, activation='relu'))
model.add(Dropout(0.5))

# 输出必须是类别数
model.add(Dense(10,activation='softmax'))

# 编译模型, 添加损失函数和优化函数。损失函数采用交叉信息熵。
model.compile(loss=keras.losses.categorical_crossentropy, optimizer=keras.optimizers.Adadelta(),metrics=['accuracy'])

# 训练拟合
model.fit(trainx,trainy, batch_size=128,epochs=2,verbose=1,validation_data=(testx,testy))

# 评估模型
score = model.evaluate(testx,testy)

print("loss:{}".format(score[0]))
print("accuracy:{}".format(score[1]))


```

# 输出
```
Epoch 1/10
60000/60000 [==============================] - 235s - loss: 0.3387 - acc: 0.8966 - val_loss: 0.0779 - val_acc: 0.9743
Epoch 2/10
60000/60000 [==============================] - 239s - loss: 0.1168 - acc: 0.9654 - val_loss: 0.0531 - val_acc: 0.9824
...
Epoch 10/10
60000/60000 [==============================] - 45377s - loss: 0.0443 - acc: 0.9869 - val_loss: 0.0295 - val_acc: 0.9891

```

使用model.save(filepath)将Keras模型和权重保存在一个HDF5文件中，该文件将包含：
- 模型的结构，以便重构该模型
- 模型的权重
- 训练配置（损失函数，优化器等）
- 优化器的状态，以便于从上次训练中断的地方开始



# 参考
-  https://github.com/fchollet/keras/blob/master/examples/mnist_cnn.py
-  https://python.freelycode.com/contribution/detail/562
-  https://python.freelycode.com/contribution/detail/563
