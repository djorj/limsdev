<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String where = "where companyid = "+user.getCompanyid();

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
}

int count = TestcategoryManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord+", testcategoryid";

TestcategoryBean[] cats = TestcategoryManager.getInstance().loadByWhere(where+" "+order+" "+limit);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<cats.length;i++){
    TestcategorylabBean[] labs = TestcategorylabManager.getInstance().loadByWhere("where testcategoryid = "+cats[i].getTestcategoryid()+" order by institutionid");
    String labnames = "";
    for(int j=0;j<labs.length;j++){
        InstitutionBean inst = InstitutionManager.getInstance().loadByPrimaryKey(labs[j].getInstitutionid());
        if(j > 0)   labnames += "<br>";
        labnames += getFullLabName(inst,"<i class='fa fa-arrow-right'></i>");
    }
    JSONObject ob = new JSONObject();
    ob.put("id",cats[i].getTestcategoryid());
    JSONArray cell = new JSONArray();
    cell.add(trs.t(cats[i].getName()));
    cell.add(labnames);
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
