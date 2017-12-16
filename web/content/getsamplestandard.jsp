<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
Vector v = (Vector)session.getAttribute("LABTESTPARAMS");
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

int count = v.size();
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
ilmt += start;
if(ilmt > v.size())
    ilmt = v.size();

JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=start;i<ilmt;i++){
    LabtestparamsBean ss = (LabtestparamsBean)v.elementAt(i);
    SampletypeBean stp = SampletypeManager.getInstance().loadByPrimaryKey(ss.getSampletypeid());
    String stdname = "";
    if(ss.getStandardid() != null){
        StandardBean std = StandardManager.getInstance().loadByPrimaryKey(ss.getStandardid());
        stdname = std.getName();
    }
    JSONObject ob = new JSONObject();
    ob.put("id",i);
    JSONArray cell = new JSONArray();
    cell.add(trs.t(stp.getName()));
    cell.add(trs.t(stdname));
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
