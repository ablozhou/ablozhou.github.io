---
author: abloz
comments: true
date: 2013-01-30 10:47:55+00:00
layout: post
link: http://abloz.com/index.php/2013/01/30/analyze-data-from-hdfs-to-hbase/
slug: analyze-data-from-hdfs-to-hbase
title: 从HDFS分析数据到HBase
wordpress_id: 2100
categories:
- 技术
tags:
- flume
- hadoop
- mapreduce
---

周海汉

2013.1.30

http://abloz.com



**需求：**

需要将flume收集到hdfs的数据分析后导入HBase里。 行键是userid+date,value是该用户当天全部记录，并对记录按时间排序。

**问题1：**

TableMapReduceUtil来设置Reduce时输出到HBase，会缺省设置OutPutKeyFormat为ImmutableBytesWritable，OutPutValueFormat为Writable类型。所以我想用Text来做OutKey和OutValue，需在ableMapReduceUtil.initTableReducerJob后调用

job.setOutputKeyClass(Text.class);
job.setOutputValueClass(Text.class);

否则会报错：

13/01/30 18:41:09 WARN mapred.LocalJobRunner: job_local_0001
java.io.IOException: Type mismatch in key from map: expected org.apache.hadoop.hbase.io.ImmutableBytesWritable, recieved org.apache.hadoop.io.Text
at org.apache.hadoop.mapred.MapTask$MapOutputBuffer.collect(MapTask.java:1014)
at org.apache.hadoop.mapred.MapTask$NewOutputCollector.write(MapTask.java:691)
at org.apache.hadoop.mapreduce.TaskInputOutputContext.write(TaskInputOutputContext.java:80)
at cn.jj.hbase.UserAnalysis$UserMapper.map(UserAnalysis.java:54)
at cn.jj.hbase.UserAnalysis$UserMapper.map(UserAnalysis.java:1)
at org.apache.hadoop.mapreduce.Mapper.run(Mapper.java:144)
at org.apache.hadoop.mapred.MapTask.runNewMapper(MapTask.java:764)
at org.apache.hadoop.mapred.MapTask.run(MapTask.java:370)
at org.apache.hadoop.mapred.LocalJobRunner$Job.run(LocalJobRunner.java:212)



**问题2：**

找不到zookeeper：

3/01/30 18:42:13 WARN zookeeper.ClientCnxn: Session 0x0 for server null, unexpected error, closing socket connection and attempting reconnect
java.net.ConnectException: Connection refused
at sun.nio.ch.SocketChannelImpl.checkConnect(Native Method)
at sun.nio.ch.SocketChannelImpl.finishConnect(SocketChannelImpl.java:701)
at org.apache.zookeeper.ClientCnxnSocketNIO.doTransport(ClientCnxnSocketNIO.java:286)
at org.apache.zookeeper.ClientCnxn$SendThread.run(ClientCnxn.java:1035)

可以用

conf.set("hbase.zookeeper.quorum", "Hadoop46,Hadoop47,Hadoop48");
conf.set("hbase.zookeeper.property.clientPort", "22228");

来手动配置，或将hbase-site.xml复制到当前工作目录或设置相关环境变量。这样方便在eclipse中直接调试。

**问题3：**

****遇到Text.toBytes出现截断问题。

rowkey 正确的为:

92903526:01/25/13

却变成了

92903526:01/25/133

后将Text先转为String，再用Bytes.toBytes()来转就正确了。



**问题4：**

****Reduce中如何对Iterate<Text> values中的values进行排序？

目前是将迭代器中内容放到ArrayList中，然后对其排序，再转为String。



    
    package com.abloz;
    // zhouhh 2013.1.30
    import java.io.IOException;
    import java.util.ArrayList;
    import java.util.Collections;
    import java.util.List;
    
    import org.apache.hadoop.conf.Configuration;
    import org.apache.hadoop.fs.Path;
    import org.apache.hadoop.io.LongWritable;
    import org.apache.hadoop.io.Text;
    import org.apache.hadoop.io.Writable;
    import org.apache.hadoop.mapreduce.Job;
    import org.apache.hadoop.mapreduce.Mapper;
    import org.apache.hadoop.mapreduce.Reducer;
    import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
    import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
    import org.apache.hadoop.util.GenericOptionsParser;
    import org.apache.hadoop.util.StringUtils;
    
    import org.apache.hadoop.hbase.client.Put;
    import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
    import org.apache.hadoop.hbase.mapreduce.TableMapReduceUtil;
    
    //import org.apache.hadoop.hbase.mapreduce.TableOutputFormat;
    import org.apache.hadoop.hbase.util.Bytes;
    import org.apache.log4j.Logger;
    
    public class UserAnalysis  {
    	private static final Logger LOG = Logger.getLogger(UserAnalysis.class);
        private final static String TABLE_NAME="userlog";
        private final static String family="i";
        private final static String qualifier="v";
      public static class UserMapper
           extends Mapper{
    
        public void map(LongWritable key, Text value, Context context
                        ) throws IOException, InterruptedException {
    
        	String[] slist=value.toString().split("t", 2);
    
        	String[] slead=slist[0].split(" ");
        	String date=slead[0];
        	String uid = slead[3];
        	LOG.info("uid:"+uid+" date:"+date);
        	String keystring=uid+":"+date;
        	LOG.info("keystring:"+keystring);
    
        	if(uid != "0")
        	{
        		context.write(new Text(Bytes.toBytes(keystring)),value);
        	}
        }
      }
    
      public static class UserReducer
           extends Reducer {
    
    	public void reduce(Text key, Iterable values,
                           Context context
                           ) throws IOException, InterruptedException {
    
        String value="";
        //Collections.sort(values);
    
        List vl = new ArrayList();
      	for (Text v:values)
    
      	{
      		vl.add(v.toString());
      		//value +=v.toString()+"n";
    
      	}
    
      	Collections.sort(vl);
      	value = StringUtils.join("n", vl);
      	LOG.info("key:"+key.toString());
      	Put put= new Put(Bytes.toBytes(key.toString()));
      	put.add(family.getBytes(), qualifier.getBytes(), value.getBytes());
      	context.write(new ImmutableBytesWritable(TABLE_NAME.getBytes()), put);
        }
      }
    
      public static Job configureJob(Configuration conf, String [] args)
      throws IOException {
    	//  conf.set(TableOutputFormat.OUTPUT_TABLE,TABLE_NAME);
    	  //conf.set("hbase.zookeeper.quorum", "Hadoop46,Hadoop47,Hadoop48");
    	  //conf.set("hbase.zookeeper.property.clientPort", "22228");
    
    	  Job job = new Job(conf, "user anaysis");
        job.setJarByClass(UserAnalysis.class);
        job.setMapperClass(UserMapper.class);
        job.setInputFormatClass(TextInputFormat.class);
        TableMapReduceUtil.initTableReducerJob(
        		TABLE_NAME,      // output table
        		null,             // reducer class
        		job);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);
    
        job.setReducerClass(UserReducer.class);
        FileInputFormat.addInputPath(job, new Path(args[0]));
    
        //job.setOutputFormatClass(TableOutputFormat.class);
        return job;
      }
      public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
        if (otherArgs.length != 1) {
          System.err.println("Usage: useras  ");
          System.exit(2);
        }
    
        Job job = configureJob(conf, otherArgs);
    
        System.exit(job.waitForCompletion(true) ? 0 : 1);
      }
    }
