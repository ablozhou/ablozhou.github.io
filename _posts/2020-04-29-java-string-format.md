---
layout: post
title:  "Java 字符串参数格式化"
author: "周海汉"
date:   2020-04-29 19:48:26 +0800
categories: tech
tags:
    - java
    - format
---

# Java 字符串参数格式化
想设计一个模板, 直接将java的参数用进去。故整理一下java字符串参数格式化方法。

# 格式标志
SPECIFIER | APPLIES TO | OUTPUT
--|--|--
%a | floating point (except BigDecimal) | Hex output of floating point number
%b | Any type | “true” if non-null, “false” if null
%c | character | Unicode character
%d | integer (incl. byte, short, int, long, bigint) | Decimal Integer
%e | floating point | decimal number in scientific notation
%f | floating point | decimal number
%g | floating point | decimal number, possibly in scientific notation depending on the precision and value.
%h | any type | Hex String of value from hashCode() method.
 %n | none | Platform-specific line separator.
%o | integer (incl. byte, short, int, long, bigint) | Octal number
%s | any type | String value
%t | Date/Time (incl. long, Calendar, Date and TemporalAccessor) | %t is the prefix for Date/Time conversions. More formatting flags are needed after this. See Date/Time conversion below.
%x | integer (incl. byte, short, int, long, bigint) | 
Hex string.

# 格式化通用说明

## general, character,  numeric 类型 
``` 
%[argument_index$][flags][width][.precision]conversion
```
## dates and times
```
%[argument_index$][flags][width]conversion
```
## 非参数
```
 %[flags][width]conversion
```
如%n换行

# 举例
## 通用格式化
```
String output = String.format("%s = %d", "zhh", 25);
System.out.printf("My name is: %s%n", "zhh");
```
## 参数索引
用第2个参数,忽略第1个
```
String.format("%2$s", 32, "Hello"); // prints: "Hello"
```
## 字符串格式化
```
String.format("|%s|", "Hello World"); // prints: "Hello World"
String.format("|%30s|", "Hello World");
// |                   Hello World|
String.format("|%-30s|", "Hello World");
// |Hello World                   |
String.format("|%.5s|", "Hello World"); // prints: |Hello|
String.format("|%30.5s|", "Hello World"); // prints: |Hello|

|                         Hello|
```

 ## 货币格式化
```
String.format("|%,d|", 10000000); // prints: |10,000,000|
```
## 整形数字格式化
```
String.format("%d", 93); // prints 93
String.format("|%20d|", 93); // prints: |                  93|
String.format("|%-20d|", 93); // prints: |93                  |
String.format("|%020d|", 93); // prints: |00000000000000000093|
String.format("|%+20d|', 93); // prints: |                 +93|
String.format("|% d|", 93); // prints: | 93| String.format("|% d|", -36); // prints: |-36|
String.format("|%(d|", -36); // prints: |(36)|

// 增加前导0和0x
String.format("|%#o|", 93);
// prints: 0135
String.format("|%#x|", 93);
// prints: 0x5d
String.format("|%#X|", 93);
// prints: 0X5D
```
## 浮点格式化
```
StringBuilder sb = new StringBuilder();
// Send all output to the Appendable object sb
Formatter formatter = new Formatter(sb, Locale.CHINESE);
formatter.format(Locale.CHINESE, "e = |%+10.4f|", Math.E);
System.out.println(formatter.toString());
//e = |   +2.7183|
formatter.format("e = |%,.2f|", -Math.E*10000);
//e = |-27,182.82|
formatter.format("e = |%(,.2f|", -Math.E*10000);
//(可以取代负号,|(27,182.82)|

BigDecimal b = new BigDecimal(Math.PI*Math.pow(10,20));
formatter.format("big pi:|%.4f|",b);
//big pi:|314159265358979334144.0000|
```

## 日期格式化
常用的格式化标志,全集请参考java doc.

FLAG | NOTES
-- | --
%tF|ISO 8601 formatted date with “%tY-%tm-%td“.
%tH|Hour of the day for the 24-hour clock e.g. “00” to “23“.
%tM|Minute within the hour formatted a leading 0 e.g. “00” to “59“.
%tm|Month formatted with a leading 0 e.g. “01” to “12“.
%tT|Time formatted as 24-hours e.g. “%tH:%tM:%tS“.
%tY|Year formatted with 4 digits e.g. “0000” to “9999“.
%tS|Seconds within the minute formatted with 2 digits e.g. “00” to “60”. “60” is required to support leap seconds.
%td|Day of the month formatted with two digits. e.g. “01” to “31“.
%tR|Time formatted as 24-hours e.g. “%tH:%tM“.

```
//月份从0开始,所以需要-1
Calendar c1 = new GregorianCalendar(2020, 4-1, 23);
String s = String.format("那天: %1$tY年%1$tm月%1$te日", c1);
//那天: 2020年03月23日
Calendar c = new GregorianCalendar();
String s = String.format("今天: %1$tY年%1$tm月%1$te日", c);
//今天: 2020年04月29日
s = String.format("今天时间: %1$tY年%1$tm月%1$te日 %1$tH时%1$tM分%1$tS秒", c);
//今天时间: 2020年04月29日 17时31分04秒
```

# 参考
- https://docs.oracle.com/javase/8/docs/api/java/util/Formatter.html
- https://dzone.com/articles/java-string-format-examples
