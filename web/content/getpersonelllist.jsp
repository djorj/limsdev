<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String where = "where companyid = "+user.getCompanyid();

for(Enumeration en = request.getParameterNames();en.hasMoreElements();){
    String name = (String)en.nextElement();
    String val = request.getParameter(name);
System.out.println(name+" = "+val);
}

if(request.getParameter("_search") != null && request.getParameter("_search").equalsIgnoreCase("true")){
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    
    if(fname == null)   fname = "";
    if(lname == null)   lname = "";
    
    fname = fname.trim().toUpperCase().replaceAll("'", "''");
    lname = lname.trim().toUpperCase().replaceAll("'", "''");
    
    int personelltypeid = Integer.parseInt(request.getParameter("personelltypeid"));
    int institutionid = Integer.parseInt(request.getParameter("institutionid"));
    
    if(fname.length() > 0)  where += " and upper(fname) like '%"+fname+"%'";
    if(lname.length() > 0)  where += " and upper(lname) like '%"+lname+"%'";
    if(personelltypeid > 0)  where += " and personelltypeid = "+personelltypeid;
    if(institutionid > 0)  where += " and institutionid = "+institutionid;
    
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


int count = PersonellManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord+", personellid";
session.setAttribute("EXPORT_PERSONELLLIST", where+" "+order);
PersonellBean[] personell = PersonellManager.getInstance().loadByWhere(where+" "+order+" "+limit);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<personell.length;i++){
    PersonelltypeBean pt = PersonelltypeManager.getInstance().loadByPrimaryKey(personell[i].getPersonelltypeid());
    String del = "არა";
    if(personell[i].getDeleted().booleanValue())    del = "დიახ";
    String lim = "არა";
    if(personell[i].getLimited().booleanValue())    lim = "დიახ";
    String ins = "";
    if(personell[i].getInstitutionid() != null){
        InstitutionBean in = InstitutionManager.getInstance().loadByPrimaryKey(personell[i].getInstitutionid());
        ins = getFullLabName(in, "=>");
    }
    JSONObject ob = new JSONObject();
    ob.put("id",personell[i].getPersonellid());
    JSONArray cell = new JSONArray();
    cell.add(trs.t(personell[i].getFname()));
    cell.add(trs.t(personell[i].getLname()));
    cell.add(personell[i].getPhone());
    cell.add(trs.t(pt.getName()));
    cell.add(personell[i].getLoginid());
    cell.add(personell[i].getPassword());
    cell.add((personell[i].getEmail() != null) ? personell[i].getEmail():"");
    cell.add(trs.t(ins));
    cell.add(dtlong.format(personell[i].getRegdate().getTime()));
    cell.add(lim);
    cell.add(del);
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
