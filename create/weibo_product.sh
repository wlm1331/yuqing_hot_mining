#! /bin/bash/

#让环境变量生效
source ../config/set_env.sh

#在脚本头部，定义脚本的输入
db_name=wangliming
db_table=weibo_product

$HIVE -e "
  use $db_name;
  CREATE TABLE $db_table(
  mid string,
  retweeted_status_mid string,
  uid string,
  retweeted_uid string,
  source string,
  image string,
  text string,
  geo string,
  created_at string,
  deleted_last_seen string,
  permission_denied string
)
comment 'weibo content table'
partitioned by (week_seq string comment 'the week sequence')
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
STORED AS orcfile;
"
