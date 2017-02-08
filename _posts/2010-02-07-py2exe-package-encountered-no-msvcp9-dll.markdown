---
author: abloz
comments: true
date: 2010-02-07 06:51:00+00:00
layout: post
link: http://abloz.com/index.php/2010/02/07/py2exe-package-encountered-no-msvcp9-dll/
slug: py2exe-package-encountered-no-msvcp9-dll
title: py2exe打包，遇到找不到msvcp9.dll
wordpress_id: 1046
categories:
- 技术
---

#  					 				

				

 					  					  					

[周海汉](http://blog.csdn.net/ablo_zhou) /文

2010.2.7

 

今天用py2exe打包python程序，结果遇到如下错误：

 

[  
](http://blog.csdn.net/ablo_zhou/archive/2010/02/07/5295750.aspx#)[](http://blog.csdn.net/ablo_zhou/archive/2010/02/07/5295750.aspx#)

  1. *** searching for required modules ***
  2. *** parsing results ***
  3. creating python loader for extension 'wx._misc_' (c:python26libsite-packages
  4. wx-2.8-msw-unicodewx_misc_.pyd -> wx._misc_.pyd)
  5. creating python loader for extension 'select' (c:python26DLLsselect.pyd -> se
  6. lect.pyd)
  7. creating python loader for extension 'unicodedata' (c:python26DLLsunicodedata
  8. .pyd -> unicodedata.pyd)
  9. creating python loader for extension 'wx._windows_' (c:python26libsite-packag
  10. eswx-2.8-msw-unicodewx_windows_.pyd -> wx._windows_.pyd)
  11. creating python loader for extension 'wx._core_' (c:python26libsite-packages
  12. wx-2.8-msw-unicodewx_core_.pyd -> wx._core_.pyd)
  13. creating python loader for extension 'wx._gdi_' (c:python26libsite-packagesw
  14. x-2.8-msw-unicodewx_gdi_.pyd -> wx._gdi_.pyd)
  15. creating python loader for extension 'wx._controls_' (c:python26libsite-packa
  16. geswx-2.8-msw-unicodewx_controls_.pyd -> wx._controls_.pyd)
  17. creating python loader for extension 'bz2' (c:python26DLLsbz2.pyd -> bz2.pyd)
  18. *** finding dlls needed ***
  19. error: MSVCP90.dll: No such file or directory

*** searching for required modules *** *** parsing results *** creating python loader for extension 'wx._misc_' (c:python26libsite-packages wx-2.8-msw-unicodewx_misc_.pyd -> wx._misc_.pyd) creating python loader for extension 'select' (c:python26DLLsselect.pyd -> se lect.pyd) creating python loader for extension 'unicodedata' (c:python26DLLsunicodedata .pyd -> unicodedata.pyd) creating python loader for extension 'wx._windows_' (c:python26libsite-packag eswx-2.8-msw-unicodewx_windows_.pyd -> wx._windows_.pyd) creating python loader for extension 'wx._core_' (c:python26libsite-packages wx-2.8-msw-unicodewx_core_.pyd -> wx._core_.pyd) creating python loader for extension 'wx._gdi_' (c:python26libsite-packagesw x-2.8-msw-unicodewx_gdi_.pyd -> wx._gdi_.pyd) creating python loader for extension 'wx._controls_' (c:python26libsite-packa geswx-2.8-msw-unicodewx_controls_.pyd -> wx._controls_.pyd) creating python loader for extension 'bz2' (c:python26DLLsbz2.pyd -> bz2.pyd) *** finding dlls needed *** error: MSVCP90.dll: No such file or directory   

*** finding dlls needed ***

error: MSVCP90.dll: No such file or directory

  

## 解决办法：

 

因为包含wxpython模块，需下载MSVCP90.DLL 并拷贝到Python26/DLLs 目录下

 

1.直接下载安装[微软vc++ 2008 分发包](http://www.microsoft.com/downloads/details.aspx?displaylang=zh-cn&FamilyID=9b2da534-3e03-4391-8a4d-074b9f2bc1bf)：[http://www.microsoft.com/downloads/details.aspx?displaylang=zh-cn&FamilyID=9b2da534-3e03-4391-8a4d-074b9f2bc1bf](http://www.microsoft.com/downloads/details.aspx?displaylang=zh-cn&FamilyID=9b2da534-3e03-4391-8a4d-074b9f2bc1bf)

 

会安装到：

C:WINDOWSWinSxSx86_Microsoft.VC90.CRT_1fc8b3b9a1e18e3b_9.0.30411.0_x-ww_71382c73目录下

可能不同的系统会稍有不同，但C:WINDOWSWinSxSx86_Microsoft.VC90...这个是一致的。

而且直接在windows里搜索搜不到。

 

2.单独下载MSVCP90.DLL 并拷贝到Python26/DLLs 目录下

[http://www.dll-files.com/dllindex/dll-files.shtml?msvcp90](http://www.dll-files.com/dllindex/dll-files.shtml?msvcp90)

3.由于本机也能运行，确认不需要msvcp90.dll,可以直接在脚本中去掉包含该dll。但可能在其他人机器不能运行。

在py2exe的setup.py包含如下的代码：

[  
](http://blog.csdn.net/ablo_zhou/archive/2010/02/07/5295750.aspx#)[](http://blog.csdn.net/ablo_zhou/archive/2010/02/07/5295750.aspx#)

  1. distutils.core.setup(
  2. options = {
  3. "py2exe": {
  4. "dll_excludes": ["MSVCP90.dll"]
  5. }
  6. },
  7. ...
  8. )

distutils.core.setup(    options = {        "py2exe": {            "dll_excludes": ["MSVCP90.dll"]        }    },    ... )

或

[  
](http://blog.csdn.net/ablo_zhou/archive/2010/02/07/5295750.aspx#)[](http://blog.csdn.net/ablo_zhou/archive/2010/02/07/5295750.aspx#)

  1. fro
m distutils.core import setup
  2. import py2exe
  3. setup(
  4. windows=['main.py'],
  5. options = {
  6. "py2exe":
  7. {"dll_excludes":["MSVCP90.dll"]}
  8. }
  9. )

from distutils.core import setup  import py2exe setup(      windows=['main.py'],       options = {               "py2exe":       {"dll_excludes":["MSVCP90.dll"]}       } )  

4.如果已经安装msvc++ 2008以上，而找不到目录，可以如下设置，找到分发目录。

[  
](http://blog.csdn.net/ablo_zhou/archive/2010/02/07/5295750.aspx#)[](http://blog.csdn.net/ablo_zhou/archive/2010/02/07/5295750.aspx#)

  1. import sys
  2. sys.path.append('c:/Program Files/Microsoft Visual Studio 9.0/VC/redist/x86/Microsoft.VC90.CRT')

  


  
  


![](http://img.zemanta.com/pixy.gif?x-id=87283133-c83d-8a91-b8f7-70978b68fa2e)
