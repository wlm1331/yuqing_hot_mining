#! /bin/bash

source ../config/set_env.sh

db_name=wangliming
from_tb=weibo_seg_result
to_tb=weibo_seg_wc

$HIVE -e "
  use $db_name;
  set hive.exec.dynamic.partition.mode=nonstrict;
  insert overwrite table $to_tb partition(week_seq)
  select word,count(1) as freq,week_seq from $from_tb
  lateral view explode(split(text_seg,'\001')) word_table as word
  where week_seq='week1' and text_seg is not null and length(word)>1
  group by week_seq,word order by freq desc;
"
