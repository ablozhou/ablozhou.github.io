---
author: abloz
comments: true
date: 2012-12-14 03:35:41+00:00
layout: post
link: http://abloz.com/index.php/2012/12/14/the-hbase-0-94-master-boot-process-source-code-analysis/
slug: the-hbase-0-94-master-boot-process-source-code-analysis
title: HBase 0.94 master启动过程源码分析
wordpress_id: 2009
categories:
- 技术
tags:
- hadoop
- hbase
---

HBase 0.94 master启动过程源码分析
周海汉
http://abloz.com

[zhouhh@Hadoop48 bin]$ pwd
/home/zhouhh/hbase-0.94.0/bin
[zhouhh@Hadoop48 bin]$ vi hbase
shell中开始准备java和hadoop，hbase的环境，然后处理传入的参数。如果参数是"master"，则类是org.apache.hadoop.hbase.master.HMaster
270 elif [ "$COMMAND" = "master" ] ; then
271   CLASS='org.apache.hadoop.hbase.master.HMaster'
272   if [ "$1" != "stop" ] ; then
273     HBASE_OPTS="$HBASE_OPTS $HBASE_MASTER_OPTS"
274   fi
275 elif [ "$COMMAND" = "regionserver" ] ; then
276   CLASS='org.apache.hadoop.hbase.regionserver.HRegionServer'
277   if [ "$1" != "stop" ] ; then
278     HBASE_OPTS="$HBASE_OPTS $HBASE_REGIONSERVER_OPTS"
279   fi
280 elif [ "$COMMAND" = "thrift" ] ; then
281   CLASS='org.apache.hadoop.hbase.thrift.ThriftServer'
282   if [ "$1" != "stop" ] ; then
283     HBASE_OPTS="$HBASE_OPTS $HBASE_THRIFT_OPTS"
284   fi

328 # Exec unless HBASE_NOEXEC is set.
执行程序，简化一下就是java HMaster "$@"
329 if [ "${HBASE_NOEXEC}" != "" ]; then
330   "$JAVA" -XX:OnOutOfMemoryError="kill -9 %p" $JAVA_HEAP_MAX $HBASE_OPTS -classpath "$CLASSPATH" $CLASS "$@"
331 else
332   exec "$JAVA" -XX:OnOutOfMemoryError="kill -9 %p" $JAVA_HEAP_MAX $HBASE_OPTS -classpath "$CLASSPATH" $CLASS "$@"
333 fi


[zhouhh@Hadoop48 master]$ pwd
/home/zhouhh/hbase-0.94.0/src/main/java/org/apache/hadoop/hbase/master
hbase shell脚本会调用到HMaster.java的main(),该函数执行HMasterCommandLine的doMain(),并将HMaster作为参数传入。最终调用到HMaster的父类HasThread.start(),然后调用到HMaster.run(),becomeActiveMaster(),抢先向Zookeeper注册成Master，启动完毕
[zhouhh@Hadoop48 master]$ vi HMaster.java
这是HMaster 源代码入口
1752   public static void main(String [] args) throws Exception {
1753     VersionInfo.logVersion();
1754     new HMasterCommandLine(HMaster.class).doMain(args);
1755   }
HMasterCommandLine的doMain会调用到其父类ServerCommandLine的doMain，ServerCommandLine又是Tool接口的子类，实现了run函数，
[zhouhh@Hadoop48 master]$ vi HMasterCommandLine.java
 44 public class HMasterCommandLine extends ServerCommandLine {

 66   public int run(String args[]) throws Exception {
 94     List remainingArgs = cmd.getArgList();
 72     CommandLine cmd;

 74       cmd = new GnuParser().parse(opt, args);

100     String command = remainingArgs.get(0);
101
start 参数，调用startMaster()函数
102     if ("start".equals(command)) {
103       return startMaster();
104     } else if ("stop".equals(command)) {
105       return stopMaster();
106     } else {
107       usage("Invalid command: " + command);
108       return -1;
109     }
110   }

112   private int startMaster() {
113     Configuration conf = getConf();
114     try {
115       // If 'local', defer to LocalHBaseCluster instance.  Starts master
116       // and regionserver both in the one JVM.

117       if (LocalHBaseCluster.isLocal(conf)) {
启动本地HBase的HMaster
118         final MiniZooKeeperCluster zooKeeperCluster =
119           new MiniZooKeeperCluster();
120         File zkDataPath = new File(conf.get(HConstants.ZOOKEEPER_DATA_DIR));
121         int zkClientPort = conf.getInt(HConstants.ZOOKEEPER_CLIENT_PORT, 0);
122         if (zkClientPort == 0) {
123           throw new IOException("No config value for "
124               + HConstants.ZOOKEEPER_CLIENT_PORT);
125         }
126         zooKeeperCluster.setDefaultClientPort(zkClientPort);
127         int clientPort = zooKeeperCluster.startup(zkDataPath);
128         if (clientPort != zkClientPort) {
129           String errorMsg = "Could not start ZK at requested port of " +
130             zkClientPort + ".  ZK was started at port: " + clientPort +
131             ".  Aborting as clients (e.g. shell) will not be able to find " +
132             "this ZK quorum.";
133           System.err.println(errorMsg);
134           throw new IOException(errorMsg);
135         }
136         conf.set(HConstants.ZOOKEEPER_CLIENT_PORT,
137                  Integer.toString(clientPort));
138         // Need to have the zk cluster shutdown when master is shutdown.
139         // Run a subclass that does the zk cluster shutdown on its way out.
140         LocalHBaseCluster cluster = new LocalHBaseCluster(conf, 1, 1,
141                                                           LocalHMaster.class, HRegionServer.class);
142         ((LocalHMaster)cluster.getMaster(0)).setZKCluster(zooKeeperCluster);
143         cluster.startup();
144         waitOnMasterThreads(cluster);
145       } else {
启动分布式HBase master，masterClass正是传入的HMaster.java的HMaster类，所以会调用到HMaster.start();
146         HMaster master = HMaster.constructMaster(masterClass, conf);
147         if (master.isStopped()) {
148           LOG.info("Won't bring the Master up as a shutdown is requested");
149           return -1;
150         }
151         master.start();
152         master.join();
153         if(master.isAborted())
154           throw new RuntimeException("HMaster Aborted");
155       }
156     } catch (Throwable t) {
157       LOG.error("Failed to start master", t);
158       return -1;
159     }
160     return 0;
161   }

234 }

[zhouhh@Hadoop48 util]$ pwd
/home/zhouhh/hbase-0.94.0/src/main/java/org/apache/hadoop/hbase/util
[zhouhh@Hadoop48 util]$ vi ServerCommandLine.java

 33 /**
 34  * Base class for command lines that start up various HBase daemons.
 35  */
 36 public abstract class ServerCommandLine extends Configured implements Tool {
 doMain函数调用ToolRunner.run,因将自身传入ToolRunner，ToolRunner.run会调用所传入的Tool的run函数，即实现在ServerCommandLine子类HMasterCommandLine的run函数，从而调用到HMasterCommandLine.startMaster
 75   public void doMain(String args[]) throws Exception {
 76     int ret = ToolRunner.run(
 77       HBaseConfiguration.create(), this, args);
 78     if (ret != 0) {
 79       System.exit(ret);
 80     }
 81   }
 82 }


[zhouhh@Hadoop48 util]$ pwd
/home/zhouhh/hadoop-1.0.3/src/core/org/apache/hadoop/util

[zhouhh@Hadoop48 util]$ vi ToolRunner.java
ToolRunner 作用，提供一个分析参数和配置，并调用Tool.run的接口
 39 public class ToolRunner {
 54   public static int run(Configuration conf, Tool tool, String[] args)
 55     throws Exception{
 59     GenericOptionsParser parser = new GenericOptionsParser(conf, args);
 60     //set the configuration back, so that Tool can configure itself
 61     tool.setConf(conf);
 62
 63     //get the args w/o generic hadoop args
 64     String[] toolArgs = parser.getRemainingArgs();
 65     return tool.run(toolArgs);
 66   }

[zhouhh@Hadoop48 util]$ vi Tool.java
Tool 提供统一run接口
 70 public interface Tool extends Configurable {
 78   int run(String [] args) throws Exception;
 79 }

