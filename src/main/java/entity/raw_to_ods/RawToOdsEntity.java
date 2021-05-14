package entity.raw_to_ods;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.alibaba.excel.annotation.ExcelProperty;
import lombok.Data;

/**
 * Author:BYDylan
 * Date:2020/8/10
 * Description:存放 RAW_TO_ODS 解析结果
 */
@Data
public class RawToOdsEntity {
    @ExcelProperty("解析文件路径")
    private String fileAddr;
    @ExcelProperty("数据中心解析节点")
    private String dataCenterNode;
    @ExcelProperty("数据中心连接地址")
    private String dataCenterConnection;
    @ExcelProperty("数据中心表名")
    private String dataCenterTableName;
    @ExcelProperty("数据仓库解析节点")
    private String dataWareHouseNode;
    @ExcelProperty("数据仓库连接地址")
    private String dataWareHouseConnection;
    @ExcelProperty("数据仓库表名")
    private String dataWareHouseTableName;
    @ExcelProperty("数据仓库归档表名")
    private String dataWareHouseSaveTableName;
    @ExcelProperty("http解析工程名")
    private String httpUrlProject;
    @ExcelProperty("http解析文件名")
    private String httpUrlFileName;
    @ExcelProperty("http地址")
    private String httpUrl;
    @ExcelProperty("解析结果json")
    private String jsonResult;
    @ExcelIgnore
    String createTime;
    @ExcelIgnore
    String modifyTime;
}
