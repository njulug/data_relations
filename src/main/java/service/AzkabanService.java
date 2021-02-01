package service;

import com.alibaba.excel.EasyExcel;
import dao.ParseDataDao;
import entity.excel.AzkabanDataListener;
import entity.azkaban.AzkabanEntity;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tools.FileTools;

import java.io.File;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Author:BYDylan
 * Date:2020/8/17
 * Description: 解析 azkaban 调度文件
 * excel结果: job名称, stg_shell-s参数, stg_shell-e参数, stg_shell-o参数, ods_shell-g参数, ods_shell-k参数, 命令, 创建时间, 修改时间
 * 数据库结果: job名称, stg_shell-s参数, stg_shell-e参数, stg_shell-o参数, ods_shell-g参数, ods_shell-k参数, 命令, 创建时间, 修改时间
 */
@Slf4j
@Service
public class AzkabanService {
    private final String projectPath = System.getProperty("user.dir");
    private final ParseDataDao parseDataDao;
    private final FileTools fileTools;

    @Autowired
    public AzkabanService(ParseDataDao parseDataDao, FileTools fileTools) {
        this.parseDataDao = parseDataDao;
        this.fileTools = fileTools;
    }

    /**
     * azkaban调度文件解析
     *
     * @return 返回 阿兹卡班所有行
     */
    public List<AzkabanEntity> parse() {
        List<File> targetFileList = fileTools.matchTargetFiles(projectPath, "azkaban", ".xlsx");
        log.info("总共获取到文件个数: {}", targetFileList.size());
        parseDataDao.truncateTable("azkaban_detail");
        List<AzkabanEntity> azkabanAllFileList = new ArrayList<>();
        List<AzkabanEntity> azkabanThisFileList = new ArrayList<>();
        for (File targetFile : targetFileList) {
            log.info("开始解析文件: {}", targetFile);
            List<AzkabanEntity> readExcel = EasyExcel.read(targetFile, AzkabanEntity.class, new AzkabanDataListener()).sheet("job").doReadSync();
            readExcel = readExcel.stream()
                    .filter(entity -> entity.getCommand() != null
                            && (entity.getCommand().contains("ods_shell") || entity.getCommand().contains("stg_shell") || entity.getCommand().contains("hive_file") || entity.getCommand().contains("stg_sql") || entity.getCommand().contains("ods_sql")))
                    .collect(Collectors.toList());
            for (AzkabanEntity azkabanEntity : readExcel) {
                AzkabanEntity azkabanResultEntity = new AzkabanEntity();
                azkabanResultEntity.setFileName(targetFile.getName());
                String command = azkabanEntity.getCommand();
                String jobName = azkabanEntity.getJobName();
                azkabanResultEntity.setCommand(command);
                azkabanResultEntity.setJobName(jobName);
                azkabanResultEntity.setCreateTime(LocalDate.now().toString());
                azkabanResultEntity.setModifyTime(LocalDate.now().toString());
                List<String> commandSplitList = Arrays.asList(command.split("[\\ ]+"));
                String[] addrSplitArray = new String[10];
                if (command.contains("stg_shell")) {
                    azkabanResultEntity.setParseType("stg_shell");
                    log.debug("command 切分后大小: {}", commandSplitList.size());
                    addrSplitArray = commandSplitList.get(1).split("/");
                    if (command.contains("-a2")) {
                        for (String par : commandSplitList) {
                            if (par.contains("-s${")) {
                                azkabanResultEntity.setStgShellSName(par.replace("-s", "").replaceAll("[$|{}]", ""));
                            } else if (par.contains("-e${")) {
                                azkabanResultEntity.setStgShellEName(par.replace("-e", "").replaceAll("[$|{}]", ""));
                            } else if (par.contains("-o${")) {
                                azkabanResultEntity.setStgShellOName(par.replace("-o", "").replaceAll("[$|{}]", ""));
                            }
                        }
                    }
                } else if (command.contains("ods_shell")) {
                    azkabanResultEntity.setParseType("ods_shell");
                    addrSplitArray = commandSplitList.get(1).split("/");
                    for (String par : commandSplitList) {
                        if (par.contains("-g${")) {
                            azkabanResultEntity.setOdsShellGName(par.replace("-g", "").replaceAll("[$|{}]", ""));
                        } else if (par.contains("-k${")) {
                            azkabanResultEntity.setOdsShellKName(par.replace("-k", "").replaceAll("[$|{}]", ""));
                        }
                    }
                } else if (command.contains("hive_file")) {
                    azkabanResultEntity.setParseType("hive_file");
                    addrSplitArray = commandSplitList.get(1).split("/");
                    for (String par : commandSplitList) {
                        if (par.contains("-s${")) {
                            azkabanResultEntity.setStgShellSName(par.replace("-s", "").replaceAll("[$|{}]", ""));
                        } else if (par.contains("-e${")) {
                            azkabanResultEntity.setStgShellEName(par.replace("-e", "").replaceAll("[$|{}]", ""));
                        } else if (par.contains("-c${")) {
                            azkabanResultEntity.setHiveFileCName(par.replace("-c", "").replaceAll("[$|{}]", ""));
                        }
                    }
                } else if (command.contains("ods_sql") || command.contains("stg_sql")) {
                    addrSplitArray = commandSplitList.get(2).split("/");
                    if (command.contains("ods_sql")) {
                        azkabanResultEntity.setParseType("ods_sql");
                    } else {
                        azkabanResultEntity.setParseType("stg_sql");
                    }
                }
                azkabanResultEntity.setSubFileName(addrSplitArray[addrSplitArray.length - 1].trim());
                azkabanThisFileList.add(azkabanResultEntity);
            }
//            以 ods_shell 为准,把 stg_shell 的参数整合进来
            log.debug("整合文件: {}", targetFile.getName());
            for (AzkabanEntity odsJobLine : azkabanThisFileList
                    .stream()
                    .filter(entity -> entity.getCommand().contains("ods_shell")).collect(Collectors.toSet())) {
                String odsJobName = odsJobLine.getJobName();
//                有的 stg 会不规范,看结果后直接修改excel,能关联上就可以了.改代码是无底洞.不知道有多少种不规范的情况
                String stgJobName = odsJobName.replace("_ods_", "_stg_");
                boolean isMatch = false;
                for (AzkabanEntity stgJobLine : azkabanThisFileList
                        .stream()
                        .filter(entity -> entity.getCommand().contains("stg_shell")).collect(Collectors.toSet())) {
                    if (stgJobName.equalsIgnoreCase(stgJobLine.getJobName())) {
                        odsJobLine.setStgShellSName(stgJobLine.getStgShellSName());
                        odsJobLine.setStgShellEName(stgJobLine.getStgShellEName());
                        odsJobLine.setStgShellOName(stgJobLine.getStgShellOName());
                        isMatch = true;
                        break;
                    }
                }
                if (!isMatch) {
                    log.debug("作业未找到对应的 stg Job: {} , {}", odsJobName, stgJobName);
                    odsJobLine.setStgShellSName("未找到对应的 stg_job: " + stgJobName);
                }
            }
            azkabanAllFileList.addAll(azkabanThisFileList);
            azkabanThisFileList.clear();
        }
        log.info("表字段明细信息,开始存入数据库");
//        parseDataDao.saveBatchAzkaban("azkaban_detail", azkabanAllFileList);
        for (int i = azkabanAllFileList.size(); i > 0; i -= 10000) {
//            注意这里 sublist 是 [,)
            parseDataDao.saveBatchAzkaban("azkaban_detail", azkabanAllFileList.subList((i - 10000) < 0 ? 0 : i - 10000, i));
        }
        EasyExcel.write(projectPath + "\\azkaban结果.xlsx", AzkabanEntity.class).sheet().doWrite(azkabanAllFileList);
        log.info("azkaban 解析完成,共解析: {} 个, {} 行", targetFileList.size(), azkabanAllFileList.size());
        return azkabanAllFileList;
    }
}
