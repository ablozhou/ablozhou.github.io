---
author: abloz
comments: true
date: 2009-12-15 05:58:00+00:00
layout: post
link: http://abloz.com/index.php/2009/12/15/linux-open-a-writable-anonymous-ftp/
slug: linux-open-a-writable-anonymous-ftp
title: linux 开个匿名可写ftp
wordpress_id: 983
categories:
- 技术
---

#  					 				

				

 					  					  					

[周海汉](http://blog.csdn.net/ablo_zhou)  /文  
2009-12-15

  
不可否认，ftp还是最方便的文件共享方式，特别是针对一些客户端连zip解压软件都不安装的人。  
使用ubuntu 9.10 linux做桌面，最方便的就是开个服务什么的。  
恰好有人需要与我共享8G 的文件。开可写的samba也挺麻烦，以前还遇到samba匿名可写感染病毒的事情。于是就开一个ftp服务器吧。  
  
安装：  
sudo apt-get install vsftpd  
  
启动：  
service vsftpd restart  
  
登录  
ftp localhost  
可以登录，但里面是空的。  
  
我现在需要开一个匿名可写的ftp服务器，也不需要过多配置，共享完文件就关了。  
  
参考一下鸟哥的linux私房菜:  
http://linux.vbird.org/linux_server/0410vsftpd.php#server_anon  
确实讲的很到位，很全面。  
不管太多，将其匿名配置部分抄下来。  
mv /etc/vsftpd.conf /etc/vsftpd.conf.bk  
vi /etc/vsftpd.conf# 將這個檔案改成這樣：  


  1. # 1. 與匿名者相關的資訊：
  2. anonymous_enable=YES
  3. # 不必提供密碼啦！可直接登入哩！
  4. no_anon_password=YES
  5. # 限制流速啦！
  6. #anon_max_rate=30000 #ablo 限速就免了，注释
  7. # 與連線時間有關的設定項目
  8. #data_connection_timeout=60 #ablo 文件很大，也不必限制
  9. #idle_session_timeout=600
  10. # 限制連線人數
  11. max_clients=50
  12. max_per_ip=5
  13. anon_root=/var/ftp #ablo 这一句很重要，指定匿名目录的。 ubuntu 9.10 安装完vsftpd并没有生成/var/ftp目录。必须自己创建。否则缺省指向/var/run/vsftpd/empty，都是没有写权限的。
  14. # 2. 與實體用戶相關的資訊，本案例中為關閉他的情況！
  15. local_enable=NO
  16. # 3. 與主機有關的設定
  17. use_localtime=YES
  18. dirmessage_enable=YES
  19. xferlog_enable=YES
  20. connect_from_port_20=YES
  21. xferlog_std_format=YES
  22. pam_service_name=vsftpd
  23. listen=YES # stand alone 模式，独立启动
  24. tcp_wrappers=YES
  25. banner_file=/etc/vsftpd/welcome.txt
  26. # 4.匿名可写
  27. write_enable=YES
  28. anon_other_write_enable=YES
  29. anon_mkdir_write_enable=YES
  30. anon_upload_enable=YES

# 1. 與匿名者相關的資訊： anonymous_enable=YES # 不必提供密碼啦！可直接登入哩！ no_anon_password=YES # 限制流速啦！ #anon_max_rate=30000  #ablo 限速就免了，注释 # 與連線時間有關的設定項目 #data_connection_timeout=60  #ablo 文件很大，也不必限制 #idle_session_timeout=600 # 限制連線人數 max_clients=50 max_per_ip=5 anon_root=/var/ftp   #ablo 这一句很重要，指定匿名目录的。 ubuntu 9.10 安装完vsftpd并没有生成/var/ftp目录。必须自己创建。否则缺省指向/var/run/vsftpd/empty，都是没有写权限的。 # 2. 與實體用戶相關的資訊，本案例中為關閉他的情況！ local_enable=NO # 3. 與主機有關的設定 use_localtime=YES dirmessage_enable=YES xferlog_enable=YES connect_from_port_20=YES xferlog_std_format=YES pam_service_name=vsftpd listen=YES              # stand alone 模式，独立启动 tcp_wrappers=YES banner_file=/etc/vsftpd/welcome.txt # 4.匿名可写 write_enable=YES anon_other_write_enable=YES anon_mkdir_write_enable=YES anon_upload_enable=YES    
  
再新建/etc/vsftpd目录，修改一下/etc/vsftpd/welcome.txt  
  
修改/var/ftp/pub 权限。  
sudo chown ftp:ftp pub  
  
vsftpd缺省会使用ftp作为匿名用户。  
这时候使用  
ftp localhost  
会看到欢迎信息。必须输入anonymous作为用户名。  
  


  1. zhouhh@zhhofs:~$ ftp localhost
  2. Connected to localhost.
  3. 220-欢迎光临zhouhh的ftp！
  4. 220
  5. Name (localhost:zhouhh): anonymous
  6. 230 Login successful.
  7. Remote system type is UNIX.
  8. Using binary mode to transfer files.
  9. ftp> ls
  10. 200 PORT command successful. Consider using PASV.
  11. 150 Here comes the directory listing.
  12. drwxrwxr-x 2 113 122 4096 Dec 15 14:48 pub
  13. 226 Directory send OK.
  14. ftp>

zhouhh@zhhofs:~$ ftp localhost Connected to localhost. 220-欢迎光临zhouhh的ftp！ 220 Name (localhost:zhouhh): anonymous 230 Login successful. Remote system type is UNIX. Using binary mode to transfer files. ftp> ls 200 PORT command successful. Consider using PASV. 150 Here comes the directory listing. drwxrwxr-x    2 113      122          4096 Dec 15 14:48 pub 226 Directory send OK. ftp>    
  
进去后，cd pub  
put localfile.c  
提示成功。  
其中localfile.c是~目录下存在的文件。

  


  
  


![](http://img.zemanta.com/pixy.gif?x-id=1f94202f-02af-8dfb-97b0-a056f12ba41e)
