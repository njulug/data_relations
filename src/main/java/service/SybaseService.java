package service;

import com.alibaba.excel.EasyExcel;
import config.DataBaseConstant;
import dao.CustomerContextHolder;
import dao.MySQLDao;
import dao.SybaseDao;
import entity.sybase.ProcedureEntity;
import entity.raw_to_ods.RawToOdsEntity;
import entity.sybase.ViewEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tools.FileTools;
import tools.SqlParserTools;

import java.io.File;
import java.time.LocalDate;
import java.util.*;

/**
 * Author:BYDylan
 * Date:2020/12/31
 * Description:
 */
@Slf4j
@Service
public class SybaseService {
    private final String projectPath = System.getProperty("user.dir");
    private final FileTools fileTools;
    private final MySQLDao mySQLDao;
    private final SybaseDao sybaseDao;

    @Autowired
    public SybaseService(SybaseDao sybaseDao, MySQLDao mySQLDao, FileTools fileTools) {
        this.fileTools = fileTools;
        this.mySQLDao = mySQLDao;
        this.sybaseDao = sybaseDao;
    }

    /**
     * 解析sybase视图中的源表,目标表
     * TODO 待查: SYBASE\VIEW\dba_v_ddw_a5_cpxsqkb_m.sql , 这个sql有点奇怪
     * @param userNameList 提供的用户列表
     */
    public void parseView(List<String> userNameList) {
        String targetWriteDir = projectPath + "\\SYBASE\\VIEW";
        Map<String, List<LinkedHashMap<String, String>>> userNameAndViewDetailMap = new HashMap<>();
        CustomerContextHolder.setCustomerType(CustomerContextHolder.SYBASE_SOURCE);
        log.info("开始按用户获取视图内容存入文件并解析");
        fileTools.truncateDir(targetWriteDir);
        userNameList.forEach(userName -> userNameAndViewDetailMap.put(userName, sybaseDao.getViewDetail(userName)));
        List<ViewEntity> fileContext = new ArrayList<>();
        userNameAndViewDetailMap.forEach((userName, viewList) -> viewList.forEach(view -> {
                    String viewName = view.getOrDefault("table_name", "未获取到视图名");
                    String viewDetail = view.getOrDefault("view_def", "未获取到视图内容");
                    String fileName = userName + "_" + viewName + ".sql";
                    fileTools.WriteStringToFile(targetWriteDir, fileName, viewDetail);
                    Map<String, String> sourceTargetTableMap = SqlParserTools.setJdbc(DataBaseConstant.SYBASE).getSourceTargetTables(viewDetail, "");
                    sourceTargetTableMap.forEach((key, value) -> {
                        ViewEntity viewEntity = new ViewEntity();
                        viewEntity.setFileAddr("SYBASE\\VIEW\\" + fileName);
                        viewEntity.setFileName(fileName);
                        viewEntity.setUserName(userName);
                        viewEntity.setViewName(viewName);
                        viewEntity.setTableType(value);
                        viewEntity.setTableName(key);
                        viewEntity.setCreateTime(LocalDate.now().toString());
                        viewEntity.setModifyTime(LocalDate.now().toString());
                        fileContext.add(viewEntity);
                    });
                }
        ));
        log.info("明细信息,开始存入数据库");
        CustomerContextHolder.setCustomerType(CustomerContextHolder.MYSQL_SOURCE);
        mySQLDao.truncateTable("sybase_view_detail");
        mySQLDao.saveBatchView("sybase_view_detail", fileContext);
        log.info("明细信息,开始存入excel");
        EasyExcel.write(projectPath + "\\sybase_view结果.xlsx", RawToOdsEntity.class).sheet("sybase_view").doWrite(fileContext);
        List<File> viewFiles = fileTools.matchTargetFiles(projectPath + "\\SYBASE", "view", ".sql");
        log.info("解析完成, view 共解析: {} 个, 明细: {}", viewFiles.size(), fileContext.size());
        viewFiles.clear();
    }

    /**
     * 解析sybase存储过程中的源表,目标表
     *
     * @param userNameList 提供的用户列表
     */
    public void parseProcedure(List<String> userNameList) {
        String targetWriteDir = projectPath + "\\SYBASE\\PROCEDURE";
        Map<String, List<LinkedHashMap<String, String>>> userNameAndprocedureDetailMap = new HashMap<>();
        CustomerContextHolder.setCustomerType(CustomerContextHolder.SYBASE_SOURCE);
        log.info("开始按用户获取存储过程内容存入文件并解析");
        fileTools.truncateDir(targetWriteDir);
        userNameList.forEach(userName -> userNameAndprocedureDetailMap.put(userName, sybaseDao.getProcedureDetail(userName)));
        List<ProcedureEntity> fileContext = new ArrayList<>();
        Set<String> sourceTableSet = new HashSet<>();
        Set<String> targetTableSet = new HashSet<>();
        userNameAndprocedureDetailMap.forEach((userName, procedure) -> procedure.forEach(map ->
                {
                    String procedureName = map.getOrDefault("proc_name", "无文件名");
                    String procedureSql = map.getOrDefault("proc_defn", "无内容").replace("--", "-- ");
                    String fileName = userName + "_" + procedureName + ".sql";
                    fileTools.WriteStringToFile(targetWriteDir, fileName, procedureSql);
                    procedureSql = fileTools.removeCursorsAndKeywords(procedureSql);
                    String[] fileNameSplits = fileName.split("_");
                    SqlParserTools.parseSybaseProcedureTables(procedureSql, sourceTableSet, targetTableSet, fileName);
                    for (String sourceTable : sourceTableSet) {
                        ProcedureEntity procedureEntity = new ProcedureEntity();
                        procedureEntity.setFileAddr("SYBASE\\PROCEDURE\\" + fileName);
                        procedureEntity.setFileName(fileName);
                        procedureEntity.setUserName(userName);
                        procedureEntity.setProcedureName(procedureName);
                        procedureEntity.setTableType("sourceTable");
                        procedureEntity.setTableName(sourceTable);
                        procedureEntity.setCreateTime(LocalDate.now().toString());
                        procedureEntity.setModifyTime(LocalDate.now().toString());
                        fileContext.add(procedureEntity);
                    }
                    for (String targetTable : targetTableSet) {
                        ProcedureEntity procedureEntity = new ProcedureEntity();
                        procedureEntity.setFileAddr("SYBASE\\PROCEDURE\\" + fileName);
                        procedureEntity.setFileName(fileName);
                        procedureEntity.setUserName(userName);
                        procedureEntity.setProcedureName(procedureName);
                        procedureEntity.setTableType("targetTable");
                        procedureEntity.setTableName(targetTable);
                        procedureEntity.setCreateTime(LocalDate.now().toString());
                        procedureEntity.setModifyTime(LocalDate.now().toString());
                        fileContext.add(procedureEntity);
                    }
//            没解析出来的也存一条进去,方便定位问题
                    if (sourceTableSet.size() == 0 && targetTableSet.size() == 0) {
                        ProcedureEntity procedureEntity = new ProcedureEntity();
                        procedureEntity.setFileAddr("SYBASE\\PROCEDURE\\" + fileName);
                        procedureEntity.setFileName(fileName);
                        procedureEntity.setUserName(userName);
                        procedureEntity.setProcedureName(procedureName);
                        fileContext.add(procedureEntity);
                    }
                    targetTableSet.clear();
                    sourceTableSet.clear();
                }
        ));
        log.info("明细信息,开始存入数据库");
        CustomerContextHolder.setCustomerType(CustomerContextHolder.MYSQL_SOURCE);
        mySQLDao.truncateTable("sybase_procedure_detail");
        mySQLDao.saveBatchProcedure("sybase_procedure_detail", fileContext);
        log.info("明细信息,开始存入excel");
        EasyExcel.write(projectPath + "\\sybase_procedure结果.xlsx", RawToOdsEntity.class).sheet("sybase_procedure").doWrite(fileContext);
        List<File> procedureFiles = fileTools.matchTargetFiles(projectPath + "\\SYBASE", "procedure", ".sql");
        log.info("解析完成, procedure 共解析: {} 个, 明细: {}", procedureFiles.size(), fileContext.size());
        procedureFiles.clear();
    }
}
