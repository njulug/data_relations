package dao;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * Author:BYDylan
 * Date:2021/1/4
 * Description: TODO
 */
@Repository
public interface OracleDao {

    @Select("")
    List<LinkedHashMap<String,String>> getProcedureDetail(String userName);

    @Select("")
    List<LinkedHashMap<String,String>> getViewDetail(String userName);
}
