package entity.excel;

import com.alibaba.excel.write.handler.AbstractCellWriteHandler;
import com.alibaba.excel.write.handler.SheetWriteHandler;
import com.alibaba.excel.write.metadata.holder.WriteSheetHolder;
import com.alibaba.excel.write.metadata.holder.WriteWorkbookHolder;
import org.apache.poi.ss.usermodel.Sheet;

public class FreezeAndFilter extends AbstractCellWriteHandler implements SheetWriteHandler {

    @Override
    public void beforeSheetCreate(WriteWorkbookHolder writeWorkbookHolder, WriteSheetHolder writeSheetHolder) {

    }

    @Override
    public void afterSheetCreate(WriteWorkbookHolder writeWorkbookHolder, WriteSheetHolder writeSheetHolder) {
        Sheet sheet = writeSheetHolder.getSheet();
        int colSplit = 0;
        int rowSplit = 1;
        int leftmostColumn = 0;
        int topRow = 1;
        sheet.createFreezePane(colSplit, rowSplit, leftmostColumn, topRow);
//        设置过滤
        //        String autoFilterRange = "1:1";
//        sheet.setAutoFilter(CellRangeAddress.valueOf(autoFilterRange));
    }

}