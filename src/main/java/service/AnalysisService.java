package service;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.ExcelWriter;
import com.alibaba.excel.write.metadata.WriteSheet;
import config.DataBaseConstant;
import dao.AnalysisDao;
import dao.MySQLDao;
import entity.analysis.SqlFileTableEntity;
import entity.excel.FreezeAndFilter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tools.FileTools;
import tools.SqlParserTools;

import java.io.File;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * Author:BYDylan
 * Date:2020/12/31
 * Description:
 */
@Slf4j
@Service
public class AnalysisService {
    private final String projectPath = System.getProperty("user.dir");
    private final SqlParserTools sqlParserTools;
    private final AnalysisDao analysisDao;
    private final FileTools fileTools;
    private final MySQLDao mySQLDao;

    @Autowired
    public AnalysisService(SqlParserTools sqlParserTools, AnalysisDao analysisDao, FileTools fileTools, MySQLDao mySQLDao) {
        this.sqlParserTools = sqlParserTools;
        this.analysisDao = analysisDao;
        this.fileTools = fileTools;
        this.mySQLDao = mySQLDao;
    }

    /**
     * 解析目录下所有sql文件的源表
     */
    public void parseSQLFileSourceTable(String targetWriteDir, DataBaseConstant dataBaseConstant) {
        log.info("开始解析");
        List<SqlFileTableEntity> fileContext = new ArrayList<>();
        for (File sqlFile : new File(targetWriteDir).listFiles()) {
            String sql = fileTools.readToBuffer(sqlFile);
            Map<String, String> sourceTargetTables = sqlParserTools.setJdbc(dataBaseConstant).getSimpleSourceTargetTables(sql, sqlFile.getAbsolutePath());
            log.debug("{} 解析结果: {}", sqlFile.getName(), sourceTargetTables);
            for (String key : sourceTargetTables.keySet()) {
                SqlFileTableEntity sqlFileTableEntity = new SqlFileTableEntity();
                sqlFileTableEntity.setFileName(sqlFile.getName());
                sqlFileTableEntity.setTableType(sourceTargetTables.get(key));
                sqlFileTableEntity.setTableName(key);
                sqlFileTableEntity.setCreateTime(LocalDateTime.now().toString());
                sqlFileTableEntity.setModifyTime(LocalDateTime.now().toString());
                fileContext.add(sqlFileTableEntity);
            }
        }
//        log.info("明细信息,开始存入数据库");
//        mySQLDao.truncateTable("oracle_dchis_detail");
//        mySQLDao.saveBatchDchis("oracle_dchis_detail", fileContext);
        log.info("明细信息,开始存入excel");
//        EasyExcel.write(projectPath + "\\sql解析结果-" + LocalDate.now().toString().replace("-", "") + ".xlsx", SqlFileTableEntity.class).sheet("sql解析结果").doWrite(fileContext);
        log.info("解析完成, 共解析: {} 个", fileContext.size());
    }

    public void execProcedure(List<String> procedureNameList) {
        LocalDateTime startTime;
        for (String procedureName : procedureNameList) {
            startTime = LocalDateTime.now();
            log.info("执行存过: {}", procedureName);
            analysisDao.callProcedure(procedureName);
            long timeComsumer = Duration.between(startTime, LocalDateTime.now()).getSeconds();
            log.info("耗时 : {} 秒, 约 {} 分钟", timeComsumer, timeComsumer / 60);
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
}
