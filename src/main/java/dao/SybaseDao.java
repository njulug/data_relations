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
public interface SybaseDao {
    @Select("select \n" +
            "\ttrim(lower(t2.user_name)) as user_name \n" +
            "\t,trim(lower(t1.proc_name)) as proc_name\n" +
            "\t,t1.proc_defn \n" +
            "from sysprocedure t1\n" +
            "left join sysuser t2 on t1.creator = t2.user_id \n" +
            "where lower(t2.user_name) = '${userName}'")
    List<LinkedHashMap<String,String>> getProcedureDetail(String userName);

    @Select("select \n" +
            "\ttrim(lower(t2.user_name)) as user_name \n" +
            "\t,trim(lower(t1.table_name)) as table_name\n" +
            "\t,t1.view_def \n" +
            "from systable t1\n" +
            "left join sysuser t2 on t1.creator = t2.user_id \n" +
            "where t1.table_type = 'VIEW' and lower(t2.user_name) = '${userName}'")
    List<LinkedHashMap<String,String>> getViewDetail(String userName);
}
