package entity.src_to_bigdata;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import lombok.Data;

/**
 * Author:BYDylan
 * Date:2021/1/5
 * Description:
 */
@Data
public class HiveFileEntity {
    @ExcelProperty("解析文件路径")
    private String fileAddr;
    @ExcelProperty("解析文件名")
    private String fileName;
    @ExcelProperty("ods表名")
    private String odsTableName;
    @ExcelProperty("导出列个数")
    private int allColumnsCount;
    @ExcelProperty("导出列")
    private String allColumns;
    @ExcelProperty("主键字段")
    private String partitionKey;
    @ExcelProperty("where条件")
    private String whereCondition;
    @ExcelIgnore
    String createTime;
    @ExcelIgnore
    String modifyTime;
}
