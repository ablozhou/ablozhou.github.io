---
author: abloz
comments: true
date: 2006-08-21 08:05:01+00:00
layout: post
link: http://abloz.com/index.php/2006/08/21/strcmp-function-in-assembly-to-achieve/
slug: strcmp-function-in-assembly-to-achieve
title: 用汇编实现strcmp函数
wordpress_id: 173
categories:
- 技术
---


    // file       : zhh_strcmp.cpp
    // author : zhouhh
    // email : ablozhou@gmail.com
    // date       : 2006.8.21
    // license    : copyleft,you can use this code for free
    // note       : 部分实现参考 linus写的string.h汇编,不过他是用AT&T;语法的汇编,我用的是MASM汇编
    
    int zhh_strcmp(const char *src, const char * dest)
    {
         int result=0;          //定义临时变量用于保存返回结果
         __asm                       //内联汇编开始
         {
                  mov esi,src     //将源字符串放入ds:esi
                  mov edi,dest    //将目标字符串放入es:edi
    START:                           //开始
                  lodsb              //将ds:esi的第一个字节装入寄存器AL，同时[esi]+1
                  scasb           //将es:edi的第一个字节和AL相减，同时[edi]+1
                                     //cmpsb 将edi 和 esi的字节相减
                  jne NOTEQ     //不相等，转到NOTEQ处理
    
                  test al,al         //看看AL是否为NULL
                  jne START       //不为空，则比较下一个
                  xor eax,eax     //为空,将寄存器EAX清空为0
                  jmp ENDCMP      //跳转到返回结果的地方
    NOTEQ:                           //不相等
                  mov eax,1     //不相等时的处理,将EAX置1
                  jl ENDCMP     //如果是大于的话,跳到返回结果的地方
                  neg eax            //将EAX取反,变为-1
    
    ENDCMP:       mov result,eax     //结果存入result
    
         }
    
         return result;              //返回
    
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    


下面是微软自带的strcmp.ASM文件,可以比较一下

    
    
            page    ,132
            title   strcmp.asm - compare two strings
    ;***
    ;strcmp.asm - routine to compare two strings (for equal, less, or greater)
    ;
    ;       Copyright (c) Microsoft Corporation. All rights reserved.
    ;
    ;Purpose:
    ;       STRCMP compares two strings and returns an integer
    ;       to indicate whether the first is less than the second, the two are
    ;       equal, or whether the first is greater than the second, respectively.
    ;       Comparison is done byte by byte on an UNSIGNED basis, which is to
    ;       say that Null (0) is less than any other character (1-255).
    ;
    ;*******************************************************************************
            .xlist
            include cruntime.inc
            .list
    page
    ;***
    ;strcmp - compare two strings, returning less than, equal to, or greater than
    ;
    ;Purpose:
    ;       Compares two string, determining their lexical order.  Unsigned
    ;       comparison is used.
    ;
    ;       Algorithm:
    ;          int strcmp ( src , dst )
    ;                  unsigned char *src;
    ;                  unsigned char *dst;
    ;          {
    ;                  int ret = 0 ;
    ;
    ;                  while( ! (ret = *src - *dst) && *dst)
    ;                          ++src, ++dst;
    ;
    ;                  if ( ret < 0 )
    ;                          ret = -1 ;
    ;                  else if ( ret > 0 )
    ;                          ret = 1 ;
    ;
    ;                  return( ret );
    ;          }
    ;
    ;Entry:
    ;       const char * src - string for left-hand side of comparison
    ;       const char * dst - string for right-hand side of comparison
    ;
    ;Exit:
    ;       AX < 0, 0, or >0, indicating whether the first string is
    ;       Less than, Equal to, or Greater than the second string.
    ;
    ;Uses:
    ;       CX, DX
    ;
    ;Exceptions:
    ;
    ;*******************************************************************************
            CODESEG
            public  strcmp
    strcmp  proc
            .FPO    ( 0, 2, 0, 0, 0, 0 )
            mov     edx,[esp + 4]   ; edx = src
            mov     ecx,[esp + 8]   ; ecx = dst
            test    edx,3
            jnz     short dopartial
            align   4
    dodwords:
            mov     eax,[edx]
            cmp     al,[ecx]
            jne     short donene
            or      al,al
            jz      short doneeq
            cmp     ah,[ecx + 1]
            jne     short donene
            or      ah,ah
            jz      short doneeq
            shr     eax,16
            cmp     al,[ecx + 2]
            jne     short donene
            or      al,al
            jz      short doneeq
            cmp     ah,[ecx + 3]
            jne     short donene
            add     ecx,4
            add     edx,4
            or      ah,ah
            jnz     short dodwords
            align   4
    doneeq:
            xor     eax,eax
            ret
            align   4
    donene:
            ; The instructions below should place -1 in eax if src < dst,
            ; and 1 in eax if src > dst.
            sbb     eax,eax
            sal     eax,1
            add     eax,1
            ret
            align   4
    dopartial:
            test    edx,1
            jz      short doword
            mov     al,[edx]
            add     edx,1
            cmp     al,[ecx]
            jne     short donene
            add     ecx,1
            or      al,al
            jz      short doneeq
            test    edx,2
            jz      short dodwords
    
            align   4
    doword:
            mov     ax,[edx]
            add     edx,2
            cmp     al,[ecx]
            jne     short donene
            or      al,al
            jz      short doneeq
            cmp     ah,[ecx + 1]
            jne     short donene
            or      ah,ah
            jz      short doneeq
            add     ecx,2
            jmp     short dodwords
    strcmp  endp
            end
    
