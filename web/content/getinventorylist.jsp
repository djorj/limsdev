<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String where = "where regbyid in (select personellid from personell where companyid = "+user.getCompanyid()+") ";

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
    if(name == null)   name = "";
    name = name.trim().toUpperCase().replaceAll("'", "''");
    if(name.length() > 0)  where += " and upper(name) like '%"+name+"%'";
}

int count = InventoryManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord+", inventoryid";

InventoryBean[] invs = InventoryManager.getInstance().loadByWhere(where+" "+order+" "+limit);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<invs.length;i++){
    InstitutionBean inst = InstitutionManager.getInstance().loadByPrimaryKey(invs[i].getInstitutionid());
    PersonellBean author = PersonellManager.getInstance().loadByPrimaryKey(invs[i].getRegbyid());
    String status = trs.t("დაუსრულებელი");
    int closed = 0;
    if(invs[i].getEnddate() != null){
        status = dtlong.format(invs[i].getEnddate());
        closed = 1;
    }
    JSONObject ob = new JSONObject();
    ob.put("id",invs[i].getInventoryid());
    JSONArray cell = new JSONArray();
    cell.add(dtlong.format(invs[i].getStartdate()));
    cell.add(trs.t(inst.getName()));
    cell.add(trs.t(author.getFname())+" "+trs.t(author.getLname()));
    cell.add(status);
    cell.add(closed);
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
