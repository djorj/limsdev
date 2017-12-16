<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
Vector v = (Vector)session.getAttribute("UPLOADEDRESULTS");
if(v == null)   v = new Vector();

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


int count = v.size();
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord+", deviceid";

JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<v.size();i++){
    DeviceresultBean dr = (DeviceresultBean)v.elementAt(i);
    JSONObject result = JSONObject.fromObject(dr.getResult());
    JSONObject ob = new JSONObject();
    ob.put("id",i);
    JSONArray cell = new JSONArray();
    cell.add(result.getString("wellno")+": "+result.getString("barcode"));
    cell.add(result.getString("quantitative"));
    cell.add(result.getString("qualitative"));
    cell.add("-");
    cell.add(result.getString("absorbency"));
    cell.add("-");
    cell.add("-");
    int status = 1;
    if(dr.getSampleitemreseachid()== null)    status = 0;
    else if(dr.getDeviceresultid() != null)   status = 2;
    cell.add(status);
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

