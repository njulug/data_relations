package tools;

import config.DataBaseConstant;
import entity.src_to_bigdata.HiveFileEntity;
import entity.src_to_bigdata.ShellEntity;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.springframework.stereotype.Repository;

import java.io.*;
import java.time.LocalDate;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Author:BYDylan
 * Date:2020/8/11
 * Description: stg_shell, ods_shell 解析工具类
 */
@Slf4j
@Repository
public class FileParseTools {
    private final String project_path = System.getProperty("user.dir");

    @Test
    public void test() {
        String absolutePath = "C:\\Workspace\\ideaProject\\data_relations\\SRC_TO_BIGDATA\\glkj\\stg_shell\\t_stg_glkj_view_sc_shareresult_hv.sh";
        System.out.println(parseStgShell(new File(absolutePath)));
    }

    public ShellEntity parseShell(String parseType, File targetFile) {
        ShellEntity shellEntity;
        if ("ods_shell".equalsIgnoreCase(parseType)) {
            shellEntity = parseOdsShell(targetFile);
        } else {
            shellEntity = parseStgShell(targetFile);
        }
        return shellEntity;
    }

    /**
     * hive_file 具体解析类
     *
     * @param targetFile 要解析的文件
     * @return 返回解析的内容
     */
    public HiveFileEntity parseHiveFile(File targetFile) {
        HiveFileEntity hiveFileEntity = new HiveFileEntity();
        String hive_database = "";
        String hive_table = "";
        String all_columns = "";
        int all_columns_count = 0;
        String partition_key = "";
        String where_conditions = "";
        try {
            FileReader fr = new FileReader(targetFile);
            LineNumberReader lnr = new LineNumberReader(fr);
            while (lnr.ready()) {
                String line = lnr.readLine();
                if (line.toLowerCase().contains("hive_database=")) {
                    hive_database = line.toLowerCase().replace("hive_database=", "");
                } else if (line.toLowerCase().contains("hive_table=")) {
                    hive_table = line.toLowerCase().replace("hive_table=", "");
                } else if (line.toLowerCase().contains("columns_name=")) {
                    all_columns = line.toLowerCase().replace("columns_name=", "").replaceAll("[' ]", "");
                    all_columns_count = all_columns.split(",").length;
                } else if (line.toLowerCase().contains("partition_key=")) {
                    partition_key = line.toLowerCase().replace("partition_key=", "");
                } else if (line.toLowerCase().contains("where_conditions=")) {
                    where_conditions = line.toLowerCase().replace("where_conditions=", "").replace("\"", "");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            hiveFileEntity.setFileAddr(targetFile.getAbsolutePath().replace(project_path + "\\", ""));
            String[] pathSplit = targetFile.getAbsolutePath().split("\\\\");
            hiveFileEntity.setFileName(pathSplit[pathSplit.length - 1].trim());
            hiveFileEntity.setOdsTableName(hive_database + "." + hive_table);
            hiveFileEntity.setAllColumns(all_columns);
            hiveFileEntity.setAllColumnsCount(all_columns_count);
            hiveFileEntity.setPartitionKey(partition_key);
            hiveFileEntity.setWhereCondition(where_conditions);
            hiveFileEntity.setCreateTime(LocalDate.now().toString());
            hiveFileEntity.setModifyTime(LocalDate.now().toString());
        }
        return hiveFileEntity;
    }

    /**
     * ods_shell 具体解析类
     *
     * @param targetFile 要解析的文件
     * @return 返回解析的内容
     */
    private ShellEntity parseOdsShell(File targetFile) {
        ShellEntity shellEntity = new ShellEntity();
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;
        String hive_database_stg = "";
        String hive_database_ods = "";
        String hive_table_stg = "";
        String hive_table_ods = "";
        try {
            FileReader fr = new FileReader(targetFile);
            LineNumberReader lnr = new LineNumberReader(fr);
            while (lnr.ready()) {
                String line = lnr.readLine();
                if (line.toLowerCase().contains("hive_database_stg=")) {
                    hive_database_stg = line.toLowerCase().replace("hive_database_stg=", "");
                } else if (line.toLowerCase().contains("hive_table_stg=")) {
                    hive_table_stg = line.toLowerCase().replace("hive_table_stg=", "");
                } else if (line.toLowerCase().contains("hive_database_ods=")) {
                    hive_database_ods = line.toLowerCase().replace("hive_database_ods=", "");
                } else if (line.toLowerCase().contains("hive_table_ods=")) {
                    hive_table_ods = line.toLowerCase().replace("hive_table_ods=", "");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            shellEntity.setFileAddr(targetFile.getAbsolutePath().replace(project_path + "\\", ""));
            shellEntity.setFileName(targetFile.getName());
            shellEntity.setStgTableName(hive_database_stg + "." + hive_table_stg);
            shellEntity.setOdsTableName(hive_database_ods + "." + hive_table_ods);
            shellEntity.setCreateTime(LocalDate.now().toString());
            shellEntity.setModifyTime(LocalDate.now().toString());
        }

        return shellEntity;
    }

    /**
     * stg_shell 具体解析对象
     *
     * @param targetFile 要解析的文件
     * @return 返回解析的内容
     */
    private ShellEntity parseStgShell(File targetFile) {
        ShellEntity shellEntity = new ShellEntity();
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;
        String source_table = "";
        String target_table = "";
        String filter_key = "";
        String all_columns = "";
        int all_columns_count = 0;
        String parse_all_columns = "";
        String target_database = "";
        String jdbc_string = "";
        String xtjc = "";
        try {
            FileReader fr = new FileReader(targetFile);
            LineNumberReader lnr = new LineNumberReader(fr);
            while (lnr.ready()) {
                String line = lnr.readLine();
                if (line.toLowerCase().contains("table_name=")) {
                    source_table = line.toLowerCase().replace("table_name=", "");
                } else if (line.toLowerCase().contains("hive_database=")) {
                    target_database = line.toLowerCase().replace("hive_database=", "");
                } else if (line.toLowerCase().contains("hive_table=")) {
                    target_table = line.toLowerCase().replace("hive_table=", "");
                } else if (line.toLowerCase().contains("jdbc_string=")) {
//                    有2行的清空,如果有了就不判断第2次了
                    if (jdbc_string == null | "".equalsIgnoreCase(jdbc_string)) {
                        jdbc_string = line.toLowerCase().replace("jdbc_string=", "");
                        String pattern = "(/.*(/!))";
                        Pattern p = Pattern.compile(pattern);
                        Matcher matcher = p.matcher(jdbc_string);
                        if (matcher.find()) {
                            jdbc_string = matcher.group().replaceAll("/|\\^|=|!", "");
                            log.debug("jdbc_string: {}", jdbc_string);
                        }
                    }
                } else if (line.toLowerCase().contains("source_db_username=")) {
//                    有2行的清空,如果有了就不判断第2次了
                    if (xtjc == null | "".equalsIgnoreCase(xtjc)) {
                        xtjc = line.toLowerCase().replace("source_db_username=", "");
                        String pattern = "(/.*(/!))";
                        Pattern p = Pattern.compile(pattern);
                        Matcher matcher = p.matcher(xtjc);
                        if (matcher.find()) {
                            xtjc = matcher.group().replaceAll("/|\\^|=|!", "")
                                    .replace("source_db_username_", "");
                            log.debug("xtjc: {}", xtjc);
                        }
                    }
                } else if (line.toLowerCase().contains("filter_key=")) {
                    filter_key = line.toLowerCase()
                            .replace("filter_key=", "")
                            .replace("\"", "");
                } else if (line.toLowerCase().contains("all_columns=")) {
//                    去掉 " \ 以及 逗号前后的空格,然后用sql解析出来字段列表
                    all_columns = line.toLowerCase()
                            .replace("all_columns=", "")
                            .replaceAll("\"|\\\\", "")
                            .replaceAll("( +,)|(, +)", ",");
                    all_columns_count = all_columns.split(",").length;
                    parse_all_columns = SqlParserTools.setJdbc(DataBaseConstant.ORACLE)
                            .getAllColumns("select " + all_columns + " from test;", targetFile.getAbsolutePath())
                            .toString().replaceAll("\\[|\\]| +", "");
                }
            }
            if (target_database == null && target_table == null) {
                shellEntity.setStgTableName("空");
            } else if (target_database == null) {
                shellEntity.setStgTableName(target_table);
            } else {
                shellEntity.setStgTableName(target_database + "." + target_table);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            shellEntity.setFileAddr(targetFile.getAbsolutePath().replace(project_path + "\\", ""));
            shellEntity.setFileName(targetFile.getName());
            shellEntity.setSourceTableName(source_table);
            shellEntity.setFilterKey(filter_key);
            shellEntity.setJdbcName(jdbc_string);
            shellEntity.setXtjc(xtjc);
            shellEntity.setAllColumns(all_columns);
            shellEntity.setAllColumnsCount(all_columns_count);
            shellEntity.setParseAllColumns(parse_all_columns);
            shellEntity.setCreateTime(LocalDate.now().toString());
            shellEntity.setModifyTime(LocalDate.now().toString());
        }
        return shellEntity;
    }
}
