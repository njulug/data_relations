package entity.src_to_bigdata;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Author:BYDylan
 * Date:2020/8/10
 * Description:存放 stg_shell 解析结果
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ShellEntity {
    @ExcelProperty("解析文件路径")
    private String fileAddr;
    @ExcelProperty("解析文件名")
    private String fileName;
    @ExcelProperty("源系统表名")
    private String sourceTableName;
    @ExcelProperty("stg表名")
    private String stgTableName;
    @ExcelProperty("增量字段")
    private String filterKey;
    @ExcelProperty("系统检查")
    private String xtjc;
    @ExcelProperty("jdbc名")
    private String jdbcName;
    @ExcelProperty("原始所有字段个数")
    private int allColumnsCount;
    @ExcelProperty("解析后所有字段名")
    private String parseAllColumns;
    @ExcelProperty("原始所有字段名")
    private String allColumns;
    @ExcelProperty("ods表名")
    private String odsTableName;
    @ExcelIgnore
    String createTime;
    @ExcelIgnore
    String modifyTime;
}
