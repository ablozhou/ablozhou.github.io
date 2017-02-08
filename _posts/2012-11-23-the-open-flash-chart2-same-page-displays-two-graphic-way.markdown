---
author: abloz
comments: true
date: 2012-11-23 09:51:44+00:00
layout: post
link: http://abloz.com/index.php/2012/11/23/the-open-flash-chart2-same-page-displays-two-graphic-way/
slug: the-open-flash-chart2-same-page-displays-two-graphic-way
title: open flash chart2 同一页显示两个图形的方式
wordpress_id: 1982
categories:
- 技术
tags:
- open flash chart
---

周海汉
2012.11.23


## **一、chart2_1.php**


同时显示两个图：

<?php

include 'openflash/php-ofc-library/open-flash-chart.php';

$title = new title( date("D M d Y") );

$bar = new bar();
$bar->set_values( array(9,8,7,6,5,4,3,2,1) );
$bar->set_colour( '#94D700' );

$chart_1 = new open_flash_chart();
$chart_1->set_title( $title );
$chart_1->add_element( $bar );
$data_1 = $chart_1->toPrettyString();
//
// CHART 2
//
// generate some random data
srand((double)microtime()*1000000);

$tmp = array();
for( $i=0; $i<9; $i++ )
$tmp[] = rand(1,10);

$bar_2 = new bar();
$bar_2->set_values( $tmp );

$chart_2 = new open_flash_chart();
$chart_2->set_title( new title( "Chart 2 :-)" ) );
$chart_2->add_element( $bar_2 );
//
//
$data_2 = $chart_2->toPrettyString();
//
?>
<html>
<head>
<script type="text/javascript" src="js/json/json2.js"></script>
<script type="text/javascript" src="js/swfobject.js"></script>
<script type="text/javascript">

var data_1 = <?php echo $data_1;?>

//
// to help debug:
//
// alert(JSON.stringify(data_1));

var data_2 = <?php echo $data_2;?>
/*

don't forget to include the JSON JS library :-) ^^

*/

swfobject.embedSWF(
"open-flash-chart.swf", "div_chart_1",
"300", "300", "9.0.0", "expressInstall.swf",
{"get-data":"get_data_1"} );

swfobject.embedSWF(
"open-flash-chart.swf", "div_chart_2",
"450", "300", "9.0.0", "expressInstall.swf",
{"get-data":"get_data_2"} );
function ofc_ready()
{
alert('ofc_ready');
}
function get_data_1()
{
alert( 'reading data 1' );
return JSON.stringify(data_1);
}

function get_data_2()
{
alert( 'reading data 2' );
alert(JSON.stringify(data_2));
}
</script>
</head>
<body>
<div id="div_chart_1"></div>
<div id="div_chart_2"></div>
</body>
</html>


## 二、chart2_2.php


一次只显示一个图表，点击显示另一个图表，用javascript控制

<?php
//
// This is the MODEL section:
//
include 'openflash/php-ofc-library/open-flash-chart.php';

$title = new title( date("D M d Y") );

$bar = new bar();
$bar->set_values( array(9,8,7,6,5,4,3,2,1) );

$chart_1 = new open_flash_chart();
$chart_1->set_title( $title );
$chart_1->add_element( $bar );
// generate some random data
srand((double)microtime()*1000000);

$tmp = array();
for( $i=0; $i<9; $i++ )
$tmp[] = rand(1,10);

$bar_2 = new bar();
$bar_2->set_values( $tmp );

$chart_2 = new open_flash_chart();
$chart_2->set_title( new title( "Chart 2 :-)" ) );
$chart_2->add_element( $bar_2 );
//
// This is the VIEW section:
//

?>

<html>
<head>

<script type="text/javascript" src="js/json/json2.js"></script>
<script type="text/javascript" src="js/swfobject.js"></script>
<script type="text/javascript">
swfobject.embedSWF("open-flash-chart.swf", "my_chart", "350", "200", "9.0.0");
</script>

<script type="text/javascript">

function ofc_ready()
{
alert('ofc_ready');
}

function open_flash_chart_data()
{
alert( 'reading data' );
return JSON.stringify(data_1);
}

function load_1()
{
tmp = findSWF("my_chart");
x = tmp.load( JSON.stringify(data_1) );
}

function load_2()
{
alert("loading data_2");
tmp = findSWF("my_chart");
x = tmp.load( JSON.stringify(data_2) );
}

function findSWF(movieName) {
if (navigator.appName.indexOf("Microsoft")!= -1) {
return window[movieName];
} else {
return document[movieName];
}
}

var data_1 = <?php echo $chart_1->toPrettyString(); ?>;
var data_2 = <?php echo $chart_2->toPrettyString(); ?>;

</script>
</head>
<body>

<p>Open Flash Chart</p>

<div id="my_chart"></div>
<br>
<a href="javascript:load_1()">display data_1</a> || <a href="javascript:load_2()">display data_2</a>
<p>
Don't forget to 'view source' to see how the Javascript JSON data is loaded.
</p>
</body>
</html>
