---
layout: post
title:  "Spark安装使用实例"
author: "周海汉"
date:   2017-06-09 20:18:26 +0800
categories: tech
tags:
    - spark
    - java
---

![image](http://spark.apache.org/images/spark-logo-trademark.png)
# 安装java opensdk 1.8
如果没有安装Java环境，需要先下载安装。
```
[zhouhh@mainServer ~]$ yum search java | grep openjdk
[zhouhh@mainServer ~]$ sudo yum install java-1.8.0-openjdk-devel.x86_64
[zhouhh@mainServer ~]$ sudo yum install java-1.8.0-openjdk-src

```
centos 使用yum命令后，将 OpenSDK 安装到/usr/lib/jvm/ 目录.

# 配置Java环境

```
[zhouhh@mainServer ~]$ vi /etc/profile
export JAVA_HOME=/etc/alternatives/java_sdk_openjdk
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

[zhouhh@mainServer ~]$ java -version
openjdk version "1.8.0_131"
OpenJDK Runtime Environment (build 1.8.0_131-b12)
OpenJDK 64-Bit Server VM (build 25.131-b12, mixed mode)
[zhouhh@mainServer ~]$ ls -l /usr/bin/java
lrwxrwxrwx 1 root root 22 Jun  5 17:38 /usr/bin/java -> /etc/alternatives/java


[zhouhh@mainServer ~]$ javac -version
javac 1.8.0_131

```
## Java程序测试环境

```
[zhouhh@mainServer java]$ cat HelloWorld.java
public class HelloWorld {
    public static void main(String[] args) {
            System.out.println("Hello, World! ");
        }
}
[zhouhh@mainServer java]$ javac HelloWorld.java
[zhouhh@mainServer java]$ java HelloWorld
Hello, World!
```

# 下载spark
官方下载地址:最新版[spark download page](http://spark.apache.org/downloads.html)

[spark-2.1.1-bin-hadoop2.7.tgz](https://d3kbcqa49mib13.cloudfront.net/spark-2.1.1-bin-hadoop2.7.tgz)

我这里直接通过git下载最新源码.
```
[zhouhh@mainServer java]$ git clone git://github.com/apache/spark.git
# 稳定分支: git clone git://github.com/apache/spark.git -b branch-2.1

[zhouhh@mainServer spark]$ ls
appveyor.yml  CONTRIBUTING.md  external      mllib        R                      spark-warehouse
assembly      core             graphx        mllib-local  README.md              sql
bin           data             hadoop-cloud  NOTICE       repl                   streaming
build         dev              launcher      pom.xml      resource-managers      target
common        docs             LICENSE       project      sbin                   tools
conf          examples         licenses      python       scalastyle-config.xml  work

[zhouhh@mainServer spark]$ mvn install -DskipTests
[INFO] BUILD SUCCESS

```

## 设置spark环境变量
```

[zhouhh@mainServer ~]$ vi .bashrc
#修改.bashrc或.zshrc

# spark
export SPARK_HOME="${HOME}/java/spark"
export PATH="$SPARK_HOME/bin:$PATH"


[zhouhh@mainServer ~]$ source .bashrc

```



# 示例 
用mapreduce求PI
```python
from __future__ import print_function

import sys
from random import random
from operator import add

from pyspark.sql import SparkSession

if __name__ == "__main__":
    """
        Usage: pi [partitions]
        蒙特卡罗算法, 求落在圆内的点和正方形内的点的比值求PI
    """
    spark = SparkSession\
        .builder\
        .appName("PythonPi")\
        .getOrCreate()
    
    # 分区数, 为输入值,缺省为2
    partitions = int(sys.argv[1]) if len(sys.argv) > 1 else 2
    n = 100000 * partitions
    
    # map 函数:[(-1,1),(-1,1)]之间的随机数, 落在圆内为1, 圆外为0.
    圆面积pi, 落了count个点, 正方形面积4, 落了n个点.
    pi/count=4/n.
    pi=4*count/n
    def f(_):
        x = random() * 2 - 1
        y = random() * 2 - 1
        return 1 if x ** 2 + y ** 2 <= 1 else 0

    count = spark.sparkContext.parallelize(range(1, n + 1), partitions).map(f).reduce(add)
    print("Pi is roughly %f" % (4.0 * count / n))

    spark.stop()

```

运行示例
```
[zhouhh@mainServer spark]$ ./bin/run-example SparkPi 10
17/06/06 19:41:03 INFO DAGScheduler: Job 0 finished: reduce at SparkPi.scala:38, took 0.814962 s
Pi is roughly 3.142123142123142
```

# 启动shell

spark可以灵活运行在local, mesos,YARN,或分布式中的独立计划(Standalone Scheduler)各种不同的模式中.

## scala shell
```
[zhouhh@mainServer conf]$ cp log4j.properties.template log4j.properties

[zhouhh@mainServer spark]$ ./bin/spark-shell --master local[2]
```
--master 指定分布式远程的url, 或者 local指定本地单线程处理,local[n]表示启动n个线程处理.

## python shell

```
[zhouhh@mainServer ~]$ pyspark --master local[2]

```
```
./bin/spark-submit examples/src/main/python/pi.py 10
```

### 启动ipython 或jupyter notebook

原来的IPYTHON和IPYTHON_OPTS都已经作废, 改用PYSPARK_DRIVER_PYTHON和PYSPARK_DRIVER_PYTHON_OPTS

```
[zhouhh@mainServer spark]$ PYSPARK_DRIVER_PYTHON=ipython ./bin/pyspark
In [4]: lines = sc.textFile("README.md")

In [5]: lines.count()
Out[5]: 103

In [6]: lines.first()
Out[6]: '# Apache Spark'

In [10]: type(lines)
Out[10]: pyspark.rdd.RDD
In [15]: pylines = lines.filter(lambda line: "Python" in line)

In [16]: pylines.first()
Out[16]: 'high-level APIs in Scala, Java, Python, and R, and an optimized engine that'


#notebook
[zhouhh@mainServer spark]$ PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS="notebook --ip=10.6.0.200" ./bin/pyspark
Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
        http://10.6.0.200:8888/?token=69456fd93a5ce196b3b3f7ee5a983a40115da9cef982e35f

```
这里通过--ip绑定了局域网访问的地址. 否则只可本地访问.
可以通过nohup 启动后台程序, 保持一直远程访问能力.

## Rshell
```
./bin/sparkR --master local[2]
```

```
./bin/spark-submit examples/src/main/r/dataframe.R
```


