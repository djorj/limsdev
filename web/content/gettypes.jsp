<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.DatabaseMetaData" %>
<%@include file="../includes/init.jsp"%>
<%
String where = request.getParameter("where");
if(where == null)   where = "";
String objname = request.getParameter("objname");
String[] cols = request.getParameterValues("cols");

Class cl = Class.forName("com.mysoft.lims."+objname+"Manager");
Object obj = cl.newInstance();
Method mt = cl.getMethod("loadByWhere",new Class[] {String.class});
Object[] records = (Object[])mt.invoke(obj,new Object[] {where});

Hashtable h = new Hashtable();
Connection con = Manager.getInstance().getConnection();
DatabaseMetaData meta = con.getMetaData();
ResultSet rs = meta.getImportedKeys(null, null, objname.toLowerCase());
while(rs.next()){
    String tablename = rs.getString("PKTABLE_NAME");
    String pkeyname = rs.getString("PKCOLUMN_NAME");
    String colname = rs.getString("FKCOLUMN_NAME");
    String sql = "select * from "+tablename+" where "+pkeyname+" = ";
    h.put((String)colname, (String)sql);
}
rs.close();

String res = "<select>\n<option value=\"0\">"+trs.t("-- ყველა --")+"</option>\n";
if(request.getParameter("edit") != null){
    res = "<select>\n";
} else if(request.getParameter("nmand") != null){
    res = "<select>\n<option value=\"0\">"+trs.t(request.getParameter("nmand"))+"</option>\n";
}
String sel = request.getParameter("sel");
if(sel == null) sel = "";
for(int i=0;i<records.length;i++)
    {
    String id = "";
    String value = "";
    for(int j=0;j<cols.length;j++){
        Class cl0 = records[i].getClass();
        mt = cl0.getMethod("get"+cols[j],new Class[] {});
        Object ob = mt.invoke(records[i]);
        String val = "";
        if(ob != null){
            val = ob.toString();
            
        }
        if(j==0) id = val;
        else{
            if(value.length() > 0)  value += " ";
            value += val;
        }
    }
    String selected = "";
    if(sel.equalsIgnoreCase(id)) selected = "selected";
    res += "<option value=\""+id+"\" "+selected+">"+trs.t(value)+"</option>\n";
}
res += "</select>";
%>
<%=res%>
