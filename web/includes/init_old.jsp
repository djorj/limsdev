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
<jsp:useBean id="trs" scope="application" class="com.mysoft.lims.translation"/>
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

%>
<%
Manager.getInstance().setJdbcDriver(getServletContext().getInitParameter("driver"));
Manager.getInstance().setJdbcUrl(getServletContext().getInitParameter("url"));
Manager.getInstance().setJdbcUsername(getServletContext().getInitParameter("user"));
Manager.getInstance().setJdbcPassword(getServletContext().getInitParameter("pass"));

DecimalFormat dc = new DecimalFormat("0.00");
DecimalFormat dcc = new DecimalFormat("0.0000");
SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy");
SimpleDateFormat dtlong = new SimpleDateFormat("dd/MM/yyyy HH:mm");
SimpleDateFormat dtime = new SimpleDateFormat("HH:mm");

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
%>