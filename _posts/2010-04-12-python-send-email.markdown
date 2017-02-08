---
author: abloz
comments: true
date: 2010-04-12 07:34:00+00:00
layout: post
link: http://abloz.com/index.php/2010/04/12/python-send-email/
slug: python-send-email
title: python 发email
wordpress_id: 1203
categories:
- 技术
---

周海汉 /文

2010.4.12

 

  
同事搭了个postfix邮件服务器，用python测试了一下发邮件：

#!/usr/bin/env python  
#coding:utf8  
# Import smtplib for the actual sending function  
import smtplib  
#第一封邮件  
# Import the email modules we'll need  
from email.mime.text import MIMEText  
# Open a plain text file for reading. For this example, assume that  
# the text file contains only ASCII characters.  
textfile='sendmail.py.html'  
fp = open(textfile, 'rb')  
# Create a text/plain message  
msg = MIMEText(fp.read(),'html','utf8') #这是正确显示Html中文的设置，会解析html标签，不再是原始文本。  
msg.set_charset('utf8')#这是正确显示中文的设置  
fp.close()  
me = 'ablozhou@gmail.com'# the sender's email address  
you = 'zhouhaihan@you.cn'# the recipient's email address  
msg['Subject'] = 'The contents of %s,中文标题' % textfile  
msg['From'] = me  
msg['To'] = you  
# Send the message via our own SMTP server, but don't include the  
# envelope header.  
s = smtplib.SMTP('210.211.225.5')  
#s.login()  
s.sendmail(me, [you], msg.as_string())  
s.quit()   


测试发送成功

更多参考：

http://docs.python.org/library/email-examples.html

  
  


![](http://img.zemanta.com/pixy.gif?x-id=384dc96f-e620-86e6-a19c-6f5ec043bb65)
