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
public interface AnalysisDao {
    @Update("truncate table ${tableName}")
    void truncateTable(String tableName);

    @Select("call ${procedureName}()")
    void callProcedure(String procedureName);

    @Select("select * from `${tableName}`")
    List<LinkedHashMap<String,Object>> selectData(String tableName);

}
