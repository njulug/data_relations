package tools;

import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.springframework.stereotype.Repository;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Author:BYDylan
 * Date:2020/8/10
 * Description:
 */
@Slf4j
@Repository
public class FileTools {
    @Test
    public void test() {
        String absolutePath = "D:\\WorkSpace\\ideaProject\\DataCenter_Transfer\\SJCK";
        List<File> fileList = new ArrayList<>();
        List<File> files = getFiles(new File(absolutePath), ".kjb", fileList);
        log.info("fileSize: {} , context : {}", files.size(), files.toString());
    }

    /**
     * 写入字符串到文件中
     *
     * @param dir      要写入的目录
     * @param fileName 文件名
     * @param context  文件内容
     */
    public void WriteStringToFile(String dir, String fileName, String context) {
        File file = new File(dir + File.separator + fileName);
        PrintStream ps = null;
        try {
            ps = new PrintStream(new FileOutputStream(file));
        } catch (FileNotFoundException e) {
            log.error("文件写入失败: {}", e.getMessage());
        }
        ps.println(context);
    }

    /**
     * 清空目录下所有文件
     *
     * @param dir 目录
     */
    public void truncateDir(String dir) {
        File dirFile = new File(dir);
        if (dirFile.exists()) {
            File[] files = dirFile.listFiles();
            for (File file : files) {
                if (file.isDirectory()) {
                    truncateDir(file.getAbsolutePath());
                }
                boolean delete = file.delete();
            }
        }
    }

    /**
     * 获取目标文件列表
     *
     * @param firstFile 顶层目录文件
     * @param fileType  想要的文件类型
     * @param fileList  匹配的文件列表
     * @return 返回匹配的文件列表
     */
    private List<File> getFiles(File firstFile, String fileType, List<File> fileList) {
        File[] files = firstFile.listFiles();
        Optional.ofNullable(files).ifPresent(x -> {
            for (File file : files) {
                if (file.isFile() && file.getName().endsWith(fileType)) {
                    fileList.add(file);
                } else {
                    getFiles(file, fileType, fileList);
                }
            }
        });
        return fileList;
    }

    /**
     * 匹配子目录下对应文件类型的文件列表,例如 afa目录下, hive_file 子目录, .sh文件类型的文件列表
     *
     * @param firstFile  顶层目录
     * @param subDirName 子目录
     * @param fileType   文件类型
     * @param fileList   匹配到的文件列表
     * @return 返回 fileList
     */
    private List<File> getFiles(File firstFile, String subDirName, String fileType, List<File> fileList) {
        File[] files = firstFile.listFiles();
        Optional.ofNullable(files).ifPresent(x -> {
            for (File file : files) {
//                匹配子目录
                if (file.isDirectory() && file.getName().equals(subDirName)) {
//                    匹配文件
                    getFiles(file, fileType, fileList);
                } else {
//                    否则继续进去找子目录
                    getFiles(file, subDirName, fileType, fileList);
                }
            }
        });
        return fileList;
    }

    /**
     * 获取 目录下指定类型的所有文件
     *
     * @param matchDirName 目录
     * @param fileType     文件类型
     * @return 返回 匹配的文件列表
     */
    public List<File> matchTargetFiles(String projectPath, String matchDirName, String fileType) {
        List<File> targetDirList = new ArrayList<>();
        File[] files = new File(projectPath).listFiles();
        Optional.ofNullable(files).ifPresent(x -> {
            for (File file : files) {
                if (file.isDirectory() && (file.getName().toLowerCase().contains(matchDirName))) {
                    targetDirList.add(file);
                }
            }
        });
        log.info("匹配到目录个数: {} , 分别是: {}", targetDirList.size(), targetDirList.toString());
        List<File> targetFileList = new ArrayList<>();
        Optional.ofNullable(targetDirList).ifPresent(x -> {
            for (File targetDir : targetDirList) {
                List<File> fileList = new ArrayList<>();
                targetFileList.addAll(getFiles(targetDir, fileType, fileList));
            }
        });
        return targetFileList;
    }

    /**
     * 获取 目录下, 子目录指定类型的所有文件
     *
     * @param matchDirName 目录
     * @param subDirName   子目录
     * @param fileType     文件类型
     * @return 返回 匹配的文件列表
     */
    public List<File> matchTargetFiles(String projectPath, String matchDirName, String subDirName, String fileType) {
        List<File> ktrFileList = new ArrayList<>();
        File[] files = new File(projectPath).listFiles();
        Optional.ofNullable(files).ifPresent(x -> {
            for (File file : files) {
                if (file.isDirectory() && (file.getName().toLowerCase().contains(matchDirName))) {
                    ktrFileList.add(file);
                }
            }
        });
        log.info("匹配到目录个数: {} , 分别是: {}", ktrFileList.size(), ktrFileList.toString());
        List<File> targetFileList = new ArrayList<>();
        Optional.ofNullable(ktrFileList).ifPresent(x -> {
            for (File ktrFile : ktrFileList) {
                List<File> fileList = new ArrayList<>();
                targetFileList.addAll(getFiles(ktrFile, subDirName, fileType, fileList));
            }
        });
        return targetFileList;
    }

    /**
     * 将文件转换成 字符串
     *
     * @param file 文件
     * @return 返回字符串
     */
    public String readToBuffer(File file) {
        StringBuilder stringBuilder = new StringBuilder();
        String line;
        try {
            InputStream is = new FileInputStream(file);
            BufferedReader reader = new BufferedReader(new InputStreamReader(is));
            line = reader.readLine();
            while (line != null) {
                stringBuilder.append(line);
                stringBuilder.append("\n");
                line = reader.readLine();
            }
            reader.close();
            is.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return stringBuilder.toString();
    }

    public String removeCursorsAndKeywords(String value) {
        Pattern scriptPattern = Pattern.compile("( loop\\s+FETCH\\s+NEXT)+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll(" select ");

        scriptPattern = Pattern.compile("( end\\s+if(\\s+;)?)+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll("");

        scriptPattern = Pattern.compile(
                "(commit\\s+work\\s+(;)?\\s*end\\s+(;|try)?)+",
                Pattern.CASE_INSENSITIVE);
        Matcher matcher2 = scriptPattern.matcher(value);
        if (matcher2.find()) {
            String group = matcher2.group().trim();
            if (!group.endsWith("try") && !group.endsWith(";")) {
                group = group + ";\n";
                value = matcher2.replaceAll(group);
            }
        }

        scriptPattern = Pattern.compile(
                "(if exists\\s*\\(|SCROLL\\s+CURSOR\\s+FOR\\()+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll(" if (");

        scriptPattern = Pattern
                .compile(
                        "(SCROLL\\s+CURSOR\\s+FOR| with\\s*\\([a-z0-9_\"]+\\s+[a-z]+\\([0-9,]+\\)\\)|'\\s*\\|\\|(\\s*@[a-z0-9_]+\\s*\\|\\|\\s*)+'|current | end\\s+for(\\s+;)?|if exists|execute immediate with (quotes on|unsigned |result )|(default\\s+'(\\w+(\\s+\\w+)*|%)')+|declare\\s+local\\s+temporary\\s+table|default\\s+null|sql\\s+security\\s+(definer|invoker)|\\(\\s?'(xd0|\\xd0|\\\\xd0|\\\\\\\\xd0)'\\s?\\)|\\(\\s?''\\s?\\)|\\s+WITH\\s+CHECKPOINT\\s+(ON)?\\s*?|@\\w+\\s*?\\|\\|\\s*?|'\\w+'\\s*?\\|\\|\\s*?)+",
                        Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll("");

        scriptPattern = Pattern.compile("( as \\w+\\)\\);)+",
                Pattern.CASE_INSENSITIVE);
        Matcher matcher1 = scriptPattern.matcher(value);
        if (matcher1.find()) {
            String group = matcher1.group().trim();
            group = group.replace(";", "");
            value = matcher1.replaceAll(group);
        }

        // scriptPattern = Pattern.compile("(\\s+when\\s+[0-9]+\\s+then)+",
        // Pattern.CASE_INSENSITIVE);
        // Matcher matcher3 = scriptPattern.matcher(value);
        // if (matcher3.find()) {
        // String group = matcher3.group().trim();
        // group = ";" + group;
        // value = matcher3.replaceAll(group);
        // }

        scriptPattern = Pattern.compile("(\"unique\")+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll("\"table_name\"");

        scriptPattern = Pattern.compile(
                "('\\s*\\|\\|\\s*@[a-z0-9_]+\\s*\\s*(;)?)+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll(" ' ");

        scriptPattern = Pattern.compile("(CURSOR\\s+FOR)+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll(" DYNAMIC");

        // scriptPattern = Pattern.compile("(HISTORYDATA)+",
        // Pattern.CASE_INSENSITIVE);
        // value = scriptPattern.matcher(value).replaceAll("abc");

        scriptPattern = Pattern.compile(
                "(asc\\s+rows\\s+between\\s+.*\\)\\s+as)+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll(" ) as ");

        scriptPattern = Pattern
                .compile(
                        "(OPEN\\s+[a-z0-9_\"]+\\s+WITH\\s+HOLD\\s*(;)?| database |\\s+do\\s+)+",
                        Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll(" ");

        scriptPattern = Pattern.compile("(FETCH\\s+NEXT)+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll(" select ");
        value = scriptPattern.matcher(value).replaceAll(" ;");

        scriptPattern = Pattern.compile(
                "(full outer join [0-9a-z_\\\\.\"]+ as [0-9a-z_\"]+\\s+join)+",
                Pattern.CASE_INSENSITIVE);
        Matcher matcher = scriptPattern.matcher(value);
        if (matcher.find()) {
            String group = matcher.group().trim();
            group = group.substring(0, group.length() - 5);
            group = group + " on a=b \n join ";
            value = matcher.replaceAll(group);
        }

        scriptPattern = Pattern.compile(
                "(EXECUTE\\s+IMMEDIATE\\s*\\(.*\\)\\s*(;| ))+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll("");

        scriptPattern = Pattern.compile("(\\s+elseif(\\s+|\\())+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll(" if ");

        scriptPattern = Pattern.compile("(;\\s+(--.*)?\\s+;)+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll(" ;\n");

        scriptPattern = Pattern.compile("(as\\s+\"(\\w+ ){1,2}\\w+\")+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll(" as alias");

        scriptPattern = Pattern.compile(
                "(char\\([0-9]*\\)\\s+(not)?\\s*null,)+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll("varchar(1) null,");

        // scriptPattern = Pattern.compile(
        // "(decimal\\([0-9]*,[0-9]*\\)\\s+(not)?\\s*null,)+",
        // Pattern.CASE_INSENSITIVE);
        // value = scriptPattern.matcher(value).replaceAll(",");
        // oracle
        // scriptPattern = Pattern.compile("(\\n/\\s+)+",
        // Pattern.CASE_INSENSITIVE);
        // value = scriptPattern.matcher(value).replaceAll("");
        //
        // scriptPattern = Pattern.compile("(prompt\\s+)+",
        // Pattern.CASE_INSENSITIVE);
        // value = scriptPattern.matcher(value).replaceAll("--");
        scriptPattern = Pattern
                .compile(
                        "(declare.*exception\\s+for\\s+sqlstate\\s+value|\\s+end\\s+case|set\\s+on\\s+@[a-z0-9_]+[ ]*(;)?|alter\\s+procedure\\s+[0-9a-z_\\\\.\"]+\\s*\\(| message\\s*(\\()?|set\\s+\"[a-z0-9]+\"\\s+[0-9]+;|END\\s+LOOP\\s*?|set temporary option)+",
                        Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll("--");

        scriptPattern = Pattern.compile(
                "(exception\\s+when |exception(\\s+)?--.*(\\s+)?when )+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll(" if ");

        scriptPattern = Pattern.compile("(internal\\s+name\\s+')+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll("begin \n end; --");

        scriptPattern = Pattern.compile(
                "(\\(\\s*'\\s*(\\\\\\\\N|\\\\N)\\s*'\\s*\\))+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll("");

        scriptPattern = Pattern.compile("(@\\w+\\s*?\\|\\|\\s*?)+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll("");

        scriptPattern = Pattern
                .compile("( as\\s+@)+", Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll(" as ");

        scriptPattern = Pattern
                .compile(
                        "(\\(convert\\([a-z]+\\s*,\\s*@[a-z0-9_]+\\s*\\)\\s*,\\s*[0-9,']+\\))+",
                        Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll("('1')");

        scriptPattern = Pattern.compile(
                "(\\(([a-z\"]+\\('[0-9]+'\\),){1,2}[0-9]+,'[0-9]+'\\))+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll("('1')");

        scriptPattern = Pattern.compile("((-|\\+){1}#)+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll("- #");

        scriptPattern = Pattern.compile("(\\*(-|\\+){1})+",
                Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll("\\* -");

        scriptPattern = Pattern.compile("(/#)+", Pattern.CASE_INSENSITIVE);
        value = scriptPattern.matcher(value).replaceAll("#");
        return value;
    }
}
