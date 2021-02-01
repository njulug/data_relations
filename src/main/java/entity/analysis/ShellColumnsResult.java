package entity.analysis;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Author:BYDylan
 * Date:2021/1/4
 * Description:
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ShellColumnsResult {
    @ExcelProperty("匹配类型")
    private String matchType;
    @ExcelProperty("stg表名")
    private String stgTableName;
    @ExcelProperty("匹配字段名")
    private String columnName;
    @ExcelProperty("所有列名 ")
    private String allColumns;
    @ExcelIgnore
    String createTime;
    @ExcelIgnore
    String modifyTime;
}
