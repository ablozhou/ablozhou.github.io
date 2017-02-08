---
author: abloz
comments: true
date: 2012-06-07 11:44:31+00:00
layout: post
link: http://abloz.com/index.php/2012/06/07/hbase-the-java-to-read-and-write-instance/
slug: hbase-the-java-to-read-and-write-instance
title: hbase java 读写实例
wordpress_id: 1682
categories:
- 技术
tags:
- hbase
- java
---





    
    package com.abloz.hbase;
    //date:2012.6.7
    //http://abloz.com
    //hadoop 1.0.3
    //hbase 0.94.0
    //tested on centos 5.5
    //cluster distributed system:Hadoop48,Hadoop47,Hadoop46
    /*
     [zhouhh@Hadoop48 hbase-0.94.0]$ cat conf/hbase-site.xml
    
    
    
        hbase.rootdir
        
        hdfs://Hadoop48:54310/hbase
    
        hbase.cluster.distributed
        true
    
        hbase.master.port
        60000
    
          hbase.zookeeper.quorum
          Hadoop48,Hadoop47,Hadoop46
    
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
    
    	public static void main(String[] args)
    	{
    		String tableName = "student";
    		String[] families = {"age","sex"};
    		try
    		{
    			HBaseTest.createTable(tableName,families);
    			String rowKey="zhh";
    			String family="age";
    			String value="28";
    			HBaseTest.putData(tableName, rowKey, family, "", value);
    			family="sex";
    			value="male";
    
    			HBaseTest.putData(tableName, rowKey, family, "", value);
    
    			rowKey="yff";
    			family="age";
    			value="20";
    			HBaseTest.putData(tableName, rowKey, family, "", value);
    			family="sex";
    			value="female";
    			HBaseTest.putData(tableName, rowKey, family, "", value);
    
    			HBaseTest.getData(tableName, rowKey);
    
    			HBaseTest.scanData(tableName);
    
    		}
    		catch (Exception e)
    		{
    			e.printStackTrace();
    		}
    	}
    
    }


执行后输出：

    
    12/06/07 19:30:00 INFO zookeeper.ZooKeeper: Client environment:zookeeper.version=3.4.3-1240972, built on 02/06/2012 10:48 GMT
    12/06/07 19:30:00 INFO zookeeper.ZooKeeper: Client environment:host.name=Hadoop48
    12/06/07 19:30:00 INFO zookeeper.ZooKeeper: Client environment:java.version=1.7.0
    12/06/07 19:30:00 INFO zookeeper.ZooKeeper: Client environment:java.vendor=Oracle Corporation
    12/06/07 19:30:00 INFO zookeeper.ZooKeeper: Client environment:java.home=/usr/java/jdk1.7.0/jre
    12/06/07 19:30:00 INFO zookeeper.ZooKeeper: Client environment:java.class.path=/home/zhouhh/workspace/.metadata/.plugins/org.apache.hadoop.eclipse/hadoop-conf-9138530567059164014:/home/zhouhh/workspace/myhbase/bin:/home/zhouhh/hadoop-1.0.3/lib/jasper-compiler-5.5.12.jar:/home/zhouhh/hadoop-1.0.3/lib/xmlenc-0.52.jar:/home/zhouhh/hadoop-1.0.3/lib/hadoop-capacity-scheduler-1.0.3.jar:/home/zhouhh/hadoop-1.0.3/lib/jersey-json-1.8.jar:/home/zhouhh/hadoop-1.0.3/lib/commons-logging-1.1.1.jar:/home/zhouhh/hadoop-1.0.3/lib/hsqldb-1.8.0.10.jar:/home/zhouhh/hadoop-1.0.3/lib/commons-configuration-1.6.jar:/home/zhouhh/hadoop-1.0.3/lib/commons-math-2.1.jar:/home/zhouhh/hadoop-1.0.3/lib/commons-net-1.4.1.jar:/home/zhouhh/hadoop-1.0.3/lib/commons-beanutils-1.7.0.jar:/home/zhouhh/hadoop-1.0.3/lib/jdom.jar:/home/zhouhh/hadoop-1.0.3/lib/commons-httpclient-3.0.1.jar:/home/zhouhh/hadoop-1.0.3/lib/junit-4.5.jar:/home/zhouhh/hadoop-1.0.3/lib/jackson-core-asl-1.8.8.jar:/home/zhouhh/hadoop-1.0.3/lib/commons-beanutils-core-1.8.0.jar:/home/zhouhh/hadoop-1.0.3/lib/servlet-api-2.5-20081211.jar:/home/zhouhh/hadoop-1.0.3/lib/commons-io-2.1.jar:/home/zhouhh/hadoop-1.0.3/lib/jsch-0.1.42.jar:/home/zhouhh/hadoop-1.0.3/lib/jetty-6.1.26.jar:/home/zhouhh/hadoop-1.0.3/lib/jersey-server-1.8.jar:/home/zhouhh/hadoop-1.0.3/lib/commons-digester-1.8.jar:/home/zhouhh/hadoop-1.0.3/lib/aspectjtools-1.6.5.jar:/home/zhouhh/hadoop-1.0.3/lib/slf4j-api-1.4.3.jar:/home/zhouhh/hadoop-1.0.3/lib/commons-lang-2.4.jar:/home/zhouhh/hadoop-1.0.3/lib/mockito-all-1.8.5.jar:/home/zhouhh/hadoop-1.0.3/lib/jdeb-0.8.jar:/home/zhouhh/hadoop-1.0.3/lib/oro-2.0.8.jar:/home/zhouhh/hadoop-1.0.3/lib/commons-daemon-1.0.1.jar:/home/zhouhh/hadoop-1.0.3/lib/jackson-mapper-asl-1.8.8.jar:/home/zhouhh/hadoop-1.0.3/lib/commons-codec-1.4.jar:/home/zhouhh/hadoop-1.0.3/lib/commons-el-1.0.jar:/home/zhouhh/hadoop-1.0.3/lib/slf4j-log4j12-1.4.3.jar:/home/zhouhh/hadoop-1.0.3/lib/jasper-runtime-5.5.12.jar:/home/zhouhh/hadoop-1.0.3/lib/commons-collections-3.2.1.jar:/home/zhouhh/hadoop-1.0.3/lib/commons-logging-api-1.0.4.jar:/home/zhouhh/hadoop-1.0.3/lib/hadoop-thriftfs-1.0.3.jar:/home/zhouhh/hadoop-1.0.3/lib/jetty-util-6.1.26.jar:/home/zhouhh/hadoop-1.0.3/lib/aspectjrt-1.6.5.jar:/home/zhouhh/hadoop-1.0.3/lib/hadoop-fairscheduler-1.0.3.jar:/home/zhouhh/hadoop-1.0.3/lib/log4j-1.2.15.jar:/home/zhouhh/hadoop-1.0.3/lib/jets3t-0.6.1.jar:/home/zhouhh/hadoop-1.0.3/lib/core-3.1.1.jar:/home/zhouhh/hadoop-1.0.3/lib/kfs-0.2.2.jar:/home/zhouhh/hadoop-1.0.3/lib/jersey-core-1.8.jar:/home/zhouhh/hadoop-1.0.3/lib/asm-3.2.jar:/home/zhouhh/hadoop-1.0.3/lib/commons-cli-1.2.jar:/home/zhouhh/hadoop-1.0.3/hadoop-ant-1.0.3.jar:/home/zhouhh/hadoop-1.0.3/hadoop-minicluster-1.0.3.jar:/home/zhouhh/hadoop-1.0.3/hadoop-client-1.0.3.jar:/home/zhouhh/hadoop-1.0.3/hadoop-core-1.0.3.jar:/home/zhouhh/hadoop-1.0.3/hadoop-tools-1.0.3.jar:/home/zhouhh/hbase-0.94.0/hbase-0.94.0.jar:/home/zhouhh/hbase-0.94.0/hbase-0.94.0-tests.jar:/home/zhouhh/hbase-0.94.0/slf4j-log4j12-1.5.8.jar:/home/zhouhh/hbase-0.94.0/lib/activation-1.1.jar:/home/zhouhh/hbase-0.94.0/lib/asm-3.1.jar:/home/zhouhh/hbase-0.94.0/lib/avro-1.5.3.jar:/home/zhouhh/hbase-0.94.0/lib/avro-ipc-1.5.3.jar:/home/zhouhh/hbase-0.94.0/lib/commons-beanutils-1.7.0.jar:/home/zhouhh/hbase-0.94.0/lib/commons-beanutils-core-1.8.0.jar:/home/zhouhh/hbase-0.94.0/lib/commons-cli-1.2.jar:/home/zhouhh/hbase-0.94.0/lib/commons-codec-1.4.jar:/home/zhouhh/hbase-0.94.0/lib/commons-collections-3.2.1.jar:/home/zhouhh/hbase-0.94.0/lib/commons-configuration-1.6.jar:/home/zhouhh/hbase-0.94.0/lib/commons-digester-1.8.jar:/home/zhouhh/hbase-0.94.0/lib/commons-el-1.0.jar:/home/zhouhh/hbase-0.94.0/lib/commons-httpclient-3.1.jar:/home/zhouhh/hbase-0.94.0/lib/commons-io-2.1.jar:/home/zhouhh/hbase-0.94.0/lib/commons-lang-2.5.jar:/home/zhouhh/hbase-0.94.0/lib/commons-logging-1.1.1.jar:/home/zhouhh/hbase-0.94.0/lib/commons-math-2.1.jar:/home/zhouhh/hbase-0.94.0/lib/commons-net-1.4.1.jar:/home/zhouhh/hbase-0.94.0/lib/core-3.1.1.jar:/home/zhouhh/hbase-0.94.0/lib/guava-r09.jar:/home/zhouhh/hbase-0.94.0/lib/hadoop-core-1.0.2.jar:/home/zhouhh/hbase-0.94.0/lib/high-scale-lib-1.1.1.jar:/home/zhouhh/hbase-0.94.0/lib/httpclient-4.1.2.jar:/home/zhouhh/hbase-0.94.0/lib/httpcore-4.1.3.jar:/home/zhouhh/hbase-0.94.0/lib/jackson-core-asl-1.5.5.jar:/home/zhouhh/hbase-0.94.0/lib/jackson-jaxrs-1.5.5.jar:/home/zhouhh/hbase-0.94.0/lib/jackson-mapper-asl-1.5.5.jar:/home/zhouhh/hbase-0.94.0/lib/jackson-xc-1.5.5.jar:/home/zhouhh/hbase-0.94.0/lib/jamon-runtime-2.3.1.jar:/home/zhouhh/hbase-0.94.0/lib/jasper-compiler-5.5.23.jar:/home/zhouhh/hbase-0.94.0/lib/jasper-runtime-5.5.23.jar:/home/zhouhh/hbase-0.94.0/lib/jaxb-api-2.1.jar:/home/zhouhh/hbase-0.94.0/lib/jaxb-impl-2.1.12.jar:/home/zhouhh/hbase-0.94.0/lib/jersey-core-1.4.jar:/home/zhouhh/hbase-0.94.0/lib/jersey-json-1.4.jar:/home/zhouhh/hbase-0.94.0/lib/jersey-server-1.4.jar:/home/zhouhh/hbase-0.94.0/lib/jettison-1.1.jar:/home/zhouhh/hbase-0.94.0/lib/jetty-6.1.26.jar:/home/zhouhh/hbase-0.94.0/lib/jetty-util-6.1.26.jar:/home/zhouhh/hbase-0.94.0/lib/jruby-complete-1.6.5.jar:/home/zhouhh/hbase-0.94.0/lib/jsp-2.1-6.1.14.jar:/home/zhouhh/hbase-0.94.0/lib/jsp-api-2.1-6.1.14.jar:/home/zhouhh/hbase-0.94.0/lib/libthrift-0.8.0.jar:/home/zhouhh/hbase-0.94.0/lib/log4j-1.2.16.jar:/home/zhouhh/hbase-0.94.0/lib/netty-3.2.4.Final.jar:/home/zhouhh/hbase-0.94.0/lib/protobuf-java-2.4.0a.jar:/home/zhouhh/hbase-0.94.0/lib/servlet-api-2.5-6.1.14.jar:/home/zhouhh/hbase-0.94.0/lib/slf4j-api-1.5.8.jar:/home/zhouhh/hbase-0.94.0/lib/snappy-java-1.0.3.2.jar:/home/zhouhh/hbase-0.94.0/lib/stax-api-1.0.1.jar:/home/zhouhh/hbase-0.94.0/lib/velocity-1.7.jar:/home/zhouhh/hbase-0.94.0/lib/xmlenc-0.52.jar:/home/zhouhh/hbase-0.94.0/lib/zookeeper-3.4.3.jar
    12/06/07 19:30:00 INFO zookeeper.ZooKeeper: Client environment:java.library.path=/usr/java/packages/lib/amd64:/usr/lib64:/lib64:/lib:/usr/lib
    12/06/07 19:30:00 INFO zookeeper.ZooKeeper: Client environment:java.io.tmpdir=/tmp
    12/06/07 19:30:00 INFO zookeeper.ZooKeeper: Client environment:java.compiler=<NA>
    12/06/07 19:30:00 INFO zookeeper.ZooKeeper: Client environment:os.name=Linux
    12/06/07 19:30:00 INFO zookeeper.ZooKeeper: Client environment:os.arch=amd64
    12/06/07 19:30:00 INFO zookeeper.ZooKeeper: Client environment:os.version=2.6.18-194.el5
    12/06/07 19:30:00 INFO zookeeper.ZooKeeper: Client environment:user.name=zhouhh
    12/06/07 19:30:00 INFO zookeeper.ZooKeeper: Client environment:user.home=/home/zhouhh
    12/06/07 19:30:00 INFO zookeeper.ZooKeeper: Client environment:user.dir=/home/zhouhh/workspace/myhbase
    12/06/07 19:30:00 INFO zookeeper.ZooKeeper: Initiating client connection, connectString=localhost:2181 sessionTimeout=180000 watcher=hconnection
    12/06/07 19:30:00 INFO zookeeper.ClientCnxn: Opening socket connection to server /127.0.0.1:2181
    12/06/07 19:30:00 INFO client.ZooKeeperSaslClient: Client will not SASL-authenticate because the default JAAS configuration section 'Client' could not be found. If you are not using SASL, you may ignore this. On the other hand, if you expected SASL to work, please fix your JAAS configuration.
    12/06/07 19:30:00 INFO zookeeper.ClientCnxn: Socket connection established to localhost.localdomain/127.0.0.1:2181, initiating session
    12/06/07 19:30:00 INFO zookeeper.RecoverableZooKeeper: The identifier of this process is 16604@Hadoop48
    12/06/07 19:30:00 INFO zookeeper.ClientCnxn: Session establishment complete on server localhost.localdomain/127.0.0.1:2181, sessionid = 0x37c4cc9e3f0018, negotiated timeout = 180000
    12/06/07 19:30:01 INFO zookeeper.ZooKeeper: Initiating client connection, connectString=localhost:2181 sessionTimeout=180000 watcher=catalogtracker-on-org.apache.hadoop.hbase.client.HConnectionManager$HConnectionImplementation@6a4b72c
    12/06/07 19:30:01 INFO zookeeper.ClientCnxn: Opening socket connection to server /127.0.0.1:2181
    12/06/07 19:30:01 INFO client.ZooKeeperSaslClient: Client will not SASL-authenticate because the default JAAS configuration section 'Client' could not be found. If you are not using SASL, you may ignore this. On the other hand, if you expected SASL to work, please fix your JAAS configuration.
    12/06/07 19:30:01 INFO zookeeper.ClientCnxn: Socket connection established to localhost.localdomain/127.0.0.1:2181, initiating session
    12/06/07 19:30:01 INFO zookeeper.ClientCnxn: Session establishment complete on server localhost.localdomain/127.0.0.1:2181, sessionid = 0x37c4cc9e3f0019, negotiated timeout = 180000
    12/06/07 19:30:01 INFO zookeeper.RecoverableZooKeeper: The identifier of this process is 16604@Hadoop48
    12/06/07 19:30:01 INFO zookeeper.ZooKeeper: Session: 0x37c4cc9e3f0019 closed
    12/06/07 19:30:01 INFO zookeeper.ClientCnxn: EventThread shut down
    12/06/07 19:30:01 INFO client.HBaseAdmin: Started disable of student
    12/06/07 19:30:02 INFO client.HBaseAdmin: Disabled student
    table student exist,delete it.
    12/06/07 19:30:03 INFO client.HBaseAdmin: Deleted student
    <span style="color: #ff6600;">table student create ok.</span>
    <span style="color: #ff6600;">put data to student,rowKey:zhh,family:age,qual:,value:28</span>
    <span style="color: #ff6600;">put data to student,rowKey:zhh,family:sex,qual:,value:male</span>
    <span style="color: #ff6600;">put data to student,rowKey:yff,family:age,qual:,value:20</span>
    <span style="color: #ff6600;">put data to student,rowKey:yff,family:sex,qual:,value:female</span>
    <span style="color: #ff6600;">get from student,rowkey:yff</span>
    <span style="color: #ff6600;">yff: age:, 20, 1339068604414</span>
    <span style="color: #ff6600;">yff: sex:, female, 1339068604422</span>
    <span style="color: #ff6600;">scan student</span>
    <span style="color: #ff6600;">==============begin=================</span>
    <span style="color: #ff6600;">yff: age:, 20, 1339068604414</span>
    <span style="color: #ff6600;">yff: sex:, female, 1339068604422</span>
    <span style="color: #ff6600;">zhh: age:, 28, 1339068604409</span>
    <span style="color: #ff6600;">zhh: sex:, male, 1339068604412</span>
    <span style="color: #ff6600;">================end===============</span>


参考:

[http://blog.csdn.net/fangwei1235/article/details/7333577](http://blog.csdn.net/fangwei1235/article/details/7333577)
