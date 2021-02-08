package service;

import dao.MySQLDao;
import dao.SybaseDao;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tools.FileTools;

/**
 * Author:BYDylan
 * Date:2020/12/31
 * Description:
 */
@Slf4j
@Service
public class OracleService {
    private final String projectPath = System.getProperty("user.dir");
    private final FileTools fileTools;
    private final MySQLDao mySQLDao;
    private final SybaseDao sybaseDao;

    @Autowired
    public OracleService(SybaseDao sybaseDao, MySQLDao mySQLDao, FileTools fileTools) {
        this.fileTools = fileTools;
        this.mySQLDao = mySQLDao;
        this.sybaseDao = sybaseDao;
    }

    /**
     * 解析 Oracle 视图中的源表,目标表
     */
    public void parseView() {
//        TODO
    }

    /**
     * 解析 Oracle 存储过程中的源表,目标表
     */
    public void parseProcedure() {
//        TODO
    }
}
