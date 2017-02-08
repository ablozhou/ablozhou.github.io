---
author: abloz
comments: true
date: 2013-02-01 11:41:13+00:00
layout: post
link: http://abloz.com/index.php/2013/02/01/merge-the-files-to-hdfs/
slug: merge-the-files-to-hdfs
title: 将文件合并到HDFS
wordpress_id: 2114
categories:
- 技术
tags:
- hadoop
- hdfs
---

周海汉
2013.2.1

将文件合并到HDFS。从目录中读取所有文件，合并成一个HDFS文件。

    
    
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
     * @date 2013.2.1
     * merge files to hdfs
     */
    public class testh1 {
    	public static void main(String[] args) throws IOException {
    		String sourceFile = "";
    		String targetFile = "";
    		if (args.length < 2) {
    			sourceFile = "/home/zhouhh/test.txt";
    			targetFile = "hdfs://hadoop48:54310/user/zhouhh/test.txt";
    		} else {
    			sourceFile = args[0];
    			targetFile = args[1];
    		}
    		Configuration conf = new Configuration();
    		FileSystem hdfs = FileSystem.get(conf);
    		FileSystem local = FileSystem.getLocal(conf);
    		Path inputDir = new Path(sourceFile);
    		Path hdfsFile = new Path(targetFile);
    
    		try {
    			FileStatus[] inputFiles = local.listStatus(inputDir);
    			FSDataOutputStream out = hdfs.create(hdfsFile);
    			for (int i = 0; i < inputFiles.length; i++) {
    				System.out.println(inputFiles[i].getPath().getName());
    				FSDataInputStream in = local.open(inputFiles[i].getPath());
    				byte buffer[] = new byte[256];
    				int bytesRead = 0;
    				while ((bytesRead = in.read(buffer)) > 0) {
    					out.write(buffer, 0, bytesRead);
    				}
    				in.close();
    			}
    			out.close();
    		} catch (IOException e) {
    			e.printStackTrace();
    		}
    	}
    
    }
    
    



**参考**
《Hadoop in action》第三章 hadoop 组件
