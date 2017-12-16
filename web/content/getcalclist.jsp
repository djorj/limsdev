<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String where = "where labtestid = "+request.getParameter("labtestid");

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

int count = LabtestprodManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord+", productid";
double total = 0;
LabtestprodBean[] prs = LabtestprodManager.getInstance().loadByWhere(where+" "+order);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<prs.length;i++){
    ProductBean product = ProductManager.getInstance().loadByPrimaryKey(prs[i].getProductid());
    PunitBean punit = PunitManager.getInstance().loadByPrimaryKey(product.getPunitid());
    double price = 0;
    JSONObject ob = new JSONObject();
    ob.put("id",prs[i].getProductid());
    
    JSONArray cell = new JSONArray();
    cell.add(product.getName());
    cell.add(dcc.format(prs[i].getQty()));
    cell.add(punit.getName());
    cell.add(dc.format(price));
    cell.add(dc.format(price*prs[i].getQty()));
    ob.put("cell",cell);
    rows.add(ob);
    total += price*prs[i].getQty();
}
obj.put("rows",rows);
JSONObject userdata = new JSONObject();
userdata.put("price",dc.format(total));
obj.put("userdata",userdata);
out.print(obj.toString());
out.flush();
%>
