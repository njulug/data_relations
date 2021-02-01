package entity.src_to_bigdata;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Author:BYDylan
 * Date:2020/8/10
 * Description:存放 ods_shell 解析结果
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OdsTotalEntity {
    @ExcelProperty("解析文件路径")
    private String fileAddr;
    @ExcelProperty("解析文件名")
    private String fileName;
    @ExcelProperty("stg表名")
    private String stgTableName;
    @ExcelProperty("ods表名")
    private String odsTableName;
    @ExcelProperty("ods表中文名")
    private String odsTableComment;
    @ExcelProperty("job名称")
    private String jobName;
    @ExcelProperty("stg_shell-s参数")
    private String sName;
    @ExcelProperty("stg_shell-e参数")
    private String eName;
    @ExcelProperty("stg_shell-o参数")
    private String oName;
    @ExcelProperty("ods_shell-g参数")
    private String gName;
    @ExcelProperty("ods_shell-k参数")
    private String kName;
    @ExcelProperty("命令")
    private String command;
    @ExcelIgnore
    String createTime;
    @ExcelIgnore
    String modifyTime;
}
