package tools;

import com.alibaba.druid.DbType;
import com.alibaba.druid.sql.SQLUtils;
import com.alibaba.druid.sql.ast.SQLExpr;
import com.alibaba.druid.sql.ast.SQLStatement;
import com.alibaba.druid.sql.ast.statement.*;
import com.alibaba.druid.sql.dialect.hive.visitor.HiveSchemaStatVisitor;
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

    public static SqlParserTools setJdbc(DataBaseConstant dataBaseConstant) {
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
                visitor = new OracleSchemaStatVisitor();
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
//        File file = new File("C:\\Workspace\\ideaProject\\data_relations\\PROCEDURE\\dba_p_cust_entst_use_tern.sql");
//        FileTools fileTools = new FileTools();
//        Set<String> sourceTableSet = new HashSet<>();
//        Set<String> targetTableSet = new HashSet<>();
//        parseSybaseProcedureTables(fileTools.removeCursorsAndKeywords(fileTools.readToBuffer(file)), sourceTableSet, targetTableSet, "");
//        System.out.println("sourceTableSet = " + sourceTableSet);
//        System.out.println("sourceTableSet.size() = " + sourceTableSet.size());
//        System.out.println("targetTableSet = " + targetTableSet);
//        System.out.println("targetTableSet.size() = " + targetTableSet.size());
//        String sql = new FileParseTools().parseDchis(new File("C:\\Workspace\\ideaProject\\data_relations\\ORACLE\\dchis.sql"));
        String sql = "CREATE OR REPLACE Procedure SP_I_OMS_HIS_BLOBFILE(I_JOB_NAME   In DCMETA.PKG_DCTYPE.DCVARCHAR128,\n" +
                "                                                        I_INIT_DATE  In DCMETA.PKG_DCTYPE.DCDATE,\n" +
                "                                                        I_BEGIN_DATE In DCMETA.PKG_DCTYPE.DCDATE,\n" +
                "                                                        I_END_DATE   In DCMETA.PKG_DCTYPE.DCDATE)\n" +
                "--============================================================================\n" +
                "  --对象编号   :\n" +
                "  --对象名称   : dcraw.hs08_his_blobfile\n" +
                "  --对象标识   :\n" +
                "  --创 建 人   : hzy\n" +
                "  --创建日期   :\n" +
                "  --功能描述   : 表dchis.oms_his_blobfile RAW to ODS 自动生成。\n" +
                "  --修改说明   :\n" +
                "  --============================================================================\n" +
                " Is\n" +
                "  V_SQLCODE     DCMETA.PKG_DCTYPE.DCNUM Default 0;\n" +
                "  V_ERROR_MSG   DCMETA.PKG_DCTYPE.DCVARCHAR4000 Default ' ';\n" +
                "  V_ERROR_LEVEL DCMETA.PKG_DCTYPE.DCTYPE Default '2'; --信息级别：'0'消息、'1'警告、'2'错误\n" +
                "\n" +
                "  V_JOB_NAME   DCMETA.PKG_DCTYPE.DCVARCHAR128 := NVL(I_JOB_NAME, ' ');\n" +
                "  V_INIT_DATE  DCMETA.PKG_DCTYPE.DCNUM := NVL(I_INIT_DATE, 0);\n" +
                "  V_BEGIN_DATE DCMETA.PKG_DCTYPE.DCDATE := NVL(I_BEGIN_DATE, 0);\n" +
                "  V_END_DATE   DCMETA.PKG_DCTYPE.DCDATE := NVL(I_END_DATE, 0);\n" +
                "Begin\n" +
                "\n" +
                "  Execute Immediate 'TRUNCATE TABLE  dchis.oms_his_blobfile';\n" +
                "  Insert Into DCHIS.OMS_HIS_BLOBFILE\n" +
                "    (OC_DATE, INIT_DATE, FILE_GUID, ORDINAL, BLOB_NO, DEAL_FLAG, FILE_OBJ, DATE_CLEAR, CHANGE_TIME, REMARK)\n" +
                "    Select OC_DATE, INIT_DATE, FILE_GUID, ORDINAL, BLOB_NO, DEAL_FLAG, FILE_OBJ, DATE_CLEAR, Sysdate As CHANGE_TIME, REMARK REGISTER_DATE\n" +
                "    \n" +
                "      From DCRAW.HS08_HIS_BLOBFILE;\n" +
                "  Commit;\n" +
                "Exception\n" +
                "  When Others Then\n" +
                "    V_SQLCODE   := Sqlcode;\n" +
                "    V_ERROR_MSG := Sqlerrm;\n" +
                "    Rollback;\n" +
                "    DCMETA.SP_WRITE_JOB_LOG(V_JOB_NAME, V_ERROR_LEVEL, V_SQLCODE || V_ERROR_MSG);\n" +
                "    Raise;\n" +
                "End SP_I_OMS_HIS_BLOBFILE;";
//        Map<String, String> sourceTargetTables = setJdbc(DataBaseConstant.SYBASE).getSourceTargetTables(sql, "");
//        System.out.println("sourceTargetTables = " + sourceTargetTables);
//        System.out.println(setJdbc(DataBaseConstant.SYBASE).getTableNameAndColumns(sql, ""));
        System.out.println(setJdbc(DataBaseConstant.ORACLE).getSourceTargetTables(sql, ""));
//        System.out.println(setJdbc(DataBaseConstant.ORACLE).getAllColumns(sql, ""));
//        System.out.println(setJdbc(DataBaseConstant.HIVE).getFieldsDetail(sql, ""));
    }

    /**
     * 获取 sql 的 源表,目标表
     *
     * @param sql          传入 sql
     * @param absolutePath sql 的路径
     * @return 返回 (源表,目标表)
     */
    public Map<String, String> getSourceTargetTables(String sql, String absolutePath) {
        List<SQLStatement> stmtList;
        try {
            stmtList = SQLUtils.parseStatements(sql, dbType);
            for (SQLStatement stmt : stmtList) {
                stmt.accept(visitor);
            }
        } catch (Exception e) {
            log.error("sql 解析失败: {} ,解析类型: {} , 路径: {}", e.getMessage(), dbType, absolutePath);
            try {
                stmtList = SQLUtils.parseStatements(sql, JdbcConstants.HIVE);
                for (SQLStatement stmt : stmtList) {
                    stmt.accept(visitor);
                }
            } catch (Exception exception) {
                log.error("sql 解析失败: {} ,解析类型: {} , 路径: {}", e.getMessage(), JdbcConstants.HIVE, absolutePath);
//                log.error("sql:\n {}", sql);
            }
        }

        Map<String, String> resultMap = new HashMap<>();
        Map<TableStat.Name, TableStat> visitorTables = visitor.getTables();
        log.debug("sql解析出的table列表: {}", visitorTables);
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
     * 解析存储过程中的表名
     *
     * @param sqlFile        sql文件
     * @param sourceTableSet 解析出的源表名
     * @param targetTableSet 解析出的目标表名
     */
    public static void parseSybaseProcedureTables(File sqlFile,
                                                  Set<String> sourceTableSet,
                                                  Set<String> targetTableSet) {
        sqlParser.sqlfilename = sqlFile.getAbsolutePath();
        try {
            int parseIsSuccess = sqlParser.parse();
        } catch (Exception e) {
            log.error("sql解析失败,路径: {}, 报错:{}", sqlFile, sqlParser.getErrormessage());
            return;
        }
//        好像没啥用,还是解析出来了
//        if (parseIsSuccess != 0) {
//            log.error("sql解析失败: {}, 路径: {}", parseIsSuccess, sqlFile.getAbsolutePath());
//        }
        TStatementList sqlstatements = sqlParser.sqlstatements;
        for (int i = 0; i < sqlParser.sqlstatements.size(); i++) {
            log.debug("开始递归获取表名,目前第: {} 层", i + 1);
            int layer = 1;
            recursionSqlStatement(sqlParser.sqlstatements.get(i), layer, sourceTableSet, targetTableSet);
        }
    }

    /**
     * 解析存储过程中的表名
     *
     * @param sql            sql内容
     * @param sourceTableSet 解析出的源表名
     * @param targetTableSet 解析出的目标表名
     */
    public static void parseSybaseProcedureTables(String sql,
                                                  Set<String> sourceTableSet,
                                                  Set<String> targetTableSet,
                                                  String fileName) {
        sqlParser.sqltext = sql;
        try {
            int parseIsSuccess = sqlParser.parse();
        } catch (Exception e) {
            log.error("sql解析失败,文件名: {}, 报错:{}", fileName, sqlParser.getErrormessage());
            return;
        }
        TStatementList sqlstatements = sqlParser.sqlstatements;
        for (int i = 0; i < sqlParser.sqlstatements.size(); i++) {
            log.debug("开始递归获取表名,目前第: {} 层", i + 1);
            int layer = 1;
            recursionSqlStatement(sqlParser.sqlstatements.get(i), layer, sourceTableSet, targetTableSet);
        }
    }

    /**
     * 递归获取sql树
     *
     * @param stmt           对象
     * @param layer          层次
     * @param sourceTableSet 解析出的源表名
     * @param targetTableSet 解析出的目标表名
     */
    private static void recursionSqlStatement(TCustomSqlStatement stmt, int layer, Set<String> sourceTableSet, Set<String> targetTableSet) {
        log.debug("递归获取表名,目前第: {} 子层", layer++);
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
                    // TODO 临时表
                } else {
//                    子查询应该都是源表
//                    if (stmt instanceof TSelectSqlStatement || stmt instanceof TTruncateStatement) {
                    sourceTableSet.add(tableName);
//                    } else {
//                        targetTableSet.add(tableName);
//                    }
                }
            }
        }
//        继续往内层递归
        for (int x = 0; x < statements.size(); x++) {
            recursionSqlStatement(statements.get(x), layer, sourceTableSet, targetTableSet);
        }
    }

    /**
     * 测试 druid 解析存储过程, 目前只有 oracle,mysql的解析
     *
     * @param sql          sql字符串
     * @param absolutePath 路径
     */
    private void parseProcedureTables(String sql, String absolutePath) {
        visitor = new OracleSchemaStatVisitor();
        SQLStatementParser parser = SQLParserUtils.createSQLStatementParser(sql, JdbcConstants.ORACLE);
        SQLCreateProcedureStatement sqlCreateProcedureStatement = (SQLCreateProcedureStatement) parser.parseStatement();
        sqlCreateProcedureStatement.accept(visitor);
        System.out.println("visitor.getTables() = " + visitor.getTables());
    }

    /**
     * 获取 表名 和 字段列表
     *
     * @param sql          传入 sql
     * @param absolutePath sql 的路径
     * @return 返回 (表名,字段列表)
     */
    public Map<String, List<String>> getTableNameAndColumns(String sql, String absolutePath) {
        Map<String, List<String>> resultMap = new HashMap<>();
        List<SQLStatement> stmtList = null;
        try {
            stmtList = SQLUtils.parseStatements(sql, dbType);
        } catch (Exception e) {
            log.error("sql 解析失败: {} ,路径: {}", e.getMessage(), absolutePath);
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
     * 获取 sql 的所有列,这里如果是select , 分2种情况,因为 visitor.getColumns()解析不出来固定值的字段,例如 1 as fields_name
     * 优先 以 select 里面解析的为主,但没有 as 的会为null , 在 visitor.getColumns() 找出对应的放进去
     *
     * @param sql          传入 sql
     * @param absolutePath sql 的路径
     * @return 返回 sql 的所有列
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
            log.error("sql 解析失败: {} ,路径: {}, sql: \n{}", e.getMessage(), absolutePath, sql);
        }
        return returnFieldsList;
    }

    /**
     * 获取 sql 所有明细数据
     *
     * @param sql          传入 sql
     * @param absolutePath sql 的路径
     * @return 返回 sql 所有明细数据
     */
    public List<Map<String, String>> getFieldsDetail(String sql, String absolutePath) {
        List<Map<String, String>> resultList = new ArrayList<>();
        List<SQLStatement> stmtList = null;
        try {
            stmtList = SQLUtils.parseStatements(sql, dbType);
        } catch (Exception e) {
            log.error("sql 解析失败: {} ,路径: {}", e.getMessage(), absolutePath);
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
     * 获取 sql where条件后面的字段列表
     *
     * @param sql          传入 sql
     * @param absolutePath sql 的路径
     * @return 返回 where条件后面的字段列表
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
//                System.out.println("字段名表达式 x*100+y,也可能就一个字段 " + where1.testExpr);
                    if (where != null && where.toString().toLowerCase().contains("where")) {
                        where.accept(visitor);
                    }
                }
            }
            visitor.getColumns().forEach(entity -> {
//            解析 where 条件的 columns 会拿不到表名,在 循环里面拿出来
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
            log.error("sql 解析失败: {} ,路径: {}", e.getMessage(), absolutePath);
        }
        return resultMap;
    }

    /**
     * @param sql          传入 sql
     * @param absolutePath sql 的路径
     * @return 返回 (表名,表注释)
     */
    public Map<String, String> getTableNameAndComment(String sql, String absolutePath) {
        Map<String, String> resultMap = new HashMap<>();
        List<SQLStatement> stmtList = null;
        try {
            stmtList = SQLUtils.parseStatements(sql, dbType);
        } catch (Exception e) {
            log.error("sql 解析失败: {} ,路径: {}", e.getMessage(), absolutePath);
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