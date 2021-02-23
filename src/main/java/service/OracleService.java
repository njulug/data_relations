package service;

import com.alibaba.excel.EasyExcel;
import config.DataBaseConstant;
import dao.MySQLDao;
import dao.SybaseDao;
import entity.oracle.Dchis;
import entity.oracle.Dcraw;
import entity.raw_to_ods.RawToOdsEntity;
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
 * Date:2020/12/31
 * Description:
 */
@Slf4j
@Service
public class OracleService {
    private final String projectPath = System.getProperty("user.dir");
    private final FileTools fileTools;
    private final MySQLDao mySQLDao;
    private final SybaseDao sybaseDao;
    private final FileParseTools fileParseTools;

    @Autowired
    public OracleService(SybaseDao sybaseDao, MySQLDao mySQLDao, FileTools fileTools, FileParseTools fileParseTools) {
        this.fileTools = fileTools;
        this.mySQLDao = mySQLDao;
        this.sybaseDao = sybaseDao;
        this.fileParseTools = fileParseTools;
    }

    /**
     * 解析 Oracle dchis 文件中的源表,目标表
     */
    public void parseDchis() {
        String targetWriteDir = projectPath + "\\ORACLE\\DCHIS";
        fileTools.truncateDir(targetWriteDir);
        List<Dchis> fileContext = new ArrayList<>();
        File dchisFile = new File("C:\\Workspace\\ideaProject\\data_relations\\ORACLE\\dchis.sql");
        String sql = fileParseTools.clearOracleSpecialCharacters(dchisFile);
        fileTools.WriteStringToFile(targetWriteDir, "clear_dchis.sql", sql);
        Map<String, String> sourceTargetTables = SqlParserTools.setJdbc(DataBaseConstant.ORACLE).getSourceTargetTables(sql, dchisFile.getAbsolutePath());
        log.debug("解析结果: {}", sourceTargetTables);
        sourceTargetTables.forEach((key, value) -> {
            Dchis dchis = new Dchis();
            dchis.setFileAddr(dchisFile.getAbsolutePath());
            dchis.setFileName(dchisFile.getName());
            dchis.setTableName(key);
            dchis.setTableType(value);
            dchis.setCreateTime(LocalDate.now().toString());
            dchis.setModifyTime(LocalDate.now().toString());
            fileContext.add(dchis);
        });
        log.info("明细信息,开始存入数据库");
        mySQLDao.truncateTable("oracle_dchis_detail");
        mySQLDao.saveBatchDchis("oracle_dchis_detail", fileContext);
        log.info("明细信息,开始存入excel");
        EasyExcel.write(projectPath + "\\oracle_dchis_detail结果.xlsx", RawToOdsEntity.class).sheet("oracle_dchis_detail").doWrite(fileContext);
        log.info("解析完成, procedure 共解析: {} 个", fileContext.size());
    }

    /**
     * 解析 Oracle dcraw 文件中的源表,目标表
     */
    public void parseDcraw() {
        String targetWriteDir = projectPath + "\\ORACLE\\DCRAW";
        fileTools.truncateDir(targetWriteDir);
        List<Dcraw> fileContext = new ArrayList<>();
        File dchisFile = new File("C:\\Workspace\\ideaProject\\data_relations\\ORACLE\\dcraw.sql");
        String sql = fileParseTools.clearOracleSpecialCharacters(dchisFile);
        fileTools.WriteStringToFile(targetWriteDir, "clear_dcraw.sql", sql);
        Map<String, String> sourceTargetTables = SqlParserTools.setJdbc(DataBaseConstant.ORACLE).getSourceTargetTables(sql, dchisFile.getAbsolutePath());
        log.debug("解析结果: {}", sourceTargetTables);
        sourceTargetTables.forEach((key, value) -> {
            Dcraw dcraw = new Dcraw();
            dcraw.setFileAddr(dchisFile.getAbsolutePath());
            dcraw.setFileName(dchisFile.getName());
            dcraw.setTableName(key);
            dcraw.setTableType(value);
            dcraw.setCreateTime(LocalDate.now().toString());
            dcraw.setModifyTime(LocalDate.now().toString());
            fileContext.add(dcraw);
        });
        log.info("明细信息,开始存入数据库");
        mySQLDao.truncateTable("oracle_dcraw_detail");
        mySQLDao.saveBatchDcraw("oracle_dcraw_detail", fileContext);
        log.info("明细信息,开始存入excel");
        EasyExcel.write(projectPath + "\\oracle_dcraw_detail结果.xlsx", RawToOdsEntity.class).sheet("oracle_dcraw_detail").doWrite(fileContext);
        log.info("解析完成, procedure 共解析: {} 个", fileContext.size());
    }

    /**
     * 解析 Oracle dcrun 文件中的源表,目标表
     * 注意:
     * 1.只解析其中视图,建表部分,手工删掉其它的
     */
    public void parseDcrun() {
        String targetWriteDir = projectPath + "\\ORACLE\\DCRUN";
        fileTools.truncateDir(targetWriteDir);
        List<Dcraw> fileContext = new ArrayList<>();
        File dchisFile = new File("C:\\Workspace\\ideaProject\\data_relations\\ORACLE\\dcrun.sql");
        String sql = fileParseTools.clearOracleSpecialCharacters(dchisFile);
        fileTools.WriteStringToFile(targetWriteDir, "clear_dcrun.sql", sql);
        Map<String, String> sourceTargetTables = SqlParserTools.setJdbc(DataBaseConstant.ORACLE).getSourceTargetTables(sql, dchisFile.getAbsolutePath());
        log.debug("解析结果: {}", sourceTargetTables);
        sourceTargetTables.forEach((key, value) -> {
            Dcraw dcraw = new Dcraw();
            dcraw.setFileAddr(dchisFile.getAbsolutePath());
            dcraw.setFileName(dchisFile.getName());
            dcraw.setTableName(key);
            dcraw.setTableType(value);
            dcraw.setCreateTime(LocalDate.now().toString());
            dcraw.setModifyTime(LocalDate.now().toString());
            fileContext.add(dcraw);
        });
        log.info("明细信息,开始存入数据库");
        mySQLDao.truncateTable("oracle_dcrun_detail");
        mySQLDao.saveBatchDcraw("oracle_dcrun_detail", fileContext);
        log.info("明细信息,开始存入excel");
        EasyExcel.write(projectPath + "\\oracle_dcrun_detail结果.xlsx", RawToOdsEntity.class).sheet("oracle_dcrun_detail").doWrite(fileContext);
        log.info("解析完成, procedure 共解析: {} 个", fileContext.size());
    }

    /**
     * 解析 Oracle dcser 文件中的源表,目标表
     * 注意:
     * 1.只解析其中视图,建表部分,手工删掉其它的
     * 2.$ 直接去掉这个字符
     */
    public void parseDcser() {
        String targetWriteDir = projectPath + "\\ORACLE\\DCSER";
        fileTools.truncateDir(targetWriteDir);
        List<Dcraw> fileContext = new ArrayList<>();
        File dchisFile = new File("C:\\Workspace\\ideaProject\\data_relations\\ORACLE\\dcser.sql");
        String sql = fileParseTools.clearOracleSpecialCharacters(dchisFile);
        fileTools.WriteStringToFile(targetWriteDir, "clear_dcser.sql", sql);
        Map<String, String> sourceTargetTables = SqlParserTools.setJdbc(DataBaseConstant.ORACLE).getSourceTargetTables(sql, dchisFile.getAbsolutePath());
        log.debug("解析结果: {}", sourceTargetTables);
        sourceTargetTables.forEach((key, value) -> {
            Dcraw dcraw = new Dcraw();
            dcraw.setFileAddr(dchisFile.getAbsolutePath());
            dcraw.setFileName(dchisFile.getName());
            dcraw.setTableName(key);
            dcraw.setTableType(value);
            dcraw.setCreateTime(LocalDate.now().toString());
            dcraw.setModifyTime(LocalDate.now().toString());
            fileContext.add(dcraw);
        });
        log.info("明细信息,开始存入数据库");
        mySQLDao.truncateTable("oracle_dcser_detail");
        mySQLDao.saveBatchDcraw("oracle_dcser_detail", fileContext);
        log.info("明细信息,开始存入excel");
        EasyExcel.write(projectPath + "\\oracle_dcser_detail结果.xlsx", RawToOdsEntity.class).sheet("oracle_dcser_detail").doWrite(fileContext);
        log.info("解析完成, procedure 共解析: {} 个", fileContext.size());
    }
}
