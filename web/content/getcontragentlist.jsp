<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%@include file="../api/api.inc.jsp"%>
<%
String where = "where deleted=false and companyid = "+user.getCompanyid();

String pg   = request.getParameter("page");
String lmt  = request.getParameter("rows");
String sidx = request.getParameter("sidx")==null ? "" : request.getParameter("sidx");
String sord = request.getParameter("sord")==null ? "" : request.getParameter("sord");
int ipg  = (pg != null) ? Integer.parseInt(pg) : 1;
int ilmt = (lmt != null) ? Integer.parseInt(lmt) : 10;

if (request.getParameter("name")!=null&&request.getParameter("name").trim().length()>0)  where += " and upper(name) like '%"+request.getParameter("name").trim().toUpperCase().replaceAll("'", "''")+"%'";
if (request.getParameter("idn")!=null&&request.getParameter("idn").trim().length()>0)  where += " and upper(idn) like '%"+request.getParameter("idn").trim().toUpperCase().replaceAll("'", "''")+"%'";
if (request.getParameter("address")!=null&&request.getParameter("address").trim().length()>0)  where += " and upper(address) like '%"+request.getParameter("address").trim().toUpperCase().replaceAll("'", "''")+"%'";
if (request.getParameter("phone")!=null&&request.getParameter("phone").trim().length()>0)  where += " and upper(phone) like '%"+request.getParameter("phone").trim().toUpperCase().replaceAll("'", "''")+"%'";
if (request.getParameter("email")!=null&&request.getParameter("email").trim().length()>0)  where += " and upper(email) like '%"+request.getParameter("email").trim().toUpperCase().replaceAll("'", "''")+"%'";
if (request.getParameter("url")!=null&&request.getParameter("url").trim().length()>0)  where += " and upper(url) like '%"+request.getParameter("url").trim().toUpperCase().replaceAll("'", "''")+"%'";
if (request.getParameter("contact")!=null&&request.getParameter("contact").trim().length()>0)  where += " and upper(contact) like '%"+request.getParameter("contact").trim().toUpperCase().replaceAll("'", "''")+"%'";
if (request.getParameter("bankdata")!=null&&request.getParameter("bankdata").trim().length()>0)  where += " and upper(bankdata) like '%"+request.getParameter("bankdata").trim().toUpperCase().replaceAll("'", "''")+"%'";
if (request.getParameter("note")!=null&&request.getParameter("note").trim().length()>0)  where += " and upper(note) like '%"+request.getParameter("note").trim().toUpperCase().replaceAll("'", "''")+"%'";
if (request.getParameter("contragenttypeid")!=null)  where += " and contragenttypeid = "+Integer.parseInt(request.getParameter("contragenttypeid"));
    

int count = ContragentManager.getInstance().countWhere(where);
int total_pages = count > 0 ? (int)(count/ilmt) : 0;
if (total_pages*ilmt < count)
    total_pages++;
if (ipg > total_pages)
    ipg=total_pages;

int start = ilmt*ipg - ilmt;
if(start < 0)
    start = 0;

String limit = "limit "+ilmt+" offset "+start;
String order = "order by "+sidx+" "+sord+", contragentid";

ContragentBean[] contragents = ContragentManager.getInstance().loadByWhere(where+" "+order+" "+limit);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<contragents.length;i++){
    ContragenttypeBean type = ContragenttypeManager.getInstance().loadByPrimaryKey(contragents[i].getContragenttypeid());
    JSONObject ob = new JSONObject();
    ob.put("id",contragents[i].getContragentid());
    JSONArray cell = new JSONArray();
    cell.add(contragents[i].getContragentid());
    cell.add(trs.t(type.getName()));
    cell.add(trs.t(contragents[i].getName()));
    cell.add(contragents[i].getIdn());
    cell.add(trs.t(contragents[i].getAddress()));
    cell.add(contragents[i].getPhone());
    cell.add(contragents[i].getEmail());
    cell.add(contragents[i].getUrl());
    cell.add(trs.t(contragents[i].getContact()));
    cell.add(trs.t(contragents[i].getBankdata()));
    cell.add(trs.t(contragents[i].getNote()));
    ob.put("cell",cell);
    rows.add(ob);
}
obj.put("rows",rows);
JSONObject userdata = new JSONObject();
System.out.println(obj.toString());
obj.put("userdata",userdata);
out.print(obj.toString());
out.flush();
%>
