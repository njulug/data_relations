package main;

import dao.ParseDataDao;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.InputStream;

/**
 * Author:BYDylan
 * Date:2020/12/25
 * Description:
 */
public class MybatisTest {
    private InputStream in;
    private SqlSessionFactory factory;
    private SqlSession session;
    private ParseDataDao parseDataDao;

    @Before
    public void init() throws Exception {
        in = Resources.getResourceAsStream("mybatis/SqlMapConfig.xml");
        factory = new SqlSessionFactoryBuilder().build(in);
//        session = factory.openSession(ExecutorType.BATCH, false);
        session = factory.openSession();
        parseDataDao = session.getMapper(ParseDataDao.class);
    }

    @After
    public void destroy() throws Exception {
        session.commit();
        session.close();
        in.close();
    }

    @Test
    public void testSave() {
//        List<DataEntity> list = new ArrayList<>();
//        DataEntity dataEntity = new DataEntity();
//        dataEntity.setTableName("tableName1");
//        dataEntity.setColumnName("columnName1");
//        dataEntity.setColumnType("columnType1");
//        dataEntity.setColumnComment("columnComment1");
//        dataEntity.setCreateTime(LocalDateTime.now().toString());
//        dataEntity.setModifyTime(LocalDateTime.now().toString());
//        dataDao.saveData(dataEntity);

//        DataEntity dataEntity1 = new DataEntity();
//        dataEntity1.setTableName("tableName2");
//        dataEntity1.setColumnName("columnName2");
//        dataEntity1.setColumnType("columnType2");
//        dataEntity1.setColumnComment("columnComment2");
//        dataEntity1.setCreateTime(LocalDateTime.now().toString());
//        dataEntity1.setModifyTime(LocalDateTime.now().toString());
//        list.add(dataEntity);
//        list.add(dataEntity1);
//        dataDao.saveBatchData(list);
        parseDataDao.truncateTable("hive_table_detail");
    }
}
