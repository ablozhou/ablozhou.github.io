---
author: abloz
comments: true
date: 2012-07-03 09:52:21+00:00
layout: post
link: http://abloz.com/index.php/2012/07/03/the-hbase-how-implementation-of-the-ruby-script/
slug: the-hbase-how-implementation-of-the-ruby-script
title: hbase如何执行ruby脚本
wordpress_id: 1751
categories:
- 技术
tags:
- hbase
- ruby
---

from:http://abloz.com
author:ablozhou
date:2012.7.3

在[hbase的官方文档](http://abloz.com/hbase/book.html#shell)里，讲述了hbase的bin目录下的ruby程序，可以采用如下的方式执行：


    
    
    如果要使用脚本，可以看Hbase的bin 目录.在里面找到后缀为 *.rb的脚本.要想运行这个脚本，要这样
    
    $ ./bin/hbase org.jruby.Main PATH_TO_SCRIPT
    


如：

    
    
    [zhouhh@Hadoop48 bin]$ hbase-jruby get-active-master.rb
    Hadoop48
    [zhouhh@Hadoop48 bin]$ hbase-jruby region_status.rb
    Region Status: 92 / 92
    
    


hbase-jruby是hbase org.jruby.Main的shell封装，hbase 0.94提供在bin里。
在执行hbase的例子IndexBuilder.java，需要预先准备数据。
但该数据是用ruby文件来提供的：

    
    
    [zhouhh@Hadoop48 mapreduce]$ pwd
    /home/zhouhh/hbase-0.94.0/src/examples/mapreduce
    [zhouhh@Hadoop48 mapreduce]$ cat index-builder-setup.rb
    
    # Set up sample data for IndexBuilder example
    create "people", "attributes"
    create "people-email", "INDEX"
    create "people-phone", "INDEX"
    create "people-name", "INDEX"
    
    [["1", "jenny", "jenny@example.com", "867-5309"],
     ["2", "alice", "alice@example.com", "555-1234"],
     ["3", "kevin", "kevinpet@example.com", "555-1212"]].each do |fields|
      (id, name, email, phone) = *fields
      put "people", id, "attributes:name", name
      put "people", id, "attributes:email", email
      put "people", id, "attributes:phone", phone
    end
    
    
    


可是hbase的文档没有任何解释，如何执行该文件以导入ruby数据。如果用[hbase文档](http://abloz.com/hbase/book.html)提到的方法，报错：

    
    
    [zhouhh@Hadoop48 mapreduce]$ hbase org.jruby.Main index-builder-setup.rb
    NoMethodError: undefined method `create' for main:Object
      (root) at index-builder-setup.rb:18
    
    [zhouhh@Hadoop48 hbase-0.94.0]$ hbase-jruby ./src/examples/mapreduce/index-builder-setup.rb
    NoMethodError: undefined method `create' for main:Object
      (root) at ./src/examples/mapreduce/index-builder-setup.rb:18
    [zhouhh@Hadoop48 mapreduce]$ ruby index-builder-setup.rb
    index-builder-setup.rb:18: undefined method `create' for main:Object (NoMethodError)
    
    


一时手足无措，用java写了个导数据的程序：

    
    
    
    [zhouhh@Hadoop48 myhbase]$ cat src/com/abloz/hbase/HBaseTest.java
    package com.abloz.hbase;
    //date:2012.6.7
    //http://abloz.com
    //hadoop 1.0.3
    //hbase 0.94.0
    //tested on centos 5.5
    //cluster distributed system:Hadoop48,Hadoop47,Hadoop46
    /*
    
    
     */
    import java.io.IOException;
    
    import org.apache.hadoop.conf.Configuration;
    import org.apache.hadoop.hbase.HBaseConfiguration;
    import org.apache.hadoop.hbase.HColumnDescriptor;
    import org.apache.hadoop.hbase.HTableDescriptor;
    import org.apache.hadoop.hbase.ZooKeeperConnectionException;
    import org.apache.hadoop.hbase.client.HBaseAdmin;
    import org.apache.hadoop.hbase.client.Get;
    import org.apache.hadoop.hbase.client.HTable;
    //import org.apache.hadoop.hbase.client.Delete;
    //import org.apache.hadoop.hbase.client.HTablePool;
    import org.apache.hadoop.hbase.client.Put;
    import org.apache.hadoop.hbase.client.Scan;
    import org.apache.hadoop.hbase.client.ResultScanner;
    import org.apache.hadoop.hbase.client.Result;
    //import org.apache.hadoop.hbase.client.Action;
    import org.apache.hadoop.hbase.MasterNotRunningException;
    import org.apache.hadoop.hbase.KeyValue;
    
    //import org.apache.hadoop.hbase.
    public class HBaseTest {
            //get configure of hbase-site.xml under classpath,so needn't any configuration any more.
            public static Configuration conf =  HBaseConfiguration.create();
            //or Configuration.set(String name, String value)
            /*
             Configuration conf = new Configuration();
             //same as from hbase-site.xml
             conf.set("hbase.zookeeper.property.clientPort", "2181");
         conf.set("hbase.zookeeper.quorum", "192.168.10.48,192.168.10.47,192.168.10.46");
         public static Configuration conf1 = HBaseConfiguration.create(conf);
             */
    
            public static void createTable(String tableName, String[] families) throws Exception
            {
                    try
                    {
                            //table create,disable,exist ,drop,use HBaseAdmin
                            HBaseAdmin hadmin = new HBaseAdmin(conf);
                            if( hadmin.tableExists(tableName))
                            {
                                    hadmin.disableTable(tableName);
                                    hadmin.deleteTable(tableName);
                                    System.out.println("table "+tableName+" exist,delete it.");
    
    
                            }
    
                            HTableDescriptor tbdesc = new HTableDescriptor(tableName);
    
                            for(String family : families)
                            {
    
                                    tbdesc.addFamily(new HColumnDescriptor(family));
                            }
    
    
                            hadmin.createTable(tbdesc);
    
                    } catch (MasterNotRunningException e){
                            e.printStackTrace();
                    } catch (ZooKeeperConnectionException e) {
                            e.printStackTrace();
                    }
    
                    System.out.println("table "+ tableName+ " create ok.");
    
            }
    
            public static void putData(String tableName,String rowKey,String family, String qualifier, String value ) throws Exception
            {
                    //insert,update,delete,get row,column families, use HTable.
                    try
                    {
                            if(qualifier == null) qualifier = "";
                            if(value == null) value = "";
    
                            HTable htb = new HTable(conf,tableName);
                            Put put = new Put(rowKey.getBytes());
    
                            put.add(family.getBytes(),qualifier.getBytes(),value.getBytes());
                            htb.put(put);
                            System.out.println("put data to "+ tableName + ",rowKey:"+rowKey+",family:"+family+",qual:"+qualifier+",value:"+value);
                    }
                    catch (IOException e)
                    {
    
                            e.printStackTrace();
                    }
            }
    
            public static void getData(String tableName, String rowKey) throws Exception
            {
                    try
                    {
                            HTable htb = new HTable(conf,tableName);
                            Get get = new Get(rowKey.getBytes());
                            Result rs = htb.get(get);
                            System.out.println("get from "+tableName+ ",rowkey:"+rowKey);
                            for(KeyValue kv:rs.raw())
                            {
                                    System.out.println(new String(kv.getRow()) +":t"+
                                                    new String(kv.getFamily())+":"+
                                                    new String(kv.getQualifier())+",t"+
                                                    new String(kv.getValue())+",t"+
                                                    kv.getTimestamp()
    
                                                    );
                            }
    
                    }
                    catch (IOException e)
                    {
                            e.printStackTrace();
                    }
    
            }
    
            public static void scanData(String tableName) throws Exception
            {
                    try
                    {
                            HTable htb = new HTable(conf,tableName);
                            Scan scan = new Scan(tableName.getBytes());
                            ResultScanner rss = htb.getScanner(scan);
                            System.out.println("scan "+tableName);
                            System.out.println("==============begin=================");
                            for(Result r:rss)
                            {
    
                                    for(KeyValue kv: r.raw())
                                    {
                                            System.out.println(new String(kv.getRow()) +":t"+
                                                            new String(kv.getFamily())+":"+
                                                            new String(kv.getQualifier())+",t"+
                                                            new String(kv.getValue())+",t"+
                                                            kv.getTimestamp()
    
                                                            );
                                    }
                            }
                            System.out.println("================end===============");
    
                    }
                    catch(IOException e)
                    {
                            e.printStackTrace();
                    }
            }
    
            public static void test_student()
            {
                    String tableName = "student";
                    //String[] families = {"age","sex"};
    
                    String rowKey="1";
                    String family="class";
                    String token = "";
                    //String[] tokens={"class","score"};;
                    String value="";
                    String[] families = {"class"};
                    String[][] data={
                    {"jenny", "chinese", "85"},
                                    {"jenny", "math", "55"},
                                    {"jenny", "english", "65"},
                                    {"alice", "chinese", "74"},
                                    {"alice", "math", "88"},
                                    {"alice", "english", "85"},
                                    {"kevin", "chinese", "35"},
                                    {"kevin", "math", "95"},
                                    {"kevin", "english", "75"}
                                    };
                    try
                    {
                            HBaseTest.createTable(tableName,families);
    
                            for(String[] user:data)
                            {
                                    rowKey=user[0];
                                    token = user[1];
                                    value = user[2];
    
                                    HBaseTest.putData(tableName, rowKey, family, token, value);
    
                            }
    
    
    
                            HBaseTest.getData(tableName, rowKey);
    
                            HBaseTest.scanData(tableName);
    
                    }
                    catch (Exception e)
                    {
                            e.printStackTrace();
                    }
            }
            public static void test_people()
            {
                    String tableName = "people";
                    String rowKey="1";
                    String family="";
                    //String token="";
                    String value="";
                    String[] families = {"attribute"};
                    String[][] data={
                    {"1", "jenny", "jenny@example.com", "867-5309"},
                                    {"2", "alice", "alice@example.com", "555-1234"},
                                    {"3", "kevin", "kevinpet@example.com", "555-1212"}
                                    };
    
                    try
                    {
                            HBaseTest.createTable(tableName,families);
    
                            for(String[] user:data)
                            {
                                    rowKey=user[0];
                                    family="attribute";
                                    value=user[1];
                                    HBaseTest.putData(tableName, rowKey, family, "name", value);
                                    value=user[2];
                                    HBaseTest.putData(tableName, rowKey, family, "email", value);
                                    value=user[3];
                                    HBaseTest.putData(tableName, rowKey, family, "phone", value);
    
                            }
    
    
                            HBaseTest.getData(tableName, rowKey);
    
                            HBaseTest.scanData(tableName);
    
                    }
                    catch (Exception e)
                    {
                            e.printStackTrace();
                    }
            }
    
            public static void main(String[] args)
            {
                    //test_people();
                    test_student();
            }
    
    
    }
    


不过，感觉花了九牛二虎之力。ruby的程序相当简洁。考虑到hbase的shell是ruby写的，shell应该可以执行该程序。但进入shell，没有发现任何导入文件和执行的命令。后面灵机一动，可能是直接执行的：

    
    
    
    [zhouhh@Hadoop48 hbase-0.94.0]$ hbase shell ./src/examples/mapreduce/index-builder-setup.rb
    0 row(s) in 8.6140 seconds
    ...
    hbase(main):001:0> list
    TABLE
    
    people
    people-email
    people-name
    people-phone
    ...
    hbase(main):004:0> scan 'people'
    ROW                        COLUMN+CELL
     1                         column=attributes:email, timestamp=1341306690384, value=jenny@example.com
     1                         column=attributes:name, timestamp=1341306690278, value=jenny
    ...
    


一下子就解决了该问题。用ruby来操作hbase的数据，看来还是比较完美的方案。
