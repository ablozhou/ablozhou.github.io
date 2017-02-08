---
author: abloz
comments: true
date: 2008-05-21 09:25:33+00:00
layout: post
link: http://abloz.com/index.php/2008/05/21/regularly-back-up-files-using-python-script/
slug: regularly-back-up-files-using-python-script
title: 用python脚本定期备份文件
wordpress_id: 311
categories:
- 技术
tags:
- python
- 备份
---



    
    
    #!/usr/bin/env python
    # file name : backup.py
    # author: zhouhh
    # blog: http://blog.csdn.net/ablo_zhou
    # Email: ablozhou@gmail.com
    # Date : 2008.5.21
    # back up files and dir to a time format tgz file.
    # you could add this script to crontab
    #
    
    import os
    import time
    
    
    source=['/home/zhouhh/test/','/home/zhouhh/test1/']
    print ' backup files:',source
    
    target_dir='/home/zhouhh/backup/'
    target=target_dir+time.strftime('%Y%m%d%H%M%S')+'.tar.gz'
    
    
    cmd='tar -zcvf %s %s '%(target,' '.join(source))
    
    if os.system(cmd)==0 :
        print 'successfull backup to ',target
    else:
        print 'failed backup'
    
    


可以将这个脚本加入crontab中，定期备份文件。如需要备份到windows，需要先mount windows分区，然后将目标地址修改为mount到的分区目录。
