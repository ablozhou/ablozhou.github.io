---
author: abloz
comments: true
date: 2008-12-29 09:59:05+00:00
layout: post
link: http://abloz.com/index.php/2008/12/29/python-write-local-search-widget-0-9/
slug: python-write-local-search-widget-0-9
title: python写的本地搜索小工具0.9
wordpress_id: 321
categories:
- 技术
tags:
- python
---

采用了tkinter的界面库，用于搜索设定时间编写的文件，将文件信息统计进csv文件。

    
    
    #coding=utf-8
    #small search tool by tkinter
    #test plat form: Windows XP Chinese
    #version 0.9
    #author: zhouhh
    #file name:find.py
    #date: 2008.12.16
    #email:ablozhou gmail.com
    #note:to search files modified a few days ago
    #debug tool: PythonWin
    #python version: 2.5.2
    #py2exe:
    #create a setup.py:
    ###########################
    #setup.py
    #from distutils.core import setup
    #import py2exe
    #setup(console=["find.py"])
    #
    ##########################
    #runing cmd: python setup.py py2exe
    import os;
    import time;
    from Tkinter import *
    #
    class capp:
        ''''' 对输入的路径和文件后缀以及编辑的天数进行搜索，并在输入路径下生成一个csv结果文件。'''
        def __init__(self,master):
            ''''' file search tool 0.9 by zhouhaihan@cvtt.cn 周海汉 '''
            frame1 = Frame(master)
            frame1.pack(padx=5)
            self.quest = Label(frame1,bitmap='questhead')
            self.quest.pack(side=LEFT)
            self.dirlable=Label(frame1,text=unicode('输入搜索路径: ','utf8'),font=('songti',9))
            self.dirlable.pack(side=LEFT)
            self.entry = Entry(frame1,font=('songti',9),width=65)
            self.entry.pack(side=LEFT)
    #
            frame = Frame(master)
            frame.pack(pady=5)
            self.lblext=Label(frame,text=unicode('      文件后缀名: ','utf8'),font=('songti',9))
            self.lblext.pack(side=LEFT)
    
            self.ext = Entry(frame,width=15)
            self.ext.pack(side=LEFT,padx=5)
            self.extstr=StringVar()
            self.extstr.set(u'*.xls')
            self.ext['textvariable']=self.extstr
            self.contents = StringVar()
            self.contents.set(u'')
            self.entry['textvariable']=self.contents
            self.daylable=Label(frame,text=unicode('   修改时间（几天前）：','utf8'),font=('songti',9))
            self.daylable.pack(side=LEFT)
            self.days = Entry(frame,width=20)
            self.days.pack(side=LEFT,padx=5)
            self.daystr=StringVar()
            self.daystr.set('1')
            self.days['textvariable']=self.daystr
    
            frame2 = Frame(master)
            frame2.pack(pady=5)
            self.resultlabel = Label(frame2,text=unicode('结果保存路径','utf8'),font=('songti',9))
            self.resultlabel.pack(side=LEFT,padx=8)
            self.resultfilestr = StringVar()
            self.resultfile = Entry(frame2,font=('songti',9),width=40)
            self.resultfile.pack(side=LEFT)
            self.resultfile['textvariable']=self.resultfilestr
            self.resultfilestr.set(u'')
            self.hello =  Button(frame2,text=unicode('查找','utf8'),font=('songti',12,'bold'),fg='red',height=1,width=8,command=self.sayhi)
            self.hello.bind('<enter>',self.rolloverEnter)
            self.hello.bind('<leave>',self.rolloverLeave)
            self.hello.pack(side=LEFT,padx=5)
           self.button = Button(frame2,text=unicode('退出','utf8'),font=('songti',12),height=1,command=master.quit)
           self.button.bind('<enter>',self.rolloverEnter)
           self.button.bind('<leave>',self.rolloverLeave)
           self.button.pack(side=LEFT,padx=5)
    #
            frame3 = Frame(master)
            frame3.pack(pady=5)
            self.msg = Label(frame3,text=unicode('','utf8'))
            self.msg.pack(side=LEFT)
    
        def sayhi(self):
            print 'begining ... '
            self.msg.config(text='...')
            try:
                mydir = self.contents.get()
                if len(mydir) <= 0:
                    mydir = os.getcwd()
                    self.contents.set(unicode(mydir,'utf8'))
    #
                os.chdir(mydir)
                resultdir = self.resultfilestr.get()
                if len(resultdir) <=0:
                    resultdir = mydir
                    self.resultfilestr.set(resultdir)
                mydays = self.daystr.get()
                myext =self.extstr.get()
                file1 = open(os.path.join(resultdir,'result.csv'),'a+')
                searchinfo = 'nsearch '+myext+' in '+mydays+' days. Time:'+time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))+' n'
                file1.write(searchinfo)
                file1.write('File name, Modify time, Size (bytes), Directoryn')
                self.listfile(mydir,file1,mydays,myext)
                file1.close()
                os.chdir(mydir)change path to the begining path
                self.msg.config(text=unicode('搜索成功!请查看'+os.path.join(resultdir.encode('utf8'),'result.csv'),'utf8'),font=('songti',9))
            except IOError,(errno,strerror):
                print 'IO error %s: %s' % (errno,strerror)
                self.msg.config(text = 'IO error %s: %s' % (errno,strerror))
                os.chdir(mydir)
            except:
                print "Unexpected error:", sys.exc_info()[0]
                self.msg.config(text='error '+str(sys.exc_info()[0]))
                file1.close()
                os.chdir(mydir)
                raise
       def pressedPlain(self):
           showinfo("Message","You pressed Plain Button")
        def rolloverEnter(self,event):
            event.widget.config(relief=GROOVE)
        def rolloverLeave(self,event):
            event.widget.config(relief=RAISED)
    
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
                        self.msg.config(text=status,font=('songti',9))
                        continue;
    
                t = os.path.getmtime(fullname)
                tnow = time.time()
                #print fullname,' ignore',tnow,t,tnow-t,86400*int(days)
                if len(days) > 0 :
                    if( (tnow -t) > 86400*int(days)):
                        status = 'ignore '+filename+' for date'
                        print status
                        self.msg.config(text=status,font=('songti',9))
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
        root.title(unicode("搜索工具-0.9- 周海汉 2008.12.17",'utf8'))
        app = capp(root)
        root.mainloop()
    
