---
author: abloz
comments: true
date: 2013-08-30 05:35:56+00:00
layout: post
link: http://abloz.com/index.php/2013/08/30/try-go-language/
slug: try-go-language
title: Go 语言试用
wordpress_id: 2212
categories:
- 技术
tags:
- go
---

周海汉 /文 2013.8.30








## 安装测试




官网




[http://golang.org/](http://golang.org/)







下载


[https://code.google.com/p/go/downloads/list](https://code.google.com/p/go/downloads/list)





wget [https://go.googlecode.com/files/go1.1.2.linux-amd64.tar.gz](https://go.googlecode.com/files/go1.1.2.linux-amd64.tar.gz)







解压后会生成go目录




 




[andy@s1 test]$ cat hello.go
package mainimport "fmt"

func main() {
fmt.Println("Hello, 世界")
}









[andy@s1 test]$ go build hello.go
hello.go:3:8: cannot find package "fmt" in any of:
/usr/local/go/src/pkg/fmt (from $GOROOT)
($GOPATH not set)
package runtime: cannot find package "runtime" in any of:
/usr/local/go/src/pkg/runtime (from $GOROOT)
($GOPATH not set)










配一下环境变量：







[andy@s1 ~]$ cat .bashrc




export GOROOT=/home/andy/go
export GOPATH=/home/andy/go/src/pkg
export PATH=$GOROOT/bin:$PATH







[andy@s1 test]$ go build hello.go









[andy@s1 test]$ ./hello
Hello, 世界




## GOPATH







GOPATH是git 获取更新时下载到的地址。


 下面是以为外国朋友对GOPATH的测试： 








    
    rday@rday-laptop:~/golang$ mkdir packages1
    rday@rday-laptop:~/golang$ export GOPATH=~/golang/packages1/
    rday@rday-laptop:~/golang$ go get github.com/rday/web
    rday@rday-laptop:~/golang$ ls packages1/src/github.com/
    rday
    rday@rday-laptop:~/golang$ mkdir packages2
    rday@rday-laptop:~/golang$ export GOPATH=~/golang/packages2/
    rday@rday-laptop:~/golang$ go get github.com/alphazero/Go-Redis
    rday@rday-laptop:~/golang$ ls packages2/src/github.com/
    alphazero
    rday@rday-laptop:~/golang$



    
    When we change $GOPATH, and grab a new package, our new package is stored in the new $GOPATH directory




[andy@s1 test]$ !go
go build hello.go





## 测试mysql


安装go的mysql驱动：

    
    [andy@s1 pkg]$ mkdir mysql



    
    [andy@s1 pkg]$ cd mysql
    [andy@s1 mysql]$ pwd
    /home/andy/go/src/pkg/mysql






    
    #[andy@s1 mysql]$ export GOPATH=/home/andy/go/src/pkg/mysql



    
    [andy@s1 ~]$ echo $GOPATH
    /home/andy/go
    [andy@s1 ~]$ go get github.com/go-sql-driver/mysql
    warning: GOPATH set to GOROOT (/home/andy/go) has no effect
    package github.com/go-sql-driver/mysql: cannot download, $GOPATH must not be set to $GOROOT. For more details see: go help gopath






    
    [andy@s1 ~]$ echo $GOPATH
    /home/andy/go/src/pkg



    
    [andy@s1 ~]$ go get github.com/go-sql-driver/mysql



    
    [andy@s1 pkg]$ find . -name mysql
    ./src/github.com/go-sql-driver/mysql



    
    [andy@s1 pkg]$ cp -r ./src/github.com/go-sql-driver/mysql mysql






    
    [andy@s1 mysql]$ ls



    
    buffer.go      const.go   driver_test.go  infile.go  packets.go  result.go  statement.go    utils.go
    connection.go  driver.go  errors.go       LICENSE    README.md   rows.go    transaction.go  utils_test.go
    [andy@s1 mysql]$ pwd
    /home/andy/go/src/pkg/mysql/src/github.com/go-sql-driver/mysql






    
    [root@s1 mysql]# yum install mysql-devel mysql-server



    
    [root@s1 mysql]# service mysql restart



    
    mysql> use test;
    Database changed
    mysql> show tables;
    Empty set (0.00 sec)
    
    CREATE TABLE `student` (
      `id` int(11) NOT NULL AUTO_INCREMENT,
      `name` varchar(20) DEFAULT NULL,
      `age` int(11) DEFAULT NULL,
      PRIMARY KEY (`id`)
    ) ENGINE=MyISAM DEFAULT CHARSET=
    mysql> create table student(id int primary key auto_increment,name varchar(20),age int,created date) DEFAULT CHARSET=utf8;



    
    Query OK, 0 rows affected (0.08 sec)






[andy@s1 test]$ cat my.go





    
    //andy zhou 2013.8.27
    //http://abloz.com
    
    package main
    import (
        _ "mysql"
        "database/sql"
        "fmt"
    )
    
    func main() {
        db := opendb("root:@/test?charset=utf8")
        id:=insert(db)
        query(db)
        update(db,id)
    
    }
    
    //打开数据库连接
    func opendb(dbstr string) ( * sql.DB) {
    //dsn: [username[:password]@][protocol[(address)]]/dbname[?param1=value1&paramN=valueN]
        db, err := sql.Open("mysql", dbstr)
        prerr(err)
        return db
    }
    
    //插入数据
    func insert(db  * sql.DB) int64 {
    
        stmt, err := db.Prepare("INSERT INTO student SET id=?, name=?,age=?,created=?")
        prerr(err)
    
        res, err := stmt.Exec(0, "abloz1", 28, "2013-8-20")
        prerr(err)
    
        id, err := res.LastInsertId()
        prerr(err)
    
        fmt.Println(id)
        return id
    
    }
    //更新数据
    func update(db  *sql.DB,id int64) {
        stmt, err := db.Prepare("update student set name=? where id=?")
        prerr(err)
    
        res, err := stmt.Exec("abloz2", id)
        prerr(err)
    
        affect, err := res.RowsAffected()
        prerr(err)
    
        fmt.Println(affect)
    }



    
    //查询数据
    func query(db  * sql.DB) {
    
        rows, err := db.Query("SELECT * FROM student")
        prerr(err)
    
        for rows.Next() {
            var id int
            var name string
            var department string
            var created string
            err = rows.Scan(&id, &name, &department, &created)
            prerr(err)
            fmt.Println(id)
            fmt.Println(name)
            fmt.Println(department)
            fmt.Println(created)
        }
    }
    
    //删除数据
    func del(db  * sql.DB, id int64) {
        stmt, err := db.Prepare("delete from student where id=?")
        prerr(err)
    
        res, err := stmt.Exec(id)
        prerr(err)
    
        affect, err := res.RowsAffected()
        prerr(err)
    
        fmt.Println(affect)
    }
    func prerr(err error) {
        if err != nil {
            panic(err)
        }
    }
    
    执行：
    [andy@s1 test]$ go build my.go


[andy@s1 test]$ ./my
4
1
helloå‘¨
30
2013-08-27
2
abloz2
28
2013-08-20
3
abloz2
28
2013-08-20
4
abloz1
28
2013-08-20
1








