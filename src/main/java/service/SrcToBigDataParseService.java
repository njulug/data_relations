package service;

import com.alibaba.excel.EasyExcel;
import config.DataBaseConstant;
import dao.MySQLDao;
import entity.src_to_bigdata.HiveFileEntity;
import entity.src_to_bigdata.ShellEntity;
import entity.src_to_bigdata.TableEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tools.FileParseTools;
import tools.FileTools;
import tools.SqlParserTools;

import java.io.File;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Author:BYDylan
 * Date:2020/8/17
 * Description: 解析 源到大数据平台 ods_table,stg_table,hive_file
 * excel结果: 表名, 表注释名
 * 数据库结果: 表名, 字段名, 字段类型, 字段注释名, 创建时间, 修改时间
 */
@Service
@Slf4j
public class SrcToBigDataParseService {
    private final String projectPath = System.getProperty("user.dir");
    private final MySQLDao mySQLDao;
    private final FileTools fileTools;
    private final FileParseTools fileParseTools;
    private final SqlParserTools sqlParserTools;

    @Autowired
    public SrcToBigDataParseService(MySQLDao mySQLDao, FileTools fileTools, FileParseTools fileParseTools,SqlParserTools sqlParserTools) {
        this.mySQLDao = mySQLDao;
        this.fileTools = fileTools;
        this.fileParseTools = fileParseTools;
        this.sqlParserTools = sqlParserTools;
    }

    public List<TableEntity> odsTableParse() {
        log.info("-------开始解析 ods_sql");
        return tableParse("ods_sql");
    }

    public List<TableEntity> stgTableParse() {
        log.info("-------开始解析 stg_sql");
        return tableParse("stg_sql");
    }

    public List<ShellEntity> stgShellParse() {
        return shellParse("stg_shell");
    }

    public List<ShellEntity> odsShellParse() {
        return shellParse("ods_shell");
    }

    /**
     * hive_file 解析
     *
     * @return 返回所有行
     */
    public List<HiveFileEntity> hiveFileParse() {
        List<File> targetFileList = fileTools.matchTargetFiles(projectPath, "src_to_bigdata", "hive_file", ".sh");
        log.info("匹配到 hive_file 文件个数: {}", targetFileList.size());
        List<HiveFileEntity> fileContext = new ArrayList<>();
//        解析前先清空 mysql 表
        mySQLDao.truncateTable("hive_file_detail");
        log.info("表字段明细信息,开始存入数据库");
        for (File targetFile : targetFileList) {
            log.debug("开始解析文件: {}", targetFile);
            fileContext.add(fileParseTools.parseHiveFile(targetFile));
        }
        mySQLDao.saveBatchHiveFileDetail("hive_file_detail", fileContext);
        log.info("表字段明细信息,开始存入excel");
//        excelTools.writeExcel(HiveFileEntity.class, project_path + "\\hive_file结果.xlsx", fileContext);
        EasyExcel.write(projectPath + "\\hive_file结果.xlsx", HiveFileEntity.class).sheet("hive_file结果").doWrite(fileContext);
        log.info("解析完成, hive 共解析: {} 个, {} 行", targetFileList.size(), fileContext.size());
        return fileContext;
    }

    /**
     * stg_shell,ods_shell 解析
     *
     * @param parseType 解析类型 stg_shell / ods_shell
     * @return 返回所有行
     */
    private List<ShellEntity> shellParse(String parseType) {
        List<File> targetFileList = fileTools.matchTargetFiles(projectPath, "src_to_bigdata", parseType, ".sh");
        log.info("匹配到 {} 文件个数: {}", parseType, targetFileList.size());
        List<ShellEntity> fileContext = new ArrayList<>();
        mySQLDao.truncateTable(parseType + "_detail");
        for (File targetFile : targetFileList) {
            log.debug("开始解析文件: {}", targetFile);
            fileContext.add(fileParseTools.parseShell(parseType, targetFile));
        }
        log.info("明细信息,开始存入数据库");
        mySQLDao.saveBatchShellDetail(parseType + "_detail", fileContext);
//        excelTools.writeExcel(ShellEntity.class, project_path + File.separator + parseType + "结果.xlsx", fileContext);
        EasyExcel.write(projectPath + File.separator + parseType + "结果.xlsx", ShellEntity.class).sheet(parseType + "结果").doWrite(fileContext);
        log.info("解析完成, {} 共解析: {} 个, {} 行", parseType, targetFileList.size(), fileContext.size());

        return fileContext;
    }

    /**
     * 建表解析
     *
     * @param parseType 解析类型 ods_sql / stg_sql
     * @return 返回所有行
     */
    private List<TableEntity> tableParse(String parseType) {
        List<File> targetFileList = fileTools.matchTargetFiles(projectPath, "src_to_bigdata", parseType, ".sql");
        log.info("匹配到 {} 文件个数: {}", parseType, targetFileList.size());
        List<TableEntity> fileContext = new ArrayList<>();
//        解析前先清空 mysql 表
        mySQLDao.truncateTable(parseType + "_detail");
//        3.一次性插入
        log.info("表字段明细信息,开始存入数据库");
        for (File targetFile : targetFileList) {
            log.debug("开始解析文件: {}", targetFile);
            String sql = fileTools.readToBuffer(targetFile);
//            Map<String, String> tableNameAndComment = SqlParserTools.setJdbc(Constant.HIVE).getTableNameAndComment(sql, targetFile);
            List<Map<String, String>> fieldsDetailList = sqlParserTools.setJdbc(DataBaseConstant.HIVE).getFieldsDetail(sql, targetFile.getAbsolutePath());
//            2.一张表插入一次
//            List<TableDetailEntity> dataList = new ArrayList<>();
            for (Map<String, String> fieldsDetaiMap : fieldsDetailList) {
                TableEntity tableEntity = new TableEntity();
                tableEntity.setFileAddr(targetFile.getAbsolutePath().replace(projectPath + "\\", ""));
                tableEntity.setFileName(targetFile.getName());
                tableEntity.setTableName(fieldsDetaiMap.getOrDefault("tableName", ""));
                tableEntity.setTableComment(fieldsDetaiMap.getOrDefault("tableComment", ""));
                tableEntity.setColumnsCount(fieldsDetailList.size());
                tableEntity.setColumnName(fieldsDetaiMap.getOrDefault("columnName", ""));
                tableEntity.setColumnType(fieldsDetaiMap.getOrDefault("columnType", ""));
                tableEntity.setColumnComment(fieldsDetaiMap.getOrDefault("columnComment", ""));
                tableEntity.setColumnOrder(fieldsDetaiMap.getOrDefault("columnOrder", ""));
                tableEntity.setCreateTime(LocalDate.now().toString());
                tableEntity.setModifyTime(LocalDate.now().toString());
//                1.单条插入 慢N倍
//                parseDataDao.saveBatchTableDetail(parseType + "_detail", dataList);
                fileContext.add(tableEntity);
            }
//            2.一张表插入一次 慢N-1倍
//            parseDataDao.saveBatchTableDetail(parseType + "_detail", dataList);
        }
//            3.一次性插入,数据库设置上限了.
        for (int i = fileContext.size(); i > 0; i -= 10000) {
//            注意这里 sublist 是 [,)
            mySQLDao.saveBatchTableDetail(parseType + "_detail", fileContext.subList((i - 10000) < 0 ? 0 : i - 10000, i));
        }
        log.info("表字段明细信息,开始存入excel");
        EasyExcel.write(projectPath + File.separator + parseType + "结果.xlsx", TableEntity.class).sheet(parseType + "结果").doWrite(fileContext);
        log.info("解析完成, {} 共解析: {} 个, {} 行", parseType, targetFileList.size(), fileContext.size());
        return fileContext;
    }

}
