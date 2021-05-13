package main;

import controller.ParseController;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.time.Duration;
import java.time.LocalDateTime;

/**
 * Author:BYDylan
 * Date:2020/12/31
 * Description:
 */
@Slf4j
public class SpringStartMain {

    /**
     * 工作目录: C:\Workspace\ideaProject\data_relations
     * 说明: sybase是连接数据库获取,会顺便存到工作目录 \SYBASE 下面.
     * src_to_raw,raw_to_ods,src_to_bigdata都有文件在工作目录下,如有更新,按格式替换在里面即可
     * 下面是对应的解析过程,按需执行,或者全部执行,全程大概11分钟
     *
     * @param args src_to_raw 解析
     *             parseController.parseSrcToRaw();
     *             raw_to_ods 解析
     *             parseController.parseRawToOds();
     *             sybase存储过程 解析
     *             parseController.parseSybaseProcedure();
     *             sybase视图 解析
     *             parseController.parseSybaseView();
     *             src_to_bigdata 解析,里面分为5个细项,具体点进这个方法看.
     *             parseController.parseSrcToBigData();
     *             数据库分析,执行存过
     *             parseController.analysisService();
     *             导出excel,模板在当前目录下,大数据平台梳理结果-模板.xlsx
     *             parseController.exportResult();
     */
    public static void main(String[] args) {
        LocalDateTime startTime = LocalDateTime.now();
        String xmlPath = "applicationContext.xml";
        ClassPathXmlApplicationContext applicationContext = new ClassPathXmlApplicationContext(xmlPath);
        ParseController parseController = applicationContext.getBean("parseController", ParseController.class);

//        if (args == null || args.length == 0) {
//            log.error("请提供参数,目前可用参数列表: oracle");
//            System.exit(-1);
//        } else if ("oracle".equalsIgnoreCase(args[0])) {
//            parseController.parseOracleDchis();
//        } else {
//            log.error("参数错误: {}, 目前可用参数列表: oracle", args[0]);
//            System.exit(-1);
//        }

//        parseController.parseOracleDchis();
//        parseController.parseOracleDcraw();
//        parseController.parseOracleDcrun();
//        parseController.parseOracleDcser();
//        parseController.parseSybaseProcedure();
//        parseController.parseSybaseView();
//        parseController.parseSrcToRaw();
//        parseController.parseRawToOds();
//        parseController.parseSrcToBigData();
        parseController.analysisService();
        parseController.exportResult();

//        List<ShellEntity> stgShellList = parseController.stgShellParse();
//        List<ShellEntity> odsShellList = parseController.odsShellParse();
//        List<TableEntity> stgTableList = parseController.stgTableParse();
//        List<TableEntity> odsTableList = parseController.odsTableParse();
//        List<AzkabanEntity> azkabanList = parseController.azkabanParse();
//        List<HiveFileEntity> hiveFileList = parseController.hiveFileParse();
        long timeComsumer = Duration.between(startTime, LocalDateTime.now()).getSeconds();
        log.info("总耗时 : {} 秒, 约 {} 分钟", timeComsumer, timeComsumer / 60);
        applicationContext.close();
    }

}
