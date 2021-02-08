package tools;

import com.fasterxml.jackson.databind.JsonNode;
import config.DataBaseConstant;
import entity.raw_to_ods.RawToOdsEntity;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.set.ListOrderedSet;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.io.File;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * Author:BYDylan
 * Date:2020/8/10
 * Description: xml 解析 工具类
 */
@Slf4j
@Repository
public class XmlTools {
    private final JsonTools jsonTools;
    private static Element root;

    @Autowired
    public XmlTools(JsonTools jsonTools) {
        this.jsonTools = jsonTools;
    }

    @Test
    public void test() {
//        kjb 解析
//        String absolutePath = "C:\\Workspace\\ideaProject\\data_relations\\RAW_TO_ODS\\SJCK\\CFS2\\ODS_CFS2_SIM_STOCKBACKBUYTRADE.kjb";
//        List<String> fileList = new ArrayList<>();
//        JsonNode parseJsonNode = jsonTools.object2Json(parseKjbFile(new File(absolutePath)));
//        System.out.println("parseJsonNode = " + parseJsonNode);
//        Map<String, String> ascMap = jsonTools.ergodicJson(parseJsonNode, "asc");
//        System.out.println("ascMap = " + ascMap);
//        Map<String, String> descMap = jsonTools.ergodicJson(parseJsonNode, "desc");
//        System.out.println("descMap = " + descMap);
//                ktr 解析
        String absolutePath = "C:\\Workspace\\ideaProject\\data_relations\\SRC_TO_RAW\\CFS\\raw_cfs_run_cfs_bd_accsubj.ktr";
        JsonNode parseJsonNode = jsonTools.object2Json(parseKtrFile(new File(absolutePath)));
        Map<String, String> ascMap = jsonTools.ergodicJson(parseJsonNode, "asc");
        Map<String, String> descMap = jsonTools.ergodicJson(parseJsonNode, "desc");
        System.out.println("parseJsonNode = " + parseJsonNode);
        System.out.println("ascMap = " + ascMap);
        System.out.println("descMap = " + descMap);
    }

    /**
     * 解析 kjb 文件
     *
     * @param targetFile 文件
     * @return 返回 组件序号,和文件内容
     */
    public Map<Integer, Object> parseKjbFile(File targetFile) {
//        获取 root 目录
        getXmlRoot(targetFile);
        RawToOdsEntity rawToOdsEntity = new RawToOdsEntity();
//        1.遍历kjb文件的hops标签,解析组件流向顺序,取出来后去个重,因为会有循环的情况
        ListOrderedSet<String> kjbOrderSet = new ListOrderedSet<>();
        List<String> kjbOrder = new ArrayList<>();
        kjbOrder = parseComponentOrder(root.element("hops").elements("hop"), kjbOrder);
        kjbOrderSet.addAll(kjbOrder);
        log.debug("kjb 组件顺序解析结果 : \n{}", kjbOrder);
        log.debug("kjb 组件顺序解析结果去重 : \n{}", kjbOrderSet);
        List list = kjbOrderSet.asList();
        Map<Integer, Object> parseResult = new HashMap<>();
        List<Element> entryList = root.element("entries").elements("entry");
        for (int i = 0; i < list.size(); i++) {
            String componentName = list.get(i).toString();
            for (Element entry : entryList) {
                String entryName = entry.elementText("name");
                HashMap<String, String> kjbComponentMap = new HashMap<>();
                String entryType = entry.elementText("type");
                kjbComponentMap.put("type", entryType);
                kjbComponentMap.put("name", entryName);
//                如果找到这个标签了则进一步解析组件的内容
                if (entryName.equals(componentName)) {
                    switch (entryType) {
                        case "HTTP":
                            String httpUrl = convertFormat(entry.elementText("url"));
                            String[] strings = httpUrl.split("/");
                            String httpUrlFileName = strings[strings.length - 1];
                            String httpUrlProject = strings[strings.length - 3];
                            kjbComponentMap.put("httpUrl", httpUrl);
                            kjbComponentMap.put("httpUrlFileName", httpUrlFileName);
                            kjbComponentMap.put("httpUrlProject", httpUrlProject);
                            break;
                        case "TRANS":
//                            目录要把xml编码转义一下,然后拼接成全路径去解析ktr文件
                            String directory = convertFormat(entry.elementText("directory"));
                            Matcher ktrMatcher = Pattern.compile("(RAW_TO_ODS).*").matcher(directory + File.separator + entry.elementText("transname") + ".ktr");
                            Matcher currentMatcher = Pattern.compile(".*(RAW_TO_ODS)").matcher(targetFile.getAbsolutePath());
                            if (currentMatcher.find()) {
                                String currentPath = currentMatcher.group().replace("RAW_TO_ODS", "");
                                if (ktrMatcher.find()) {
                                    String ktrPath = currentPath + ktrMatcher.group();
                                    HashMap<String, String> ktrResult = new HashMap<>();
                                    JsonNode ktrJsonNode = jsonTools.object2Json(parseKtrFile(new File(ktrPath)));
                                    Map<String, String> ascMap = jsonTools.ergodicJson(ktrJsonNode, "asc");
                                    Map<String, String> descMap = jsonTools.ergodicJson(ktrJsonNode, "desc");
                                    ktrResult.put("sourceTableNode", ascMap.getOrDefault("node", ""));
                                    ktrResult.put("sourceTable", ascMap.getOrDefault("sourceTable", ""));
                                    ktrResult.put("sourceConnect", ascMap.getOrDefault("sourceConnect", ""));
                                    ktrResult.put("targetTableNode", descMap.getOrDefault("node", ""));
                                    ktrResult.put("targetTable", descMap.getOrDefault("targetTable", ""));
                                    ktrResult.put("targetConnect", descMap.getOrDefault("targetConnect", ""));
                                    ktrResult.put("ktrPath", ktrPath);
                                    kjbComponentMap.putAll(ktrResult);
                                }
                            }
                            break;
                        case "SQL":
                            convertFormat(entry.elementText("sql"));
                            Map<String, String> sourceTargetTables = SqlParserTools.setJdbc(DataBaseConstant.ORACLE).getSourceTargetTables(convertFormat(entry.elementText("sql")), targetFile.getAbsolutePath());
//                            这里解析出来是 (表名,targetTbale / sourceTbale) 反转一下
                            sourceTargetTables.forEach((key, value) -> kjbComponentMap.put(value, key.toLowerCase().trim()));
                            kjbComponentMap.put("sourceConnect", getConnect(entry.elementText("connection")));
                            kjbComponentMap.put("targetConnect", getConnect(entry.elementText("connection")));
                            break;
                        case "WRITE_TO_FILE":
                        case "CREATE_FILE":
                        case "SHELL":
                            kjbComponentMap.put("targetTable", entry.elementText("filename").toLowerCase().trim());
                            break;
                    }
                    parseResult.put(i, kjbComponentMap);
                    parseResult.put(999, targetFile.getAbsolutePath());
                    break;
                }
            }
        }
        return parseResult;
    }

    /**
     * 获取 xml 对象
     *
     * @param targetFile 目标文件
     */
    private void getXmlRoot(File targetFile) {
        SAXReader reader = new SAXReader();
        try {
//            解析字符串
//            Document doc = DocumentHelper.parseText("");
            Document doc = reader.read(targetFile);
            root = doc.getRootElement();
        } catch (DocumentException e) {
            log.error("报错信息: {}", e.getMessage());
        }
    }

    /**
     * kettle 的组件顺序 是开始对应结尾,这里手动解析出来后
     *
     * @param hoplist    所有 hop
     * @param fromToList 解析出的顺序list
     * @return 返回 fromToList
     */
    private List<String> parseComponentOrder(List<Element> hoplist, List<String> fromToList) {
        if (hoplist.size() == 0 || hoplist == null) {
            return new ArrayList<>();
        }
        for (Element empEle : hoplist) {
            int size = fromToList.size();
            String from = convertFormat(empEle.elementText("from"));
            String to = convertFormat(empEle.elementText("to"));
            log.debug("from : {} , to: {}", from, to);
//                情况一: size为0,直接插入
            if (size == 0) {
                fromToList.add(from);
                fromToList.add(to);
                continue;
            }
//                情况二: from == START 说明是最开始的2个,则 判断一下 to 是否存在,不存在都插入,存在的话只插入 from
            if (from.equals("START")) {
                if (size > 0 && !fromToList.get(0).equals(to)) {
                    fromToList.add(0, to);
                }
                fromToList.add(0, from);
                continue;
//                情况三: to == 成功 说明是最末尾的2个,则 判断一下 集合是否大于 1个元素,并且最后一个元素是否等于from,不等于则都插入,等于的话只插入 to
            } else if (to.equals("成功")) {
                if (size > 0) {
                    if (!fromToList.get(size - 1).equals(from)) {
                        fromToList.add(from);
                    }
                    fromToList.add(to);
                } else {
                    fromToList.add(from);
                    fromToList.add(to);
                }
                continue;
            }

//                情况四:遍历  集合,见缝插针
            boolean isMatch = false;
            for (int i = 0; i < size; i++) {
                String current = fromToList.get(i);
//                    匹配到 from 则添加 to,那么校验 下一个位置
                if (current.equals(from)) {
//                        如果有下一个,并且不等于 to 则在下一个 添加 to
                    if (size >= i + 2) {
                        if (!fromToList.get(i + 1).equals(to)) {
                            fromToList.add(i + 1, to);
                        }
//                            如果没有下一个,直接末尾追加 to
                    } else {
                        fromToList.add(to);
                    }
                    isMatch = true;
                    break;
//                        匹配到 to 则添加 from, 那么校验 上一个位置
                } else if (current.equals(to)) {
                    if (i > 0) {
                        if (!fromToList.get(i - 1).equals(from)) {
                            fromToList.add(i, from);
                        }
                    } else {
                        fromToList.add(0, from);
                    }
                    isMatch = true;
                    break;
                }
            }
//                C:\Workspace\ideaProject\data_relations\SRC_TO_RAW\HQ\raw_hq_real_sh_mktdt000.ktr
            if (!isMatch) {
                if (size > 0) {
                    int index = hoplist.indexOf(empEle);
                    List<Element> newHoplist = new ArrayList<>();
                    for (int i = index + 1; i < hoplist.size(); i++) {
                        newHoplist.add(hoplist.get(i));
                    }
                    newHoplist.add(empEle);
                    parseComponentOrder(newHoplist, fromToList);
                    break;
                }
                fromToList.add(from);
                fromToList.add(to);
            }
        }
        return fromToList;
    }

    /**
     * 解析  ktr 文件
     *
     * @param targetFile 目标文件
     * @return 返回组件序号, 对应解析内容
     */
    public Map<Integer, Object> parseKtrFile(File targetFile) {
        Map<Integer, Object> ktrXmlParseResult = new HashMap<>();
        log.debug("解析ktr文件: {}", targetFile.getAbsolutePath());
        getXmlRoot(targetFile);
        ListOrderedSet<String> ktrOrderSet = new ListOrderedSet<>();
        List<String> ktrOrder = new ArrayList<>();
        List<Element> stepList = new ArrayList<>();
        try {
            List<Element> hops = root.element("order").elements("hop");
            ktrOrder = parseComponentOrder(hops, ktrOrder);
            ktrOrderSet.addAll(ktrOrder);
            log.debug("ktr 组件顺序解析结果 : {}", ktrOrder);
            log.debug("ktr 组件顺序解析结果去重 : {}", ktrOrderSet);
            stepList = root.elements("step");
        } catch (Exception ignored) {
        }
        if (ktrOrder.size() > 0) {
            List<String> list = ktrOrderSet.asList();
            for (int i = 0; i < list.size(); i++) {
                String componentName = list.get(i).toString();
                for (Element step : stepList) {
                    String stepName = Objects.requireNonNull(step.elementText("name"));
                    String stepType = Objects.requireNonNull(step.elementText("type"));
                    Map<Object, Object> ktrComponentMap = new HashMap<>();
                    ktrComponentMap.put("type", stepType);
                    ktrComponentMap.put("name", stepName);
                    if (stepName.equals(componentName)) {
                        String[] parseSql;
                        Map<String, String> sourceTargetTables;
                        Map<String, List<String>> tableNameAndWhereColumns;
                        switchKtrStepType(stepType, step, ktrComponentMap, targetFile.getAbsolutePath());
                        ktrXmlParseResult.put(i, ktrComponentMap);
                        ktrXmlParseResult.put(999, targetFile.getAbsolutePath());
                        break;
                    }
                }
            }
        } else {
            Map<String, List<String>> tableNameAndWhereColumns;
            for (Element step : stepList) {
                String stepName = Objects.requireNonNull(step.elementText("name"));
                String stepType = Objects.requireNonNull(step.elementText("type"));
                Map<Object, Object> ktrComponentMap = new HashMap<>();
                ktrComponentMap.put("type", stepType);
                String[] parseSql;
                switchKtrStepType(stepType, step, ktrComponentMap, targetFile.getAbsolutePath());
                ktrXmlParseResult.put(0, ktrComponentMap);
                ktrXmlParseResult.put(999, targetFile.getAbsolutePath());
                break;
            }
        }
        return ktrXmlParseResult;
    }

    /**
     * ktr 不同的组件解析内容不尽相同,这里按情况解析
     *
     * @param stepType        组件类型
     * @param step            具体内容
     * @param ktrComponentMap 返回结果
     * @param absolutePath    文件路径
     */
    private void switchKtrStepType(String stepType, Element step, Map<Object, Object> ktrComponentMap, String absolutePath) {
        Map<String, String> sourceTargetTables;
        Map<String, List<String>> tableNameAndWhereColumns;
        switch (stepType) {
            case "JsonInput":
                ktrComponentMap.put("sourceTable", "文件输入: " + step.element("file").elementText("name"));
                break;
            case "ExcelInput":
                ktrComponentMap.put("sourceTable", "文件输入: " + step.element("file").elementText("name"));
                break;
            case "CsvInput":
                ktrComponentMap.put("sourceTable", "文件输入: " + step.elementText("filename"));
                break;
            case "XBaseInput":
                ktrComponentMap.put("sourceTable", "文件输入: " + step.elementText("file_dbf"));
                break;
            case "TextFileInput":
                ktrComponentMap.put("sourceTable", "文件输入: " + step.element("file").elementText("name"));
                break;
            case "TableInput":
                String sql = convertFormat(step.elementText("sql")).replace("..",".");
                sourceTargetTables = SqlParserTools.setJdbc(DataBaseConstant.ORACLE).getSourceTargetTables(sql, absolutePath);
//                            这里解析出来是 (表名,targetTbale / sourceTbale) 反转一下
                sourceTargetTables.forEach((key, value) -> {
                    if (value.equalsIgnoreCase("sourceTable")) {
                        ktrComponentMap.put(value, key.toLowerCase().trim());
                    }
                });
                tableNameAndWhereColumns = SqlParserTools.setJdbc(DataBaseConstant.ORACLE).getTableNameAndWhereColumns(convertFormat(step.elementText("sql")).replaceAll("[\\$|{}]", ""), absolutePath);
                if (tableNameAndWhereColumns != null && tableNameAndWhereColumns.size() > 0) {
                    tableNameAndWhereColumns.forEach((key, value) -> {
//                        ${begin_date} 这样的因为没加引号无法解析,所以去成了 begin_date ,解析出来是 [unknown,begin_date] 但这是参数要排除掉
                        String value1 = value.stream()
                                .filter(entity -> !entity.equalsIgnoreCase("begin_date") && !entity.equalsIgnoreCase("end_date"))
                                .collect(Collectors.toList())
                                .toString()
                                .replaceAll("[\\[|\\]]", "");
                        if (value1 != null && !value1.trim().equalsIgnoreCase("")) {
                            if (!ktrComponentMap.containsKey("incrementFields")) {
                                ktrComponentMap.put("incrementFields", value1);
                            } else {
                                Object incrementFields = ktrComponentMap.get("incrementFields");
                                ktrComponentMap.put("incrementFields"
                                        , incrementFields.toString().trim().equalsIgnoreCase("") || incrementFields == null ? value1 : incrementFields.toString() + "," + value1);
                            }
                        }
                    });
                }
                ktrComponentMap.put("sourceConnect", getConnect(step.elementText("connection")));
                break;
            case "GetVariable":
                ktrComponentMap.put("sourceTable", "获取变量:");
                break;
            case "TableOutput":
                ktrComponentMap.put("targetTable", (step.elementText("schema") + "." + step.elementText("table")).toLowerCase().trim());
                ktrComponentMap.put("targetConnect", getConnect(step.elementText("connection")));
                break;
            case "InsertUpdate":
                Element lookup = step.element("lookup");
                ktrComponentMap.put("targetTable", (lookup.elementText("schema") + "." + lookup.elementText("table")).toLowerCase().trim());
                ktrComponentMap.put("targetConnect", getConnect(step.elementText("connection")));
                break;
            case "DBProc":
                ktrComponentMap.put("targetTable", "调用存过: " + step.elementText("procedure"));
                ktrComponentMap.put("targetConnect", getConnect(step.elementText("connection")));
                break;
            case "ExecSQL":
                convertFormat(step.elementText("sql"));
                sourceTargetTables = SqlParserTools.setJdbc(DataBaseConstant.ORACLE).getSourceTargetTables(convertFormat(step.elementText("sql")), absolutePath);
//                            这里解析出来是 (表名,targetTbale / sourceTbale) 反转一下
                sourceTargetTables.forEach((key, value) -> ktrComponentMap.put(value, key.toLowerCase().trim()));

                ktrComponentMap.put("sourceConnect", getConnect(step.elementText("connection")));
                ktrComponentMap.put("targetConnect", getConnect(step.elementText("connection")));
                tableNameAndWhereColumns = SqlParserTools.setJdbc(DataBaseConstant.ORACLE).getTableNameAndWhereColumns(convertFormat(step.elementText("sql")).replaceAll("[\\$|{}]", ""), absolutePath);
                if (tableNameAndWhereColumns != null && tableNameAndWhereColumns.size() > 0) {
                    tableNameAndWhereColumns.forEach((key, value) -> {
//                        ${begin_date} 这样的因为没加引号无法解析,所以去成了 begin_date ,解析出来是 [unknown,begin_date] 但这是参数要排除掉
                        String value1 = value.stream()
                                .filter(entity -> !entity.equalsIgnoreCase("begin_date") && !entity.equalsIgnoreCase("end_date"))
                                .collect(Collectors.toList())
                                .toString()
                                .replaceAll("[\\[|\\]]", "");
                        if (value1 != null && !value1.trim().equalsIgnoreCase("")) {
                            if (!ktrComponentMap.containsKey("incrementFields")) {
                                ktrComponentMap.put("incrementFields", value1);
                            } else {
                                Object incrementFields = ktrComponentMap.get("incrementFields");
                                ktrComponentMap.put("incrementFields"
                                        , incrementFields.toString().trim().equalsIgnoreCase("") || incrementFields == null ? value1 : incrementFields.toString() + "," + value1);
                            }
                        }
                    });
                }
                break;
            case "TextFileOutput":
            case "ExcelOutput":
                ktrComponentMap.put("targetTable", "文件输出: " + convertFormat(step.element("file").elementText("name")));
                break;
            case "OraBulkLoader":
                ktrComponentMap.put("targetTable", (step.elementText("schema") + "." + step.elementText("table")).toLowerCase().trim());
                ktrComponentMap.put("targetConnect", getConnect(step.elementText("connection")));
                break;
            case "RowsToResult":
                ktrComponentMap.put("targetTable", "RowsToResult: " + convertFormat(step.elementText("name")));
                break;
        }
    }

    /**
     * 解析 connect ,因为 connect 统一存在最顶层的,这里逐一便利
     *
     * @param connection 原始的 connect 内容
     * @return 返回解析后的内容
     */
    private String getConnect(String connection) {
        StringBuilder addr = new StringBuilder();
        List<Element> elementlist = root.elements("connection");
        if (elementlist == null) {
            log.error("连接信息获取失败: {}", elementlist);
            return "";
        }
        for (Element empEle : elementlist) {
            String name = empEle.elementText("name");
            if (name.equals(connection)) {
                addr.append(empEle.elementText("service"))
                        .append(":")
                        .append(empEle.elementText("port"))
                        .append("/")
                        .append(empEle.elementText("database"))
                        .append(":")
                        .append(empEle.elementText("username"));
                break;
            }
        }
        return addr.toString();
    }

    /**
     * kettle 文件有特殊编码,进行解码操作
     *
     * @param context 编码内容
     * @return 返回 解码后内容
     */
    private String convertFormat(String context) {
        Pattern compile = Pattern.compile("&#.*?;");
        Matcher matcher = compile.matcher(context);
        while (matcher.find()) {
            String group = matcher.group();
            String hexcode = "0" + group.replaceAll("(&#|;)", "");
            context = context.replace(group, (char) Integer.decode(hexcode).intValue() + "");
        }
        return context;
    }
}
