package controller;

import entity.azkaban.AzkabanEntity;
import entity.src_to_bigdata.HiveFileEntity;
import entity.src_to_bigdata.ShellEntity;
import entity.src_to_bigdata.TableEntity;
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
    private final SybaseService sybaseService;
    private final OracleService oracleService;
    private final SrcToBigDataParseService srcToBigDataParseService;
    private final String projectPath = System.getProperty("user.dir");

    @Autowired
    public ParseController(SrcToBigDataParseService srcToBigDataParseService
            , SrcToRawParseService srcToRawParseService
            , RawToOdsParseService rawToOdsParseService
            , AzkabanService azkabanService
            , AnalysisService analysisService
            , SybaseService sybaseService
            , OracleService oracleService) {
        this.azkabanService = azkabanService;
        this.analysisService = analysisService;
        this.srcToRawParseService = srcToRawParseService;
        this.rawToOdsParseService = rawToOdsParseService;
        this.sybaseService = sybaseService;
        this.oracleService = oracleService;
        this.srcToBigDataParseService = srcToBigDataParseService;
    }

    //   初始化注解方法
    @ModelAttribute
    public void init() {
    }

    @ResponseBody
    @PostMapping("/parseSrcToRaw")
    public void parseSrcToRaw() {
        srcToRawParseService.parse();
    }

    @ResponseBody
    @PostMapping("/parseRawToOds")
    public void parseRawToOds() {
        rawToOdsParseService.parse();
    }

    @ResponseBody
    @PostMapping("/parseSrcToBigData")
    public void parseSrcToBigData() {
//        hive_file解析
        List<HiveFileEntity> hiveFileList = srcToBigDataParseService.hiveFileParse();
//        stg_shell 解析
        List<ShellEntity> stgShellList = srcToBigDataParseService.stgShellParse();
//        ods_shell 解析
        List<ShellEntity> odsShellList = srcToBigDataParseService.odsShellParse();
//        ods_table 解析
        List<TableEntity> odsTableList = srcToBigDataParseService.odsTableParse();
//        stg_table 解析
        List<TableEntity> stgTableList = srcToBigDataParseService.stgTableParse();
//        azkaban 解析
        List<AzkabanEntity> azkabanList = azkabanService.parse();
    }

    @ResponseBody
    @PostMapping("/analysisService")
    public void analysisService() {
        log.info("开始分析");
        List<String> procedureNameList = new ArrayList<>();
//        更新元数据,不用每次都跑
        procedureNameList.add("p_compare_src_to_raw");
        procedureNameList.add("p_update_meta_data");
        procedureNameList.add("p_compare_azkaban_ods_stg_hive_file");
        procedureNameList.add("p_compare_ods_sql_vs_stg_sql");
        procedureNameList.add("p_compare_ods_sql_vs_hive_file");
        procedureNameList.add("p_compare_ods_sql_vs_hive_meta_pro");
        procedureNameList.add("p_compare_ods_sql_vs_source_meta_pro");
        procedureNameList.add("p_compare_stg_sql_shell");
        procedureNameList.add("p_compare_hive_meta_test_vs_hive_meta_pro");
        procedureNameList.add("p_compare_source_meta_test_vs_source_meta_pro");
        procedureNameList.add("p_compare_source_meta_pro_vs_hive_meta_pro");
//        元数据太大,分析完清掉几张大表
//        procedureNameList.add("p_truncate_meta_data");
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

        viewNameList.add("测试环境hive元数据与生产环境hive元数据表名不一致");
        viewNameList.add("测试环境hive元数据与生产环境hive元数据字段数不一致");
        viewNameList.add("测试环境hive元数据与生产环境hive元数据表注释不一致");
        viewNameList.add("测试环境hive元数据与生产环境hive元数据字段名不一致");
        viewNameList.add("测试环境hive元数据与生产环境hive元数据字段类型不一致");
        viewNameList.add("测试环境hive元数据与生产环境hive元数据字段注释不一致");

        viewNameList.add("生产源表元数据和stg_shell源表表名不一致");
        viewNameList.add("生产源表元数据和stg_shell源表表字段数不一致");
        viewNameList.add("生产源表元数据和stg_shell源表表注释不一致");
        viewNameList.add("生产源表元数据和stg_shell源表表字段名不一致");
        viewNameList.add("生产源表元数据和stg_shell源表表字段类型不一致");
        viewNameList.add("生产源表元数据和stg_shell源表表字段注释不一致");
        analysisService.exportResult(viewNameList);
    }

    @ResponseBody
    @PostMapping("/parseSybaseProcedure")
    public void parseSybaseProcedure() {
        List<String> userNameList = new ArrayList<>();
        userNameList.add("dm");
        userNameList.add("dba");
        sybaseService.parseProcedure(userNameList);
    }

    @ResponseBody
    @PostMapping("/parseSybaseView")
    public void parseSybaseView() {
        List<String> userNameList = new ArrayList<>();
        userNameList.add("dm");
        userNameList.add("dba");
        sybaseService.parseView(userNameList);
    }

    @ResponseBody
    @PostMapping("/parseOracleDchis")
    public void parseOracleDchis() {
        oracleService.parseDchis();
    }

    @ResponseBody
    @PostMapping("/parseOracleDcraw")
    public void parseOracleDcraw() {
        oracleService.parseDcraw();
    }

    @ResponseBody
    @PostMapping("/parseOracleDcrun")
    public void parseOracleDcrun() {
        oracleService.parseDcrun();
    }
    @ResponseBody
    @PostMapping("/parseOracleDcser")
    public void parseOracleDcser() {
        oracleService.parseDcser();
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
