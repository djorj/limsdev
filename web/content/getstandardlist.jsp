<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String where = "where standardid > 0 ";

int ipg = 1;
int ilmt = 10;
String pg = request.getParameter("page");
if(pg != null)  ipg = Integer.parseInt(pg);
String lmt = request.getParameter("rows");
if(lmt != null) ilmt = Integer.parseInt(lmt);
String sidx = request.getParameter("sidx");
if(sidx == null)    sidx = "";
String sord = request.getParameter("sord");
if(sord == null)    sord = "";
//if(isidx == 0) isidx = 1;
if(request.getParameter("_search") != null && request.getParameter("_search").equalsIgnoreCase("true")){
    String name = request.getParameter("name");
    if(name == null)   name = "";
    name = name.trim().toUpperCase().replaceAll("'", "''");
    if(name.length() > 0)  where += " and upper(name) like '%"+name+"%'";
    
    String description = request.getParameter("description");
    if(description == null)   description = "";
    description = description.trim().toUpperCase().replaceAll("'", "''");
    if(description.length() > 0)  where += " and upper(description) like '%"+description+"%'";
    
    int certid = Integer.parseInt(request.getParameter("certificateid"));
    if(certid > 0)  where += " and certificateid = "+certid;
}

int count = StandardManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord+", standardid";

StandardBean[] standards = StandardManager.getInstance().loadByWhere(where+" "+order+" "+limit);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<standards.length;i++){
    String certificatename = "";
    String certificatelogo = "";
    if(standards[i].getCertificateid() != null){
        CertificateBean cert = CertificateManager.getInstance().loadByPrimaryKey(standards[i].getCertificateid());
        certificatename = cert.getName();
        certificatelogo = cert.getLogo();
    }
    JSONObject ob = new JSONObject();
    ob.put("id",standards[i].getStandardid());
    JSONArray cell = new JSONArray();
    cell.add(trs.t(standards[i].getName()));
    cell.add(trs.t((standards[i].getDescription() == null) ? "":standards[i].getDescription()));
    cell.add(certificatename);
    cell.add(certificatelogo);
    ob.put("cell",cell);
    rows.add(ob);
}
obj.put("rows",rows);
JSONObject userdata = new JSONObject();
//userdata.put("price",dc.format(total));
System.out.println(obj.toString());
obj.put("userdata",userdata);
out.print(obj.toString());
out.flush();
%>
