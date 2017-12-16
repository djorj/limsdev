<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String where = "where invoiceid = "+request.getParameter("id");

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
    
    String productid = request.getParameter("productid");
    if(productid == null)   productid = "";
    productid = productid.trim().toUpperCase().replaceAll("'", "''");
    if(productid.length() > 0)  where += " and productid in (select productid from product where upper(name) like '%"+productid+"%')";
    
}

int count = StockmovementManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord+", stockmovementid";

StockmovementBean[] invs = StockmovementManager.getInstance().loadByWhere(where+" "+order+" "+limit);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<invs.length;i++){
    ProductBean product = ProductManager.getInstance().loadByPrimaryKey(invs[i].getProductid());
    //PersonellBean author = PersonellManager.getInstance().loadByPrimaryKey(invs[i].getRegbyid());
    JSONObject ob = new JSONObject();
    ob.put("id",invs[i].getStockmovementid());
    JSONArray cell = new JSONArray();
    cell.add(product.getInvnumber());
    cell.add(product.getCode());
    cell.add(trs.t(product.getName()));
    cell.add(dc.format(invs[i].getUnitprice()));
    cell.add(dc.format(invs[i].getQuantity()));
    cell.add(dc.format(invs[i].getUnitprice()*invs[i].getQuantity()));
    ob.put("cell",cell);
    rows.add(ob);
}
obj.put("rows",rows);
JSONObject userdata = new JSONObject();
//userdata.put("price",dc.format(total));
obj.put("userdata",userdata);
out.print(obj.toString());System.out.println(obj.toString());
out.flush();
%>
