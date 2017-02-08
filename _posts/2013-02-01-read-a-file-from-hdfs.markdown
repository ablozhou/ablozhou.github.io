---
author: abloz
comments: true
date: 2013-02-01 11:33:33+00:00
layout: post
link: http://abloz.com/index.php/2013/02/01/read-a-file-from-hdfs/
slug: read-a-file-from-hdfs
title: 从HDFS中读取文件
wordpress_id: 2112
categories:
- 技术
tags:
- hadoop
- hdfs
---

周海汉
2013.2.1

本代码可以从本地或hdfs系统中读取文件两次，并在终端打印出来。

    
    
    /**
     * test read file from hdfs
     */
    package my.test;
    
    import java.net.URI;
    
    import org.apache.hadoop.conf.Configuration;
    import org.apache.hadoop.fs.FSDataInputStream;
    import org.apache.hadoop.fs.FileSystem;
    import org.apache.hadoop.fs.Path;
    import org.apache.hadoop.io.IOUtils;
    /**
     * @author zhouhh
     * @date 2013.2.1
     *
     */
    public class TestHdfs {
    
    	public static void main(String[] args) throws Exception {
    		String uri = "";
    		if (args.length < 1)
    		{
    			//uri="test.txt";
    			uri="hdfs://hadoop48:54310/user/zhouhh/test.txt";
    		}
    		else
    		{
    			uri = args[0];
    		}
    		Configuration conf = new Configuration();
    		FileSystem fs = FileSystem.get(URI.create(uri), conf);
    		FSDataInputStream in = null;
    		try {
    			in = fs.open(new Path(uri));
    			IOUtils.copyBytes(in, System.out, 4096, false);
    			in.seek(0); // go back to the start of the file
    			IOUtils.copyBytes(in, System.out, 4096, false);
    		} finally {
    			IOUtils.closeStream(in);
    		}
    	}
    
    }
    
    



参考：tom white《hadoop the difinitive guide 3nd edition》 第三章 hadoop 分布式文件系统
