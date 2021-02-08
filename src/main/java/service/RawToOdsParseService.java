package service;

import com.alibaba.excel.EasyExcel;
import com.fasterxml.jackson.databind.JsonNode;
import dao.MySQLDao;
import entity.raw_to_ods.RawToOdsEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tools.FileTools;
import tools.JsonTools;
import tools.XmlTools;

import java.io.File;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * Author:BYDylan
 * Date:2020/8/17
 * Description: 解析 raw_to_ods
 * excel结果: 解析文件路径, 数据中心解析节点, 数据中心连接地址, 数据中心表名, 数据仓库解析节点, 数据仓库连接地址, 数据仓库表名, 数据仓库归档表名, http解析工程名, http解析文件名, http地址, 解析结果json, 创建时间, 修改时间
 * 数据库结果: 解析文件路径, 数据中心解析节点, 数据中心连接地址, 数据中心表名, 数据仓库解析节点, 数据仓库连接地址, 数据仓库表名, 数据仓库归档表名, http解析工程名, http解析文件名, http地址, 解析结果json, 创建时间, 修改时间
 */
@Slf4j
@Service
public class RawToOdsParseService {
    private final String projectPath = System.getProperty("user.dir");
    private final MySQLDao mySQLDao;
    private final XmlTools xmlTools;
    private final FileTools fileTools;
    private final JsonTools jsonTools;

    @Autowired
    public RawToOdsParseService(MySQLDao mySQLDao, XmlTools xmlTools, FileTools fileTools, JsonTools jsonTools) {
        this.mySQLDao = mySQLDao;
        this.xmlTools = xmlTools;
        this.fileTools = fileTools;
        this.jsonTools = jsonTools;
    }

    /**
     * raw_to_ods 解析
     * @return 返回所有行
     */
    public void parse() {
        List<File> targetFileList = fileTools.matchTargetFiles(projectPath,"raw_to_ods", ".kjb");
        log.info("匹配到目文件个数: {}", targetFileList.size());
        List<RawToOdsEntity> fileContext = new ArrayList<>();
        mySQLDao.truncateTable("raw_to_ods_detail");
        for (File targetFile : targetFileList) {
            log.debug("开始解析文件: {}", targetFile);
            RawToOdsEntity rawToOdsEntity = new RawToOdsEntity();
            JsonNode parseJsonNode = jsonTools.object2Json(xmlTools.parseKjbFile(targetFile));
            for (Iterator<JsonNode> it = parseJsonNode.elements(); it.hasNext(); ) {
                JsonNode jsonNode = it.next();
                if (jsonNode == null || jsonNode.get("type") == null) {
                    continue;
                }
                if ("HTTP".equals(jsonNode.get("type").textValue())) {
                    rawToOdsEntity.setHttpUrl(jsonNode.get("httpUrl").textValue());
                    rawToOdsEntity.setHttpUrlProject(jsonNode.get("httpUrlProject").textValue());
                    rawToOdsEntity.setHttpUrlFileName(jsonNode.get("httpUrlFileName").textValue());
                    break;
                }
            }
            Map<String, String> ascMap = jsonTools.ergodicJson(parseJsonNode, "asc");
            Map<String, String> descMap = jsonTools.ergodicJson(parseJsonNode, "desc");
            rawToOdsEntity.setFileAddr(parseJsonNode.get("999").textValue().replace(projectPath + "\\", ""));
            rawToOdsEntity.setJsonResult(parseJsonNode.toString());
            rawToOdsEntity.setDataCenterNode(ascMap.getOrDefault("node", "0"));
            rawToOdsEntity.setDataCenterTableName(ascMap.getOrDefault("sourceTable", ""));
            rawToOdsEntity.setDataCenterConnection(ascMap.getOrDefault("sourceConnect", ""));
            rawToOdsEntity.setDataWareHouseNode(descMap.getOrDefault("node", "0"));
            rawToOdsEntity.setDataWareHouseTableName(descMap.getOrDefault("targetTable", ""));
            rawToOdsEntity.setDataWareHouseSaveTableName(descMap.getOrDefault("targetSaveTable", ""));
            rawToOdsEntity.setDataWareHouseConnection(descMap.getOrDefault("targetConnect", ""));
            rawToOdsEntity.setCreateTime(LocalDate.now().toString());
            rawToOdsEntity.setModifyTime(LocalDate.now().toString());
            fileContext.add(rawToOdsEntity);
        }
        log.info("明细信息,开始存入数据库");
        mySQLDao.saveBatchRawToOds("raw_to_ods_detail", fileContext);
        log.info("明细信息,开始存入excel");
        EasyExcel.write(projectPath + "\\raw_to_ods结果.xlsx", RawToOdsEntity.class).sheet("raw_to_ods结果").doWrite(fileContext);
        log.info("解析完成, raw_to_ods 共解析: {} 个, {} 行",targetFileList.size(), fileContext.size());
    }
}
