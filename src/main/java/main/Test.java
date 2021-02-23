package main;

import com.fasterxml.jackson.databind.JsonNode;
import gudusoft.gsqlparser.IMetaDatabase;
import tools.FileTools;
import tools.JsonTools;
import tools.XmlTools;

import java.io.File;
import java.nio.charset.Charset;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Author:BYDylan
 * Date:2020/8/10
 * Description:
 */
public class Test {
    private static final String projectPath = System.getProperty("user.dir");

    static class sampleMetaDB implements IMetaDatabase {
        @Override
        public String toString() {
            return super.toString();
        }
        /*
         * 解析存储过程时 游标的关键字和 exists 不可解析
         */

        String columns[][] = {
                {"server", "db", "schema", "TBL_BBGPOS_REP", "M_TP_PFOLIO"},
                {"server", "db", "schema", "A_FXPOSITIONDEL_REP", "M_FXDELTA"},
                {"server", "db", "schema", "A_FXPOSITIONDEL_REP", "M_CLOSING_E"},
                {"server", "db", "schema", "A_FXPOSITIONDEL_REP", "M_FXDELTA_Z"}};

        public boolean checkColumn(String server, String database, String schema,
                                   String table, String column) {
            boolean bServer, bDatabase, bSchema, bTable, bColumn, bRet = false;
            for (int i = 0; i < columns.length; i++) {
                if ((server == null) || (server.length() == 0)) {
                    bServer = true;
                } else {
                    bServer = columns[i][0].equalsIgnoreCase(server);
                }
                if (!bServer)
                    continue;

                if ((database == null) || (database.length() == 0)) {
                    bDatabase = true;
                } else {
                    bDatabase = columns[i][1].equalsIgnoreCase(database);
                }
                if (!bDatabase)
                    continue;

                if ((schema == null) || (schema.length() == 0)) {
                    bSchema = true;
                } else {
                    bSchema = columns[i][2].equalsIgnoreCase(schema);
                }

                if (!bSchema)
                    continue;

                bTable = columns[i][3].equalsIgnoreCase(table);
                if (!bTable)
                    continue;

                bColumn = columns[i][4].equalsIgnoreCase(column);
                if (!bColumn)
                    continue;

                bRet = true;
                break;
            }
            return bRet;
        }

    }

    public static void main(String[] args) {
        System.out.println("Charset.availableCharsets() = " + Charset.availableCharsets());
        FileTools fileTools = new FileTools();
        JsonTools jsonTools = new JsonTools();

        XmlTools xmlTools = new XmlTools(jsonTools);
        String absolutePath = "C:\\Workspace\\ideaProject\\data_relations\\SRC_TO_RAW\\XRZ\\ktr\\2-2-2获取事件对应的题材信息.ktr";
        JsonNode parseJsonNode = jsonTools.object2Json(xmlTools.parseKtrFile(new File(absolutePath)));
        Map<String, String> ascMap = jsonTools.ergodicJson(parseJsonNode, "asc");
        Map<String, String> descMap = jsonTools.ergodicJson(parseJsonNode, "desc");
        System.out.println("parseJsonNode = " + parseJsonNode);
        System.out.println("ascMap = " + ascMap);
        System.out.println("descMap = " + descMap);
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
