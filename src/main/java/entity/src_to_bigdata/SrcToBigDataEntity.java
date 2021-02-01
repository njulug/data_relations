package entity.src_to_bigdata;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Author:BYDylan
 * Date:2020/8/10
 * Description:整合 stg_shell 和 ods_shell 解析结果
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SrcToBigDataEntity {
    @ExcelProperty("stg文件名")
    private String stgFileName;
    @ExcelProperty("stg文件路径")
    private String stgFilePath;
    @ExcelProperty("ods文件路径")
    private String odsFilePath;
    @ExcelProperty("源系统表名")
    private String sourceTableName;
    @ExcelProperty("增量字段")
    private String filterKey;
    @ExcelProperty("系统简称")
    private String xtjc;
    @ExcelProperty("jdbc名")
    private String jdbcName;
    @ExcelProperty("stg表名")
    private String stgTableName;
    @ExcelProperty("ods表名")
    private String odsTableName;
    @ExcelProperty("ods表中文名")
    private String odsTableComment;
    @ExcelProperty("job名称")
    private String jobName;
    @ExcelProperty("stg_shell-s参数")
    private String stgShellSName;
    @ExcelProperty("stg_shell-e参数")
    private String stgShellEName;
    @ExcelProperty("stg_shell-o参数")
    private String stgShellOName;
    @ExcelProperty("ods_shell-g参数")
    private String odsShellGName;
    @ExcelProperty("ods_shell-k参数")
    private String odsShellKName;
    @ExcelProperty("hive_file-C参数")
    private String hiveFileCName;
    @ExcelProperty("命令")
    private String command;
    @ExcelIgnore
    String createTime;
    @ExcelIgnore
    String modifyTime;
}
