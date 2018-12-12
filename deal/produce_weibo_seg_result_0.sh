#! /bin/bash

source ../config/set_env.sh

#设置所使用数据库
db_name=wangliming
#设置jar包位置
jar_path="/home/wangliming/yuqing_hot_mining/udf/YuqingHotMining-jar-with-dependencies.jar"
#设置udf classpath
class_path="cn.tledu.job004.udf.CwsUDF"
#数据的来源表
from_table=weibo_product
#要生成的数据表
to_table=weibo_seg_result
#发起执行hql脚本
$HIVE -e "
        use $db_name;
        set hive.exec.dynamic.partition.mode=nonstrict;
        add jar $jar_path;
        create temporary function seg as '$class_path';
        from $from_table
        insert overwrite table $to_table partition(week_seq)
select mid,retweeted_status_mid,uid,retweeted_uid,source,text,seg(text) as text_seg,geo,created_at,week_seq;
"
