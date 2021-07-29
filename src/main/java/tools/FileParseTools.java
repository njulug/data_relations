package tools;

import config.DataBaseConstant;
import entity.src_to_bigdata.HiveFileEntity;
import entity.src_to_bigdata.ShellEntity;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.io.*;
import java.time.LocalDate;
import java.util.Locale;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Author:BYDylan
 * Date:2020/8/11
 * Description: 文件解析工具类
 */
@Slf4j
@Repository
public class FileParseTools {
    private final String projectPath = System.getProperty("user.dir");
    private final SqlParserTools sqlParserTools;

    @Autowired
    public FileParseTools(SqlParserTools sqlParserTools) {
        this.sqlParserTools = sqlParserTools;
    }

    @Test
    public void test() {
        String absolutePath = "C:\\Workspace\\ideaProject\\data_relations\\SRC_TO_BIGDATA\\glkj\\stg_shell\\t_stg_glkj_view_sc_shareresult_hv.sh";
//        System.out.println(parseStgShell(new File(absolutePath)));
        System.out.println("parseDchis(new File(\"\")) = " + clearOracleSpecialCharacters(new File("C:\\Workspace\\ideaProject\\data_relations\\ORACLE\\dcraw.sql")));
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
        Properties properties = new Properties();
        String hive_database = "";
        String hive_table = "";
        String all_columns = "";
        int all_columns_count = 0;
        String partition_key = "";
        String where_conditions = "";
        try {
            FileReader fr = new FileReader(targetFile);
            properties.load(fr);
            hive_database = properties.getProperty("HIVE_DATABASE","").toLowerCase(Locale.ROOT).trim();
            hive_table = properties.getProperty("HIVE_TABLE","").toLowerCase(Locale.ROOT).trim();
            all_columns = properties.getProperty("COLUMNS_NAME","").toLowerCase(Locale.ROOT).trim();
            all_columns_count = all_columns.split(",").length;
            partition_key = properties.getProperty("PARTITION_KEY","").toLowerCase(Locale.ROOT).trim();
            where_conditions = properties.getProperty("WHERE_CONDITIONS","").toLowerCase(Locale.ROOT).trim();
        } catch (Exception e) {
            log.error("读取文件出错: {}, 报错信息: {}", targetFile, e.getMessage());
        } finally {
            hiveFileEntity.setFileAddr(targetFile.getAbsolutePath().replace(projectPath + "\\", ""));
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
            log.error("读取文件出错: {}, 报错信息: {}", targetFile, e.getMessage());
        } finally {
            shellEntity.setFileAddr(targetFile.getAbsolutePath().replace(projectPath + "\\", ""));
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
        String where_conditions = "";
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
//                } else if (line.toLowerCase().contains("where_conditions=")) {
////                    有2行的清空,如果有了就不判断第2次了
//                    if (where_conditions == null | "".equalsIgnoreCase(where_conditions)) {
//                        where_conditions = line.toLowerCase().replace("where_conditions=", "");
//                        String pattern = "(/.*(/!))";
//                        Pattern p = Pattern.compile(pattern);
//                        Matcher matcher = p.matcher(where_conditions);
//                        if (matcher.find()) {
//                            where_conditions = matcher.group().replaceAll("/|\\^|=|!", "");
//                            log.debug("where_conditions: {}", where_conditions);
//                        }
//                    }
                } else if (line.toLowerCase().contains("where_conditions=")) {
                    where_conditions = line.toLowerCase().replace("where_conditions=", "").replace("\"", "");
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
                    parse_all_columns = sqlParserTools.setJdbc(DataBaseConstant.ORACLE)
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
            log.error("读取文件出错: {}, 报错信息: {}", targetFile, e.getMessage());
        } finally {
            shellEntity.setFileAddr(targetFile.getAbsolutePath().replace(projectPath + "\\", ""));
            shellEntity.setFileName(targetFile.getName());
            shellEntity.setSourceTableName(source_table);
            shellEntity.setFilterKey(filter_key);
            shellEntity.setWhereConditions(where_conditions);
            shellEntity.setXtjc(xtjc);
            shellEntity.setAllColumns(all_columns);
            shellEntity.setAllColumnsCount(all_columns_count);
            shellEntity.setParseAllColumns(parse_all_columns);
            shellEntity.setCreateTime(LocalDate.now().toString());
            shellEntity.setModifyTime(LocalDate.now().toString());
        }
        return shellEntity;
    }

    /**
     * 解析 dchis,dcraw文件,去掉无法解析的行
     * 特殊情况:
     * 1.create unique index BIN$2Vi6FwEdexjgQBSBUA1Tag==$0 on CCK_RZ_TERR_OPERATE (ID);
     * 特殊字符 $ 规避掉
     * 2.  BY      VARCHAR2(200)
     * 关键字 ,手动加上分号    `BY`      VARCHAR2(200)
     *
     * @param targetFile 文件
     * @return 返回sql内容
     */
    public String clearOracleSpecialCharacters(File targetFile) {
        StringBuilder stringBuilder = new StringBuilder();
        try {
            FileReader fr = new FileReader(targetFile);
            LineNumberReader lnr = new LineNumberReader(fr);
            while (lnr.ready()) {
                String line = lnr.readLine();
//                Pattern p = Pattern.compile("^(prompt).*|\\$");
                Pattern p = Pattern.compile("^(prompt).*|\\$");
                Matcher matcher = p.matcher(line.trim());
                if (!matcher.find() && line != null && !"\\".equalsIgnoreCase(line.trim()) && !"/".equalsIgnoreCase(line.trim())) {
//                    if (!"/".equalsIgnoreCase(line.trim())) {
                    stringBuilder.append(line).append("\n");
//                    } else {
//                        stringBuilder.append(";").append("\n");
//                    }
                }
            }
        } catch (Exception e) {
            log.error("读取文件出错: {}, 报错信息: {}", targetFile, e.getMessage());
        }
        return stringBuilder.toString();
    }
}
