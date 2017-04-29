---
layout: post
title:  "pymysql 解决utf8mb4扩展"
date:   2017-02-28 20:17:26 +0800
categories: 技术
---

# 问题
在将一些emoji表情符号入库时, 发现utf8的表插入会失败. mysql5.6以上支持utf8mb4的扩展, 必须配置相应的扩展, 并且客户端python程序采用最新的pymysql,设置charset='utf8mb4'才可以正确插入.
采用MySqlDB则不能解决该中文乱码问题.
创建库的缺省编码指定utf8mb4
```sql
CREATE DATABASE `data_v1` DEFAULT CHARACTER SET utf8mb4
```

```python
# coding:utf8
# author:zhh
# 2017.2.28
# 以前写的一个插入utf8mb4扩展解决表情符等乱码问题
import pymysql

def getConn():
    conn=pymysql.connect(host='10.43.4.148',
                         port=3306,
                         user='myuser',
                         passwd='pwd',
                         charset='utf8mb4',
                         db='data_v1')
    return conn

def insert(conn):
    cur = conn.cursor()
    mystr = "zhh2爱我的请举手🙋，爱我的请举手..."
    sql = "insert into news_content_new (content) values('%s')"%mystr
    cur.execute(sql)
    conn.commit()
    cur.close()
    conn.close()

if __name__ == "__main__":
    conn = getConn()
    insert(conn)
```

# 参考
- [mysql utf8mb4与emoji表情](https://my.oschina.net/wingyiu/blog/153357)
