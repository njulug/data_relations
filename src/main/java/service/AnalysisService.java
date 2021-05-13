package service;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.ExcelWriter;
import com.alibaba.excel.write.metadata.WriteSheet;
import dao.AnalysisDao;
import dao.MySQLDao;
import entity.excel.FreezeAndFilter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
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
}
