# 源数据中所有的系统简称
```sql
select distinct 
	lower(substring(dmod_en_name,1,locate('.',dmod_en_name)-1)) as '系统简称' 
from source_meta_tables_detail 
order by '系统简称'
;

select distinct 
	lower(substring(dmod_en_name,1,locate('.',dmod_en_name)-1)) as '系统简称' 
from tn_meta_dmod_col_info 
order by '系统简称'
;
```

# 提供的系统简称
```sql
select 
	ods_name as 'ods库名',
	jdbc_name as 'jdbc名',
	gkpt_name as '管控平台简称',
	system_comment as '说明'
from dim_system_shortname 
order by gkpt_name 
;
```

# 提供的调度文件列表
```sql
select distinct 
	file_name as '文件名',
    replace(replace(file_name, 'P_', ''), '.xlsx', '') as '拆分出的系统简称'
from azkaban_detail 
order by file_name 
;
```

# 特例表
```sql
select 
	match_rule as '匹配规则',
	exclude_type as '排除类型',
	exclude_reason as '排除原因' 
from dim_exclude_detail 
order by exclude_type 
;
```

# 数据库梳理过程
```sql
select 
	database_info as '数据库信息',
	analysis_type as '分析类型',
	analysis_name as '分析结果名',
	analysis_comment as '备注'
from dim_analysis_process 
order by analysis_type
;
```

# 没有调度的ods表
```sql
select distinct 
	file_addr as 'ods_sql路径',
    table_name as 'ods_sql表名'
from analysis_azkaban_ods_sql 
where is_match_azkaban = 0 
order by table_name
;
```

# 重复调用之stg_shell
```sql
select
	file_addr as '文件路径',
	file_name as '文件名',
	source_table_name as '源表名',
	stg_table_name as 'stg表名',
	azkaban_file_name as '调度文件名',
	is_match_azkaban as '是否有调度',
	azkaban_job_name as 'job名'
from analysis_azkaban_stg_shell 
where source_table_name in (
	select source_table_name from stg_shell_detail group by source_table_name having count(1) > 1
)
order by source_table_name 
;
```

# 重复调用之ods_shell
```sql
select
	file_addr as '文件路径',
	file_name as '文件名',
	stg_table_name as 'stg表名',
	ods_table_name as 'ods表名',
	azkaban_file_name as '调度文件名',
	is_match_azkaban as '是否有调度',
	azkaban_job_name as 'job名'
from analysis_azkaban_ods_shell 
where ods_table_name in (
	select ods_table_name from ods_shell_detail group by ods_table_name having count(1) > 1
) and stg_table_name <> '.'
order by ods_table_name 
;
```

# 重复调用之hive_file
```sql
select
	file_addr as '文件路径',
	file_name as '文件名',
	ods_table_name as 'ods表名',
	azkaban_file_name as '调度文件名',
	is_match_azkaban as '是否有调度',
	azkaban_job_name as 'job名'
from analysis_azkaban_hive_file 
where ods_table_name in (
	select ods_table_name from hive_file_detail group by ods_table_name having count(1) > 1
)
order by ods_table_name 
;
```


# 重复调用之azkaban
```sql 
select 
	tt1.file_name as '文件名',
	tt1.parse_type as '解析类型',
	tt1.sub_file_name as '子文件名',
	tt1.job_name as 'job名',
	tt1.command as '命令'
from (
	select
	    t1.file_name,
	    t1.parse_type,
	    t1.sub_file_name,
	    t1.job_name,
	    t1.command,
	    sum((case when t1.sub_file_name like concat(t2.match_rule,'%') then 1 else 0 end)) as is_exclude 
	from azkaban_detail t1 
	left join (select distinct match_rule from dim_exclude_detail where exclude_type = 'azkaban') t2 on 1 = 1
	where t1.sub_file_name in (
		select sub_file_name from azkaban_detail group by sub_file_name having count(1) > 1
	)
	group by t1.file_name,t1.parse_type,t1.sub_file_name,t1.job_name,t1.command 
) tt1 
where tt1.is_exclude = 0 
order by tt1.sub_file_name 
;
```

# ods_sql与源数据比对
## ods_sql与源数据表名不一致
```sql
select  
	ods_shell_file_addr as 'ods_shell路径',
	ods_shell_file_name as 'ods_shell文件名',
	ods_shell_ods_name as 'ods_shell-ods表名',
	stg_shell_xtjc as 'stg_shell系统简称',
	stg_shell_source_table_name as 'stg_shell源表名',
	full_stg_shell_source_table_name as '系统简称_stg_shell源表名',
	source_table_name as '源数据表名',
	ods_table_name_is_match as 'ods表名是否匹配',
	source_table_name_is_match as '源表名是否匹配'
from analysis_ods_source_meta_columns_count
where ods_table_name_is_match = 0 or source_table_name_is_match = 0 
order by stg_shell_source_table_name
;
```

## ods_sql与源数据表注释不一致
```sql
select  
	ods_shell_file_addr as 'ods_shell路径',
	ods_shell_file_name as 'ods_shell文件名',
	ods_shell_ods_name as 'ods_shell-ods表名',
	stg_shell_xtjc as 'stg_shell系统简称',
	stg_shell_source_table_name as 'stg_shell源表名',
	full_stg_shell_source_table_name as '系统简称_stg_shell源表名',
	source_table_name as '源数据表名',
	ods_table_name_is_match as 'ods表名是否匹配',
	source_table_name_is_match as '源表名是否匹配',
	ods_sql_table_comment as 'ods表名注释',
	source_table_comment as '源表注释',
	table_comment_is_match as '注释是否匹配'
from analysis_ods_source_meta_columns_count
where ods_table_name_is_match = 1 and source_table_name_is_match = 1 and table_comment_is_match = 0
order by stg_shell_source_table_name
;
```

## ods_sql与源数据字段数不一致
```sql
select distinct 
	ods_shell_file_addr as 'ods_shell路径',
	ods_shell_file_name as 'ods_shell文件名',
	ods_shell_ods_name as 'ods_shell-ods表名',
	stg_shell_xtjc as 'stg_shell系统简称',
	stg_shell_source_table_name as 'stg_shell源表名',
	full_stg_shell_source_table_name as '系统简称_stg_shell源表名',
	source_table_name as '源数据表名',
	ods_table_name_is_match as 'ods表名是否匹配',
	source_table_name_is_match as '源表名是否匹配',
	ods_sql_columns_count as 'ods表字段数',
	source_columns_count as '源表字段数',
	columns_count_is_match as '字段数是否匹配'
from analysis_ods_source_meta_columns_count
where ods_table_name_is_match = 1 and source_table_name_is_match = 1 and columns_count_is_match = 0
order by stg_shell_source_table_name
;
```

## ods_sql与源数据字段名不一致
```sql
select 
	ods_sql_table_name as 'ods_sql表名',
	xtjc as '系统简称',
    stg_shell_source_table_name as 'stg_shell源表名',
    source_table_name as '源数据表名',
    table_name_is_match as '表名是否匹配',
    ods_sql_column_name as 'ods_sql字段名',
    source_column_name as '源数据字段名',
    column_name_is_match as '字段名是否匹配'
from analysis_ods_source_meta_columns_detail
where table_name_is_match = 1 and column_name_is_match = 0 
order by stg_shell_source_table_name
;

select  
	ods_shell_file_addr as 'ods_shell路径',
	ods_shell_file_name as 'ods_shell文件名',
	ods_shell_ods_name as 'ods_shell-ods表名',
	stg_shell_xtjc as 'stg_shell系统简称',
	stg_shell_source_table_name as 'stg_shell源表名',
	full_stg_shell_source_table_name as '系统简称_stg_shell源表名',
	source_table_name as '源数据表名',
	ods_table_name_is_match as 'ods表名是否匹配',
	source_table_name_is_match as '源表名是否匹配',
	ods_sql_column_name as 'ods表字段数',
	source_column_name as '源表字段数',
	column_name_is_match as '字段名是否匹配'
from analysis_ods_source_meta_columns_detail
where ods_table_name_is_match = 1 and source_table_name_is_match = 1 and column_name_is_match = 0
order by stg_shell_source_table_name
;
```

## ods_sql与源数据字段类型不一致
```sql
select  
	ods_shell_file_addr as 'ods_shell路径',
	ods_shell_file_name as 'ods_shell文件名',
	ods_shell_ods_name as 'ods_shell-ods表名',
	stg_shell_xtjc as 'stg_shell系统简称',
	stg_shell_source_table_name as 'stg_shell源表名',
	full_stg_shell_source_table_name as '系统简称_stg_shell源表名',
	source_table_name as '源数据表名',
	ods_table_name_is_match as 'ods表名是否匹配',
	source_table_name_is_match as '源表名是否匹配',
	ods_sql_column_name as 'ods表字段名',
	source_column_name as '源表字段名',
	column_name_is_match as '字段名是否匹配',
	ods_sql_column_type as 'ods字段类型',
	source_column_type as '源表字段类型',
	source_column_length as '源表字段长度',
	source_column_flo as '源表字段精度',
	column_type_is_match as '字段类型是否匹配'
from analysis_ods_source_meta_columns_detail
where ods_table_name_is_match = 1 and source_table_name_is_match = 1 and column_name_is_match = 1 and column_type_is_match = 0
order by stg_shell_source_table_name
;
```

## ods_sql与源数据字段注释不一致
```sql
select  
	ods_shell_file_addr as 'ods_shell路径',
	ods_shell_file_name as 'ods_shell文件名',
	ods_shell_ods_name as 'ods_shell-ods表名',
	stg_shell_xtjc as 'stg_shell系统简称',
	stg_shell_source_table_name as 'stg_shell源表名',
	full_stg_shell_source_table_name as '系统简称_stg_shell源表名',
	source_table_name as '源数据表名',
	ods_table_name_is_match as 'ods表名是否匹配',
	source_table_name_is_match as '源表名是否匹配',
	ods_sql_column_name as 'ods表字段数',
	source_column_name as '源表字段数',
	column_name_is_match as '字段名是否匹配',
	ods_sql_column_comment as 'ods字段注释',
	source_column_comment as '源表字段注释',
	column_comment_is_match as '字段注释是否匹配'
from analysis_ods_source_meta_columns_detail
where ods_table_name_is_match = 1 and source_table_name_is_match = 1 and column_name_is_match = 1 and column_comment_is_match = 0
order by stg_shell_source_table_name
;
```

# ods_sql与hive元数据比对
## ods_sql与hive元数据表名不一致
```sql
select 
    ods_shell_file_addr as 'ods_shell文件路径',
    ods_shell_file_name as 'ods_shell文件名',
    ods_shell_ods_name as 'ods_shell-ods表名',
    ods_sql_table_name as 'ods_sql表名',
    bigdata_table_name as 'hive元数据表名',
    ods_table_name_is_match as 'ods表名是否匹配',
    bigdata_table_name_is_match as 'hive元数据表名是否匹配',
from analysis_ods_hive_meta_columns_count 
where ods_table_name_is_match = 0 or bigdata_table_name_is_match = 0 
order by ods_sql_table_name 
;
```

## ods_sql与hive元数据表注释不一致
```sql
select 
    ods_shell_file_addr as 'ods_shell文件路径',
    ods_shell_file_name as 'ods_shell文件名',
    ods_shell_ods_name as 'ods_shell-ods表名',
    ods_sql_table_name as 'ods_sql表名',
    bigdata_table_name as 'hive元数据表名',
    ods_table_name_is_match as 'ods表名是否匹配',
    bigdata_table_name_is_match as 'hive元数据表名是否匹配',
    ods_sql_table_comment as 'ods_sql表注释',
    bigdata_table_comment as 'hive元数据表注释',
    table_comment_is_match as '表注释是否匹配' 
from analysis_ods_hive_meta_columns_count 
where ods_table_name_is_match = 1 and bigdata_table_name_is_match = 1 and table_comment_is_match = 0 
order by ods_sql_table_name 
;
```

## ods_sql与hive元数据字段数不一致
```sql
select 
    ods_shell_file_addr as 'ods_shell文件路径',
    ods_shell_file_name as 'ods_shell文件名',
    ods_shell_ods_name as 'ods_shell-ods表名',
    ods_sql_table_name as 'ods_sql表名',
    bigdata_table_name as 'hive元数据表名',
    ods_table_name_is_match as 'ods表名是否匹配',
    bigdata_table_name_is_match as 'hive元数据表名是否匹配',
    ods_sql_columns_count as 'ods_sql字段数',
    bigdata_columns_count as 'hive元数据表字段个数',
    columns_count_is_match as '表字段个数是否匹配' 
from analysis_ods_hive_meta_columns_count 
where ods_table_name_is_match = 1 and bigdata_table_name_is_match = 1 and columns_count_is_match = 0 
order by ods_sql_table_name 
;
```

## ods_sql与hive元数据字段名不一致
```sql
select 
    ods_shell_file_addr as 'ods_shell文件路径',
    ods_shell_file_name as 'ods_shell文件名',
    ods_shell_ods_name as 'ods_shell-ods表名',
    ods_sql_table_name as 'ods_sql表名',
    bigdata_table_name as 'hive元数据表名',
    ods_table_name_is_match as 'ods表名是否匹配',
    bigdata_table_name_is_match as 'hive元数据表名是否匹配',
    ods_sql_column_name as 'ods_sql字段名',
    ods_sql_column_order as 'ods_sql字段顺序号',
    bigdata_column_name as 'hive元数据字段名',
    bigdata_column_order as 'hive元数据表字段顺序号',
    column_name_is_match as '字段名是否匹配' 
from analysis_ods_hive_meta_columns_detail 
where ods_table_name_is_match = 1 and bigdata_table_name_is_match = 1 and column_name_is_match = 0 
order by ods_sql_table_name 
;
```

## ods_sql与hive元数据字段类型不一致
```sql
select 
    ods_shell_file_addr as 'ods_shell文件路径',
    ods_shell_file_name as 'ods_shell文件名',
    ods_shell_ods_name as 'ods_shell-ods表名',
    ods_sql_table_name as 'ods_sql表名',
    bigdata_table_name as 'hive元数据表名',
    ods_table_name_is_match as 'ods表名是否匹配',
    bigdata_table_name_is_match as 'hive元数据表名是否匹配',
    ods_sql_column_name as 'ods_sql字段名',
    bigdata_column_name as 'hive元数据字段名',
    column_name_is_match as '字段名是否匹配',
    ods_sql_column_type as 'ods_sql字段类型',
    bigdata_column_type as 'hive元数据列类型',
    column_type_is_match as '字段类型是否匹配' 
from analysis_ods_hive_meta_columns_detail 
where ods_table_name_is_match = 1 and bigdata_table_name_is_match = 1 and column_name_is_match = 1 and column_type_is_match = 0
order by ods_sql_table_name 
;
```

## ods_sql与hive元数据字段注释不一致
```sql
select 
    ods_shell_file_addr as 'ods_shell文件路径',
    ods_shell_file_name as 'ods_shell文件名',
    ods_shell_ods_name as 'ods_shell-ods表名',
    ods_sql_table_name as 'ods_sql表名',
    bigdata_table_name as 'hive元数据表名',
    ods_table_name_is_match as 'ods表名是否匹配',
    bigdata_table_name_is_match as 'hive元数据表名是否匹配',
    ods_sql_column_name as 'ods_sql字段名',
    bigdata_column_name as 'hive元数据字段名',
    column_name_is_match as '字段名是否匹配',
    ods_sql_column_comment as 'ods_sql字段注释',
    bigdata_column_comment as 'hive元数据字段注释',
    column_comment_is_match as '字段注释是否匹配' 
from analysis_ods_hive_meta_columns_detail 
where ods_table_name_is_match = 1 and bigdata_table_name_is_match = 1 and column_name_is_match = 1 and column_comment_is_match = 0
order by ods_sql_table_name 
;
```

# ods_sql与stg_sql比对
## ods_sql与stg_sql表名不一致
```sql
select 
	ods_shell_file_addr as 'ods_shell文件路径',
	ods_shell_file_name as 'ods_shell文件名',
	ods_shell_ods_name as 'ods_shell-ods表名',
	ods_shell_stg_name as 'ods_shell-stg表名',
	ods_sql_table_name as 'ods_sql表名',
	stg_sql_table_name as 'stg_sql表名',
	ods_table_name_is_match as 'ods表名是否匹配',
	stg_table_name_is_match as 'stg表名是否匹配'
from analysis_ods_stg_columns_count 
where is_exclude = 0 and (ods_table_name_is_match = 0 or stg_table_name_is_match = 0)
order by ods_shell_ods_name 
;
```

## ods_sql与stg_sql表注释不一致
```sql
select 
	ods_shell_file_addr as 'ods_shell文件路径',
	ods_shell_file_name as 'ods_shell文件名',
	ods_shell_ods_name as 'ods_shell-ods表名',
	ods_shell_stg_name as 'ods_shell-stg表名',
	ods_sql_table_name as 'ods_sql表名',
	stg_sql_table_name as 'stg_sql表名',
	ods_table_name_is_match as 'ods表名是否匹配',
	stg_table_name_is_match as 'stg表名是否匹配',
	ods_sql_table_comment as 'ods_sql表注释',
	stg_sql_table_comment as 'stg_sql表注释',
	table_comment_is_match as '表注释是否匹配'
from analysis_ods_stg_columns_count 
where is_exclude = 0 and (ods_table_name_is_match = 1 and stg_table_name_is_match = 1 and table_comment_is_match = 0)
order by ods_shell_ods_name 
;
```

## ods_sql与stg_sql字段数不一致
```sql
select 
	ods_shell_file_addr as 'ods_shell文件路径',
	ods_shell_file_name as 'ods_shell文件名',
	ods_shell_ods_name as 'ods_shell-ods表名',
	ods_shell_stg_name as 'ods_shell-stg表名',
	ods_sql_table_name as 'ods_sql表名',
	stg_sql_table_name as 'stg_sql表名',
	ods_table_name_is_match as 'ods表名是否匹配',
	stg_table_name_is_match as 'stg表名是否匹配',
	ods_sql_columns_count as 'ods_sql字段数',
	stg_sql_columns_count as 'stg_sql字段数',
	columns_count_is_match as '字段数是否匹配'
from analysis_ods_stg_columns_count 
where is_exclude = 0 and (ods_table_name_is_match = 1 and stg_table_name_is_match = 1 and columns_count_is_match = 0)
order by ods_shell_ods_name 
;
```

## ods_sql与stg_sql字段名不一致
```sql
select distinct 
	ods_shell_file_addr as 'ods_shell文件路径',
	ods_shell_file_name as 'ods_shell文件名',
	ods_shell_ods_name as 'ods_shell-ods表名',
	ods_shell_stg_name as 'ods_shell-stg表名',
	ods_sql_file_name as 'ods_sql文件名',
	ods_sql_table_name as 'ods_sql表名',
	stg_sql_file_name as 'stg_sql文件名',
	stg_sql_table_name as 'stg_sql表名',
	ods_table_name_is_match as 'ods表名是否匹配',
	stg_table_name_is_match as 'stg表名是否匹配',
	ods_sql_column_name as 'ods_sql字段名',
	ods_sql_column_order as 'ods_sql字段顺序号',
	stg_sql_column_name as 'stg_sql字段名',
	stg_sql_column_order as 'stg_sql字段顺序号',
	column_name_is_match as '字段名是否匹配'
from analysis_ods_stg_columns_detail 
where is_exclude = 0 and (ods_table_name_is_match = 1 and stg_table_name_is_match = 1 and column_name_is_match = 0)
order by ods_shell_ods_name 
;
```

## ods_sql与stg_sql字段类型不一致
```sql
select 
	ods_shell_file_addr as 'ods_shell文件路径',
	ods_shell_file_name as 'ods_shell文件名',
	ods_shell_ods_name as 'ods_shell-ods表名',
	ods_shell_stg_name as 'ods_shell-stg表名',
	ods_sql_table_name as 'ods_sql表名',
	stg_sql_table_name as 'stg_sql表名',
	ods_table_name_is_match as 'ods表名是否匹配',
	stg_table_name_is_match as 'stg表名是否匹配',
	ods_sql_column_name as 'ods_sql字段名',
	stg_sql_column_name as 'stg_sql字段名',
	column_name_is_match as '字段名是否匹配',
	ods_sql_column_type as 'ods_sql字段类型',
	stg_sql_column_type as 'stg_sql字段类型',
	column_type_is_match as '字段类型是否匹配' 
from analysis_ods_stg_columns_detail 
where is_exclude = 0 and (ods_table_name_is_match = 1 and stg_table_name_is_match = 1 and column_name_is_match = 1 and column_type_is_match = 0)
order by ods_shell_ods_name 
;
```

## ods_sql与stg_sql字段注释不一致
```sql
select 
	ods_shell_file_addr as 'ods_shell文件路径',
	ods_shell_file_name as 'ods_shell文件名',
	ods_shell_ods_name as 'ods_shell-ods表名',
	ods_shell_stg_name as 'ods_shell-stg表名',
	ods_sql_table_name as 'ods_sql表名',
	stg_sql_table_name as 'stg_sql表名',
	ods_table_name_is_match as 'ods表名是否匹配',
	stg_table_name_is_match as 'stg表名是否匹配',
	ods_sql_column_name as 'ods_sql字段名',
	stg_sql_column_name as 'stg_sql字段名',
	column_name_is_match as '字段名是否匹配',
	ods_sql_column_comment as 'ods_sql字段注释',
	stg_sql_column_comment as 'stg_sql字段注释',
	column_comment_is_match as '字段注释是否匹配' 
from analysis_ods_stg_columns_detail 
where is_exclude = 0 and (ods_table_name_is_match = 1 and stg_table_name_is_match = 1 and column_name_is_match = 1 and column_comment_is_match = 0)
order by ods_shell_ods_name 
;
```

# 大数据平台测试环境hive元数据和生产环境hive元数据比对
## 测试环境hive元数据与生产环境hive元数据表名不一致
```sql
select
	online_table_name as '生产环境表名'
	,test_table_name as '测试环境表名'
	,table_name_is_match as '表名是匹配'
from analysis_hive_meta_columns_count 
where table_name_is_match = 0 
order by online_table_name
;
```

## 测试环境hive元数据与生产环境hive元数据字段数不一致
```sql
select distinct 
	online_table_name as '生产环境表名'
	,test_table_name as '测试环境表名'
	,table_name_is_match as '表名是匹配'
	,online_columns_count as '生产环境字段数'
	,test_columns_count as '测试环境字段数'
	,columns_count_is_match as '字段数是否匹配'
from analysis_hive_meta_columns_count 
where table_name_is_match = 1 and columns_count_is_match = 0
order by online_table_name 
;
```

## 测试环境hive元数据与生产环境hive元数据表注释不一致
```sql
select 
	online_table_name as '生产环境表名'
	,test_table_name as '测试环境表名'
	,table_name_is_match as '表名是匹配'
	,online_table_comment as '生产环境表注释'
	,test_table_comment as '测试环境表注释'
	,table_comment_is_match as '表注释是否匹配'
from analysis_hive_meta_columns_count 
where table_name_is_match = 1 and table_comment_is_match = 0
order by online_table_name 
;
```

## 测试环境hive元数据与生产环境hive元数据字段名不一致
```sql
select distinct 
	online_table_name as '生产环境表名'
	,test_table_name as '测试环境表名'
	,table_name_is_match as '表名是匹配'
	,online_column_name as '生产环境字段名'
	,online_column_order as '生产环境字段顺序号'
	,test_column_name as '测试环境字段名'
	,test_column_order as '测试环境字段顺序号'
	,column_name_is_match as '字段名是否配'
from analysis_hive_meta_columns_detail 
where table_name_is_match = 1 and column_name_is_match = 0
order by online_table_name 
;
```

## 测试环境hive元数据与生产环境hive元数据字段类型不一致
```sql
select distinct 
	online_table_name as '生产环境表名'
	,test_table_name as '测试环境表名'
	,table_name_is_match as '表名是匹配'
	,online_column_name as '生产环境字段名'
	,test_column_name as '测试环境字段名'
	,column_name_is_match as '字段名是否配'
	,online_column_type as '生产环境字段类型'
	,test_column_type as '测试环境字段类型'
	,column_type_is_match as '字段类型是否匹配'
from analysis_hive_meta_columns_detail 
where table_name_is_match = 1 and column_name_is_match = 1 and column_type_is_match = 0 
order by online_table_name 
;
```

## 测试环境hive元数据与生产环境hive元数据字段注释不一致
```sql
select distinct 
	online_table_name as '生产环境表名'
	,test_table_name as '测试环境表名'
	,table_name_is_match as '表名是匹配'
	,online_column_name as '生产环境字段名'
	,test_column_name as '测试环境字段名'
	,column_name_is_match as '字段名是否配'
	,online_column_comment as '生产环境字段注释'
	,test_column_comment as '测试环境字段注释'
	,column_comment_is_match as '字段注释是否匹配'
from analysis_hive_meta_columns_detail 
where table_name_is_match = 1 and column_name_is_match = 1 and column_comment_is_match = 0 
order by online_table_name 
;
```
# 大数据平台测试环境源数据和生产环境源数据比对
## 测试环境源数据与生产环境源数据表名不一致
```sql
select
	online_table_name as '生产环境表名'
	,test_table_name as '测试环境表名'
	,table_name_is_match as '表名是匹配'
from analysis_source_meta_columns_count 
where table_name_is_match = 0 
order by online_table_name
;
```

## 测试环境源数据与生产环境源数据字段数不一致
```sql
select distinct 
	online_table_name as '生产环境表名'
	,test_table_name as '测试环境表名'
	,table_name_is_match as '表名是匹配'
	,online_columns_count as '生产环境字段数'
	,test_columns_count as '测试环境字段数'
	,columns_count_is_match as '字段数是否匹配'
from analysis_source_meta_columns_count 
where table_name_is_match = 1 and columns_count_is_match = 0
order by online_table_name 
;
```

## 测试环境源数据与生产环境源数据表注释不一致
```sql
select 
	online_table_name as '生产环境表名'
	,test_table_name as '测试环境表名'
	,table_name_is_match as '表名是匹配'
	,online_table_comment as '生产环境表注释'
	,test_table_comment as '测试环境表注释'
	,table_comment_is_match as '表注释是否匹配'
from analysis_source_meta_columns_count 
where table_name_is_match = 1 and table_comment_is_match = 0
order by online_table_name 
;
```

## 测试环境源数据与生产环境源数据字段名不一致
```sql
select distinct 
	online_table_name as '生产环境表名'
	,test_table_name as '测试环境表名'
	,table_name_is_match as '表名是匹配'
	,online_column_name as '生产环境字段名'
	,online_column_order as '生产环境字段顺序号'
	,test_column_name as '测试环境字段名'
	,test_column_order as '测试环境字段顺序号'
	,column_name_is_match as '字段名是否配'
from analysis_source_meta_columns_detail 
where table_name_is_match = 1 and column_name_is_match = 0
order by online_table_name 
;
```

## 测试环境源数据与生产环境源数据字段类型不一致
```sql
select distinct 
	online_table_name as '生产环境表名'
	,test_table_name as '测试环境表名'
	,table_name_is_match as '表名是匹配'
	,online_column_name as '生产环境字段名'
	,test_column_name as '测试环境字段名'
	,column_name_is_match as '字段名是否配'
	,online_column_type as '生产环境字段类型'
	,test_column_type as '测试环境字段类型'
	,column_type_is_match as '字段类型是否匹配'
from analysis_source_meta_columns_detail 
where table_name_is_match = 1 and column_name_is_match = 1 and column_type_is_match = 0 
order by online_table_name 
;
```

## 测试环境源数据与生产环境源数据字段注释不一致
```sql
select distinct 
	online_table_name as '生产环境表名'
	,test_table_name as '测试环境表名'
	,table_name_is_match as '表名是匹配'
	,online_column_name as '生产环境字段名'
	,test_column_name as '测试环境字段名'
	,column_name_is_match as '字段名是否配'
	,online_column_comment as '生产环境字段注释'
	,test_column_comment as '测试环境字段注释'
	,column_comment_is_match as '字段注释是否匹配'
from analysis_source_meta_columns_detail 
where table_name_is_match = 1 and column_name_is_match = 1 and column_comment_is_match = 0 
order by online_table_name 
;
```

# 大数据生产源表元数据和stg_shell源表比对
## 生产源表元数据和stg_shell源表表名不一致
```sql
select 
	ods_shell_file_addr as 'ods_shell路径'
	,ods_shell_ods_name as 'ods_shell中ods表名'
	,stg_shell_file_name as 'stg_shell文件名'
	,stg_shell_source_table_name as 'stg_shell源表名'
	,full_source_table_name as '系统简称_源表名'
	,hive_meta_table_is_match as 'hive元数据表名是否匹配'
	,source_meta_table_is_match as '源表名是否匹配'
from analysis_source_hive_meta_columns_count 
where hive_meta_table_is_match = 0 or source_meta_table_is_match = 0 
order by ods_shell_ods_name
;
```

## 生产源表元数据和stg_shell源表表字段数不一致
```sql
select  
	ods_shell_file_addr as 'ods_shell路径'
	,ods_shell_ods_name as 'ods_shell中ods表名'
	,stg_shell_file_name as 'stg_shell文件名'
	,stg_shell_source_table_name as 'stg_shell源表名'
	,full_source_table_name as '系统简称_源表名'
	,hive_meta_table_is_match as 'hive元数据表名是否匹配'
	,source_meta_table_is_match as '源表名是否匹配'
	,hive_meta_columns_count as 'hive元数据表字段数'
	,source_meta_columns_count as '源数据表字段数'
	,columns_count_is_match as '字段数是否匹配'
from analysis_source_hive_meta_columns_count 
where hive_meta_table_is_match = 1 and source_meta_table_is_match = 1 and columns_count_is_match = 0 
order by ods_shell_ods_name
;
```

## 生产源表元数据和stg_shell源表表注释不一致
```sql
select  
	ods_shell_file_addr as 'ods_shell路径'
	,ods_shell_ods_name as 'ods_shell中ods表名'
	,stg_shell_file_name as 'stg_shell文件名'
	,stg_shell_source_table_name as 'stg_shell源表名'
	,full_source_table_name as '系统简称_源表名'
	,hive_meta_table_is_match as 'hive元数据表名是否匹配'
	,source_meta_table_is_match as '源表名是否匹配'
	,hive_meta_table_comment as 'hive元数据表注释'
	,source_meta_table_comment as '源数据表注释'
	,table_comment_is_match as '表注释是否匹配'
from analysis_source_hive_meta_columns_count 
where hive_meta_table_is_match = 1 and source_meta_table_is_match = 1 and table_comment_is_match = 0 
order by ods_shell_ods_name
;
```

## 生产源表元数据和stg_shell源表表字段名不一致
```sql
select 
	ods_shell_file_addr as 'ods_shell路径'
	,ods_shell_ods_name as 'ods_shell中ods表名'
	,stg_shell_file_name as 'stg_shell文件名'
	,stg_shell_source_table_name as 'stg_shell源表名'
	,full_source_table_name as '系统简称_源表名'
	,hive_meta_table_is_match as 'hive元数据表名是否匹配'
	,source_meta_table_is_match as '源表名是否匹配'
	,hive_meta_column_name as 'hive元数据字段名'
	,source_meta_column_name as '源数据表字段名'
	,column_name_is_match as '字段名是否匹配'
from analysis_source_hive_meta_columns_detail 
where hive_meta_table_is_match = 1 and source_meta_table_is_match = 1 and column_name_is_match = 0 
order by ods_shell_ods_name
;
```

## 生产源表元数据和stg_shell源表表字段类型不一致
```sql
select 
	ods_shell_file_addr as 'ods_shell路径'
	,ods_shell_ods_name as 'ods_shell中ods表名'
	,stg_shell_file_name as 'stg_shell文件名'
	,stg_shell_source_table_name as 'stg_shell源表名'
	,full_source_table_name as '系统简称_源表名'
	,hive_meta_table_is_match as 'hive元数据表名是否匹配'
	,source_meta_table_is_match as '源表名是否匹配'
	,hive_meta_column_name as 'hive元数据字段名'
	,source_meta_column_name as '源数据表字段名'
	,column_name_is_match as '字段名是否匹配'
	,hive_meta_column_type as 'hive元数据字段类型'
	,source_meta_column_type as '源数据字段类型'
	,source_meta_column_length as '源数据字段长度'
	,source_meta_column_flo as '源数据字段精度'
	,column_type_is_match as '字段类型是否匹配'
from analysis_source_hive_meta_columns_detail 
where hive_meta_table_is_match = 1 and source_meta_table_is_match = 1 and column_name_is_match = 1 and column_type_is_match = 0
order by ods_shell_ods_name
;
```

## 生产源表元数据和stg_shell源表表字段注释不一致
```sql
select 
	ods_shell_file_addr as 'ods_shell路径'
	,ods_shell_ods_name as 'ods_shell中ods表名'
	,stg_shell_file_name as 'stg_shell文件名'
	,stg_shell_source_table_name as 'stg_shell源表名'
	,full_source_table_name as '系统简称_源表名'
	,hive_meta_table_is_match as 'hive元数据表名是否匹配'
	,source_meta_table_is_match as '源表名是否匹配'
	,hive_meta_column_name as 'hive元数据字段名'
	,source_meta_column_name as '源数据表字段名'
	,column_name_is_match as '字段名是否匹配'
	,hive_meta_column_comment as 'hive元数据字段注释'
	,source_meta_column_comment as '源数据字段注释'
	,column_comment_is_match as '字段注释是否匹配'
from analysis_source_hive_meta_columns_detail 
where hive_meta_table_is_match = 1 and source_meta_table_is_match = 1 and column_name_is_match = 1 and column_comment_is_match = 0
order by ods_shell_ods_name
;
```


# ods_sql与hive_file比对
## ods_sql与hive_file表名不一致
```sql
select distinct 
	hive_file_addr as 'hive_file路径',
	hive_file_name as 'hive_file文件名',
	hive_file_ods_name as 'hive_file-ods表名',
	ods_sql_table_name as 'ods_sql表名',
	table_name_is_match as '表名是否匹配' 
from analysis_ods_hive_file_columns_detail
where table_name_is_match = 0 
order by ods_sql_table_name 
;
```

## ods_sql与hive_file字段名不一致
```sql
select 
	hive_file_addr as 'hive_file路径',
	hive_file_name as 'hive_file文件名',
	hive_file_ods_name as 'hive_file-ods表名',
	ods_sql_table_name as 'ods_sql表名',
	table_name_is_match as '表名是否匹配',
	hive_file_column_name as 'hive_file字段名',
	ods_sql_column_name as 'ods_sql字段名',
	column_name_is_match as '字段名是否匹配'
from analysis_ods_hive_file_columns_detail
where table_name_is_match = 1 and column_name_is_match = 0 
order by ods_sql_table_name 
;
```


# stg_sql与stg_shell比对
## stg_sql与stg_shell表名不一致,排除一些没有 stg_shell的表
```sql
select 
	stg_shell_file_addr as 'stg_shell文件路径',
	stg_shell_file_name as 'stg_shell文件名',
	stg_shell_stg_table_name as 'stg_shell-stg表名',
	stg_sql_file_name as 'stg_sql文件名',
	stg_sql_table_name as 'stg_sql表名',
	table_name_is_match as '表名是否匹配'
from analysis_stg_sql_shell_columns_count  
where table_name_is_match = 0
order by stg_shell_stg_table_name
;
```

## stg_sql与stg_shell字段数不一致
```sql
select 
	stg_shell_file_addr as 'stg_shell文件路径',
	stg_shell_file_name as 'stg_shell文件名',
	stg_shell_stg_table_name as 'stg_shell-stg表名',
	stg_sql_file_name as 'stg_sql文件名',
	stg_sql_table_name as 'stg_sql表名',
	table_name_is_match as '表名是否匹配',
	stg_shell_all_columns_count as 'stg_shell字段数',
	stg_sql_columns_count as 'stg_sql字段数',
	columns_count_is_match as '字段数是否匹配'
from analysis_stg_sql_shell_columns_count  
where table_name_is_match = 1 and columns_count_is_match = 0 
order by stg_shell_stg_table_name
;
```

## stg_sql与stg_shell字段名不一致
```sql
select distinct 
	stg_shell_file_addr as 'stg_shell文件路径',
	stg_shell_file_name as 'stg_shell文件名',
	stg_shell_stg_table_name as 'stg_shell-stg表名',
	stg_sql_file_name as 'stg_sql文件名',
	stg_sql_table_name as 'stg_sql表名',
	table_name_is_match as '表名是否匹配',
	stg_shell_stg_column_name as 'stg_shell字段名',
	stg_shell_stg_column_order as 'stg_shell字段顺序号',
	stg_sql_column_name as 'stg_sql字段名',
	stg_sql_column_order as 'stg_sql字段顺序号',
	column_name_is_match as '字段名是否匹配'
from analysis_stg_sql_shell_columns_detail  
where table_name_is_match = 1 and column_name_is_match = 0 
order by stg_shell_stg_table_name
;
```