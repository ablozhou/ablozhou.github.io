---
author: abloz
comments: true
date: 2012-12-20 12:14:42+00:00
layout: post
link: http://abloz.com/index.php/2012/12/20/bloomfilter/
slug: bloomfilter
title: BloomFilter 布隆过滤
wordpress_id: 2017
categories:
- 技术
tags:
- BloomFilter
- hadoop
---

周海汉
2012.12.20 听说世界末日狂欢要到了？

Bloom 1970年发明了布隆过滤器，对大数据尤其有用。

**Bloom过滤原理：**

如果要判断一个数是否在一个集合中，最自然的想法是直接遍历，如果找到，则存在;没有找到，则不存在。如果数据是有序集合，则可以用折半查找。

Hash方法是一种很好的映射方式，方便快速查找。我们可以先用Hash做索引，如果数据Hash后在索引表中存在，则数据可能存在。因为Hash可能存在碰撞的可能。

Bloom过滤是对Hash的进一步优化，采用一组Hash，获得数据不同的位。如果每个位都置1了，则可能存在数据，这是考虑到很少的碰撞情况。如果有一个位没有置1，则该数据必然不存在。由于一个很大的数据在Hash中仅占几个位，所以极大的减少了对磁盘的访问和加快了查找数据速度。

**Bloom过滤步骤：**

假设Bloom数位列表长度n=20，每个数据D，采用k=3个Hash函数，获取到3个不同位置,并将相应的位置置1.

如下图所示HASHSET(D1)={Hash1(D1),Hash2(D1),Hash3(D1)}={2,8,16},则将2，8，16三个位置置1，红色表示。
<table width="700" > 
<tbody >
<tr >

<td width="24" height="19" >1
</td>

<td width="72" height="19" >2
</td>

<td width="72" height="19" >3
</td>

<td width="72" height="19" >4
</td>

<td width="72" height="19" >5
</td>

<td width="72" height="19" >6
</td>

<td width="72" height="19" >7
</td>

<td width="72" height="19" >8
</td>

<td width="72" height="19" >9
</td>

<td width="72" height="19" >10
</td>

<td width="72" height="19" >11
</td>

<td width="72" height="19" >12
</td>

<td width="72" height="19" >13
</td>

<td width="72" height="19" >14
</td>

<td width="72" height="19" >15
</td>

<td width="72" height="19" >16
</td>

<td width="72" height="19" >17
</td>

<td width="72" height="19" >18
</td>

<td width="72" height="19" >19
</td>

<td width="72" height="19" >20
</td>
</tr>
<tr >

<td width="24" height="19" >
</td>

<td width="72" height="19" >1
</td>

<td width="72" height="19" >
</td>

<td width="72" height="19" >
</td>

<td width="72" height="19" >1
</td>

<td width="72" height="19" >
</td>

<td width="72" height="19" >
</td>

<td width="72" height="19" >1
</td>

<td width="72" height="19" >
</td>

<td width="72" height="19" >
</td>

<td width="72" height="19" >
</td>

<td width="72" height="19" >1
</td>

<td width="72" height="19" >
</td>

<td width="72" height="19" >
</td>

<td width="72" height="19" >
</td>

<td width="72" height="19" >1
</td>

<td width="72" height="19" >
</td>

<td width="72" height="19" >
</td>

<td width="72" height="19" >
</td>

<td width="72" height="19" >
</td>
</tr>
</tbody>
</table>
HASHSET(D2)={Hash1(D2),Hash2(D2),Hash3(D2)}={2,5,12},则将2，5，12三个位置置1，黑色表示。注意到2位置D2和D1重复了。没关系，仍然置1，这不妨碍找到D1和D2.

现在如果有D3，HASHSET(D3)={Hash1(D3),Hash2(D3),Hash3(D3)}={2,5,12}，那么我们认为D3是存在的。但也可能因为Hash碰撞原因不存在。所以需要读完磁盘的真实数据才知道。

现在如果有D4，HASHSET(D4)={Hash1(D4),Hash2(D4),Hash3(D4)}={5,12,19}，则该数据D4必然不存在。



**Hadoop有对Bloom Filter的实现**
**代码**
[zhouhh@Hadoop48 hadoop-1.0.4]$ cd ./src/core/org/apache/hadoop/util/bloom/
[zhouhh@Hadoop48 bloom]$ ls
BloomFilter.java DynamicBloomFilter.java HashFunction.java RemoveScheme.java
CountingBloomFilter.java Filter.java Key.java RetouchedBloomFilter.java
[zhouhh@Hadoop48 bloom]$ cat BloomFilter.java

    
    public class BloomFilter extends Filter {
      private static final byte[] bitvalues = new byte[] {
        (byte)0x01,
        (byte)0x02,
        (byte)0x04,
        (byte)0x08,
        (byte)0x10,
        (byte)0x20,
        (byte)0x40,
        (byte)0x80
      };
    
      /** The bit vector. */
      BitSet bits;
    
      /** Default constructor - use with readFields */
      public BloomFilter() {
        super();
      }
    
      /**
       * Constructor
       * @param vectorSize The vector size of <em>this</em> filter.数组大小
       * @param nbHash The number of hash function to consider.多少个Hash函数
       * @param hashType type of the hashing function 什么hash函数(see
       * {@link org.apache.hadoop.util.hash.Hash}).
       */
      public BloomFilter(int vectorSize, int nbHash, int hashType) {
        super(vectorSize, nbHash, hashType);
    
        bits = new BitSet(this.vectorSize);
      }
    
      @Override
      public void add(Key key) { //将key 添加到Bloom位数组
        if(key == null) {
          throw new NullPointerException("key cannot be null");
        }
    
        int[] h = hash.hash(key); //这返回一组位置
        hash.clear();
    
        for(int i = 0; i < nbHash; i++) {
          bits.set(h[i]);
        }
      }
    
      @Override
      public void and(Filter filter) {
        if(filter == null
            || !(filter instanceof BloomFilter)
            || filter.vectorSize != this.vectorSize
            || filter.nbHash != this.nbHash) {
          throw new IllegalArgumentException("filters cannot be and-ed");
        }
    
        this.bits.and(((BloomFilter) filter).bits);
      }
    
      @Override
      public boolean membershipTest(Key key) { //检查是否在集合内
        if(key == null) {
          throw new NullPointerException("key cannot be null");
        }
    
        int[] h = hash.hash(key);
        hash.clear();
        for(int i = 0; i < nbHash; i++) {
          if(!bits.get(h[i])) { //比较每个Hash位置，如果有一个不同，则返回失败
            return false;
          }
        }
        return true; //返回真，但可能会有碰撞误报
      }
    
      @Override
      public void not() {
        bits.flip(0, vectorSize - 1);
      }
    
      @Override
      public void or(Filter filter) {
        if(filter == null
            || !(filter instanceof BloomFilter)
            || filter.vectorSize != this.vectorSize
            || filter.nbHash != this.nbHash) {
          throw new IllegalArgumentException("filters cannot be or-ed");
        }
        bits.or(((BloomFilter) filter).bits);
      }
    
      @Override
      public void xor(Filter filter) {
        if(filter == null
            || !(filter instanceof BloomFilter)
            || filter.vectorSize != this.vectorSize
            || filter.nbHash != this.nbHash) {
          throw new IllegalArgumentException("filters cannot be xor-ed");
        }
        bits.xor(((BloomFilter) filter).bits);
      }
    
      @Override
      public String toString() {
        return bits.toString();
      }
    
      /**
       * @return size of the the bloomfilter
       */
      public int getVectorSize() {
        return this.vectorSize;
      }
    
      // Writable
    
      @Override
      public void write(DataOutput out) throws IOException {
        super.write(out);
        byte[] bytes = new byte[getNBytes()];
        for(int i = 0, byteIndex = 0, bitIndex = 0; i < vectorSize; i++, bitIndex++) {
          if (bitIndex == 8) {
            bitIndex = 0;
            byteIndex++;
          }
          if (bitIndex == 0) {
            bytes[byteIndex] = 0;
          }
          if (bits.get(i)) {
            bytes[byteIndex] |= bitvalues[bitIndex];
          }
        }
        out.write(bytes);
      }
    
      @Override
      public void readFields(DataInput in) throws IOException {
        super.readFields(in);
        bits = new BitSet(this.vectorSize); //位集合
        byte[] bytes = new byte[getNBytes()];
        in.readFully(bytes);
        for(int i = 0, byteIndex = 0, bitIndex = 0; i < vectorSize; i++, bitIndex++) {
          if (bitIndex == 8) {
            bitIndex = 0;
            byteIndex++;
          }
          if ((bytes[byteIndex] & bitvalues[bitIndex]) != 0) {
            bits.set(i);
          }
        }
      }
    
      /* @return number of bytes needed to hold bit vector */
      private int getNBytes() {
        return (vectorSize + 7) / 8;
      }
    }//end class


[zhouhh@Hadoop48 bloom]$ cat HashFunction.java
这是Hash函数

    
    package org.apache.hadoop.util.bloom;
    
    import org.apache.hadoop.util.hash.Hash;
    
    /**
     * Implements a hash object that returns a certain number of hashed values.
     *
     * @see Key The general behavior of a key being stored in a filter
     * @see Filter The general behavior of a filter
     */
    public final class HashFunction {
      /** The number of hashed values. */
      private int nbHash;
    
      /** The maximum highest returned value. */
      private int maxValue;
    
      /** Hashing algorithm to use. */
      private Hash hashFunction;
    
      /**
       * Constructor.
       *
    * /
    public HashFunction(int maxValue, int nbHash, int hashType) {
        if (maxValue  0");
        }
    
        if (nbHash  0");
        }
    
        this.maxValue = maxValue;
        this.nbHash = nbHash;
        this.hashFunction = Hash.getInstance(hashType);
        if (this.hashFunction == null)
          throw new IllegalArgumentException("hashType must be known");
      }
    
      /** Clears thishash function. A NOOP */
      public void clear() {
      }
    
      /**
       * Hashes a specified key into several integers.
       * @param k The specified key.
       * @return The array of hashed values.
       */
      public int[] hash(Key k){
          byte[] b = k.getBytes();
          if (b == null) {
            throw new NullPointerException("buffer reference is null");
          }
          if (b.length == 0) {
            throw new IllegalArgumentException("key length must be > 0");
          }
          int[] result = new int[nbHash];
          for (int i = 0, initval = 0; i < nbHash; i++) {
              initval = hashFunction.hash(b, initval);//每个Hash函数是用初始值来区分的。初始值又作为下次输入。
              result[i] = Math.abs(initval % maxValue);//对数组长度，求余，以免溢出
          }
          return result;
      }
    }


**参考：**
[http://www.cnblogs.com/yuyijq/archive/2012/02/08/2343374.html](http://www.cnblogs.com/yuyijq/archive/2012/02/08/2343374.html)
[http://en.wikipedia.org/wiki/Bloom_filter](http://en.wikipedia.org/wiki/Bloom_filter)
[Hbase 官方文档最新中文版http://abloz.com/hbase/book.html#perf.reading](http://abloz.com/hbase/book.html#perf.reading)
