<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String oper = request.getParameter("op");
String where = "";
if(oper.equalsIgnoreCase("sampletype")){
    SampletypeBean sampletype = SampletypeManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("sampletypeid")));
    where = "where sampletypeid = "+sampletype.getSampletypeid();
} else if(oper.equalsIgnoreCase("labtest")){

}


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

int count = ExtraparamManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord+", extraparamid";
double total = 0;
ExtraparamBean[] params = ExtraparamManager.getInstance().loadByWhere(where+" "+order);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<params.length;i++){
    RestypeBean restype = RestypeManager.getInstance().loadByPrimaryKey(params[i].getRestypeid());
    JSONObject ob = new JSONObject();
    ob.put("id",params[i].getExtraparamid());
    
    JSONArray cell = new JSONArray();
    cell.add(params[i].getName());
    cell.add(params[i].getDescription());
    cell.add(restype.getName());
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
