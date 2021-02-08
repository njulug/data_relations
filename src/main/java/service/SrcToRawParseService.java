package service;

import com.alibaba.excel.EasyExcel;
import com.fasterxml.jackson.databind.JsonNode;
import dao.MySQLDao;
import entity.src_to_raw.SrcToRawEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tools.FileTools;
import tools.JsonTools;
import tools.XmlTools;

import java.io.File;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Author:BYDylan
 * Date:2020/8/17
 * Description: 解析 src_ro_raw
 * excel结果: 解析文件路径, 源系统解析节点, 源系统连接地址, 源系统表名, 数据中心解析节点, 数据中心连接地址, 数据中心表名, 增量字段, 解析结果json
 * 数据库结果: 解析文件路径, 源系统解析节点, 源系统连接地址, 源系统表名, 数据中心解析节点, 数据中心连接地址, 数据中心表名, 增量字段, 解析结果json
 */
@Slf4j
@Service
public class SrcToRawParseService {
    private final String projectPath = System.getProperty("user.dir");
    private final MySQLDao mySQLDao;
    private final XmlTools xmlTools;
    private final FileTools fileTools;
    private final JsonTools jsonTools;

    @Autowired
    public SrcToRawParseService(MySQLDao mySQLDao, XmlTools xmlTools, FileTools fileTools, JsonTools jsonTools) {
        this.mySQLDao = mySQLDao;
        this.xmlTools = xmlTools;
        this.fileTools = fileTools;
        this.jsonTools = jsonTools;
    }

    /**
     * src_to_raw 解析
     *
     * @return 返回所有行
     */
    public void parse() {
        log.info("-------开始解析 src_to_raw");
        List<File> targetFileList = fileTools.matchTargetFiles(projectPath, "src_to_raw", ".ktr");
        log.info("总共获取到文件个数: {}", targetFileList.size());
        List<SrcToRawEntity> fileContext = new ArrayList<>();
        for (File targetFile : targetFileList) {
            log.debug("开始解析文件: {}", targetFile);
            SrcToRawEntity srcToRawEntity = new SrcToRawEntity();
            JsonNode ktrJsonNode = jsonTools.object2Json(xmlTools.parseKtrFile(targetFile));
            Map<String, String> ascMap = jsonTools.ergodicJson(ktrJsonNode, "asc");
            Map<String, String> descMap = jsonTools.ergodicJson(ktrJsonNode, "desc");
            srcToRawEntity.setFileAddr(ktrJsonNode.get("999").textValue().replace(projectPath + "\\", ""));
            srcToRawEntity.setJsonResult(ktrJsonNode.toString());
//            System.out.println("ascMap = " + ascMap);
            srcToRawEntity.setIncrementFields(ascMap.getOrDefault("incrementFields", ""));
            srcToRawEntity.setDataSourceNode(ascMap.getOrDefault("node", "0"));
            srcToRawEntity.setDataSourceTableName(ascMap.getOrDefault("sourceTable", ""));
            srcToRawEntity.setDataSourceConnection(ascMap.getOrDefault("sourceConnect", ""));
            srcToRawEntity.setDataCenterNode(descMap.getOrDefault("node", "0"));
            srcToRawEntity.setDataCenterTableName(descMap.getOrDefault("targetTable", ""));
            srcToRawEntity.setDataCenterConnection(descMap.getOrDefault("targetConnect", ""));
            srcToRawEntity.setCreateTime(LocalDate.now().toString());
            srcToRawEntity.setModifyTime(LocalDate.now().toString());
            fileContext.add(srcToRawEntity);
        }
        log.info("明细信息,开始存入数据库");
        mySQLDao.truncateTable("src_to_raw_detail");
        mySQLDao.saveBatchSrcToRaw("src_to_raw_detail", fileContext);
        log.info("明细信息,开始存入excel");
//        excelTools.writeExcel(SrcToRawEntity.class, project_path + "\\src_to_raw结果.xlsx", fileContext);
        EasyExcel.write(projectPath + "\\src_to_raw结果.xlsx", SrcToRawEntity.class).sheet("src_to_raw结果").doWrite(fileContext);
        log.info("解析完成,src_to_raw 共解析: {} 个, {} 行", targetFileList.size(), fileContext.size());
    }
}
