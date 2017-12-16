<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String where = "where contragenttypeid > 0 ";

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
    String idn = request.getParameter("idn");
    String address = request.getParameter("address");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");
    String url = request.getParameter("url");
    String contact = request.getParameter("contact");
    String bankdata = request.getParameter("bankdata");
    String note = request.getParameter("note");
    
    if(name == null)   name = "";
    if(idn == null)   idn = "";
    if(address == null)   address = "";
    if(phone == null)   phone = "";
    if(email == null)   email = "";
    if(url == null)   url = "";
    if(contact == null)   contact = "";
    if(bankdata == null)   bankdata = "";
    if(note == null)   note = "";
    
    name = name.trim().toUpperCase().replaceAll("'", "''");
    idn = idn.trim().toUpperCase().replaceAll("'", "''");
    address = address.trim().toUpperCase().replaceAll("'", "''");
    phone = phone.trim().toUpperCase().replaceAll("'", "''");
    email = email.trim().toUpperCase().replaceAll("'", "''");
    url = url.trim().toUpperCase().replaceAll("'", "''");
    contact = contact.trim().toUpperCase().replaceAll("'", "''");
    bankdata = bankdata.trim().toUpperCase().replaceAll("'", "''");
    note = note.trim().toUpperCase().replaceAll("'", "''");
    
    int contragenttypeid = Integer.parseInt(request.getParameter("contragenttypeid"));
    
    if(name.length() > 0)  where += " and upper(name) like '%"+name+"%'";
    if(idn.length() > 0)  where += " and upper(idn) like '%"+idn+"%'";
    if(contragenttypeid > 0)  where += " and contragenttypeid = "+contragenttypeid;

    if(address.length() > 0)  where += " and upper(address) like '%"+address+"%'";
    if(phone.length() > 0)  where += " and upper(phone) like '%"+phone+"%'";
    if(email.length() > 0)  where += " and upper(email) like '%"+email+"%'";
    if(url.length() > 0)  where += " and upper(url) like '%"+url+"%'";
    if(contact.length() > 0)  where += " and upper(contact) like '%"+contact+"%'";
    if(bankdata.length() > 0)  where += " and upper(bankdata) like '%"+bankdata+"%'";
    if(note.length() > 0)  where += " and upper(note) like '%"+note+"%'";
    
}

int count = ContragenttypeManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord+", contragenttypeid";

ContragenttypeBean[] contragenttypes = ContragenttypeManager.getInstance().loadByWhere(where+" "+order+" "+limit);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<contragenttypes.length;i++){
    JSONObject ob = new JSONObject();
    ob.put("id",contragenttypes[i].getContragenttypeid());
    JSONArray cell = new JSONArray();
    cell.add(trs.t(contragenttypes[i].getName()));
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
