---
author: abloz
comments: true
date: 2010-01-29 06:51:00+00:00
layout: post
link: http://abloz.com/index.php/2010/01/29/to-operate-with-a-shell-script-subversion/
slug: to-operate-with-a-shell-script-subversion
title: 用shell 脚本来操作subversion
wordpress_id: 1036
categories:
- 技术
---

#  					 				

				

 					  					  					

[周海汉](http://blog.csdn.net/ablo_zhou) /文

2010.1.29

 

一个svn下有很多svn项目的目录，每个项目目录下有trunk,branches,tags目录。如果直接在项目目录下check out或update，会导致本地文件很大，因为tags,branches都会下载很多副本。而我现在只关心主干。

 

假设我的svn目录在~/svn下面。

新建svnup.sh

 

[view plain](http://blog.csdn.net/ablo_zhou/archive/2010/01/29/5269859.aspx#)[copy to clipboard](http://blog.csdn.net/ablo_zhou/archive/2010/01/29/5269859.aspx#)[print](http://blog.csdn.net/ablo_zhou/archive/2010/01/29/5269859.aspx#)[?](http://blog.csdn.net/ablo_zhou/archive/2010/01/29/5269859.aspx#)

  1. #!/bin/bash
  2. #author:zhouhh
  3. #blog: http://blog.csdn.net/ablo_zhou
  4. cur=`pwd`
  5. echo $cur
  6. for dirname in `ls`;
  7. do
  8. cd "$cur/$dirname/trunk"
  9. echo "$dirname/trunk"
  10. svn up
  11. done
  12. ~

#!/bin/bash #author:zhouhh #blog: http://blog.csdn.net/ablo_zhou cur=`pwd` echo $cur for dirname in `ls`; do cd "$cur/$dirname/trunk" echo "$dirname/trunk" svn up done ~      

chmod +x svnup.sh

./svnup.sh

就可以自动更新每个项目的主干。

 

再将主干导出。

vi svnexport.sh

 

[  
](http://blog.csdn.net/ablo_zhou/archive/2010/01/29/5269859.aspx#)[](http://blog.csdn.net/ablo_zhou/archive/2010/01/29/5269859.aspx#)

  1. #!/bin/bash
  2. cur=`pwd`
  3. echo $cur
  4. for dirname in `ls`;
  5. do
  6. echo "$dirname"
  7. svn export $dirname "/home/zhouhh/svnnew/$dirname"
  8. done

#!/bin/bash cur=`pwd` echo $cur for dirname in `ls`; do echo "$dirname" svn export $dirname "/home/zhouhh/svnnew/$dirname" done  

chmod +x svnexport.sh

./svnexport.sh

  
  


![](http://img.zemanta.com/pixy.gif?x-id=90d1c7d2-4b71-81cd-8070-91e4bad77f83)
