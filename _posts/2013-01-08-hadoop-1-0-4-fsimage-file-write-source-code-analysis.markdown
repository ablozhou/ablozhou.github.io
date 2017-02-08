---
author: abloz
comments: true
date: 2013-01-08 10:55:33+00:00
layout: post
link: http://abloz.com/index.php/2013/01/08/hadoop-1-0-4-fsimage-file-write-source-code-analysis/
slug: hadoop-1-0-4-fsimage-file-write-source-code-analysis
title: hadoop 1.0.3 fsimage 文件写源码分析
wordpress_id: 2063
categories:
- 技术
tags:
- fsimage
- hadoop
---

周海汉 2013.1.8
上一篇文章《[hadoop 1.0.4 fsimage 文件格式分析](http://abloz.com/2013/01/08/hadoop-1-0-4-fsimage-file-format.html)》描述了hadoop1.04的fsimage的格式。
本篇看看hadoop 1.0.3源码是如何实现的。fsimage格式 1.04和1.03之间没有差别。


    
    
    public interface FSConstants {
    public static int MAX_PATH_LENGTH = 8000;
      public static final int LAYOUT_VERSION = -32;
    }
    


FSImage.java (hadoop-1.0.3srchdfsorgapachehadoophdfsservernamenode)	66286	2012/5/9

    
    
    public class FSImage extends Storage {
    
     /**
       * Save the contents of the FS image to the file.
       */
      void saveFSImage(File newFile) throws IOException {
        FSNamesystem fsNamesys = FSNamesystem.getFSNamesystem();
        FSDirectory fsDir = fsNamesys.dir;
        long startTime = FSNamesystem.now();
        //
        // Write out data
        //
        DataOutputStream out = new DataOutputStream(
                                                    new BufferedOutputStream(
                                                                             new FileOutputStream(newFile)));
        try {
          out.writeInt(FSConstants.LAYOUT_VERSION);
          out.writeInt(namespaceID);
          out.writeLong(fsDir.rootDir.numItemsInTree());
          out.writeLong(fsNamesys.getGenerationStamp());
          byte[] byteStore = new byte[4*FSConstants.MAX_PATH_LENGTH];
          ByteBuffer strbuf = ByteBuffer.wrap(byteStore);
          // save the root
          saveINode2Image(strbuf, fsDir.rootDir, out);
          // save the rest of the nodes
          saveImage(strbuf, 0, fsDir.rootDir, out);
          fsNamesys.saveFilesUnderConstruction(out);
          fsNamesys.saveSecretManagerState(out);
          strbuf = null;
        } finally {
          out.close();
        }
    
        LOG.info("Image file of size " + newFile.length() + " saved in "
            + (FSNamesystem.now() - startTime)/1000 + " seconds.");
      }
    /*
       * Save one inode's attributes to the image.
       */
      private static void saveINode2Image(ByteBuffer name,
                                          INode node,
                                          DataOutputStream out) throws IOException {
        int nameLen = name.position();
        out.writeShort(nameLen);
        out.write(name.array(), name.arrayOffset(), nameLen);
        if (!node.isDirectory()) {  // write file inode
          INodeFile fileINode = (INodeFile)node;
          out.writeShort(fileINode.getReplication());
          out.writeLong(fileINode.getModificationTime());
          out.writeLong(fileINode.getAccessTime());
          out.writeLong(fileINode.getPreferredBlockSize());
          Block[] blocks = fileINode.getBlocks();
          out.writeInt(blocks.length);
          for (Block blk : blocks)
            blk.write(out);
          FILE_PERM.fromShort(fileINode.getFsPermissionShort());
          PermissionStatus.write(out, fileINode.getUserName(),
                                 fileINode.getGroupName(),
                                 FILE_PERM);
        } else {   // write directory inode
          out.writeShort(0);  // replication
          out.writeLong(node.getModificationTime());
          out.writeLong(0);   // access time
          out.writeLong(0);   // preferred block size
          out.writeInt(-1);    // # of blocks
          out.writeLong(node.getNsQuota());
          out.writeLong(node.getDsQuota());
          FILE_PERM.fromShort(node.getFsPermissionShort());
          PermissionStatus.write(out, node.getUserName(),
                                 node.getGroupName(),
                                 FILE_PERM);
        }
      }
    }
    


PermissionStatus.java (hadoop-1.0.3srccoreorgapachehadoopfspermission)	3683	2012/5/9

    
    
    public class PermissionStatus implements Writable {
      public static void write(DataOutput out,
                               String username,
                               String groupname,
                               FsPermission permission) throws IOException {
        Text.writeString(out, username);
        Text.writeString(out, groupname);
        permission.write(out);
      }
    }
    public class FsPermission implements Writable {
      public void write(DataOutput out) throws IOException {
        out.writeShort(toShort());
      }
    }
    


Block.java (hadoop-1.0.3srchdfsorgapachehadoophdfsprotocol)	5055	2012/5/9

    
    
    public class Block implements Writable, Comparable<block> {
      public void write(DataOutput out) throws IOException {
        out.writeLong(blockId);
        out.writeLong(numBytes);
        out.writeLong(generationStamp);
      }
    }
    
