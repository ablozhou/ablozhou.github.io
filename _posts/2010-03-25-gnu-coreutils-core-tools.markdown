---
author: abloz
comments: true
date: 2010-03-25 07:05:00+00:00
layout: post
link: http://abloz.com/index.php/2010/03/25/gnu-coreutils-core-tools/
slug: gnu-coreutils-core-tools
title: gnu coreutils内核工具
wordpress_id: 1183
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

 

gnu coreutils 是原来的gnu shellutils, fileutils, textutils三部分合成的。里面有许多很强大的shell，文件和文本处理工具。如sort, seq, split,uniq,cut,md5sum,wc等

 

gnu coreutils的手册英文版放在：http://www.gnu.org/software/coreutils/manual/，可以text,html,pdf等各种格式。

 

查询我utuntu 9.10安装的coreutils版本号是： 7.4-2：

 

[](http://blog.csdn.net/ablo_zhou/archive/2010/03/28/5425811.aspx#)[  
](http://blog.csdn.net/ablo_zhou/archive/2010/03/28/5425811.aspx#)

  1. zhouhh@zhouhh-home:~$ sudo aptitude show coreutils
  2. 软件包： coreutils
  3. 基本的： 是
  4. 状态: 已安装
  5. 自动安装: 否
  6. 版本号： 7.4-2ubuntu1
  7. 优先级： 必要
  8. 部分： utils
  9. 维护者： Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
  10. 未压缩尺寸： 12.8M
  11. 预依赖于: libacl1 (>= 2.2.11-1), libattr1 (>= 2.4.41-1), libc6 (>= 2.7),
  12. libselinux1 (>= 2.0.85)
  13. 代替: mktemp
  14. 描述： The GNU core utilities
  15. This package contains the essential basic system utilities.
  16.   17. Specifically, this package includes: basename cat chgrp chmod chown chroot
  18. cksum comm cp csplit cut date dd df dir dircolors dirname du echo env expand
  19. expr factor false fmt fold groups head hostid id install join link ln logname
  20. ls md5sum mkdir mkfifo mknod mktemp mv nice nl nohup od paste pathchk pinky pr
  21. printenv printf ptx pwd readlink rm rmdir sha1sum seq shred sleep sort split
  22. stat stty sum sync tac tail tee test touch tr true tsort tty uname unexpand
  23. uniq unlink users vdir wc who whoami yes

zhouhh@zhouhh-home:~$ sudo aptitude show coreutils 软件包： coreutils 基本的： 是 状态: 已安装 自动安装: 否 版本号： 7.4-2ubuntu1 优先级： 必要 部分： utils 维护者： Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com> 未压缩尺寸： 12.8M 预依赖于: libacl1 (>= 2.2.11-1), libattr1 (>= 2.4.41-1), libc6 (>= 2.7),              libselinux1 (>= 2.0.85) 代替: mktemp 描述： The GNU core utilities This package contains the essential basic system utilities.   Specifically, this package includes: basename cat chgrp chmod chown chroot cksum comm cp csplit cut date dd df dir dircolors dirname du echo env expand expr factor false fmt fold groups head hostid id install join link ln logname ls md5sum mkdir mkfifo mknod mktemp mv nice nl nohup od paste pathchk pinky pr printenv printf ptx pwd readlink rm rmdir sha1sum seq shred sleep sort split stat stty sum sync tac tail tee test touch tr true tsort tty uname unexpand uniq unlink users vdir wc who whoami yes    

下面是gnu coreutils工具简介：
    
    3 Output of entire files
    
      3.1 `cat': Concatenate and write files
    
      3.2 `tac': Concatenate and write files in reverse
    
      3.3 `nl': Number lines and write files
    
      3.4 `od': Write files in octal or other formats
    
      3.5 `base64': Transform data into printable data
    
    4 Formatting file contents
    
      4.1 `fmt': Reformat paragraph text
    
      4.2 `pr': Paginate or columnate files for printing
    
      4.3 `fold': Wrap input lines to fit in specified width
    
    5 Output of parts of files
    
      5.1 `head': Output the first part of files
    
      5.2 `tail': Output the last part of files
    
      5.3 `split': Split a file into fixed-size pieces
    
      5.4 `csplit': Split a file into context-determined pieces
    
    6 Summarizing files
    
      6.1 `wc': Print newline, word, and byte counts
    
      6.2 `sum': Print checksum and block counts
    
      6.3 `cksum': Print CRC checksum and byte counts
    
      6.4 `md5sum': Print or check MD5 digests
    
      6.5 `sha1sum': Print or check SHA-1 digests
    
      6.6 sha2 utilities: Print or check SHA-2 digests
    
    7 Operating on sorted files
    
      7.1 `sort': Sort text files
    
      7.2 `shuf': Shuffling text
    
      7.3 `uniq': Uniquify files
    
      7.4 `comm': Compare two sorted files line by line
    
      7.5 `ptx': Produce permuted indexes
    
        7.5.1 General options
    
        7.5.2 Charset selection
    
        7.5.3 Word selection and input processing
    
        7.5.4 Output formatting
    
        7.5.5 The GNU extensions to `ptx'
    
      7.6 `tsort': Topological sort
    
        7.6.1 `tsort': Background
    
    8 Operating on fields
    
      8.1 `cut': Print selected parts of lines
    
      8.2 `paste': Merge lines of files
    
      8.3 `join': Join lines on a common field
    
    9 Operating on characters
    
      9.1 `tr': Translate, squeeze, and/or delete characters
    
        9.1.1 Specifying sets of characters
    
        9.1.2 Translating
    
        9.1.3 Squeezing repeats and deleting
    
      9.2 `expand': Convert tabs to spaces
    
      9.3 `unexpand': Convert spaces to tabs
    
    10 Directory listing
    
      10.1 `ls': List directory contents
    
        10.1.1 Which files are listed
    
        10.1.2 What information is listed
    
        10.1.3 Sorting the output
    
        10.1.4 Details about version sort
    
        10.1.5 General output formatting
    
        10.1.6 Formatting file timestamps
    
        10.1.7 Formatting the file names
    
      10.2 `dir': Briefly list directory contents
    
      10.3 `vdir': Verbosely list directory contents
    
      10.4 `dircolors': Color setup for `ls'
    
    11 Basic operations
    
      11.1 `cp': Copy files and directories
    
      11.2 `dd': Convert and copy a file
    
      11.3 `install': Copy files and set attributes
    
      11.4 `mv': Move (rename) files
    
      11.5 `rm': Remove files or directories
    
      11.6 `shred': Remove files more securely
    
    12 Special file types
    
      12.1 `link': Make a hard link via the link syscall
    
      12.2 `ln': Make links between files
    
      12.3 `mkdir': Make directories
    
      12.4 `mkfifo': Make FIFOs (named pipes)
    
      12.5 `mknod': Make block or character special files
    
      12.6 `readlink': Print value of a symlink or canonical file name
    
      12.7 `rmdir': Remove empty directories
    
      12.8 `unlink': Remove files via the unlink syscall
    
    13 Changing file attributes
    
      13.1 `chown': Change file owner and group
    
      13.2 `chgrp': Change group ownership
    
      13.3 `chmod': Change access permissions
    
      13.4 `touch': Change file timestamps
    
    14 Disk usage
    
      14.1 `df': Report file system disk space usage
    
      14.2 `du': Estimate file space usage
    
      14.3 `stat': Report file or file system status
    
      14.4 `sync': Synchronize data on disk with memory
    
      14.5 `truncate': Shrink or extend the size of a file
    
    15 Printing text
    
      15.1 `echo': Print a line of text
    
      15.2 `printf': Format and print data
    
      15.3 `yes': Print a string until interrupted
    
    16 Conditions
    
      16.1 `false': Do nothing, unsuccessfully
    
      16.2 `true': Do nothing, successfully
    
      16.3 `test': Check file types and compare values
    
        16.3.1 File type tests
    
        16.3.2 Access permission tests
    
        16.3.3 File characteristic tests
    
        16.3.4 String tests
    
        16.3.5 Numeric tests
    
        16.3.6 Connectives for `test'
    
      16.4 `expr': Evaluate expressions
    
        16.4.1 String expressions
    
        16.4.2 Numeric expressions
    
        16.4.3 Relations for `expr'
    
        16.4.4 Examples of using `expr'
    
    17 Redirection
    
      17.1 `tee': Redirect output to multiple files or processes
    
    18 File name manipulation
    
      18.1 `basename': Strip directory and suffix from a file name
    
      18.2 `dirname': Strip non-directory suffix from a file name
    
      18.3 `pathchk': Check file name validity and portability
    
      18.4 `mktemp': Create temporary file or directory
    
    19 Working context
    
      19.1 `pwd': Print working directory
    
      19.2 `stty': Print or change terminal characteristics
    
        19.2.1 Control settings
    
        19.2.2 Input settings
    
        19.2.3 Output settings
    
        19.2.4 Local settings
    
        19.2.5 Combination settings
    
        19.2.6 Special characters
    
        19.2.7 Special settings
    
      19.3 `printenv': Print all or some environment variables
    
      19.4 `tty': Print file name of terminal on standard input
    
    20 User information
    
      20.1 `id': Print user identity
    
      20.2 `logname': Print current login name
    
      20.3 `whoami': Print effective user ID
    
      20.4 `groups': Print group names a user is in
    
      20.5 `users': Print login names of users currently logged in
    
      20.6 `who': Print who is currently logged in
    
    21 System context
    
      21.1 `date': Print or set system date and time
    
        21.1.1 Time conversion specifiers
    
        21.1.2 Date conversion specifiers
    
        21.1.3 Literal conversion specifiers
    
        21.1.4 Padding and other flags
    
        21.1.5 Setting the time
    
        21.1.6 Options for `date'
    
        21.1.7 Examples of `date'
    
      21.2 `arch': Print machine hardware name
    
      21.3 `nproc': Print the number of available processors
    
      21.4 `uname': Print system information
    
      21.5 `hostname': Print or set system name
    
      21.6 `hostid': Print numeric host identifier
    
      21.7 `uptime': Print system uptime and load
    
    22 SELinux context
    
      22.1 `chcon': Change SELinux context of file
    
      22.2 `runcon': Run a command in specified SELinux context
    
    23 Modified command invocation
    
      23.1 `chroot': Run a command with a different root directory
    
      23.2 `env': Run a command in a modified environment
    
      23.3 `nice': Run a command with modified niceness
    
      23.4 `nohup': Run a command immune to hangups
    
      23.5 `stdbuf': Run a command with modified I/O stream buffering
    
      23.6 `su': Run a command with substitute user and group ID
    
        23.6.1 Why GNU `su' does not support the `wheel' group
    
      23.7 `timeout': Run a command with a time limit
    
    24 Process control
    
      24.1 `kill': Send a signal to processes
    
    25 Delaying
    
      25.1 `sleep': Delay for a specified time
    
    26 Numeric operations
    
      26.1 `factor': Print prime factors
    
      26.2 `seq': Print numeric sequences
    
    27 File permissions
    
      27.1 Structure of File Mode Bits
    
      27.2 Symbolic Modes
    
        27.2.1 Setting Permissions
    
        27.2.2 Copying Existing Permissions
    
        27.2.3 Changing Special Mode Bits
    
        27.2.4 Conditional Executability
    
        27.2.5 Making Multiple Changes
    
        27.2.6 The Umask and Protection
    
      27.3 Numeric Modes
    
      27.4 Directories and the Set-User-ID and Set-Group-ID Bits
    
    28 Date input formats
    
      28.1 General date syntax
    
      28.2 Calendar date items
    
      28.3 Time of day items
    
      28.4 Time zone items
    
      28.5 Day of week items
    
      28.6 Relative items in date strings
    
      28.7 Pure numbers in date strings
    
      28.8 Seconds since the Epoch
    
      28.9 Specifying time zone rules
    
      28.10 Authors of `get_date'
    
    29 Opening the Software Toolbox
    
      Toolbox Introduction
    
      I/O Redirection
    
      The `who' Command
    
      The `cut' Command
    
      The `sort' Command
    
      The `uniq' Command

  
  


![](http://img.zemanta.com/pixy.gif?x-id=ff1a13b5-e5b0-8997-a11f-87807a0347fa)
