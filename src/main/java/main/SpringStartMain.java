package main;

import controller.ParseController;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationContext;
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
    private static final ParseController parseController;

    static {
        String xmlPath = "applicationContext.xml";
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext(xmlPath);
        parseController = applicationContext.getBean("parseController", ParseController.class);
    }

    /**
     * @param args 参数
     *             src_to_raw 解析
     *             List<SrcToRawEntity> srcToRawList = parseController.srcToRawParse()
     *             raw_to_ods 解析
     *             List<RawToOdsEntity> rawToOdsList = parseController.rawToOdsParse();
     *             src_to_big_data 解析
     *             parseController.srcToBigDataParse();
     *             分析业务
     *             parseController.analysisService();
     *             <p>
     *             stg_table 解析
     *             List<TableEntity> stgTableList = parseController.stgTableParse();
     *             stg_shell 解析
     *             List<ShellEntity> stgShellList = parseController.stgShellParse();
     *             ods_shell 解析
     *             List<ShellEntity> odsShellList = parseController.odsShellParse();
     *             azkaban 解析
     *             List<AzkabanEntity> azkabanList = parseController.azkabanParse();
     *             ods_table 解析
     *             List<TableEntity> odsTableList = parseController.odsTableParse();
     */
    public static void main(String[] args) {
        LocalDateTime startTime = LocalDateTime.now();
//        List<SrcToRawEntity> srcToRawList = parseController.srcToRawParse();
//        List<RawToOdsEntity> rawToOdsList = parseController.rawToOdsParse();
        parseController.parseSybaseProcedure();
//        parseController.srcToBigDataParse();
//        parseController.analysisService();
//        parseController.exportResult();

//        List<ShellEntity> stgShellList = parseController.stgShellParse();
//        List<ShellEntity> odsShellList = parseController.odsShellParse();
//        List<TableEntity> stgTableList = parseController.stgTableParse();
//        List<TableEntity> odsTableList = parseController.odsTableParse();
//        List<AzkabanEntity> azkabanList = parseController.azkabanParse();
//        List<HiveFileEntity> hiveFileList = parseController.hiveFileParse();

        log.info("总耗时 : {} 秒", Duration.between(startTime, LocalDateTime.now()).getSeconds());
    }

}
