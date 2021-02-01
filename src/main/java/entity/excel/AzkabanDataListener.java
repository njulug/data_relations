package entity.excel;

import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.event.AnalysisEventListener;
import entity.azkaban.AzkabanEntity;
import lombok.extern.slf4j.Slf4j;

/**
 * Author:BYDylan
 * Date:2021/1/6
 * Description:
 */
@Slf4j
public class AzkabanDataListener extends AnalysisEventListener<AzkabanEntity> {

    @Override
    public void invoke(AzkabanEntity azkabanEntity, AnalysisContext analysisContext) {
    }

    @Override
    public void doAfterAllAnalysed(AnalysisContext analysisContext) {
        log.debug("所有数据读取完成!");
    }
}
