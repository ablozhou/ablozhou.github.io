---
layout: post
title:  "python kafka生产消费示例"
author: "周海汉"
date:   2017-07-22 10:18:26 +0800
categories: tech
tags:
    - python
    - kafka
    - json
---

# 概述
本文是python作为kafka的生产者和消费者的示例.
可以作为kafka测试程序使用.

## 关注点
- json对象, python对象和json字符串转换
- utf8支持
- kafka生产和消费初始化

# kafka-python 安装
利用conda 从conda-forge库中安装
```
zhouhh@/Users/zhouhh/python $ conda install -c conda-forge kafka-python


The following NEW packages will be INSTALLED:

    kafka-python: 1.3.3-py36_0  conda-forge

The following packages will be UPDATED:

    conda:        4.2.13-py36_0 https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge --> 4.3.22-py36_0 conda-forge

```
# 代码
感谢[yueyanyu](http://www.cnblogs.com/yueyanyu/p/6409374.html) 代码,有改动
```python
# -*- coding: utf-8 -*-

'''''
    使用kafka-Python 1.3.3模块
'''

import sys
import time
import json

from kafka import KafkaProducer
from kafka import KafkaConsumer
from kafka.errors import KafkaError


KAFAKA_HOST = "spider"
KAFAKA_PORT = 9092
KAFAKA_TOPIC = "test"


class Kafka_producer():
    '''''
    生产模块：根据不同的key，区分消息
    '''

    def __init__(self, kafkahost,kafkaport, kafkatopic, key):
        self.kafkaHost = kafkahost
        self.kafkaPort = kafkaport
        self.kafkatopic = kafkatopic
        self.key = key
        print("producer:h,p,t,k",kafkahost,kafkaport,kafkatopic,key)
        bootstrap_servers = '{kafka_host}:{kafka_port}'.format(
                kafka_host=self.kafkaHost,
                kafka_port=self.kafkaPort
                )
        print("boot svr:",bootstrap_servers)
        self.producer = KafkaProducer(bootstrap_servers = bootstrap_servers
                )

    def sendjsondata(self, params):
        try:
            parmas_message = json.dumps(params,ensure_ascii=False)
            producer = self.producer
            print(parmas_message)
            v = parmas_message.encode('utf-8')
            k = key.encode('utf-8')
            print("send msg:(k,v)",k,v)
            producer.send(self.kafkatopic, key=k, value= v)
            producer.flush()
        except KafkaError as e:
            print (e)

class Kafka_consumer():
    '''''
    消费模块: 通过不同groupid消费topic里面的消息
    '''

    def __init__(self, kafkahost, kafkaport, kafkatopic, groupid):
        self.kafkaHost = kafkahost
        self.kafkaPort = kafkaport
        self.kafkatopic = kafkatopic
        self.groupid = groupid
        self.key = key
        self.consumer = KafkaConsumer(self.kafkatopic, group_id = self.groupid,
                bootstrap_servers = '{kafka_host}:{kafka_port}'.format(
                    kafka_host=self.kafkaHost,
                    kafka_port=self.kafkaPort )
                )

    def consume_data(self):
        try:
            for message in self.consumer:
                yield message
        except KeyboardInterrupt as e:
            print (e)


def main(xtype, group, key):
    '''''
    测试consumer和producer
    '''
    if xtype == "p":
        # 生产模块
        producer = Kafka_producer(KAFAKA_HOST, KAFAKA_PORT, KAFAKA_TOPIC, key)
        print ("===========> producer:", producer)
        for _id in range(100):
           params = '{"消息" : "%s"}' % str(_id)
          # 这种方式会将引号都打上\,
          可以直接用python对象
          params=[{"消息0" :_id},{"消息1" :_id}]
          producer.sendjsondata(params)
           time.sleep(1)

    if xtype == 'c':
        # 消费模块
        consumer = Kafka_consumer(KAFAKA_HOST, KAFAKA_PORT, KAFAKA_TOPIC, group)
        print ("===========> consumer:", consumer)
        message = consumer.consume_data()
        for msg in message:
            print ('msg---------------->k,v', msg.key,msg.value)
            print ('offset---------------->', msg.offset)

if __name__ == '__main__':
    xtype = sys.argv[1]
    group = sys.argv[2]
    key = sys.argv[3]
    main(xtype, group, key)

```

# 使用方式
## 生产消息
```
python testkafka.py p g k
```
## 消费消息
```
python testkafka.py c g k
```

# 参考
http://www.cnblogs.com/yueyanyu/p/6409374.html
