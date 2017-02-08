---
author: abloz
comments: true
date: 2011-09-07 09:51:23+00:00
layout: post
link: http://abloz.com/index.php/2011/09/07/c-language-the-url-to-the-code-submit-content-to-the-site/
slug: c-language-the-url-to-the-code-submit-content-to-the-site
title: C语言的url转码，提交内容到网站
wordpress_id: 1398
categories:
- 技术
tags:
- c
- urlencode
- utf-8
---

url提交信息为何要转码呢？因为url本身会有很多特殊字符。而提交的参数中如果再有特殊字符的话，url就不能区分哪些是参数内容，哪些是分隔符。尤其是unicode，gb18030，big5等多字节的编码，不知道里面会隐藏什么字节，因此必须全部转码。

好像C语言里面没有现成的转码函数。参考[张老师专栏](http://blog.csdn.net/langeldep/article/details/6264058)，从php的转码中引出两个函数，进行转码。

字符"a"-"z"，"A"-"Z"，"0"-"9"，"."，"-"，"*"，和"_" 都不被编码，维持原值；
空格" "被转换为加号"+"。
其他每个字节都被表示成"%xy"格式的由3个字符组成的字符串，编码为UTF-8。

头文件

    
    int url_decode(char *str, int len);
    char *url_encode(char const *s, int len, int *new_length);




c 文件：

    
    #include <stdlib.h>
    #include <string.h>
    #include <ctype.h>
    #include <sys/types.h>
    
    
    /*
    本文代码为从PHP代码中修改而来，只保留了2个函数。
    
    int url_decode(char *str, int len);
    char *url_encode(char const *s, int len, int *new_length);
    
    
    
    URL编码做了如下操作：
    
    
    字符"a"-"z"，"A"-"Z"，"0"-"9"，"."，"-"，"*"，和"_" 都不被编码，维持原值；
    
    空格" "被转换为加号"+"。
    
    其他每个字节都被表示成"%xy"格式的由3个字符组成的字符串，编码为UTF-8。
    */
    static unsigned char hexchars[] = "0123456789ABCDEF";
    
    static int htoi(char *s)
    {
    	int value;
    	int c;
    
    	c = ((unsigned char *)s)[0];
    	if (isupper(c))
    		c = tolower(c);
    	value = (c >= '0' && c <= '9' ? c - '0' : c - 'a' + 10) * 16;
    
    	c = ((unsigned char *)s)[1];
    	if (isupper(c))
    		c = tolower(c);
    	value += c >= '0' && c <= '9' ? c - '0' : c - 'a' + 10;
    
    	return (value);
    }
    
    
    char *url_encode(char const *s, int len, int *new_length)
    {
    	register unsigned char c;
    	unsigned char *to, *start;
    	unsigned char const *from, *end;
    
    	from = (unsigned char *)s;
    	end  = (unsigned char *)s + len;
    	start = to = (unsigned char *) calloc(1, 3*len+1);
    
    	while (from < end)
    	{
    		c = *from++;
    
    		if (c == ' ')
    		{
    			*to++ = '+';
    		}
    		else if ((c < '0' && c != '-' && c != '.') ||
    			(c < 'A' && c > '9') ||
    			(c > 'Z' && c < 'a' && c != '_') ||
    			(c > 'z'))
    		{
    			to[0] = '%';
    			to[1] = hexchars[c >> 4];
    			to[2] = hexchars[c & 15];
    			to += 3;
    		}
    		else
    		{
    			*to++ = c;
    		}
    	}
    	*to = 0;
    	if (new_length)
    	{
    		*new_length = to - start;
    	}
    	return (char *) start;
    }
    
    
    int url_decode(char *str, int len)
    {
    	char *dest = str;
    	char *data = str;
    
    	while (len--)
    	{
    		if (*data == '+')
    		{
    			*dest = ' ';
    		}
    		else if (*data == '%' && len >= 2 && isxdigit((int) *(data + 1)) && isxdigit((int) *(data + 2)))
    		{
    			*dest = (char) htoi(data + 1);
    			data += 2;
    			len -= 2;
    		}
    		else
    		{
    			*dest = *data;
    		}
    		data++;
    		dest++;
    	}
    	*dest = '/0';
    	return dest - str;
    }




使用方式：

    
    
    #include <wininet.h>
    //定义一个发送函数
    void PostHttpRequest(const char* url, const char* param)
    {
    	HINTERNET hSession = InternetOpen("MobileAgent", INTERNET_OPEN_TYPE_PRECONFIG, NULL, NULL, 0);
    	if ( hSession != NULL )
    	{
    		HINTERNET hConnection = InternetConnect(hSession,
    												url,
    												INTERNET_DEFAULT_HTTP_PORT,
    												NULL,
    												NULL,
    												INTERNET_SERVICE_HTTP,
    												0,
    												NULL);
    		if ( hConnection != NULL )
    		{
    			HINTERNET hRequest = HttpOpenRequest(hConnection,
    												"POST",
    												param,
    												NULL,
    												NULL,
    												(const char**)"*/*\0",
    												0,
    												NULL);
    			if ( hRequest != NULL )
    			{
    				HttpSendRequest(hRequest, NULL, 0, NULL, 0);
    				InternetCloseHandle(hRequest);
    			}
    			InternetCloseHandle(hConnection);
    		}
    		InternetCloseHandle(hSession);
    	}
    }



    
    
    #define URL_ADDFEEDBACK ("http://abloz.com/")
    void sendurl()
    {
        char buf[MAX_PATH];
    	char szUserName[MAX_PATH]={"周海汉 ablozhou abloz.com"};
    	char szContent[MAX_PATH]={"这什么网站啊？尽是些乱码dja;a d;404 &^$ # %$()!~?'、%“”;"};
    	int lenu = strlen(szUserName);
    	int lenc = strlen(szContent);
    
    	sprintf(buf, "test.php?username=%s&content;=%s", url_encode(szUserName,lenu,&lenu),url_encode(szContent,lenc,&lenc));
    
    PostHttpRequest(URL_ADDFEEDBACK,buf);
    }
    



本文在window7 下用vs 2010编译测试通过。

