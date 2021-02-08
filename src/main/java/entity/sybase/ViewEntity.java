package entity.sybase;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Author:BYDylan
 * Date:2021/1/29
 * Description:
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ViewEntity {
    @ExcelProperty("文件路径")
    private String fileAddr;
    @ExcelProperty("文件名")
    private String fileName;
    @ExcelProperty("用户名")
    private String userName;
    @ExcelProperty("视图名")
    private String viewName;
    @ExcelProperty("表类型")
    private String tableType;
    @ExcelProperty("表名")
    private String tableName;
    @ExcelIgnore
    String createTime;
    @ExcelIgnore
    String modifyTime;
}
