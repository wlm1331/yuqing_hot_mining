#! /bin/bash

source ../config/set_env.sh

db_name=wangliming
tb_input='weibo_origin'
tb_output='weibo_product'

$HIVE -e "
    use $db_name;
      set hive.exec.dynamic.partition.mode=nonstrict;
      from $tb_input
      insert overwrite table $tb_output
      partition(week_seq) select * where mid!='mid';
"
