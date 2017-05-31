---
layout: post
title:  "感知器的两种实现"
date:   2017-05-31 05:18:26 +0800
categories: tech
tags:
    - 机器学习
    - 感知器
    - mini-batch
    - SGD
    - BGD
---


# 感知器的两种实现方式

## 1. 每一行样本循环进行处理(Stochastic Gradient Descent, SGD)

随机梯度下降,对每一行样本, 计算其参数w, 一次迭代全部样本.并在处理每个样本时逐步调整参数w.
这种方式最自然, 但参数会有反复.效率最低. 

```python
# perceptron 感知器
# 周海汉 2017.5.21

import numpy as np

# 感知器
class Perceptron:
    '''感知器 y=f(x*w+b),x为输入,w为权重,b为偏置量,f为激活函数, 一般有sigmoid,relu,sgn,tanh'''
    def __init__(self, eta, n_iter):
        '''
        eta: 迭代率
        n_iter: 迭代次数
        '''
        self.eta = eta
        self.n_iter = n_iter
        
    def fit(self, x, y):
        '''
        x: 训练数据,二维数组.[sample,feature], sample表示训练用数据数目, feature表示特征数
        y: 目标结果标签数据,一维向量. [label], 长度和samples值一样
        w: 权重向量, [weight] , 包含偏置量w0, 长度为feature值+1
        errors: 记录迭代错误
        '''
        
        # 修改输入训练数组, 添加x0为[1,...,1], 方便和w0相乘, 计算偏置量
        x_ = np.insert(x,0,np.ones(x.shape[0]),axis=1)
        self.w = np.ones(x.shape[1] + 1)
        self.errors = []
        for i in range(self.n_iter):
            print("========i:{}=====".format(i))
            for xrow, target in zip(x_,y):
                # 计算迭代量, 该值为标量, eta * (y_train - y_predict)
                print("xrow,target:",xrow,target)
                print("out:",self.predict(xrow))
                compare = target - self.predict(xrow)
                update = self.eta * compare 
                print("error c:",compare)
                print("deta w:",update*xrow)

                # w[i] = w[i] + update
                self.w += update*xrow
                print("self.w:",self.w)
                #print("compare:{}".format(compare))

                error = compare 

                self.errors.append(error)
    
    def net_input(self, xrow):
        '''
        y = w0*1 + w1*x1 + ... + wn*xn
        '''        
        return self.w.dot(xrow)
    
    def predict(self, xrow):
        '''
        计算迭代值, 返回0,1
        '''
        return np.where(self.net_input(xrow)>=0.0,1,0)
    
    def check(self,x,y):
        '''
        检验错误率
        '''
        errors=[]
        x_ = np.insert(x,0,np.ones(x.shape[0]),axis=1)
        for xrow, target in zip(x_,y):
            compare = target - self.predict(xrow)
            print('predict:{},target:{}'.format(self.predict(xrow),target))
            errors.append(int(compare > 0.01))
        
        print(errors)
            
def test():
    # 训练 布尔与的参数
    train=np.array([[0,1,0],[0,0,0],[1,0,0],[1,1,1]])
    test = np.array([[0,1,0],[1,1,1]])
    p = Perceptron(0.1,10)
    p.fit(train[:,:2],train[:,2])
    print(p.w)
    print(p.errors)
    
    p.check(test[:,:2],test[:,2])
    p.check(train[:,:2],train[:,2])
    
    

test()            
```

## 2. 采用全部样本进行矩阵训练(Batch Gradient Descent,BGD)

批梯度下降法,这种方式效率更高. 但矩阵操作直观性降低.
如果样本很大, 会导致内存加载问题.
本实现也很方便改造为mini-batch方式. 即训练时每次只加载小批数量的数据. 并逐渐调节参数.

```
# perceptron 感知器
# 周海汉 2017.5.21

import numpy as np

# 感知器
class Perceptron:
    '''感知器 y=f(x*w+b),x为输入,w为权重,b为偏置量,f为激活函数, 一般有sigmoid,relu,sgn,tanh'''
    def __init__(self, eta, n_iter):
        '''
        eta: 迭代率
        n_iter: 迭代次数
        '''
        self.eta = eta
        self.n_iter = n_iter
        
    def fit(self, x, y):
        '''
        x: 训练数据,二维数组.[sample,feature], sample表示训练用数据数目, feature表示特征数
        y: 目标结果标签数据,一维向量. [label], 长度和samples值一样
        w: 权重向量, [weight] , 包含偏置量w0, 长度为feature值+1
        costs: 记录迭代代价, 代价应该越来越小
        '''
        
        # 修改输入训练数组, 添加x0为[1,...,1], 方便和w0相乘, 计算偏置量
        x_ = np.insert(x,0,np.ones(x.shape[0]),axis=1)
        self.w = np.ones(x_.shape[1])
        print("x:",x_)
        print("y:",y)
        print("x.T:",x_.T)
        print("self.w:",self.w)
        #w = np.ones(x_.shape[1] * x_.shape[0]).reshape(x_.shape[0],x_.shape[1])
        #print("w:",w)
        self.costs = []
        for i in range(self.n_iter):
            print("=======ith {} train =======".format(i))
            # 计算输出值, 该值为和sample数相同长度的一维向量
            output = self.predict(x_)
            
            print("output:",output)
            
            # 误差 为 一维向量
            errors = y - output
            
            print("errors:",errors)
            # 计算损失函数, 也为一维向量, 长度为样本数 eta * x *(y_train - y_predict) 为每一个样本的deta w
            # x.T 表示每一个feature的值,和误差相乘, 得到一维向量,长度为 feature 数 +1
            print("x.T:\n",x_.T)
            detaw = self.eta * x_.T.dot(errors)
            
            print("deta w:",detaw)
            self.w += detaw
             
            #print("w:",w)
            #print("w.sum:",w.sum(axis=0))
            #self.w = w.sum(axis=0)/x_.shape[0]
            print("s w:",self.w)
            cost = (errors**2).sum()/2.0
            self.costs.append(cost)
            
        print("costs:",self.costs)
            

    def net_input(self, x):
        '''
        y(i) = w0*1 + w1*x1(i) + ... + wn*xn(i)
        
        i 表示第i个sample
        
        返回sample长度的一维输出向量
        '''        
        return np.dot(x, self.w)
    
    def activate(self,x):
        '''激活函数, 直接使用原值'''
        return self.net_input(x)
    
    def predict(self,x):
        '''
        预测函数, 返回0,1
        '''
        return np.where(self.activate(x)>=0.0,1,0)
    
    def check(self,x,y):
        '''
        检验错误率
        '''
        errors=[]
        x_ = np.insert(x,0,np.ones(x.shape[0]),axis=1)
        for xrow, target in zip(x_,y):
            print("xrow,target:",xrow,target)
            
            error = target - self.predict(xrow)
            print('predict:{},target:{}'.format(self.predict(xrow),target))
            errors.append(int(error > 0.01))
        
        print("check errors:",errors)
            
def test():
# 训练 布尔与的参数
    train=np.array([[0,1,0],[0,0,0],[1,0,0],[1,1,1]])
    test = np.array([[0,1,0],[1,1,1]])
    p = Perceptron(0.1,20)
    p.fit(train[:,:2],train[:,2])
    print(p.w)
    print(p.costs)
    
    p.check(test[:,:2],test[:,2])
    p.check(train[:,:2],train[:,2])
    
    
test()            
```

# 参考

- [零基础入门深度学习(1) - 感知器](https://zybuluo.com/hanbingtao/note/433855)

