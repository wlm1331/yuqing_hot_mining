#! /bin/bash

source ../config/set_env.sh

input_partition_week_seq=week1

db_name=wangliming
from_table=weibo_seg_wc
to_local_dir='/home/wangliming/yuqing_hot_mining/deal/download_data'

$HIVE -e "
        use $db_name;
        insert overwrite local directory '$to_local_dir'
          row format delimited fields terminated by '\t'
           select * from $from_table where week_seq='$input_partition_week_seq' 
             order by freq desc limit 100;
"
