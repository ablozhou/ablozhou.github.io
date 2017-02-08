---
author: abloz
comments: true
date: 2011-08-30 02:20:29+00:00
layout: post
link: http://abloz.com/index.php/2011/08/30/php5-3-features-deprecated/
slug: php5-3-features-deprecated
title: php5.3 中废弃的功能全集
wordpress_id: 1383
categories:
- 技术
tags:
- php
---

作者：ablozhou

来源：abloz.com

2011.8.30

在看一些php5.3版本以前的教程时，举的例子在php5.3 中将得到警告。 如

    
    Function ereg_replace() is deprecated


PHP 5.3 中令人瞩目的废弃有3类。一是POSIX的正则表达式全部用[Perl兼容正则表达式(PCRE)](http://www.php.net/manual/en/book.pcre.php)替代。二是Session相关用$_SESSION[] 全局变量来操作。三是对mysql操作的一些改变。

改变详情：

PHP 5.3.0 新增了两个错误等级: **E_DEPRECATED** 和 **E_USER_DEPRECATED**. 错误等级 **E_DEPRECATED** 被用来说明一个函数或者功能已经被弃用. **E_USER_DEPRECATED** 等级目的在于表明用户代码中的弃用功能, 类似于 **E_USER_ERROR** 和 **E_USER_WARNING** 等级.

下面是被弃用的 INI 指令列表. 使用下面任何指令都将导致 **E_DEPRECATED** 错误.



	
  * [define_syslog_variables](http://cn.php.net/manual/zh/network.configuration.php#ini.define-syslog-variables)

	
  * [register_globals](http://cn.php.net/manual/zh/ini.core.php#ini.register-globals)

	
  * [register_long_arrays](http://cn.php.net/manual/zh/ini.core.php#ini.register-long-arrays)

	
  * [safe_mode](http://cn.php.net/manual/zh/ini.sect.safe-mode.php#ini.safe-mode)

	
  * [magic_quotes_gpc](http://cn.php.net/manual/zh/info.configuration.php#ini.magic-quotes-gpc)

	
  * [magic_quotes_runtime](http://cn.php.net/manual/zh/info.configuration.php#ini.magic-quotes-runtime)

	
  * [magic_quotes_sybase](http://cn.php.net/manual/zh/sybase.configuration.php#ini.magic-quotes-sybase)

	
  * 弃用 INI 文件中以 '#' 开头的注释.


弃用函数:

	
  * [call_user_method()](http://cn.php.net/manual/zh/function.call-user-method.php) (使用 [call_user_func()](http://cn.php.net/manual/zh/function.call-user-func.php) 替代)

	
  * [call_user_method_array()](http://cn.php.net/manual/zh/function.call-user-method-array.php) (使用 [call_user_func_array()](http://cn.php.net/manual/zh/function.call-user-func-array.php) 替代)

	
  * [define_syslog_variables()](http://cn.php.net/manual/zh/function.define-syslog-variables.php)

	
  * [dl()](http://cn.php.net/manual/zh/function.dl.php)

	
  * [ereg()](http://cn.php.net/manual/zh/function.ereg.php) (使用 [preg_match()](http://cn.php.net/manual/zh/function.preg-match.php) 替代)

	
  * [ereg_replace()](http://cn.php.net/manual/zh/function.ereg-replace.php) (使用 [preg_replace()](http://cn.php.net/manual/zh/function.preg-replace.php) 替代)

	
  * [eregi()](http://cn.php.net/manual/zh/function.eregi.php) (使用 [preg_match()](http://cn.php.net/manual/zh/function.preg-match.php) 配合 _'i'_ 修正符替代)

	
  * [eregi_replace()](http://cn.php.net/manual/zh/function.eregi-replace.php) (使用 [preg_replace()](http://cn.php.net/manual/zh/function.preg-replace.php) 配合 _'i'_ 修正符替代)

	
  * [set_magic_quotes_runtime()](http://cn.php.net/manual/zh/function.set-magic-quotes-runtime.php) 以及它的别名函数 [magic_quotes_runtime()](http://cn.php.net/manual/zh/function.magic-quotes-runtime.php)

	
  * [session_register()](http://cn.php.net/manual/zh/function.session-register.php) (使用 [$_SESSION](http://cn.php.net/manual/zh/reserved.variables.session.php) 超全部变量替代)

	
  * [session_unregister()](http://cn.php.net/manual/zh/function.session-unregister.php) (使用 [$_SESSION](http://cn.php.net/manual/zh/reserved.variables.session.php) 超全部变量替代)

	
  * [session_is_registered()](http://cn.php.net/manual/zh/function.session-is-registered.php) (使用 [$_SESSION](http://cn.php.net/manual/zh/reserved.variables.session.php) 超全部变量替代)

	
  * [set_socket_blocking()](http://cn.php.net/manual/zh/function.set-socket-blocking.php) (使用 [stream_set_blocking()](http://cn.php.net/manual/zh/function.stream-set-blocking.php) 替代)

	
  * [split()](http://cn.php.net/manual/zh/function.split.php) (使用 [preg_split()](http://cn.php.net/manual/zh/function.preg-split.php) 替代)

	
  * [spliti()](http://cn.php.net/manual/zh/function.spliti.php) (使用 [preg_split()](http://cn.php.net/manual/zh/function.preg-split.php) 配合 _'i'_ 修正符替代)

	
  * [sql_regcase()](http://cn.php.net/manual/zh/function.sql-regcase.php)

	
  * [mysql_db_query()](http://cn.php.net/manual/zh/function.mysql-db-query.php) (使用 [mysql_select_db()](http://cn.php.net/manual/zh/function.mysql-select-db.php) 和 [mysql_query()](http://cn.php.net/manual/zh/function.mysql-query.php) 替代)

	
  * [mysql_escape_string()](http://cn.php.net/manual/zh/function.mysql-escape-string.php) (使用 [mysql_real_escape_string()](http://cn.php.net/manual/zh/function.mysql-real-escape-string.php) 替代)

	
  * 废弃以字符串传递区域设置名称. 使用 LC_* 系列常量替代.

	
  * [mktime()](http://cn.php.net/manual/zh/function.mktime.php) 的 _is_dst_ 参数. 使用新的时区处理函数替代.


弃用的功能:

	
  * 弃用通过引用分配 [new](http://cn.php.net/manual/zh/language.oop5.basic.php#language.oop5.basic.new) 的返回值.

	
  * 调用时传递引用被弃用.


