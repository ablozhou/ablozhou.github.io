---
author: abloz
comments: true
date: 2013-03-04 10:53:40+00:00
layout: post
link: http://abloz.com/index.php/2013/03/04/modification-to-the-source-of-the-flume-windows-spool-dir/
slug: modification-to-the-source-of-the-flume-windows-spool-dir
title: flume windows spool dir问题源码修改
wordpress_id: 2148
categories:
- 技术
tags:
- flume-ng
- windows
---



flume-ng 1.3.1 windows可能报如下错误：

04 三月 2013 16:54:19,638 ERROR [pool-4-thread-1] (org.apache.flume.source.SpoolDirectorySource$SpoolDirectoryRunnable.run:148) - Uncaught exception in Runnable
java.lang.IllegalStateException: File name has been re-used with different files. Spooling assumption violated for D:TKServerHandResult_BakLog201303041600handresult_hllord.log.fin changed name to zhh:D:TKServerHandResult_BakLog201303041600handresult_hllord.log.zhh.fin
at org.apache.flume.client.avro.SpoolingFileLineReader.retireCurrentFile(SpoolingFileLineReader.java:282)
at org.apache.flume.client.avro.SpoolingFileLineReader.readLines(SpoolingFileLineReader.java:185)
at org.apache.flume.source.SpoolDirectorySource$SpoolDirectoryRunnable.run(SpoolDirectorySource.java:135)
at java.util.concurrent.Executors$RunnableAdapter.call(Unknown Source)
at java.util.concurrent.FutureTask$Sync.innerRunAndReset(Unknown Source)
at java.util.concurrent.FutureTask.runAndReset(Unknown Source)
at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.access$101(Unknown Source)
at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.runPeriodic(Unknown Source)
at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run(Unknown Source)
at java.util.concurrent.ThreadPoolExecutor$Worker.runTask(Unknown Source)
at java.util.concurrent.ThreadPoolExecutor$Worker.run(Unknown Source)
at java.lang.Thread.run(Unknown Source)
04 三月 2013 16:54:20,168 ERROR [pool-4-thread-1] (org.apache.flume.source.SpoolDirectorySource$SpoolDirectoryRunnable.run:148) - Uncaught exception in Runnable
java.io.IOException: Stream closed
at java.io.BufferedReader.ensureOpen(Unknown Source)
at java.io.BufferedReader.readLine(Unknown Source)
at java.io.BufferedReader.readLine(Unknown Source)
at org.apache.flume.client.avro.SpoolingFileLineReader.readLines(SpoolingFileLineReader.java:180)
at org.apache.flume.source.SpoolDirectorySource$SpoolDirectoryRunnable.run(SpoolDirectorySource.java:135)
at java.util.concurrent.Executors$RunnableAdapter.call(Unknown Source)
at java.util.concurrent.FutureTask$Sync.innerRunAndReset(Unknown Source)
at java.util.concurrent.FutureTask.runAndReset(Unknown Source)
at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.access$101(Unknown Source)
at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.runPeriodic(Unknown Source)
at java.util.concurrent.ScheduledThreadPoolExecutor$ScheduledFutureTask.run(Unknown Source)
at java.util.concurrent.ThreadPoolExecutor$Worker.runTask(Unknown Source)
at java.util.concurrent.ThreadPoolExecutor$Worker.run(Unknown Source)
at java.lang.Thread.run(Unknown Source)

修改

vi ./flume-ng-core/src/main/java/org/apache/flume/client/avro/SpoolingFileLineReader.java +180

//zhh add try catch for IOException: Stream closed
String outLine = null;
try{
outLine = currentFile.get().getReader().readLine();
} catch (IOException e) {
logger.error("Exception reading file: " + currentFile.get().getFile().getAbsolutePath(), e);

}



#271

//zhh
String newZhhPath =currPath +".zhh"+ completedSuffix;
boolean renamed = newFile.renameTo(new File(newZhhPath));
if (!renamed) {
/* If we are here then the file cannot be renamed for a reason other
* than that the destination file exists (actually, that remains
* possible w/ small probability due to TOC-TOU conditions).*/
String message = "Unable to move " + currPath + " to " + newZhhPath +
". This will likely cause duplicate events. Please verify that " +
"flume has sufficient permissions to perform these operations.";
throw new FlumeException(message);
}

String message = "File name has been re-used with different" +
" files. Spooling assumption violated for " + newPath+
" changed name to zhh:"+newZhhPath;
logger.info(message);

}



diff文件

180,181c180,187
< String outLine = currentFile.get().getReader().readLine();
<
---
> //zhh add try catch for IOException: Stream closed
> String outLine = null;
> try{
> outLine = currentFile.get().getReader().readLine();
> } catch (IOException e) {
> logger.error("Exception reading file: " + currentFile.get().getFile().getAbsolutePath(), e);
>
> }
264a271,283
> //zhh
> String newZhhPath =currPath +".zhh"+ completedSuffix;
> boolean renamed = newFile.renameTo(new File(newZhhPath));
> if (!renamed) {
> /* If we are here then the file cannot be renamed for a reason other
> * than that the destination file exists (actually, that remains
> * possible w/ small probability due to TOC-TOU conditions).*/
> String message = "Unable to move " + currPath + " to " + newZhhPath +
> ". This will likely cause duplicate events. Please verify that " +
> "flume has sufficient permissions to perform these operations.";
> throw new FlumeException(message);
> }
>
266,267c285,288
< " files. Spooling assumption violated for " + newPath;
< throw new IllegalStateException(message);
---
> " files. Spooling assumption violated for " + newPath+
> " changed name to zhh:"+newZhhPath;
> logger.info(message);
>
320a342,346
> //add by zhouhh

> if(!nextFile.renameTo(nextFile)){
> logger.info("zhh:The file is writing,try again:"+ nextFile);
> return Optional.absent();
> }
361a388
>


