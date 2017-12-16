<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
ProductBean product = ProductManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("productid")));
int punitid = 0;
if(product != null) punitid = product.getPunitid();
String where = "where punitid != "+punitid;

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


int count = PunitManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord+", punitid";

PunitBean[] punit = PunitManager.getInstance().loadByWhere(where+" "+order+" "+limit);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<punit.length;i++){
    ProductunitBean pu = ProductunitManager.getInstance().loadByPrimaryKey(product.getProductid(), punit[i].getPunitid());
    String val = "";
    if(pu != null) val = dc.format(pu.getAmount());
    JSONObject ob = new JSONObject();
    ob.put("id",punit[i].getPunitid());
    JSONArray cell = new JSONArray();
    cell.add(trs.t(punit[i].getName()));
    cell.add(val);
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
