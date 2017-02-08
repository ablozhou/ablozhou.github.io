---
author: abloz
comments: true
date: 2010-08-10 03:30:09+00:00
layout: post
link: http://abloz.com/index.php/2010/08/10/dell-r610-card-problem/
slug: dell-r610-card-problem
title: Dell R610 网卡有问题？
wordpress_id: 362
categories:
- 技术
tags:
- dell
- r610
- 网卡
---

Dell R610 网卡有问题？没有确证，但有些怀疑。操作系统安装的是centos5.2,使用一段时间，recvq就大量堆积，成为僵死状态，不再响应收包。当然，这也可能是程序bug，只是程序在其他硬件设备上没有遇到类似问题。
硬件信息：

    
    
    eth0      Link encap:Ethernet  HWaddr B8:AC:6F:13:4D:DF
              inet addr:x.x.x.x  Bcast:210.211.25.127  Mask:255.255.255.128
    eth1      Link encap:Ethernet  HWaddr B8:AC:6F:13:4D:E1
              inet addr:192.168.12.76  Bcast:192.168.12.255  Mask:255.255.255.0
    
    硬件信息：
    
    eth0: Broadcom NetXtreme II BCM5709 1000Base-T (C0) PCI Express found at mem d6000000, IRQ 24, node addr b8ac6f134ddf
    ACPI: PCI Interrupt 0000:01:00.1[B] -> GSI 48 (level, low) -> IRQ 25
    PCI: Setting latency timer of device 0000:01:00.1 to 64
    eth1: Broadcom NetXtreme II BCM5709 1000Base-T (C0) PCI Express found at mem d8000000, IRQ 25, node addr b8ac6f134de1
    ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 32 (level, low) -> IRQ 26
    PCI: Setting latency timer of device 0000:02:00.0 to 64
    eth2: Broadcom NetXtreme II BCM5709 1000Base-T (C0) PCI Express found at mem da000000, IRQ 26, node addr b8ac6f134de3
    ACPI: PCI Interrupt 0000:02:00.1[B] -> GSI 42 (level, low) -> IRQ 27
    PCI: Setting latency timer of device 0000:02:00.1 to 64
    eth3: Broadcom NetXtreme II BCM5709 1000Base-T (C0) PCI Express found at mem dc000000, IRQ 27, node addr b8ac6f134de5
    


僵死状态：

    
    
    # netstat -anp | grep proxy
    Proto Recv-Q Send-Q Local Address               Foreign Address             State
    udp        0      0 0.0.0.0:30468               0.0.0.0:*                               22530/proxy
    udp        0      0 0.0.0.0:14090               0.0.0.0:*                               22530/proxy
    udp        0      0 0.0.0.0:32152               0.0.0.0:*                               22530/proxy
    udp        0      0 0.0.0.0:17054               0.0.0.0:*                               22530/proxy
    udp        0      0 0.0.0.0:23460               0.0.0.0:*                               22530/proxy
    udp        0      0 0.0.0.0:22438               0.0.0.0:*                               22530/proxy
    udp     3672      0 0.0.0.0:28842               0.0.0.0:*                               22530/proxy
    udp    75276      0 0.0.0.0:25386               0.0.0.0:*                               22530/proxy
    udp        0      0 0.0.0.0:28854               0.0.0.0:*                               22530/proxy
    udp        0      0 0.0.0.0:20282               0.0.0.0:*                               22530/proxy
    udp   108324      0 0.0.0.0:5080                0.0.0.0:*                               22530/proxy
    udp        0      0 0.0.0.0:50001               0.0.0.0:*                               22530/proxy
    udp        0      0 0.0.0.0:19026               0.0.0.0:*                               22530/proxy
    udp        0      0 192.168.12.76:32851         192.168.12.30:9998          ESTABLISHED 22530/proxy
    udp        0      0 0.0.0.0:22996               0.0.0.0:*                               22530/proxy
    udp        0      0 0.0.0.0:31060               0.0.0.0:*                               22530/proxy
    udp        0      0 192.168.12.76:32852         192.168.12.30:9999          ESTABLISHED 22530/proxy
    udp        0      0 192.168.12.76:32853         192.168.12.30:9999          ESTABLISHED 22530/proxy
    udp        0      0 192.168.12.76:32855         192.168.12.30:9999          ESTABLISHED 22530/proxy
    udp        0      0 0.0.0.0:14938               0.0.0.0:*                               22530/proxy
    udp        0      0 0.0.0.0:32864               0.0.0.0:*                               22530/proxy
    udp        0      0 0.0.0.0:33512               0.0.0.0:*                               22530/proxy
    udp        0      0 0.0.0.0:29290               0.0.0.0:*                               22530/proxy
    udp    71604      0 0.0.0.0:10872               0.0.0.0:*                               22530/proxy
    udp        0      0 0.0.0.0:11128               0.0.0.0:*                               22530/proxy
    udp        0      0 0.0.0.0:33656               0.0.0.0:*                               22530/proxy
    udp        0      0 0.0.0.0:29050               0.0.0.0:*                               22530/proxy
    udp        0      0 0.0.0.0:34430               0.0.0.0:*                               22530/proxy
    


5080信令端口recv-q有大量堆积，并且不再响应。
检测：

    
    
    [root@hkpm103 proxymedia]# ethtool -t eth0
    Cannot get driver information: Operation not supported
    
    [root@hkpm103 proxymedia]# ethtool -t eth1
    The test result is PASS
    The test extra info:
    register_test (offline) 0
    memory_test (offline) 0
    loopback_test (offline) 0
    nvram_test (online) 0
    interrupt_test (online) 0
    link_test (online) 0
    
    [root@hkpm103 proxymedia]# ethtool eth0
    Settings for eth0:
    Link detected: yes
    [root@hkpm103 proxymedia]# ethtool eth1
    Settings for eth1:
    Supported ports: [ TP ]
    Supported link modes:   10baseT/Half 10baseT/Full
                            100baseT/Half 100baseT/Full
                            1000baseT/Full
    


同样是Broadcom NetXtreme II BCM5709 1000Base-T 的网卡，怎么相差就这么大呢？

正好有位朋友也遇到类似的网卡问题：[Dell R610的Broadcom NetXtreme II BCM5709网卡down掉问题](http://www.bugx.org/136) http://www.bugx.org/136，还提供了两种解决办法。但我没有尝试。
