---
author: abloz
comments: true
date: 2004-07-27 06:53:00+00:00
layout: post
link: http://abloz.com/index.php/2004/07/27/ce-hide-and-show-system-tray/
slug: ce-hide-and-show-system-tray
title: CE隐藏和显示系统任务栏
wordpress_id: 31
categories:
- 技术
tags:
- wince
---

HWND hWndInputPanel = NULL;  

HWND hWndTaskBar = NULL;  


 

HWND hWndSipButton = NULL;  


 

 

RECT rtDesktop;  


 

RECT rtNewDesktop;  


 

//RECT rtInputPanel;  

//RECT rtSipButton;  

RECT rtTaskBar;  


 

 

//初始化任务栏，获取任务栏窗口参数

int InitFullScreen (void)  


 

{  

int Result = 0;  


 

 

__try  

{  

if (SystemParametersInfo(SPI_GETWORKAREA, 0, &rtDesktop,
 NULL) == 1)  

{  

// Successful obtain the
 system working area (Desktop)  

SetRect(&rtNewDesktop, 0,
0, CEP_SCREEN_WIDTH, CEP_SCREEN_HEIGHT);  

 

// Change system setting  

SystemParametersInfo(SPI_SETWORKAREA, 0, &rtNewDesktop, SPIF_UPDATEINIFILE);  

}  

hWndTaskBar = FindWindow(TEXT("HHTaskBar"), NULL);  

// Checking...  

if (hWndTaskBar != NULL)  

{  

// Get the original
taskbar window size  


 

GetWindowRect(hWndTaskBar, &rtTaskBar);  

if (rtTaskBar.top >= CEP_SCREEN_HEIGHT)  

{  

rtTaskBar.top = CEP_SCREEN_HEIGHT - (rtTaskBar.bottom-rtTaskBar.top);  


 

rtTaskBar.bottom = CEP_SCREEN_HEIGHT;  

}  

}  


 

}  


 

__except(EXCEPTION_EXECUTE_HANDLER)  

{  

// PUT YOUR ERROR LOG
CODING HERE  


 

 

// Set return value  

Result = 1;  

}  


 

 

return Result;  

}  

 

//显隐任务栏，隐藏时将任务栏窗口移到屏幕外面，显示时再移入

int DoFullScreen (bool mode)  

{  

int
 Result = 0;  

 

__try  

{  

if (mode)  


 

{  

// Update window working
 area size  


 

SystemParametersInfo(SPI_SETWORKAREA, 0, &rtNewDesktop, SPIF_UPDATEINIFILE);  

 

if (NULL != hWndTaskBar)  


 

{  

// Hide the TaskBar  

MoveWindow(hWndTaskBar,   


 

0,   


 

rtNewDesktop.bottom,   


 

rtTaskBar.right - rtTaskBar.left,   

rtTaskBar.bottom - rtTaskBar.top,   

false);  

}  

}  


 

else  

{  

// Update window working
 area size  


 

SystemParametersInfo(SPI_SETWORKAREA, 0, &rtDesktop,
 SPIF_UPDATEINIFILE);  

 

// Restore the TaskBar  

if (NULL != hWndTaskBar)  

{  

MoveWindow(hWndTaskBar,   

rtTaskBar.left,   

rtTaskBar.top,  


 

rtTaskBar.right - rtTaskBar.left,  

rtTaskBar.bottom - rtTaskBar.top,  

false);  

}  

}  


 

}  


 

__except(EXCEPTION_EXECUTE_HANDLER)  

{  

// PUT YOUR ERROR LOG
CODING HERE  


 

 

// Set return value  

Result = 1;  

}  


 

 

return Result;  

}
