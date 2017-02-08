---
author: abloz
comments: true
date: 2008-12-16 09:46:31+00:00
layout: post
link: http://abloz.com/index.php/2008/12/16/python-write-local-search-widget/
slug: python-write-local-search-widget
title: python写的本地搜索小工具
wordpress_id: 318
categories:
- 技术
tags:
- python
---

# 




给一个不太懂电脑但会编辑管理很多文件的老总写的工具程序，查找几天前编辑的文件并导入到一个csv文件中。

其中碰到的困难主要是界面布置和中文支持。但现在算是通过。支持中文windows xp的文件名和路径，其他平台没有测试。

并用py2exe生成了exe文件发布。

工具界面：

![](http://p.blog.csdn.net/images/p_blog_csdn_net/ablo_zhou/EntryImages/20081216/stool.PNG)





    
    
    
    #coding=utf-8
    #small search tool by tkinter
    #test plat form: Windows XP Chinese
    #version 0.5
    #file name: find.py
    #author: zhouhh
    #date: 2008.12.16
    #email:ablozhou gmail.com
    #note:to search files modified a few days ago
    #debug tool: PythonWin
    #python version: 2.5.2
    
    import os;
    import time;
    from Tkinter import *
    
    class capp:
        ''''' 对输入的路径和文件后缀以及编辑的天数进行搜索，并在输入路径下生成一个csv结果文件。'''
        def __init__(self,master):
            ''''' file search tool 0.5 by zhouhaihan@cvtt.cn 周海汉 '''
            frame1 = Frame(master)
            frame1.pack()
            self.quest = Label(frame1,bitmap='questhead')
            self.quest.pack(side=LEFT)
            #self.button = Button(frame,text='Quit',fg='red',command=frame.quit)
            #self.button.pack(side=LEFT)
            self.dirlable=Label(frame1,text=unicode('输入搜索路径: ','gbk'),font=('songti',9))
            self.dirlable.pack(side=LEFT)
            self.entry = Entry(frame1,font=('songti',9),width=65)
            self.entry.pack(side=LEFT)
    
            frame = Frame(master)
            frame.pack()
            self.lblext=Label(frame,text=unicode('      文件后缀名: ','gbk'),font=('songti',9))
            self.lblext.pack(side=LEFT)
    
            self.ext = Entry(frame,width=15)
            self.ext.pack(side=LEFT)
            self.extstr=StringVar()
            self.extstr.set(u'*.xls')
            self.ext['textvariable']=self.extstr
            self.contents = StringVar()
            self.contents.set(u'')
            self.entry['textvariable']=self.contents
            self.daylable=Label(frame,text=unicode('   修改时间（几天前）：','gbk'),font=('songti',9))
            self.daylable.pack(side=LEFT)
            self.days = Entry(frame,width=15)
            self.days.pack(side=LEFT)
            self.daystr=StringVar()
            self.daystr.set('1')
            self.days['textvariable']=self.daystr
            self.hello =  Button(frame,text=unicode('查找','gbk'),font=('songti',12,'bold'),fg='red',bg='white',height=2,width=8,command=self.sayhi)
            self.hello.pack(side=LEFT)
    
            frame3 = Frame(master)
            frame3.pack()
            self.msg = Label(frame3,text=unicode('','gbk'))
            self.msg.pack(side=LEFT)
    
        def sayhi(self):
            print 'begining ... '
            self.msg.config(text='...')
            try:
                mydir = self.contents.get()
                mydays = self.daystr.get()
                myext =self.extstr.get()
                file1 = open(os.path.join(mydir,'result.csv'),'a+')
                searchinfo = 'nsearch '+myext+' in '+mydays+' days. seach time:'+time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))+' n'
                file1.write(searchinfo)
                file1.write('File name, Modify time, Size (bytes), Directoryn')
                self.listfile(mydir,file1,mydays,myext)
                file1.close()
                self.msg.config(text=unicode('搜索成功!','gbk'),font=('songti',9))
            except IOError,(errno,strerror):
                print 'IO error %s: %s' % (errno,strerror)
                self.msg.config(text = 'IO error %s: %s' % (errno,strerror))
            except:
                print "Unexpected error:", sys.exc_info()[0]
                self.msg.config(text='error '+str(sys.exc_info()[0]))
                file1.close()
                raise
    
        def listfile(self,dirname,file1,days,ext):
            ''''' search files ... '''
            if len(ext) >0 :
                ext = os.path.splitext(ext)[1]
            if len(dirname) > 0:
                os.chdir(dirname)
            dirname = os.getcwd()
            print '['+dirname+']:'
            names = os.listdir(dirname)
    
            dirs=[]
            for filename in names:
                fullname = os.path.join(dirname,filename)
                if  os.path.isdir(fullname):
                    dirs.append(fullname)
                    continue
    #
                if len(ext) > 0:
                    if os.path.splitext(filename)[1]!=ext :
                        status = 'ignore '+filename+' for extension'
                        print status
                        self.msg.config(text=unicode(status,'gbk'),font=('songti',9))
                        continue;
    
                t = os.path.getmtime(fullname)
                tnow = time.time()
                #print fullname,' ignore',tnow,t,tnow-t,86400*int(days)
                if len(days) > 0 :
                    if( (tnow -t) > 86400*int(days)):
                        status = 'ignore '+filename+' for date'
                        print status
                        self.msg.config(text=unicode(status,'gbk'),font=('songti',9))
                        continue;
    #
                mt = time.localtime(t)
                size = os.path.getsize(fullname)
    #
                fileinfo = filename+','+time.strftime('%Y-%m-%d %H:%M:%S',mt)+','+str(size)+','+dirname+'n'
                print fileinfo
                file1.write(fileinfo)
    
            for dirname in dirs:
                self.listfile(dirname,file1,days,ext)
    
    if __name__=='__main__':
        #reload(sys)
        #sys.setdefaultencoding('utf8')
        root = Tk()
        root.title(unicode("搜索工具-0.5- 周海汉 2008.12.16",'gbk'))
        app = capp(root)
        root.mainloop()
    
    


py2exe 的setup.py

   1. # setup.py
   2. from distutils.core import setup
   3. import py2exe
   4. setup(console=["find.py"])

执行，在命令行下输入：

   1. python setup.py py2exe
