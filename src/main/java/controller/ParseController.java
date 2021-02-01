package controller;

import entity.azkaban.AzkabanEntity;
import entity.raw_to_ods.RawToOdsEntity;
import entity.src_to_bigdata.HiveFileEntity;
import entity.src_to_bigdata.ShellEntity;
import entity.src_to_bigdata.TableEntity;
import entity.src_to_raw.SrcToRawEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import service.*;

import java.util.ArrayList;
import java.util.List;

/**
 * Author:BYDylan
 * Date:2020/12/31
 * Description:
 */
@Slf4j
@Controller
//@RequestMapping(method = RequestMethod.POST, value = "/parser")
public class ParseController {
    private final AzkabanService azkabanService;
    private final AnalysisService analysisService;
    private final SrcToRawParseService srcToRawParseService;
    private final RawToOdsParseService rawToOdsParseService;
    private final ParseProcedureService parseProcedureService;
    private final SrcToBigDataParseService srcToBigDataParseService;
    private final String projectPath = System.getProperty("user.dir");

    @Autowired
    public ParseController(SrcToBigDataParseService srcToBigDataParseService
            , SrcToRawParseService srcToRawParseService
            , RawToOdsParseService rawToOdsParseService
            , AzkabanService azkabanService
            , AnalysisService analysisService
            , ParseProcedureService parseProcedureService) {
        this.azkabanService = azkabanService;
        this.analysisService = analysisService;
        this.srcToRawParseService = srcToRawParseService;
        this.rawToOdsParseService = rawToOdsParseService;
        this.parseProcedureService = parseProcedureService;
        this.srcToBigDataParseService = srcToBigDataParseService;
    }

    //   初始化注解方法
    @ModelAttribute
    public void init() {
    }

    @ResponseBody
    @PostMapping("/srcToRawParse")
    public List<SrcToRawEntity> srcToRawParse() {
        return srcToRawParseService.parse();
    }

    @ResponseBody
    @PostMapping("/rawToOdsParse")
    public List<RawToOdsEntity> rawToOdsParse() {
        return rawToOdsParseService.parse();
    }

    @ResponseBody
    @PostMapping("/srcToBigDataParse")
    public void srcToBigDataParse() {
//        hive_file解析
        List<HiveFileEntity> hiveFileList = srcToBigDataParseService.hiveFileParse();
//        stg_shell 解析
        List<ShellEntity> stgShellList = srcToBigDataParseService.stgShellParse();
//        ods_shell 解析
        List<ShellEntity> odsShellList = srcToBigDataParseService.odsShellParse();
//        azkaban 解析
        List<AzkabanEntity> azkabanList = azkabanService.parse();
//        ods_table 解析
        List<TableEntity> odsTableList = srcToBigDataParseService.odsTableParse();
//        stg_table 解析
        List<TableEntity> stgTableList = srcToBigDataParseService.stgTableParse();
//        整合: stg_shell,ods_shell,ods_table(表注释),azkaban,已在数据库操作,这张表可以忽略
        analysisService.mergeSrcToBigData(odsShellList, stgShellList, odsTableList, azkabanList);
    }

    @ResponseBody
    @PostMapping("/analysisService")
    public void analysisService() {
        log.info("开始分析");
        List<String> procedureNameList = new ArrayList<>();
//        更新元数据,不用每次都跑
        procedureNameList.add("p_update_meta_data");
        procedureNameList.add("p_compare_azkaban_ods_stg_hive_file");
        procedureNameList.add("p_compare_ods_stg_sql");
        procedureNameList.add("p_compare_stg_sql_shell");
        procedureNameList.add("p_compare_ods_hive_file");
        procedureNameList.add("p_compare_ods_hive_meta");
        procedureNameList.add("p_compare_test_hive_meta");
        procedureNameList.add("p_compare_source_hive_meta");
        procedureNameList.add("p_compare_ods_source_meta");
        analysisService.execProcedure(procedureNameList);
        log.info("分析完成");
    }

    @ResponseBody
    @PostMapping("/exportResult")
    public void exportResult() {
        List<String> viewNameList = new ArrayList<>();
        viewNameList.add("提供的调度文件列表");
        viewNameList.add("提供的系统简称");
        viewNameList.add("源数据中所有的系统简称");
        viewNameList.add("特例表");
        viewNameList.add("数据库梳理过程");
        viewNameList.add("没有调度的ODS表");

        viewNameList.add("重复调用之stg_shell");
        viewNameList.add("重复调用之ods_shell");
        viewNameList.add("重复调用之hive_file");
        viewNameList.add("重复调用之azkaban");

        viewNameList.add("ods_sql与源数据表名不一致");
        viewNameList.add("ods_sql与源数据表注释不一致");
        viewNameList.add("ods_sql与源数据字段数不一致");
        viewNameList.add("ods_sql与源数据字段名不一致");
        viewNameList.add("ods_sql与源数据字段类型不一致");
        viewNameList.add("ods_sql与源数据字段注释不一致");

        viewNameList.add("ods_sql与hive元数据表名不一致");
        viewNameList.add("ods_sql与hive元数据表注释不一致");
        viewNameList.add("ods_sql与hive元数据字段数不一致");
        viewNameList.add("ods_sql与hive元数据字段名不一致");
        viewNameList.add("ods_sql与hive元数据字段类型不一致");
        viewNameList.add("ods_sql与hive元数据字段注释不一致");

        viewNameList.add("ods_sql与stg_sql表名不一致");
        viewNameList.add("ods_sql与stg_sql表注释不一致");
        viewNameList.add("ods_sql与stg_sql字段数不一致");
        viewNameList.add("ods_sql与stg_sql字段名不一致");
        viewNameList.add("ods_sql与stg_sql字段类型不一致");
        viewNameList.add("ods_sql与stg_sql字段注释不一致");

        viewNameList.add("ods_sql与hive_file表名不一致");
        viewNameList.add("ods_sql与hive_file字段名不一致");

        viewNameList.add("stg_sql与stg_shell表名不一致");
        viewNameList.add("stg_sql与stg_shell字段数不一致");
        viewNameList.add("stg_sql与stg_shell字段名不一致");

        viewNameList.add("测试环境与生产环境表名不一致");
        viewNameList.add("测试环境与生产环境字段数不一致");
        viewNameList.add("测试环境与生产环境表注释不一致");
        viewNameList.add("测试环境与生产环境字段名不一致");
        viewNameList.add("测试环境与生产环境字段类型不一致");
        viewNameList.add("测试环境与生产环境字段注释不一致");

        viewNameList.add("生产环境与源表元数据表名不一致");
        viewNameList.add("生产环境与源表元数据表字段数不一致");
        viewNameList.add("生产环境与源表元数据表注释不一致");
        viewNameList.add("生产环境与源表元数据表字段名不一致");
        viewNameList.add("生产环境与源表元数据表字段类型不一致");
        viewNameList.add("生产环境与源表元数据表字段注释不一致");
        analysisService.exportResult(viewNameList);
    }

    @ResponseBody
    @PostMapping("/parseSybaseProcedure")
    public void parseSybaseProcedure() {
        List<String> userNameList = new ArrayList<>();
//        userNameList.add("dm");
        userNameList.add("dba");
        parseProcedureService.parseProcedure(userNameList);
    }

    @ResponseBody
    @PostMapping("/odsShellParse")
    public List<ShellEntity> odsShellParse() {
        return srcToBigDataParseService.odsShellParse();
    }

    @ResponseBody
    @PostMapping("/stgShellParse")
    public List<ShellEntity> stgShellParse() {
        return srcToBigDataParseService.stgShellParse();
    }

    @ResponseBody
    @PostMapping("/azkabanParse")
    public List<AzkabanEntity> azkabanParse() {
        return azkabanService.parse();
    }

    @ResponseBody
    @PostMapping("/odsTableParse")
    public List<TableEntity> odsTableParse() {
        return srcToBigDataParseService.odsTableParse();
    }

    @ResponseBody
    @PostMapping("/stgTableParse")
    public List<TableEntity> stgTableParse() {
        return srcToBigDataParseService.stgTableParse();
    }

    @ResponseBody
    @PostMapping("/hiveFileParse")
    public List<HiveFileEntity> hiveFileParse() {
        return srcToBigDataParseService.hiveFileParse();
    }
}
