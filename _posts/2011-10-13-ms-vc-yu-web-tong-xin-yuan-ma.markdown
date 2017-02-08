---
author: abloz
comments: true
date: 2011-10-13 12:34:24+00:00
layout: post
link: http://abloz.com/index.php/2011/10/13/ms-vc-yu-web-tong-xin-yuan-ma/
slug: ms-vc-yu-web-tong-xin-yuan-ma
title: ms vc++与web通信源码
wordpress_id: 1462
categories:
- 技术
---

服务器采用php完成，生成xml文件。

客户端采用C++完成，读取xml数据，再生成二进制数据，采用protocal buf 往android手机客户端发数据。这样可以节省大量访问网络的带宽。

C++代码采用libxml2和wininet库来访问网络和解析xml。

C++源码：

    
    // testhttp.cpp : 定义控制台应用程序的入口点。
    //
    
    #include "stdafx.h"
    #include "testhttp.h"
    #include <WinInet.h>
    #include <string>
    #include <tchar.h>
    
    #include <libxml/parser.h>
    #include <libxml/tree.h>
    
    #include <libxml/xpath.h>
    #include <libxml/xpathInternals.h>
    #define TK_BUFLEN_NICKNAME 20
    #define TOPMSG 1
    #ifdef _DEBUG
    #define new DEBUG_NEW
    #endif
    #pragma comment(lib, "Wininet.lib") 
    #pragma comment(lib, "libxml2.lib") 
    // 唯一的应用程序对象
    
    CWinApp theApp;
    
    using namespace std;
    /*
    void ReadRespBuff(HINTERNET hRequest)
    {
    	BOOL bVerbose = TRUE;
    	BOOL bAllDone = FALSE;
    	char lpReadBuff[256];
    
    	do
    	{
    		INTERNET_BUFFERS InetBuff;
    		FillMemory(&InetBuff, sizeof(InetBuff), 0);
    		InetBuff.dwStructSize = sizeof(InetBuff);
    		InetBuff.lpvBuffer = lpReadBuff;
    		InetBuff.dwBufferLength = sizeof(lpReadBuff) - 1;
    
    		if (bVerbose)
    		{
    			cout << "Calling InternetReadFileEx" << endl;
    			cout.flush();
    		}
    		if (!InternetReadFileEx(hRequest,
    			&InetBuff,
    			0, 2))
    		{
    			if (GetLastError() == ERROR_IO_PENDING)
    			{
    				if (bVerbose)
    				{
    					cout << "Waiting for InternetReadFileEx to complete" << endl;
    					cout.flush();
    				}
    				Sleep(3000);
    
    			}
    			else
    			{
    				cout << "InternetReadFileEx failed, error " << GetLastError();
    				cout.flush();
    				return;
    			}
    		}
    		lpReadBuff[InetBuff.dwBufferLength] = 0;
    		cout << lpReadBuff;
    		cout.flush();
    		if (InetBuff.dwBufferLength == 0) 
    			bAllDone = TRUE;
    	} while (bAllDone == FALSE);
    }
    */
    #define MAXSIZE 4096
    
    typedef struct PaoxiaoMsgTag
    {
    	int 	postid;
    	int		userid;
    	char 	nickname[TK_BUFLEN_NICKNAME];
    	int		agree;
    	int		disagree;
    	int		ctime;
    	//int		mtime;
    	//int		point;
    	int		flag;//0 :default,1: on top
    	//int		parentpostid;
    	int		iclen;
    	char 	content[0];
    }PaoxiaoMsg,*pPaoxiaoMsg;
    
    xmlXPathObjectPtr GetNodeset (xmlDocPtr doc, xmlChar *xpath){
    
    	xmlXPathContextPtr context;
    	xmlXPathObjectPtr result;
    
    	context = xmlXPathNewContext(doc);
    	if (context == NULL) {
    
    		return NULL;
    	}
    	result = xmlXPathEvalExpression(xpath, context);
    	xmlXPathFreeContext(context);
    	if (result == NULL) {
    
    		return NULL;
    	}
    	if(xmlXPathNodeSetIsEmpty(result->nodesetval)){
    		xmlXPathFreeObject(result);
    
    		return NULL;
    	}
    	return result;
    }
    
    int GenItemsData(xmlNodeSetPtr nodeset, char* outdata, int& outlen, int msgtype = 0)
    {
    	pPaoxiaoMsg pMsg = (pPaoxiaoMsg)outdata;
    	char *cur = outdata;
    	int iCur  = 0;
    	for (int i=0; i < nodeset->nodeNr; i++) {
    		xmlNodePtr curNode = nodeset->nodeTab[i]->xmlChildrenNode; //item->child
    		int iclen = 0;
    		pMsg->flag = msgtype;
    		while(curNode != NULL)
    		{
    
    			if(xmlStrcmp(curNode->name, (const xmlChar *)"postid") == 0)
    			{
    				pMsg->postid = atoi((const char*)curNode->children->content);
    			}
    			else if(xmlStrcmp(curNode->name, (const xmlChar *)"userid") == 0)
    			{
    				pMsg->userid = atoi((const char*)curNode->children->content);
    			}
    			else if(xmlStrcmp(curNode->name, (const xmlChar *)"nickname") == 0)
    			{
    				strncpy(pMsg->nickname,(const char*)curNode->children->content,TK_BUFLEN_NICKNAME);
    			}
    			else if(xmlStrcmp(curNode->name, (const xmlChar *)"agree") == 0)
    			{
    				pMsg->agree = atoi((const char*)curNode->children->content);
    			}
    			else if(xmlStrcmp(curNode->name, (const xmlChar *)"disagree") == 0)
    			{
    				pMsg->disagree = atoi((const char*)curNode->children->content);
    			}
    			else if(xmlStrcmp(curNode->name, (const xmlChar *)"ctime") == 0)
    			{
    				pMsg->ctime = atoi((const char*)curNode->children->content);
    			}
    			else if(xmlStrcmp(curNode->name, (const xmlChar *)"content") == 0)
    			{
    				iclen = strlen((const char*)curNode->children->content)+1;
    				strncpy(pMsg->content,(const char*)curNode->children->content,iclen);
    				pMsg->iclen = iclen;
    			}
    
    			curNode = curNode->next;
    
    		}
    		cur = cur+sizeof(PaoxiaoMsg)+iclen;
    		pMsg = (pPaoxiaoMsg)cur;
    
    	}
    
    	outlen = cur - outdata;
    	return 0;
    }
    int ParseData(const char* xml, int len, char* outdata, int& outlen, int& pagecount, int &msgcount)
    {
    	xmlDocPtr doc = NULL;
    	xmlNodeSetPtr nodeset;
    	xmlXPathObjectPtr result;
    	pPaoxiaoMsg pMsg = (pPaoxiaoMsg)outdata;
    	char *cur = outdata;
    	int iLen  = 0;
    	int tmpLen = 0;
    	pagecount = 0;
    	msgcount = 0;
    
    	char value[MAX_PATH];
    	value[0] = 0;
    	xmlXPathContextPtr xpathCtx = NULL; 
    	int ret = 0;
    	if ( outdata == NULL || len <= 0 )
    		goto Out;
    	doc = xmlReadMemory(xml, len, "noname.xml", "utf-8", 0);
    	if ( !doc )
    		goto Out;
    	xpathCtx = xmlXPathNewContext(doc);
    	if ( xpathCtx == NULL )
    		goto Out;
    
    	//xmlXPathObjectPtr xpathObj = xmlXPathEvalexpression((const xmlChar*)("//*"), xpathCtx);
    	result = GetNodeset(doc,BAD_CAST "//common/");
    	if(result)
    	{
    		nodeset = result->nodesetval;
    	}
    	xmlNodePtr curNode = nodeset->nodeTab[0]->xmlChildrenNode; //item->child
    	if(curNode != NULL)
    	{
    
    		if(xmlStrcmp(curNode->name, (const xmlChar *)"pagecount") == 0)
    		{
    			pagecount = atoi((const char*)curNode->children->content);
    		}
    	}
    	result = GetNodeset(doc,BAD_CAST "//tops/item");
    	if (result) {
    		nodeset = result->nodesetval;
    		msgcount +=nodeset->nodeNr;
    		GenItemsData(nodeset,cur,tmpLen,TOPMSG);
    	}
    	cur += tmpLen;
    	iLen += tmpLen;
    	result = GetNodeset(doc,BAD_CAST "//items/item");
    	if (result) {
    		nodeset = result->nodesetval;
    		msgcount +=nodeset->nodeNr;
    		GenItemsData(nodeset,cur,tmpLen);
    	}
    	iLen += tmpLen;
    
    	outlen = iLen;
    
    Out:
    	if ( xpathCtx )
    	{
    		xmlXPathFreeContext(xpathCtx);
    		xpathCtx = NULL;
    	}
    	if ( doc )
    	{
    		xmlFreeDoc(doc);
    		doc = NULL;
    	}
    
    	return 0;
    }
    
    void PostHttpRequest(LPCTSTR url, LPCTSTR param)
    {
    	string html;
    	HINTERNET hSession = InternetOpen(_T("paoxiao"), 
    
    		INTERNET_OPEN_TYPE_PRECONFIG, //PRE_CONFIG_INTERNET_ACCESS
    		NULL,
    		INTERNET_INVALID_PORT_NUMBER,
    		0);
    	if ( hSession != NULL )
    	{
    
    		HINTERNET hHttp = InternetOpenUrl(hSession, url,NULL, 0, INTERNET_FLAG_DONT_CACHE, 0);
    		if (hHttp != NULL){
    			//wprintf_s(_T("%sn"), url);
    
    			char Temp[MAXSIZE];
    			ULONG Number = 1;
    			while (Number > 0){
    				InternetReadFile(hHttp, Temp, MAXSIZE - 1, &Number);
    				Temp[Number] = '\0';
    				html=html+Temp;
    				int outlen,pagecount,msgcount;
    				memset(Temp,0,MAXSIZE);
    				ParseData(html.c_str(),html.size(),Temp,outlen,pagecount,msgcount);
    			}
    
    			}
    
    		}
    		InternetCloseHandle(hSession);
    
    	cout<<html;
    
    }
    int _tmain(int argc, TCHAR* argv[], TCHAR* envp[])
    {
    	int nRetCode = 0;
    
    	HMODULE hModule = ::GetModuleHandle(NULL);
    
    	if (hModule != NULL)
    	{
    		// 初始化 MFC 并在失败时显示错误
    		if (!AfxWinInit(hModule, NULL, ::GetCommandLine(), 0))
    		{
    			// TODO: 更改错误代码以符合您的需要
    			_tprintf(_T("错误: MFC 初始化失败n"));
    			nRetCode = 1;
    		}
    		else
    		{
    			// TODO: 在此处为应用程序的行为编写代码。
    			//PostHttpRequest(_T("http://www.baidu.com"),NULL);
    
    			PostHttpRequest(_T("http://localhost/fb/fbget.php?pageid=1&typeid=1"),NULL);
    		}
    	}
    	else
    	{
    		// TODO: 更改错误代码以符合您的需要
    		_tprintf(_T("错误: GetModuleHandle 失败n"));
    		nRetCode = 1;
    	}
    
    	return nRetCode;
    }




xml文件：

    
      <?xml version="1.0" encoding="utf8" ?>
     <root>
     <common>
      <pagecount>2</pagecount>
      </common>
     <items>
     <item>
      <postid>175</postid>
      <userid>1</userid>
      <nickname>admin</nickname>
      <content>什么内容？通知</content>
      <agree>0</agree>
      <disagree>0</disagree>
      <ctime>1317363746</ctime>
      </item>
     <item>
      <postid>174</postid>
      <userid>1</userid>
      <nickname>admin</nickname>
      <content>asfasdfsadfasdf</content>
      <agree>0</agree>
      <disagree>0</disagree>
      <ctime>1317299907</ctime>
      </item>
     <item>
      <postid>172</postid>
      <userid>1</userid>
      <nickname>admin</nickname>
      <content>你好，你好'or'1=1'</content>
      <agree>1</agree>
      <disagree>0</disagree>
      <ctime>1316679960</ctime>
      </item>
     <item>
      <postid>171</postid>
      <userid>1</userid>
      <nickname>admin</nickname>
      <content><hr> <p>你好</p><br/>当然</content>
      <agree>0</agree>
      <disagree>0</disagree>
      <ctime>1316679689</ctime>
      </item>
     <item>
      <postid>169</postid>
      <userid>1</userid>
      <nickname>admin</nickname>
      <content>想咆哮？!!!来吧!</content>
      <agree>0</agree>
      <disagree>0</disagree>
      <ctime>1316514109</ctime>
      </item>
      </items>
      </root>





