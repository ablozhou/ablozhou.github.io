---
author: abloz
comments: true
date: 2010-11-30 05:14:48+00:00
layout: post
link: http://abloz.com/index.php/2010/11/30/c-c-main-parameters-of-treatment/
slug: c-c-main-parameters-of-treatment
title: c/c++ main参数处理
wordpress_id: 1090
categories:
- 技术
---

http://abloz.com  
2010.11.30  
  
  

    
    
    #include <getopt.h>
    #include <unistd.h>
    extern char *optarg;
    
    char *usage = 
    "Usage: ./program [-w web_listen_port] [-c com_listen_port]n";
    
    void printusage ()
    {
        printf ("%s", usage);
        exit (-1);
    }
    
    void printproblem(char* problem)
    {
        printf ("%sn", problem);
        printusage();
    }
    #define LISTEN_WEBPORT 4000
    #define LISTEN_COMMPORT 5000
    int main(int argc, char* argv[])
    {
    
        int ret = 0;
        char c;
        short web_port = LISTEN_WEBPORT;
        short com_port = LISTEN_COMMPORT;
    
        while ( (c = getopt(argc,argv,"w:c:")) >= 0)
        {
            switch (c)
            {
            case 'w':
                web_port = atoi(optarg);
                break;
            case 'c':
                com_port = atoi(optarg);
            default:
                printusage();
                break;
            }
        }
    }
    

  
  
  


![](http://img.zemanta.com/pixy.gif?x-id=0e1da859-573d-8868-9235-a5d01684cc50)
