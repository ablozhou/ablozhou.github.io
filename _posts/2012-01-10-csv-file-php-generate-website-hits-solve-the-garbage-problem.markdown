---
author: abloz
comments: true
date: 2012-01-10 07:49:27+00:00
layout: post
link: http://abloz.com/index.php/2012/01/10/csv-file-php-generate-website-hits-solve-the-garbage-problem/
slug: csv-file-php-generate-website-hits-solve-the-garbage-problem
title: php 网站点击生成csv文件，解决乱码问题
wordpress_id: 1484
categories:
- 技术
tags:
- csv
- php
- 中文
- 乱码
---

abloz.com

周海汉 2012.1.10

先上一首诗：

锄禾日当午，春运订票苦 。
95105，一拨一上午。
拨了一上午，车票还没谱。
过年回不回，心里很痛苦。
为何会这样，只能问政府。          
  作者：白交易

庆贺多路出击终于买到了2012春运火车票，虽然是硬坐票，多年未挤火车了，这次要甩开膀子干了：)

php点击，从数据库生成csv格式的文件供下载，有两个问题：

1.中文文件名，在不同的浏览器下可能出现乱码

2.内容的乱码问题

重要建议，对部署在linux上，采用utf8编码的数据库和php文件，直接将内容转为gbk，可以用mb_convert_encoding或者iconv，这样省很多麻烦。不要转为utf16le格式的csv，否则还是容易遇到问题。utf8格式的csv有吗？没有。所以在windows上的csv格式，只有用gbk内容最简单。

有一个fputcsv函数，可以将array转成以逗号分隔的内容。header()函数可以让浏览器生成可以下载的csv文件。

    
    <span style="font-family: Courier New;">    function query_to_csv($query, $filename="", $attachment = true, $headers = true)
        {
         if( empty( $filename ) )
      {
       $filename = "abloz_com_".date("Ymd").".csv";
      }
         header('Cache-control: private');
           
       
            if($attachment) {
                // send response headers to the browser
          //判断浏览器，输出双字节文件名不乱码
          $encoded_filename  = urlencode($filename);
             $encoded_filename  = str_replace("+","%20",$encoded_filename );
             
                $fp = fopen('php://output', 'w');
             $ua = $_SERVER["HTTP_USER_AGENT"];
          if (preg_match("/MSIE/", $ua)) {
              header('Content-Disposition: attachment; filename="' . $encoded_filename . '"');
          }
          else if (preg_match("/Firefox/", $ua)) {
              header('Content-Disposition: attachment; filename*="utf8''' . $filename . '"');
          }
          else {
              header('Content-Disposition: attachment; filename="' . $filename . '"');
          }
          //if(function_exists('mb_convert_encoding')){
              //header('Content-type: text/csv; charset=UTF-16LE');
             header( 'Content-Type: text/csv' );
    <span style="font-family: Courier New;">  } else {
                $fp = fopen($filename, 'w');
            }
            $result = mysql_query($query, $this->conn) or die( mysql_error( $this->conn ) );
           
            if($headers) {
                // output header row (if at least one row exists)
                $row = mysql_fetch_assoc($result);
                if($row) {
                 $row = array_map("utf8togbk",array_keys($row));
                    fputcsv($fp,$row );//,mb_convert_encoding(',',"UTF-16LE","UTF-8")
                    // reset pointer back to beginning
                    mysql_data_seek($result, 0);
                }
            }
           
            while($row = mysql_fetch_assoc($result)) {
             $row = array_map("utf8togbk",$row);
             
                fputcsv($fp, $row);//,mb_convert_encoding(',',"UTF-16LE","UTF-8")
            }
           
            fclose($fp);
        }
    <span style="font-family: Courier New;">function utf8togbk($elem)
    {
     return mb_convert_encoding($elem,"GBK","UTF-8");//"auto" = "ASCII,JIS,UTF-8,EUC-JP,SJIS".
    }</span></span></span>


如果转为utf16-le格式，还要写bom，而且就算内容转成功，fputcsv函数生成的分隔符“,”还是ansi的，打开还是乱码。除非自己写一个直接生成csv格式的函数。

为了防止麻烦，就用utf8格式了。

对于下载时文件名乱码问题，根据浏览器，提供不同的header，进行解决：

    
    <span style="font-family: Courier New;">      //判断浏览器，输出双字节文件名不乱码
          $encoded_filename  = urlencode($filename);
             $encoded_filename  = str_replace("+","%20",$encoded_filename );
             
                $fp = fopen('php://output', 'w');
             $ua = $_SERVER["HTTP_USER_AGENT"];
          if (preg_match("/MSIE/", $ua)) {
              header('Content-Disposition: attachment; filename="' . $encoded_filename . '"');
          }
          else if (preg_match("/Firefox/", $ua)) {
              header('Content-Disposition: attachment; filename*="utf8''' . $filename . '"');
          }
          else {
              header('Content-Disposition: attachment; filename="' . $filename . '"');
          }
    </span>


对ie和firefox进行特殊处理。

query_to_csv是一个db类的成员函数，所以connection直接用了成员变量。如果是独立函数，可以将conn做成全局或参数传入。

用法：

    
    <span style="font-family: Courier New;">    require_once 'mydb_code.php';
        $db = new mydb();</span>



    
    <span style="font-family: Courier New;">    $sql = "SELECT * FROM users";
        </span><span style="font-family: Courier New;">// output as a csv attachment
        $db->query_to_csv($sql, "周海汉.csv");</span>



