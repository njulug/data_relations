package entity.src_to_raw;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Author:BYDylan
 * Date:2020/8/10
 * Description:存放 SRC_TO_RAW 解析结果
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SrcToRawEntity {
    @ExcelProperty("解析文件路径")
    private String fileAddr;
    @ExcelProperty("源系统解析节点")
    private String dataSourceNode;
    @ExcelProperty("源系统连接地址")
    private String dataSourceConnection;
    @ExcelProperty("源系统表名")
    private String dataSourceTableName;
    @ExcelProperty("数据中心解析节点")
    private String dataCenterNode;
    @ExcelProperty("数据中心连接地址")
    private String dataCenterConnection;
    @ExcelProperty("数据中心表名")
    private String dataCenterTableName;
    @ExcelProperty("增量字段")
    private String incrementFields;
    @ExcelProperty("解析结果json")
    private String jsonResult;
    @ExcelIgnore
    String createTime;
    @ExcelIgnore
    String modifyTime;
}
