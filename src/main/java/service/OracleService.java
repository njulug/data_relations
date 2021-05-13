package service;

import com.alibaba.excel.EasyExcel;
import config.DataBaseConstant;
import dao.MySQLDao;
import dao.SybaseDao;
import entity.oracle.Dchis;
import entity.oracle.Dcraw;
import entity.oracle.Dcrun;
import entity.oracle.Dcser;
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
    private final SqlParserTools sqlParserTools;

    @Autowired
    public OracleService(SybaseDao sybaseDao, MySQLDao mySQLDao, FileTools fileTools, FileParseTools fileParseTools,SqlParserTools sqlParserTools) {
        this.fileTools = fileTools;
        this.mySQLDao = mySQLDao;
        this.sybaseDao = sybaseDao;
        this.fileParseTools = fileParseTools;
        this.sqlParserTools = sqlParserTools;
    }

    /**
     * 解析 Oracle dchis 文件中的源表,目标表
     */
    public void parseDchis() {
        log.info("开始解析 dchis");
        String targetWriteDir = projectPath + "\\ORACLE\\DCHIS";
        fileTools.truncateDir(targetWriteDir);
        List<Dchis> fileContext = new ArrayList<>();
        File dchisFile = new File(projectPath + "\\ORACLE\\dchis.sql");
        String sql = fileParseTools.clearOracleSpecialCharacters(dchisFile);
        fileTools.WriteStringToFile(targetWriteDir, "clear_dchis.sql", sql);
        List<Map<String, String>> sourceTargetTables = sqlParserTools.setJdbc(DataBaseConstant.ORACLE).getCreateSourceTargetTables(sql, dchisFile.getAbsolutePath());
        log.debug("dchis 解析结果: {}", sourceTargetTables);
        sourceTargetTables.forEach(map -> {
            Dchis dchis = new Dchis();
            dchis.setCreateName(map.getOrDefault("createName", ""));
            map.remove("createName");
            map.forEach((key, value) -> {
                Dchis clone = null;
                try {
                    clone = dchis.clone();
                } catch (CloneNotSupportedException ignored) {
                }
                clone.setFileAddr(dchisFile.getAbsolutePath());
                clone.setFileName(dchisFile.getName());
                clone.setTableName(key);
                clone.setTableType(value);
                clone.setCreateTime(LocalDate.now().toString());
                clone.setModifyTime(LocalDate.now().toString());
                fileContext.add(clone);
            });
        });
        log.info("明细信息,开始存入数据库");
        mySQLDao.truncateTable("oracle_dchis_detail");
        mySQLDao.saveBatchDchis("oracle_dchis_detail", fileContext);
        log.info("明细信息,开始存入excel");
        EasyExcel.write(projectPath + "\\oracle_dchis_detail结果.xlsx", Dchis.class).sheet("oracle_dchis_detail").doWrite(fileContext);
        log.info("解析完成, dchis 共解析: {} 个", fileContext.size());
    }

    /**
     * 解析 Oracle dcraw 文件中的源表,目标表
     */
    public void parseDcraw() {
        log.info("开始解析 dcraw");
        String targetWriteDir = projectPath + "\\ORACLE\\DCRAW";
        fileTools.truncateDir(targetWriteDir);
        List<Dcraw> fileContext = new ArrayList<>();
        File dchisFile = new File(projectPath + "\\ORACLE\\dcraw.sql");
        String sql = fileParseTools.clearOracleSpecialCharacters(dchisFile);
        fileTools.WriteStringToFile(targetWriteDir, "clear_dcraw.sql", sql);
        List<Map<String, String>> sourceTargetTables = sqlParserTools.setJdbc(DataBaseConstant.ORACLE).getCreateSourceTargetTables(sql, dchisFile.getAbsolutePath());
        log.debug("dcraw 解析结果: {}", sourceTargetTables);
        sourceTargetTables.forEach(map -> {
            Dcraw dcraw = new Dcraw();
            dcraw.setCreateName(map.getOrDefault("createName", ""));
            map.remove("createName");
            map.forEach((key, value) -> {
                Dcraw clone = null;
                try {
                    clone = dcraw.clone();
                } catch (CloneNotSupportedException ignored) {
                }
                clone.setFileAddr(dchisFile.getAbsolutePath());
                clone.setFileName(dchisFile.getName());
                clone.setTableName(key);
                clone.setTableType(value);
                clone.setCreateTime(LocalDate.now().toString());
                clone.setModifyTime(LocalDate.now().toString());
                fileContext.add(clone);
            });
        });
        log.info("明细信息,开始存入数据库");
        mySQLDao.truncateTable("oracle_dcraw_detail");
        mySQLDao.saveBatchDcraw("oracle_dcraw_detail", fileContext);
        log.info("明细信息,开始存入excel");
        EasyExcel.write(projectPath + "\\oracle_dcraw_detail结果.xlsx", RawToOdsEntity.class).sheet("oracle_dcraw_detail").doWrite(fileContext);
        log.info("解析完成, dcraw 共解析: {} 个", fileContext.size());
    }

    /**
     * 解析 Oracle dcrun 文件中的源表,目标表
     * 注意:
     * 1.只解析其中视图,建表部分,手工删掉其它的
     */
    public void parseDcrun() {
        log.info("开始解析 dcrun");
        String targetWriteDir = projectPath + "\\ORACLE\\DCRUN";
        fileTools.truncateDir(targetWriteDir);
        List<Dcrun> fileContext = new ArrayList<>();
        File dchisFile = new File(projectPath + "\\ORACLE\\dcrun.sql");
        String sql = fileParseTools.clearOracleSpecialCharacters(dchisFile);
        fileTools.WriteStringToFile(targetWriteDir, "clear_dcrun.sql", sql);
        List<Map<String, String>> sourceTargetTables = sqlParserTools.setJdbc(DataBaseConstant.ORACLE).getCreateSourceTargetTables(sql, dchisFile.getAbsolutePath());
        log.debug("dcrun 解析结果: {}", sourceTargetTables);
        sourceTargetTables.forEach(map -> {
            Dcrun dcrun = new Dcrun();
            dcrun.setCreateName(map.getOrDefault("createName", ""));
            map.remove("createName");
            map.forEach((key, value) -> {
                Dcrun clone = null;
                try {
                    clone = dcrun.clone();
                } catch (CloneNotSupportedException ignored) {
                }
                clone.setFileAddr(dchisFile.getAbsolutePath());
                clone.setFileName(dchisFile.getName());
                clone.setTableName(key);
                clone.setTableType(value);
                clone.setCreateTime(LocalDate.now().toString());
                clone.setModifyTime(LocalDate.now().toString());
                fileContext.add(clone);
            });
        });
        log.info("明细信息,开始存入数据库");
        mySQLDao.truncateTable("oracle_dcrun_detail");
        mySQLDao.saveBatchDcrun("oracle_dcrun_detail", fileContext);
        log.info("明细信息,开始存入excel");
        EasyExcel.write(projectPath + "\\oracle_dcrun_detail结果.xlsx", RawToOdsEntity.class).sheet("oracle_dcrun_detail").doWrite(fileContext);
        log.info("解析完成, dcrun 共解析: {} 个", fileContext.size());
    }

    /**
     * 解析 Oracle dcser 文件中的源表,目标表
     * 注意:
     * 1.只解析其中视图,建表部分,手工删掉其它的
     * 2.$ 直接去掉这个字符
     */
    public void parseDcser() {
        log.info("开始解析 dcser");
        String targetWriteDir = projectPath + "\\ORACLE\\DCSER";
        fileTools.truncateDir(targetWriteDir);
        List<Dcser> fileContext = new ArrayList<>();
        File dchisFile = new File(projectPath + "\\ORACLE\\dcser.sql");
        String sql = fileParseTools.clearOracleSpecialCharacters(dchisFile);
        fileTools.WriteStringToFile(targetWriteDir, "clear_dcser.sql", sql);
        List<Map<String, String>> sourceTargetTables = sqlParserTools.setJdbc(DataBaseConstant.ORACLE).getCreateSourceTargetTables(sql, dchisFile.getAbsolutePath());
        log.debug("dcser 解析结果: {}", sourceTargetTables);
        sourceTargetTables.forEach(map -> {
            Dcser dcser = new Dcser();
            dcser.setCreateName(map.getOrDefault("createName", ""));
            map.remove("createName");
            map.forEach((key, value) -> {
                Dcser clone = null;
                try {
                    clone = dcser.clone();
                } catch (CloneNotSupportedException ignored) {
                }
                clone.setFileAddr(dchisFile.getAbsolutePath());
                clone.setFileName(dchisFile.getName());
                clone.setTableName(key);
                clone.setTableType(value);
                clone.setCreateTime(LocalDate.now().toString());
                clone.setModifyTime(LocalDate.now().toString());
                fileContext.add(clone);
            });
        });
        log.info("明细信息,开始存入数据库");
        mySQLDao.truncateTable("oracle_dcser_detail");
        mySQLDao.saveBatchDcser("oracle_dcser_detail", fileContext);
        log.info("明细信息,开始存入excel");
        EasyExcel.write(projectPath + "\\oracle_dcser_detail结果.xlsx", RawToOdsEntity.class).sheet("oracle_dcser_detail").doWrite(fileContext);
        log.info("解析完成, dcser 共解析: {} 个", fileContext.size());
    }
}
