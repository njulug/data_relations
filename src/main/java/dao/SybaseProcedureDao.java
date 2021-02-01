package dao;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * Author:BYDylan
 * Date:2021/1/4
 * Description:
 */
@Repository
public interface SybaseProcedureDao {
    @Update("truncate table ${tableName}")
    void truncateTable(String tableName);

    @Select("call ${procedureName}()")
    void callProcedure(String procedureName);

    @Select("select distinct \n" +
            "\ttrim(lower(tt1.proc_name)) as proc_name,trim(proc_defn) as proc_detail \n" +
            "from sysprocedure tt1 \n" +
            "inner join (\n" +
            "\tselect \n" +
            "\t\tt1.name as proc_name\n" +
            "\tfrom sysobjects t1 \n" +
            "\tinner join sys.sysuser t2 on t1.uid = t2.user_id\n" +
            "\twhere t1.`type` = 'P' and lower(t2.user_name) in ('${userName}')\n" +
            ") tt2 on lower(tt1.proc_name) = lower(tt2.proc_name)")
    List<LinkedHashMap<String,String>> getProcedureDetail(String userName);
}
