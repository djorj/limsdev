<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="javax.swing.text.*"%>
<%@page import="javax.swing.text.rtf.*"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="org.apache.commons.fileupload.*" %>
<%@page import="java.lang.reflect.*" %>
<%@page import="java.net.URL"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="org.w3c.dom.CharacterData"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="org.w3c.dom.Element"%>
<%@page import="org.w3c.dom.Node"%>
<%@page import="org.w3c.dom.NodeList"%>
<%@page import="java.lang.*"%>
<%@page import="org.apache.commons.lang.*"%>
<%@page import="com.itextpdf.text.*" %>
<%@page import="com.itextpdf.text.pdf.*" %>
<%@page import="com.itextpdf.text.pdf.draw.*" %>
<%@page import="net.sf.json.*" %>
<%@page import="com.mysoft.*"%>
<%@page import="com.mysoft.lims.*"%>
<%@page import="com.mysoft.serviceclient.adclient"%>
<%@page import="java.util.logging.*" %>
<%@page import="javax.naming.*" %>
<%@page import="javax.naming.directory.*" %>
<%@page import="java.sql.DatabaseMetaData" %>
<%@page import="javax.imageio.stream.ImageOutputStream" %>
<jsp:useBean id="user" scope="session" class="com.mysoft.lims.PersonellBean"/>
<jsp:useBean id="trs" scope="session" class="com.mysoft.lims.translation"/>
<%!
public String eReg(String s){
    String ss = s;
    try {
    if(s == null)   ss = "";
    else
            ss = new String(s.getBytes("8859_1"), "UTF-8");
    //ss = ss.replaceAll("\"","&quot;");
    }catch(Exception ign){ss = "";}
    return ss;
}

public double getSum(String sql){
    double val = 0;
    Connection c = null;
    try 
    {
    c = Manager.getInstance().getConnection();
    ResultSet rs = c.createStatement().executeQuery(sql);
    if(rs.next())   val = rs.getDouble(1);
    rs.close();
    return val;
    }
    catch(Exception e){e.printStackTrace();}
    finally
    {
    Manager.getInstance().releaseConnection(c);
    }
    return val;
}

public double[] getSum(String sql,int num){
    double[] val = new double[num];
    Connection c = null;
    try
    {
    c = Manager.getInstance().getConnection();
    ResultSet rs = c.createStatement().executeQuery(sql);
    if(rs.next())
        {
        for(int i=0;i<num;i++)
            val[i] = rs.getDouble(i+1);
        }
    rs.close();
    return val;
    }
    catch(Exception e){e.printStackTrace();}
    finally
    {
    Manager.getInstance().releaseConnection(c);
    }
    return val;
}

public String getTestAns(long sampleitemreseachid) throws Exception {
    String answer = "";
    SampleitemreseachBean sb = SampleitemreseachManager.getInstance().loadByPrimaryKey(sampleitemreseachid);
    //LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(sb.getLabtestid());
    TestruleBean[] tr = TestruleManager.getInstance().loadByWhere("where labtestid = "+sb.getLabtestid());
    if(tr.length > 0){
        JSONArray ar = JSONArray.fromObject(tr[0].getJson());
        for(int i=0;i<ar.size();i++){
            JSONObject o = ar.getJSONObject(i);
            JSONArray ar0 = o.getJSONArray("tests");
            for(int j=0;j<ar0.size();j++){
                JSONObject o0 = ar0.getJSONObject(j);
                LabtestBean labtest0 = LabtestManager.getInstance().loadByPrimaryKey(o0.getInt("testid"));
                String sqlitem = "where parenttest = "+sb.getContractsampleitemid()+ " and labtestid = "+labtest0.getLabtestid();
                if(o0.containsKey("condition")){
                    if(SampleitemreseachManager.getInstance().countWhere(sqlitem+" and " + o0.getString("condition")) == 0){
                        SampleitemreseachBean[] sb0 = SampleitemreseachManager.getInstance().loadByWhere(sqlitem);
                        answer = sb0[0].getResult();
                        break;
                    }
                }
                SampleitemreseachBean[] sb0 = SampleitemreseachManager.getInstance().loadByWhere(sqlitem);
                //if(j == ar0.size()-1)
                //    answer = sb0[0].getResult();
            }
        }
    } else answer = (sb.getResult() != null) ? sb.getResult():"";
    
    return answer;
}

public JSONObject getFromFile(String file) throws Exception {
    FileInputStream fi = new FileInputStream(file);
    byte[] b = new byte[fi.available()];
    fi.read(b);
    fi.close();
    return JSONObject.fromObject(new String(b,"UTF-8"));
}

String bytesToSize(long bytes){  
    DecimalFormat dc = new DecimalFormat("0.00");
    long kilobyte = 1024;
    long megabyte = kilobyte * 1024;
    long gigabyte = megabyte * 1024;
    long terabyte = gigabyte * 1024;

    String s = "";
    if ((bytes >= 0) && (bytes < kilobyte)) {
        s = bytes + " B";

    } else if ((bytes >= kilobyte) && (bytes < megabyte)) {
        s = dc.format(bytes / kilobyte) + " KB";

    } else if ((bytes >= megabyte) && (bytes < gigabyte)) {
        s = dc.format(bytes / megabyte) + " MB";

    } else if ((bytes >= gigabyte) && (bytes < terabyte)) {
        s = dc.format(bytes / gigabyte) + " GB";

    } else if (bytes >= terabyte) {
        s = dc.format(bytes / terabyte) + " TB";

    } else {
        s = dc.format(bytes) + " B";
    }
    return s;
}

String getFullLabName(InstitutionBean mn,String sep) throws Exception{
    String s = "";
    if(mn.getParentid() != null){
        InstitutionBean mn0 = InstitutionManager.getInstance().loadByPrimaryKey(mn.getParentid());
	if(mn.getParentid().intValue() != mn.getInstitutionid().intValue())
		s = getFullLabName(mn0,sep) + " "+sep+" ";
    }
    s += (mn.getName());
    return s;
}

boolean checkProductUsage(int pid) throws Exception {
    boolean bret = false;
    if(InventoryitemManager.getInstance().countWhere("where productid = "+pid) == 0)
        bret = true;
    else if(StockmovementManager.getInstance().countWhere("where productid = "+pid) == 0)
        bret = true;
    return bret;
}

public String Num2Text(double val) {
        System.out.println("val = " + val);
        if (val <= 0.0001) {
            return "ნული";
        }
        if (val >= 1.0E33) {
            return "1.0E33";
        }
        String[] smore = {
            "ათასი", "მილიონი", "მილიარდი", "ტრილიონი", "კვადრილიონი",
            "კვინტილიონი", "სეკსტილიონი", "სეპტილიონი", "ოქტილიონი",
            "ნონილიონი", "დეცილიონი"
        };

        DecimalFormat nmf = new DecimalFormat("#,##0.00");

        String sval = nmf.format(val);

        String[] sv1 = sval.split("\\.");
        String[] sv2 = sv1[0].split(",");

        String ss = "";

        for (int i = 0; i < sv2.length; i++) {
            double d = Double.parseDouble(sv2[i]);
            if (d == 0 && i == sv2.length - 1 && ss.length() > 0) {
                ss = ss.substring(0, ss.length() - 1) + "ი";
            }
            if (d == 0) {
                continue;
            }
            ss += get1000(d);
            if (i < sv2.length - 1) {
                ss += " " + smore[sv2.length - i - 2].substring(
                        0, smore[sv2.length - i - 2].length() - 1) + " ";
            }
        }
        return ss;
    }

    /**
     * Returns number of thousands in a double value.
     *
     * @param val double value to analyze.
     *
     * @return number of thousands in the input value.
     *
     * Usde in: primarily in Num2Text method.
     */
    public String get1000(double val) {
        DecimalFormat nmf = new DecimalFormat("#,##0.00");
        String[] s10 = {
            "ერთი", "ორი", "სამი", "ოთხი", "ხუთი", "ექვსი", "შვიდი", "რვა",
            "ცხრა", "ათი", "თერთმეტი", "თორმეტი", "ცამეტი", "თოთხმეტი",
            "თხუთმეტი", "თექვსმეტი", "ჩვიდმეტი", "თვრამეტი", "ცხრამეტი"
        };

        String[] s100 = {
            "ოცი", "ორმოცი", "სამოცი", "ოთხმოცი"
        };

        String[] s1000 = {
            "ასი", "ორასი", "სამასი", "ოთხასი", "ხუთასი", "ექვსასი", "შვიდასი",
            "რვაასი", "ცხრაასი"
        };

        String sval = nmf.format(val);

        String[] sv1 = sval.split("\\.");
        String snum = sv1[0];

        String ss = "";
        int n = 0;
        int nn = 0;
        if (snum.length() == 3) {
            int m = Integer.parseInt(snum.substring(0, 1));
            ss = s1000[m - 1].substring(0, s1000[m - 1].length() - 1);
            if (Integer.parseInt(snum.substring(1)) > 0) {
                ss += " ";
            }
            n = Integer.parseInt(snum.substring(1)) / 20 - 1;
            if (n >= 0) {
                ss += s100[n].substring(0, s100[n].length() - 1);
            }
            nn = Integer.parseInt(snum.substring(1)) - 20 * (n + 1);
            if (nn > 0 && n >= 0) {
                ss += "და";
            }
            if (nn > 0) {
                ss += s10[nn - 1];
            } else {
                ss += "ი";
            }
        } else if (snum.length() == 2) {
            n = Integer.parseInt(snum) / 20 - 1;
            if (n >= 0) {
                ss += s100[n].substring(0, s100[n].length() - 1);
            }
            nn = Integer.parseInt(snum) - 20 * (n + 1);
            if (nn > 0 && n >= 0) {
                ss += "და";
            }
            if (nn > 0) {
                ss += s10[nn - 1];
            } else {
                ss += "ი";
            }
        } else if (snum.length() == 1) {
            if (Integer.parseInt(snum) > 0) {
                ss += s10[Integer.parseInt(snum) - 1];
            } else {
                ss = "ნული";
            }
        }
        return ss;
    }

public String Num2Text(int val) {
        if (val <= 0.0001) {
            return "ნული";
        }
        if (val >= 1.0E33) {
            return "1.0E33";
        }
        String[] smore = {
            "ათასი", "მილიონი", "მილიარდი", "ტრილიონი", "კვადრილიონი",
            "კვინტილიონი", "სეკსტილიონი", "სეპტილიონი", "ოქტილიონი",
            "ნონილიონი", "დეცილიონი"
        };

        DecimalFormat nmf = new DecimalFormat("#,##0");

        String sval = nmf.format(val);

        String[] sv1 = sval.split("\\.");
        String[] sv2 = sv1[0].split(",");

        String ss = "";

        for (int i = 0; i < sv2.length; i++) {
            double d = Double.parseDouble(sv2[i]);
            if (d == 0 && i == sv2.length - 1 && ss.length() > 0) {
                ss = ss.substring(0, ss.length() - 1) + "ი";
            }
            if (d == 0) {
                continue;
            }
            ss += get1000(d);
            if (i < sv2.length - 1) {
                ss += " " + smore[sv2.length - i - 2].substring(
                        0, smore[sv2.length - i - 2].length() - 1) + " ";
            }
        }
        return ss;
    }

    /**
     * Returns number of thousands in a double value.
     *
     * @param val double value to analyze.
     *
     * @return number of thousands in the input value.
     *
     * Usde in: primarily in Num2Text method.
     */
    public String get1000(int val) {
        DecimalFormat nmf = new DecimalFormat("#,##0.00");
        String[] s10 = {
            "ერთი", "ორი", "სამი", "ოთხი", "ხუთი", "ექვსი", "შვიდი", "რვა",
            "ცხრა", "ათი", "თერთმეტი", "თორმეტი", "ცამეტი", "თოთხმეტი",
            "თხუთმეტი", "თექვსმეტი", "ჩვიდმეტი", "თვრამეტი", "ცხრამეტი"
        };

        String[] s100 = {
            "ოცი", "ორმოცი", "სამოცი", "ოთხმოცი"
        };

        String[] s1000 = {
            "ასი", "ორასი", "სამასი", "ოთხასი", "ხუთასი", "ექვსასი", "შვიდასი",
            "რვაასი", "ცხრაასი"
        };

        String sval = nmf.format(val);

        String[] sv1 = sval.split("\\.");
        String snum = sv1[0];

        String ss = "";
        int n = 0;
        int nn = 0;
        if (snum.length() == 3) {
            int m = Integer.parseInt(snum.substring(0, 1));
            ss = s1000[m - 1].substring(0, s1000[m - 1].length() - 1);
            if (Integer.parseInt(snum.substring(1)) > 0) {
                ss += " ";
            }
            n = Integer.parseInt(snum.substring(1)) / 20 - 1;
            if (n >= 0) {
                ss += s100[n].substring(0, s100[n].length() - 1);
            }
            nn = Integer.parseInt(snum.substring(1)) - 20 * (n + 1);
            if (nn > 0 && n >= 0) {
                ss += "და";
            }
            if (nn > 0) {
                ss += s10[nn - 1];
            } else {
                ss += "ი";
            }
        } else if (snum.length() == 2) {
            n = Integer.parseInt(snum) / 20 - 1;
            if (n >= 0) {
                ss += s100[n].substring(0, s100[n].length() - 1);
            }
            nn = Integer.parseInt(snum) - 20 * (n + 1);
            if (nn > 0 && n >= 0) {
                ss += "და";
            }
            if (nn > 0) {
                ss += s10[nn - 1];
            } else {
                ss += "ი";
            }
        } else if (snum.length() == 1) {
            if (Integer.parseInt(snum) > 0) {
                ss += s10[Integer.parseInt(snum) - 1];
            } else {
                ss = "ნული";
            }
        }
        return ss;
    }
%>
<%
Manager.getInstance().setJdbcDriver(getServletContext().getInitParameter("driver"));
Manager.getInstance().setJdbcUrl(getServletContext().getInitParameter("url"));
Manager.getInstance().setJdbcUsername(getServletContext().getInitParameter("user"));
Manager.getInstance().setJdbcPassword(getServletContext().getInitParameter("pass"));

DecimalFormat dc = new DecimalFormat("0.00");
DecimalFormat dcc = new DecimalFormat("0.0000");
DecimalFormat dcint = new DecimalFormat("0");
SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy");
SimpleDateFormat dtlong = new SimpleDateFormat("dd/MM/yyyy HH:mm");
SimpleDateFormat dtime = new SimpleDateFormat("HH:mm");
SimpleDateFormat dtrep = new SimpleDateFormat("dd.MM.yyyy");
SimpleDateFormat dtrepfile = new SimpleDateFormat("dd_MM_yyyy");
SimpleDateFormat dtdb = new SimpleDateFormat("yyyy-MM-dd");

LangBean[] langs = (LangBean[])session.getAttribute("LANGS");
if(langs == null){
    langs = LangManager.getInstance().loadByWhere("order by basic desc, langid");
    session.setAttribute("LANGS", (LangBean[])langs);
}
if(!trs.isinit())   trs.init(langs[0].getLangid().intValue());
if(request.getParameter("langid") != null)
    trs.init(Integer.parseInt(request.getParameter("langid")));
String basedir = session.getServletContext().getRealPath("/")+"/";
//                       0: add 1: edit 2: delete   3: read 4: export   5: print
boolean[] permissions = {true,  true,   true,       true,   true,       true};

long[] ageunitvals = {31540000000L,2628000000L,86400000L,3600000L,60000L,1000L};
String[] agenames = {"წელი","თვე","დღე","საათი","წუთი","წამი"};
long msgtimeout = 60000;

String pickerformat = "{dateFormat: 'dd/mm/yy', changeMonth: true,changeYear: true,dayNames: ['კვირა','ორშაბათი','სამშაბათი','ოთხშაბათი','ხუთშაბათი','პარასკევი','შაბათი'],dayNamesMin: ['კვ','ორ','სა','ოთ','ხუ','პა','შა'],dayNamesShort: ['კვი','ორშ','სამ','ოთხ','ხუთ','პარ','შაბ'],firstDay: 1,monthNames: ['იანვარი','თებერვალი','მარტი','აპრილი','მაისი','ივნისი','ივლისი','აგვისტო','სექტემბერი','ოქტომბერი','ნოემბერი','დეკემბერი'],monthNamesShort: ['იან','თებ','მარ','აპრ','მაი','ივნ','ივლ','აგვ','სექ','ოქტ','ნოე','დეკ'], yearRange: 'c-99:c+99', minDate: '-100Y', maxDate: 0}";
String[] valuetypes = {"რიცხვითი","ტექსტური","ლოგიკური","სია","ცხრილი"};
String pickerformat1 = "{dateFormat: 'dd/mm/yy', changeMonth: true,changeYear: true,dayNames: ['კვირა','ორშაბათი','სამშაბათი','ოთხშაბათი','ხუთშაბათი','პარასკევი','შაბათი'],dayNamesMin: ['კვ','ორ','სა','ოთ','ხუ','პა','შა'],dayNamesShort: ['კვი','ორშ','სამ','ოთხ','ხუთ','პარ','შაბ'],firstDay: 1,monthNames: ['იანვარი','თებერვალი','მარტი','აპრილი','მაისი','ივნისი','ივლისი','აგვისტო','სექტემბერი','ოქტომბერი','ნოემბერი','დეკემბერი'],monthNamesShort: ['იან','თებ','მარ','აპრ','მაი','ივნ','ივლ','აგვ','სექ','ოქტ','ნოე','დეკ'], yearRange: 'c-99:c+99', minDate: '-3Y', maxDate: 0}";
String rpickerformat = "presetRanges: ["+
"        {text: 'დღეს', dateStart: 'today', dateEnd: 'today' },"+
"        {text: 'ბოლო 7 დღე', dateStart: 'today-7days', dateEnd: 'today' },"+
"        {text: 'თვის დასაწყისისდან', dateStart: function(){ return Date.parse('today').moveToFirstDayOfMonth();  }, dateEnd: 'today' },"+
"        {text: 'წლის დასაწყისისდან', dateStart: function(){ var x= Date.parse('today'); x.setMonth(0); x.setDate(1); return x; }, dateEnd: 'today' },"+
"        {text: 'წინა თვე', dateStart: function(){ return Date.parse('1 month ago').moveToFirstDayOfMonth();  }, dateEnd: function(){ return Date.parse('1 month ago').moveToLastDayOfMonth();  } },"+
//"        {text: 'ხვალ', dateStart: 'Tomorrow', dateEnd: 'Tomorrow' },"+
"        {text: 'ბოლო 30 დღე', dateStart: 'Today-30', dateEnd: 'Today' }"+
//"	 {text: 'შემდეგი 30 დღე', dateStart: 'Today', dateEnd: 'Today+30' }"+
"    ],"+
"    presets: {"+
"        specificDate: 'კონკრეტული თარიღი',"+
"	allDatesBefore: 'თარიღამდე',"+
"	allDatesAfter: 'თარიღის შემდეგ',"+
"	dateRange: 'პერიოდი'"+
"    },"+
"    dateFormat: 'dd/mm/yy',"+
"    rangeStartTitle: 'საწყისი თარიღი',"+
"    rangeEndTitle: 'საბოლოო თარიღი',"+
"    nextLinkText: 'შემდეგი',"+
"    prevLinkText: 'წინა',"+
"    doneButtonText: 'არჩევა',"+
"    datepickerOptions: "+pickerformat1;

%>
