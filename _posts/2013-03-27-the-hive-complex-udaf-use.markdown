---
author: abloz
comments: true
date: 2013-03-27 10:51:58+00:00
layout: post
link: http://abloz.com/index.php/2013/03/27/the-hive-complex-udaf-use/
slug: the-hive-complex-udaf-use
title: hive 复杂 UDAF 使用方法
wordpress_id: 2166
categories:
- 技术
tags:
- hadoop
- hive
- udaf
---

周海汉 /文
2013.3.27

前文《[hive mapreduce script用法示例](http://abloz.com/2013/03/27/hive-mapreduce-script-usage-examples.html)》
示例了mapreduce脚本。本文采用较复杂的方式自定义hive聚合函数。


    
    
    package com.abloz.hive;
    /**
     * @author zhouhh
     * @date 2013-3-27
     * note: for count value >=1
     */
    import org.apache.hadoop.hive.ql.exec.UDAF;
    import org.apache.hadoop.hive.ql.exec.UDAFEvaluator;
    import org.apache.hadoop.io.IntWritable;
    import org.apache.hadoop.io.Text;
    import org.apache.log4j.Logger;
    
    
    
    public class JJPokerStat extends UDAF {
    	public static class JJCountUDAFEvaluator implements UDAFEvaluator {
    		public static final Logger log = Logger.getLogger(JJPokerStat.class);
    		public static class PartialResult {
    			int total=0;
    			int win=0;
    			int fold=0;
    			int allin=0;
    		}
    		private PartialResult result;
    
    		public void init() {
    			result = new PartialResult();
    		}
    
    		public boolean calwin(int rbet,String chipwon)
    		{
    			if(chipwon.equalsIgnoreCase("NULL"))
    			{
    				return false;
    			}
    
    			String[] cw = chipwon.split("\|");
    			int chipwons=0;
    			//log.info("calwin:"+chipwon);
    			for(String v:cw)
    			{
    
    				String[] c = v.split(":");
    				//log.info("calwin:v "+v+",c.length:"+c.length);
    				if(c.length>1)
    				{
    					chipwons += Integer.parseInt(c[1]);
    				}
    			}
    			//log.info("calwin:chipwons:"+chipwons+",rbet:"+rbet);
    			if(chipwons>rbet)
    			{
    				return true;
    			}
    			return false;
    		}
    
    
    		public boolean iterate(IntWritable rbet,Text chipwon,IntWritable f,IntWritable a) {
    			if ( rbet == null || chipwon == null || f == null || a == null) {
    				return true;
    			}
    			boolean win = calwin(rbet.get(),chipwon.toString());
    
    			if(result == null)
    			{
    				result = new PartialResult();
    			}
    
    			result.total++;
    
    			if(win)
    			{
    				result.win++;
    			}
    
    
    			int v = f.get();
    			if (v>=1)
    			{
    				result.fold++;
    			}
    			v = a.get();
    			if (v>=1)
    			{
    				result.allin++;
    			}
    
    
    			return true;
    		}
    
    		public PartialResult terminatePartial() {
    			return result;
    		}
    
    		public boolean merge(PartialResult other) {
    			if(other == null)
    			{
    				return true;
    			}
    			result.total+=other.total;
    			result.win += other.win;
    			result.fold += other.fold;
    			result.allin += other.allin;
    
    
    			return true;
    		}
    
    		public Text terminate() {
    			if(result == null) {
    				return new Text("0t0t0t0");
    			}
    
    			String s=""+result.total+"t"+result.win+"t"+result.fold+"t"+result.allin;
    			return new Text(s);
    		}
    	}
    }
    



