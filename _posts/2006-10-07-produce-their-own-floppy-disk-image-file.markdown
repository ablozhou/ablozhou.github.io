---
author: abloz
comments: true
date: 2006-10-07 09:17:07+00:00
layout: post
link: http://abloz.com/index.php/2006/10/07/produce-their-own-floppy-disk-image-file/
slug: produce-their-own-floppy-disk-image-file
title: 自己制作软盘镜像文件
wordpress_id: 187
categories:
- 技术
tags:
- bochs
- image
- os
- 软盘
---

现在较以往编写操作系统方便的地方就是有许多虚拟机可以应用，因此不必要在硬件上不停重启机器。然而，新机器很多也没有软驱。因此需要用模拟的软驱，即用一个img文件来代替软驱。vmware和bochs都支持模拟软驱。

但是img文件如何生成呢？

1.使用winimage软件。该软件可以生成各种镜像文件。然而不可以直接写二进制，即未格式化的二进制img文件。

2.自己写一个可以拷贝二进制进而生成img文件的代码（在linux AS4上编译调试通过）：

/**************************************************************
文件名 : writeimg.c
说 明 ：将二进制文件写成一个软盘image文件，用于引导

版权所有 2006, 周海汉，保留所有权利
Copyright 2006, ablo zhou. All Right Reserved.

版权声明：
 汉风操作系统(Hanos)，分发遵循汉风操作系统授权协议(Hanos License)。
***************************************************************/

#include  /* unistd.h 需要这个文件 */
#include     /* 包含有read和write函数 */
#include 
#include 
void menu(void)
{
 printf("write binary file to image file or floppyn 
    copy right 2006 zhouhh nn 
    using : n 
    writeimg [-i infile] [-o outfile] n 
    -i : binary input file n 
    -o : output image file n 
    eg:n 
    writeimg -i boot.bin -o boot.imgn 
    writeimg -i boot.bin -o /dev/fd0 n");
}
int main(int argc,char** argv)
{
 char in_file[256]="boot.bin";
 char out_file[256]="BOOT.IMG";
 int i=0;
 char boot_buf[1440*1024]={0};
 int size=0;
    int floppy_desc, file_desc;
 if(argc == 1)
 {
  menu();
  return;
 }
 for(i = 1; i < argc; i+=2)
 {
  if(i+1 > argc)
  {
   menu();
   return;
  }
  if(strcmp(argv[i],"-i")==0)
  {
   strcpy(in_file,argv[i+1]);
  }
  else if(strcmp(argv[i],"-o")==0)
  {
   strcpy(out_file,argv[i+1]);
  }
 }

 file_desc = open(in_file,O_RDONLY);
 if(file_desc <=0)
 {
  printf("error: can't open file %s n",in_file);
  menu();
  return;
 }

 size = lseek(file_desc,0L,SEEK_END);
 lseek(file_desc,0L,SEEK_SET);
 read(file_desc, boot_buf, size);
 close(file_desc);
 boot_buf[510] = 0x55;
 boot_buf[511] = 0xaa;

 floppy_desc = open(out_file,O_RDWR|O_CREAT);
 if(floppy_desc <=0)
 {
  printf("error: can't open file %s n",out_file);
  menu();
  return;
 }
 lseek(floppy_desc, 0, SEEK_CUR);
 write(floppy_desc, boot_buf, 1440*1024);
 close(floppy_desc);
 printf("image file %s create successfully.n",out_file);
}

该程序可以直接拷贝二进制到img文件或者软驱。可以用于制作直接启动盘。
