<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String where = "where phrase != '' and langid = "+trs.getBlangid();

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


int count = TrlibManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by (select t.phrase from trlib t where t.phraseid = trlib.trlibid limit 1) desc";

TrlibBean[] tres = TrlibManager.getInstance().loadByWhere(where+" "+order+" "+limit);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<tres.length;i++){
    JSONObject ob = new JSONObject();
    ob.put("id",tres[i].getTrlibid());
    JSONArray cell = new JSONArray();
    cell.add(tres[i].getPhrase());
    for(int j=1;j<langs.length;j++){
        String s = "";
        TrlibBean[] tr = TrlibManager.getInstance().loadByWhere("where langid = "+langs[j].getLangid()+" and phraseid = "+tres[i].getTrlibid());
        if(tr.length > 0 && tr[0].getPhrase() != null)   s = tr[0].getPhrase();
        cell.add(s);
    }
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
