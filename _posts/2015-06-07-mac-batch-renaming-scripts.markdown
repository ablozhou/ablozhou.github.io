---
author: abloz
comments: true
date: 2015-06-07 07:15:20+00:00
layout: post
link: http://abloz.com/index.php/2015/06/07/mac-batch-renaming-scripts/
slug: mac-batch-renaming-scripts
title: mac 批量改名脚本
wordpress_id: 2665
categories:
- 技术
tags:
- awk
- shell
- stat
---

周海汉 2015.6.7

JVC，sony，松下的摄像机，其文件格式是MTS或M2TS文件。摄像机或盘连接到Mac book后，如果直接通过mount的盘去查看，只能看见一个整体的视频文件，而不是根据录制时间切分的。如果用mac自带的照片查看，导入的视频也会失去时间信息，而且全部转为mov格式。用iMovie可以保留时间信息，但其文件名是类似Clip #99.mov这样的格式，文件名本身不带时间信息，不方便放在云盘保存。

所以写了个脚本，将mov文件重命名。 iMovie的视频文件内容放在类似"/Users/zhh/Movies/iMovie 资源库.imovielibrary/15-6-6/Original Media"文件夹下。

先切换到"/Users/zhh/Movies/iMovie 资源库.imovielibrary/15-6-6/"，在下面新建t.sh, 放入下面的内容：

    
    #########################################################################
    # File  : t.sh
    # Author: Andy Zhou
    # Date  : 2015.06.07
    # Desc  :
    # Copyright (c) 2015-~ Andy Zhou
    #########################################################################
    #!/bin/bash
    
    for f in  Original\ Media/*
    do
            stat -t %y%m%d%H%M%S "${f}" | awk '{t=$12; org="\""$16 " " $17" "$18"\""; system("mv "org" "t".mov")};'
            #mv "${f}" "${f}".mov
    done


chmod +x t.sh

执行./t.sh

会将文件复制到其上一级目录，并改名为类似150314110934.mov这样的文件名。然后可以复制到云盘中。
