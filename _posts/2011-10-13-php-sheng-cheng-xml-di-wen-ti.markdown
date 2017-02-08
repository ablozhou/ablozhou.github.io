---
author: abloz
comments: true
date: 2011-10-13 08:45:26+00:00
layout: post
link: http://abloz.com/index.php/2011/10/13/php-sheng-cheng-xml-di-wen-ti/
slug: php-sheng-cheng-xml-di-wen-ti
title: php 生成xml的问题
wordpress_id: 1459
categories:
- 技术
---

用php的DOMDocument生成了一段xml，但开头却有一空行。用libxml2分析xml时，提示：

    
    noname.xml:2: parser error : XML declaration allowed only at the start of the document
    <?xml version="1.0" encoding="utf-8"?>




php代码类似：

    
    	global $pagecount;
    	$doc = new DOMDocument("1.0","utf-8");
    	header("Content-Type: text/plain; charset=utf-8");
    
    	$root = $doc->createElement("root");
    	$doc->appendChild($root);
    	$comm = $doc->createElement("common");
    	$root->appendChild($comm);
    	$item = $doc->createElement("pagecount",$pagecount);
    	$comm->appendChild($item);
    
    	if(!empty($rows_top))
    	{
    		$top =  $doc->createElement("tops");
    		$root->appendChild($top);
    		genxml_content($rows_top,$top,$doc);
    	}
    	if(!empty($rows))
    	{
    		$item =  $doc->createElement("items");
    		$root->appendChild($item);
    		genxml_content($rows,$item,$doc);
    	}
    
    	echo $doc->saveXML();




C++语言读取代码：

    
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
    		HINTERNET hHttp = InternetOpenUrl(hSession, _T("http://localhost/fb/fbget.php?pageid=1&typeid=1"),NULL, 0, INTERNET_FLAG_DONT_CACHE, 0);
    		if (hHttp != NULL){
    
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
    				//InternetCloseHandle(hRequest);
    			}
    			//InternetCloseHandle(hConnection);
    		}
    		InternetCloseHandle(hSession);
    
    	cout<<html;
    
    }




libxml分析类似：

    
    xmlXPathObjectPtr GetNodeset (xmlDocPtr doc, xmlChar *xpath){
    
    	xmlXPathContextPtr context;
    	xmlXPathObjectPtr result;
    
    	context = xmlXPathNewContext(doc);
    	if (context == NULL) {
    		//TKWriteLog("Error in xmlXPathNewContextn");
    		return NULL;
    	}
    	result = xmlXPathEvalExpression(xpath, context);
    	xmlXPathFreeContext(context);
    	if (result == NULL) {
    		//TKWriteLog("Error in xmlXPathEvalExpressionn");
    		return NULL;
    	}
    	if(xmlXPathNodeSetIsEmpty(result->nodesetval)){
    		xmlXPathFreeObject(result);
    		//TKWriteLog("No resultn");
    		return NULL;
    	}
    	return result;
    }



    
    int ParseData(const char* xml, int len, char* outdata, int& outlen, int& pagecount, int &msgcount)
    {
    	xmlDocPtr doc = NULL;
    	xmlNodeSetPtr nodeset;
    	xmlXPathObjectPtr result;



    
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
    	result = GetNodeset(doc,BAD_CAST "//common");...


结果分析xml时报如题错误。

原来，php文件的包含文件里，<?php 前面不小心有一空行，竟然出这么大问题。xml格式太严格了。


