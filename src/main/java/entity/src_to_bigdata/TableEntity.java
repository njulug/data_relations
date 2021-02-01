package entity.src_to_bigdata;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Author:BYDylan
 * Date:2020/12/25
 * Description: hive 元数据实体类
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TableEntity {
    @ExcelProperty("文件路径")
    String fileAddr;
    @ExcelProperty("文件名")
    String fileName;
    @ExcelProperty("表名")
    String tableName;
    @ExcelProperty("表注释")
    private String tableComment;
    @ExcelProperty("字段数")
    private int columnsCount;
    @ExcelProperty("字段名")
    String columnName;
    @ExcelProperty("字段类型")
    String columnType;
    @ExcelProperty("字段注释")
    String columnComment;
    @ExcelProperty("字段顺序号")
    String columnOrder;
    @ExcelIgnore
    String createTime;
    @ExcelIgnore
    String modifyTime;
}
