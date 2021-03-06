package tools;

import com.alibaba.druid.DbType;
import com.alibaba.druid.sql.SQLUtils;
import com.alibaba.druid.sql.ast.SQLExpr;
import com.alibaba.druid.sql.ast.SQLStatement;
import com.alibaba.druid.sql.ast.statement.*;
import com.alibaba.druid.sql.dialect.hive.visitor.HiveSchemaStatVisitor;
import com.alibaba.druid.sql.dialect.mysql.visitor.MySqlSchemaStatVisitor;
import com.alibaba.druid.sql.dialect.oracle.ast.stmt.OracleCreateTableStatement;
import com.alibaba.druid.sql.dialect.oracle.visitor.OracleSchemaStatVisitor;
import com.alibaba.druid.sql.parser.SQLParserUtils;
import com.alibaba.druid.sql.parser.SQLStatementParser;
import com.alibaba.druid.sql.visitor.SchemaStatVisitor;
import com.alibaba.druid.stat.TableStat;
import com.alibaba.druid.util.JdbcConstants;
import config.DataBaseConstant;
import gudusoft.gsqlparser.*;
import gudusoft.gsqlparser.nodes.TTable;
import gudusoft.gsqlparser.nodes.TTableList;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.springframework.stereotype.Repository;

import java.io.File;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Author:BYDylan
 * Date:2020/8/5
 * Description:
 */
@Slf4j
@Repository
public class SqlParserTools {
    private final String projectPath = System.getProperty("user.dir");
    private static SchemaStatVisitor visitor = null;
    private static DbType dbType = null;
    private static final TGSqlParser sqlParser = new TGSqlParser(EDbVendor.dbvsybase);

    private volatile static SqlParserTools sqlParserTools;

    private static SqlParserTools getInstance() {

        if (sqlParserTools == null) {
            synchronized (SqlParserTools.class) {
                if (sqlParserTools == null) {
                    sqlParserTools = new SqlParserTools();
                }
            }
        }
        return sqlParserTools;
    }

    public SqlParserTools setJdbc(DataBaseConstant dataBaseConstant) {
        switch (dataBaseConstant) {
            case HIVE:
                visitor = new HiveSchemaStatVisitor();
                dbType = JdbcConstants.HIVE;
                break;
            case ORACLE:
                visitor = new OracleSchemaStatVisitor();
                dbType = JdbcConstants.ORACLE;
                break;
            case MYSQL:
                visitor = new MySqlSchemaStatVisitor();
                dbType = JdbcConstants.MYSQL;
                break;
            case SYBASE:
                visitor = new OracleSchemaStatVisitor();
                dbType = JdbcConstants.SYBASE;
                break;
        }
        return getInstance();
    }

    @Test
    public void test() {
//        File dchisFile = new File(projectPath + "\\ORACLE\\dchis.sql");
//        FileParseTools fileParseTools = new FileParseTools(new SqlParserTools());
//        String sql = fileParseTools.clearOracleSpecialCharacters(dchisFile);
        String sql = "insert overwrite table ${hivevar:hive_cleandb}.t_mid_clean_his_databankmshare_hv partition(part_init_date)\n" +
                "select arrays[0] as init_date,\n" +
                "arrays[1] as end_date,\n" +
                "arrays[2] as fund_account,\n" +
                "arrays[3] as client_id,\n" +
                "arrays[4] as prodta_no,\n" +
                "arrays[5] as bankm_account,\n" +
                "cast(arrays[6] as decimal(10,0)) as branch_no,\n" +
                "arrays[7] as prod_code,\n" +
                "arrays[8] as money_type,\n" +
                "arrays[9] as buy_date,\n" +
                "cast(arrays[10] as decimal(10,0)) as serial_no,\n" +
                "arrays[11] as net_no,\n" +
                "arrays[12] as allot_no,\n" +
                "cast(arrays[13] as decimal(19,2)) as begin_amount,\n" +
                "cast(arrays[14] as decimal(19,2)) as current_amount,\n" +
                "cast(arrays[15] as decimal(19,2)) as frozen_amount,\n" +
                "arrays[16] as dividend_way,\n" +
                "arrays[17] as charge_type,\n" +
                "cast(arrays[18] as decimal(19,2)) as bankm_market_value,\n" +
                "arrays[19] as position_str,\n" +
                "arrays[20] as trans_account,\n" +
                "arrays[21] as part_init_date\n" +
                " from (\n" +
                "\n" +
                "select split(value,\"!#\") arrays from (\n" +
                "\n" +
                "select explode(value) as value from (\n" +
                "\n" +
                "select a.key,split(hiveudf.FillDataByClosedayUDF(concat_ws(\"!@#\",collect_set(value)),hiveudf.udf_last_close_day(${hivevar:endDate}),${hivevar:endDate},0,21,\"databankmshare\",13,14),\"!@#\") value\n" +
                "from (\n" +
                "   \n" +
                "    select concat_ws(\",\",fund_account,bankm_account,prodta_no,prod_code) as key,concat_ws(\"!#\",nvl(init_date,\"\"),nvl(end_date,\"\"),nvl(fund_account,\"\"),nvl(client_id,\"\"),nvl(prodta_no,\"\"),nvl(bankm_account,\"\"),nvl(cast(branch_no as string),\"\"),nvl(prod_code,\"\"),nvl(money_type,\"\"),nvl(\n" +
                "buy_date,\"\"),nvl(cast(serial_no as string),\"\"),nvl(net_no,\"\"),nvl(allot_no,\"\"),nvl(cast(begin_amount as string),\"\"),nvl(cast(current_amount as string),\"\"),nvl(\n" +
                "cast(frozen_amount as string),\"\"),nvl(dividend_way,\"\"),nvl(charge_type,\"\"),nvl(cast(bankm_market_value as string),\"\"),nvl(position_str,\"\"),nvl(trans_account,\"\"),nvl(part_init_date,\"\")) as value from \n" +
                "    (\n" +
                "   \n" +
                "    select a.init_date,a.end_date,a.fund_account,a.client_id,a.prodta_no,a.bankm_account,a.branch_no,a.prod_code,a.money_type,a.\n" +
                "buy_date,a.serial_no,a.net_no,a.allot_no,0 as begin_amount,a.current_amount,a.frozen_amount,a.dividend_way,a.\n" +
                "charge_type,a.bankm_market_value,a.position_str,a.trans_account,a.part_init_date\n" +
                "    from ${hivevar:hive_hs08db}.t_ods_hs08_his_databankmshare_hv a where begin_amount = current_amount and begin_amount <> 0 and part_init_date=${hivevar:endDate}\n" +
                "    union all\n" +
                "    select \n" +
                "    a.init_date,a.end_date,a.fund_account,a.client_id,a.prodta_no,a.bankm_account,a.branch_no,a.prod_code,a.money_type,a.\n" +
                "buy_date,a.serial_no,a.net_no,a.allot_no,a.begin_amount,a.current_amount,a.frozen_amount,a.dividend_way,a.\n" +
                "charge_type,a.bankm_market_value,a.position_str,a.trans_account,a.part_init_date\n" +
                "    from ${hivevar:hive_hs08db}.t_ods_hs08_his_databankmshare_hv a where !(begin_amount = current_amount and begin_amount <> 0) and part_init_date=${hivevar:endDate}\n" +
                "    union all\n" +
                "\n" +
                "    select \n" +
                "    a.init_date,a.end_date,a.fund_account,a.client_id,a.prodta_no,a.bankm_account,a.branch_no,a.prod_code,a.money_type,a.\n" +
                "buy_date,a.serial_no,a.net_no,a.allot_no,a.begin_amount,a.current_amount,a.frozen_amount,a.dividend_way,a.\n" +
                "charge_type,a.bankm_market_value,a.position_str,a.trans_account,a.part_init_date\n" +
                "    from ${hivevar:hive_cleandb}.t_mid_clean_his_databankmshare_hv a where part_init_date=hiveudf.udf_last_close_day(${hivevar:endDate})\n" +
                "\n" +
                "    ) x \n" +
                "\n" +
                ") a group by key\n" +
                "\n" +
                ") b\n" +
                "\n" +
                ") c\n" +
                "\n" +
                ") d where arrays[0] != -1 and arrays[0] >=${hivevar:endDate} and arrays[0] <= ${hivevar:endDate};";
//        List<Map<String, String>> oracleProcedureSourceTargetTables = setJdbc(DataBaseConstant.ORACLE).getCreateSourceTargetTables(sql, "");
//        System.out.println("oracleProcedureSourceTargetTables = " + oracleProcedureSourceTargetTables);
        Map<String, String> sourceTargetTables = setJdbc(DataBaseConstant.ORACLE).getSimpleSourceTargetTables(sql, "");
        System.out.println("sourceTargetTables = " + sourceTargetTables);
    }

    /**
     * ???????????????????????????,?????????,?????????????????????,?????? ?????????,?????????
     *
     * @param sql          sql
     * @param absolutePath sql ??????
     * @return ????????????
     */
    public List<Map<String, String>> getCreateSourceTargetTables(String sql, String absolutePath) {
        List<Map<String, String>> returnList = new ArrayList<>();
        List<SQLStatement> stmtList;
        try {
            stmtList = SQLUtils.parseStatements(sql, dbType);
            for (SQLStatement stmt : stmtList) {
                Map<String, String> singleMap = new HashMap<>();
                if (stmt instanceof SQLCreateProcedureStatement) {
                    SQLCreateProcedureStatement stmt1 = (SQLCreateProcedureStatement) stmt;
                    singleMap.put("createName", stmt1.getName().getSimpleName().toLowerCase().trim());
                } else if (stmt instanceof OracleCreateTableStatement) {
                    OracleCreateTableStatement stmt1 = (OracleCreateTableStatement) stmt;
                    singleMap.put("createName", stmt1.getName().getSimpleName().toLowerCase().trim());
                } else if (stmt instanceof SQLCreateViewStatement) {
                    SQLCreateViewStatement stmt1 = (SQLCreateViewStatement) stmt;
                    singleMap.put("createName", stmt1.getName().getSimpleName().toLowerCase().trim());
                } else {
                    continue;
                }
                stmt.accept(visitor);
                Map<TableStat.Name, TableStat> visitorTables = visitor.getTables();
                log.debug("sql????????????table??????: {}", visitorTables);
                Set<TableStat.Name> names = visitorTables.keySet();
                for (TableStat.Name name : visitorTables.keySet()) {
                    String tableName = name.getName().toLowerCase().trim();
                    String tableType = visitorTables.get(name).toString().toLowerCase().trim();
                    if (tableType.contains("select")) {
                        singleMap.put(tableName, "sourceTable");
                    } else {
                        singleMap.put(tableName, "targetTable");
                    }
                }
                returnList.add(singleMap);
                visitor = new OracleSchemaStatVisitor();
            }
        } catch (Exception e) {
            log.error("sql ????????????: {}, ????????????: {}, ??????: {}, sql: \n{}", e.getMessage(), dbType, absolutePath, sql);
        }
        return returnList;
    }

    /**
     * ?????? sql ??? ??????,?????????
     *
     * @param sql          ?????? sql
     * @param absolutePath sql ?????????
     * @return ?????? (??????,?????????)
     */
    public Map<String, String> getSimpleSourceTargetTables(String sql, String absolutePath) {
        List<SQLStatement> stmtList;
        try {
            stmtList = SQLUtils.parseStatements(sql, dbType);
            for (SQLStatement stmt : stmtList) {
                stmt.accept(visitor);
            }
        } catch (Exception e) {
            try {
                stmtList = SQLUtils.parseStatements(sql, JdbcConstants.HIVE);
                for (SQLStatement stmt : stmtList) {
                    stmt.accept(visitor);
                }
            } catch (Exception exception) {
//                log.error("sql ????????????: {} ,????????????: {} , ??????: {} ,sql: \n{}", e.getMessage(), JdbcConstants.HIVE, absolutePath,sql);
//                log.error("sql ????????????: {} ,????????????: {} , ??????: {}", e.getMessage(), JdbcConstants.HIVE, absolutePath);
                log.error("sql ????????????,??????: {}", absolutePath);
            }
        }

        Map<String, String> resultMap = new HashMap<>();
        Map<TableStat.Name, TableStat> visitorTables = visitor.getTables();
        log.debug("sql????????????table??????: {}", visitorTables);
        Set<TableStat.Name> names = visitorTables.keySet();
        for (TableStat.Name name : visitorTables.keySet()) {
            String tableName = name.getName().toLowerCase().trim();
            String tableType = visitorTables.get(name).toString().toLowerCase().trim();
            if (tableType.contains("select")) {
                resultMap.put(tableName, "sourceTable");
            } else {
                resultMap.put(tableName, "targetTable");
            }
        }
        return resultMap;
    }

    /**
     * ??????????????????????????????
     *
     * @param sqlFile        sql??????
     * @param sourceTableSet ?????????????????????
     * @param targetTableSet ????????????????????????
     */
    public static void parseSybaseProcedureTables(File sqlFile,
                                                  Set<String> sourceTableSet,
                                                  Set<String> targetTableSet) {
        sqlParser.sqlfilename = sqlFile.getAbsolutePath();
        try {
            int parseIsSuccess = sqlParser.parse();
        } catch (Exception e) {
            log.error("sql????????????,??????: {}, ??????:{}", sqlFile, sqlParser.getErrormessage());
            return;
        }
//        ???????????????,?????????????????????
//        if (parseIsSuccess != 0) {
//            log.error("sql????????????: {}, ??????: {}", parseIsSuccess, sqlFile.getAbsolutePath());
//        }
        TStatementList sqlstatements = sqlParser.sqlstatements;
        for (int i = 0; i < sqlParser.sqlstatements.size(); i++) {
            log.debug("????????????????????????,?????????: {} ???", i + 1);
            int layer = 1;
            recursionSqlStatement(sqlParser.sqlstatements.get(i), layer, sourceTableSet, targetTableSet);
        }
    }

    /**
     * ??????????????????????????????
     *
     * @param sql            sql??????
     * @param sourceTableSet ?????????????????????
     * @param targetTableSet ????????????????????????
     */
    public static void parseSybaseProcedureTables(String sql,
                                                  Set<String> sourceTableSet,
                                                  Set<String> targetTableSet,
                                                  String fileName) {
        sqlParser.sqltext = sql;
        try {
            int parseIsSuccess = sqlParser.parse();
        } catch (Exception e) {
            log.error("sql????????????,?????????: {}, ??????:{}", fileName, sqlParser.getErrormessage());
            return;
        }
        TStatementList sqlstatements = sqlParser.sqlstatements;
        for (int i = 0; i < sqlParser.sqlstatements.size(); i++) {
            log.debug("????????????????????????,?????????: {} ???", i + 1);
            int layer = 1;
            recursionSqlStatement(sqlParser.sqlstatements.get(i), layer, sourceTableSet, targetTableSet);
        }
    }

    /**
     * ????????????sql???
     *
     * @param stmt           ??????
     * @param layer          ??????
     * @param sourceTableSet ?????????????????????
     * @param targetTableSet ????????????????????????
     */
    private static void recursionSqlStatement(TCustomSqlStatement stmt, int layer, Set<String> sourceTableSet, Set<String> targetTableSet) {
        log.debug("??????????????????,?????????: {} ??????", layer++);
        TTable targetTable = stmt.getTargetTable();
        TTableList tableList = stmt.tables;
        TStatementList statements = stmt.getStatements();
        if (targetTable != null) {
//            System.out.println("targetTable = " + targetTable);
            String targetTableName = targetTable.getFullName().trim().toLowerCase().replace("\"", "");
            if (!targetTableName.contains("#")) {
                targetTableSet.add(targetTableName);
            }
        }
        for (int i = 0; i < tableList.size(); i++) {
            TTable table = tableList.getTable(i);
            if (!((table.getTableType() == ETableSource.subquery) || (table.isCTEName()))) {
                String tableName = "";
                if (table.isLinkTable()) {
                    tableName = table.getLinkTable().getFullName().trim().toLowerCase().replace("\"", "");
                } else {
                    String fullName = table.getFullName();
                    tableName = fullName == null ? "" : fullName.trim().toLowerCase().replace("\"", "");
                }

                if (tableName.contains("#")) {
                    // TODO ?????????
                } else {
//                    ???????????????????????????
//                    if (stmt instanceof TSelectSqlStatement || stmt instanceof TTruncateStatement) {
                    sourceTableSet.add(tableName);
//                    } else {
//                        targetTableSet.add(tableName);
//                    }
                }
            }
        }
//        ?????????????????????
        for (int x = 0; x < statements.size(); x++) {
            recursionSqlStatement(statements.get(x), layer, sourceTableSet, targetTableSet);
        }
    }

    /**
     * ?????? druid ??????????????????, ???????????? oracle,mysql?????????
     *
     * @param sql          sql?????????
     * @param absolutePath ??????
     */
    private void parseProcedureTables(String sql, String absolutePath) {
        visitor = new OracleSchemaStatVisitor();
        SQLStatementParser parser = SQLParserUtils.createSQLStatementParser(sql, JdbcConstants.ORACLE);
        SQLCreateProcedureStatement sqlCreateProcedureStatement = (SQLCreateProcedureStatement) parser.parseStatement();
        sqlCreateProcedureStatement.accept(visitor);
        System.out.println("visitor.getTables() = " + visitor.getTables());
    }

    /**
     * ?????? ?????? ??? ????????????
     *
     * @param sql          ?????? sql
     * @param absolutePath sql ?????????
     * @return ?????? (??????,????????????)
     */
    public Map<String, List<String>> getTableNameAndColumns(String sql, String absolutePath) {
        Map<String, List<String>> resultMap = new HashMap<>();
        List<SQLStatement> stmtList = null;
        try {
            stmtList = SQLUtils.parseStatements(sql, dbType);
        } catch (Exception e) {
            log.error("sql ????????????: {} ,??????: {}", e.getMessage(), absolutePath);
        }
        for (SQLStatement stmt : stmtList) {
            stmt.accept(visitor);
        }
        visitor.getColumns().forEach(entity -> {
            String tableName = entity.getTable().trim().toLowerCase();
            String columnName = entity.getName().trim().toLowerCase();
            if (!resultMap.containsKey(tableName)) {
                resultMap.put(tableName, Collections.singletonList(columnName));
            } else {
                List<String> list = new ArrayList<>(resultMap.get(tableName));
                list.add(columnName);
                resultMap.put(tableName, list);
            }
        });
        return resultMap;
    }

    /**
     * ?????? sql ????????????,???????????????select , ???2?????????,?????? visitor.getColumns()?????????????????????????????????,?????? 1 as fields_name
     * ?????? ??? select ?????????????????????,????????? as ?????????null , ??? visitor.getColumns() ????????????????????????
     *
     * @param sql          ?????? sql
     * @param absolutePath sql ?????????
     * @return ?????? sql ????????????
     */
    List<String> getAllColumns(String sql, String absolutePath) {
        log.debug("sql: {}", sql);
        List<SQLStatement> stmtList;
        List<String> returnFieldsList = new ArrayList<>();
        try {
            stmtList = SQLUtils.parseStatements(sql, dbType);
            List<String> visitorFieldsList = new ArrayList<>();
            List<String> selectFieldsList = new ArrayList<>();
            for (SQLStatement stmt : stmtList) {
                stmt.accept(visitor);
                visitorFieldsList = visitor.getColumns().stream()
                        .map(entity -> entity.getName().toLowerCase().trim().replace("`", ""))
                        .collect(Collectors.toList());
                if (stmt instanceof SQLSelectStatement) {
                    SQLSelectStatement sqlSelectStatement = (SQLSelectStatement) stmt;
                    List<SQLSelectItem> selectList = sqlSelectStatement.getSelect().getFirstQueryBlock().getSelectList();
                    for (SQLSelectItem selectItem : selectList) {
                        selectFieldsList.add(selectItem.computeAlias());
                    }
                }
            }

            if (selectFieldsList.contains(null)) {
                List<Integer> nullIndexList = new ArrayList<>();
                for (int i = 0; i < selectFieldsList.size() - 1; i++) {
                    if (selectFieldsList.get(i) == null) {
                        nullIndexList.add(i);
                    }
                }
                returnFieldsList.addAll(selectFieldsList.stream().filter(Objects::nonNull).collect(Collectors.toList()));
                String visitorField = null;
                for (int nullIndex : nullIndexList) {
                    visitorField = nullIndex > visitorFieldsList.size() ?
                            visitorFieldsList.get(visitorFieldsList.size() - 1)
                            : visitorFieldsList.get(nullIndex);
                    returnFieldsList.add(nullIndex, visitorField);
                }
                log.debug("visitorFieldsList: {}", visitorFieldsList);
                log.debug("selectFieldsList: {}", selectFieldsList);
                log.debug("nullIndexList: {}, visitorField: {}", nullIndexList, visitorField);
                log.debug("returnFieldsList: {}", returnFieldsList);
            } else {
                returnFieldsList.addAll(selectFieldsList);
            }
        } catch (Exception e) {
            log.error("sql ????????????: {} ,??????: {}, sql: \n{}", e.getMessage(), absolutePath, sql);
        }
        return returnFieldsList;
    }

    /**
     * ?????? sql ??????????????????
     *
     * @param sql          ?????? sql
     * @param absolutePath sql ?????????
     * @return ?????? sql ??????????????????
     */
    public List<Map<String, String>> getFieldsDetail(String sql, String absolutePath) {
        List<Map<String, String>> resultList = new ArrayList<>();
        List<SQLStatement> stmtList = null;
        try {
            stmtList = SQLUtils.parseStatements(sql, dbType);
        } catch (Exception e) {
            log.error("sql ????????????: {} ,??????: {}", e.getMessage(), absolutePath);
        }
        for (SQLStatement stmt : stmtList) {
            stmt.accept(visitor);
            if (stmt instanceof SQLCreateTableStatement) {
                SQLCreateTableStatement stmt1 = (SQLCreateTableStatement) stmt;
                String tableName = stmt1.getName().toString().toLowerCase().trim();
                SQLExpr tableComment = stmt1.getComment();
//                List<SQLColumnDefinition> partitionColumns = stmt1.getPartitionColumns();
//                if (partitionColumns != null && partitionColumns.size() > 0) {
//                    for (SQLColumnDefinition sqlColumnDefinition : partitionColumns) {
//                        Map<String, String> resultMap = new HashMap<>();
//                        resultMap.put("tableName", tableName);
//                        resultMap.put("columnName", sqlColumnDefinition.getColumnName().replace("`", ""));
//                        resultMap.put("columnType", sqlColumnDefinition.getDataType().getName());
//                        resultMap.put("columnComment", "");
//                        resultList.add(resultMap);
//                    }
//                }
                List<SQLColumnDefinition> columnDefinitions = stmt1.getColumnDefinitions();
//                System.out.println("stmt1.getColumnComments() = " + stmt1.getColumnComments());
//                System.out.println("stmt1.getColumnDefinitions() = " + columnDefinitions);
                int i = 1;
                for (SQLColumnDefinition sqlColumnDefinition : columnDefinitions) {
                    Map<String, String> resultMap = new HashMap<>();
                    SQLExpr columnComment = sqlColumnDefinition.getComment();
                    resultMap.put("tableName", tableName);
                    resultMap.put("tableComment", tableComment == null ? "" : tableComment.toString().replaceAll("'|\\n", ""));
                    resultMap.put("columnName", sqlColumnDefinition.getColumnName().replace("`", "").toLowerCase().trim());
                    resultMap.put("columnType", sqlColumnDefinition.getDataType().toString().toLowerCase().replaceAll(" ", "").trim());
                    resultMap.put("columnOrder", String.valueOf(i++));
                    //                    decimal(18, 0)
//                    System.out.println("sqlColumnDefinition.getDataType() = " + sqlColumnDefinition.getDataType());
//                    decimal
//                    System.out.println("sqlColumnDefinition.getDataType().getName() = " + sqlColumnDefinition.getDataType().getName());
//                    hive
//                    System.out.println("sqlColumnDefinition.getDataType().getDbType() = " + sqlColumnDefinition.getDataType().getDbType());
//                    [18, 0]
//                    System.out.println("sqlColumnDefinition.getDataType().getArguments() = " + sqlColumnDefinition.getDataType().getArguments());
                    resultMap.put("columnComment", columnComment != null ? columnComment.toString().replaceAll("'|\\n", "") : "");
                    resultList.add(resultMap);
                }
            }
        }
        return resultList;
    }

    /**
     * ?????? sql where???????????????????????????
     *
     * @param sql          ?????? sql
     * @param absolutePath sql ?????????
     * @return ?????? where???????????????????????????
     */
    Map<String, List<String>> getTableNameAndWhereColumns(String sql, String absolutePath) {
        Map<String, List<String>> resultMap = new HashMap<>();
        List<SQLStatement> stmtList;
        try {
            stmtList = SQLUtils.parseStatements(sql, dbType);
            for (SQLStatement stmt : stmtList) {
                if (stmt instanceof SQLDeleteStatement) {
                    SQLDeleteStatement stmt1 = (SQLDeleteStatement) stmt;
                    stmt1.accept(visitor);
                } else if (stmt instanceof SQLSelectStatement) {
                    SQLSelectStatement stmt1 = (SQLSelectStatement) stmt;
                    SQLSelectQueryBlock firstQueryBlock = stmt1.getSelect().getFirstQueryBlock();
                    //                System.out.println("tableName = " + firstQueryBlock.getFrom());
                    SQLExpr where = firstQueryBlock.getWhere();
//                SQLBetweenExpr where1 = (SQLBetweenExpr) where;
//                System.out.println("?????????????????? x*100+y,???????????????????????? " + where1.testExpr);
                    if (where != null && where.toString().toLowerCase().contains("where")) {
                        where.accept(visitor);
                    }
                }
            }
            visitor.getColumns().forEach(entity -> {
//            ?????? where ????????? columns ??????????????????,??? ?????????????????????
                String tableName = entity.getTable().trim().toLowerCase();
                String columnName = entity.getName().trim().toLowerCase();
                if (!resultMap.containsKey(tableName)) {
                    resultMap.put(tableName, Collections.singletonList(columnName));
                } else {
                    List<String> list = new ArrayList<>(resultMap.get(tableName));
                    list.add(columnName);
                    resultMap.put(tableName, list);
                }
            });
        } catch (Exception e) {
            log.error("sql ????????????: {} ,??????: {}", e.getMessage(), absolutePath);
        }
        return resultMap;
    }

    /**
     * @param sql          ?????? sql
     * @param absolutePath sql ?????????
     * @return ?????? (??????,?????????)
     */
    public Map<String, String> getTableNameAndComment(String sql, String absolutePath) {
        Map<String, String> resultMap = new HashMap<>();
        List<SQLStatement> stmtList = null;
        try {
            stmtList = SQLUtils.parseStatements(sql, dbType);
        } catch (Exception e) {
            log.error("sql ????????????: {} ,??????: {}", e.getMessage(), absolutePath);
        }
        for (SQLStatement stmt : stmtList) {
            stmt.accept(visitor);
            if (stmt instanceof SQLCreateTableStatement) {
                SQLCreateTableStatement stmt1 = (SQLCreateTableStatement) stmt;
                String tableName = stmt1.getName().toString().toLowerCase().trim();
                SQLExpr tableComment = stmt1.getComment();
                if (tableComment == null) {
                    resultMap.put(tableName, "");
                } else {
                    resultMap.put(tableName, tableComment.toString().replace("'", ""));
                }
            }
        }
        return resultMap;
    }

}