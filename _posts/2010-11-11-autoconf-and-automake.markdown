---
author: abloz
comments: true
date: 2010-11-11 09:14:54+00:00
layout: post
link: http://abloz.com/index.php/2010/11/11/autoconf-and-automake/
slug: autoconf-and-automake
title: autoconf和automake实践
wordpress_id: 1052
categories:
- 技术
tags:
- autoconf
- automake
---

周海汉 2010.11.11 光棍不再

linux程序源码编译三部曲：
**./configure
make
make install**
非常省事。一个configure可以为多变环境生成不同的makefile，确保make可以通过。
所以我们写代码时也非常希望利用上这些快捷工具，免得自己去写configure和makefile。
autoconf和automake联合起来，可以为编译省很多事。

下面是gnu画的autoconf和automake关系图：
来源：http://www.gnu.org/software/autoconf/manual/autoconf.html
用autoconf生成configure.带*表示可以执行。带[]表示可选。

    
         your source files --> [autoscan*] --> [configure.scan] --> configure.ac
    
         configure.ac --.
                        |   .------> autoconf* -----> configure
         [aclocal.m4] --+---+
                        |   `-----> [autoheader*] --> [config.h.in]
         [acsite.m4] ---'


用automake生成Makefile.in,但Makefile.am是手动编辑的。

    
         [acinclude.m4] --.
                          |
         [local macros] --+--> aclocal* --> aclocal.m4
                          |
         configure.ac ----'
    
         configure.ac --.
                        +--> automake* --> Makefile.in
         Makefile.am ---'


配置软件包用到的文件。

    
                                .-------------> [config.cache]
         configure* ------------+-------------> config.log
                                |
         [config.h.in] -.       v            .-> [config.h] -.
                        +--> config.status* -+               +--> make*
         Makefile.in ---'                    `-> Makefile ---'


其中configure.ac和Makefile.am是必须手工修改的。

测试程序：
zhouhh@zhh64:~/hello$ ls
hello.c hello.h

我希望为测试程序生成./configure和Makefile

    
    zhouhh@zhh64:~/hello$ cat hello.c
    //////////////////////////////////////////
    //author 	zhouhh
    //date 		2010.11.8
    //web       http://abloz.com
    //history
    /////////////////////////////////////////
    
    #include
    #include
    #include
    #include
    #include
    #include
    #include
    #include
    
    #include
    
    #include
    
    #include "hello.h"
    
    int         epoll_handle;
    struct epoll_event    events[EPOLL_SIZE];
    pthread_t accept_tid;
    static void *accept_thread(void *arg);
    
    int main(int argc, char *argv[])
    {
        int perr, nfds, i;
    
        epoll_handle = epoll_create(EPOLL_SIZE);
        if (epoll_handle == -1) {
            perror("process exitn");
            exit(EXIT_FAILURE);
        }
        perr = pthread_create(&accept_tid, NULL, accept_thread, NULL);
        if (perr != 0) {
            perror("pthread_create");
            exit(EXIT_FAILURE);
        }
        char buf[1024]={0};
        int len = 0;
        while (1) {
            nfds = epoll_wait(epoll_handle, events, EPOLL_SIZE, -1);
            if (nfds == -1) {
                perror("epoll_wait");
                exit(EXIT_FAILURE);
            }
            for (i = 0; i < nfds; i++) {
                printf("%d recv socket fd %d is donen", i, events[i].data.fd);
                len = read(events[i].data.fd,buf,1024);
                buf[len]='\0';
                printf("rcved "%s",len= %d n",buf,len);
                write(events[i].data.fd,buf,len);
                //write(stdout,buf,1024);
    
            } //for (i = 0; i < nfds; i++)
        } //while(1)
        return 0;
    }
    static void *accept_thread(void *arg)
    {
        int                 sockfd;
        int                    connfd;
        int                    t;
        socklen_t            clilen = 0;
        struct sockaddr     servaddr, cliaddr;
        struct sockaddr_in    *st_in = (struct sockaddr_in *)&servaddr;
        struct epoll_event    ev;
    
        t = pthread_detach(pthread_self());
        if (t != 0) {
            perror("pthread_detach");
            return NULL;
        }
    
        sockfd = socket(AF_INET, SOCK_STREAM, 0);
        if (sockfd == -1) {
            perror("process exitn");
            exit(EXIT_FAILURE);
        }
        int opt = 1;
        setsockopt(sockfd,SOL_SOCKET,SO_REUSEADDR,&opt, sizeof(opt));
        bzero(&servaddr, sizeof(struct sockaddr));
        st_in->sin_family = AF_INET;
        st_in->sin_port = htons(PORT);
        st_in->sin_addr.s_addr = htonl(INADDR_ANY);
        if (bind(sockfd, &servaddr, sizeof(servaddr)) == -1) {
            perror("bind");
            exit(EXIT_FAILURE);
        }
        if (listen(sockfd, 10) == -1) {
            perror("process exitn");
            exit(EXIT_FAILURE);
        }
    
        clilen = sizeof(cliaddr);
        ev.events = EPOLLIN | EPOLLET;
    
        while (1) {
            if ( (connfd = accept(sockfd, (struct sockaddr *)&cliaddr, &clilen)) < 0) {
                perror("accept");
                break;
            }
            printf("accept return %dn", connfd);
            ev.data.fd = connfd;
            if (epoll_ctl(epoll_handle, EPOLL_CTL_ADD, connfd, &ev) < 0) {
                perror("epoll_ctl");
            }
        }
    
        return NULL;
    }
    
    void testcurl(void)
    {
        CURL *curl;
        CURLcode res;
    
        curl = curl_easy_init();
        if(curl) {
            curl_easy_setopt(curl, CURLOPT_URL, "http://abloz.com");
            res = curl_easy_perform(curl);
    
            /* always cleanup */
            curl_easy_cleanup(curl);
        }
    }



    
    zhouhh@zhh64:~/hello$ cat hello.h
    //////////////////////////////////////////
    //author 	zhouhh
    //date 		2010.11.8
    //web       http://abloz.com
    //history
    /////////////////////////////////////////
    
    #ifndef __HELLO_H_
    #define __HELLO_H_
    
    #define PORT 5000
    #define EPOLL_SIZE 50
    
    #endif // __HELLO_H_


生成configure.scan
zhouhh@zhh64:~/hello$ autoscan
zhouhh@zhh64:~/hello$ ls
autoscan.log configure.scan hello.c hello.h

zhouhh@zhh64:~/hello$ vi configure.scan

将configure.scan改名configure.ac或configure.in，但第二种文件名只是为了和老版本兼容。
zhouhh@zhh64:~/hello$ cp configure.scan configure.ac

生成aclocal.m4
zhouhh@zhh64:~/hello$ aclocal
zhouhh@zhh64:~/hello$ ls
autom4te.cache autoscan.log configure.ac configure.scan hello.c hello.h

修改configure.ac
zhouhh@zhh64:~/hello$ vi configure.ac

    
    #                                               -*- Autoconf -*-
    # Process this file with autoconf to produce a configure script.
    
    AC_PREREQ([2.67])
    AC_INIT([FULL-PACKAGE-NAME], [VERSION], [BUG-REPORT-ADDRESS])
    AC_CONFIG_SRCDIR([hello.h])
    AC_CONFIG_HEADERS([config.h])
    
    # Checks for programs.
    AC_PROG_CC
    
    # Checks for libraries.
    
    # Checks for header files.
    AC_CHECK_HEADERS([arpa/inet.h stdlib.h strings.h sys/socket.h unistd.h])
    
    # Checks for typedefs, structures, and compiler characteristics.
    
    # Checks for library functions.
    AC_CHECK_FUNCS([bzero socket])
    
    AC_OUTPUT



    
    zhouhh@zhh64:~/hello$ cp configure.scan configure.scan.bk
    zhouhh@zhh64:~/hello$ autoconf
    configure.ac:8: error: possibly undefined macro: AM_INIT_AUTOMAKE
          If this token and others are legitimate, please use m4_pattern_allow.
          See the Autoconf documentation.


这是因为更新configure.ac后必须重新生成aclocal.m4，宏才有定义。
zhouhh@zhh64:~/hello$ ls
autom4te.cache configure configure.scan hello.c
autoscan.log configure.ac configure.scan.bk hello.h
zhouhh@zhh64:~/hello$ aclocal
zhouhh@zhh64:~/hello$ ls
aclocal.m4 autoscan.log configure.ac configure.scan.bk hello.h
autom4te.cache configure configure.scan hello.c
zhouhh@zhh64:~/hello$ autoconf

调用autoheader生成config.h.in
zhouhh@zhh64:~/hello$ autoheader
zhouhh@zhh64:~/hello$ ls
aclocal.m4 autoscan.log configure configure.scan hello.c
autom4te.cache config.h.in configure.ac configure.scan.bk hello.h

生成configure
zhouhh@zhh64:~/hello$ autoconf
zhouhh@zhh64:~/hello$ ls
aclocal.m4 autoscan.log configure configure.scan hello.c
autom4te.cache config.h.in configure.ac configure.scan.bk hello.h
zhouhh@zhh64:~/hello$ ./configure
configure: error: cannot find install-sh, install.sh, or shtool in "." "./.." "./../.."

为符合gnu标准，生成NEWS README AUTHORS ChangeLog，否则会报错。但这些也可以配置不生成。
zhouhh@zhh64:~/hello$ touch NEWS README AUTHORS ChangeLog

zhouhh@zhh64:~/hello$ autoreconf --force --install
configure.ac:8: installing `./install-sh'
configure.ac:8: installing `./missing'
automake: no `Makefile.am' found for any configure output
autoreconf: automake failed with exit status: 1

zhouhh@zhh64:~/hello$ autoconf
zhouhh@zhh64:~/hello$ ./configure
checking for a BSD-compatible install... /usr/bin/install -c
...
configure: creating ./config.status
config.status: error: cannot find input file: `Makefile.in'

zhouhh@zhh64:~/hello$ automake
automake: no `Makefile.am' found for any configure output
zhouhh@zhh64:~/hello$ touch Makefile.am
zhouhh@zhh64:~/hello$ automake
Makefile.am: required file `./INSTALL' not found
Makefile.am: `automake --add-missing' can install `INSTALL'
Makefile.am: required file `./COPYING' not found
Makefile.am: `automake --add-missing' can install `COPYING'
zhouhh@zhh64:~/hello$ ls
aclocal.m4 ChangeLog config.status configure.scan.bk Makefile.am
AUTHORS config.h.in configure hello.c missing
autom4te.cache config.h.in~ configure.ac hello.h NEWS
autoscan.log config.log configure.scan install-sh README
zhouhh@zhh64:~/hello$ automake --add-missing INSTALL COPYING
automake: no Automake input file found for `INSTALL'
automake: no Automake input file found for `COPYING'
automake: no input file found among supplied arguments

zhouhh@zhh64:~/hello$ touch INSTALL COPYING
zhouhh@zhh64:~/hello$ automake
zhouhh@zhh64:~/hello$ ls
aclocal.m4 config.h.in configure.ac hello.h missing
AUTHORS config.h.in~ configure.scan INSTALL NEWS
autom4te.cache config.log configure.scan.bk install-sh README
autoscan.log config.status COPYING Makefile.am
ChangeLog configure hello.c Makefile.in
zhouhh@zhh64:~/hello$ autoreconf
zhouhh@zhh64:~/hello$ ./configure
...
configure: creating ./config.status
config.status: creating Makefile
config.status: creating config.h
config.status: executing depfiles commands

zhouhh@zhh64:~/hello$ ls
aclocal.m4 config.h.in configure.scan install-sh README
AUTHORS config.h.in~ configure.scan.bk Makefile stamp-h1
autom4te.cache config.log COPYING Makefile.am
autoscan.log config.status hello.c Makefile.in
ChangeLog configure hello.h missing
config.h configure.ac INSTALL NEWS
zhouhh@zhh64:~/hello$ vi Makefile

因为Makefile.am是空的
zhouhh@zhh64:~/hello$ make
make all-am
make[1]: 正在进入目录 `/home/zhouhh/hello'
make[1]:正在离开目录 `/home/zhouhh/hello'

zhouhh@zhh64:~/hello$ vi Makefile.am

    
    AUTOMAKE_OPTIONS = subdir-objects
    ACLOCAL_AMFLAGS = ${ACLOCAL_FLAGS}
    
    bin_PROGRAMS = hello
    hello_SOURCES = hello.h hello.c
    #SUBDIRS = src
    #AM_CPPFLAGS = $(MYSQL_CFLAGS)
    hello_LDADD =  $(CURL_LIBS)
    #dist_noinst_SCRIPTS = autogen.sh


zhouhh@zhh64:~/hello$ vi configure.ac

    
    #                                               -*- Autoconf -*-
    # Process this file with autoconf to produce a configure script.
    
    AC_PREREQ([2.67])
    #AC_INIT([FULL-PACKAGE-NAME], [VERSION], [BUG-REPORT-ADDRESS])
    AC_INIT([hello], [1.0], [ablozhou@gmail.com], [hello], [http://abloz.com])
    AC_CONFIG_SRCDIR([hello.h])
    AM_INIT_AUTOMAKE([1.0 no-define])
    AC_CONFIG_HEADERS([config.h])
    AC_SUBST(CFLAGS)
    AC_SUBST(LD_FLAGS)
    
    # Checks for programs.
    AC_PROG_CC
    AC_CONFIG_FILES([Makefile])
    
    # Checks for libraries.
    #采用pkg-config
    #PKG_CHECK_MODULES([DEPS],[curl])
    AC_CHECK_LIB([pthread], [pthread_rwlock_init])
    AC_PROG_RANLIB
    #不采用pkg-config:
    AC_ARG_WITH([curl-lib-path],
      [AS_HELP_STRING([--with-curl-lib-path], [location of the curl libraries])],
      [CURL_LIBS="-L$withval -lcurl"],
      [CURL_LIBS='-lcurl'])
    AC_SUBST([CURL_LIBS])
    # Checks for header files.
    AC_CHECK_HEADERS([arpa/inet.h stdlib.h strings.h sys/socket.h unistd.h])
    
    # Checks for typedefs, structures, and compiler characteristics.
    
    # Checks for library functions.
    AC_CHECK_FUNCS([bzero socket])
    
    AC_OUTPUT


不采用pkg-config的方式，如mysql：

    
    # Get MySQL library and include locations
    AC_ARG_WITH([mysql-include-path],
      [AS_HELP_STRING([--with-mysql-include-path],
        [location of the MySQL headers, defaults to /usr/include/mysql])],
      [MYSQL_CFLAGS="-I$withval"],
      [MYSQL_CFLAGS='-I/usr/include/mysql'])
    AC_SUBST([MYSQL_CFLAGS])
    
    AC_ARG_WITH([mysql-lib-path],
      [AS_HELP_STRING([--with-mysql-lib-path], [location of the MySQL libraries])],
      [MYSQL_LIBS="-L$withval -lmysqlclient"],
      [MYSQL_LIBS='-lmysqlclient'])
    AC_SUBST([MYSQL_LIBS])


zhouhh@zhh64:~/hello$ autoreconf --force --install
Makefile.am: installing `./depcomp'
zhouhh@zhh64:~/hello$ ./configure
zhouhh@zhh64:~/hello$ make
通过。

参考：
http://www.openismus.com/documents/linux/automake/automake.shtml
http://www.openismus.com/documents/linux/using_libraries/using_libraries
[例子下载](http://www.openismus.com/documents/linux/using_libraries/examplelib_example-0.5.tar.gz)
http://www.gnu.org/software/automake/manual/standards/Makefile-Basics.html
http://www.gnu.org/software/autoconf/manual/autoconf.html
