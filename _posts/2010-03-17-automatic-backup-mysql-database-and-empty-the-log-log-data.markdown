---
author: abloz
comments: true
date: 2010-03-17 06:05:00+00:00
layout: post
link: http://abloz.com/index.php/2010/03/17/automatic-backup-mysql-database-and-empty-the-log-log-data/
slug: automatic-backup-mysql-database-and-empty-the-log-log-data
title: 自动备份mysql数据库，并清空log日志数据
wordpress_id: 1159
categories:
- 技术
---

[周海汉](http://blog.csdn.net/ablo_zhou) /文

2010.3.17

 

mysql数据库有几个表分别记录cpu等占用信息的日志，有大量记录。这些日志对于定位问题很重要，但如果没有问题，则比较多余。运维手工清除不仅麻烦，而且容易出错。因此，写一个脚本，放到crontab里，定期备份和清除日志。

 

  1. #!/bin/sh
  2. # File: /root/bcdb.sh
  3. # Author: zhouhh
  4. # Date: 2010-3-17
  5. # Database info
  6. DB_NAME=("systemdb" "localdb")
  7. DB_USER="root"
  8. DB_PASS="xxxxxx"
  9. # Others vars
  10. BIN_DIR="/usr/bin"
  11. BCK_DIR="/var/lib/mysql/backup"
  12. SYSTABLES=("history1" "history2" "cpu_history")
  13. LOCALTABLES=("cpulog")
  14. DATE=`date +%F`
  15. #backup systemdb
  16. for db in ${DB_NAME[@]}
  17. do
  18. echo
  19. echo "backup $db to $BCK_DIR/${db}_$DATE.gz..."
  20. $BIN_DIR/mysqldump --opt -u$DB_USER -p$DB_PASS $db | gzip > "$BCK_DIR/${db}_$DATE.gz"
  21. echo "backup $db finished!"
  22. done
  23. #clear systemdb tables;
  24. echo
  25. echo "clear table logs..."
  26. for tb in ${SYSTABLES[@]}
  27. do
  28. echo "clear $tb..."
  29. $BIN_DIR/mysql -u$DB_USER -p$DB_PASS ${DB_NAME[0]} -e "truncate table $tb;"
  30. done;
  31. #clear localdb tables
  32. for tb in ${LOCALTABLES[@]}
  33. do
  34. echo "clear $tb..."
  35. $BIN_DIR/mysql -u$DB_USER -p$DB_PASS ${DB_NAME[1]} -e "truncate table $tb;"
  36. done;
  37. echo
  38. echo 'clear table logs successfully'

#!/bin/sh # File: /root/bcdb.sh # Author: zhouhh # Date: 2010-3-17 # Database info DB_NAME=("systemdb" "localdb") DB_USER="root" DB_PASS="xxxxxx" # Others vars BIN_DIR="/usr/bin" BCK_DIR="/var/lib/mysql/backup" SYSTABLES=("history1" "history2" "cpu_history") LOCALTABLES=("cpulog") DATE=`date +%F` #backup systemdb for db in ${DB_NAME[@]} do        echo        echo "backup $db to $BCK_DIR/${db}_$DATE.gz..."        $BIN_DIR/mysqldump --opt -u$DB_USER -p$DB_PASS $db | gzip > "$BCK_DIR/${db}_$DATE.gz"        echo "backup $db finished!" done #clear systemdb tables; echo echo "clear table logs..." for tb in ${SYSTABLES[@]} do        echo "clear $tb..."        $BIN_DIR/mysql -u$DB_USER -p$DB_PASS ${DB_NAME[0]} -e "truncate table $tb;" done; #clear localdb tables for tb in ${LOCALTABLES[@]} do        echo "clear $tb..."        $BIN_DIR/mysql -u$DB_USER -p$DB_PASS ${DB_NAME[1]} -e "truncate table $tb;" done; echo echo 'clear table logs successfully'   

本脚本备份systemdb和localdb两个库，并清除两个库中的表。在/var/lib/mysql中建立backup目录，脚本执行时将数据库备份到/var/lib/mysql/backup/数据库名_日期.gz

也可以在脚本中检查一下：

#check backup dir  
if ! [ -d ${BCK_DIR} ]  
then  
echo "${BCK_DIR} does not exist,create it..."  
mkdir ${BCK_DIR}  
fi

另：

清除mysql系统log，3天前/var/log/mysql  
mysql -uroot -e 'PURGE MASTER LOGS BEFORE DATE_SUB( NOW( ), INTERVAL 3 DAY);'  
#清除指定log  
PURGE MASTER LOGS TO 'mysql-bin.000930';

 

定期执行脚本：

[root@server ~]# crontab -e

增加：

00 05 */3 * * /root/bcdb.sh

每3天的凌晨5点备份清空一次。

  
  


![](http://img.zemanta.com/pixy.gif?x-id=eb7b5e88-70f2-8658-a43e-ce87875fdd18)
