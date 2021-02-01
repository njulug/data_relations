package dao;

import com.alibaba.druid.util.StringUtils;

/**
 * Author:BYDylan
 * Date:2021/1/27
 * Description:
 */
public class CustomerContextHolder {
    public static final String SYBASE_SOURCE = "sybaseSource";
    public static final String MYSQL_SOURCE = "mysqlSource";
//    用ThreadLocal来设置当前线程使用哪个dataSource
    private static final ThreadLocal<String> contextHolder = new ThreadLocal<String>();
    public static void setCustomerType(String customerType) {
        contextHolder.set(customerType);
    }
    static String getCustomerType() {
        String dataSource = contextHolder.get();
        if (StringUtils.isEmpty(dataSource)) {
            return MYSQL_SOURCE;
        }else {
            return dataSource;
        }
    }
    public static void clearCustomerType() {
        contextHolder.remove();
    }
}
