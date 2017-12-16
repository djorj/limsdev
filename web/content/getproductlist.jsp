<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String where = "where productgroupid = "+request.getParameter("gid");

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
    String code = request.getParameter("code");
    
    if(name == null)   name = "";
    if(code == null)   code = "";
    
    name = name.trim().toUpperCase().replaceAll("'", "''");
    code = code.trim().toUpperCase().replaceAll("'", "''");
    
    int punitid = Integer.parseInt(request.getParameter("punitid"));
    
    if(name.length() > 0)  where += " and upper(name) like '%"+name+"%'";
    if(code.length() > 0)  where += " and upper(code) like '%"+code+"%'";
    if(punitid > 0)  where += " and punitid = "+punitid;
    
}

int count = ProductManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord+", productid";

ProductBean[] products = ProductManager.getInstance().loadByWhere(where+" "+order+" "+limit);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<products.length;i++){
    ProductgroupBean group = ProductgroupManager.getInstance().loadByPrimaryKey(products[i].getProductgroupid());
    PunitBean punit = PunitManager.getInstance().loadByPrimaryKey(products[i].getPunitid());
    String exp1 = "";
    String exp2 = "";
    JSONObject ob = new JSONObject();
    ob.put("id",products[i].getProductid());
    JSONArray cell = new JSONArray();
    cell.add(trs.t(group.getName()));
    cell.add(trs.t(products[i].getName()));
    cell.add(trs.t(products[i].getCode()));
    cell.add(trs.t(punit.getName()));
    cell.add(dc.format(products[i].getLimitqty().doubleValue()));
    cell.add(exp1);
    cell.add(exp2);
    ob.put("cell",cell);
    rows.add(ob);
}
obj.put("rows",rows);
JSONObject userdata = new JSONObject();
//userdata.put("price",dc.format(total));
obj.put("userdata",userdata);
out.print(obj.toString());
out.flush();
%>
