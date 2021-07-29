package entity.azkaban;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import lombok.Data;

/**
 * Author:BYDylan
 * Date:2020/8/10
 * Description:存放 azkaban 解析结果
 */
@Data
//@NoArgsConstructor
//@AllArgsConstructor
public class AzkabanEntity {
    @ExcelProperty("文件名")
    private String fileName;
    @ExcelProperty("解析类型")
    private String parseType;
    @ExcelProperty("子文件名")
    private String subFileName;
    @ExcelProperty("flow名称")
    private String flowName;
    @ExcelProperty("group名称")
    private String groupName;
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
