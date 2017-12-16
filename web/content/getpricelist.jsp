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

int count = PriceManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord+", priceid";

PriceBean[] prs = PriceManager.getInstance().loadByWhere(where+" "+order+" "+limit);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<prs.length;i++){
    JSONObject ob = new JSONObject();
    ob.put("id",prs[i].getPriceid());
    
    JSONArray cell = new JSONArray();
    cell.add(dt.format(prs[i].getPricedate()));
    cell.add(prs[i].getReason());
    cell.add(dc.format(prs[i].getPrice()));
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
