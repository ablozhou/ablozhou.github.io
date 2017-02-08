---
author: abloz
comments: true
date: 2012-08-07 08:23:01+00:00
layout: post
link: http://abloz.com/index.php/2012/08/07/mapreduce-code-unit-testing/
slug: mapreduce-code-unit-testing
title: 对mapreduce代码进行单元测试
wordpress_id: 1803
categories:
- 技术
tags:
- hadoop
- unitest
---

http://abloz.com

hadoop自带一个wordcount的示例代码，用于计算单词个数。我将其单独移出来，测试成功。源码如下：

    
    package org.apache.hadoop.examples;
    
    import java.io.IOException;
    import java.util.StringTokenizer;
    
    import org.apache.hadoop.conf.Configuration;
    import org.apache.hadoop.fs.Path;
    import org.apache.hadoop.io.IntWritable;
    import org.apache.hadoop.io.Text;
    import org.apache.hadoop.mapreduce.Job;
    import org.apache.hadoop.mapreduce.Mapper;
    import org.apache.hadoop.mapreduce.Reducer;
    import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
    import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
    import org.apache.hadoop.util.GenericOptionsParser;
    
    public class WordCount {
    
      public static class TokenizerMapper
           extends Mapper{
    
        private final static IntWritable one = new IntWritable(1);
        private Text word = new Text();
    
        public void map(Object key, Text value, Context context
                        ) throws IOException, InterruptedException {
          StringTokenizer itr = new StringTokenizer(value.toString());
          while (itr.hasMoreTokens()) {
            word  = new Text(itr.nextToken()); //to unitest,should be new Text word.set(itr.nextToken())
            context.write(word, new IntWritable(1));
          }
        }
      }
    
      public static class IntSumReducer
           extends Reducer {
        private IntWritable result = new IntWritable();
    
        public void reduce(Text key, Iterable values,
                           Context context
                           ) throws IOException, InterruptedException {
          int sum = 0;
          for (IntWritable val : values) {
            sum += val.get();
          }
          result.set(sum);
          context.write(key, result);
        }
      }
    
      public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        String[] otherArgs = new GenericOptionsParser(conf, args).getRemainingArgs();
        if (otherArgs.length != 2) {
          System.err.println("Usage: wordcount  ");
          System.exit(2);
        }
        Job job = new Job(conf, "word count");
        job.setJarByClass(WordCount.class);
        job.setMapperClass(TokenizerMapper.class);
        job.setCombinerClass(IntSumReducer.class);
        job.setReducerClass(IntSumReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);
        FileInputFormat.addInputPath(job, new Path(otherArgs[0]));
        FileOutputFormat.setOutputPath(job, new Path(otherArgs[1]));
        System.exit(job.waitForCompletion(true) ? 0 : 1);
      }
    }


现在我想对其进行单元测试。一种方式，是job执行完了后，读取输出目录中的文件，确认计数是否正确。但这样的情况如果失败，也不知道是哪里失败。我们需要对map和reduce单独进行测试。
tomwhite的书《hadoop权威指南》有提到如何用Mockito进行单元测试，我们依照原书对温度的单元测试来对wordcount进行单元测试。(原书第二版的示例已经过时，可以参考英文版第三版或我的程序)。

    
    package org.apache.hadoop.examples;
    /* author zhouhh
     * date:2012.8.7
     */
    import static org.mockito.Mockito.*;
    import java.io.IOException;
    import java.util.ArrayList;
    import java.util.List;
    
    import org.apache.hadoop.io.*;
    import org.junit.*;
    
    public class WordCountTest {
    
    	@Test
    	public  void testWordCountMap() throws IOException, InterruptedException
    	{
    		WordCount w = new WordCount();
    		WordCount.TokenizerMapper mapper = new WordCount.TokenizerMapper();
    		Text value = new Text("a b c b a a");
    		@SuppressWarnings("unchecked")
    		WordCount.TokenizerMapper.Context context = mock(WordCount.TokenizerMapper.Context.class);
    		mapper.map(null, value, context);
    		verify(context,times(3)).write(new Text("a"), new IntWritable(1));
    		verify(context).write(new Text("c"), new IntWritable(1));
    		//verify(context).write(new Text("cc"), new IntWritable(1));
    
    	}
    
    	@Test
    	public void testWordCountReduce() throws IOException, InterruptedException
    	{
    		WordCount.IntSumReducer reducer = new WordCount.IntSumReducer();
    		WordCount.IntSumReducer.Context context = mock(WordCount.IntSumReducer.Context.class);
    		Text key = new Text("a");
    		List values = new ArrayList();
    		values.add(new IntWritable(1));
    		values.add(new IntWritable(1));
    		reducer.reduce(key, values, context);
    
    		verify(context).write(new Text("a"), new IntWritable(2));
    
    	}
    
    	public static void main(String[] args) {
    //		try {
    //			WordCountTest t = new WordCountTest();
    //
    //			//t.testWordCountMap();
    //			t.testWordCountReduce();
    //		} catch (IOException e) {
    //			// TODO Auto-generated catch block
    //			e.printStackTrace();
    //		} catch (InterruptedException e) {
    //			// TODO Auto-generated catch block
    //			e.printStackTrace();
    //		}
    
    	}
    
    }


verify(context)只检查一次的写，如果多次写，需用verify(contex,times(n))检查,否则会失败。

执行时在测试文件上点run as JUnit Test，会得到测试结果是否通过。
本示例程序在hadoop1.0.3环境中测试通过。Mockito也在hadoop的lib中自带，打包在mockito-all-1.8.5.jar

参考：
http://bobflagg.com/blog/unit-testing-wordcount-mapreduce-example/
http://blog.pfa-labs.com/2010/01/unit-testing-hadoop-wordcount-example.html
