---
author: abloz
comments: true
date: 2011-09-26 08:57:14+00:00
layout: post
link: http://abloz.com/index.php/2011/09/26/about-c-exception-handling-and-win32-structured-exception-handling/
slug: about-c-exception-handling-and-win32-structured-exception-handling
title: 关于C++异常处理和win32结构化异常处理
wordpress_id: 1451
categories:
- 技术
tags:
- seh
- try
- vs2003
- vs2010
---

周海汉 abloz.com 2011-09-26



C++中经常会用到try...catch()结构来进行异常处理。但windows平台VS2005之后，缺省的配置，try catch是抓不到硬件异常的，如访问非法内存和除以0。而vs2005之前的try catch能抓住硬件异常，可是因为不能正确处理，还是会导致程序错误。

那么windows平台只使用结构化异常处理呢？全部用__try,__except(). 这样还是不行，因为C++的异常__try又不能抓取。那么二者共用呢？对不起，仍然不行，因为这两种异常处理机制不一样，不能公用。
C++的try catch是会做回绕的，会跟踪对象的创建和释放。而win的是__try是对硬件中断异常的处理，仅适用于windows平台。

二者共存，如下的简单代码，编译会提示错误：error C2712: 无法在要求对象展开的函数中使用 __try

    
    void divbyzero( int j)
    {
    	std::string strTest;         // 错误！结构化异常无法解析C++ 对象
    	__try
    	{
    		int i = 1;
    		i=1/j;
    	}
    	__except(cout<<"exception filter in divbyzero()n",0)
    	{  
    		//0=EXCEPTION_CONTINUE_SEARCH 会传递到外层except，1=EXCEPTION_EXECUTE_HANDLER 终结，-1=EXCEPTION_CONTINUE_EXECUTION在excpt.h定义
    		cout<<"exception error in divbyzero()" <<endl;
    	}
    }


关于异常的处理，windows下的编译器版本不同，处理方式还不一样。vs2005(vc8)以前的编译器如vc6，vc7都缺省能抓获SEH异常。而vs2005以后的，缺省是不抓获seh异常的。
对如下的测试代码：

    
    // testtry.cpp : 定义控制台应用程序的入口点。
    //
    
    #include "stdafx.h"
    #include <exception>
    #include <iostream>
    using namespace std;
    
    void crashmem(void)
    {
    	int *p = NULL;
    
    	try
    	{
    		*p = 1;
    
    		cout<<"process in crashmem()"<<endl;
    	}
    	catch(...)
    	{
    		cout << "catch exception in crashmem()" << endl;
    	}
    
    	cout<<"after catch in crashmem()"<<endl;
    
    }
    void divbyzero( int j)
    {
    	//std::string strTest;         // 错误！结构化异常无法解析C++ 对象
    	__try
    	{
    		int i = 1;
    		i=1/j;
    	}
    	__except(cout<<"exception filter in divbyzero()n",1)
    	{
    		//0=EXCEPTION_CONTINUE_SEARCH 会传递到外层except，1=EXCEPTION_EXECUTE_HANDLER 终结，-1=EXCEPTION_CONTINUE_EXECUTION在excpt.h定义
    		cout<<"exception error in divbyzero()" <<endl;
    	}
    }
    int _tmain(int argc, _TCHAR* argv[])
    {
    	int i = 1;
    	int j = 0;
    
    	try
    	{
    		crashmem();
    		divbyzero(0);
    
    		cout << "main() process" << endl;
    	}
    	catch(...)
    	{
    		cout << "catched exception in main()" << endl;
    	}
    
    	cout << "good in main()" << endl;
    
    	getchar();
    	return 0;
    }


缺省配置，
在VS2003中测试，打印结果：

    
    catch exception in crashmem()
     after catch in crashmem()
     exception filter in divbyzero()
     exception error in divbyzero()
     main() process
     good in main()


而在vs2010中直接崩溃。
但如果在vs2010中设置可以抓取SEH：项目>属性>c/c++>代码生成 启用C++异常，选/EHa,有seh异常。则打印

    
    catch exception in crashmem()
     after catch in crashmem()
     main() process
     good in main()



    
    如果将1改为0 EXCEPTION_CONTINUE_SEARCH
     则vs2003打印：
     catch exception in crashmem()
     after catch in crashmem()
     exception filter in divbyzero()
     catched exception in main()
     good in main()



    
    vs2010打印
     catch exception in crashmem()
     after catch in crashmem()
     main() process
     good in main()
     <strong></strong>


**参考：**

http://blog.csdn.net/kongbu0622/article/details/4233946

http://thunderguy.com/semicolon/2002/08/15/visual-c-exception-handling/
