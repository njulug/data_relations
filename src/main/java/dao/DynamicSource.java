package dao;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

/**
 * Author:BYDylan
 * Date:2021/1/27
 * Description:
 */
public class DynamicSource extends AbstractRoutingDataSource {
    @Override
    protected Object determineCurrentLookupKey() {
        return CustomerContextHolder.getCustomerType();
    }
}
