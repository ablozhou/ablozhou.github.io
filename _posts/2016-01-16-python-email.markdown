---
author: abloz
comments: true
date: 2016-01-16 18:14:24+00:00
layout: post
link: http://abloz.com/index.php/2016/01/17/python-email/
slug: python-email
title: python email
wordpress_id: 2721
categories:
- 技术
tags:
- email
- python
- 中文
- 乱码
- 附件
---

周海汉 2016.1.17

python 发送邮件，可带多附件，并且可以将目录中所有文件作为附件发送。解决中文乱码问题。

整理一下可以作为一个开源库使用。

使用方法：

```
python dkemail.py -a dkemail.py -a myemail.py -s 1234234@163.com -r 5636223@163.com -r 234234@qq.com
```


    
    #!/usr/bin/env python
    #-*- coding:utf-8 -*-
    #author:Andy Zhou
    #date:2016.1.17
    
    """发送邮件程序"""
    
    import os
    import sys
    import smtplib
    # For guessing MIME type based on file name extension
    import mimetypes
    
    from optparse import OptionParser
    
    from email import encoders
    from email.message import Message
    from email.mime.audio import MIMEAudio
    from email.mime.base import MIMEBase
    from email.mime.image import MIMEImage
    from email.mime.multipart import MIMEMultipart
    from email.mime.text import MIMEText
    from email.header import Header
    
    COMMASPACE = ', '
    
    SMTP_SVR = 'smtp.163.com'
    PASSWORD = 'mypassword'
    
    def attach_file(path):
    
        # Guess the content type based on the file's extension.  Encoding
        # will be ignored, although we should check for simple things like
        # gzip'd or compressed files.
        filename = os.path.basename(path)
        ctype, encoding = mimetypes.guess_type(path)
        if ctype is None or encoding is not None:
            # No guess could be made, or the file is encoded (compressed), so
            # use a generic bag-of-bits type.
            ctype = 'application/octet-stream'
        maintype, subtype = ctype.split('/', 1)
        if maintype == 'text' or maintype == 'html':
            fp = open(path)
            # Note: we should handle calculating the charset
            msg = MIMEText(fp.read(), _subtype=subtype, _charset="utf-8")
            fp.close()
        elif maintype == 'image':
            fp = open(path, 'rb')
            msg = MIMEImage(fp.read(), _subtype=subtype)
            fp.close()
        elif maintype == 'audio':
            fp = open(path, 'rb')
            msg = MIMEAudio(fp.read(), _subtype=subtype)
            fp.close()
        else:
            fp = open(path, 'rb')
            msg = MIMEBase(maintype, subtype)
            msg.set_payload(fp.read())
            fp.close()
            # Encode the payload using Base64
            encoders.encode_base64(msg)
        # Set the filename parameter
        msg.add_header('Content-Disposition', 'attachment', filename=filename)
        return msg
    
    def attach_files(files,outer_msg):
        for afile in files:
            if afile[0] != '/':
                afile=os.path.join(os.path.abspath('.'),afile)
            msg = attach_file(afile)
            outer_msg.attach(msg)
        
    def attach_dir(directory,outer_msg):
    
        for filename in os.listdir(directory):
            path = os.path.join(directory, filename)
            if not os.path.isfile(path):
                continue
            msg = attach_file(path)
            outer_msg.attach(msg)
    
    def email_outer(_from, _to, subject ):
    
        # Create the enclosing (outer) message
        outer = MIMEMultipart()
        outer['Subject'] = Header(subject,'utf-8') 
        outer['To'] = _to 
        outer['From'] = _from 
        #outer["Accept-Language"]="zh-CN"
        outer["Accept-Charset"]="ISO-8859-1,utf-8"
        return outer
    
    def email_body(body, outer, _format = 'plain'):
        if isinstance(body,unicode):
            body = str(body)
    
        msg = MIMEText(body,_format,'utf-8')
        outer.attach(msg)
        return outer
    
    def main():
        parser = OptionParser(usage="""\
    Send the contents of a directory as a MIME message.
    
    Usage: %prog [options]
    
    Unless the -o option is given, the email is sent by forwarding to your local
    SMTP server, which then does the normal delivery process.  Your local machine
    must be running an SMTP server.
    """)
        parser.add_option('-a', '--attfile',
                          type='string', action='append', metavar='ATTFILE',
                          default=[], dest='attfiles',
                          help="""Mail the contents of the specified file,
                          if the file name is not  full path, it will from the current directory.""")
        parser.add_option('-d', '--directory',
                          type='string', action='store',
                          help="""Mail the contents of the specified directory,
                          otherwise use the current directory.  Only the regular
                          files in the directory are sent, and we don't recurse to
                          subdirectories.""")
        parser.add_option('-o', '--output',
                          type='string', action='store', metavar='FILE',
                          help="""Print the composed message to FILE instead of
                          sending the message to the SMTP server.""")
        parser.add_option('-s', '--sender',
                          type='string', action='store', metavar='SENDER',
                          help='The value of the From: header (required)')
        parser.add_option('-r', '--recipient',
                          type='string', action='append', metavar='RECIPIENT',
                          default=[], dest='recipients',
                          help='A To: header value (at least one required)')
        opts, args = parser.parse_args()
        if not opts.sender or not opts.recipients:
            parser.print_help()
            sys.exit(1)
        directory = opts.directory
        if not directory:
            directory = '.'
    ##
        main_body="""<h1>这是测试邮件附件程序body.</h1><p>命令:python dkemail.py -a
        dkemail.py -a myemail.py -s myemail@163.com -r rec@163.com -r
        153234@qq.com</p>"""
        subject = "测试邮件标题subject"
        outer = email_outer(opts.sender,COMMASPACE.join(opts.recipients),subject)
        outer = email_body(main_body,outer,"html")
        
        if opts.attfiles:
            attach_files(opts.attfiles,outer)
        if opts.directory:
            attach_dir(directory,outer)
        # Now send or store the message
        composed = outer.as_string()
        if opts.output:
            fp = open(opts.output, 'w')
            fp.write(composed)
            fp.close()
        else:
            s = smtplib.SMTP(SMTP_SVR)
            s.login(opts.sender, PASSWORD)
            s.sendmail(opts.sender, opts.recipients, composed)
            s.quit()
    
    
    if __name__ == '__main__':
        main()
    





