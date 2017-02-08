---
author: abloz
comments: true
date: 2012-05-30 11:16:59+00:00
layout: post
link: http://abloz.com/index.php/2012/05/30/hbase-0-95-chinese-version-of-the-official-document/
slug: hbase-0-95-chinese-version-of-the-official-document
title: hbase 0.95 最新官方文档中文版
wordpress_id: 1623
categories:
- 技术
tags:
- hbase
- 中文
- 文档
---

花了很大精力，整理翻译hbase 0.95最新官方文档中文版。放在[http://abloz.com/hbase/book.html](http://abloz.com/hbase/book.html) 。但时间仓促还没翻译完全，将其放在https://code.google.com/p/hbasedoc-cn 上，欢迎有兴趣的更新翻译内容。


**译者**：HBase新版 0.95 文档和0.90版相比，变化较大，文档补充更新了很多内容，章节调整较大。本翻译文档的部分工作基于[颜开](http://www.yankay.com)工作。英文原文地址在[此处](http://hbase.apache.org/book.html)。旧版0.90版由颜开翻译文档在[此处](http://www.yankay.com/wp-content/hbase/book.html)。0.95版翻译最后更新请到[此处](http://abloz.com/hbase/book.html)( [http://abloz.com/hbase/book.html](http://abloz.com/hbase/book.html) )浏览。反馈和参与请到[此处 (https://code.google.com/p/hbasedoc-cn/)](https://code.google.com/p/hbasedoc-cn/)或访问我的[blog(http://abloz.com)](http://abloz.com)，或给我发email。




最终版生成[pdf](https://hbasedoc-cn.googlecode.com/files/HBase 官方文档.pdf)供下载。


贡献者：


周海汉邮箱：ablozhou@gmail.com, 网址：[http://abloz.com/](http://abloz.com/)


颜开邮箱: yankaycom@gmail.com, 网址：[http://www.yankay.com/](http://www.yankay.com/)



[序](http://abloz.com/hbase/book.html#preface)[1. 入门](http://abloz.com/hbase/book.html#getting_started)



[1.1. 介绍](http://abloz.com/hbase/book.html#d613e75)
[1.2. 快速开始](http://abloz.com/hbase/book.html#quickstart)
[2. 配置](http://abloz.com/hbase/book.html#configuration)



[2.1. Java](http://abloz.com/hbase/book.html#java)
[2.2. 操作系统](http://abloz.com/hbase/book.html#os)
[2.3. Hadoop](http://abloz.com/hbase/book.html#hadoop)
[2.4. ](http://abloz.com/hbase/book.html#standalone_dist)[HBase运行模式:单机和分布式](http://abloz.com/hbase/book.html#standalone_dist)
[2.5. ZooKeeper](http://abloz.com/hbase/book.html#zookeeper)
[2.6. 配置文件](http://abloz.com/hbase/book.html#config.files)
[2.7. 配置示例](http://abloz.com/hbase/book.html#example_config)
[2.8. 重要配置](http://abloz.com/hbase/book.html#important_configurations)
[2.9. Bloom Filter](http://abloz.com/hbase/book.html#config.bloom)
[3. 升级](http://abloz.com/hbase/book.html#upgrading)



[3.1. ](http://abloz.com/hbase/book.html#upgrade0.90)[从HBase 0.20.x or 0.89.x 升级到 HBase 0.90.x](http://abloz.com/hbase/book.html#upgrade0.90)
[3.2. 从 0.90.x 到 0.92.x](http://abloz.com/hbase/book.html#upgrade0.92)
[4. The HBase Shell](http://abloz.com/hbase/book.html#shell)



[4.1. ](http://abloz.com/hbase/book.html#scripting)[使用脚本](http://abloz.com/hbase/book.html#scripting)
[4.2. ](http://abloz.com/hbase/book.html#shell_tricks)[Shell 技巧](http://abloz.com/hbase/book.html#shell_tricks)
[5. ](http://abloz.com/hbase/book.html#datamodel)[数据模型](http://abloz.com/hbase/book.html#datamodel)



[5.1. ](http://abloz.com/hbase/book.html#conceptual.view)[概念视图](http://abloz.com/hbase/book.html#conceptual.view)
[5.2. ](http://abloz.com/hbase/book.html#physical.view)[物理视图](http://abloz.com/hbase/book.html#physical.view)
[5.3. ](http://abloz.com/hbase/book.html#table)[表](http://abloz.com/hbase/book.html#table)
[5.4. ](http://abloz.com/hbase/book.html#row)[行](http://abloz.com/hbase/book.html#row)
[5.5. 列族](http://abloz.com/hbase/book.html#columnfamily)
[5.6. Cells](http://abloz.com/hbase/book.html#cells)
[5.7. Data Model Operations](http://abloz.com/hbase/book.html#data_model_operations)
[5.8. ](http://abloz.com/hbase/book.html#versions)[版本](http://abloz.com/hbase/book.html#versions)
[5.9. 排序](http://abloz.com/hbase/book.html#dm.sort)
[5.10. 列元数据](http://abloz.com/hbase/book.html#dm.column.metadata)
[5.11. Joins](http://abloz.com/hbase/book.html#joins)
[6. HBase 和 Schema 设计](http://abloz.com/hbase/book.html#schema)



[6.1. Schema ](http://abloz.com/hbase/book.html#schema.creation)[创建](http://abloz.com/hbase/book.html#schema.creation)
[6.2. ](http://abloz.com/hbase/book.html#number.of.cfs)[column families的数量](http://abloz.com/hbase/book.html#number.of.cfs)
[6.3. Rowkey 设计](http://abloz.com/hbase/book.html#rowkey.design)
[6.4. Number 数量](http://abloz.com/hbase/book.html#schema.versions)
[6.5. 支持的数据类型](http://abloz.com/hbase/book.html#supported.datatypes)
[6.6. Joins](http://abloz.com/hbase/book.html#schema.joins)
[6.7. 生存时间 (TTL)](http://abloz.com/hbase/book.html#ttl)
[6.8. 保留删除的单元](http://abloz.com/hbase/book.html#cf.keep.deleted)
[6.9. 第二索引和替代查询路径](http://abloz.com/hbase/book.html#secondary.indexes)
[6.10. 模式设计对决](http://abloz.com/hbase/book.html#schema.smackdown)
[6.11. 操作和性能配置选项](http://abloz.com/hbase/book.html#schema.ops)
[6.12. 限制](http://abloz.com/hbase/book.html#constraints)
[7. HBase 和 MapReduce](http://abloz.com/hbase/book.html#mapreduce)



[7.1. Map-Task 分割](http://abloz.com/hbase/book.html#splitter)
[7.2. HBase MapReduce 示例](http://abloz.com/hbase/book.html#mapreduce.example)
[7.3. 在MapReduce工作中访问其他 HBase 表](http://abloz.com/hbase/book.html#mapreduce.htable.access)
[7.4. 推测执行](http://abloz.com/hbase/book.html#mapreduce.specex)
[8. HBase安全](http://abloz.com/hbase/book.html#security)



[8.1. 安全客户端访问 HBase](http://abloz.com/hbase/book.html#hbase.secure.configuration)
[8.2. 访问控制](http://abloz.com/hbase/book.html#hbase.accesscontrol.configuration)
[9. 架构](http://abloz.com/hbase/book.html#architecture)



[9.1. 概述](http://abloz.com/hbase/book.html#arch.overview)
[9.2. 目录表](http://abloz.com/hbase/book.html#arch.catalog)
[9.3. 客户端](http://abloz.com/hbase/book.html#client)
[9.4. 客户请求过滤器](http://abloz.com/hbase/book.html#client.filter)
[9.5. Master](http://abloz.com/hbase/book.html#master)
[9.6. RegionServer](http://abloz.com/hbase/book.html#regionserver.arch)
[9.7. 分区(Regions](http://abloz.com/hbase/book.html#regions.arch))
[9.8. 批量加载](http://abloz.com/hbase/book.html#arch.bulk.load)
[9.9. HDFS](http://abloz.com/hbase/book.html#arch.hdfs)
[10. 外部 APIs](http://abloz.com/hbase/book.html#external_apis)



[10.1. 非Java语言和 JVM交互](http://abloz.com/hbase/book.html#nonjava.jvm)
[10.2. REST](http://abloz.com/hbase/book.html#rest)
[10.3. Thrift](http://abloz.com/hbase/book.html#thrift)
[11. 性能调优](http://abloz.com/hbase/book.html#performance)



[11.1. 操作系统](http://abloz.com/hbase/book.html#perf.os)
[11.2. 网络](http://abloz.com/hbase/book.html#perf.network)
[11.3. Java](http://abloz.com/hbase/book.html#jvm)
[11.4. HBase 配置](http://abloz.com/hbase/book.html#perf.configurations)
[11.5. ZooKeeper](http://abloz.com/hbase/book.html#perf.zookeeper)
[11.6. Schema 设计](http://abloz.com/hbase/book.html#perf.schema)
[11.7. 写到 HBase](http://abloz.com/hbase/book.html#perf.writing)
[11.8. 从 HBase读取](http://abloz.com/hbase/book.html#perf.reading)
[11.9. 从 HBase删除](http://abloz.com/hbase/book.html#perf.deleting)
[11.10. HDFS](http://abloz.com/hbase/book.html#perf.hdfs)
[11.11. Amazon EC2](http://abloz.com/hbase/book.html#perf.ec2)
[11.12. 案例](http://abloz.com/hbase/book.html#perf.casestudy)
[12. 故障排除和调试 HBase](http://abloz.com/hbase/book.html#trouble)



[12.1. 通用指引](http://abloz.com/hbase/book.html#trouble.general)
[12.2. Logs](http://abloz.com/hbase/book.html#trouble.log)
[12.3. 资源](http://abloz.com/hbase/book.html#trouble.resources)
[12.4. 工具](http://abloz.com/hbase/book.html#trouble.tools)
[12.5. 客户端](http://abloz.com/hbase/book.html#trouble.client)
[12.6. MapReduce](http://abloz.com/hbase/book.html#trouble.mapreduce)
[12.7. NameNode](http://abloz.com/hbase/book.html#trouble.namenode)
[12.8. 网络](http://abloz.com/hbase/book.html#trouble.network)
[12.9. RegionServer](http://abloz.com/hbase/book.html#trouble.rs)
[12.10. Master](http://abloz.com/hbase/book.html#trouble.master)
[12.11. ZooKeeper](http://abloz.com/hbase/book.html#trouble.zookeeper)
[12.12. Amazon EC2](http://abloz.com/hbase/book.html#trouble.ec2)
[12.13. HBase 和 Hadoop 版本相关](http://abloz.com/hbase/book.html#trouble.versions)
[12.14. 案例](http://abloz.com/hbase/book.html#trouble.casestudy)
[13. 案例研究](http://abloz.com/hbase/book.html#casestudies)



[13.1. 概要](http://abloz.com/hbase/book.html#casestudies.overview)
[13.2. Schema 设计](http://abloz.com/hbase/book.html#casestudies.schema)
[13.3. 性能/故障排除](http://abloz.com/hbase/book.html#casestudies.perftroub)
[14. HBase 运维管理](http://abloz.com/hbase/book.html#ops_mgt)



[14.1. HBase 工具和实用程序](http://abloz.com/hbase/book.html#tools)
[14.2. 分区管理](http://abloz.com/hbase/book.html#ops.regionmgt)
[14.3. 节点管理](http://abloz.com/hbase/book.html#node.management)
[14.4. HBase 度量(Metrics)](http://abloz.com/hbase/book.html#hbase_metrics)
[14.5. HBase 监控](http://abloz.com/hbase/book.html#ops.monitoring)
[14.6. Cluster 复制](http://abloz.com/hbase/book.html#cluster_replication)
[14.7. HBase 备份](http://abloz.com/hbase/book.html#ops.backup)
[14.8. 容量规划](http://abloz.com/hbase/book.html#ops.capacity)
[15. 创建和开发 HBase](http://abloz.com/hbase/book.html#developer)



[15.1. HBase 仓库](http://abloz.com/hbase/book.html#repos)
[15.2. IDEs](http://abloz.com/hbase/book.html#ides)
[15.3. 创建 HBase](http://abloz.com/hbase/book.html#build)
[15.4. 发布新版 hbase.apache.org](http://abloz.com/hbase/book.html#hbase.site.publishing)
[15.5. 测试](http://abloz.com/hbase/book.html#hbase.tests)
[15.6. Maven 创建命令](http://abloz.com/hbase/book.html#maven.build.commands)
[15.7. 加入](http://abloz.com/hbase/book.html#getting.involved)
[15.8. 开发](http://abloz.com/hbase/book.html#developing)
[15.9. 提交补丁](http://abloz.com/hbase/book.html#submitting.patches)
[A. FAQ](http://abloz.com/hbase/book.html#faq)[B. 深入hbck](http://abloz.com/hbase/book.html#hbck.in.depth)



[B.1. 运行 hbck 以查找不一致](http://abloz.com/hbase/book.html#d1934e10593)
[B.2. 不一致(Inconsistencies)](http://abloz.com/hbase/book.html#apbs02)
[B.3. 局部修补](http://abloz.com/hbase/book.html#apbs03)
[B.4. 分区重叠修补](http://abloz.com/hbase/book.html#apbs04)
[C. HBase中的压缩](http://abloz.com/hbase/book.html#compression)



[C.1. CompressionTest 工具](http://abloz.com/hbase/book.html#compression.test)
[C.2. hbase.regionserver.codecs](http://abloz.com/hbase/book.html#hbase.regionserver.codecs)
[C.3. LZO](http://abloz.com/hbase/book.html#lzo.compression)
[C.4. GZIP](http://abloz.com/hbase/book.html#gzip.compression)
[C.5. SNAPPY](http://abloz.com/hbase/book.html#snappy.compression)
[C.6. 修改压缩 Schemes](http://abloz.com/hbase/book.html#changing.compression)
[D. YCSB: Yahoo! 云服务评估和 HBase](http://abloz.com/hbase/book.html#apd) [E. HFile 格式版本 2](http://abloz.com/hbase/book.html#hfilev2)



[E.1. Motivation](http://abloz.com/hbase/book.html#d1934e10848)
[E.2. HFile 格式版本 1 概览](http://abloz.com/hbase/book.html#apes02)
[E.3. HBase 文件格式带 inline blocks (version 2)](http://abloz.com/hbase/book.html#apes03)
[F. HBase的其他信息](http://abloz.com/hbase/book.html#other.info)



[F.1. HBase 视频](http://abloz.com/hbase/book.html#other.info.videos)
[F.2. HBase 展示 (Slides)](http://abloz.com/hbase/book.html#other.info.pres)
[F.3. HBase 论文](http://abloz.com/hbase/book.html#other.info.papers)
[F.4. HBase 网站](http://abloz.com/hbase/book.html#other.info.sites)
[F.5. HBase 书籍](http://abloz.com/hbase/book.html#other.info.books)
[F.6. Hadoop 书籍](http://abloz.com/hbase/book.html#other.info.books.hadoop)
[G. HBase 历史](http://abloz.com/hbase/book.html#hbase.history) [H. HBase 和 Apache 软件基金会(ASF)](http://abloz.com/hbase/book.html#asf)



[H.1. ASF开发进程](http://abloz.com/hbase/book.html#asf.devprocess)
[H.2. ASF 报告板](http://abloz.com/hbase/book.html#asf.reporting)
[词汇表](http://abloz.com/hbase/book.html#book_index)



    
