---
author: abloz
comments: true
date: 2012-09-05 12:10:53+00:00
layout: post
link: http://abloz.com/index.php/2012/09/05/manually-removed-meta-table-error-message/
slug: manually-removed-meta-table-error-message
title: 手工移除.META.表的错误信息
wordpress_id: 1856
categories:
- 技术
tags:
- .META.
- hadoop
- hbase
---

周海汉/文

2012.9.5

从其他HBase数据库中硬导出了HDFS的HBase数据出来，但在新的cluster中hbase hbck -repair后，.META.表中还是有一些垃圾数据，导致region server不停写日志报告region表不存在，HBase创建删除表奇慢。错误日志量一天有几个G。

通过过滤错误日志，可以获得错误的表名。

cat thelog | grep ERROR | sed 's/2012.*=//' | sed 's/, start.*.//' | sort | uniq -d > errtable
过滤错误日志中有表名的行，去掉其他头尾，只剩下表名。并排序去重，还剩下几十个错误的表名。

查询HDFS中存在的表名
hadoop fs -ls /hbase/ | sed 's/hbase///' > tables

comm -12 errtable tables

发现错误表都不存在于HDFS中。

所以编程将.META.表中多余的错误表都清除即可。

人工移除.META.中大量错误表会很辛苦，所以写了个程序。



    
    
    import java.io.IOException;
    import java.util.ArrayList;
    import java.util.List;
    
    import org.apache.hadoop.conf.Configuration;
    import org.apache.hadoop.hbase.HBaseConfiguration;
    import org.apache.hadoop.hbase.HColumnDescriptor;
    import org.apache.hadoop.hbase.HTableDescriptor;
    import org.apache.hadoop.hbase.KeyValue;
    import org.apache.hadoop.hbase.MasterNotRunningException;
    import org.apache.hadoop.hbase.ZooKeeperConnectionException;
    import org.apache.hadoop.hbase.client.Delete;
    import org.apache.hadoop.hbase.client.Get;
    import org.apache.hadoop.hbase.client.HBaseAdmin;
    import org.apache.hadoop.hbase.client.HTable;
    import org.apache.hadoop.hbase.client.HTablePool;
    import org.apache.hadoop.hbase.client.Put;
    import org.apache.hadoop.hbase.client.Result;
    import org.apache.hadoop.hbase.client.ResultScanner;
    import org.apache.hadoop.hbase.client.Scan;
    import org.apache.hadoop.hbase.filter.Filter;
    import org.apache.hadoop.hbase.filter.FilterList;
    import org.apache.hadoop.hbase.filter.PrefixFilter;
    import org.apache.hadoop.hbase.filter.SingleColumnValueFilter;
    import org.apache.hadoop.hbase.filter.CompareFilter.CompareOp;
    import org.apache.hadoop.hbase.util.Bytes;
    /*
    author:zhouhh
    根据前缀清除表相应行
    */
    public class DelTable {
     public static Configuration configuration;
        static {
            configuration = HBaseConfiguration.create();
            }
        public static void main(String[] args) {
            String pres="toplist";
        		ResultScanner rs = queryByPrefix(".META.",pres);
        		if(rs != null)
        		{
        			for (Result r : rs) {
        				String rk = new String(r.getRow());
                        System.out.println("queryed rowkey:" + rk);
                        delRow(".META.",rk);
        			}
        		}
        		else
        		{
        			System.out.println("rk not exist "+pres);
        		}
        	}
        	    public static ResultScanner queryByPrefix(String tableName,String pres) {
    
            try {
                HTablePool pool = new HTablePool(configuration, 1000);
                HTable table = (HTable) pool.getTable(tableName);
                Filter filter = new PrefixFilter(pres.getBytes());
                Scan s = new Scan();
                s.setFilter(filter);
                ResultScanner rs = table.getScanner(s);
                /*for (Result r : rs) {
                    System.out.println("rowkey:" + new String(r.getRow()));
                    for (KeyValue keyValue : r.raw()) {
                        System.out.println(new String(keyValue.getFamily())+":"+new String(keyValue.getQualifier())
                                + "t" + new String(keyValue.getValue()));
    
    
                    }
                } */
                return rs;
            } catch (Exception e) {
                e.printStackTrace();
            }
    
            return null;
    
        }
             public static void delRow(String tablename, String rowkey)  {
            try {
                HTable table = new HTable(configuration, tablename);
                List list = new ArrayList();
                Delete d1 = new Delete(rowkey.getBytes());
                list.add(d1);
    
                table.delete(list);
                System.out.println("deleted "+ rowkey);
    
            } catch (IOException e) {
                e.printStackTrace();
            }
    
        }
    }
    



