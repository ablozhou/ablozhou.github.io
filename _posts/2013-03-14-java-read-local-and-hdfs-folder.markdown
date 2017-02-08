---
author: abloz
comments: true
date: 2013-03-14 03:14:48+00:00
layout: post
link: http://abloz.com/index.php/2013/03/14/java-read-local-and-hdfs-folder/
slug: java-read-local-and-hdfs-folder
title: java 读取本地和hdfs文件夹
wordpress_id: 2159
categories:
- 技术
tags:
- hdfs
- path
---

周海汉/文
[abloz.com](http://abloz.com)
2013.3.14


    
    
    package my.test;
    import java.io.IOException;
    import org.apache.hadoop.conf.Configuration;
    
    import org.apache.hadoop.fs.FSDataInputStream;
    import org.apache.hadoop.fs.FSDataOutputStream;
    import org.apache.hadoop.fs.FileStatus;
    import org.apache.hadoop.fs.FileSystem;
    import org.apache.hadoop.fs.Path;
    /**
     *
     * @author zhouhh
     * @date 2013.3.14
     * merge files to hdfs
     */
    public class testhdfspaths {
    	public static void main(String[] args) throws IOException {
    		String sourceFile = "";
    		String targetFile = "";
    		if (args.length < 2) {
    			sourceFile = "/home/zhouhh/test";
    			targetFile = "hdfs://hadoop48:54310/user/zhouhh";
    		} else {
    			sourceFile = args[0];
    			targetFile = args[1];
    		}
    		Configuration conf = new Configuration();
    		FileSystem hdfs = FileSystem.get(conf);
    		FileSystem local = FileSystem.getLocal(conf);
    
    		try {
    			visitPath(local,sourceFile);
    			visitPath(hdfs,targetFile);
    		} catch (IOException e) {
    			e.printStackTrace();
    		}
    
    	}
    
    	public static void visitPath(FileSystem fs,String path) throws IOException
    	{
    		Path inputDir = new Path(path);
    		FileStatus[] inputFiles = fs.listStatus(inputDir);
    		if(inputFiles==null)
    		{
    			throw new IOException(" the path is not correct:" + path);
    		}
    
    		System.out.println("----------------path:"+path+"----------------");
    		for (int i = 0; i < inputFiles.length; i++) {
    
    
    
    			if(inputFiles[i].isDir())
    			{
    				System.out.println(inputFiles[i].getPath().getName()+" -dir-");
    				visitPath(fs,inputFiles[i].getPath().toString());
    			}
    			else
    			{
    				System.out.println(inputFiles[i].getPath().getName()+",len:"+inputFiles[i].getLen());
    			}
    
    		}
    
    	}
    
    }
    


输出：

    
    
    ----------------path:/home/zhouhh/test----------------
    HelloWorldApp.class,len:432
    a.scm,len:99
    jar -dir-
    ----------------path:file:/home/zhouhh/test/jar----------------
    Test.jar,len:1040
    name.txt,len:389211
    jdk-6u38-linux-amd64.rpm,len:58727459
    hbase_thrift.tar.gz,len:770987
    src -dir-
    ...
    ----------------path:hdfs://hadoop48:54310/user/zhouhh----------------
    README.txt,len:1399
    a,len:0
    fsimage,len:9358
    gz -dir-
    ----------------path:hdfs://hadoop48:54310/user/zhouhh/gz----------------
    abs.gz,len:309589
    mytest.txt,len:20
    output -dir-
    
