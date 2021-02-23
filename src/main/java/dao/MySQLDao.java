package dao;

import entity.azkaban.AzkabanEntity;
import entity.oracle.Dchis;
import entity.oracle.Dcraw;
import entity.oracle.Dcrun;
import entity.oracle.Dcser;
import entity.raw_to_ods.RawToOdsEntity;
import entity.src_to_bigdata.*;
import entity.src_to_raw.SrcToRawEntity;
import entity.sybase.ProcedureEntity;
import entity.sybase.ViewEntity;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Author:BYDylan
 * Date:2020/12/25
 * Description:
 */
@Repository
public interface MySQLDao {
    @Update("truncate table ${tableName}")
    void truncateTable(String tableName);

    @Insert("insert into ods_sql_table_detail(table_name,column_name,column_type,column_comment,create_time,modify_time) values (#{tableName},#{columnName},#{columnType},#{columnComment},#{createTime},now())")
    void saveData(TableEntity data);

    void saveBatchAzkaban(String tableName, List<AzkabanEntity> azkabanList);

    void saveBatchSrcToRaw(String tableName, List<SrcToRawEntity> srcToRawList);

    void saveBatchRawToOds(String tableName, List<RawToOdsEntity> rawtoOdsList);

    void saveBatchHiveFileDetail(String tableName, List<HiveFileEntity> hiveFileList);

    void saveBatchShellDetail(String tableName, List<ShellEntity> shellList);

    void saveBatchTableDetail(String tableName, List<TableEntity> dataList);

    void saveBatchOdsTotalDetail(String tableName, List<OdsTotalEntity> odsTotalList);

    void saveBatchSrcToBigData(String tableName, List<SrcToBigDataEntity> srcToBigDataList);

    void saveBatchProcedure(String tableName, List<ProcedureEntity> procedureList);

    void saveBatchView(String tableName, List<ViewEntity> viewList);

    void saveBatchDchis(String tableName, List<Dchis> dchisList);

    void saveBatchDcraw(String tableName, List<Dcraw> dcrawList);

    void saveBatchDcrun(String tableName, List<Dcrun> dcrunList);

    void saveBatchDcser(String tableName, List<Dcser> dcserList);
}
