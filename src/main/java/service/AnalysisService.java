package service;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.ExcelWriter;
import com.alibaba.excel.write.metadata.WriteSheet;
import dao.AnalysisDao;
import dao.MySQLDao;
import entity.azkaban.AzkabanEntity;
import entity.excel.FreezeAndFilter;
import entity.src_to_bigdata.ShellEntity;
import entity.src_to_bigdata.SrcToBigDataEntity;
import entity.src_to_bigdata.TableEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

/**
 * Author:BYDylan
 * Date:2020/12/31
 * Description:
 */
@Slf4j
@Service
public class AnalysisService {
    private final String projectPath = System.getProperty("user.dir");
    private final AnalysisDao analysisDao;
    private final MySQLDao mySQLDao;

    @Autowired
    public AnalysisService(AnalysisDao analysisDao, MySQLDao mySQLDao) {
        this.analysisDao = analysisDao;
        this.mySQLDao = mySQLDao;
    }

    public void execProcedure(List<String> procedureNameList) {
        LocalDateTime startTime;
        for (String procedureName : procedureNameList) {
            startTime = LocalDateTime.now();
            log.info("执行存过: {}", procedureName);
            analysisDao.callProcedure(procedureName);
            log.info("耗时 : {} 秒", Duration.between(startTime, LocalDateTime.now()).getSeconds());
        }
    }

    public void exportResult(List<String> viewNameList) {
        WriteSheet writeSheet;
        List<LinkedHashMap<String, Object>> viewDataList;
        List<List<String>> sheetHeadList = new ArrayList<>();
        List<List<Object>> sheetDataList = new ArrayList<>();
//        ExcelWriter excelWriter = EasyExcel.write(projectPath + "\\大数据平台梳理结果-" + LocalDate.now().toString().replace("-", "") + ".xlsx").build();
//        ExcelWriter excelWriter = EasyExcel.write(projectPath + "\\大数据平台梳理结果.xlsx").build();
        ExcelWriter excelWriter = EasyExcel.write(projectPath + "\\大数据平台梳理结果-" + LocalDate.now().toString().replace("-", "") + ".xlsx")
                .withTemplate(projectPath + "\\大数据平台梳理结果-模板.xlsx")
                .build();

        writeSheet = EasyExcel.writerSheet(0, "说明")
                .head(sheetHeadList)
                .registerWriteHandler(new FreezeAndFilter())
                .build();
        excelWriter.write(sheetDataList, writeSheet);
        int i = 1;
        for (String viewName : viewNameList) {
            log.info("查询视图: {}", viewName);
            viewDataList = analysisDao.selectData(viewName);
            sheetHeadList.add(Collections.singletonList("序号"));
            if (viewDataList != null && viewDataList.size() > 0) {
                viewDataList.get(0).keySet().forEach(entity -> sheetHeadList.add(Collections.singletonList(entity)));
            }
            AtomicInteger index = new AtomicInteger(1);
            viewDataList.forEach(entity -> {
                List<Object> dataList = new ArrayList<>(entity.values());
                dataList.add(0, index.getAndIncrement());
                sheetDataList.add(dataList);
            });
            writeSheet = EasyExcel.writerSheet(i++, viewName)
//                    .head(sheetHeadList) // 表头
//                    .registerWriteHandler(new FreezeAndFilter())
                    .build();
            excelWriter.write(sheetDataList, writeSheet);
            sheetDataList.clear();
            sheetHeadList.clear();
        }
        excelWriter.finish();
    }

    public void mergeSrcToBigData(List<ShellEntity> odsShellList
            , List<ShellEntity> stgShellList
            , List<TableEntity> odsTableList
            , List<AzkabanEntity> azkabanList) {
        log.info("-------开始合并 src_to_bigdata");
        log.debug("1. ods_sql 里面是明细,这里只要表名和注释即可");
        Map<String, String> odsTableNameAndCommentMap = new HashMap<>();
        for (TableEntity odsTableEntity : odsTableList) {
            odsTableNameAndCommentMap.put(odsTableEntity.getTableName(), odsTableEntity.getTableComment());
        }
        log.debug("2. azkaban 只要 ods_shell 的数据,因为azkaban解析的时候,以 ods_shell为主,整合的 stg_shell");
        azkabanList = azkabanList.stream()
                .filter(entity -> "ods_shell".equalsIgnoreCase(entity.getParseType()))
                .collect(Collectors.toList());
        log.debug("3. 整合 ods_shell 和 stg_shell");
        List<SrcToBigDataEntity> srcToBigDataList = new ArrayList<>();
        if (odsShellList.size() > stgShellList.size()) {
            for (ShellEntity odsShellEntity : odsShellList) {
                String odsShellStgTableName = odsShellEntity.getStgTableName();
                String odsShellOdsTableName = odsShellEntity.getOdsTableName();
                String odsShellFileName = odsShellEntity.getFileName();
                SrcToBigDataEntity srcToBigDataEntity = new SrcToBigDataEntity();
                srcToBigDataEntity.setCreateTime(LocalDate.now().toString());
                srcToBigDataEntity.setModifyTime(LocalDate.now().toString());
                srcToBigDataEntity.setOdsFilePath(odsShellEntity.getFileAddr());
                srcToBigDataEntity.setOdsTableName(odsShellOdsTableName);
                srcToBigDataEntity.setOdsTableComment(odsTableNameAndCommentMap.get(odsShellOdsTableName));
                List<AzkabanEntity> list = azkabanList.stream()
                        .filter(entity -> entity.getFileName().equalsIgnoreCase(odsShellFileName))
                        .collect(Collectors.toList());
                if (list.size() > 1) {
                    log.warn("匹配到多个调度文件行 {} 个: {} , \njob名: {}", list.size(), odsShellFileName, list.stream().map(AzkabanEntity::getJobName).collect(Collectors.toList()).toString());
                }
                for (AzkabanEntity azkabanEntity : azkabanList) {
                    String subFileName = azkabanEntity.getSubFileName();
                    if (subFileName.equalsIgnoreCase(odsShellFileName)) {
                        srcToBigDataEntity.setJobName(azkabanEntity.getJobName());
                        srcToBigDataEntity.setStgShellSName(azkabanEntity.getStgShellSName());
                        srcToBigDataEntity.setStgShellEName(azkabanEntity.getStgShellEName());
                        srcToBigDataEntity.setOdsShellGName(azkabanEntity.getOdsShellGName());
                        srcToBigDataEntity.setOdsShellKName(azkabanEntity.getOdsShellKName());
                        srcToBigDataEntity.setHiveFileCName(azkabanEntity.getHiveFileCName());
                        srcToBigDataEntity.setCommand(azkabanEntity.getCommand());
                        break;
                    }
                }
                for (ShellEntity stgShellEntity : stgShellList) {
                    String stgShellstgTableName = stgShellEntity.getStgTableName();
                    if (odsShellStgTableName.equalsIgnoreCase(stgShellstgTableName)) {
                        srcToBigDataEntity.setStgFilePath(stgShellEntity.getFileAddr());
                        srcToBigDataEntity.setStgFileName(stgShellEntity.getFileName());
                        srcToBigDataEntity.setSourceTableName(stgShellEntity.getSourceTableName());
                        srcToBigDataEntity.setFilterKey(stgShellEntity.getFilterKey());
                        srcToBigDataEntity.setXtjc(stgShellEntity.getXtjc());
                        srcToBigDataEntity.setJdbcName(stgShellEntity.getJdbcName());
                        srcToBigDataEntity.setStgTableName(stgShellEntity.getStgTableName());
                        break;
                    }
                }
                srcToBigDataList.add(srcToBigDataEntity);
            }
        } else {
            for (ShellEntity stgShellEntity : stgShellList) {
                String stgShellstgTableName = stgShellEntity.getStgTableName();
                SrcToBigDataEntity srcToBigDataEntity = new SrcToBigDataEntity();
                srcToBigDataEntity.setCreateTime(LocalDate.now().toString());
                srcToBigDataEntity.setModifyTime(LocalDate.now().toString());
                srcToBigDataEntity.setStgFilePath(stgShellEntity.getFileAddr());
                srcToBigDataEntity.setStgFileName(stgShellEntity.getFileName());
                srcToBigDataEntity.setSourceTableName(stgShellEntity.getSourceTableName());
                srcToBigDataEntity.setFilterKey(stgShellEntity.getFilterKey());
                srcToBigDataEntity.setXtjc(stgShellEntity.getXtjc());
                srcToBigDataEntity.setJdbcName(stgShellEntity.getJdbcName());
                srcToBigDataEntity.setStgTableName(stgShellEntity.getStgTableName());
                for (ShellEntity odsShellEntity : odsShellList) {
                    String odsShellStgTableName = odsShellEntity.getStgTableName();
                    String odsShellOdsTableName = odsShellEntity.getOdsTableName();
                    String odsShellFileName = odsShellEntity.getFileName();
                    List<AzkabanEntity> list = azkabanList.stream()
                            .filter(entity -> entity.getFileName().equalsIgnoreCase(odsShellFileName))
                            .collect(Collectors.toList());
                    if (list.size() > 1) {
                        log.warn("匹配到多个调度文件行 {} 个: {} , \njob名: {}", list.size(), odsShellFileName, list.stream().map(AzkabanEntity::getJobName).collect(Collectors.toList()).toString());
                    }
                    for (AzkabanEntity azkabanEntity : azkabanList) {
                        String subFileName = azkabanEntity.getSubFileName();
                        if (subFileName.equalsIgnoreCase(odsShellFileName)) {
                            srcToBigDataEntity.setJobName(azkabanEntity.getJobName());
                            srcToBigDataEntity.setStgShellSName(azkabanEntity.getStgShellSName());
                            srcToBigDataEntity.setStgShellEName(azkabanEntity.getStgShellEName());
                            srcToBigDataEntity.setOdsShellGName(azkabanEntity.getOdsShellGName());
                            srcToBigDataEntity.setOdsShellKName(azkabanEntity.getOdsShellKName());
                            srcToBigDataEntity.setHiveFileCName(azkabanEntity.getHiveFileCName());
                            srcToBigDataEntity.setCommand(azkabanEntity.getCommand());
                            break;
                        }
                    }
                    if (odsShellStgTableName.equalsIgnoreCase(stgShellstgTableName)) {
                        srcToBigDataEntity.setOdsFilePath(odsShellEntity.getFileAddr());
                        srcToBigDataEntity.setOdsTableName(odsShellOdsTableName);
                        srcToBigDataEntity.setOdsTableComment(odsTableNameAndCommentMap.get(odsShellOdsTableName));
                        break;
                    }
                }
                srcToBigDataList.add(srcToBigDataEntity);
            }
        }
        log.info("明细信息,开始存入数据库");
        mySQLDao.truncateTable("src_to_bigdata_detail");
        mySQLDao.saveBatchSrcToBigData("src_to_bigdata_detail", srcToBigDataList);
        log.info("src_to_bigdata 整合完成 {} 个", srcToBigDataList.size());
        EasyExcel.write(projectPath + "\\src_to_bigdata结果.xlsx", SrcToBigDataEntity.class).sheet("src_to_bigdata结果").doWrite(srcToBigDataList);
    }
}
