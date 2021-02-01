package service;

import com.alibaba.excel.EasyExcel;
import dao.CustomerContextHolder;
import dao.ParseDataDao;
import dao.SybaseProcedureDao;
import entity.procedure.ProcedureEntity;
import entity.raw_to_ods.RawToOdsEntity;
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
public class ParseProcedureService {
    private final String projectPath = System.getProperty("user.dir");
    private final FileTools fileTools;
    private final ParseDataDao parseDataDao;
    private final SybaseProcedureDao sybaseProcedureDao;

    @Autowired
    public ParseProcedureService(SybaseProcedureDao sybaseProcedureDao, ParseDataDao parseDataDao, FileTools fileTools) {
        this.fileTools = fileTools;
        this.parseDataDao = parseDataDao;
        this.sybaseProcedureDao = sybaseProcedureDao;
    }

    public void parseProcedure(List<String> userNameList) {
        String targetWriteDir = projectPath + "//PROCEDURE";
        Map<String, List<LinkedHashMap<String, String>>> userNameAndprocedureDetailMap = new HashMap<>();
        CustomerContextHolder.setCustomerType(CustomerContextHolder.SYBASE_SOURCE);
        log.info("开始按用户获取存储过程内容存入文件并解析");
        fileTools.truncateDir(targetWriteDir);
        userNameList.forEach(userName -> userNameAndprocedureDetailMap.put(userName, new ArrayList<>(sybaseProcedureDao.getProcedureDetail(userName))));
        List<ProcedureEntity> fileContext = new ArrayList<>();
        Set<String> sourceTableSet = new HashSet<>();
        Set<String> targetTableSet = new HashSet<>();
        userNameAndprocedureDetailMap.forEach((userName, procedure) -> procedure.forEach(map ->
                {
                    String procedureName = map.getOrDefault("proc_name", "无文件名");
                    String procedureSql = map.getOrDefault("proc_detail", "无内容").replace("--", "-- ");
                    String fileName = userName + "_" + procedureName + ".sql";
                    fileTools.WriteStringToFile(targetWriteDir, fileName, procedureSql);
                    procedureSql = fileTools.removeCursorsAndKeywords(procedureSql);
                    String[] fileNameSplits = fileName.split("_");
                    SqlParserTools.parseSybaseProcedureTables(procedureSql, sourceTableSet, targetTableSet, fileName);
                    if("p_edw_mkt_act".equalsIgnoreCase(procedureName)){
                        System.out.println("sourceTableSet = " + sourceTableSet);
                        System.out.println("targetTableSet = " + targetTableSet);
                        System.out.println("sourceTableSet.size() = " + sourceTableSet.size());
                        System.out.println("targetTableSet.size() = " + targetTableSet.size());
                    }
                    for (String sourceTable : sourceTableSet) {
                        ProcedureEntity procedureEntity = new ProcedureEntity();
                        procedureEntity.setFileAddr("PROCEDURE\\" + fileName);
                        procedureEntity.setFileName(fileName);
                        procedureEntity.setUserName(userName);
                        procedureEntity.setProcedureName(procedureName);
                        procedureEntity.setTableType("源表");
                        procedureEntity.setTableName(sourceTable);
                        procedureEntity.setCreateTime(LocalDate.now().toString());
                        procedureEntity.setModifyTime(LocalDate.now().toString());
                        fileContext.add(procedureEntity);
                    }
                    for (String targetTable : targetTableSet) {
                        ProcedureEntity procedureEntity = new ProcedureEntity();
                        procedureEntity.setFileAddr("PROCEDURE\\" + fileName);
                        procedureEntity.setFileName(fileName);
                        procedureEntity.setUserName(userName);
                        procedureEntity.setProcedureName(procedureName);
                        procedureEntity.setTableType("目标表");
                        procedureEntity.setTableName(targetTable);
                        procedureEntity.setCreateTime(LocalDate.now().toString());
                        procedureEntity.setModifyTime(LocalDate.now().toString());
                        fileContext.add(procedureEntity);
                    }
//            没解析出来的也存一条进去,方便定位问题
                    if (sourceTableSet.size() == 0 && targetTableSet.size() == 0) {
                        ProcedureEntity procedureEntity = new ProcedureEntity();
                        procedureEntity.setFileAddr("PROCEDURE\\" + fileName);
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
        parseDataDao.truncateTable("procedure_detail");
        parseDataDao.saveBatchProcedure("procedure_detail", fileContext);
        log.info("明细信息,开始存入excel");
        EasyExcel.write(projectPath + "\\procedure结果.xlsx", RawToOdsEntity.class).sheet("procedure结果").doWrite(fileContext);
        List<File> procedureFiles = fileTools.matchTargetFiles(projectPath, "procedure", ".sql");
        log.info("解析完成, procedure 共解析: {} 个, 明细: {}", procedureFiles.size(), fileContext.size());
    }
}
