#! /bin/bash/

#让环境变量生效
source ../config/set_env.sh

#在脚本头部，定义脚本的输入
db_name=wangliming
db_table=weibo_stopwords

$HIVE -e "
  use $db_name;
  CREATE external TABLE $db_table(
  word string
)
comment 'weibo stopwords'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS textfile;
"
