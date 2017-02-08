---
author: abloz
comments: true
date: 2006-10-10 09:29:53+00:00
layout: post
link: http://abloz.com/index.php/2006/10/10/use-bcdedit-to-change-the-boot-order-in-windows-vista/
slug: use-bcdedit-to-change-the-boot-order-in-windows-vista
title: 使用bcdedit 更改windows vista 的启动顺序
wordpress_id: 192
categories:
- 技术
tags:
- bcedit
- vista
- 启动顺序
---

下了个windows vista试用，等我旅游一趟回来，发现要激活。但我又没有激活码，所以连操作系统都进不去。vista安装后更改了启动顺序，将vista 设为缺省启动。这样我每次启动电脑一不留神就跑vista里面去了，而又不能用。查看XP的boot顺序，根本连vista的选项都没有。这就是说，我无法更改启动顺序，而缺省却总引导到一个我不能用的vista？

查看XP的boot.ini，发现vista加了个注释：

;
;Warning: Boot.ini is used on Windows XP and earlier operating systems.
;Warning: Use BCDEDIT.exe to modify Windows Vista boot options.
;

因此找到装vista的E盘的windows/system32目录，

使用bcdedit.exe来更改启动选项。

该程序是字符界面。选项很多。经过摸索，成功更改了启动顺序，并删除vista的启动选项，手工将vista直接从硬盘中清除。

**1.在cmd模式下，切换到 e:windowssystem32，执行bcdedit /v命令**

    
    
    E:WindowsSystem32>bcdedit /v
    
    Windows Boot Manager
    --------------------
    identifier              {9dea862c-5cdd-4e70-acc1-f32b344d4795}
    device                  partition=C:
    description             Windows Boot Manager
    locale                  en-US
    inherit                 {7ea2e1ac-2e61-4728-aaa3-896d9d0a9f0e}
    default                 {77c363ea-4851-11db-9098-ba68b5106fc5}
    displayorder            {466f5a88-0af2-4f76-9038-095b170dc21c}
                            {77c363ea-4851-11db-9098-ba68b5106fc5}
    toolsdisplayorder       {b2721d73-1db4-4c62-bf78-c548a880142d}
    timeout                 30
    
    Windows Legacy OS Loader
    ------------------------
    identifier              {466f5a88-0af2-4f76-9038-095b170dc21c}
    device                  partition=C:
    path                    ntldr
    description             Earlier Version of Windows
    
    Windows Boot Loader
    -------------------
    identifier              {77c363ea-4851-11db-9098-ba68b5106fc5}
    device                  partition=E:
    path                    Windowssystem32winload.exe
    description             Microsoft Windows Vista
    locale                  en-US
    inherit                 {6efb52bf-1766-41db-a6b3-0ee5eff72bd7}
    osdevice                partition=E:
    systemroot              Windows
    resumeobject            {77c363eb-4851-11db-9098-ba68b5106fc5}
    nx                      OptIn
    


看到了Windows Legacy OS Loader的identifier   为 {466f5a88-0af2-4f76-9038-095b170dc21c}

**2.执行下面的命令，将缺省启动选项改为XP：**

E:WindowsSystem32>bcdedit /default {466f5a88-0af2-4f76-9038-095b170dc21c}
操作成功完成。

查看一下启动选项：

    
    
    E:WindowsSystem32>bcdedit
    
    Windows Boot Manager
    --------------------
    identifier              {bootmgr}
    device                  partition=C:
    description             Windows Boot Manager
    locale                  en-US
    inherit                 {globalsettings}
    default                 {ntldr}
    displayorder            {ntldr}
                            {77c363ea-4851-11db-9098-ba68b5106fc5}
    toolsdisplayorder       {memdiag}
    timeout                 30
    
    Windows Legacy OS Loader
    ------------------------
    identifier              {ntldr}
    device                  partition=C:
    path                    ntldr
    description             Earlier Version of Windows
    
    Windows Boot Loader
    -------------------
    identifier              {77c363ea-4851-11db-9098-ba68b5106fc5}
    device                  partition=E:
    path                    Windowssystem32winload.exe
    description             Microsoft Windows Vista
    locale                  en-US
    inherit                 {bootloadersettings}
    osdevice                partition=E:
    systemroot              Windows
    resumeobject            {77c363eb-4851-11db-9098-ba68b5106fc5}
    nx                      OptIn
    


**3.更改timeout时间**

E:WindowsSystem32>bcdedit /timeout 0
操作成功完成。

**4.将Vista的选项清除**

E:WindowsSystem32>bcdedit /delete {77c363ea-4851-11db-9098-ba68b5106fc5}
操作成功完成。

然后就可以将E盘的Vista直接删除了。最好是格式化。
