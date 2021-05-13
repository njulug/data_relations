package entity.oracle;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Author:BYDylan
 * Date:2021/2/22
 * Description:
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Dchis implements Cloneable {
    @ExcelProperty("文件路径")
    private String fileAddr;
    @ExcelProperty("文件名")
    private String fileName;
    @ExcelProperty("sql创建名")
    private String createName;
    @ExcelProperty("表类型")
    private String tableType;
    @ExcelProperty("表名")
    private String tableName;
    @ExcelIgnore
    String createTime;
    @ExcelIgnore
    String modifyTime;

    @Override
    public Dchis clone() throws CloneNotSupportedException {
        return (Dchis) super.clone();
    }
}
