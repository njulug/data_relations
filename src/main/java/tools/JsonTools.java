package tools;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.springframework.stereotype.Repository;

import java.io.IOException;
import java.util.*;

/**
 * Author:BYDylan
 * Date:2020/8/14
 * Description:
 */
@Slf4j
@Repository
public class JsonTools {

    @Test
    public void test() {
        Map<Integer, Object> map = new HashMap<>();
        map.put(1, "hhh");
        map.put(2, "hhh");
        JsonNode jsonNode = object2Json(map);
        ergodicJson(jsonNode, "asc");
//        System.out.println(map);
    }

    /**
     * 将任意对象转成 json 格式
     *
     * @param object 对象
     * @return 返回json 对象
     */
    public JsonNode object2Json(Object object) {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode jsonNode = null;
        try {
            String json = mapper.writeValueAsString(object);
            jsonNode = mapper.readTree(json);
        } catch (IOException e) {
            e.printStackTrace();
        }
        log.debug("解析结果转 json : {}", jsonNode);
        return jsonNode;
    }

    /**
     * 将 json 对象 进行排序解析
     *
     * @param node        json 对象
     * @param ergodicType 升序或降序
     * @return 返回解析结果
     */
    public Map<String, String> ergodicJson(JsonNode node, String ergodicType) {
        HashMap<String, String> resultMap = new HashMap<>();
        //        先拿到 json 顺序
        List<Integer> jsonOrder = new ArrayList<>();
        Iterator<String> fieldNames = node.fieldNames();
        while (fieldNames.hasNext()) {
            jsonOrder.add(Integer.valueOf(fieldNames.next()));
        }

        switch (ergodicType) {
            case "asc":
                for (Integer integer : jsonOrder) {
                    String fieldName = integer.toString();
                    JsonNode jsonSubNode = node.get(fieldName);
                    JsonNode sourceTable = jsonSubNode.get("sourceTable");
                    JsonNode sourceConnect = jsonSubNode.get("sourceConnect");
                    JsonNode incrementFields = jsonSubNode.get("incrementFields");
                    if (incrementFields != null) {
                        resultMap.put("incrementFields", incrementFields.textValue());
                    }
//                    找到源表了直接返回结果
                    //        方案一:其它不排序字段想放进来,放asc里面就可以
                    if (sourceTable != null && sourceTable.textValue() != null && resultMap.get("sourceTable") == null) {
                        resultMap.put("node", fieldName);
                        resultMap.put("sourceTable", sourceTable.textValue());
                        if (sourceConnect != null) {
                            resultMap.put("sourceConnect", sourceConnect.textValue());
                        } else {
                            resultMap.put("sourceConnect", "");
                        }
                        break;
                    }
                }
                break;
            case "desc":
                for (int i = jsonOrder.size() - 1; i >= 0; i--) {
                    String fieldName = jsonOrder.get(i).toString();
                    JsonNode jsonSubNode = node.get(fieldName);
                    JsonNode type = jsonSubNode.get("type");
                    JsonNode sourceTable = jsonSubNode.get("sourceTable");
                    JsonNode targetTable = jsonSubNode.get("targetTable");
                    JsonNode targetConnect = jsonSubNode.get("targetConnect");
                    JsonNode incrementFields = jsonSubNode.get("incrementFields");
                    if (incrementFields != null) {
                        resultMap.put("incrementFields", incrementFields.textValue());
                    }
                    if (type == null || type.textValue() == null || targetTable == null || targetTable.textValue() == null) {
                        continue;
                    }
//                    按照新的业务规则,如果最后遇到SQL组件,那应该是在归档.
                    if ("SQL".equals(type.textValue())) {
                        resultMap.put("node", fieldName);
                        resultMap.put("targetTable", sourceTable == null ? "" : sourceTable.textValue());
                        resultMap.put("targetSaveTable", targetTable == null ? "" : targetTable.textValue());
                        if (targetConnect != null) {
                            resultMap.put("targetConnect", targetConnect.textValue());
                        } else {
                            resultMap.put("targetConnect", "");
                        }
                        break;
                    } else {
//                    找到目标表了直接返回结果
                        resultMap.put("node", fieldName);
                        resultMap.put("targetTable", targetTable.textValue());
                        if (targetConnect != null) {
                            resultMap.put("targetConnect", targetConnect.textValue());
                        } else {
                            resultMap.put("targetConnect", "");
                        }
                        break;
                    }
                }
                break;
        }
//        方案二:其它不排序字段想放进来,单独循环
//        for (Integer integer : jsonOrder) {
//            String fieldName = integer.toString();
//            JsonNode jsonSubNode = node.get(fieldName);
//            JsonNode incrementFields = jsonSubNode.get("incrementFields");
//            if (incrementFields != null) {
//                resultMap.put("incrementFields", incrementFields.textValue());
//                break;
//            }
//        }
        return resultMap;
    }
}
