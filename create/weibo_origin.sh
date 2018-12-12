#! /bin/bash
#让环境变量生效
source ../config/set_env.sh

#在脚本头部，定义脚本输出
db_name=wangliming
table_name=weibo_origin

$HIVE -e "
  use $db_name;
  CREATE external TABLE $table_name(
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
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'
STORED AS textfile;
"
