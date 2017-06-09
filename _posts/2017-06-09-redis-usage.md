---
layout: post
title:  "redis基本使用"
author: "周海汉"
date:   2017-06-09 20:18:26 +0800
categories: tech
tags:
    - docker
    - redis
---

# redis使用

```
[zhouhh@mainServer redis]$ redis-cli -h 172.17.0.2
172.17.0.2:6379> set test='zhouhh'
(error) ERR wrong number of arguments for 'set' command
172.17.0.2:6379> set test 'zhouhh'
OK
172.17.0.2:6379> get test
"zhouhh"

172.17.0.2:6379> ping
PONG
172.17.0.2:6379> set conn 10
OK
172.17.0.2:6379> incr conn
(integer) 11
172.17.0.2:6379> del conn
(integer) 1
172.17.0.2:6379> get conn
(nil)
172.17.0.2:6379> incr conn
(integer) 1
172.17.0.2:6379> get conn
"1"


```
incr 是原子操作.
如果有两台设备同时执行下面到操作,count=10
```
x = GET count
x = x + 1
SET count x
```
流程可能是
1. a 得到x值为10
1. b 得到x值为10
1. a 加1后 count为11
1. b 增加1后 count为11

我们期望 count为12.
用incr就会保证原子操作, 得到的值是12

```
172.17.0.2:6379> set res:lock "redis lock"
OK
172.17.0.2:6379> expire res:lock 60
(integer) 1
172.17.0.2:6379> get res:lock
"redis lock"
172.17.0.2:6379> ttl res:lock
(integer) 56

172.17.0.2:6379> get res:lock
(nil)
172.17.0.2:6379> ttl res:lock
(integer) -2

```
expire 表示设置资源失效时间,单位秒.
ttl可以查询资源失效时间. 
1. 大于0的值表示 该秒数时间资源失效.
1. -1表示永不失效. 
1. -2表示已经失效.


# 数据结构

## 列表操作
 RPUSH, LPUSH, LLEN, LINDEX, LRANGE, LREM, LSET, LTRIM, LPOP, 和 RPOP.
```
172.17.0.2:6379> rpush stu "alice"
(integer) 1
172.17.0.2:6379> lrange stu 0 -1
1) "alice"
172.17.0.2:6379> get stu
(error) WRONGTYPE Operation against a key holding the wrong kind of value
172.17.0.2:6379> get stu[0]
(nil)
172.17.0.2:6379> rpush stu bob
(integer) 2
172.17.0.2:6379> lrange stu 0 -1
1) "alice"
2) "bob"
172.17.0.2:6379> rpush stu mike
(integer) 3
172.17.0.2:6379> lrange stu 0 -1
1) "alice"
2) "bob"
3) "mike"
172.17.0.2:6379> lpush stu jack
(integer) 4
172.17.0.2:6379> lrange stu 0 -1
1) "jack"
2) "alice"
3) "bob"
4) "mike"

```

header 1 | header 2
---|---
row 1 col 1 | row 1 col 2
row 2 col 1 | row 2 col 2



序号 | 命令 | 描述
--- | --- | --
1 | BLPOP key1 [key2 ] timeout | 移出并获取列表的第一个元素， 如果列表没有元素会阻塞列表直到等待超时或发现可弹出元素为止。
2 | BRPOP key1 [key2 ] timeout | 移出并获取列表的最后一个元素， 如果列表没有元素会阻塞列表直到等待超时或发现可弹出元素为止。
3 | BRPOPLPUSH source destination timeout | 从列表中弹出一个值，将弹出的元素插入到另外一个列表中并返回它； 如果列表没有元素会阻塞列表直到等待超时或发现可弹出元素为止。
4 | LINDEX key index | 通过索引获取列表中的元素
5 | LINSERT key BEFORE|AFTER pivot value | 在列表的元素前或者后插入元素
6 | LLEN key | 获取列表长度
7 | LPOP key | 移出并获取列表的第一个元素
8 | LPUSH key value1 [value2] | 将一个或多个值插入到列表头部
9 | LPUSHX key value | 将一个或多个值插入到已存在的列表头部
10 | LRANGE key start stop | 获取列表指定范围内的元素
11 | LREM key count value | 移除列表元素
12 | LSET key index value | 通过索引设置列表元素的值
13 | LTRIM key start stop | 对一个列表进行修剪(trim)，就是说，让列表只保留指定区间内的元素，不在指定区间之内的元素都将被删除。
14 | RPOP key | 移除并获取列表最后一个元素
15 | RPOPLPUSH source destination | 移除列表的最后一个元素，并将该元素添加到另一个列表并返回
16 | RPUSH key value1 [value2] | 在列表中添加一个或多个值
17 | RPUSHX key value | 为已存在的列表添加值

## 集合 set
 
### 非排序集合 
 SADD, SREM, SISMEMBER, SMEMBERS and SUNION
 
 ```
 172.17.0.2:6379> sadd friends alice
(integer) 1
172.17.0.2:6379> smembers friends
1) "alice"
172.17.0.2:6379> sadd friends alice
(integer) 0
172.17.0.2:6379> smembers friends
1) "alice"
172.17.0.2:6379> sadd friends bob
(integer) 1
172.17.0.2:6379> smembers friends
1) "alice"
2) "bob"

```

### 排序集合

```
172.17.0.2:6379> zadd worker 1 alice
(integer) 1
172.17.0.2:6379> zadd worker 10 zhouhh
(integer) 1
172.17.0.2:6379> zadd worker 2 zzz
(integer) 1

172.17.0.2:6379> zrange worker 1 3
1) "zzz"
2) "zhouhh"
172.17.0.2:6379> zrange worker 0 -1
1) "alice"
2) "zzz"
3) "zhouhh"
```

# 哈希
HSET,HGET,HMSET,HGETALL,HINCRBY,
HDEL

```
172.17.0.2:6379> hset user:1 name zhh
(integer) 1
172.17.0.2:6379> hset user:1 email zhh@abloz.com
(integer) 1
172.17.0.2:6379> hset user:1 tel 123456
(integer) 1
172.17.0.2:6379> hgetall user
(empty list or set)
172.17.0.2:6379> hgetall user:1
1) "name"
2) "zhh"
3) "email"
4) "zhh@abloz.com"
5) "tel"
6) "123456"
172.17.0.2:6379> hget user:1 name
"zhh"
172.17.0.2:6379> hmset user:2 name 'duck ducky' email 'duck@abloz.com' tel '345666'
OK
172.17.0.2:6379> hgetall user:2
1) "name"
2) "duck ducky"
3) "email"
4) "duck@abloz.com"
5) "tel"
6) "345666"
172.17.0.2:6379> hget user:2 name
"duck ducky"
172.17.0.2:6379> hset user:1 visits 100
(integer) 1
172.17.0.2:6379> hincrby user:1 visits 5
(integer) 105
172.17.0.2:6379> hget user:1 visits
"105"
```
# 事务
```
172.17.0.2:6379> set a 1
OK
172.17.0.2:6379> lpush b 2
(integer) 1
172.17.0.2:6379> set c 3
OK
172.17.0.2:6379> multi
OK
172.17.0.2:6379> incr a
QUEUED
172.17.0.2:6379> incr b
QUEUED
172.17.0.2:6379> incr c
QUEUED
172.17.0.2:6379> exec
1) (integer) 2
2) (error) WRONGTYPE Operation against a key holding the wrong kind of value
3) (integer) 4
172.17.0.2:6379> get a
"2"
172.17.0.2:6379> get c
"4"

```
事务不会全部回滚, 仅保证内部顺序执行.

# 发布和订阅

发布
```
[zhouhh@mainServer ~]$ redis-cli -h 172.17.0.2
172.17.0.2:6379> publish mychannel hello
(integer) 1
172.17.0.2:6379> publish mychannel 你好
(integer) 1

```
订阅
```
172.17.0.2:6379> psubscribe my*
Reading messages... (press Ctrl-C to quit)
1) "psubscribe"
2) "my*"
3) (integer) 1

1) "pmessage"
2) "my*"
3) "mychannel"
4) "hello"
1) "pmessage"
2) "my*"
3) "mychannel"
4) "\xe4\xbd\xa0\xe5\xa5\xbd"

```
