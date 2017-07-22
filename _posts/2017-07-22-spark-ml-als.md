---
layout: post
title:  "spark 隐含因子音乐推荐"
author: "周海汉"
date:   2017-07-22 10:18:26 +0800
categories: tech
tags:
    - scala
    - spark
    - 机器学习
---
# 音乐推荐

本示例基于spark高级编程. 实现了一个对

# 隐因子推荐算法( Latent Factor Analysis)


用用户和产品之间的交互, 来找到潜在的分类, 并对用户进行推荐.

隐含语义模型LFM和LSI，LDA，Topic Model 都属于隐含语义分析技术，是一类概念，他们在本质上是相通的，都是找出潜在的主题或分类。和该技术相关算法有pLSA（probabilitistic Latent Semantic Analysis）概率隐语义主题模型 、LDA（Latent Dirichlet Allocation）文档主题生成模型、隐含类别模型（latent class model ）、隐含主题模型（latent topic model ）、矩阵分解（matrix factorization ）。这些技术和方法在本质上是相通的，其中很多方法都可以用于个性化推荐系统。
隐含语义分析核心思想是通过隐含特征(latent factor)联系用户兴趣和物品。
基于兴趣分类的方法大概需要解决3个问题。
	如何给物品进行分类？
	如何确定用户对哪些类的物品感兴趣，以及感兴趣的程度？
	对于一个给定的类，选择哪些属于这个类的物品推荐给用户，以及如何确定这些物品一个类中的权重？
对分类来说，可能因人而异，很难到位。很难控制分类的粒度；很难给一个物品多个分类；很难给出多维度的分类（分类是可以有很多维度的，比如按照作者分类、按照来源分类、按照地域分类）；很难决定一个物品在某一个分类中的权重。
能否从数据出发，自动地找到那些类，进行个性化推荐？隐含语义分析技术即用于解决上述问题。
隐含语义分析技术的分类来自对用户行为的统计，代表了用户对物品分类的看法。隐含语义分析技术和ItemCF在物品分类方面的思想类似，如果两个物品被很多用户同时喜欢，那么这两个物品就很有可能属于同一个类。

# 矩阵分解原理

如下面的公式所示.R是m,n阶矩阵.P是m,k阶矩阵. Q是k,n阶矩阵. 其中, k就是隐藏的类别属性.


$$
R^{m\times n} = P^{m \times k}Q^{k \times n}

R_{i,:} = P_{i,:}Q^{k \times n}
$$

第二个公式表示R的第i行等于分界后矩阵P的第i行和矩阵Q相乘.

矩阵分解算法有时称为矩阵补全（matrix completion）算法，因为原始矩阵R 可能非常稀疏，但乘积$PQ$ 是稠密的. 因此模型只是对R的一种近似。

对具体实例, 我们假设P为m个用户,具有k种兴趣(每个值代表了对应模型的一个隐含特征).
Q为n个物品,具有k种分类.$PQ$的乘积即为"用户_特征"表和"物品_特征"表的乘积, 结果为全部用户对全部物品的兴趣.

R是一个用户物品行为的稀疏矩阵, 它只是所有用户物品关系的一个样本. 可以看成一个对基本事实的观察. 用k个特征,却可以很好的归纳总结这些基本事实.根据这些归纳, 可以对还没有发生的用户物品的行为进行补全. 补全的值即可用于推荐.

$PQ$应该趋近R, 但不应该完全和R一致. 将R矩阵分解成$PQ$并不容易.完全一致的分解可能也会产生过拟合. 因为偶然的行为等噪音也会计算在内.
直接同时得到$PQ$的最优解是不可能的. 但如果P已知，求Q的最优解是非常容易的，反之亦然。
所以我们可以通过迭代的方式逐步趋近$PQ$
如使用交替最小二乘（Alternating Least Squares，ALS）算法, 来获得$PQ$近似值.

虽然Q是未知的，但我们可以把它初始化为随机行向量矩阵。接着运用简单的线性代数，就能在给定R和Q的条件下求出P的最优解。实际上，P的第i行是R 的第i行和Q的函数，因此可以很容易分开计算P的每一行。因为P的每一行可以分开计算，所以我们可以将其并行化，而并行化是大规模计算的一大优点。



$$
P_i = R_iQ^T(QQ^T)^{-1}
$$


## 交替最小二乘推荐算法（Alternating Least Squares，ALS）
实际的目标是最小化$|Q^T(QQ^T)^{-1} - P_i|$，或者最小化
两个矩阵的平方误差。这就是算法名称中“最小二乘”的来由。这里给出方程式只是为
了说明行向量计算方法，但实践中从来不会对矩阵求逆，会借助于
[QR分解](http://
en.wikipedia.org/wiki/QR_decomposition) 之类的方法，这种方法速度更快而且更直接。
可以由P计算每个$Q_i$。然后又可以由Q计算P，这样反复下去。这就是算法名称中“交替”的来由。Q刚开始是随机的. P和Q最终会收敛得到一个合适的结果。


将ALS 算法用于隐性数据矩阵分解时，ALS 矩阵分解要稍微复杂一点儿。它不是直接分解输入矩阵R，而是分解由0 和1 组成的矩阵R1，当R中元素为正时，R1中对应元素为1，否则为0。R中的具体值后面会以权重的形式反映出来.


# 准备数据
示例使用Audioscrobbler公开发布的一个数据集。Audioscrobbler 是last.fm 的第一个音乐推荐系统。Audioscrobbler 数据集有些特别，因为它只记录了播放数据.
[下载地址](http://www-etud.iro.umontreal.ca/~bergstrj/audioscrobbler_data.html)
里面有几个文件,主要的数据集在文件user_artist_data.txt 中，它由3列组成:( userid artistid playcount)包含141 000 个用户和160万个艺术家，记录了约2420 万条用户播放艺术家歌曲的信息，其中包括播放次数信息。artist_data.txt 文件由2列组成(artistid artist_name)中给出了每个艺术家的ID和对应的名字。artist_alias.txt 文件由2列组成(badid, goodid)保存艺术家别称.

# 测试
$$
scala
scala> val rawUserArtistData = sc.textFile("/Users/zhouhh/Downloads/profiledata_06-May-2005/user_artist_data.txt")
rawUserArtistData: org.apache.spark.rdd.RDD[String] = /Users/zhouhh/Downloads/profiledata_06-May-2005/user_artist_data.txt MapPartitionsRDD[1] at textFile at <console>:24
scala> rawUserArtistData.take(10)
res0: Array[String] = Array(1000002 1 55, 1000002 1000006 33, 1000002 1000007 8, 1000002 1000009 144, 1000002 1000010 314, 1000002 1000013 8, 1000002 1000014 42, 1000002 1000017 69, 1000002 1000024 329, 1000002 1000025 1)

scala> case class UserArtist(userid:Int, artistid:Int, playcount:Int)

scala> val ua = rawUserArtistData.map(_.split(" ")).map{x=>
     |         UserArtist(x(0).toInt,x(1).toInt,x(2).toInt)}
ua: org.apache.spark.rdd.RDD[UserArtist] = MapPartitionsRDD[4] at map at <console>:28

scala> ua.take(10)
res5: Array[UserArtist] = Array(UserArtist(1000002,1,55), UserArtist(1000002,1000006,33), UserArtist(1000002,1000007,8), UserArtist(1000002,1000009,144), UserArtist(1000002,1000010,314), UserArtist(1000002,1000013,8), UserArtist(1000002,1000014,42), UserArtist(1000002,1000017,69), UserArtist(1000002,1000024,329), UserArtist(1000002,1000025,1))
scala> ua.map(_.userid).stats()
res8: org.apache.spark.util.StatCounter = (count: 24296858, mean: 1947573.265353, stdev: 496000.544975, max: 2443548.000000, min: 90.000000)

scala> import org.apache.spark.mllib.recommendation._
import org.apache.spark.mllib.recommendation._

scala> val trainData = rawUserArtistData.map(_.split(" ")).map{x=>
     |         Rating(x(0).toInt,x(1).toInt,x(2).toInt)}.cache()
trainData: org.apache.spark.rdd.RDD[org.apache.spark.mllib.recommendation.Rating] = MapPartitionsRDD[9] at map at <console>:29
scala> val model = ALS.trainImplicit(trainData, 10, 5, 0.01, 1.0)
Caused by: java.lang.OutOfMemoryError: Java heap space
$$


切换服务器,提高内存
$$

[zhouhh@msvr ~]$ spark-shell --master local[4] --driver-memory 6g

scala> import org.apache.spark.mllib._
import org.apache.spark.mllib._

scala> import org.apache.spark.mllib.recommendation._
import org.apache.spark.mllib.recommendation._
scala> val rawUserArtistData = sc.textFile("/home/zhouhh/nlp/data/profiledata/user_artist_data.txt")
rawUserArtistData: org.apache.spark.rdd.RDD[String] = /home/zhouhh/nlp/data/profiledata/user_artist_data.txt MapPartitionsRDD[1] at textFile at <console>:24
scala> val trainData = rawUserArtistData.map(_.split(" ")).map{x=>
     |         Rating(x(0).toInt,x(1).toInt,x(2).toInt)}.cache()
trainData: org.apache.spark.rdd.RDD[org.apache.spark.mllib.recommendation.Rating] = MapPartitionsRDD[3] at map at <console>:32
$$

## 训练模型
$$

scala> val model = ALS.trainImplicit(trainData, 10, 5, 0.01, 1.0)
17/07/05 15:36:05 WARN BLAS: Failed to load implementation from: com.github.fommil.netlib.NativeSystemBLAS
17/07/05 15:36:05 WARN BLAS: Failed to load implementation from: com.github.fommil.netlib.NativeRefBLAS
17/07/05 15:36:06 WARN LAPACK: Failed to load implementation from: com.github.fommil.netlib.NativeSystemLAPACK
17/07/05 15:36:06 WARN LAPACK: Failed to load implementation from: com.github.fommil.netlib.NativeRefLAPACK
model: org.apache.spark.mllib.recommendation.MatrixFactorizationModel = org.apache.spark.mllib.recommendation.MatrixFactorizationModel@5c8859b4
scala> model.userFeatures.mapValues(_.mkString(", ")).first()
res1: (Int, String) = (90,0.9103583693504333, -0.799676775932312, -0.7170624732971191, 0.27575400471687317, 0.23960699141025543, 0.21480463445186615, -0.12654761970043182, 0.33688923716545105, 0.31023073196411133, -0.2494485229253769)
$$

ALS.trainImplicit() 的参数包括以下几个。
- rank = 10
模型的潜在因素的个数，即“用户-特征”和“产品-特征”矩阵的列数；一般来说，它也是矩阵的阶。
- iterations = 5
矩阵分解迭代的次数；迭代的次数越多，花费的时间越长，但分解的结果可能会更好。
- lambda = 0.01
标准的过拟合参数；值越大越不容易产生过拟合，但值太大会降低分解的准确度。
- alpha = 1.0
控制矩阵分解时，被观察到的“用户-产品”交互相对没被观察到的交互的权重。

## 推荐
给用户2093760做推荐,5位艺术家.
$$

scala> val recommendations = model.recommendProducts(2093760, 5)
recommendations: Array[org.apache.spark.mllib.recommendation.Rating] = Array(Rating(2093760,1300642,0.031684423392518514), Rating(2093760,2814,0.03133836778736454), Rating(2093760,1001819,0.03098141120876122), Rating(2093760,1007614,0.030441838331559903), Rating(2093760,4605,0.030321088541257573))



$$

rating第三个值,对这类ALS 算法，它是一个在0 到1 之间的模糊值，
值越大，推荐质量越好。它不是概率，但可以把它理解成对0/1 值的一个估计，0 表示用
户不喜欢播放艺术家的歌曲，1 表示喜欢播放艺术家的歌曲。

# 推荐评价
一个指标是观测者操作特性（Receiver Operating Characteristic，ROC，http://en.wikipedia.org/wiki/Receiver_operating_characteristic）曲线。上一段中的指标等于ROC曲线下区域的面积，称为AUC（Area Under the Curve）。
可以把AUC 看成是随机选择的好推荐比随机选择的差推荐的排名高的概率。

# 参考
《Spark高级数据分析》
《推荐系统设计》
