---
author: abloz
comments: true
date: 2015-06-04 06:39:23+00:00
layout: post
link: http://abloz.com/index.php/2015/06/04/java-custom-annotations/
slug: java-custom-annotations
title: java的自定义注解
wordpress_id: 2653
categories:
- 技术
tags:
- java
---

周海汉 2015.6.4

java 1.5以后有了自定义注解annotation。注解的作用可以用于方便看源代码，方便编译器理解代码，方便生成文档，方便运行时做一些处理。

写代码测试一下

注解代码：

    
    package notation;
    
    import java.lang.annotation.*;
    @Target({ElementType.METHOD, ElementType.CONSTRUCTOR }) //注解用于方法和构造
    @Retention(RetentionPolicy.RUNTIME ) //注解保留到运行时，即运行时还可以反射得到
    public @interface MyNotation {
    	String value();
    }
    


测试代码

    
    package notation;
    
    public class TestNotation {
    
    	@MyNotation("hello world")
    	public void Test1(String x){
    		System.out.println(x);
    	}
    	@MyNotation(value="a test")
    	public void Test2(String x){
    		System.out.println(x);
    	}
    	public static void main(String[] args) {
    		TestNotation t = new TestNotation();
    		t.Test1("abloz.com");
    		t.Test2("abloz.com 2");
    		
    
    	}
    
    }
    


执行结果，打印：


abloz.com




abloz.com 2
