---
author: abloz
comments: true
date: 2013-01-10 07:22:36+00:00
layout: post
link: http://abloz.com/index.php/2013/01/10/the-hbase-0-94-3-hregion-name/
slug: the-hbase-0-94-3-hregion-name
title: HBase 0.94.3的HRegion名字
wordpress_id: 2072
categories:
- 技术
tags:
- hbase
- HRegion
---

周海汉

2013.1.10

HBase 可以通过Region server的60030端口看到各区域的信息。
<table >
<tbody >
<tr >
Region Name
Start Key
End Key
Metrics
</tr>
<tr >

<td >-ROOT-,,0.70236052
</td>

<td >
</td>

<td >
</td>

<td >numberOfStores=1, numberOfStorefiles=1, storefileUncompressedSizeMB=0, storefileSizeMB=0, memstoreSizeMB=0, storefileIndexSizeMB=0, readRequestsCount=456675, writeRequestsCount=1, rootIndexSizeKB=0, totalStaticIndexSizeKB=0, totalStaticBloomSizeKB=0, totalCompactingKVs=10, currentCompactedKVs=10, compactionProgressPct=1.0, coprocessors=[]
</td>
</tr>
<tr >

<td >award_1209,2012-09-01 18:29:11:106558138,1356603311407.ece53b830498cf7e0462332056b436f9.
</td>

<td >2012-09-01 18:29:11:106558138
</td>

<td >2012-09-01 20:13:38:162325277
</td>

<td >numberOfStores=1, numberOfStorefiles=1, storefileUncompressedSizeMB=133, storefileSizeMB=133, compressionRatio=1.0000, memstoreSizeMB=0, storefileIndexSizeMB=0, readRequestsCount=188270, writeRequestsCount=0, rootIndexSizeKB=0, totalStaticIndexSizeKB=140, totalStaticBloomSizeKB=0, totalCompactingKVs=4515962, currentCompactedKVs=1998451, compactionProgressPct=0.0, coprocessors=[]
</td>
</tr>
</tbody>
</table>
新版的区域名字包含了尾巴上的encodeName，即用JenkinsHash计算后生成整形值转成的10进制字符串，32位。其组成为“表名,起始行键,regionid.encodeName.”。ROOT表和第一个META表，及老版HRegion(0.20以前)，使用老的区域名。

源码如下：

HRegionInfo.java (srcmainjavaorgapachehadoophbase) 25868 2012/11/15

    
    /**
       * Make a region name of passed parameters.
       * @param tableName
       * @param startKey Can be null
       * @param id Region id (Usually timestamp from when region was created).
       * @param newFormat should we create the region name in the new format
       *                  (such that it contains its encoded name?).
       * @return Region name made of passed tableName, startKey and id
       */
      public static byte [] createRegionName(final byte [] tableName,
          final byte [] startKey, final byte [] id, boolean newFormat) {
        byte [] b = new byte [tableName.length + 2 + id.length +
           (startKey == null? 0: startKey.length) +
           (newFormat ? (MD5_HEX_LENGTH + 2) : 0)];
    
        int offset = tableName.length;
        System.arraycopy(tableName, 0, b, 0, offset);
        b[offset++] = DELIMITER;
        if (startKey != null && startKey.length > 0) {
          System.arraycopy(startKey, 0, b, offset, startKey.length);
          offset += startKey.length;
        }
        b[offset++] = DELIMITER;
        System.arraycopy(id, 0, b, offset, id.length);
        offset += id.length;
    //新版增加一个Hash值
        if (newFormat) {
          //
          // Encoded name should be built into the region name.
          //
          // Use the region name thus far (namely, ,,)
          // to compute a MD5 hash to be used as the encoded name, and append
          // it to the byte buffer.
          //
          String md5Hash = MD5Hash.getMD5AsHex(b, 0, offset);
          byte [] md5HashBytes = Bytes.toBytes(md5Hash);
    
          if (md5HashBytes.length != MD5_HEX_LENGTH) {
            LOG.error("MD5-hash length mismatch: Expected=" + MD5_HEX_LENGTH +
                      "; Got=" + md5HashBytes.length);
          }
    
          // now append the bytes '..' to the end
          b[offset++] = ENC_SEPARATOR;
          System.arraycopy(md5HashBytes, 0, b, offset, MD5_HEX_LENGTH);
          offset += MD5_HEX_LENGTH;
          b[offset++] = ENC_SEPARATOR;
        }



