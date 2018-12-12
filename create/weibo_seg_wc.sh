#! /bin/bash/

#让环境变量生效
source ../config/set_env.sh

#在脚本头部，定义脚本的输入
db_name=wangliming
db_table=weibo_seg_wc

$HIVE -e "
  use $db_name;
  CREATE TABLE $db_table(
    word string,
    freq int
)
comment 'weibo seg wc'
partitioned by (week_seq string comment 'the week sequence')
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'
STORED AS orcfile;
"
