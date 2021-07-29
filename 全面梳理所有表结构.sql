/*
 Navicat Premium Data Transfer

 Source Server         : MySQL - localhost
 Source Server Type    : MySQL
 Source Server Version : 80021
 Source Host           : localhost:3306
 Source Schema         : by_dylan

 Target Server Type    : MySQL
 Target Server Version : 80021
 File Encoding         : 65001

 Date: 29/07/2021 18:00:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for analysis_azkaban_hive_file
-- ----------------------------
DROP TABLE IF EXISTS `analysis_azkaban_hive_file`;
CREATE TABLE `analysis_azkaban_hive_file`  (
  `file_addr` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '解析文件路径',
  `file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '解析文件名',
  `ods_table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods表名',
  `all_columns_count` int(0) NULL DEFAULT 0 COMMENT '导出列个数',
  `all_columns` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '导出列',
  `is_match_azkaban` int(0) NULL DEFAULT 0 COMMENT 'hive_file是否分发',
  `azkaban_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'azkaban文件名',
  `azkaban_job_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'azkaban-job名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_azkaban_ods_shell
-- ----------------------------
DROP TABLE IF EXISTS `analysis_azkaban_ods_shell`;
CREATE TABLE `analysis_azkaban_ods_shell`  (
  `file_addr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '解析文件路径',
  `file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '解析文件名',
  `stg_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg表名',
  `ods_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods表名',
  `is_match_azkaban` int(0) NULL DEFAULT 0 COMMENT '是否匹配azkaban',
  `azkaban_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'azkaban文件名',
  `azkaban_job_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'azkaban-job名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_azkaban_ods_sql
-- ----------------------------
DROP TABLE IF EXISTS `analysis_azkaban_ods_sql`;
CREATE TABLE `analysis_azkaban_ods_sql`  (
  `file_addr` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件路径',
  `file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件名',
  `table_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名',
  `table_comment` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表注释',
  `columns_count` int(0) NULL DEFAULT 0 COMMENT '字段个数',
  `column_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段名',
  `column_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段类型',
  `column_comment` varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段注释',
  `column_order` int(0) NULL DEFAULT 0 COMMENT '字段顺序号',
  `is_match_azkaban` int(0) NULL DEFAULT 0 COMMENT '是否匹配到azkaban调度',
  `azkaban_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'azkaban文件名',
  `azkaban_job_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'azkaban-job名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_azkaban_src_to_bigdata
-- ----------------------------
DROP TABLE IF EXISTS `analysis_azkaban_src_to_bigdata`;
CREATE TABLE `analysis_azkaban_src_to_bigdata`  (
  `ods_shell_file_addr` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell文件路径',
  `ods_shell_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell文件名',
  `ods_shell_ods_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell,ods表名',
  `ods_shell_stg_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell,stg表名',
  `ods_shell_is_match_azkaban` int(0) NULL DEFAULT 0 COMMENT 'ods_shell,是否匹配azkaban',
  `ods_shell_azkaban_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell,azkaban文件名',
  `ods_shell_azkaban_job_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell,azkaban job名',
  `stg_shell_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell文件名',
  `stg_shell_stg_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell,stg表名',
  `stg_shell_source_table_name` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell,源表名',
  `stg_shell_xtjc` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell,系统简称',
  `stg_shell_all_columns_count` int(0) NULL DEFAULT 0 COMMENT 'stg_shell,字段数',
  `stg_shell_is_match_azkaban` int(0) NULL DEFAULT 0 COMMENT 'stg_shell,是否匹配azkaban',
  `stg_shell_azkaban_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell,azkaban文件名',
  `stg_shell_azkaban_job_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell,azkaban job名',
  `stg_shell_parse_all_columns` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'stg_shell,解析后所有字段',
  `stg_shell_all_columns` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'stg_shell,原始所有字段',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_azkaban_stg_shell
-- ----------------------------
DROP TABLE IF EXISTS `analysis_azkaban_stg_shell`;
CREATE TABLE `analysis_azkaban_stg_shell`  (
  `file_addr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '解析文件路径',
  `file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '解析文件名',
  `source_table_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '源系统表名',
  `stg_table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg表名',
  `filter_key` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '增量字段',
  `xtjc` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '系统简称',
  `all_columns_count` int(0) NULL DEFAULT 0 COMMENT '原始所有字段个数',
  `is_match_azkaban` int(0) NULL DEFAULT 0 COMMENT '是否匹配调度文件',
  `azkaban_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'azkaban文件名',
  `azkaban_job_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'azkaban-job名',
  `parse_all_columns` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '解析所有字段',
  `all_columns` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '原始所有字段',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_azkaban_stg_sql
-- ----------------------------
DROP TABLE IF EXISTS `analysis_azkaban_stg_sql`;
CREATE TABLE `analysis_azkaban_stg_sql`  (
  `file_addr` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件路径',
  `file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件名',
  `table_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名',
  `table_comment` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表注释',
  `columns_count` int(0) NULL DEFAULT 0 COMMENT '字段个数',
  `column_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段名',
  `column_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段类型',
  `column_comment` varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段注释',
  `column_order` int(0) NULL DEFAULT 0 COMMENT '字段顺序号',
  `is_match_azkaban` int(0) NULL DEFAULT 0 COMMENT '是否匹配到azkaban调度',
  `azkaban_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'azkaban文件名',
  `azkaban_job_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'azkaban-job名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_hive_meta_columns_count
-- ----------------------------
DROP TABLE IF EXISTS `analysis_hive_meta_columns_count`;
CREATE TABLE `analysis_hive_meta_columns_count`  (
  `online_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '生产hive元数据表名',
  `online_table_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '生产hive元数据表注释',
  `online_columns_count` int(0) NULL DEFAULT 0 COMMENT '生产hive元数据表字段数',
  `test_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '测试hive元数据表名',
  `test_table_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '测试hive元数据表注释',
  `test_columns_count` int(0) NULL DEFAULT 0 COMMENT '测试hive元数据表字段数',
  `table_name_is_match` int(0) NULL DEFAULT 0 COMMENT '表名是否匹配',
  `table_comment_is_match` int(0) NULL DEFAULT 0 COMMENT '表注释是否匹配',
  `columns_count_is_match` int(0) NULL DEFAULT 0 COMMENT '表字段个数是否匹配',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_hive_meta_columns_detail
-- ----------------------------
DROP TABLE IF EXISTS `analysis_hive_meta_columns_detail`;
CREATE TABLE `analysis_hive_meta_columns_detail`  (
  `online_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '生产hive元数据表名',
  `online_column_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '生产hive元数据字段名',
  `online_column_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '生产hive元数据字段类型',
  `online_column_comment` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '生产hive元数据表字段注释',
  `online_column_order` int(0) NULL DEFAULT 0 COMMENT '生产hive元数据表字段顺序号',
  `test_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '测试hive元数据表名',
  `test_column_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '测试hive元数据字段名',
  `test_column_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '测试hive元数据字段类型',
  `test_column_comment` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '测试hive元数据表字段注释',
  `test_column_order` int(0) NULL DEFAULT 0 COMMENT '测试hive元数据表字段顺序号',
  `table_name_is_match` int(0) NULL DEFAULT 0 COMMENT '表名是否匹配',
  `column_name_is_match` int(0) NULL DEFAULT 0 COMMENT '字段名否匹配',
  `column_type_is_match` int(0) NULL DEFAULT 0 COMMENT '字段类型是否匹配',
  `column_comment_is_match` int(0) NULL DEFAULT 0 COMMENT '字段类型是否匹配',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_ods_hive_file_columns_detail
-- ----------------------------
DROP TABLE IF EXISTS `analysis_ods_hive_file_columns_detail`;
CREATE TABLE `analysis_ods_hive_file_columns_detail`  (
  `hive_file_addr` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'hive_file文件路径',
  `hive_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'hive_file文件名',
  `hive_file_ods_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'hive_file,ods表名',
  `hive_file_column_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'hive_file字段名',
  `hive_file_column_order` int(0) NULL DEFAULT 0 COMMENT 'hive_file字段顺序号',
  `ods_sql_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql表名',
  `ods_sql_column_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql字段名',
  `ods_sql_column_order` int(0) NULL DEFAULT 0 COMMENT 'ods_sql字段顺序号',
  `table_name_is_match` int(0) NULL DEFAULT 0 COMMENT '表名是否匹配',
  `column_name_is_match` int(0) NULL DEFAULT 0 COMMENT '字段名是否匹配',
  `hive_file_all_columns` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT 'hive_file所有字段名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_ods_hive_meta_columns_count
-- ----------------------------
DROP TABLE IF EXISTS `analysis_ods_hive_meta_columns_count`;
CREATE TABLE `analysis_ods_hive_meta_columns_count`  (
  `ods_shell_file_addr` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell文件路径',
  `ods_shell_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell文件名',
  `ods_shell_ods_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell,ods表名',
  `ods_sql_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql文件名',
  `ods_sql_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql表名',
  `ods_sql_table_comment` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql表注释',
  `ods_sql_columns_count` int(0) NULL DEFAULT 0 COMMENT 'ods_sql字段数',
  `bigdata_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '元数据表名',
  `bigdata_table_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '元数据表注释',
  `bigdata_columns_count` int(0) NULL DEFAULT 0 COMMENT '元数据表字段个数',
  `ods_table_name_is_match` int(0) NULL DEFAULT 0 COMMENT 'ods表名是否匹配',
  `bigdata_table_name_is_match` int(0) NULL DEFAULT 0 COMMENT 'hive元数据表名是否匹配',
  `table_comment_is_match` int(0) NULL DEFAULT 0 COMMENT '表注释是否匹配',
  `columns_count_is_match` int(0) NULL DEFAULT 0 COMMENT '表字段个数是否匹配',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_ods_hive_meta_columns_detail
-- ----------------------------
DROP TABLE IF EXISTS `analysis_ods_hive_meta_columns_detail`;
CREATE TABLE `analysis_ods_hive_meta_columns_detail`  (
  `ods_shell_file_addr` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell文件路径',
  `ods_shell_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell文件名',
  `ods_shell_ods_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell,ods表名',
  `ods_sql_file_name` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql文件名',
  `ods_sql_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql表名',
  `ods_sql_column_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql列名',
  `ods_sql_column_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql字段类型',
  `ods_sql_column_comment` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql字段注释',
  `ods_sql_column_order` int(0) NULL DEFAULT 0 COMMENT 'ods_sql字段顺序号',
  `bigdata_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '元数据表名',
  `bigdata_column_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '元数据字段名',
  `bigdata_column_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '元数据列类型',
  `bigdata_column_comment` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '元数据列注释',
  `bigdata_column_order` int(0) NULL DEFAULT 0 COMMENT '元数据表字段顺序号',
  `ods_table_name_is_match` int(0) NULL DEFAULT 0 COMMENT 'ods表名是否匹配',
  `bigdata_table_name_is_match` int(0) NULL DEFAULT 0 COMMENT 'hive元数据表名是否匹配',
  `column_name_is_match` int(0) NULL DEFAULT 0 COMMENT '列名是否匹配',
  `column_type_is_match` int(0) NULL DEFAULT 0 COMMENT '列类型是否匹配',
  `column_comment_is_match` int(0) NULL DEFAULT 0 COMMENT '列注释是否匹配',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_ods_source_meta_columns_count
-- ----------------------------
DROP TABLE IF EXISTS `analysis_ods_source_meta_columns_count`;
CREATE TABLE `analysis_ods_source_meta_columns_count`  (
  `ods_shell_file_addr` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell文件路径',
  `ods_shell_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell文件名',
  `ods_shell_ods_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell,ods表名',
  `stg_shell_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell文件名',
  `stg_shell_xtjc` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell系统简称',
  `stg_shell_source_table_name` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell,源表名',
  `full_stg_shell_source_table_name` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell,源表名包含系统简称',
  `stg_shell_all_columns_count` int(0) NULL DEFAULT 0 COMMENT 'stg_shell字段数',
  `ods_sql_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql文件名',
  `ods_sql_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql表名',
  `ods_sql_table_comment` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql表注释',
  `ods_sql_columns_count` int(0) NULL DEFAULT 0 COMMENT 'ods_sql字段数',
  `source_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '源数据表名',
  `source_table_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '源数据表注释',
  `source_columns_count` int(0) NULL DEFAULT 0 COMMENT '源数据字段顺序号',
  `ods_table_name_is_match` int(0) NULL DEFAULT 0 COMMENT 'ods表名是否匹配',
  `source_table_name_is_match` int(0) NULL DEFAULT 0 COMMENT '源表名是否匹配',
  `table_comment_is_match` int(0) NULL DEFAULT 0 COMMENT '表注释是否匹配',
  `columns_count_is_match` int(0) NULL DEFAULT 0 COMMENT '字段数是否匹配',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_ods_source_meta_columns_detail
-- ----------------------------
DROP TABLE IF EXISTS `analysis_ods_source_meta_columns_detail`;
CREATE TABLE `analysis_ods_source_meta_columns_detail`  (
  `ods_shell_file_addr` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell文件路径',
  `ods_shell_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell文件名',
  `ods_shell_ods_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell,ods表名',
  `stg_shell_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell文件名',
  `stg_shell_xtjc` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell系统简称',
  `stg_shell_source_table_name` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell,源表名',
  `full_stg_shell_source_table_name` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell,源表名包含系统简称',
  `ods_sql_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql文件名',
  `ods_sql_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql表名',
  `ods_sql_column_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql字段名',
  `ods_sql_column_order` int(0) NULL DEFAULT 0 COMMENT 'ods_sql字段顺序号',
  `ods_sql_column_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql字段类型',
  `ods_sql_column_comment` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql字段注释',
  `source_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '源数据表名',
  `source_column_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '源数据字段名',
  `source_column_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '源数据字段类型',
  `source_column_length` int(0) NULL DEFAULT 0 COMMENT '源数据字段长度',
  `source_column_flo` int(0) NULL DEFAULT 0 COMMENT '源数据字段精度',
  `source_column_order` int(0) NULL DEFAULT 0 COMMENT '源数据字段顺序号',
  `source_column_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '源数据字段注释',
  `ods_table_name_is_match` int(0) NULL DEFAULT 0 COMMENT 'ods表名是否匹配',
  `source_table_name_is_match` int(0) NULL DEFAULT 0 COMMENT '源表名是否匹配',
  `column_name_is_match` int(0) NULL DEFAULT 0 COMMENT '字段名是否匹配',
  `column_type_is_match` int(0) NULL DEFAULT 0 COMMENT '字段类型是否匹配',
  `column_comment_is_match` int(0) NULL DEFAULT 0 COMMENT '表注释是否匹配',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_ods_stg_columns_count
-- ----------------------------
DROP TABLE IF EXISTS `analysis_ods_stg_columns_count`;
CREATE TABLE `analysis_ods_stg_columns_count`  (
  `ods_shell_file_addr` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell文件路径',
  `ods_shell_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell文件名',
  `ods_shell_ods_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell,ods表名',
  `ods_shell_stg_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell,stg表名',
  `stg_shell_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell文件名',
  `stg_shell_all_columns_count` int(0) NULL DEFAULT 0 COMMENT 'stg_shell,字段数',
  `ods_sql_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql文件名',
  `ods_sql_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql表名',
  `ods_sql_table_comment` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql表注释',
  `ods_sql_columns_count` int(0) NULL DEFAULT 0 COMMENT 'ods_sql字段数',
  `stg_sql_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_sql文件名',
  `stg_sql_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_sql表名',
  `stg_sql_table_comment` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_sql表注释',
  `stg_sql_columns_count` int(0) NULL DEFAULT 0 COMMENT 'stg_sql字段数',
  `ods_table_name_is_match` int(0) NULL DEFAULT 0 COMMENT 'ods表名是否匹配',
  `stg_table_name_is_match` int(0) NULL DEFAULT 0 COMMENT 'stg表名是否匹配',
  `table_comment_is_match` int(0) NULL DEFAULT 0 COMMENT '表注释是否匹配',
  `columns_count_is_match` int(0) NULL DEFAULT 0 COMMENT '字段数是否匹配',
  `is_exclude` int(0) NULL DEFAULT 0 COMMENT '匹配特例表后是否排除',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_ods_stg_columns_detail
-- ----------------------------
DROP TABLE IF EXISTS `analysis_ods_stg_columns_detail`;
CREATE TABLE `analysis_ods_stg_columns_detail`  (
  `ods_shell_file_addr` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell文件路径',
  `ods_shell_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell文件名',
  `ods_shell_ods_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell,ods表名',
  `ods_shell_stg_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell,stg表名',
  `stg_shell_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell文件名',
  `stg_shell_all_columns_count` int(0) NULL DEFAULT 0 COMMENT 'stg_shell,字段数',
  `ods_sql_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql文件名',
  `ods_sql_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql表名',
  `ods_sql_column_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql字段名',
  `ods_sql_column_order` int(0) NULL DEFAULT 0 COMMENT 'ods_sql字段顺序号',
  `ods_sql_column_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql字段类型',
  `ods_sql_column_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_sql字段注释',
  `stg_sql_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_sql文件名',
  `stg_sql_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_sql表名',
  `stg_sql_column_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_sql字段名',
  `stg_sql_column_order` int(0) NULL DEFAULT 0 COMMENT 'stg_sql字段顺序号',
  `stg_sql_column_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_sql字段类型',
  `stg_sql_column_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_sql字段注释',
  `ods_table_name_is_match` int(0) NULL DEFAULT 0 COMMENT 'ods表名是否匹配',
  `stg_table_name_is_match` int(0) NULL DEFAULT 0 COMMENT 'stg表名是否匹配',
  `column_name_is_match` int(0) NULL DEFAULT 0 COMMENT '字段名是否匹配',
  `column_type_is_match` int(0) NULL DEFAULT 0 COMMENT '字段类型是否匹配',
  `column_comment_is_match` int(0) NULL DEFAULT 0 COMMENT '字段注释是否匹配',
  `is_exclude` int(0) NULL DEFAULT 0 COMMENT '匹配特例表后是否排除',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_source_hive_meta_columns_count
-- ----------------------------
DROP TABLE IF EXISTS `analysis_source_hive_meta_columns_count`;
CREATE TABLE `analysis_source_hive_meta_columns_count`  (
  `ods_shell_file_addr` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell文件路径',
  `ods_shell_ods_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell中ods表名',
  `stg_shell_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell文件名',
  `gkpt_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '管控平台简称',
  `stg_shell_source_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell中源表名',
  `full_source_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '源表名拼接简称后全名',
  `hive_meta_columns_count` int(0) NULL DEFAULT 0 COMMENT 'hive元数据表字段数',
  `hive_meta_table_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'hive元数据表注释',
  `source_meta_columns_count` int(0) NULL DEFAULT 0 COMMENT '源数据表字段数',
  `source_meta_table_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '源数据表注释',
  `hive_meta_table_is_match` int(0) NULL DEFAULT 0 COMMENT 'hive元数据表名是否匹配',
  `source_meta_table_is_match` int(0) NULL DEFAULT 0 COMMENT '源表名是否匹配',
  `columns_count_is_match` int(0) NULL DEFAULT 0 COMMENT '字段数是否匹配',
  `table_comment_is_match` int(0) NULL DEFAULT 0 COMMENT '表注释是否匹配',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_source_hive_meta_columns_detail
-- ----------------------------
DROP TABLE IF EXISTS `analysis_source_hive_meta_columns_detail`;
CREATE TABLE `analysis_source_hive_meta_columns_detail`  (
  `ods_shell_file_addr` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell文件路径',
  `ods_shell_ods_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell中ods表名',
  `stg_shell_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell文件名',
  `gkpt_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '管控平台简称',
  `stg_shell_source_table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell中源表名',
  `full_source_table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '源表名拼接简称后全名',
  `hive_meta_column_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'hive元数据字段名',
  `hive_meta_column_order` int(0) NULL DEFAULT 0 COMMENT 'hive元数据字段顺序号',
  `hive_meta_column_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'hive元数据字段类型',
  `hive_meta_column_comment` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'hive元数据字段注释',
  `source_meta_column_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '源数据字段名',
  `source_meta_column_order` int(0) NULL DEFAULT 0 COMMENT '源数据字段顺序号',
  `source_meta_column_type` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '源数据字段类型',
  `source_meta_column_length` int(0) NULL DEFAULT 0 COMMENT '源数据字段长度',
  `source_meta_column_flo` int(0) NULL DEFAULT 0 COMMENT '源数据字段精度',
  `source_meta_column_comment` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '源数据字段注释',
  `hive_meta_table_is_match` int(0) NULL DEFAULT 0 COMMENT 'hive元数据表名是否匹配',
  `source_meta_table_is_match` int(0) NULL DEFAULT 0 COMMENT '源表名是否匹配',
  `column_name_is_match` int(0) NULL DEFAULT 0 COMMENT '字段名是否匹配',
  `column_type_is_match` int(0) NULL DEFAULT 0 COMMENT '字段类型是否匹配',
  `column_comment_is_match` int(0) NULL DEFAULT 0 COMMENT '字段注释是否匹配',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_source_meta_columns_count
-- ----------------------------
DROP TABLE IF EXISTS `analysis_source_meta_columns_count`;
CREATE TABLE `analysis_source_meta_columns_count`  (
  `online_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '生产源数据表名',
  `online_table_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '生产源数据表注释',
  `online_columns_count` int(0) NULL DEFAULT 0 COMMENT '生产源数据表字段数',
  `test_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '测试源数据表名',
  `test_table_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '测试源数据表注释',
  `test_columns_count` int(0) NULL DEFAULT 0 COMMENT '测试源数据表字段数',
  `table_name_is_match` int(0) NULL DEFAULT 0 COMMENT '表名是否匹配',
  `table_comment_is_match` int(0) NULL DEFAULT 0 COMMENT '表注释是否匹配',
  `columns_count_is_match` int(0) NULL DEFAULT 0 COMMENT '表字段个数是否匹配',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_source_meta_columns_detail
-- ----------------------------
DROP TABLE IF EXISTS `analysis_source_meta_columns_detail`;
CREATE TABLE `analysis_source_meta_columns_detail`  (
  `online_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '生产源数据表名',
  `online_column_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '生产源数据字段名',
  `online_column_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '生产源数据字段类型',
  `online_column_comment` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '生产源数据表字段注释',
  `online_column_order` int(0) NULL DEFAULT 0 COMMENT '生产源数据表字段顺序号',
  `test_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '测试源数据表名',
  `test_column_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '测试源数据字段名',
  `test_column_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '测试源数据字段类型',
  `test_column_comment` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '测试源数据表字段注释',
  `test_column_order` int(0) NULL DEFAULT 0 COMMENT '测试源数据表字段顺序号',
  `table_name_is_match` int(0) NULL DEFAULT 0 COMMENT '表名是否匹配',
  `column_name_is_match` int(0) NULL DEFAULT 0 COMMENT '字段名否匹配',
  `column_type_is_match` int(0) NULL DEFAULT 0 COMMENT '字段类型是否匹配',
  `column_comment_is_match` int(0) NULL DEFAULT 0 COMMENT '字段类型是否匹配',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_src_to_raw
-- ----------------------------
DROP TABLE IF EXISTS `analysis_src_to_raw`;
CREATE TABLE `analysis_src_to_raw`  (
  `data_source_table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据源表名',
  `file_addr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'kettle路径',
  `data_center_table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据中心表名',
  `is_match_azkaban` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否有调度',
  `hive_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '大数据平台表名',
  `ods_shell_file_addr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ods_shell文件路径',
  `ods_shell_stg_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ods_shell中stg表名',
  `ods_shell_ods_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ods_shell中ods表名'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_stg_sql_shell_columns_count
-- ----------------------------
DROP TABLE IF EXISTS `analysis_stg_sql_shell_columns_count`;
CREATE TABLE `analysis_stg_sql_shell_columns_count`  (
  `stg_shell_file_addr` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell文件路径',
  `stg_shell_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell文件名',
  `stg_shell_source_table_name` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell源表名',
  `stg_shell_stg_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell,stg表名',
  `stg_shell_all_columns_count` int(0) NULL DEFAULT 0 COMMENT 'stg_shell字段数',
  `stg_sql_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_sql文件名',
  `stg_sql_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_sql表名',
  `stg_sql_columns_count` int(0) NULL DEFAULT 0 COMMENT 'stg_sql字段数',
  `file_name_is_match` int(0) NULL DEFAULT 0 COMMENT '文件名是否匹配',
  `table_name_is_match` int(0) NULL DEFAULT 0 COMMENT '表名是否匹配',
  `columns_count_is_match` int(0) NULL DEFAULT 0 COMMENT '字段数是否匹配',
  `is_exclude` int(0) NULL DEFAULT 0 COMMENT '匹配特例表后是否排除',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for analysis_stg_sql_shell_columns_detail
-- ----------------------------
DROP TABLE IF EXISTS `analysis_stg_sql_shell_columns_detail`;
CREATE TABLE `analysis_stg_sql_shell_columns_detail`  (
  `stg_shell_file_addr` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell文件路径',
  `stg_shell_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell文件名',
  `stg_shell_source_table_name` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell源表名',
  `stg_shell_stg_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell,stg表名',
  `stg_shell_stg_column_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell字段名',
  `stg_shell_stg_column_order` int(0) NULL DEFAULT 0 COMMENT 'stg_shell字段顺序号',
  `stg_sql_file_addr` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_sql文件路径',
  `stg_sql_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_sql文件名',
  `stg_sql_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_sql表名',
  `stg_sql_column_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_sql字段名',
  `stg_sql_column_order` int(0) NULL DEFAULT 0 COMMENT 'stg_sql字段顺序号',
  `file_name_is_match` int(0) NULL DEFAULT 0 COMMENT '表名是否匹配',
  `table_name_is_match` int(0) NULL DEFAULT 0 COMMENT '表名是否匹配',
  `column_name_is_match` int(0) NULL DEFAULT 0 COMMENT '字段数是否匹配',
  `is_exclude` int(0) NULL DEFAULT 0 COMMENT '匹配特例表后是否排除',
  `stg_shell_parse_all_columns` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '解析后所有列名',
  `stg_shell_all_columns` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '原始所有列名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for azkaban_detail
-- ----------------------------
DROP TABLE IF EXISTS `azkaban_detail`;
CREATE TABLE `azkaban_detail`  (
  `file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件名',
  `parse_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '解析类型',
  `sub_file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件名',
  `flow_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'flow名称',
  `group_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'group名称',
  `job_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'job名称',
  `s_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell-s参数',
  `e_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell-e参数',
  `o_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg_shell-o参数',
  `g_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell-g参数',
  `k_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods_shell-k参数',
  `c_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'hive_file-c参数',
  `command` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '命令',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dim_analysis_process
-- ----------------------------
DROP TABLE IF EXISTS `dim_analysis_process`;
CREATE TABLE `dim_analysis_process`  (
  `database_info` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '数据库信息',
  `analysis_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '分析类型',
  `analysis_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '分析结果名',
  `analysis_comment` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dim_data_compare
-- ----------------------------
DROP TABLE IF EXISTS `dim_data_compare`;
CREATE TABLE `dim_data_compare`  (
  `hive_database` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '系统名',
  `sjzx_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '数据中心表名',
  `hive_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '大数据平台表名'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dim_dataware_hourse_task
-- ----------------------------
DROP TABLE IF EXISTS `dim_dataware_hourse_task`;
CREATE TABLE `dim_dataware_hourse_task`  (
  `job_id` int(0) NULL DEFAULT 0 COMMENT 'job_id',
  `task_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '任务名',
  `father_task_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '父任务名'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dim_exclude_detail
-- ----------------------------
DROP TABLE IF EXISTS `dim_exclude_detail`;
CREATE TABLE `dim_exclude_detail`  (
  `match_rule` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '匹配规则',
  `exclude_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '排除类型',
  `exclude_reason` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '排除原因'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dim_system_shortname
-- ----------------------------
DROP TABLE IF EXISTS `dim_system_shortname`;
CREATE TABLE `dim_system_shortname`  (
  `ods_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods系统简称',
  `jdbc_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'jdbc系统简称',
  `gkpt_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '管控平台系统简称',
  `system_comment` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '说明'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for dim_system_shortname_test
-- ----------------------------
DROP TABLE IF EXISTS `dim_system_shortname_test`;
CREATE TABLE `dim_system_shortname_test`  (
  `ods_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods系统简称',
  `jdbc_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'jdbc系统简称',
  `gkpt_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '管控平台系统简称',
  `system_comment` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '说明'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hive_file_detail
-- ----------------------------
DROP TABLE IF EXISTS `hive_file_detail`;
CREATE TABLE `hive_file_detail`  (
  `file_addr` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '解析文件路径',
  `file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '解析文件名',
  `ods_table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods表名',
  `all_columns_count` int(0) NULL DEFAULT 0 COMMENT '导出列个数',
  `all_columns` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '导出列',
  `partition_key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '分区字段',
  `where_condition` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'where条件',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hive_meta_columns_detail
-- ----------------------------
DROP TABLE IF EXISTS `hive_meta_columns_detail`;
CREATE TABLE `hive_meta_columns_detail`  (
  `table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名',
  `table_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表注释',
  `column_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段名',
  `column_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段类型',
  `column_comment` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段注释',
  `column_order` int(0) NULL DEFAULT 0 COMMENT '表字段顺序号'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hive_meta_columns_detail_test
-- ----------------------------
DROP TABLE IF EXISTS `hive_meta_columns_detail_test`;
CREATE TABLE `hive_meta_columns_detail_test`  (
  `table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名',
  `table_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表注释',
  `column_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段名',
  `column_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段类型',
  `column_comment` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段注释',
  `column_order` int(0) NULL DEFAULT 0 COMMENT '表字段顺序号'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hive_meta_tables_detail
-- ----------------------------
DROP TABLE IF EXISTS `hive_meta_tables_detail`;
CREATE TABLE `hive_meta_tables_detail`  (
  `table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名',
  `table_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表注释',
  `columns_count` int(0) NULL DEFAULT 0 COMMENT '字段数'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for hive_meta_tables_detail_test
-- ----------------------------
DROP TABLE IF EXISTS `hive_meta_tables_detail_test`;
CREATE TABLE `hive_meta_tables_detail_test`  (
  `table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名',
  `table_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表注释',
  `columns_count` int(0) NULL DEFAULT 0 COMMENT '字段数'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ods_shell_detail
-- ----------------------------
DROP TABLE IF EXISTS `ods_shell_detail`;
CREATE TABLE `ods_shell_detail`  (
  `file_addr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '解析文件路径',
  `file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '解析文件名',
  `source_table_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '源系统表名',
  `stg_table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg表名',
  `filter_key` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '增量字段',
  `xtjc` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '系统简称',
  `where_conditions` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'where条件',
  `all_columns_count` int(0) NULL DEFAULT NULL COMMENT '原始所有字段个数',
  `parse_all_columns` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '解析所有字段',
  `all_columns` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '原始所有字段',
  `ods_table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods表名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ods_sql_detail
-- ----------------------------
DROP TABLE IF EXISTS `ods_sql_detail`;
CREATE TABLE `ods_sql_detail`  (
  `file_addr` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件路径',
  `file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件名',
  `table_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名',
  `table_comment` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表注释',
  `columns_count` int(0) NULL DEFAULT 0 COMMENT '字段个数',
  `column_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段名',
  `column_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段类型',
  `column_comment` varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段注释',
  `column_order` int(0) NULL DEFAULT 0 COMMENT '字段顺序号',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for oracle_dchis_detail
-- ----------------------------
DROP TABLE IF EXISTS `oracle_dchis_detail`;
CREATE TABLE `oracle_dchis_detail`  (
  `file_addr` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件路径',
  `file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件名',
  `create_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'sql创建名',
  `table_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表类型',
  `table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for oracle_dcraw_detail
-- ----------------------------
DROP TABLE IF EXISTS `oracle_dcraw_detail`;
CREATE TABLE `oracle_dcraw_detail`  (
  `file_addr` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件路径',
  `file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件名',
  `create_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'sql创建名',
  `table_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表类型',
  `table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for oracle_dcrun_detail
-- ----------------------------
DROP TABLE IF EXISTS `oracle_dcrun_detail`;
CREATE TABLE `oracle_dcrun_detail`  (
  `file_addr` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件路径',
  `file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件名',
  `create_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'sql创建名',
  `table_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表类型',
  `table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for oracle_dcser_detail
-- ----------------------------
DROP TABLE IF EXISTS `oracle_dcser_detail`;
CREATE TABLE `oracle_dcser_detail`  (
  `file_addr` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件路径',
  `file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件名',
  `create_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'sql创建名',
  `table_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表类型',
  `table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for raw_to_ods_detail
-- ----------------------------
DROP TABLE IF EXISTS `raw_to_ods_detail`;
CREATE TABLE `raw_to_ods_detail`  (
  `file_addr` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '解析文件路径',
  `data_center_node` int(0) NULL DEFAULT 0 COMMENT '数据中心解析节点',
  `data_center_connection` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '数据中心连接地址',
  `data_center_table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '数据中心表名',
  `data_warehourse_node` int(0) NULL DEFAULT 0 COMMENT '数据仓库解析节点',
  `data_warehourse_connection` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '数据仓库连接地址',
  `data_warehourse_table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '数据仓库表名',
  `data_warehourse_save_table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '数据仓库归档表名',
  `http_url_project` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'http解析工程名',
  `http_url_file_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'http解析文件名',
  `http_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'http地址',
  `json_result` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '解析结果json',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for source_meta_columns_detail
-- ----------------------------
DROP TABLE IF EXISTS `source_meta_columns_detail`;
CREATE TABLE `source_meta_columns_detail`  (
  `table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名',
  `full_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '全表名',
  `table_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表注释',
  `column_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段名',
  `column_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段类型',
  `column_length` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段长度',
  `column_flo` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段精度',
  `column_comment` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段注释',
  `column_order` int(0) NULL DEFAULT 0 COMMENT '表字段顺序号'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for source_meta_columns_detail_test
-- ----------------------------
DROP TABLE IF EXISTS `source_meta_columns_detail_test`;
CREATE TABLE `source_meta_columns_detail_test`  (
  `table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名',
  `full_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '全表名',
  `table_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表注释',
  `column_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段名',
  `column_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段类型',
  `column_length` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段长度',
  `column_flo` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段精度',
  `column_comment` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段注释',
  `column_order` int(0) NULL DEFAULT 0 COMMENT '表字段顺序号'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for source_meta_tables_detail
-- ----------------------------
DROP TABLE IF EXISTS `source_meta_tables_detail`;
CREATE TABLE `source_meta_tables_detail`  (
  `table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名',
  `full_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '全表名',
  `table_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表注释',
  `columns_count` int(0) NULL DEFAULT 0 COMMENT '字段数'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for source_meta_tables_detail_test
-- ----------------------------
DROP TABLE IF EXISTS `source_meta_tables_detail_test`;
CREATE TABLE `source_meta_tables_detail_test`  (
  `table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名',
  `full_table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '全表名',
  `table_comment` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表注释',
  `columns_count` int(0) NULL DEFAULT 0 COMMENT '字段数'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for src_to_raw_detail
-- ----------------------------
DROP TABLE IF EXISTS `src_to_raw_detail`;
CREATE TABLE `src_to_raw_detail`  (
  `file_addr` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '解析文件路径',
  `data_source_node` int(0) NULL DEFAULT 0 COMMENT '源系统解析节点',
  `data_source_connection` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '源系统连接地址',
  `data_source_table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '源系统表名',
  `data_center_node` int(0) NULL DEFAULT 0 COMMENT '数据中心解析节点',
  `data_center_connection` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '数据中心连接地址',
  `data_center_table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '数据中心表名',
  `increment_fields` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '增量字段',
  `json_result` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '解析结果json',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for stg_shell_detail
-- ----------------------------
DROP TABLE IF EXISTS `stg_shell_detail`;
CREATE TABLE `stg_shell_detail`  (
  `file_addr` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '解析文件路径',
  `file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '解析文件名',
  `source_table_name` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '源系统表名',
  `stg_table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'stg表名',
  `filter_key` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '增量字段',
  `xtjc` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '系统简称',
  `where_conditions` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'where条件',
  `all_columns_count` int(0) NULL DEFAULT NULL COMMENT '原始所有字段个数',
  `parse_all_columns` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '解析所有字段',
  `all_columns` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '原始所有字段',
  `ods_table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'ods表名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for stg_sql_detail
-- ----------------------------
DROP TABLE IF EXISTS `stg_sql_detail`;
CREATE TABLE `stg_sql_detail`  (
  `file_addr` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件路径',
  `file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件名',
  `table_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名',
  `table_comment` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表注释',
  `columns_count` int(0) NULL DEFAULT 0 COMMENT '字段个数',
  `column_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段名',
  `column_type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段类型',
  `column_comment` varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '字段注释',
  `column_order` int(0) NULL DEFAULT 0 COMMENT '字段顺序号',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sybase_procedure_detail
-- ----------------------------
DROP TABLE IF EXISTS `sybase_procedure_detail`;
CREATE TABLE `sybase_procedure_detail`  (
  `file_addr` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件路径',
  `file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件名',
  `user_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户名',
  `procedure_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '存储过程名',
  `table_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表类型',
  `table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sybase_view_detail
-- ----------------------------
DROP TABLE IF EXISTS `sybase_view_detail`;
CREATE TABLE `sybase_view_detail`  (
  `file_addr` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件路径',
  `file_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '文件名',
  `user_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户名',
  `view_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '视图名',
  `table_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表类型',
  `table_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '表名',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for temp_analysis_src_to_raw
-- ----------------------------
DROP TABLE IF EXISTS `temp_analysis_src_to_raw`;
CREATE TABLE `temp_analysis_src_to_raw`  (
  `data_source_table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `file_addr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `data_center_table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_match` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `hive_table_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ods_shell_file_addr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ods_shell_stg_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `ods_shell_ods_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- View structure for ods_sql与hive_file字段名不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与hive_file字段名不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与hive_file字段名不一致` AS select `analysis_ods_hive_file_columns_detail`.`hive_file_addr` AS `hive_file路径`,`analysis_ods_hive_file_columns_detail`.`hive_file_name` AS `hive_file文件名`,`analysis_ods_hive_file_columns_detail`.`hive_file_ods_name` AS `hive_file-ods表名`,`analysis_ods_hive_file_columns_detail`.`ods_sql_table_name` AS `ods_sql表名`,`analysis_ods_hive_file_columns_detail`.`table_name_is_match` AS `表名是否匹配`,`analysis_ods_hive_file_columns_detail`.`hive_file_column_name` AS `hive_file字段名`,`analysis_ods_hive_file_columns_detail`.`ods_sql_column_name` AS `ods_sql字段名`,`analysis_ods_hive_file_columns_detail`.`column_name_is_match` AS `字段名是否匹配` from `analysis_ods_hive_file_columns_detail` where ((`analysis_ods_hive_file_columns_detail`.`table_name_is_match` = 1) and (`analysis_ods_hive_file_columns_detail`.`column_name_is_match` = 0)) order by `analysis_ods_hive_file_columns_detail`.`ods_sql_table_name`;

-- ----------------------------
-- View structure for ods_sql与hive_file表名不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与hive_file表名不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与hive_file表名不一致` AS select distinct `analysis_ods_hive_file_columns_detail`.`hive_file_addr` AS `hive_file路径`,`analysis_ods_hive_file_columns_detail`.`hive_file_name` AS `hive_file文件名`,`analysis_ods_hive_file_columns_detail`.`hive_file_ods_name` AS `hive_file-ods表名`,`analysis_ods_hive_file_columns_detail`.`ods_sql_table_name` AS `ods_sql表名`,`analysis_ods_hive_file_columns_detail`.`table_name_is_match` AS `表名是否匹配` from `analysis_ods_hive_file_columns_detail` where (`analysis_ods_hive_file_columns_detail`.`table_name_is_match` = 0) order by `analysis_ods_hive_file_columns_detail`.`ods_sql_table_name`;

-- ----------------------------
-- View structure for ods_sql与hive元数据字段名不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与hive元数据字段名不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与hive元数据字段名不一致` AS select `analysis_ods_hive_meta_columns_detail`.`ods_shell_file_addr` AS `ods_shell文件路径`,`analysis_ods_hive_meta_columns_detail`.`ods_shell_file_name` AS `ods_shell文件名`,`analysis_ods_hive_meta_columns_detail`.`ods_shell_ods_name` AS `ods_shell-ods表名`,`analysis_ods_hive_meta_columns_detail`.`ods_sql_table_name` AS `ods_sql表名`,`analysis_ods_hive_meta_columns_detail`.`bigdata_table_name` AS `hive元数据表名`,`analysis_ods_hive_meta_columns_detail`.`ods_table_name_is_match` AS `ods表名是否匹配`,`analysis_ods_hive_meta_columns_detail`.`bigdata_table_name_is_match` AS `hive元数据表名是否匹配`,`analysis_ods_hive_meta_columns_detail`.`ods_sql_column_name` AS `ods_sql字段名`,`analysis_ods_hive_meta_columns_detail`.`ods_sql_column_order` AS `ods_sql字段顺序号`,`analysis_ods_hive_meta_columns_detail`.`bigdata_column_name` AS `hive元数据字段名`,`analysis_ods_hive_meta_columns_detail`.`bigdata_column_order` AS `hive元数据表字段顺序号`,`analysis_ods_hive_meta_columns_detail`.`column_name_is_match` AS `字段名是否匹配` from `analysis_ods_hive_meta_columns_detail` where ((`analysis_ods_hive_meta_columns_detail`.`ods_table_name_is_match` = 1) and (`analysis_ods_hive_meta_columns_detail`.`bigdata_table_name_is_match` = 1) and (`analysis_ods_hive_meta_columns_detail`.`column_name_is_match` = 0)) order by `analysis_ods_hive_meta_columns_detail`.`ods_sql_table_name`;

-- ----------------------------
-- View structure for ods_sql与hive元数据字段数不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与hive元数据字段数不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与hive元数据字段数不一致` AS select `analysis_ods_hive_meta_columns_count`.`ods_shell_file_addr` AS `ods_shell文件路径`,`analysis_ods_hive_meta_columns_count`.`ods_shell_file_name` AS `ods_shell文件名`,`analysis_ods_hive_meta_columns_count`.`ods_shell_ods_name` AS `ods_shell-ods表名`,`analysis_ods_hive_meta_columns_count`.`ods_sql_table_name` AS `ods_sql表名`,`analysis_ods_hive_meta_columns_count`.`bigdata_table_name` AS `hive元数据表名`,`analysis_ods_hive_meta_columns_count`.`ods_table_name_is_match` AS `ods表名是否匹配`,`analysis_ods_hive_meta_columns_count`.`bigdata_table_name_is_match` AS `hive元数据表名是否匹配`,`analysis_ods_hive_meta_columns_count`.`ods_sql_columns_count` AS `ods_sql字段数`,`analysis_ods_hive_meta_columns_count`.`bigdata_columns_count` AS `hive元数据表字段个数`,`analysis_ods_hive_meta_columns_count`.`columns_count_is_match` AS `表字段个数是否匹配` from `analysis_ods_hive_meta_columns_count` where ((`analysis_ods_hive_meta_columns_count`.`ods_table_name_is_match` = 1) and (`analysis_ods_hive_meta_columns_count`.`bigdata_table_name_is_match` = 1) and (`analysis_ods_hive_meta_columns_count`.`columns_count_is_match` = 0)) order by `analysis_ods_hive_meta_columns_count`.`ods_sql_table_name`;

-- ----------------------------
-- View structure for ods_sql与hive元数据字段注释不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与hive元数据字段注释不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与hive元数据字段注释不一致` AS select `analysis_ods_hive_meta_columns_detail`.`ods_shell_file_addr` AS `ods_shell文件路径`,`analysis_ods_hive_meta_columns_detail`.`ods_shell_file_name` AS `ods_shell文件名`,`analysis_ods_hive_meta_columns_detail`.`ods_shell_ods_name` AS `ods_shell-ods表名`,`analysis_ods_hive_meta_columns_detail`.`ods_sql_table_name` AS `ods_sql表名`,`analysis_ods_hive_meta_columns_detail`.`bigdata_table_name` AS `hive元数据表名`,`analysis_ods_hive_meta_columns_detail`.`ods_table_name_is_match` AS `ods表名是否匹配`,`analysis_ods_hive_meta_columns_detail`.`bigdata_table_name_is_match` AS `hive元数据表名是否匹配`,`analysis_ods_hive_meta_columns_detail`.`ods_sql_column_name` AS `ods_sql字段名`,`analysis_ods_hive_meta_columns_detail`.`bigdata_column_name` AS `hive元数据字段名`,`analysis_ods_hive_meta_columns_detail`.`column_name_is_match` AS `字段名是否匹配`,`analysis_ods_hive_meta_columns_detail`.`ods_sql_column_comment` AS `ods_sql字段注释`,`analysis_ods_hive_meta_columns_detail`.`bigdata_column_comment` AS `hive元数据字段注释`,`analysis_ods_hive_meta_columns_detail`.`column_comment_is_match` AS `字段注释是否匹配` from `analysis_ods_hive_meta_columns_detail` where ((`analysis_ods_hive_meta_columns_detail`.`ods_table_name_is_match` = 1) and (`analysis_ods_hive_meta_columns_detail`.`bigdata_table_name_is_match` = 1) and (`analysis_ods_hive_meta_columns_detail`.`column_name_is_match` = 1) and (`analysis_ods_hive_meta_columns_detail`.`column_comment_is_match` = 0)) order by `analysis_ods_hive_meta_columns_detail`.`ods_sql_table_name`;

-- ----------------------------
-- View structure for ods_sql与hive元数据字段类型不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与hive元数据字段类型不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与hive元数据字段类型不一致` AS select `analysis_ods_hive_meta_columns_detail`.`ods_shell_file_addr` AS `ods_shell文件路径`,`analysis_ods_hive_meta_columns_detail`.`ods_shell_file_name` AS `ods_shell文件名`,`analysis_ods_hive_meta_columns_detail`.`ods_shell_ods_name` AS `ods_shell-ods表名`,`analysis_ods_hive_meta_columns_detail`.`ods_sql_table_name` AS `ods_sql表名`,`analysis_ods_hive_meta_columns_detail`.`bigdata_table_name` AS `hive元数据表名`,`analysis_ods_hive_meta_columns_detail`.`ods_table_name_is_match` AS `ods表名是否匹配`,`analysis_ods_hive_meta_columns_detail`.`bigdata_table_name_is_match` AS `hive元数据表名是否匹配`,`analysis_ods_hive_meta_columns_detail`.`ods_sql_column_name` AS `ods_sql字段名`,`analysis_ods_hive_meta_columns_detail`.`bigdata_column_name` AS `hive元数据字段名`,`analysis_ods_hive_meta_columns_detail`.`column_name_is_match` AS `字段名是否匹配`,`analysis_ods_hive_meta_columns_detail`.`ods_sql_column_type` AS `ods_sql字段类型`,`analysis_ods_hive_meta_columns_detail`.`bigdata_column_type` AS `hive元数据列类型`,`analysis_ods_hive_meta_columns_detail`.`column_type_is_match` AS `字段类型是否匹配` from `analysis_ods_hive_meta_columns_detail` where ((`analysis_ods_hive_meta_columns_detail`.`ods_table_name_is_match` = 1) and (`analysis_ods_hive_meta_columns_detail`.`bigdata_table_name_is_match` = 1) and (`analysis_ods_hive_meta_columns_detail`.`column_name_is_match` = 1) and (`analysis_ods_hive_meta_columns_detail`.`column_type_is_match` = 0)) order by `analysis_ods_hive_meta_columns_detail`.`ods_sql_table_name`;

-- ----------------------------
-- View structure for ods_sql与hive元数据表名不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与hive元数据表名不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与hive元数据表名不一致` AS select `analysis_ods_hive_meta_columns_count`.`ods_shell_file_addr` AS `ods_shell文件路径`,`analysis_ods_hive_meta_columns_count`.`ods_shell_file_name` AS `ods_shell文件名`,`analysis_ods_hive_meta_columns_count`.`ods_shell_ods_name` AS `ods_shell-ods表名`,`analysis_ods_hive_meta_columns_count`.`ods_sql_table_name` AS `ods_sql表名`,`analysis_ods_hive_meta_columns_count`.`bigdata_table_name` AS `hive元数据表名`,`analysis_ods_hive_meta_columns_count`.`ods_table_name_is_match` AS `ods表名是否匹配`,`analysis_ods_hive_meta_columns_count`.`bigdata_table_name_is_match` AS `hive元数据表名是否匹配` from `analysis_ods_hive_meta_columns_count` where ((`analysis_ods_hive_meta_columns_count`.`ods_table_name_is_match` = 0) or (`analysis_ods_hive_meta_columns_count`.`bigdata_table_name_is_match` = 0)) order by `analysis_ods_hive_meta_columns_count`.`ods_sql_table_name`;

-- ----------------------------
-- View structure for ods_sql与hive元数据表注释不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与hive元数据表注释不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与hive元数据表注释不一致` AS select `analysis_ods_hive_meta_columns_count`.`ods_shell_file_addr` AS `ods_shell文件路径`,`analysis_ods_hive_meta_columns_count`.`ods_shell_file_name` AS `ods_shell文件名`,`analysis_ods_hive_meta_columns_count`.`ods_shell_ods_name` AS `ods_shell-ods表名`,`analysis_ods_hive_meta_columns_count`.`ods_sql_table_name` AS `ods_sql表名`,`analysis_ods_hive_meta_columns_count`.`bigdata_table_name` AS `hive元数据表名`,`analysis_ods_hive_meta_columns_count`.`ods_table_name_is_match` AS `ods表名是否匹配`,`analysis_ods_hive_meta_columns_count`.`bigdata_table_name_is_match` AS `hive元数据表名是否匹配`,`analysis_ods_hive_meta_columns_count`.`ods_sql_table_comment` AS `ods_sql表注释`,`analysis_ods_hive_meta_columns_count`.`bigdata_table_comment` AS `hive元数据表注释`,`analysis_ods_hive_meta_columns_count`.`table_comment_is_match` AS `表注释是否匹配` from `analysis_ods_hive_meta_columns_count` where ((`analysis_ods_hive_meta_columns_count`.`ods_table_name_is_match` = 1) and (`analysis_ods_hive_meta_columns_count`.`bigdata_table_name_is_match` = 1) and (`analysis_ods_hive_meta_columns_count`.`table_comment_is_match` = 0)) order by `analysis_ods_hive_meta_columns_count`.`ods_sql_table_name`;

-- ----------------------------
-- View structure for ods_sql与stg_sql字段名不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与stg_sql字段名不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与stg_sql字段名不一致` AS select distinct `analysis_ods_stg_columns_detail`.`ods_shell_file_addr` AS `ods_shell文件路径`,`analysis_ods_stg_columns_detail`.`ods_shell_file_name` AS `ods_shell文件名`,`analysis_ods_stg_columns_detail`.`ods_shell_ods_name` AS `ods_shell-ods表名`,`analysis_ods_stg_columns_detail`.`ods_shell_stg_name` AS `ods_shell-stg表名`,`analysis_ods_stg_columns_detail`.`ods_sql_file_name` AS `ods_sql文件名`,`analysis_ods_stg_columns_detail`.`ods_sql_table_name` AS `ods_sql表名`,`analysis_ods_stg_columns_detail`.`stg_sql_file_name` AS `stg_sql文件名`,`analysis_ods_stg_columns_detail`.`stg_sql_table_name` AS `stg_sql表名`,`analysis_ods_stg_columns_detail`.`ods_table_name_is_match` AS `ods表名是否匹配`,`analysis_ods_stg_columns_detail`.`stg_table_name_is_match` AS `stg表名是否匹配`,`analysis_ods_stg_columns_detail`.`ods_sql_column_name` AS `ods_sql字段名`,`analysis_ods_stg_columns_detail`.`ods_sql_column_order` AS `ods_sql字段顺序号`,`analysis_ods_stg_columns_detail`.`stg_sql_column_name` AS `stg_sql字段名`,`analysis_ods_stg_columns_detail`.`stg_sql_column_order` AS `stg_sql字段顺序号`,`analysis_ods_stg_columns_detail`.`column_name_is_match` AS `字段名是否匹配` from `analysis_ods_stg_columns_detail` where ((`analysis_ods_stg_columns_detail`.`is_exclude` = 0) and (`analysis_ods_stg_columns_detail`.`ods_table_name_is_match` = 1) and (`analysis_ods_stg_columns_detail`.`stg_table_name_is_match` = 1) and (`analysis_ods_stg_columns_detail`.`column_name_is_match` = 0)) order by `analysis_ods_stg_columns_detail`.`ods_shell_ods_name`;

-- ----------------------------
-- View structure for ods_sql与stg_sql字段数不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与stg_sql字段数不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与stg_sql字段数不一致` AS select `analysis_ods_stg_columns_count`.`ods_shell_file_addr` AS `ods_shell文件路径`,`analysis_ods_stg_columns_count`.`ods_shell_file_name` AS `ods_shell文件名`,`analysis_ods_stg_columns_count`.`ods_shell_ods_name` AS `ods_shell-ods表名`,`analysis_ods_stg_columns_count`.`ods_shell_stg_name` AS `ods_shell-stg表名`,`analysis_ods_stg_columns_count`.`ods_sql_table_name` AS `ods_sql表名`,`analysis_ods_stg_columns_count`.`stg_sql_table_name` AS `stg_sql表名`,`analysis_ods_stg_columns_count`.`ods_table_name_is_match` AS `ods表名是否匹配`,`analysis_ods_stg_columns_count`.`stg_table_name_is_match` AS `stg表名是否匹配`,`analysis_ods_stg_columns_count`.`ods_sql_columns_count` AS `ods_sql字段数`,`analysis_ods_stg_columns_count`.`stg_sql_columns_count` AS `stg_sql字段数`,`analysis_ods_stg_columns_count`.`columns_count_is_match` AS `字段数是否匹配` from `analysis_ods_stg_columns_count` where ((`analysis_ods_stg_columns_count`.`is_exclude` = 0) and (`analysis_ods_stg_columns_count`.`ods_table_name_is_match` = 1) and (`analysis_ods_stg_columns_count`.`stg_table_name_is_match` = 1) and (`analysis_ods_stg_columns_count`.`columns_count_is_match` = 0)) order by `analysis_ods_stg_columns_count`.`ods_shell_ods_name`;

-- ----------------------------
-- View structure for ods_sql与stg_sql字段注释不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与stg_sql字段注释不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与stg_sql字段注释不一致` AS select `analysis_ods_stg_columns_detail`.`ods_shell_file_addr` AS `ods_shell文件路径`,`analysis_ods_stg_columns_detail`.`ods_shell_file_name` AS `ods_shell文件名`,`analysis_ods_stg_columns_detail`.`ods_shell_ods_name` AS `ods_shell-ods表名`,`analysis_ods_stg_columns_detail`.`ods_shell_stg_name` AS `ods_shell-stg表名`,`analysis_ods_stg_columns_detail`.`ods_sql_table_name` AS `ods_sql表名`,`analysis_ods_stg_columns_detail`.`stg_sql_table_name` AS `stg_sql表名`,`analysis_ods_stg_columns_detail`.`ods_table_name_is_match` AS `ods表名是否匹配`,`analysis_ods_stg_columns_detail`.`stg_table_name_is_match` AS `stg表名是否匹配`,`analysis_ods_stg_columns_detail`.`ods_sql_column_name` AS `ods_sql字段名`,`analysis_ods_stg_columns_detail`.`stg_sql_column_name` AS `stg_sql字段名`,`analysis_ods_stg_columns_detail`.`column_name_is_match` AS `字段名是否匹配`,`analysis_ods_stg_columns_detail`.`ods_sql_column_comment` AS `ods_sql字段注释`,`analysis_ods_stg_columns_detail`.`stg_sql_column_comment` AS `stg_sql字段注释`,`analysis_ods_stg_columns_detail`.`column_comment_is_match` AS `字段注释是否匹配` from `analysis_ods_stg_columns_detail` where ((`analysis_ods_stg_columns_detail`.`is_exclude` = 0) and (`analysis_ods_stg_columns_detail`.`ods_table_name_is_match` = 1) and (`analysis_ods_stg_columns_detail`.`stg_table_name_is_match` = 1) and (`analysis_ods_stg_columns_detail`.`column_name_is_match` = 1) and (`analysis_ods_stg_columns_detail`.`column_comment_is_match` = 0)) order by `analysis_ods_stg_columns_detail`.`ods_shell_ods_name`;

-- ----------------------------
-- View structure for ods_sql与stg_sql字段类型不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与stg_sql字段类型不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与stg_sql字段类型不一致` AS select `analysis_ods_stg_columns_detail`.`ods_shell_file_addr` AS `ods_shell文件路径`,`analysis_ods_stg_columns_detail`.`ods_shell_file_name` AS `ods_shell文件名`,`analysis_ods_stg_columns_detail`.`ods_shell_ods_name` AS `ods_shell-ods表名`,`analysis_ods_stg_columns_detail`.`ods_shell_stg_name` AS `ods_shell-stg表名`,`analysis_ods_stg_columns_detail`.`ods_sql_table_name` AS `ods_sql表名`,`analysis_ods_stg_columns_detail`.`stg_sql_table_name` AS `stg_sql表名`,`analysis_ods_stg_columns_detail`.`ods_table_name_is_match` AS `ods表名是否匹配`,`analysis_ods_stg_columns_detail`.`stg_table_name_is_match` AS `stg表名是否匹配`,`analysis_ods_stg_columns_detail`.`ods_sql_column_name` AS `ods_sql字段名`,`analysis_ods_stg_columns_detail`.`stg_sql_column_name` AS `stg_sql字段名`,`analysis_ods_stg_columns_detail`.`column_name_is_match` AS `字段名是否匹配`,`analysis_ods_stg_columns_detail`.`ods_sql_column_type` AS `ods_sql字段类型`,`analysis_ods_stg_columns_detail`.`stg_sql_column_type` AS `stg_sql字段类型`,`analysis_ods_stg_columns_detail`.`column_type_is_match` AS `字段类型是否匹配` from `analysis_ods_stg_columns_detail` where ((`analysis_ods_stg_columns_detail`.`is_exclude` = 0) and (`analysis_ods_stg_columns_detail`.`ods_table_name_is_match` = 1) and (`analysis_ods_stg_columns_detail`.`stg_table_name_is_match` = 1) and (`analysis_ods_stg_columns_detail`.`column_name_is_match` = 1) and (`analysis_ods_stg_columns_detail`.`column_type_is_match` = 0)) order by `analysis_ods_stg_columns_detail`.`ods_shell_ods_name`;

-- ----------------------------
-- View structure for ods_sql与stg_sql表名不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与stg_sql表名不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与stg_sql表名不一致` AS select `analysis_ods_stg_columns_count`.`ods_shell_file_addr` AS `ods_shell文件路径`,`analysis_ods_stg_columns_count`.`ods_shell_file_name` AS `ods_shell文件名`,`analysis_ods_stg_columns_count`.`ods_shell_ods_name` AS `ods_shell-ods表名`,`analysis_ods_stg_columns_count`.`ods_shell_stg_name` AS `ods_shell-stg表名`,`analysis_ods_stg_columns_count`.`ods_sql_table_name` AS `ods_sql表名`,`analysis_ods_stg_columns_count`.`stg_sql_table_name` AS `stg_sql表名`,`analysis_ods_stg_columns_count`.`ods_table_name_is_match` AS `ods表名是否匹配`,`analysis_ods_stg_columns_count`.`stg_table_name_is_match` AS `stg表名是否匹配` from `analysis_ods_stg_columns_count` where ((`analysis_ods_stg_columns_count`.`is_exclude` = 0) and ((`analysis_ods_stg_columns_count`.`ods_table_name_is_match` = 0) or (`analysis_ods_stg_columns_count`.`stg_table_name_is_match` = 0))) order by `analysis_ods_stg_columns_count`.`ods_shell_ods_name`;

-- ----------------------------
-- View structure for ods_sql与stg_sql表注释不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与stg_sql表注释不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与stg_sql表注释不一致` AS select `analysis_ods_stg_columns_count`.`ods_shell_file_addr` AS `ods_shell文件路径`,`analysis_ods_stg_columns_count`.`ods_shell_file_name` AS `ods_shell文件名`,`analysis_ods_stg_columns_count`.`ods_shell_ods_name` AS `ods_shell-ods表名`,`analysis_ods_stg_columns_count`.`ods_shell_stg_name` AS `ods_shell-stg表名`,`analysis_ods_stg_columns_count`.`ods_sql_table_name` AS `ods_sql表名`,`analysis_ods_stg_columns_count`.`stg_sql_table_name` AS `stg_sql表名`,`analysis_ods_stg_columns_count`.`ods_table_name_is_match` AS `ods表名是否匹配`,`analysis_ods_stg_columns_count`.`stg_table_name_is_match` AS `stg表名是否匹配`,`analysis_ods_stg_columns_count`.`ods_sql_table_comment` AS `ods_sql表注释`,`analysis_ods_stg_columns_count`.`stg_sql_table_comment` AS `stg_sql表注释`,`analysis_ods_stg_columns_count`.`table_comment_is_match` AS `表注释是否匹配` from `analysis_ods_stg_columns_count` where ((`analysis_ods_stg_columns_count`.`is_exclude` = 0) and (`analysis_ods_stg_columns_count`.`ods_table_name_is_match` = 1) and (`analysis_ods_stg_columns_count`.`stg_table_name_is_match` = 1) and (`analysis_ods_stg_columns_count`.`table_comment_is_match` = 0)) order by `analysis_ods_stg_columns_count`.`ods_shell_ods_name`;

-- ----------------------------
-- View structure for ods_sql与源数据字段名不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与源数据字段名不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与源数据字段名不一致` AS select `analysis_ods_source_meta_columns_detail`.`ods_shell_file_addr` AS `ods_shell路径`,`analysis_ods_source_meta_columns_detail`.`ods_shell_file_name` AS `ods_shell文件名`,`analysis_ods_source_meta_columns_detail`.`ods_shell_ods_name` AS `ods_shell-ods表名`,`analysis_ods_source_meta_columns_detail`.`stg_shell_xtjc` AS `stg_shell系统简称`,`analysis_ods_source_meta_columns_detail`.`stg_shell_source_table_name` AS `stg_shell源表名`,`analysis_ods_source_meta_columns_detail`.`full_stg_shell_source_table_name` AS `系统简称_stg_shell源表名`,`analysis_ods_source_meta_columns_detail`.`source_table_name` AS `源数据表名`,`analysis_ods_source_meta_columns_detail`.`ods_table_name_is_match` AS `ods表名是否匹配`,`analysis_ods_source_meta_columns_detail`.`source_table_name_is_match` AS `源表名是否匹配`,`analysis_ods_source_meta_columns_detail`.`ods_sql_column_name` AS `ods表字段数`,`analysis_ods_source_meta_columns_detail`.`source_column_name` AS `源表字段数`,`analysis_ods_source_meta_columns_detail`.`column_name_is_match` AS `字段名是否匹配` from `analysis_ods_source_meta_columns_detail` where ((`analysis_ods_source_meta_columns_detail`.`ods_table_name_is_match` = 1) and (`analysis_ods_source_meta_columns_detail`.`source_table_name_is_match` = 1) and (`analysis_ods_source_meta_columns_detail`.`column_name_is_match` = 0)) order by `analysis_ods_source_meta_columns_detail`.`stg_shell_source_table_name`;

-- ----------------------------
-- View structure for ods_sql与源数据字段数不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与源数据字段数不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与源数据字段数不一致` AS select distinct `analysis_ods_source_meta_columns_count`.`ods_shell_file_addr` AS `ods_shell路径`,`analysis_ods_source_meta_columns_count`.`ods_shell_file_name` AS `ods_shell文件名`,`analysis_ods_source_meta_columns_count`.`ods_shell_ods_name` AS `ods_shell-ods表名`,`analysis_ods_source_meta_columns_count`.`stg_shell_xtjc` AS `stg_shell系统简称`,`analysis_ods_source_meta_columns_count`.`stg_shell_source_table_name` AS `stg_shell源表名`,`analysis_ods_source_meta_columns_count`.`full_stg_shell_source_table_name` AS `系统简称_stg_shell源表名`,`analysis_ods_source_meta_columns_count`.`source_table_name` AS `源数据表名`,`analysis_ods_source_meta_columns_count`.`ods_table_name_is_match` AS `ods表名是否匹配`,`analysis_ods_source_meta_columns_count`.`source_table_name_is_match` AS `源表名是否匹配`,`analysis_ods_source_meta_columns_count`.`ods_sql_columns_count` AS `ods表字段数`,`analysis_ods_source_meta_columns_count`.`source_columns_count` AS `源表字段数`,`analysis_ods_source_meta_columns_count`.`columns_count_is_match` AS `字段数是否匹配` from `analysis_ods_source_meta_columns_count` where ((`analysis_ods_source_meta_columns_count`.`ods_table_name_is_match` = 1) and (`analysis_ods_source_meta_columns_count`.`source_table_name_is_match` = 1) and (`analysis_ods_source_meta_columns_count`.`columns_count_is_match` = 0)) order by `analysis_ods_source_meta_columns_count`.`stg_shell_source_table_name`;

-- ----------------------------
-- View structure for ods_sql与源数据字段注释不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与源数据字段注释不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与源数据字段注释不一致` AS select `analysis_ods_source_meta_columns_detail`.`ods_shell_file_addr` AS `ods_shell路径`,`analysis_ods_source_meta_columns_detail`.`ods_shell_file_name` AS `ods_shell文件名`,`analysis_ods_source_meta_columns_detail`.`ods_shell_ods_name` AS `ods_shell-ods表名`,`analysis_ods_source_meta_columns_detail`.`stg_shell_xtjc` AS `stg_shell系统简称`,`analysis_ods_source_meta_columns_detail`.`stg_shell_source_table_name` AS `stg_shell源表名`,`analysis_ods_source_meta_columns_detail`.`full_stg_shell_source_table_name` AS `系统简称_stg_shell源表名`,`analysis_ods_source_meta_columns_detail`.`source_table_name` AS `源数据表名`,`analysis_ods_source_meta_columns_detail`.`ods_table_name_is_match` AS `ods表名是否匹配`,`analysis_ods_source_meta_columns_detail`.`source_table_name_is_match` AS `源表名是否匹配`,`analysis_ods_source_meta_columns_detail`.`ods_sql_column_name` AS `ods表字段数`,`analysis_ods_source_meta_columns_detail`.`source_column_name` AS `源表字段数`,`analysis_ods_source_meta_columns_detail`.`column_name_is_match` AS `字段名是否匹配`,`analysis_ods_source_meta_columns_detail`.`ods_sql_column_comment` AS `ods字段注释`,`analysis_ods_source_meta_columns_detail`.`source_column_comment` AS `源表字段注释`,`analysis_ods_source_meta_columns_detail`.`column_comment_is_match` AS `字段注释是否匹配` from `analysis_ods_source_meta_columns_detail` where ((`analysis_ods_source_meta_columns_detail`.`ods_table_name_is_match` = 1) and (`analysis_ods_source_meta_columns_detail`.`source_table_name_is_match` = 1) and (`analysis_ods_source_meta_columns_detail`.`column_name_is_match` = 1) and (`analysis_ods_source_meta_columns_detail`.`column_comment_is_match` = 0)) order by `analysis_ods_source_meta_columns_detail`.`stg_shell_source_table_name`;

-- ----------------------------
-- View structure for ods_sql与源数据字段类型不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与源数据字段类型不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与源数据字段类型不一致` AS select `analysis_ods_source_meta_columns_detail`.`ods_shell_file_addr` AS `ods_shell路径`,`analysis_ods_source_meta_columns_detail`.`ods_shell_file_name` AS `ods_shell文件名`,`analysis_ods_source_meta_columns_detail`.`ods_shell_ods_name` AS `ods_shell-ods表名`,`analysis_ods_source_meta_columns_detail`.`stg_shell_xtjc` AS `stg_shell系统简称`,`analysis_ods_source_meta_columns_detail`.`stg_shell_source_table_name` AS `stg_shell源表名`,`analysis_ods_source_meta_columns_detail`.`full_stg_shell_source_table_name` AS `系统简称_stg_shell源表名`,`analysis_ods_source_meta_columns_detail`.`source_table_name` AS `源数据表名`,`analysis_ods_source_meta_columns_detail`.`ods_table_name_is_match` AS `ods表名是否匹配`,`analysis_ods_source_meta_columns_detail`.`source_table_name_is_match` AS `源表名是否匹配`,`analysis_ods_source_meta_columns_detail`.`ods_sql_column_name` AS `ods表字段名`,`analysis_ods_source_meta_columns_detail`.`source_column_name` AS `源表字段名`,`analysis_ods_source_meta_columns_detail`.`column_name_is_match` AS `字段名是否匹配`,`analysis_ods_source_meta_columns_detail`.`ods_sql_column_type` AS `ods字段类型`,`analysis_ods_source_meta_columns_detail`.`source_column_type` AS `源表字段类型`,`analysis_ods_source_meta_columns_detail`.`source_column_length` AS `源表字段长度`,`analysis_ods_source_meta_columns_detail`.`source_column_flo` AS `源表字段精度`,`analysis_ods_source_meta_columns_detail`.`column_type_is_match` AS `字段类型是否匹配` from `analysis_ods_source_meta_columns_detail` where ((`analysis_ods_source_meta_columns_detail`.`ods_table_name_is_match` = 1) and (`analysis_ods_source_meta_columns_detail`.`source_table_name_is_match` = 1) and (`analysis_ods_source_meta_columns_detail`.`column_name_is_match` = 1) and (`analysis_ods_source_meta_columns_detail`.`column_type_is_match` = 0)) order by `analysis_ods_source_meta_columns_detail`.`stg_shell_source_table_name`;

-- ----------------------------
-- View structure for ods_sql与源数据表名不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与源数据表名不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与源数据表名不一致` AS select `analysis_ods_source_meta_columns_count`.`ods_shell_file_addr` AS `ods_shell路径`,`analysis_ods_source_meta_columns_count`.`ods_shell_file_name` AS `ods_shell文件名`,`analysis_ods_source_meta_columns_count`.`ods_shell_ods_name` AS `ods_shell-ods表名`,`analysis_ods_source_meta_columns_count`.`stg_shell_xtjc` AS `stg_shell系统简称`,`analysis_ods_source_meta_columns_count`.`stg_shell_source_table_name` AS `stg_shell源表名`,`analysis_ods_source_meta_columns_count`.`full_stg_shell_source_table_name` AS `系统简称_stg_shell源表名`,`analysis_ods_source_meta_columns_count`.`source_table_name` AS `源数据表名`,`analysis_ods_source_meta_columns_count`.`ods_table_name_is_match` AS `ods表名是否匹配`,`analysis_ods_source_meta_columns_count`.`source_table_name_is_match` AS `源表名是否匹配` from `analysis_ods_source_meta_columns_count` where ((`analysis_ods_source_meta_columns_count`.`ods_table_name_is_match` = 0) or (`analysis_ods_source_meta_columns_count`.`source_table_name_is_match` = 0)) order by `analysis_ods_source_meta_columns_count`.`stg_shell_source_table_name`;

-- ----------------------------
-- View structure for ods_sql与源数据表注释不一致
-- ----------------------------
DROP VIEW IF EXISTS `ods_sql与源数据表注释不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ods_sql与源数据表注释不一致` AS select `analysis_ods_source_meta_columns_count`.`ods_shell_file_addr` AS `ods_shell路径`,`analysis_ods_source_meta_columns_count`.`ods_shell_file_name` AS `ods_shell文件名`,`analysis_ods_source_meta_columns_count`.`ods_shell_ods_name` AS `ods_shell-ods表名`,`analysis_ods_source_meta_columns_count`.`stg_shell_xtjc` AS `stg_shell系统简称`,`analysis_ods_source_meta_columns_count`.`stg_shell_source_table_name` AS `stg_shell源表名`,`analysis_ods_source_meta_columns_count`.`full_stg_shell_source_table_name` AS `系统简称_stg_shell源表名`,`analysis_ods_source_meta_columns_count`.`source_table_name` AS `源数据表名`,`analysis_ods_source_meta_columns_count`.`ods_table_name_is_match` AS `ods表名是否匹配`,`analysis_ods_source_meta_columns_count`.`source_table_name_is_match` AS `源表名是否匹配`,`analysis_ods_source_meta_columns_count`.`ods_sql_table_comment` AS `ods表名注释`,`analysis_ods_source_meta_columns_count`.`source_table_comment` AS `源表注释`,`analysis_ods_source_meta_columns_count`.`table_comment_is_match` AS `注释是否匹配` from `analysis_ods_source_meta_columns_count` where ((`analysis_ods_source_meta_columns_count`.`ods_table_name_is_match` = 1) and (`analysis_ods_source_meta_columns_count`.`source_table_name_is_match` = 1) and (`analysis_ods_source_meta_columns_count`.`table_comment_is_match` = 0)) order by `analysis_ods_source_meta_columns_count`.`stg_shell_source_table_name`;

-- ----------------------------
-- View structure for stg_sql与stg_shell字段名不一致
-- ----------------------------
DROP VIEW IF EXISTS `stg_sql与stg_shell字段名不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `stg_sql与stg_shell字段名不一致` AS select distinct `analysis_stg_sql_shell_columns_detail`.`stg_shell_file_addr` AS `stg_shell文件路径`,`analysis_stg_sql_shell_columns_detail`.`stg_shell_file_name` AS `stg_shell文件名`,`analysis_stg_sql_shell_columns_detail`.`stg_shell_stg_table_name` AS `stg_shell-stg表名`,`analysis_stg_sql_shell_columns_detail`.`stg_sql_file_name` AS `stg_sql文件名`,`analysis_stg_sql_shell_columns_detail`.`stg_sql_table_name` AS `stg_sql表名`,`analysis_stg_sql_shell_columns_detail`.`table_name_is_match` AS `表名是否匹配`,`analysis_stg_sql_shell_columns_detail`.`stg_shell_stg_column_name` AS `stg_shell字段名`,`analysis_stg_sql_shell_columns_detail`.`stg_shell_stg_column_order` AS `stg_shell字段顺序号`,`analysis_stg_sql_shell_columns_detail`.`stg_sql_column_name` AS `stg_sql字段名`,`analysis_stg_sql_shell_columns_detail`.`stg_sql_column_order` AS `stg_sql字段顺序号`,`analysis_stg_sql_shell_columns_detail`.`column_name_is_match` AS `字段名是否匹配` from `analysis_stg_sql_shell_columns_detail` where ((`analysis_stg_sql_shell_columns_detail`.`table_name_is_match` = 1) and (`analysis_stg_sql_shell_columns_detail`.`column_name_is_match` = 0)) order by `analysis_stg_sql_shell_columns_detail`.`stg_shell_stg_table_name`;

-- ----------------------------
-- View structure for stg_sql与stg_shell字段数不一致
-- ----------------------------
DROP VIEW IF EXISTS `stg_sql与stg_shell字段数不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `stg_sql与stg_shell字段数不一致` AS select `analysis_stg_sql_shell_columns_count`.`stg_shell_file_addr` AS `stg_shell文件路径`,`analysis_stg_sql_shell_columns_count`.`stg_shell_file_name` AS `stg_shell文件名`,`analysis_stg_sql_shell_columns_count`.`stg_shell_stg_table_name` AS `stg_shell-stg表名`,`analysis_stg_sql_shell_columns_count`.`stg_sql_file_name` AS `stg_sql文件名`,`analysis_stg_sql_shell_columns_count`.`stg_sql_table_name` AS `stg_sql表名`,`analysis_stg_sql_shell_columns_count`.`table_name_is_match` AS `表名是否匹配`,`analysis_stg_sql_shell_columns_count`.`stg_shell_all_columns_count` AS `stg_shell字段数`,`analysis_stg_sql_shell_columns_count`.`stg_sql_columns_count` AS `stg_sql字段数`,`analysis_stg_sql_shell_columns_count`.`columns_count_is_match` AS `字段数是否匹配` from `analysis_stg_sql_shell_columns_count` where ((`analysis_stg_sql_shell_columns_count`.`table_name_is_match` = 1) and (`analysis_stg_sql_shell_columns_count`.`columns_count_is_match` = 0)) order by `analysis_stg_sql_shell_columns_count`.`stg_shell_stg_table_name`;

-- ----------------------------
-- View structure for stg_sql与stg_shell表名不一致
-- ----------------------------
DROP VIEW IF EXISTS `stg_sql与stg_shell表名不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `stg_sql与stg_shell表名不一致` AS select `analysis_stg_sql_shell_columns_count`.`stg_shell_file_addr` AS `stg_shell文件路径`,`analysis_stg_sql_shell_columns_count`.`stg_shell_file_name` AS `stg_shell文件名`,`analysis_stg_sql_shell_columns_count`.`stg_shell_stg_table_name` AS `stg_shell-stg表名`,`analysis_stg_sql_shell_columns_count`.`stg_sql_file_name` AS `stg_sql文件名`,`analysis_stg_sql_shell_columns_count`.`stg_sql_table_name` AS `stg_sql表名`,`analysis_stg_sql_shell_columns_count`.`table_name_is_match` AS `表名是否匹配` from `analysis_stg_sql_shell_columns_count` where (`analysis_stg_sql_shell_columns_count`.`table_name_is_match` = 0) order by `analysis_stg_sql_shell_columns_count`.`stg_shell_stg_table_name`;

-- ----------------------------
-- View structure for 提供的系统简称
-- ----------------------------
DROP VIEW IF EXISTS `提供的系统简称`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `提供的系统简称` AS select `dim_system_shortname`.`ods_name` AS `ods库名`,`dim_system_shortname`.`jdbc_name` AS `jdbc名`,`dim_system_shortname`.`gkpt_name` AS `管控平台简称`,`dim_system_shortname`.`system_comment` AS `说明` from `dim_system_shortname` order by `dim_system_shortname`.`gkpt_name`;

-- ----------------------------
-- View structure for 提供的调度文件列表
-- ----------------------------
DROP VIEW IF EXISTS `提供的调度文件列表`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `提供的调度文件列表` AS select distinct `azkaban_detail`.`file_name` AS `文件名`,replace(replace(`azkaban_detail`.`file_name`,'P_',''),'.xlsx','') AS `拆分出的系统简称` from `azkaban_detail` order by `azkaban_detail`.`file_name`;

-- ----------------------------
-- View structure for 数据库梳理过程
-- ----------------------------
DROP VIEW IF EXISTS `数据库梳理过程`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `数据库梳理过程` AS select `dim_analysis_process`.`database_info` AS `数据库信息`,`dim_analysis_process`.`analysis_type` AS `分析类型`,`dim_analysis_process`.`analysis_name` AS `分析结果名`,`dim_analysis_process`.`analysis_comment` AS `备注` from `dim_analysis_process` order by `dim_analysis_process`.`analysis_type`;

-- ----------------------------
-- View structure for 数据比对_azkaban生成视图
-- ----------------------------
DROP VIEW IF EXISTS `数据比对_azkaban生成视图`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `数据比对_azkaban生成视图` AS select distinct `dim_data_compare_basic`.`xt_name` AS `第一列不要粘贴`,'TDCDB186' AS `source_database`,'DCRAW' AS `yh_schema`,`dim_data_compare_basic`.`source_table_name` AS `source_table_name`,`dim_data_compare_basic`.`sjzx_hive_database` AS `sjzx_hive_database`,`dim_data_compare_basic`.`sjzx_hive_table_name` AS `sjzx_hive_table_name`,'parquet' AS `storage_mode`,'marketDays' AS `increment_type`,'oc_date' AS `collect_partition`,'' AS `collect_addition_column`,'\\001' AS `distribution_segment`,'part_init_date' AS `distribution_partition`,'' AS `distribution_addition_column`,'' AS `distribution_column`,concat('/home/azkaban/projects/cmp_',`dim_data_compare_basic`.`xt_name`) AS `script_store_address`,'TRUE' AS `is_collect`,'table' AS `is_view`,'' AS `is_id_increment`,substring_index(`dim_data_compare_basic`.`sjzx_hive_database`,'_',-(1)) AS `xtjc` from `dim_data_compare_basic` order by `dim_data_compare_basic`.`xt_name`;

-- ----------------------------
-- View structure for 数据比对_没有oc_date的表
-- ----------------------------
DROP VIEW IF EXISTS `数据比对_没有oc_date的表`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `数据比对_没有oc_date的表` AS select `t1`.`xt_name` AS `xt_name`,`t1`.`source_table_name` AS `source_table_name`,`t1`.`oc_date_index` AS `oc_date_index`,`t1`.`group_concat(column_name)` AS `group_concat(column_name)` from (select `dim_data_compare_basic`.`xt_name` AS `xt_name`,`dim_data_compare_basic`.`source_table_name` AS `source_table_name`,find_in_set('oc_date',group_concat(`dim_data_compare_basic`.`column_name` separator ',')) AS `oc_date_index`,group_concat(`dim_data_compare_basic`.`column_name` separator ',') AS `group_concat(column_name)` from `dim_data_compare_basic` group by `dim_data_compare_basic`.`xt_name`,`dim_data_compare_basic`.`source_table_name` order by `dim_data_compare_basic`.`xt_name`) `t1` where ((`t1`.`oc_date_index` is null) or (`t1`.`oc_date_index` = 0));

-- ----------------------------
-- View structure for 数据比对_脚本制作_hive
-- ----------------------------
DROP VIEW IF EXISTS `数据比对_脚本制作_hive`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `数据比对_脚本制作_hive` AS select distinct upper(`dim_data_compare_result`.`source_table_name`) AS `source_table_name`,upper(`dim_data_compare_result`.`xt_name`) AS `xt_name`,upper(`dim_data_compare_result`.`hive_database`) AS `hive_database`,upper(`dim_data_compare_result`.`hive_table_name`) AS `hive_table_name`,'1' AS `sequence_number` from `dim_data_compare_result` order by `source_table_name`,`xt_name`;

-- ----------------------------
-- View structure for 数据比对_脚本制作_内容比较
-- ----------------------------
DROP VIEW IF EXISTS `数据比对_脚本制作_内容比较`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `数据比对_脚本制作_内容比较` AS select upper(`dim_data_compare_result`.`source_table_name`) AS `source_table_name`,upper(`dim_data_compare_result`.`xt_name`) AS `xt_name`,upper(`dim_data_compare_result`.`hive_database`) AS `hive_database`,upper(`dim_data_compare_result`.`sjzx_hive_database`) AS `sjzx_hive_database`,upper(`dim_data_compare_result`.`sjzx_hive_table_name`) AS `sjzx_hive_table_name`,upper(`dim_data_compare_result`.`hive_table_name`) AS `hive_table_name`,upper(`dim_data_compare_result`.`column_name`) AS `column_name`,`dim_data_compare_result`.`column_order` AS `column_order` from `dim_data_compare_result` order by upper(`dim_data_compare_result`.`source_table_name`),upper(`dim_data_compare_result`.`xt_name`);

-- ----------------------------
-- View structure for 数据比对_脚本制作_差异比较
-- ----------------------------
DROP VIEW IF EXISTS `数据比对_脚本制作_差异比较`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `数据比对_脚本制作_差异比较` AS select upper(`dim_data_compare_result`.`source_table_name`) AS `source_table_name`,upper(`dim_data_compare_result`.`xt_name`) AS `xt_name`,upper(`dim_data_compare_result`.`hive_database`) AS `hive_database`,upper(`dim_data_compare_result`.`sjzx_hive_database`) AS `sjzx_hive_database`,upper(`dim_data_compare_result`.`sjzx_hive_table_name`) AS `sjzx_hive_table_name`,upper(`dim_data_compare_result`.`hive_table_name`) AS `hive_table_name`,upper(`dim_data_compare_result`.`column_name`) AS `column_name`,upper(`dim_data_compare_result`.`column_order`) AS `column_order` from `dim_data_compare_result` order by upper(`dim_data_compare_result`.`source_table_name`),upper(`dim_data_compare_result`.`xt_name`);

-- ----------------------------
-- View structure for 数据比对_脚本制作_数据中心
-- ----------------------------
DROP VIEW IF EXISTS `数据比对_脚本制作_数据中心`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `数据比对_脚本制作_数据中心` AS select distinct upper(`dim_data_compare_result`.`source_table_name`) AS `source_table_name`,upper(`dim_data_compare_result`.`xt_name`) AS `xt_name`,upper(`dim_data_compare_result`.`sjzx_hive_database`) AS `sjzx_hive_database`,upper(`dim_data_compare_result`.`sjzx_hive_table_name`) AS `sjzx_hive_table_name`,'1' AS `sequence_number` from `dim_data_compare_result` order by `source_table_name`,`xt_name`;

-- ----------------------------
-- View structure for 没有调度的ods表
-- ----------------------------
DROP VIEW IF EXISTS `没有调度的ods表`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `没有调度的ods表` AS select distinct `analysis_azkaban_ods_sql`.`file_addr` AS `ods_sql路径`,`analysis_azkaban_ods_sql`.`table_name` AS `ods_sql表名` from `analysis_azkaban_ods_sql` where (`analysis_azkaban_ods_sql`.`is_match_azkaban` = 0) order by `analysis_azkaban_ods_sql`.`table_name`;

-- ----------------------------
-- View structure for 测试环境hive元数据与生产环境hive元数据字段名不一致
-- ----------------------------
DROP VIEW IF EXISTS `测试环境hive元数据与生产环境hive元数据字段名不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `测试环境hive元数据与生产环境hive元数据字段名不一致` AS select distinct `analysis_hive_meta_columns_detail`.`online_table_name` AS `生产环境表名`,`analysis_hive_meta_columns_detail`.`test_table_name` AS `测试环境表名`,`analysis_hive_meta_columns_detail`.`table_name_is_match` AS `表名是匹配`,`analysis_hive_meta_columns_detail`.`online_column_name` AS `生产环境字段名`,`analysis_hive_meta_columns_detail`.`online_column_order` AS `生产环境字段顺序号`,`analysis_hive_meta_columns_detail`.`test_column_name` AS `测试环境字段名`,`analysis_hive_meta_columns_detail`.`test_column_order` AS `测试环境字段顺序号`,`analysis_hive_meta_columns_detail`.`column_name_is_match` AS `字段名是否配` from `analysis_hive_meta_columns_detail` where ((`analysis_hive_meta_columns_detail`.`table_name_is_match` = 1) and (`analysis_hive_meta_columns_detail`.`column_name_is_match` = 0)) order by `analysis_hive_meta_columns_detail`.`online_table_name`;

-- ----------------------------
-- View structure for 测试环境hive元数据与生产环境hive元数据字段数不一致
-- ----------------------------
DROP VIEW IF EXISTS `测试环境hive元数据与生产环境hive元数据字段数不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `测试环境hive元数据与生产环境hive元数据字段数不一致` AS select distinct `analysis_hive_meta_columns_count`.`online_table_name` AS `生产环境表名`,`analysis_hive_meta_columns_count`.`test_table_name` AS `测试环境表名`,`analysis_hive_meta_columns_count`.`table_name_is_match` AS `表名是匹配`,`analysis_hive_meta_columns_count`.`online_columns_count` AS `生产环境字段数`,`analysis_hive_meta_columns_count`.`test_columns_count` AS `测试环境字段数`,`analysis_hive_meta_columns_count`.`columns_count_is_match` AS `字段数是否匹配` from `analysis_hive_meta_columns_count` where ((`analysis_hive_meta_columns_count`.`table_name_is_match` = 1) and (`analysis_hive_meta_columns_count`.`columns_count_is_match` = 0)) order by `analysis_hive_meta_columns_count`.`online_table_name`;

-- ----------------------------
-- View structure for 测试环境hive元数据与生产环境hive元数据字段注释不一致
-- ----------------------------
DROP VIEW IF EXISTS `测试环境hive元数据与生产环境hive元数据字段注释不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `测试环境hive元数据与生产环境hive元数据字段注释不一致` AS select distinct `analysis_hive_meta_columns_detail`.`online_table_name` AS `生产环境表名`,`analysis_hive_meta_columns_detail`.`test_table_name` AS `测试环境表名`,`analysis_hive_meta_columns_detail`.`table_name_is_match` AS `表名是匹配`,`analysis_hive_meta_columns_detail`.`online_column_name` AS `生产环境字段名`,`analysis_hive_meta_columns_detail`.`test_column_name` AS `测试环境字段名`,`analysis_hive_meta_columns_detail`.`column_name_is_match` AS `字段名是否配`,`analysis_hive_meta_columns_detail`.`online_column_comment` AS `生产环境字段注释`,`analysis_hive_meta_columns_detail`.`test_column_comment` AS `测试环境字段注释`,`analysis_hive_meta_columns_detail`.`column_comment_is_match` AS `字段注释是否匹配` from `analysis_hive_meta_columns_detail` where ((`analysis_hive_meta_columns_detail`.`table_name_is_match` = 1) and (`analysis_hive_meta_columns_detail`.`column_name_is_match` = 1) and (`analysis_hive_meta_columns_detail`.`column_comment_is_match` = 0)) order by `analysis_hive_meta_columns_detail`.`online_table_name`;

-- ----------------------------
-- View structure for 测试环境hive元数据与生产环境hive元数据字段类型不一致
-- ----------------------------
DROP VIEW IF EXISTS `测试环境hive元数据与生产环境hive元数据字段类型不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `测试环境hive元数据与生产环境hive元数据字段类型不一致` AS select distinct `analysis_hive_meta_columns_detail`.`online_table_name` AS `生产环境表名`,`analysis_hive_meta_columns_detail`.`test_table_name` AS `测试环境表名`,`analysis_hive_meta_columns_detail`.`table_name_is_match` AS `表名是匹配`,`analysis_hive_meta_columns_detail`.`online_column_name` AS `生产环境字段名`,`analysis_hive_meta_columns_detail`.`test_column_name` AS `测试环境字段名`,`analysis_hive_meta_columns_detail`.`column_name_is_match` AS `字段名是否配`,`analysis_hive_meta_columns_detail`.`online_column_type` AS `生产环境字段类型`,`analysis_hive_meta_columns_detail`.`test_column_type` AS `测试环境字段类型`,`analysis_hive_meta_columns_detail`.`column_type_is_match` AS `字段类型是否匹配` from `analysis_hive_meta_columns_detail` where ((`analysis_hive_meta_columns_detail`.`table_name_is_match` = 1) and (`analysis_hive_meta_columns_detail`.`column_name_is_match` = 1) and (`analysis_hive_meta_columns_detail`.`column_type_is_match` = 0)) order by `analysis_hive_meta_columns_detail`.`online_table_name`;

-- ----------------------------
-- View structure for 测试环境hive元数据与生产环境hive元数据表名不一致
-- ----------------------------
DROP VIEW IF EXISTS `测试环境hive元数据与生产环境hive元数据表名不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `测试环境hive元数据与生产环境hive元数据表名不一致` AS select `analysis_hive_meta_columns_count`.`online_table_name` AS `生产环境表名`,`analysis_hive_meta_columns_count`.`test_table_name` AS `测试环境表名`,`analysis_hive_meta_columns_count`.`table_name_is_match` AS `表名是匹配` from `analysis_hive_meta_columns_count` where (`analysis_hive_meta_columns_count`.`table_name_is_match` = 0) order by `analysis_hive_meta_columns_count`.`online_table_name`;

-- ----------------------------
-- View structure for 测试环境hive元数据与生产环境hive元数据表注释不一致
-- ----------------------------
DROP VIEW IF EXISTS `测试环境hive元数据与生产环境hive元数据表注释不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `测试环境hive元数据与生产环境hive元数据表注释不一致` AS select `analysis_hive_meta_columns_count`.`online_table_name` AS `生产环境表名`,`analysis_hive_meta_columns_count`.`test_table_name` AS `测试环境表名`,`analysis_hive_meta_columns_count`.`table_name_is_match` AS `表名是匹配`,`analysis_hive_meta_columns_count`.`online_table_comment` AS `生产环境表注释`,`analysis_hive_meta_columns_count`.`test_table_comment` AS `测试环境表注释`,`analysis_hive_meta_columns_count`.`table_comment_is_match` AS `表注释是否匹配` from `analysis_hive_meta_columns_count` where ((`analysis_hive_meta_columns_count`.`table_name_is_match` = 1) and (`analysis_hive_meta_columns_count`.`table_comment_is_match` = 0)) order by `analysis_hive_meta_columns_count`.`online_table_name`;

-- ----------------------------
-- View structure for 测试环境源数据与生产环境源数据字段名不一致
-- ----------------------------
DROP VIEW IF EXISTS `测试环境源数据与生产环境源数据字段名不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `测试环境源数据与生产环境源数据字段名不一致` AS select distinct `analysis_source_meta_columns_detail`.`online_table_name` AS `生产环境表名`,`analysis_source_meta_columns_detail`.`test_table_name` AS `测试环境表名`,`analysis_source_meta_columns_detail`.`table_name_is_match` AS `表名是匹配`,`analysis_source_meta_columns_detail`.`online_column_name` AS `生产环境字段名`,`analysis_source_meta_columns_detail`.`online_column_order` AS `生产环境字段顺序号`,`analysis_source_meta_columns_detail`.`test_column_name` AS `测试环境字段名`,`analysis_source_meta_columns_detail`.`test_column_order` AS `测试环境字段顺序号`,`analysis_source_meta_columns_detail`.`column_name_is_match` AS `字段名是否配` from `analysis_source_meta_columns_detail` where ((`analysis_source_meta_columns_detail`.`table_name_is_match` = 1) and (`analysis_source_meta_columns_detail`.`column_name_is_match` = 0)) order by `analysis_source_meta_columns_detail`.`online_table_name`;

-- ----------------------------
-- View structure for 测试环境源数据与生产环境源数据字段数不一致
-- ----------------------------
DROP VIEW IF EXISTS `测试环境源数据与生产环境源数据字段数不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `测试环境源数据与生产环境源数据字段数不一致` AS select distinct `analysis_source_meta_columns_count`.`online_table_name` AS `生产环境表名`,`analysis_source_meta_columns_count`.`test_table_name` AS `测试环境表名`,`analysis_source_meta_columns_count`.`table_name_is_match` AS `表名是匹配`,`analysis_source_meta_columns_count`.`online_columns_count` AS `生产环境字段数`,`analysis_source_meta_columns_count`.`test_columns_count` AS `测试环境字段数`,`analysis_source_meta_columns_count`.`columns_count_is_match` AS `字段数是否匹配` from `analysis_source_meta_columns_count` where ((`analysis_source_meta_columns_count`.`table_name_is_match` = 1) and (`analysis_source_meta_columns_count`.`columns_count_is_match` = 0)) order by `analysis_source_meta_columns_count`.`online_table_name`;

-- ----------------------------
-- View structure for 测试环境源数据与生产环境源数据字段注释不一致
-- ----------------------------
DROP VIEW IF EXISTS `测试环境源数据与生产环境源数据字段注释不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `测试环境源数据与生产环境源数据字段注释不一致` AS select distinct `analysis_source_meta_columns_detail`.`online_table_name` AS `生产环境表名`,`analysis_source_meta_columns_detail`.`test_table_name` AS `测试环境表名`,`analysis_source_meta_columns_detail`.`table_name_is_match` AS `表名是匹配`,`analysis_source_meta_columns_detail`.`online_column_name` AS `生产环境字段名`,`analysis_source_meta_columns_detail`.`test_column_name` AS `测试环境字段名`,`analysis_source_meta_columns_detail`.`column_name_is_match` AS `字段名是否配`,`analysis_source_meta_columns_detail`.`online_column_comment` AS `生产环境字段注释`,`analysis_source_meta_columns_detail`.`test_column_comment` AS `测试环境字段注释`,`analysis_source_meta_columns_detail`.`column_comment_is_match` AS `字段注释是否匹配` from `analysis_source_meta_columns_detail` where ((`analysis_source_meta_columns_detail`.`table_name_is_match` = 1) and (`analysis_source_meta_columns_detail`.`column_name_is_match` = 1) and (`analysis_source_meta_columns_detail`.`column_comment_is_match` = 0)) order by `analysis_source_meta_columns_detail`.`online_table_name`;

-- ----------------------------
-- View structure for 测试环境源数据与生产环境源数据字段类型不一致
-- ----------------------------
DROP VIEW IF EXISTS `测试环境源数据与生产环境源数据字段类型不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `测试环境源数据与生产环境源数据字段类型不一致` AS select distinct `analysis_source_meta_columns_detail`.`online_table_name` AS `生产环境表名`,`analysis_source_meta_columns_detail`.`test_table_name` AS `测试环境表名`,`analysis_source_meta_columns_detail`.`table_name_is_match` AS `表名是匹配`,`analysis_source_meta_columns_detail`.`online_column_name` AS `生产环境字段名`,`analysis_source_meta_columns_detail`.`test_column_name` AS `测试环境字段名`,`analysis_source_meta_columns_detail`.`column_name_is_match` AS `字段名是否配`,`analysis_source_meta_columns_detail`.`online_column_type` AS `生产环境字段类型`,`analysis_source_meta_columns_detail`.`test_column_type` AS `测试环境字段类型`,`analysis_source_meta_columns_detail`.`column_type_is_match` AS `字段类型是否匹配` from `analysis_source_meta_columns_detail` where ((`analysis_source_meta_columns_detail`.`table_name_is_match` = 1) and (`analysis_source_meta_columns_detail`.`column_name_is_match` = 1) and (`analysis_source_meta_columns_detail`.`column_type_is_match` = 0)) order by `analysis_source_meta_columns_detail`.`online_table_name`;

-- ----------------------------
-- View structure for 测试环境源数据与生产环境源数据表名不一致
-- ----------------------------
DROP VIEW IF EXISTS `测试环境源数据与生产环境源数据表名不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `测试环境源数据与生产环境源数据表名不一致` AS select `analysis_source_meta_columns_count`.`online_table_name` AS `生产环境表名`,`analysis_source_meta_columns_count`.`test_table_name` AS `测试环境表名`,`analysis_source_meta_columns_count`.`table_name_is_match` AS `表名是匹配` from `analysis_source_meta_columns_count` where (`analysis_source_meta_columns_count`.`table_name_is_match` = 0) order by `analysis_source_meta_columns_count`.`online_table_name`;

-- ----------------------------
-- View structure for 测试环境源数据与生产环境源数据表注释不一致
-- ----------------------------
DROP VIEW IF EXISTS `测试环境源数据与生产环境源数据表注释不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `测试环境源数据与生产环境源数据表注释不一致` AS select `analysis_source_meta_columns_count`.`online_table_name` AS `生产环境表名`,`analysis_source_meta_columns_count`.`test_table_name` AS `测试环境表名`,`analysis_source_meta_columns_count`.`table_name_is_match` AS `表名是匹配`,`analysis_source_meta_columns_count`.`online_table_comment` AS `生产环境表注释`,`analysis_source_meta_columns_count`.`test_table_comment` AS `测试环境表注释`,`analysis_source_meta_columns_count`.`table_comment_is_match` AS `表注释是否匹配` from `analysis_source_meta_columns_count` where ((`analysis_source_meta_columns_count`.`table_name_is_match` = 1) and (`analysis_source_meta_columns_count`.`table_comment_is_match` = 0)) order by `analysis_source_meta_columns_count`.`online_table_name`;

-- ----------------------------
-- View structure for 源数据中所有的系统简称
-- ----------------------------
DROP VIEW IF EXISTS `源数据中所有的系统简称`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `源数据中所有的系统简称` AS select distinct lower(substring_index(`source_meta_tables_detail`.`table_name`,'.',1)) AS `系统简称` from `source_meta_tables_detail` order by '系统简称';

-- ----------------------------
-- View structure for 特例表
-- ----------------------------
DROP VIEW IF EXISTS `特例表`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `特例表` AS select `dim_exclude_detail`.`match_rule` AS `匹配规则`,`dim_exclude_detail`.`exclude_type` AS `排除类型`,`dim_exclude_detail`.`exclude_reason` AS `排除原因` from `dim_exclude_detail` order by `dim_exclude_detail`.`exclude_type`;

-- ----------------------------
-- View structure for 生产源表元数据和stg_shell源表表名不一致
-- ----------------------------
DROP VIEW IF EXISTS `生产源表元数据和stg_shell源表表名不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `生产源表元数据和stg_shell源表表名不一致` AS select `analysis_source_hive_meta_columns_count`.`ods_shell_file_addr` AS `ods_shell路径`,`analysis_source_hive_meta_columns_count`.`ods_shell_ods_name` AS `ods_shell中ods表名`,`analysis_source_hive_meta_columns_count`.`stg_shell_file_name` AS `stg_shell文件名`,`analysis_source_hive_meta_columns_count`.`stg_shell_source_table_name` AS `stg_shell源表名`,`analysis_source_hive_meta_columns_count`.`full_source_table_name` AS `系统简称_源表名`,`analysis_source_hive_meta_columns_count`.`hive_meta_table_is_match` AS `hive元数据表名是否匹配`,`analysis_source_hive_meta_columns_count`.`source_meta_table_is_match` AS `源表名是否匹配` from `analysis_source_hive_meta_columns_count` where ((`analysis_source_hive_meta_columns_count`.`hive_meta_table_is_match` = 0) or (`analysis_source_hive_meta_columns_count`.`source_meta_table_is_match` = 0)) order by `analysis_source_hive_meta_columns_count`.`ods_shell_ods_name`;

-- ----------------------------
-- View structure for 生产源表元数据和stg_shell源表表字段名不一致
-- ----------------------------
DROP VIEW IF EXISTS `生产源表元数据和stg_shell源表表字段名不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `生产源表元数据和stg_shell源表表字段名不一致` AS select `analysis_source_hive_meta_columns_detail`.`ods_shell_file_addr` AS `ods_shell路径`,`analysis_source_hive_meta_columns_detail`.`ods_shell_ods_name` AS `ods_shell中ods表名`,`analysis_source_hive_meta_columns_detail`.`stg_shell_file_name` AS `stg_shell文件名`,`analysis_source_hive_meta_columns_detail`.`stg_shell_source_table_name` AS `stg_shell源表名`,`analysis_source_hive_meta_columns_detail`.`full_source_table_name` AS `系统简称_源表名`,`analysis_source_hive_meta_columns_detail`.`hive_meta_table_is_match` AS `hive元数据表名是否匹配`,`analysis_source_hive_meta_columns_detail`.`source_meta_table_is_match` AS `源表名是否匹配`,`analysis_source_hive_meta_columns_detail`.`hive_meta_column_name` AS `hive元数据字段名`,`analysis_source_hive_meta_columns_detail`.`source_meta_column_name` AS `源数据表字段名`,`analysis_source_hive_meta_columns_detail`.`column_name_is_match` AS `字段名是否匹配` from `analysis_source_hive_meta_columns_detail` where ((`analysis_source_hive_meta_columns_detail`.`hive_meta_table_is_match` = 1) and (`analysis_source_hive_meta_columns_detail`.`source_meta_table_is_match` = 1) and (`analysis_source_hive_meta_columns_detail`.`column_name_is_match` = 0)) order by `analysis_source_hive_meta_columns_detail`.`ods_shell_ods_name`;

-- ----------------------------
-- View structure for 生产源表元数据和stg_shell源表表字段数不一致
-- ----------------------------
DROP VIEW IF EXISTS `生产源表元数据和stg_shell源表表字段数不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `生产源表元数据和stg_shell源表表字段数不一致` AS select `analysis_source_hive_meta_columns_count`.`ods_shell_file_addr` AS `ods_shell路径`,`analysis_source_hive_meta_columns_count`.`ods_shell_ods_name` AS `ods_shell中ods表名`,`analysis_source_hive_meta_columns_count`.`stg_shell_file_name` AS `stg_shell文件名`,`analysis_source_hive_meta_columns_count`.`stg_shell_source_table_name` AS `stg_shell源表名`,`analysis_source_hive_meta_columns_count`.`full_source_table_name` AS `系统简称_源表名`,`analysis_source_hive_meta_columns_count`.`hive_meta_table_is_match` AS `hive元数据表名是否匹配`,`analysis_source_hive_meta_columns_count`.`source_meta_table_is_match` AS `源表名是否匹配`,`analysis_source_hive_meta_columns_count`.`hive_meta_columns_count` AS `hive元数据表字段数`,`analysis_source_hive_meta_columns_count`.`source_meta_columns_count` AS `源数据表字段数`,`analysis_source_hive_meta_columns_count`.`columns_count_is_match` AS `字段数是否匹配` from `analysis_source_hive_meta_columns_count` where ((`analysis_source_hive_meta_columns_count`.`hive_meta_table_is_match` = 1) and (`analysis_source_hive_meta_columns_count`.`source_meta_table_is_match` = 1) and (`analysis_source_hive_meta_columns_count`.`columns_count_is_match` = 0)) order by `analysis_source_hive_meta_columns_count`.`ods_shell_ods_name`;

-- ----------------------------
-- View structure for 生产源表元数据和stg_shell源表表字段注释不一致
-- ----------------------------
DROP VIEW IF EXISTS `生产源表元数据和stg_shell源表表字段注释不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `生产源表元数据和stg_shell源表表字段注释不一致` AS select `analysis_source_hive_meta_columns_detail`.`ods_shell_file_addr` AS `ods_shell路径`,`analysis_source_hive_meta_columns_detail`.`ods_shell_ods_name` AS `ods_shell中ods表名`,`analysis_source_hive_meta_columns_detail`.`stg_shell_file_name` AS `stg_shell文件名`,`analysis_source_hive_meta_columns_detail`.`stg_shell_source_table_name` AS `stg_shell源表名`,`analysis_source_hive_meta_columns_detail`.`full_source_table_name` AS `系统简称_源表名`,`analysis_source_hive_meta_columns_detail`.`hive_meta_table_is_match` AS `hive元数据表名是否匹配`,`analysis_source_hive_meta_columns_detail`.`source_meta_table_is_match` AS `源表名是否匹配`,`analysis_source_hive_meta_columns_detail`.`hive_meta_column_name` AS `hive元数据字段名`,`analysis_source_hive_meta_columns_detail`.`source_meta_column_name` AS `源数据表字段名`,`analysis_source_hive_meta_columns_detail`.`column_name_is_match` AS `字段名是否匹配`,`analysis_source_hive_meta_columns_detail`.`hive_meta_column_comment` AS `hive元数据字段注释`,`analysis_source_hive_meta_columns_detail`.`source_meta_column_comment` AS `源数据字段注释`,`analysis_source_hive_meta_columns_detail`.`column_comment_is_match` AS `字段注释是否匹配` from `analysis_source_hive_meta_columns_detail` where ((`analysis_source_hive_meta_columns_detail`.`hive_meta_table_is_match` = 1) and (`analysis_source_hive_meta_columns_detail`.`source_meta_table_is_match` = 1) and (`analysis_source_hive_meta_columns_detail`.`column_name_is_match` = 1) and (`analysis_source_hive_meta_columns_detail`.`column_comment_is_match` = 0)) order by `analysis_source_hive_meta_columns_detail`.`ods_shell_ods_name`;

-- ----------------------------
-- View structure for 生产源表元数据和stg_shell源表表字段类型不一致
-- ----------------------------
DROP VIEW IF EXISTS `生产源表元数据和stg_shell源表表字段类型不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `生产源表元数据和stg_shell源表表字段类型不一致` AS select `analysis_source_hive_meta_columns_detail`.`ods_shell_file_addr` AS `ods_shell路径`,`analysis_source_hive_meta_columns_detail`.`ods_shell_ods_name` AS `ods_shell中ods表名`,`analysis_source_hive_meta_columns_detail`.`stg_shell_file_name` AS `stg_shell文件名`,`analysis_source_hive_meta_columns_detail`.`stg_shell_source_table_name` AS `stg_shell源表名`,`analysis_source_hive_meta_columns_detail`.`full_source_table_name` AS `系统简称_源表名`,`analysis_source_hive_meta_columns_detail`.`hive_meta_table_is_match` AS `hive元数据表名是否匹配`,`analysis_source_hive_meta_columns_detail`.`source_meta_table_is_match` AS `源表名是否匹配`,`analysis_source_hive_meta_columns_detail`.`hive_meta_column_name` AS `hive元数据字段名`,`analysis_source_hive_meta_columns_detail`.`source_meta_column_name` AS `源数据表字段名`,`analysis_source_hive_meta_columns_detail`.`column_name_is_match` AS `字段名是否匹配`,`analysis_source_hive_meta_columns_detail`.`hive_meta_column_type` AS `hive元数据字段类型`,`analysis_source_hive_meta_columns_detail`.`source_meta_column_type` AS `源数据字段类型`,`analysis_source_hive_meta_columns_detail`.`source_meta_column_length` AS `源数据字段长度`,`analysis_source_hive_meta_columns_detail`.`source_meta_column_flo` AS `源数据字段精度`,`analysis_source_hive_meta_columns_detail`.`column_type_is_match` AS `字段类型是否匹配` from `analysis_source_hive_meta_columns_detail` where ((`analysis_source_hive_meta_columns_detail`.`hive_meta_table_is_match` = 1) and (`analysis_source_hive_meta_columns_detail`.`source_meta_table_is_match` = 1) and (`analysis_source_hive_meta_columns_detail`.`column_name_is_match` = 1) and (`analysis_source_hive_meta_columns_detail`.`column_type_is_match` = 0)) order by `analysis_source_hive_meta_columns_detail`.`ods_shell_ods_name`;

-- ----------------------------
-- View structure for 生产源表元数据和stg_shell源表表注释不一致
-- ----------------------------
DROP VIEW IF EXISTS `生产源表元数据和stg_shell源表表注释不一致`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `生产源表元数据和stg_shell源表表注释不一致` AS select `analysis_source_hive_meta_columns_count`.`ods_shell_file_addr` AS `ods_shell路径`,`analysis_source_hive_meta_columns_count`.`ods_shell_ods_name` AS `ods_shell中ods表名`,`analysis_source_hive_meta_columns_count`.`stg_shell_file_name` AS `stg_shell文件名`,`analysis_source_hive_meta_columns_count`.`stg_shell_source_table_name` AS `stg_shell源表名`,`analysis_source_hive_meta_columns_count`.`full_source_table_name` AS `系统简称_源表名`,`analysis_source_hive_meta_columns_count`.`hive_meta_table_is_match` AS `hive元数据表名是否匹配`,`analysis_source_hive_meta_columns_count`.`source_meta_table_is_match` AS `源表名是否匹配`,`analysis_source_hive_meta_columns_count`.`hive_meta_table_comment` AS `hive元数据表注释`,`analysis_source_hive_meta_columns_count`.`source_meta_table_comment` AS `源数据表注释`,`analysis_source_hive_meta_columns_count`.`table_comment_is_match` AS `表注释是否匹配` from `analysis_source_hive_meta_columns_count` where ((`analysis_source_hive_meta_columns_count`.`hive_meta_table_is_match` = 1) and (`analysis_source_hive_meta_columns_count`.`source_meta_table_is_match` = 1) and (`analysis_source_hive_meta_columns_count`.`table_comment_is_match` = 0)) order by `analysis_source_hive_meta_columns_count`.`ods_shell_ods_name`;

-- ----------------------------
-- View structure for 重复调用之azkaban
-- ----------------------------
DROP VIEW IF EXISTS `重复调用之azkaban`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `重复调用之azkaban` AS select `tt1`.`file_name` AS `文件名`,`tt1`.`parse_type` AS `解析类型`,`tt1`.`sub_file_name` AS `子文件名`,`tt1`.`job_name` AS `job名`,`tt1`.`command` AS `命令` from (select `t1`.`file_name` AS `file_name`,`t1`.`parse_type` AS `parse_type`,`t1`.`sub_file_name` AS `sub_file_name`,`t1`.`job_name` AS `job_name`,`t1`.`command` AS `command`,sum((case when (`t1`.`sub_file_name` like concat(`t2`.`match_rule`,'%')) then 1 else 0 end)) AS `is_exclude` from (`azkaban_detail` `t1` left join (select distinct `dim_exclude_detail`.`match_rule` AS `match_rule` from `dim_exclude_detail` where (`dim_exclude_detail`.`exclude_type` = 'azkaban')) `t2` on((1 = 1))) where `t1`.`sub_file_name` in (select `azkaban_detail`.`sub_file_name` from `azkaban_detail` group by `azkaban_detail`.`sub_file_name` having (count(1) > 1)) group by `t1`.`file_name`,`t1`.`parse_type`,`t1`.`sub_file_name`,`t1`.`job_name`,`t1`.`command`) `tt1` where (`tt1`.`is_exclude` = 0) order by `tt1`.`sub_file_name`;

-- ----------------------------
-- View structure for 重复调用之hive_file
-- ----------------------------
DROP VIEW IF EXISTS `重复调用之hive_file`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `重复调用之hive_file` AS select `analysis_azkaban_hive_file`.`file_addr` AS `文件路径`,`analysis_azkaban_hive_file`.`file_name` AS `文件名`,`analysis_azkaban_hive_file`.`ods_table_name` AS `ods表名`,ifnull(`analysis_azkaban_hive_file`.`azkaban_file_name`,'') AS `调度文件名`,`analysis_azkaban_hive_file`.`is_match_azkaban` AS `是否有调度`,ifnull(`analysis_azkaban_hive_file`.`azkaban_job_name`,'') AS `job名` from `analysis_azkaban_hive_file` where `analysis_azkaban_hive_file`.`ods_table_name` in (select `hive_file_detail`.`ods_table_name` from `hive_file_detail` group by `hive_file_detail`.`ods_table_name` having (count(1) > 1)) order by `analysis_azkaban_hive_file`.`ods_table_name`;

-- ----------------------------
-- View structure for 重复调用之ods_shell
-- ----------------------------
DROP VIEW IF EXISTS `重复调用之ods_shell`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `重复调用之ods_shell` AS select `analysis_azkaban_ods_shell`.`file_addr` AS `文件路径`,`analysis_azkaban_ods_shell`.`file_name` AS `文件名`,`analysis_azkaban_ods_shell`.`stg_table_name` AS `stg表名`,`analysis_azkaban_ods_shell`.`ods_table_name` AS `ods表名`,ifnull(`analysis_azkaban_ods_shell`.`azkaban_file_name`,'') AS `调度文件名`,`analysis_azkaban_ods_shell`.`is_match_azkaban` AS `是否有调度`,ifnull(`analysis_azkaban_ods_shell`.`azkaban_job_name`,'') AS `job名` from `analysis_azkaban_ods_shell` where (`analysis_azkaban_ods_shell`.`ods_table_name` in (select `ods_shell_detail`.`ods_table_name` from `ods_shell_detail` group by `ods_shell_detail`.`ods_table_name` having (count(1) > 1)) and (`analysis_azkaban_ods_shell`.`stg_table_name` <> '.')) order by `analysis_azkaban_ods_shell`.`ods_table_name`;

-- ----------------------------
-- View structure for 重复调用之stg_shell
-- ----------------------------
DROP VIEW IF EXISTS `重复调用之stg_shell`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `重复调用之stg_shell` AS select `analysis_azkaban_stg_shell`.`file_addr` AS `文件路径`,`analysis_azkaban_stg_shell`.`file_name` AS `文件名`,`analysis_azkaban_stg_shell`.`source_table_name` AS `源表名`,`analysis_azkaban_stg_shell`.`stg_table_name` AS `stg表名`,ifnull(`analysis_azkaban_stg_shell`.`azkaban_file_name`,'') AS `调度文件名`,`analysis_azkaban_stg_shell`.`is_match_azkaban` AS `是否有调度`,ifnull(`analysis_azkaban_stg_shell`.`azkaban_job_name`,'') AS `job名` from `analysis_azkaban_stg_shell` where `analysis_azkaban_stg_shell`.`source_table_name` in (select `stg_shell_detail`.`source_table_name` from `stg_shell_detail` group by `stg_shell_detail`.`source_table_name` having (count(1) > 1)) order by `analysis_azkaban_stg_shell`.`source_table_name`;

-- ----------------------------
-- Procedure structure for p_compare_azkaban_ods_stg_hive_file
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_compare_azkaban_ods_stg_hive_file`;
delimiter ;;
CREATE PROCEDURE `p_compare_azkaban_ods_stg_hive_file`()
BEGIN
alter table ods_sql_detail add index file_name_index (file_name);
alter table stg_sql_detail add index file_name_index (file_name);
alter table stg_shell_detail add index file_name_index (file_name);
alter table ods_shell_detail add index file_name_index (file_name);
alter table hive_file_detail add index file_name_index(file_name);
alter table azkaban_detail add index sub_file_name_index (sub_file_name);

-- 备注
-- 1.azkaban_detail 调度文件中可能包含重复行,注意检查
-- 查找重复数据
-- select file_name,command,job_name,count(1) from azkaban_detail group by file_name,command,job_name having count(1) > 1;
-- select * from azkaban_detail where job_name = 'J_stg_val_tgjs_yhzqxx_sql';		

truncate table analysis_azkaban_ods_sql;
insert into analysis_azkaban_ods_sql 
select  
	t1.file_addr 
	,t1.file_name 
	,t1.table_name 
	,t1.table_comment 
	,t1.columns_count  
	,t1.column_name 
	,t1.column_type 
	,t1.column_comment 
	,t1.column_order 
	,(case when t2.sub_file_name is null then 0 else 1 end) as is_match_azkaban 
	,t2.file_name as azkaban_file_name 
	,t2.job_name as azkaban_job_name
	,now() as create_time 
	,now() as modify_time 
from ods_sql_detail t1 
left join (select distinct file_name,sub_file_name,job_name from azkaban_detail where parse_type = 'ods_sql') t2 on t1.file_name = t2.sub_file_name 
;

truncate table analysis_azkaban_stg_sql;
insert into analysis_azkaban_stg_sql 
select  
	t1.file_addr 
	,t1.file_name 
	,t1.table_name 
	,t1.table_comment 
	,t1.columns_count 
	,t1.column_name 
	,t1.column_type 
	,t1.column_comment 
	,t1.column_order 
	,(case when t2.sub_file_name is null then 0 else 1 end) as is_match_azkaban 
	,t2.file_name as azkaban_file_name 
	,t2.job_name as azkaban_job_name 
	,now() as create_time 
	,now() as modify_time 
from stg_sql_detail t1 
left join (select distinct file_name,sub_file_name,job_name from azkaban_detail where parse_type = 'stg_sql') t2 on t1.file_name = t2.sub_file_name 
;

truncate table analysis_azkaban_ods_shell;
insert into analysis_azkaban_ods_shell 
select  
	t1.file_addr 
	,t1.file_name 
	,t1.stg_table_name 
	,t1.ods_table_name 
	,(case when t2.sub_file_name is null then 0 else 1 end) as is_match_azkaban 
	,t2.file_name as azkaban_file_name 
	,t2.job_name as azkaban_job_name 
	,now() as create_time 
	,now() as modify_time 
from ods_shell_detail t1 
left join (select distinct file_name,sub_file_name,job_name from azkaban_detail where parse_type = 'ods_shell') t2 on t1.file_name = t2.sub_file_name 
;

truncate table analysis_azkaban_stg_shell;
insert into analysis_azkaban_stg_shell 
select  
	t1.file_addr 
	,t1.file_name 
	,t1.source_table_name 
	,t1.stg_table_name 
	,t1.filter_key 
	,t1.xtjc 
	,t1.all_columns_count 
	,(case when t2.sub_file_name is null then 0 else 1 end) as is_match_azkaban 
	,t2.file_name as azkaban_file_name 
	,t2.job_name as azkaban_job_name 
	,t1.parse_all_columns 
	,t1.all_columns 
	,now() as create_time 
	,now() as modify_time 
from stg_shell_detail t1 
left join (select distinct file_name,sub_file_name,job_name from azkaban_detail where parse_type = 'stg_shell') t2 on t1.file_name = t2.sub_file_name 
;

truncate table analysis_azkaban_hive_file;
insert into analysis_azkaban_hive_file 
select 
	t1.file_addr 
	,t1.file_name 
	,t1.ods_table_name
	,t1.all_columns_count
	,t1.all_columns
	,(case when t2.sub_file_name is null then 0 else 1 end) is_match_azkaban -- 0:未匹配到 1:匹配到
	,t2.file_name as azkaban_file_name 
	,t2.job_name as azkaban_job_name 
	,current_date() as create_time 
	,current_date() as modify_time  
from hive_file_detail t1 -- 解析 hive_file 后结果表
left join (select distinct file_name,sub_file_name,job_name from azkaban_detail where parse_type = 'hive_file') t2 on t1.file_name = t2.sub_file_name 
;

alter table analysis_azkaban_stg_shell add index stg_table_name_index(stg_table_name);
truncate table analysis_azkaban_src_to_bigdata;
insert into analysis_azkaban_src_to_bigdata 
select  
	t1.file_addr as ods_shell_file_addr  
	,t1.file_name as ods_shell_file_name  
	,t1.ods_table_name as ods_shell_ods_name
	,t1.stg_table_name as ods_shell_stg_name
	,t1.is_match_azkaban as ods_shell_is_match_azkaban 
	,t1.azkaban_file_name as ods_shell_azkaban_file_name
	,t1.azkaban_job_name as ods_shell_azkaban_job_name
	,t2.file_name as stg_shell_file_name 
	,t2.stg_table_name as stg_shell_stg_name 
	,t2.source_table_name as stg_shell_source_table_name 
	,t2.xtjc as stg_shell_xtjc 
	,t2.all_columns_count as stg_shell_all_columns_count 
	,t2.is_match_azkaban as stg_shell_is_match_azkaban 
	,t2.azkaban_file_name as stg_shell_azkaban_file_name
	,t2.azkaban_job_name as stg_shell_azkaban_job_name 
	,t2.parse_all_columns as stg_shell_parse_all_columns
	,t2.all_columns as stg_shell_all_columns 
	,current_date() as create_time 
	,current_date() as modify_time  
from analysis_azkaban_ods_shell t1 
left join analysis_azkaban_stg_shell t2 on t1.stg_table_name = t2.stg_table_name 
where trim(t1.stg_table_name) <> '.'
;

alter table ods_sql_detail drop index file_name_index;
alter table stg_sql_detail drop index file_name_index;
alter table stg_shell_detail drop index file_name_index;
alter table ods_shell_detail drop index file_name_index;
alter table hive_file_detail drop index file_name_index;
alter table azkaban_detail drop index sub_file_name_index;
alter table analysis_azkaban_stg_shell drop index stg_table_name_index;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for p_compare_hive_meta_test_vs_hive_meta_pro
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_compare_hive_meta_test_vs_hive_meta_pro`;
delimiter ;;
CREATE PROCEDURE `p_compare_hive_meta_test_vs_hive_meta_pro`()
BEGIN
alter table hive_meta_tables_detail add index table_name_index(table_name);
alter table hive_meta_tables_detail_test add index table_name_index(table_name);
alter table hive_meta_columns_detail add index table_name_order_index(table_name,column_order);
alter table hive_meta_columns_detail_test add index table_name_order_index(table_name,column_order);

-- 双向表级
truncate table analysis_hive_meta_columns_count;
insert into analysis_hive_meta_columns_count 
select distinct
	tt1.*
	,now() as create_time
	,now() as modify_time
from (
	select 
		t1.table_name as online_table_name
		,ifnull(t1.table_comment,'') as online_table_comment
		,t1.columns_count as online_columns_count
		,ifnull(t2.table_name,'') as test_table_name
		,ifnull(t2.table_comment,'') as test_table_comment
		,t2.columns_count as test_columns_count
		,(case when t2.table_name is null then 0 else 1 end) as table_name_is_match
		,(case when trim(t1.table_comment) is null or trim(t1.table_comment) = '' or lower(t1.table_comment) <> lower(t2.table_comment) then 0 else 1 end) as table_comment_is_match
		,(case when t1.columns_count = t2.columns_count then 1 else 0 end) as columns_count_is_match 
	from hive_meta_tables_detail t1 
	left join hive_meta_tables_detail_test t2 on t1.table_name = t2.table_name 
	union 
	select 
		ifnull(t2.table_name,'') as online_table_name
		,ifnull(t2.table_comment,'') as online_table_comment
		,t2.columns_count as online_columns_count
		,t1.table_name as test_table_name
		,ifnull(t1.table_comment,'') as test_table_comment
		,t1.columns_count as test_columns_count
		,(case when t2.table_name is null then 0 else 1 end) as table_name_is_match
		,(case when trim(t1.table_comment) is null or trim(t1.table_comment) = '' or lower(t1.table_comment) <> lower(t2.table_comment) then 0 else 1 end) as table_comment_is_match
		,(case when t1.columns_count = t2.columns_count then 1 else 0 end) as columns_count_is_match 
	from hive_meta_tables_detail_test t1 
	left join hive_meta_tables_detail t2 on t1.table_name = t2.table_name 
) tt1 
where tt1.table_name_is_match = 0 or -- 表名不匹配
tt1.table_comment_is_match = 0 or -- 表注释不匹配
tt1.columns_count_is_match = 0 -- 字段数不匹配
;

-- 双向字段级
truncate table analysis_hive_meta_columns_detail;
insert into analysis_hive_meta_columns_detail 
select distinct
	tt1.*
	,now() as create_time
	,now() as modify_time
from (
	select 
		t1.table_name as online_table_name
		,t1.column_name as online_column_name
		,t1.column_type as online_column_type
		,ifnull(t1.column_comment,'') as online_column_comment
		,t1.column_order as online_column_order
		,t2.table_name as test_table_name
		,t2.column_name as test_column_name
		,t2.column_type as test_column_type
		,ifnull(t2.column_comment,'') as test_column_comment
		,t2.column_order as test_column_order
		,(case when t2.table_name is null then 0 else 1 end) as table_name_is_match
		,(case when t1.column_name = t2.column_name then 1 else 0 end) as column_name_is_match 
		,(case when t1.column_type = t2.column_type then 1 else 0 end) as column_type_is_match 
		,(case when trim(t1.column_comment) = '' or trim(t1.column_comment) is null or lower(t1.column_comment) <> lower(t2.column_comment) then 0 else 1 end) as column_comment_is_match 
	from hive_meta_columns_detail t1 
	left join hive_meta_columns_detail_test t2 on t1.table_name = t2.table_name and t1.column_order = t2.column_order 
	union 
	select 
		t2.table_name as online_table_name
		,t2.column_name as online_column_name
		,t2.column_type as online_column_type
		,ifnull(t2.column_comment,'') as online_column_comment
		,t2.column_order as online_column_order
		,t1.table_name as test_table_name
		,t1.column_name as test_column_name
		,t1.column_type as test_column_type
		,ifnull(t1.column_comment,'') as test_column_comment
		,t1.column_order as test_column_order
		,(case when t2.table_name is null then 0 else 1 end) as table_name_is_match
		,(case when t1.column_name = t2.column_name then 1 else 0 end) as column_name_is_match 
		,(case when t1.column_type = t2.column_type then 1 else 0 end) as column_type_is_match 
		,(case when trim(t1.column_comment) = '' or trim(t1.column_comment) is null or lower(t1.column_comment) <> lower(t2.column_comment) then 0 else 1 end) as column_comment_is_match 
	from hive_meta_columns_detail_test t1 
	left join hive_meta_columns_detail t2 on t1.table_name = t2.table_name and t1.column_order = t2.column_order 
) tt1 
where tt1.table_name_is_match = 0 or -- 表名不匹配
tt1.column_name_is_match = 0 or -- 字段名不匹配
tt1.column_type_is_match = 0 or -- 字段类型不匹配
tt1.column_comment_is_match = 0 -- 字段注释不匹配
;

alter table hive_meta_tables_detail drop index table_name_index;
alter table hive_meta_tables_detail_test drop index table_name_index;
alter table hive_meta_columns_detail drop index table_name_order_index;
alter table hive_meta_columns_detail_test drop index table_name_order_index;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for p_compare_ods_sql_vs_hive_file
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_compare_ods_sql_vs_hive_file`;
delimiter ;;
CREATE PROCEDURE `p_compare_ods_sql_vs_hive_file`()
BEGIN
alter table ods_sql_detail add index table_column_name_index (table_name,column_name);

truncate table analysis_ods_hive_file_columns_detail;
insert into analysis_ods_hive_file_columns_detail   
select distinct
	tt1.* 
from (
	select  
		t1.file_addr as hive_file_addr
		,t1.file_name as hive_file_name
		,t1.ods_table_name as hive_file_ods_name
		,substring_index(substring_index(t1.all_columns,',',t2.help_topic_id + 1),',',-1) as hive_file_column_name  
		,(t2.help_topic_id + 1) as hive_file_column_order
		,t4.table_name as ods_sql_table_name
		,t3.column_name as ods_sql_column_name
		,t3.column_order as ods_sql_column_order
		,(case when t4.table_name is not null then 1 else 0 end) table_name_is_match 
		,(case when t3.table_name is not null then 1 else 0 end) as column_name_is_match 
		,t1.all_columns as hive_file_all_columns
		,current_date() as create_time
		,current_date() as modify_time
	from analysis_azkaban_hive_file t1 
	inner join mysql.help_topic t2 on t2.help_topic_id < (length(t1.all_columns) - length(replace(t1.all_columns,',','')) + 1)
	left join ods_sql_detail t3 on t1.ods_table_name = t3.table_name and substring_index(substring_index(t1.all_columns,',',t2.help_topic_id + 1),',',-1) = t3.column_name
	left join (select distinct table_name from ods_sql_detail) t4 on t1.ods_table_name = t4.table_name
	where t1.is_match_azkaban = 1
) tt1 
where tt1.table_name_is_match = 0 or -- 表名不匹配
tt1.column_name_is_match = 0 -- 字段名不匹配
;

-- 分析完删索引
alter table ods_sql_detail drop index table_column_name_index;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for p_compare_ods_sql_vs_hive_meta_pro
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_compare_ods_sql_vs_hive_meta_pro`;
delimiter ;;
CREATE PROCEDURE `p_compare_ods_sql_vs_hive_meta_pro`()
BEGIN
alter table ods_sql_detail add index table_name_index (table_name);
alter table hive_meta_columns_detail add index table_name_index (table_name);
alter table hive_meta_tables_detail add index table_name_index (table_name);

-- SET GLOBAL group_concat_max_len=102400;
set session group_concat_max_len = 102400;
truncate table analysis_ods_hive_meta_columns_count;
insert into analysis_ods_hive_meta_columns_count   
select distinct
	tt1.*
from (
	select  
		t1.ods_shell_file_addr
		,t1.ods_shell_file_name
		,t1.ods_shell_ods_name
		,t2.file_name as ods_sql_file_name
		,t2.table_name as ods_sql_table_name 
		,ifnull(t2.table_comment,'') as ods_sql_table_comment 
		,t2.columns_count as ods_sql_columns_count
		,t3.table_name as bigdata_table_name 
		,ifnull(t3.table_comment,'') as bigdata_table_comment 
		,t3.columns_count as bigdata_columns_count 
		,(case when t2.table_name is null then 0 else 1 end) ods_table_name_is_match 
		,(case when t3.table_name is null then 0 else 1 end) bigdata_table_name_is_match 
		,(case when trim(t2.table_comment) = '' or trim(t2.table_comment) is null or lower(t2.table_comment) <> lower(t3.table_comment) then 0 else 1 end) as table_comment_is_match
		,(case when t2.columns_count <> t3.columns_count or t2.columns_count <= 1 then 0 else 1 end) as columns_count_is_match 
		,now() as create_time
		,now() as modify_time
	from analysis_azkaban_src_to_bigdata t1 
	left join (
		select 
			file_name
			,table_name
			,table_comment
			,group_concat(column_name) as ods_sql_all_columns
			,max(column_order) as columns_count
		from ods_sql_detail 
		group by file_name,table_name,table_comment 
	) t2 on t1.ods_shell_ods_name = t2.table_name 
	left join hive_meta_tables_detail t3 on t1.ods_shell_ods_name = t3.table_name 
	where t1.ods_shell_is_match_azkaban = 1
) tt1 
where tt1.ods_table_name_is_match = 0 or -- ods表名不匹配
tt1.bigdata_table_name_is_match = 0 or -- hive元数据表名不匹配
tt1.table_comment_is_match = 0 or -- 表注释不匹配
tt1.columns_count_is_match = 0 -- 字段数不匹配
;

-- 匹配表名对应的字段名,字段类型是否一致,特殊: 如果元数据字段数量小于1,实际hive已经删表了,所以判定为不匹配
truncate table analysis_ods_hive_meta_columns_detail;
insert into analysis_ods_hive_meta_columns_detail  
select distinct 
	tt1.*
from (
	select  
		t1.ods_shell_file_addr
		,t1.ods_shell_file_name
		,t1.ods_shell_ods_name
		,t2.file_name as ods_sql_file_name
		,t2.table_name as ods_sql_table_name 
		,t2.column_name as ods_sql_column_name
		,t2.column_type as ods_sql_column_type
		,ifnull(t2.column_comment,'') as ods_sql_column_comment 
		,t2.column_order as ods_sql_column_order 
		,t3.table_name as bigdata_table_name 
		,t3.column_name as bigdata_column_name 
		,t3.column_type as bigdata_column_type
		,ifnull(t3.column_comment,'') as bigdata_column_comment 
		,t3.column_order as bigdata_column_order 
		,(case when t2.table_name is null then 0 else 1 end) ods_table_name_is_match 
		,(case when t3.table_name is null then 0 else 1 end) bigdata_table_name_is_match 
		,(case when t2.column_name = t3.column_name then 1 else 0 end) as column_name_is_match 
		,(case when t2.column_type = t3.column_type then 1 
			when (locate('decimal', t2.column_type) > 0) and (locate(',0', t2.column_type) = 0) then 1
			else 0 end) as column_type_is_match 
		,(case when trim(t2.column_comment) = '' or trim(t2.column_comment) is null or trim(t2.column_comment) <> trim(t3.column_comment) then 0 else 1 end) as column_comment_is_match
		,now() as create_time
		,now() as modify_time
	from analysis_azkaban_src_to_bigdata t1 
	left join ods_sql_detail t2 on t1.ods_shell_ods_name = t2.table_name 
	left join hive_meta_columns_detail t3 on t1.ods_shell_ods_name = t3.table_name and t2.column_order = t3.column_order + 1
	where t1.ods_shell_is_match_azkaban = 1
) tt1 
where tt1.ods_table_name_is_match = 0 or -- ods表名不匹配
tt1.bigdata_table_name_is_match = 0 or -- hive元数据表名不匹配
tt1.column_name_is_match = 0 or -- 字段名不匹配
tt1.column_type_is_match = 0 or -- 字段类型不匹配
tt1.column_comment_is_match = 0 -- 字段注释不匹配
;

-- 分析完删索引
alter table ods_sql_detail drop index table_name_index;
alter table hive_meta_columns_detail drop index table_name_index;
alter table hive_meta_tables_detail drop index table_name_index;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for p_compare_ods_sql_vs_source_meta_pro
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_compare_ods_sql_vs_source_meta_pro`;
delimiter ;;
CREATE PROCEDURE `p_compare_ods_sql_vs_source_meta_pro`()
BEGIN
alter table source_meta_columns_detail add index table_name_index (full_table_name);
alter table source_meta_tables_detail add index table_name_index (full_table_name);
alter table ods_sql_detail add index table_name_index (table_name);
alter table dim_system_shortname add index jdbc_name_index (jdbc_name);

-- 备注
-- 1.关联源表要加系统简称,不用系统可能有完全相同的一张表
-- trade.tassetday	hspb_ora.trade.tassetday
-- trade.tassetday	sbo32_ora.trade.tassetday

-- SET GLOBAL group_concat_max_len=102400;
set session group_concat_max_len = 102400;
truncate table analysis_ods_source_meta_columns_count;
insert into analysis_ods_source_meta_columns_count 
select distinct
	tt1.*
from (
	select  
		t1.ods_shell_file_addr
		,t1.ods_shell_file_name
		,t1.ods_shell_ods_name
		,ifnull(t1.stg_shell_file_name,'') 
		,ifnull(t1.stg_shell_xtjc,'')
		,ifnull(t1.stg_shell_source_table_name,'') 
		,concat_ws('.',t3.gkpt_name,t1.stg_shell_source_table_name) as full_stg_shell_source_table_name 
		,t1.stg_shell_all_columns_count
		,t2.file_name as ods_sql_file_name
		,t2.table_name as ods_sql_table_name 
		,t2.table_comment as ods_sql_table_comment 
		,(case when find_in_set('oc_date',t2.ods_sql_all_columns) > 0 then t2.columns_count - 1 else t2.columns_count end) as ods_sql_columns_count
		,ifnull(t4.full_table_name,'') as source_table_name 
		,ifnull(t4.table_comment,'') as source_table_comment
		,ifnull(t4.columns_count,0) as source_columns_count
		,(case when t2.table_name is null then 0 else 1 end) ods_table_name_is_match 
		,(case when t4.full_table_name is null then 0 else 1 end) source_table_name_is_match 
		,(case when trim(t2.table_comment) = '' or trim(t2.table_comment) is null or lower(t2.table_comment) <> lower(t4.table_comment) then 0 else 1 end) as table_comment_is_match
		,(case when 
			(case when find_in_set('oc_date',t2.ods_sql_all_columns) > 0 then t2.columns_count - 1 else t2.columns_count end) = t4.columns_count then 1 
		    else 0 end) as columns_count_is_match 
		,now() as create_time
		,now() as modify_time
	from analysis_azkaban_src_to_bigdata t1 
	left join (
		select 
			file_name
			,table_name
			,table_comment
			,group_concat(column_name) as ods_sql_all_columns
			,max(column_order) as columns_count
		from ods_sql_detail 
		group by file_name,table_name,table_comment 
	) t2 on t1.ods_shell_ods_name = t2.table_name 
	left join dim_system_shortname t3 on t1.stg_shell_xtjc = t3.jdbc_name 
	left join source_meta_tables_detail t4 on concat_ws('.',t3.gkpt_name,t1.stg_shell_source_table_name) = t4.full_table_name 
	where t1.ods_shell_is_match_azkaban = 1
) tt1 
where tt1.ods_table_name_is_match = 0 or -- ods表名不匹配
tt1.source_table_name_is_match = 0 or -- 源表名不匹配
tt1.table_comment_is_match = 0 or -- 表注释不匹配
tt1.columns_count_is_match = 0 -- 字段数不匹配
;

truncate table analysis_ods_source_meta_columns_detail;
insert into analysis_ods_source_meta_columns_detail 
select distinct
	tt1.* 
from (
	select  
		t1.ods_shell_file_addr
		,t1.ods_shell_file_name
		,t1.ods_shell_ods_name
		,t1.stg_shell_file_name 
		,t1.stg_shell_xtjc
		,t1.stg_shell_source_table_name 
		,concat_ws('.',t3.gkpt_name,t1.stg_shell_source_table_name) as full_stg_shell_source_table_name 
		,t2.file_name as ods_sql_file_name
		,t2.table_name as ods_sql_table_name
		,t2.column_name as ods_sql_column_name
		,t2.column_order as ods_sql_column_order
		,t2.column_type as ods_sql_column_type
		,t2.column_comment as ods_sql_column_comment
		,t4.full_table_name as source_table_name
		,t4.column_name as source_column_name
		,t4.column_type as source_column_type
		,t4.column_length as source_column_length
		,t4.column_flo as source_column_flo
		,t4.column_order as source_column_order 
		,t4.column_comment as source_column_comment 
		,(case when t2.table_name is null then 0 else 1 end) as ods_table_name_is_match 
		,(case when t4.table_name is null then 0 else 1 end) as source_table_name_is_match 
		,(case when trim(t2.column_name) = '' or trim(t2.column_name) is null or trim(t2.column_name) <> trim(t4.column_name) then 0 else 1 end) as column_name_is_match 
		,(case when (t4.column_type = 'nclob' or t4.column_type = 'timestamp(6)' or t4.column_type = 'timestamp' or t4.column_type = 'varchar' or t4.column_type = 'nvarchar2' or t4.column_type = 'char' or t4.column_type = 'date' or t4.column_type = 'varchar2' or t4.column_type = 'blob' or t4.column_type = 'clob') and t2.column_type = 'string' then 1 
			   when (t4.column_type = 'number' or t4.column_type = 'numeric') and locate(concat_ws(',',concat('decimal(',t4.column_length),t4.column_flo),t2.column_type) > 0 then 1 
				 when t4.column_type = 'integer' and t2.column_type = 'int' then 1 
			   else 0 end) as column_type_is_match
	  ,(case when trim(t2.column_comment) = '' or trim(t2.column_comment) is null or trim(t2.column_comment) <> trim(t4.column_comment) then 0 else 1 end) as column_comment_is_match
		,now() as create_time 
		,now() as modify_time 
	from analysis_azkaban_src_to_bigdata t1 
	left join ods_sql_detail t2 on t1.ods_shell_ods_name = t2.table_name 
	left join dim_system_shortname t3 on t1.stg_shell_xtjc = t3.jdbc_name 
	left join source_meta_columns_detail t4 on concat_ws('.',t3.gkpt_name,t1.stg_shell_source_table_name) = t4.full_table_name and t2.column_name = t4.column_name 
	where t1.ods_shell_is_match_azkaban = 1 
) tt1 
where tt1.ods_table_name_is_match = 0 or -- ods表名不匹配 
tt1.source_table_name_is_match = 0 or -- 字段名不匹配
tt1.column_name_is_match = 0 or -- 字段名不匹配
tt1.column_comment_is_match = 0 or -- 字段注释不匹配
tt1.column_type_is_match = 0 -- 字段类型不匹配 
;

alter table source_meta_columns_detail drop index table_name_index;
alter table source_meta_tables_detail drop index table_name_index;
alter table ods_sql_detail drop index table_name_index;
alter table dim_system_shortname drop index jdbc_name_index;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for p_compare_ods_sql_vs_stg_sql
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_compare_ods_sql_vs_stg_sql`;
delimiter ;;
CREATE PROCEDURE `p_compare_ods_sql_vs_stg_sql`()
BEGIN
-- 1.分析前加索引提高速度
alter table ods_sql_detail add index table_name_index(table_name);
alter table stg_sql_detail add index table_name_index(table_name);

-- 2.匹配表名,对应字段名数量是否一致
truncate table analysis_ods_stg_columns_count;
insert into analysis_ods_stg_columns_count 
select distinct
	tt1.*
from (
	select 
		t1.ods_shell_file_addr
		,t1.ods_shell_file_name
		,t1.ods_shell_ods_name
		,t1.ods_shell_stg_name
		,t1.stg_shell_file_name 
		,t1.stg_shell_all_columns_count
		,t2.file_name as ods_sql_file_name
		,ifnull(t2.table_name,'') as ods_sql_table_name 
		,ifnull(t2.table_comment,'') as ods_sql_table_comment 
		,ifnull(t2.columns_count,0) as ods_sql_columns_count
		,t3.file_name as stg_sql_file_name
		,ifnull(t3.table_name,'') as stg_sql_table_name 
		,ifnull(t3.table_comment,'') as stg_sql_table_comment
		,ifnull(t3.columns_count,0) as stg_sql_columns_count
		,(case when t2.table_name is null then 0 else 1 end) ods_table_name_is_match 
		,(case when t3.table_name is null then 0 else 1 end) stg_table_name_is_match 
		,(case when trim(t2.table_comment) = '' or trim(t2.table_comment) is null or t2.table_comment <> t3.table_comment then 0 else 1 end) as table_comment_is_match
		,(case when t2.columns_count = t3.columns_count then 1 else 0 end) as columns_count_is_match
		,sum((case when t1.ods_shell_ods_name like concat(t4.match_rule,'%') then 1 else 0 end)) as is_exclude 
		,now() as create_time
		,now() as modify_time
	from analysis_azkaban_src_to_bigdata t1 
	left join (
		select 
			file_name,table_name,table_comment,max(column_order) as columns_count
		from ods_sql_detail 
		group by file_name,table_name,table_comment 
	) t2 on t1.ods_shell_ods_name = t2.table_name 
	left join (
		select 
			file_name,table_name,table_comment,max(column_order) as columns_count
		from stg_sql_detail 
		group by file_name,table_name,table_comment 
	) t3 on t1.ods_shell_stg_name = t3.table_name  
	left join (select distinct match_rule from dim_exclude_detail where exclude_type = '没有stg_sql') t4 on 1 = 1
	where t1.ods_shell_is_match_azkaban = 1
	group by t1.ods_shell_file_addr,t1.ods_shell_file_name,t1.ods_shell_ods_name,t1.ods_shell_stg_name,t1.stg_shell_file_name,t1.stg_shell_all_columns_count
	,t2.file_name,t2.table_name,t2.table_comment,t2.columns_count,t3.file_name,t3.table_name,t3.table_comment,t3.columns_count
) tt1 
where tt1.is_exclude = 0 and (tt1.ods_table_name_is_match = 0 or -- ods表名不匹配
tt1.stg_table_name_is_match = 0 or -- stg表名不匹配
tt1.table_comment_is_match = 0 or -- 表注释不匹配
tt1.columns_count_is_match = 0 -- 字段数不匹配
);

-- 3.匹配表名,对应的字段名,字段类型是否一致
truncate table analysis_ods_stg_columns_detail;
insert into analysis_ods_stg_columns_detail 
select distinct
	tt1.*
from (
	select  
		t1.ods_shell_file_addr
		,t1.ods_shell_file_name
		,t1.ods_shell_ods_name
		,t1.ods_shell_stg_name
		,t1.stg_shell_file_name 
		,t1.stg_shell_all_columns_count
		,t2.file_name as ods_sql_file_name
		,t2.table_name as ods_sql_table_name 
		,t2.column_name as ods_sql_column_name
		,t2.column_order as ods_sql_column_order
		,t2.column_type as ods_sql_column_type
		,t2.column_comment as ods_sql_column_comment
		,t3.file_name as stg_sql_file_name
		,t3.table_name as stg_sql_table_name 
		,t3.column_name as stg_sql_column_name
		,t3.column_order as stg_sql_column_order
		,t3.column_type as stg_sql_column_type
		,t3.column_comment as stg_sql_column_comment
		,(case when t2.table_name is null then 0 else 1 end) ods_table_name_is_match 
		,(case when t3.table_name is null then 0 else 1 end) stg_table_name_is_match 
		,(case when t2.column_name = t3.column_name then 1 else 0 end) column_name_is_match 
		,(case when t2.column_type = t3.column_type then 1 else 0 end) column_type_is_match 
		,(case when trim(t2.column_comment) = '' or trim(t2.column_comment) is null or t2.column_comment <> t3.column_comment then 0 else 1 end) column_comment_is_match 
		,sum((case when t1.ods_shell_ods_name like concat(t4.match_rule,'%') then 1 else 0 end)) as is_exclude 
		,now() as create_time
		,now() as modify_time
	from analysis_azkaban_src_to_bigdata t1 
	left join ods_sql_detail t2 on t1.ods_shell_ods_name = t2.table_name 
	left join stg_sql_detail t3 on t1.ods_shell_stg_name = t3.table_name and t2.column_order = t3.column_order 
	left join (select distinct match_rule from dim_exclude_detail where exclude_type = '没有stg_sql') t4 on 1 = 1
	where t1.ods_shell_is_match_azkaban = 1
	group by t1.ods_shell_file_addr,t1.ods_shell_file_name,t1.ods_shell_ods_name,t1.ods_shell_stg_name,t1.stg_shell_file_name ,t1.stg_shell_all_columns_count,t2.file_name,t2.table_name,t2.column_name,t2.column_order,t2.column_type,t2.column_comment,t3.file_name,t3.table_name,t3.column_name,t3.column_order,t3.column_type,t3.column_comment
) tt1 
where tt1.is_exclude = 0 and (tt1.ods_table_name_is_match = 0 or -- ods表名不匹配
tt1.stg_table_name_is_match = 0 or -- stg表名不匹配
tt1.column_name_is_match = 0 or -- 字段名不匹配
tt1.column_type_is_match = 0 or -- 字段类型不匹配
tt1.column_comment_is_match = 0 -- 字段注释不匹配
);

-- 分析完索引删掉,否则插入慢
alter table ods_sql_detail drop index table_name_index;
alter table stg_sql_detail drop index table_name_index;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for p_compare_source_meta_pro_vs_hive_meta_pro
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_compare_source_meta_pro_vs_hive_meta_pro`;
delimiter ;;
CREATE PROCEDURE `p_compare_source_meta_pro_vs_hive_meta_pro`()
BEGIN

alter table dim_system_shortname add index jdbc_index(jdbc_name);
-- alter table hive_meta_tables_detail add index table_name_index(table_name);
alter table source_meta_tables_detail add index table_name_index(full_table_name);
alter table hive_meta_columns_detail add index table_column_name_index(table_name,column_name);
alter table source_meta_columns_detail add index table_name_index(full_table_name);

-- SET GLOBAL group_concat_max_len=102400;
set session group_concat_max_len = 102400;
truncate table analysis_source_hive_meta_columns_count;
insert into analysis_source_hive_meta_columns_count 
select distinct 
	tt1.*
	,now() as create_time
	,now() as modify_time
from (
	select  
		t1.ods_shell_file_addr
		,t1.ods_shell_ods_name
		,ifnull(t1.stg_shell_file_name,'')
		,t2.gkpt_name
		,ifnull(t1.stg_shell_source_table_name,'')
		,concat_ws('.',t2.gkpt_name,t1.stg_shell_source_table_name) as full_source_table_name
-- 		,t3.columns_count as hive_meta_columns_count
		,(case when find_in_set('oc_date',t3.all_columns) > 0 then t3.columns_count - 1 else t3.columns_count end) as hive_meta_columns_count
		,ifnull(t3.table_comment,'') as hive_meta_table_comment
		,t4.columns_count as source_meta_columns_count
		,ifnull(t4.table_comment,'') as source_meta_table_comment
		,(case when t3.table_name is null then 0 else 1 end) as hive_meta_table_is_match
		,(case when t4.full_table_name is null then 0 else 1 end) as source_meta_table_is_match
		,(case when 
			(case when find_in_set('oc_date',t3.all_columns) > 0 then t3.columns_count - 1 else t3.columns_count end) = t4.columns_count then 1 
			else 0 end) as columns_count_is_match 
		,(case when trim(t3.table_comment) is null or trim(t3.table_comment) = '' or trim(t3.table_comment) <> trim(t4.table_comment) then 0 else 1 end) as table_comment_is_match
	from analysis_azkaban_src_to_bigdata t1 
	left join (select distinct jdbc_name,gkpt_name from dim_system_shortname) t2 on t1.stg_shell_xtjc = t2.jdbc_name 
	left join (
		select 
			table_name
			,table_comment
			,group_concat(column_name) as all_columns
			,count(1) as columns_count 
		from hive_meta_columns_detail 
		group by table_name,table_comment
	) t3 on t1.ods_shell_ods_name = t3.table_name 
	left join source_meta_tables_detail t4 on concat_ws('.',t2.gkpt_name,t1.stg_shell_source_table_name) = t4.full_table_name 
	where t1.ods_shell_is_match_azkaban = 1
) tt1 
where tt1.hive_meta_table_is_match = 0 or -- hive元数不匹配
tt1.source_meta_table_is_match = 0 or -- 源表名不匹配
tt1.columns_count_is_match = 0 or -- 字段数量不匹配
tt1.table_comment_is_match = 0  -- 表注释不匹配
;

truncate table analysis_source_hive_meta_columns_detail;
insert into analysis_source_hive_meta_columns_detail 
select distinct 
	tt1.*
	,now() as create_time
	,now() as modify_time
from (
	select  
		t1.ods_shell_file_addr
		,t1.ods_shell_ods_name
		,ifnull(t1.stg_shell_file_name,'')
		,t2.gkpt_name
		,ifnull(t1.stg_shell_source_table_name,'')
		,concat_ws('.',t2.gkpt_name,t1.stg_shell_source_table_name) as full_source_table_name
		,t4.column_name as hive_meta_column_name
		,(t4.column_order + 1) as hive_meta_column_order
		,t4.column_type as hive_meta_column_type
		,ifnull(t4.column_comment,'') as hive_meta_column_comment
		,t3.column_name as source_meta_column_name
		,t3.column_order as source_meta_column_order
		,t3.column_type as source_meta_column_type
		,t3.column_length as source_meta_column_length
		,t3.column_flo as source_meta_column_flo
		,ifnull(t3.column_comment,'') as source_meta_column_comment
		,(case when t4.table_name is null then 0 else 1 end) as hive_meta_table_is_match
		,(case when t3.full_table_name is null then 0 else 1 end) as source_meta_table_is_match
		,(case when t3.column_name = t4.column_name then 1 else 0 end) as column_name_is_match 
		,(case when (t3.column_type = 'nclob' or t3.column_type = 'timestamp(6)' or t3.column_type = 'timestamp' or t3.column_type = 'varchar' or t3.column_type = 'nvarchar2' or t3.column_type = 'char' or t3.column_type = 'date' or t3.column_type = 'varchar2' or t3.column_type = 'blob' or t3.column_type = 'clob') and t4.column_type = 'string' then 1 
			   when (t3.column_type = 'number' or t3.column_type = 'numeric') and locate(concat_ws(',',concat('decimal(',t3.column_length),t3.column_flo),t4.column_type) > 0 then 1 
				 when t3.column_type = 'integer' and t4.column_type = 'int' then 1 
			   else 0 end) as column_type_is_match 
		,(case when trim(t4.column_comment) is null or trim(t4.column_comment) = '' or lower(t4.column_comment) <> lower(t4.column_comment) then 0 else 1 end) as column_comment_is_match 
	from analysis_azkaban_src_to_bigdata t1 
	left join (select distinct jdbc_name,gkpt_name from dim_system_shortname) t2 on t1.stg_shell_xtjc = t2.jdbc_name 
	left join source_meta_columns_detail t3 on concat_ws('.',t2.gkpt_name,t1.stg_shell_source_table_name) = t3.full_table_name 
	left join hive_meta_columns_detail t4 on t1.ods_shell_ods_name = t4.table_name and t3.column_name = t4.column_name
	where t1.ods_shell_is_match_azkaban = 1
) tt1 
where tt1.hive_meta_table_is_match = 0 or -- hive元数不匹配
tt1.source_meta_table_is_match = 0 or -- 源表名不匹配
tt1.column_name_is_match = 0 or -- 字段名不匹配
tt1.column_type_is_match = 0 or -- 字段类型不匹配
tt1.column_comment_is_match = 0  -- 字段注释不匹配
;

alter table dim_system_shortname drop index jdbc_index;
-- alter table hive_meta_tables_detail drop index table_name_index;
alter table source_meta_tables_detail drop index table_name_index;
alter table hive_meta_columns_detail drop index table_column_name_index;
alter table source_meta_columns_detail drop index table_name_index;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for p_compare_source_meta_test_vs_source_meta_pro
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_compare_source_meta_test_vs_source_meta_pro`;
delimiter ;;
CREATE PROCEDURE `p_compare_source_meta_test_vs_source_meta_pro`()
BEGIN
alter table source_meta_tables_detail add index full_table_name_index(full_table_name);
alter table source_meta_tables_detail_test add index full_table_name_index(full_table_name);
alter table source_meta_columns_detail add index full_table_name_order_index(full_table_name,column_order);
alter table source_meta_columns_detail_test add index full_table_name_order_index(full_table_name,column_order);

-- 只以生产为主
truncate table analysis_source_meta_columns_count;
insert into analysis_source_meta_columns_count 
select distinct
	tt1.*
	,now() as create_time
	,now() as modify_time
from (
	select 
		t1.table_name as online_table_name 
		,t1.table_comment as online_table_comment 
		,t1.columns_count as online_columns_count 
		,t2.table_name as test_table_name
		,t2.table_comment as test_table_comment 
		,t2.columns_count as test_columns_count 
		,(case when t2.table_name is null then 0 else 1 end) as table_name_is_match 
-- 		,(case when trim(t1.table_comment) is null or trim(t1.table_comment) = '' or lower(t1.table_comment) <> lower(t2.table_comment) then 0 else 1 end) as table_comment_is_match
		,1 as table_comment_is_match -- 暂时不校验,没必要
		,(case when t1.columns_count = t2.columns_count then 1 else 0 end) as columns_count_is_match 
	from source_meta_tables_detail t1 
	left join source_meta_tables_detail_test t2 on t1.full_table_name = t2.full_table_name
) tt1 
where tt1.table_name_is_match = 0 or -- 表名不匹配
tt1.table_comment_is_match = 0 or -- 表注释不匹配
tt1.columns_count_is_match = 0 -- 字段数不匹配
;

truncate table analysis_source_meta_columns_detail;
insert into analysis_source_meta_columns_detail 
select distinct
	tt1.*
	,now() as create_time
	,now() as modify_time
from (
	select 
		t1.table_name as online_table_name
		,t1.column_name as online_column_name
		,t1.column_type as online_column_type
		,ifnull(t1.column_comment,'') as online_column_comment
		,t1.column_order as online_column_order
		,t2.table_name as test_table_name
		,t2.column_name as test_column_name
		,t2.column_type as test_column_type
		,ifnull(t2.column_comment,'') as test_column_comment
		,t2.column_order as test_column_order
		,(case when t2.table_name is null then 0 else 1 end) as table_name_is_match
		,(case when t1.column_name = t2.column_name then 1 else 0 end) as column_name_is_match 
		,(case when t1.column_type = t2.column_type then 1 else 0 end) as column_type_is_match 
-- 		,(case when trim(t1.column_comment) = '' or trim(t1.column_comment) is null or lower(t1.column_comment) <> lower(t2.column_comment) then 0 else 1 end) as column_comment_is_match 
		,1 as column_comment_is_match -- 暂时不校验,没必要
	from source_meta_columns_detail t1 
	left join source_meta_columns_detail_test t2 on t1.full_table_name = t2.full_table_name and t1.column_order = t2.column_order 
) tt1 
where tt1.table_name_is_match = 0 or -- 表名不匹配
tt1.column_name_is_match = 0 or -- 字段名不匹配
tt1.column_type_is_match = 0 or -- 字段类型不匹配
tt1.column_comment_is_match = 0 -- 字段注释不匹配
;

alter table source_meta_tables_detail drop index full_table_name_index;
alter table source_meta_tables_detail_test drop index full_table_name_index;
alter table source_meta_columns_detail drop index full_table_name_order_index;
alter table source_meta_columns_detail_test drop index full_table_name_order_index;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for p_compare_src_to_raw
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_compare_src_to_raw`;
delimiter ;;
CREATE PROCEDURE `p_compare_src_to_raw`()
BEGIN
alter table analysis_azkaban_src_to_bigdata add index table_name_index(stg_shell_source_table_name);
alter table analysis_azkaban_ods_shell add index table_name_index(ods_table_name);

drop table if exists temp_analysis_src_to_raw;
create table temp_analysis_src_to_raw(
data_source_table_name varchar(200),
file_addr varchar(200),
data_center_table_name varchar(200),
is_match varchar(100),
hive_table_name varchar(100),
ods_shell_file_addr varchar(200),
ods_shell_stg_name varchar(100),
ods_shell_ods_name varchar(100));

-- 1.全匹配出来
insert into temp_analysis_src_to_raw 
select distinct 
	t1.data_source_table_name 
	,t1.file_addr 
	,t1.data_center_table_name
	,(case when t3.table_name like concat(concat('%',substring(t1.data_source_table_name,locate('.',t1.data_source_table_name) + 1,300)),'_hv%') then 1 else 0 end) as is_match 
	-- 		,substring(t1.data_center_table_name,locate('.',t1.data_center_table_name) + 1,100) as table_name
	,(case when t3.table_name like concat(concat('%',substring(t1.data_source_table_name,locate('.',t1.data_source_table_name) + 1,300)),'_hv%') then t3.table_name else null end) as hive_table_name
	,t2.ods_shell_file_addr 
	,t2.ods_shell_stg_name 
	,t2.ods_shell_ods_name 
from src_to_raw_detail t1 
left join (
	select  
	stg_shell_source_table_name
	,ods_shell_file_addr
	,ods_shell_stg_name
	,ods_shell_ods_name 
	from analysis_azkaban_src_to_bigdata
) t2 on t1.data_source_table_name = t2.stg_shell_source_table_name
left join (select table_name from hive_meta_tables_detail where table_name like 'ods_%') t3 on 1 = 1
where t1.data_center_table_name like 'dcraw.%' and t2.stg_shell_source_table_name is null 
and trim(t1.data_source_table_name) is not null and trim(t1.data_source_table_name) <> '' 
order by t1.data_center_table_name
;

-- 2.匹配到的数据都会多一条没匹配出的数据,删掉
delete from temp_analysis_src_to_raw 
where data_source_table_name in (
	select data_source_table_name from (select file_addr,data_source_table_name from analysis_src_to_raw group by file_addr,data_source_table_name having count(1) >= 2) t1 
) and is_match = 0
;

-- 3.关联ods_shell拿到对应的脚本路径
truncate table analysis_src_to_raw;
insert into analysis_src_to_raw 
select 
	t1.data_source_table_name 
	,t1.file_addr 
	,t1.data_center_table_name
	,t2.is_match_azkaban 
	,t1.hive_table_name
	,(case when trim(t1.ods_shell_file_addr) is null or trim(t1.ods_shell_file_addr) = '' then t2.file_addr else t1.ods_shell_file_addr end) as ods_shell_file_addr
	,(case when trim(t1.ods_shell_stg_name) is null or trim(t1.ods_shell_stg_name) = '' then t2.stg_table_name else t1.ods_shell_stg_name end) as ods_shell_stg_name
	,(case when trim(t1.ods_shell_ods_name) is null or trim(t1.ods_shell_ods_name) = '' then t2.ods_table_name else t1.ods_shell_ods_name end) as ods_shell_ods_name
from temp_analysis_src_to_raw t1 
left join analysis_azkaban_ods_shell t2 on t1.hive_table_name = t2.ods_table_name 
order by t1.data_center_table_name;

alter table analysis_azkaban_src_to_bigdata drop index table_name_index;
alter table analysis_azkaban_ods_shell drop index table_name_index;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for p_compare_stg_sql_shell
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_compare_stg_sql_shell`;
delimiter ;;
CREATE PROCEDURE `p_compare_stg_sql_shell`()
BEGIN

alter table stg_sql_detail add index table_index (table_name);
alter table stg_shell_detail add index table_index (stg_table_name);

-- SET GLOBAL group_concat_max_len=102400;
set session group_concat_max_len = 102400;

truncate table analysis_stg_sql_shell_columns_count;
insert into analysis_stg_sql_shell_columns_count 
select distinct
	tt1.* 
from (
	select  
		t1.file_addr as stg_shell_file_addr 
		,t1.file_name as stg_shell_file_name 
		,t1.source_table_name as stg_shell_source_table_name 
		,t1.stg_table_name as stg_shell_stg_table_name 
		,t1.all_columns_count as stg_shell_all_columns_count 
		,t2.file_name as stg_sql_file_name
		,t2.table_name as stg_sql_table_name
		,t2.columns_count as stg_sql_columns_count
		,(case when replace(t1.file_name,'.sh','') =  replace(t1.file_name,'.sql','') then 1 else 0 end) file_name_is_match 
		,(case when t2.table_name is null then 0 else 1 end) table_name_is_match 
		,(case when 
			(case when find_in_set('oc_date',t2.stg_sql_all_columns) > 0 then t2.columns_count - 1 else t2.columns_count end) = t1.all_columns_count then 1 
		    else 0 end) as columns_count_is_match
		-- ,sum((case when t1.stg_table_name like concat(t3.match_rule,'%') then 1 else 0 end)) as is_exclude 
		,'0' as is_exclude 
		,current_date() as create_time
		,current_date() as modify_time
	from analysis_azkaban_stg_shell t1 -- azkaban可能调用了多次,要去重 
	left join (
		select 
			file_name
			,table_name
			,group_concat(column_name) as stg_sql_all_columns
			,max(column_order) as columns_count 
		from stg_sql_detail 
		group by file_name,table_name 
	) t2 on t1.stg_table_name = t2.table_name 
	-- left join (select distinct match_rule from dim_exclude_detail where exclude_type = '没有stg_shell') t3 on 1 = 1
	where t1.is_match_azkaban = 1 
	-- group by t1.file_addr,t1.file_name,t1.source_table_name,t1.stg_table_name,t2.file_name,t2.table_name,t1.all_columns_count,t2.column_count
) tt1 
where tt1.is_exclude = 0 and (tt1.table_name_is_match = 0 or -- 表名不匹配
tt1.columns_count_is_match = 0 or -- 字段数量不匹配
tt1.file_name_is_match = 0 -- 文件名不匹配
);

-- stg_shell 与 stg_sql 比
truncate table analysis_stg_sql_shell_columns_detail;
insert into analysis_stg_sql_shell_columns_detail  
select distinct
	tt1.* 
from (
	select 
		t1.file_addr as stg_shell_file_addr 
		,t1.file_name as stg_shell_file_name
		,t1.source_table_name as stg_shell_source_table_name 
		,t1.stg_table_name as stg_shell_stg_table_name 
		,substring_index(substring_index(t1.parse_all_columns,',',t2.help_topic_id + 1),',',-1) as stg_shell_stg_column_name
		,(t2.help_topic_id + 1) as stg_shell_stg_column_order
		,t3.file_addr as stg_sql_file_addr
		,t3.file_name as stg_sql_file_name
		,t3.table_name as stg_sql_table_name 
		,t3.column_name as stg_sql_column_name
		,t3.column_order as stg_sql_column_order 
		,(case when replace(t1.file_name,'.sh','') =  replace(t3.file_name,'.sql','') then 1 else 0 end) file_name_is_match 
		,(case when t3.table_name is null then 0 else 1 end) table_name_is_match 
		,(case when 
			substring_index(substring_index(t1.parse_all_columns,',',t2.help_topic_id + 1),',',-1) = t3.column_name then 1 else 0 end) as column_name_is_match 
		,sum((case when t1.stg_table_name like concat(t4.match_rule,'%') then 1 else 0 end)) as is_exclude 
-- 		,0 as is_exclude 
		,t1.parse_all_columns as stg_shell_parse_all_columns
		,t1.all_columns as stg_shell_all_columns
		,current_date() as create_time
		,current_date() as modify_time
	from analysis_azkaban_stg_shell t1 -- azkaban可能调用了多次,要去重 
	inner join mysql.help_topic t2 on t2.help_topic_id < (length(t1.parse_all_columns) - length(replace(t1.parse_all_columns,',','')) + 1)
	left join stg_sql_detail t3 on t1.stg_table_name = t3.table_name and (t2.help_topic_id + 1) = t3.column_order 
	left join (select distinct match_rule from dim_exclude_detail where exclude_type = '不匹配stg_shell') t4 on 1 = 1
	where t1.is_match_azkaban = 1 
	group by t1.file_addr,t1.file_name,t1.source_table_name,t1.stg_table_name,t2.help_topic_id,t3.file_addr,t3.file_name,t3.table_name,t3.column_name,t3.column_order,t1.parse_all_columns,t1.all_columns 
	union 
	select 
		t1.file_addr as stg_shell_file_addr 
		,t1.file_name as stg_shell_file_name
		,t1.source_table_name as stg_shell_source_table_name 
		,t1.stg_table_name as stg_shell_stg_table_name 
		,substring_index(substring_index(t1.parse_all_columns,',',t2.help_topic_id + 1),',',-1) as stg_shell_stg_column_name
		,(t2.help_topic_id + 1) as stg_shell_stg_column_order
		,t3.file_addr as stg_sql_file_addr
		,t3.file_name as stg_sql_file_name
		,t3.table_name as stg_sql_table_name 
		,t3.column_name as stg_sql_column_name
		,t3.column_order as stg_sql_column_order 
		,(case when replace(t1.file_name,'.sh','') =  replace(t3.file_name,'.sql','') then 1 else 0 end) file_name_is_match 
		,(case when t3.table_name is null then 0 else 1 end) table_name_is_match 
		,(case when 
			substring_index(substring_index(t1.parse_all_columns,',',t2.help_topic_id + 1),',',-1) = t3.column_name then 1 else 0 end) as column_name_is_match 
		,sum((case when t1.stg_table_name like concat(t4.match_rule,'%') then 1 else 0 end)) as is_exclude 
-- 		,0 as is_exclude 
		,t1.parse_all_columns as stg_shell_parse_all_columns
		,t1.all_columns as stg_shell_all_columns
		,current_date() as create_time
		,current_date() as modify_time
	from analysis_azkaban_stg_shell t1 
	inner join mysql.help_topic t2 on t2.help_topic_id < (length(t1.parse_all_columns) - length(replace(t1.parse_all_columns,',','')) + 1)
	right join stg_sql_detail t3 on t1.stg_table_name = t3.table_name and (t2.help_topic_id + 1) = t3.column_order 
	left join (select distinct match_rule from dim_exclude_detail where exclude_type = '不匹配stg_shell') t4 on 1 = 1
	where t1.is_match_azkaban = 1 
	group by t1.file_addr,t1.file_name,t1.source_table_name,t1.stg_table_name,t2.help_topic_id,t3.file_addr,t3.file_name,t3.table_name,t3.column_name,t3.column_order,t1.parse_all_columns,t1.all_columns 
) tt1 
where tt1.is_exclude = 0 and (tt1.table_name_is_match = 0 or -- 表名不匹配
tt1.column_name_is_match = 0 -- 字段数量不匹配
);

-- select 
-- 	tt1.*
-- from (
-- 	select distinct 
-- 		t2.file_addr 
-- 		,t2.file_name 
-- 		,t2.source_table_name
-- 		,t2.stg_table_name 
-- 		,'' as stg_shell_stg_column_name
-- 		,find_in_set(t1.column_name,t2.parse_all_columns)
-- 		,t1.file_addr as stg_sql_file_addr
-- 		,t1.file_name as stg_sql_file_name
-- 		,t1.table_name as stg_sql_table_name 
-- 		,t1.column_name as stg_sql_column_name
-- 		,t1.column_order as stg_sql_column_order 
-- 		,(case when replace(t2.file_name,'.sh','') =  replace(t1.file_name,'.sql','') then 1 else 0 end) file_name_is_match 
-- 		,(case when t2.stg_table_name is null then 0 else 1 end) table_name_is_match 
-- 		,(case when find_in_set(t1.column_name,t2.parse_all_columns) = t1.column_order then 1 else 0 end) as column_name_is_match 
-- 		,sum((case when t1.table_name like concat(t4.match_rule,'%') then 1 else 0 end)) as is_exclude 
-- 		,t2.parse_all_columns
-- 		,t2.all_columns
-- 		,current_date() as create_time
-- 		,current_date() as modify_time
-- 	from analysis_azkaban_stg_sql t1
-- 	left join stg_shell_detail t2 on t1.table_name = t2.stg_table_name 
-- 	left join (select distinct match_rule from dim_exclude_detail where exclude_type = '没有stg_shell') t4 on 1 = 1
-- 	where t1.is_match_azkaban = 1 and t1.column_name <> 'oc_date'
-- 	group by t2.file_addr,t2.file_name,t2.source_table_name,t2.stg_table_name
-- 	,t1.file_addr,t1.file_name,t1.table_name,t1.column_name,t1.column_order
-- 	,t2.parse_all_columns,t2.all_columns
-- ) tt1 
-- where tt1.is_exclude = 0 and (tt1.table_name_is_match = 0 or -- 表名不匹配
-- tt1.column_name_is_match = 0 -- 字段数量不匹配
-- );


-- 分析完删索引
alter table stg_sql_detail drop index table_index;
alter table stg_shell_detail drop index table_index;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for p_data_compare_clean
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_data_compare_clean`;
delimiter ;;
CREATE PROCEDURE `p_data_compare_clean`()
BEGIN
-- 1.先对这张表加索引
alter table source_meta_columns_detail add index table_name_index(table_name);

-- 源表导入这里,这里貌似本来就会有重复,导入后记得查一下
-- drop table if exists dim_data_compare;
-- create table `dim_data_compare` (
--   `hive_database` varchar(50) default '' comment '系统名',
--   `sjzx_table_name` varchar(100) default '' comment '数据中心表名',
--   `hive_table_name` varchar(100) default '' comment '大数据平台表名'
-- ) engine=innodb default charset=utf8;

-- 2.形成基础表
-- drop table if exists dim_data_compare_basic;
-- create table `dim_data_compare_basic` (
--   `source_table_name` varchar(100) default '' comment '源表名',
--   `xt_name` varchar(50) default '' comment '系统名称',
--   `sjzx_hive_database` varchar(50) default '' comment '数据中心在hive的库名',
--   `sjzx_hive_table_name` varchar(100) default '' comment '数据中心在hive的表名',
-- 	`hive_database` varchar(50) default '' comment 'hive库名',
-- 	`hive_table_name` varchar(100) default '' comment 'hive表名',
-- 	`column_name` varchar(100) default '' comment '字段名',
-- 	`column_order` int default 0 comment '字段顺序号' 
-- ) engine=innodb default charset=utf8;

-- update dim_data_compare set hive_database = lower(trim(hive_database));
-- update dim_data_compare set hive_table_name = lower(trim(hive_table_name));
-- update dim_data_compare set sjzx_table_name = lower(trim(sjzx_table_name));
-- 跑之前查一下有没有重复的行
-- select distinct * from dim_data_compare t1 where t1.hive_database in ('ods_o32','ods_sbo3');
-- select * from dim_data_compare t1 where t1.hive_database in ('ods_o32','ods_sbo3');

truncate table dim_data_compare_basic;
insert into dim_data_compare_basic 
select  
-- 	t1.sjzx_table_name
	substring_index(t1.sjzx_table_name,'.',-1) as source_table_name
	,substring_index(t1.hive_database,'_',-1) as xt_name 
	,'ods_xydc' as sjzx_hive_database 
	,concat('t_ods_xydc_',substring_index(t1.sjzx_table_name,'.',-1),'_hv') as sjzx_hive_table_name
	,t1.hive_database 
-- 	,t1.hive_table_name 
	,substring_index(t1.hive_table_name,'.',-1) as hive_table_name 
	,t2.column_name
	,t2.column_order 
from dim_data_compare t1 
left join source_meta_columns_detail t2 on t1.sjzx_table_name = t2.table_name
where t1.hive_database in ('ods_zd','ods_zbjk','ods_td','ods_gmgt','ods_tb','ods_wx','ods_rhwz_ta','ods_jk','ods_qmfx','ods_jfxt','ods_ycjy','ods_jtcrm','ods_hxjy','ods_fxq','ods_jzyy','ods_zgfxq','ods_ygz','ods_hspb_fc','ods_mta','ods_portal','ods_ipofx','ods_lc','ods_xzzg','ods_zxxt','ods_hggl','ods_thdg','ods_nk4','ods_xydc','ods_gmjy','ods_jgcrm','ods_sjck','ods_jzrz','ods_mot','ods_qxjh','ods_xtsf','ods_ams','ods_itsm','ods_jzb','ods_nk','ods_zgcrm','ods_zj','ods_ztyy')
order by t1.sjzx_table_name,t2.column_order;

truncate table dim_data_compare_result;
insert into dim_data_compare_result select * from dim_data_compare_basic;
delete from dim_data_compare_result where column_name = 'oc_date';
-- 这里数据结构比对完后,把多余的字段删掉.
-- delete from dim_data_compare_result where source_table_name = 'o32_real_ttradestock' and column_name = '';
update dim_data_compare_result t1 
inner join (
select 
	source_table_name
	,min(column_order) as column_order
from dim_data_compare_result 
group by source_table_name
) t2 on t1.source_table_name = t2.source_table_name and t1.column_order = t2.column_order 
set t1.column_order = 1;

-- 3.查询没有 oc_date的表,手工查
-- 特别注意: 有的表可能没查到元数据
-- 查询语句: 
-- select * from dim_data_compare_basic where column_name is null;
-- call p_data_compare_query_without_oc_date('o32_thiscurrents');
-- 然后要处理下结果表
-- 1.手工插入没有元数据字段的数据,手工插入到 dim_data_compare_result
-- INSERT INTO dim_data_compare_result VALUES 
-- ('wskh_base_dictionary', 'wskh', 'ods_xydc', 't_ods_xydc_wskh_base_dictionary_hv', 'ods_wskh', 't_ods_wskh_base_dictionary_hv','id','1'),
-- 2.删掉元数据为空的那几行
-- delete from dim_data_compare_result where column_order is null;
-- 3.删除那些字段比对不一致的行
-- delete from dim_data_compare_result where source_table_name = 'o32_real_ttradestock' and column_name = 'l_create_date';


-- 4.形成azkaban批量生成,视图
-- select distinct 
-- 	xt_name as '第一列不要粘贴'
-- 	,'TDCDB186' as source_database 
-- 	,'DCRAW' as yh_schema 
-- 	,source_table_name 
-- 	,sjzx_hive_database
-- 	,sjzx_hive_table_name
-- 	,'parquet' as storage_mode 
-- 	,'marketDays' as increment_type 
-- 	,'oc_date' as collect_partition 
-- 	,'' as collect_addition_column 
-- 	,'\\001' as distribution_segment
-- 	,'part_init_date' as distribution_partition 
-- 	,'' as distribution_addition_column 
-- 	,'' as distribution_column 
-- 	,concat('/home/azkaban/projects/cmp_',xt_name) as script_store_address 
-- 	,'TRUE' is_collect 
-- 	,'table' is_view 
-- 	,'' is_id_increment 
-- 	,substring_index(sjzx_hive_database,'_',-1) as xtjc 
-- from dim_data_compare_basic 
-- order by xt_name 
-- ;

-- 5.没有oc_date的表,视图
-- select 
-- 	t1.* 
-- from (
-- 	select 
-- 		xt_name 
-- 		,source_table_name 
-- 		,find_in_set('oc_date',group_concat(column_name)) as oc_date_index 
-- 		,group_concat(column_name)
-- 	from dim_data_compare_basic 
-- 	group by xt_name,source_table_name 
-- 	order by xt_name 
-- ) t1 
-- where t1.oc_date_index is null or t1.oc_date_index = 0 
-- ;

-- 6.脚本制作
-- 6.1 hive, 视图
-- select distinct 
-- 	upper(source_table_name) as source_table_name
-- 	,upper(xt_name) as xt_name
-- 	,upper(hive_database) as hive_database
-- 	,upper(hive_table_name) as hive_table_name 
-- 	,'1' as sequence_number
-- from dim_data_compare_result 
-- order by source_table_name,xt_name 
-- ;

-- 6.2 数据中心, 视图
-- select distinct 
-- 	upper(source_table_name) as source_table_name
-- 	,upper(xt_name) as xt_name
-- 	,upper(sjzx_hive_database) as sjzx_hive_database
-- 	,upper(sjzx_hive_table_name) as sjzx_hive_table_name 
-- 	,'1' as sequence_number
-- from dim_data_compare_result 
-- order by source_table_name,xt_name 
-- ;
-- 
-- 6.3 内容比较,视图
-- select 
-- 	upper(source_table_name) as source_table_name
-- 	,upper(xt_name) as xt_name
-- 	,upper(hive_database) as hive_database
-- 	,upper(sjzx_hive_database) as sjzx_hive_database
-- 	,upper(sjzx_hive_table_name) as sjzx_hive_table_name 
-- 	,upper(hive_table_name) as hive_table_name 
-- 	,upper(column_name) as column_name 
-- 	,column_order 
-- from dim_data_compare_result
-- order by source_table_name,xt_name;

-- 6.4 差异比较,视图
-- select 
-- 	upper(source_table_name) as source_table_name
-- 	,upper(xt_name) as xt_name
-- 	,upper(hive_database) as hive_database 
-- 	,upper(sjzx_hive_database) as sjzx_hive_database 
-- 	,upper(sjzx_hive_table_name) as sjzx_hive_table_name
-- 	,upper(hive_table_name) as hive_table_name
-- 	,upper(column_name) as column_name
-- 	,upper(column_order) as column_order  
-- from dim_data_compare_result
-- order by source_table_name,xt_name;


-- 最后删除索引
alter table source_meta_columns_detail drop index table_name_index;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for p_data_compare_query_without_oc_date
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_data_compare_query_without_oc_date`;
delimiter ;;
CREATE PROCEDURE `p_data_compare_query_without_oc_date`(`source_table_name` varchar(100))
BEGIN
select 
	t1.file_addr
	,t1.filter_key
	,t1.where_conditions
	,t2.command 
from stg_shell_detail t1 
left join azkaban_detail t2 on t1.file_name = t2.sub_file_name 
where t1.file_name like concat('%',source_table_name,'%');
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for p_truncate_meta_data
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_truncate_meta_data`;
delimiter ;;
CREATE PROCEDURE `p_truncate_meta_data`()
BEGIN
-- 1.测试环境大数据平台元数据
truncate table hive_meta_columns_detail_test;
-- truncate table hive_meta_tables_detail_test;

-- 2.生产环境大数据平台元数据
truncate table hive_meta_columns_detail;
-- truncate table hive_meta_tables_detail;

-- 3.源表元数据
truncate table source_meta_columns_detail;
truncate table source_meta_tables_detail;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for p_update_meta_data
-- ----------------------------
DROP PROCEDURE IF EXISTS `p_update_meta_data`;
delimiter ;;
CREATE PROCEDURE `p_update_meta_data`()
BEGIN
-- 1.测试环境大数据平台元数据
truncate table hive_meta_columns_detail_test;
insert into hive_meta_columns_detail_test 
select 
	trim(replace(lower(t1.dmod_en_name),'metastore_hive.','')) as table_name 
	,replace(trim(lower(t2.dmod_cn_name)),'\n','') as table_comment  
	,trim(lower(t1.col_en_name)) as column_name 
	,trim(lower(t1.col_type)) as column_type
	,replace(trim(lower(t1.col_cn_name)),'\n','') as column_comment 
	,t1.col_order as column_order 
from tern_xy.tn_meta_dmod_col_info t1 
left join (
	select distinct 
		dmod_en_name
		,dmod_cn_name 
	from tern_xy.tn_meta_dmod_info 
	where dmod_en_name like '%METASTORE_HIVE%'
) t2 on t1.dmod_en_name = t2.dmod_en_name 
where t1.dmod_en_name like '%METASTORE_HIVE%'
;

truncate table hive_meta_tables_detail_test;
insert into hive_meta_tables_detail_test 
select distinct 
	trim(replace(lower(t1.dmod_en_name),'metastore_hive.','')) as table_name 
	,replace(trim(lower(t2.dmod_cn_name)),'\n','') as table_comment 
	,(max(t1.col_order) + 1) as columns_count 
from tern_xy.tn_meta_dmod_col_info t1 
left join (
	select distinct 
		dmod_en_name
		,dmod_cn_name 
	from tern_xy.tn_meta_dmod_info 
	where dmod_en_name like '%METASTORE_HIVE%'
) t2 on t1.dmod_en_name = t2.dmod_en_name 
where t1.dmod_en_name like '%METASTORE_HIVE%' 
group by t1.dmod_en_name,t2.dmod_cn_name
;

-- 2.生产环境大数据平台元数据
truncate table hive_meta_columns_detail;
insert into hive_meta_columns_detail 
select 
	trim(replace(lower(t1.dmod_en_name),'bigdata_hive.','')) as table_name 
	,replace(trim(lower(t2.dmod_cn_name)),'\n','') as table_comment  
	,trim(lower(t1.col_en_name)) as column_name 
	,trim(lower(t1.col_type)) as column_type
	,replace(trim(lower(t1.col_cn_name)),'\n','') as column_comment 
	,t1.col_order as column_order 
from tern_xy_sc_bak.tn_meta_dmod_col_info t1 
left join (
	select distinct 
		dmod_en_name
		,dmod_cn_name 
	from tern_xy_sc_bak.tn_meta_dmod_info 
	where dmod_en_name like '%BIGDATA_HIVE%'
) t2 on t1.dmod_en_name = t2.dmod_en_name 
where t1.dmod_en_name like '%BIGDATA_HIVE%'
;

truncate table hive_meta_tables_detail;
insert into hive_meta_tables_detail 
select distinct 
	trim(replace(lower(t1.dmod_en_name),'bigdata_hive.','')) as table_name 
	,replace(trim(lower(t2.dmod_cn_name)),'\n','') as table_comment 
	,(max(t1.col_order) + 1) as columns_count 
from tern_xy_sc_bak.tn_meta_dmod_col_info t1 
left join (
	select distinct 
		dmod_en_name
		,dmod_cn_name 
	from tern_xy_sc_bak.tn_meta_dmod_info 
	where dmod_en_name like '%BIGDATA_HIVE%'
) t2 on t1.dmod_en_name = t2.dmod_en_name 
where t1.dmod_en_name like '%BIGDATA_HIVE%' 
group by t1.dmod_en_name,t2.dmod_cn_name
;

-- 3.生产环境源表元数据
truncate table source_meta_columns_detail;
insert into source_meta_columns_detail 
select distinct 
	replace(trim(lower(t1.dmod_en_name)),concat(t2.gkpt_name,'.'),'') as table_name 
	,trim(lower(t1.dmod_en_name)) as full_table_name 
	,replace(trim(lower(t3.dmod_cn_name)),'\n','') as table_comment
	,trim(lower(t1.col_en_name)) as column_name 
	,trim(lower(t1.col_type)) as column_type
	,t1.col_len as column_length
	,t1.col_flo as column_flo
	,replace(trim(lower(t1.col_cn_name)),'\n','') as column_comment
	,t1.col_order as column_order 
from tern_xy_sc_bak.tn_meta_dmod_col_info t1 
left join (select distinct gkpt_name from dim_system_shortname) t2 on 1 = 1 
left join (
	select distinct 
		dmod_en_name
		,dmod_cn_name 
	from tern_xy_sc_bak.tn_meta_dmod_info 
) t3 on t1.dmod_en_name = t3.dmod_en_name and trim(lower(t3.dmod_en_name)) like concat(t2.gkpt_name,'.%') 
where trim(lower(t1.dmod_en_name)) like concat(t2.gkpt_name,'.%') 
;

truncate table source_meta_tables_detail;
insert into source_meta_tables_detail 
select  
	table_name 
	,full_table_name 
	,table_comment 
	,count(1) as columns_count 
from source_meta_columns_detail 
group by table_name,full_table_name,table_comment
;

-- 4.测试环境源表元数据
truncate table source_meta_columns_detail_test;
insert into source_meta_columns_detail_test 
select distinct 
	replace(trim(lower(t1.dmod_en_name)),concat(t2.gkpt_name,'.'),'') as table_name 
	,trim(lower(t1.dmod_en_name)) as full_table_name 
	,replace(trim(lower(t3.dmod_cn_name)),'\n','') as table_comment
	,trim(lower(t1.col_en_name)) as column_name 
	,trim(lower(t1.col_type)) as column_type
	,t1.col_len as column_length
	,t1.col_flo as column_flo
	,replace(trim(lower(t1.col_cn_name)),'\n','') as column_comment
	,t1.col_order as column_order 
from tern_xy.tn_meta_dmod_col_info t1 
left join (select distinct gkpt_name from dim_system_shortname_test) t2 on 1 = 1 
left join (
	select distinct 
		dmod_en_name
		,dmod_cn_name 
	from tern_xy.tn_meta_dmod_info
) t3 on t1.dmod_en_name = t3.dmod_en_name and trim(lower(t3.dmod_en_name)) like concat(t2.gkpt_name,'.%') 
where trim(lower(t1.dmod_en_name)) like concat(t2.gkpt_name,'.%') 
;

truncate table source_meta_tables_detail_test;
insert into source_meta_tables_detail_test 
select  
	table_name 
	,full_table_name 
	,table_comment 
	,count(1) as columns_count 
from source_meta_columns_detail_test  
group by table_name,full_table_name,table_comment
;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
