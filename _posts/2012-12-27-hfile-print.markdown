---
author: abloz
comments: true
date: 2012-12-27 03:52:51+00:00
layout: post
link: http://abloz.com/index.php/2012/12/27/hfile-print/
slug: hfile-print
title: HFile打印
wordpress_id: 2031
categories:
- 技术
---

周海汉
http://abloz.com
2012.12.27
[zhouhh@Hadoop48 ~]$ hbase org.apache.hadoop.hbase.io.hfile.HFile
usage: HFile [-a] [-b] [-e] [-f ] [-k] [-m] [-p] [-r ] [-s] [-v]
 -a,--checkfamily    Enable family check
 -b,--printblocks    Print block index meta data
 -e,--printkey       Print keys
 -f,--file      File to scan. Pass full-path; e.g.
                     hdfs://a:9000/hbase/.META./12/34
 -k,--checkrow       Enable row order check; looks for out-of-order keys
 -m,--printmeta      Print meta data of file
 -p,--printkv        Print key/value pairs
 -r,--region    Region to scan. Pass region name; e.g. '.META.,,1'
 -s,--stats          Print statistics
 -v,--verbose        Verbose output; emits file and meta data delimiters

[zhouhh@Hadoop48 ~]$ hadoop fs -ls /hbase/t1/44f07df0efbda367ca4ebcd41a0f82ca
Found 5 items
drwxr-xr-x   - zhouhh supergroup          0 2012-10-16 14:49 /hbase/t1/44f07df0efbda367ca4ebcd41a0f82ca/.oldlogs
-rw-r--r--   2 zhouhh supergroup        213 2012-10-16 14:49 /hbase/t1/44f07df0efbda367ca4ebcd41a0f82ca/.regioninfo
drwxr-xr-x   - zhouhh supergroup          0 2012-12-25 18:24 /hbase/t1/44f07df0efbda367ca4ebcd41a0f82ca/.tmp
drwxr-xr-x   - zhouhh supergroup          0 2012-12-25 18:24 /hbase/t1/44f07df0efbda367ca4ebcd41a0f82ca/info
drwxr-xr-x   - zhouhh supergroup          0 2012-12-25 15:37 /hbase/t1/44f07df0efbda367ca4ebcd41a0f82ca/recovered.edits
[zhouhh@Hadoop48 ~]$ hadoop fs -ls /hbase/t1/44f07df0efbda367ca4ebcd41a0f82ca/info
Found 1 items
-rw-r--r--   2 zhouhh supergroup       1310 2012-12-25 18:24 /hbase/t1/44f07df0efbda367ca4ebcd41a0f82ca/info/4805f7a6e4924494803a255c3c686bbe

[zhouhh@Hadoop48 ~]$ hbase org.apache.hadoop.hbase.io.hfile.HFile -pf /hbase/t1/44f07df0efbda367ca4ebcd41a0f82ca/info/4805f7a6e4924494803a255c3c686bbe

K: /info:/1350387336446/Put/vlen=0/ts=0 V:
K: /info:/1350387293594/Put/vlen=0/ts=0 V:
K: /info:/1350386219450/Put/vlen=0/ts=0 V:
K: foo/info:foo/1350387336443/Put/vlen=10/ts=0 V: foo-xFCxA1xA1xA1xA1xA1
K: foo/info:foo/1350387293578/Put/vlen=10/ts=0 V: foo-xFCxA1xA1xA1xA1xA1
K: foo/info:foo/1350386219323/Put/vlen=10/ts=0 V: foo-xFCxA1xA1xA1xA1xA1
K: foo-xE7x94x9FxE3x83x93xE3x83xBCxE3x83xAB/info:foo/1350387336448/Put/vlen=16/ts=0 V: foo-xE7x94x9FxE3x83x93xE3x83xBCxE3x83xAB
K: foo-xE7x94x9FxE3x83x93xE3x83xBCxE3x83xAB/info:foo/1350387293597/Put/vlen=16/ts=0 V: foo-xE7x94x9FxE3x83x93xE3x83xBCxE3x83xAB
K: foo-xE7x94x9FxE3x83x93xE3x83xBCxE3x83xAB/info:foo/1350386219478/Put/vlen=16/ts=0 V: foo-xE7x94x9FxE3x83x93xE3x83xBCxE3x83xAB
K: foo-xFCxA1xA1xA1xA1xA1/info:foo/1350387336476/Put/vlen=10/ts=0 V: foo-xFCxA1xA1xA1xA1xA1
K: foo-xFCxA1xA1xA1xA1xA1/info:foo/1350387293599/Put/vlen=10/ts=0 V: foo-xFCxA1xA1xA1xA1xA1
K: foo-xFCxA1xA1xA1xA1xA1/info:foo/1350386219498/Put/vlen=10/ts=0 V: foo-xFCxA1xA1xA1xA1xA1
K: no1/info:name/1350370179806/Put/vlen=6/ts=0 V: zhouhh
K: no2/info:name/1350370213338/Put/vlen=7/ts=0 V: zhouhh2
Scanned kv count -> 14

可以看到key的存储格式：rowkey/columnfamily/timestamp/Put/valuelen/ts/value

hbase(main):001:0> scan 't1'
ROW                                    COLUMN+CELL
                                       column=info:, timestamp=1350387336446, value=
 foo                                   column=info:foo, timestamp=1350387336443, value=foo-xFCxA1xA1xA1xA1xA1
 foo-xE7x94x9FxE3x83x93xE3x83 column=info:foo, timestamp=1350387336448, value=foo-xE7x94x9FxE3x83x93xE3x83xBCxE3x83xAB
 xBCxE3x83xAB
 foo-xFCxA1xA1xA1xA1xA1          column=info:foo, timestamp=1350387336476, value=foo-xFCxA1xA1xA1xA1xA1
 no1                                   column=info:name, timestamp=1350370179806, value=zhouhh
 no2                                   column=info:name, timestamp=1350370213338, value=zhouhh2
6 row(s) in 0.7380 seconds

