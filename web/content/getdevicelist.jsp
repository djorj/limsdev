<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String where = "where deviceid > 0 ";

if(request.getParameter("_search") != null && request.getParameter("_search").equalsIgnoreCase("true")){
    String name = request.getParameter("name");
    if(name == null)   name = "";
    name = name.trim().toUpperCase().replaceAll("'", "''");
    if(name.length() > 0)  where += " and upper(name) like '%"+name+"%'";
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


int count = DeviceManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord+", deviceid";

DeviceBean[] device = DeviceManager.getInstance().loadByWhere(where+" "+order+" "+limit);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<device.length;i++){
    String inst = "";
    if(device[i].getInstitutionid() != null){
        InstitutionBean in = InstitutionManager.getInstance().loadByPrimaryKey(device[i].getInstitutionid());
        inst = getFullLabName(in, "=>");
    }
    JSONObject ob = new JSONObject();
    ob.put("id",device[i].getDeviceid());
    JSONArray cell = new JSONArray();
    cell.add(trs.t(device[i].getName()));
    cell.add(trs.t(inst));
    cell.add((device[i].getModel() == null) ? "":device[i].getModel());
    cell.add((device[i].getSn() == null) ? "":device[i].getSn());
    cell.add((device[i].getCreatedate() != null) ? dt.format(device[i].getCreatedate()):"");
    cell.add((device[i].getConditioin() == null) ? "":trs.t(device[i].getConditioin()));
    cell.add((device[i].getHasplate().booleanValue()) ? trs.t("დიახ"):trs.t("არა"));
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

