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
    String num = request.getParameter("num");
    if(num == null)   num = "";
    num = num.trim().toUpperCase().replaceAll("'", "''");
    if(num.length() > 0)  where += " and upper(num) like '%"+num+"%'";
    
    String contragentid = request.getParameter("contragentid");
    if(contragentid == null)   contragentid = "";
    contragentid = contragentid.trim().toUpperCase().replaceAll("'", "''");
    if(contragentid.length() > 0)  where += " and contragentid in (select contragentid from contragent where upper(name) like '%"+contragentid+"%')";
    
    String invoicedate = request.getParameter("invoicedate");
    if(invoicedate != null && invoicedate.trim().length() > 0){
        String[] search_date = invoicedate.trim().split("-");
        if(search_date.length == 1){
            where += " and invoicedate = to_date('"+search_date[0]+"','DD/MM/YYYY')";
        } else if(search_date.length == 2){
            where += " and invoicedate >= to_date('"+search_date[0].trim()+"','DD/MM/YYYY')";
            where += " and invoicedate <= to_date('"+search_date[1].trim()+"','DD/MM/YYYY')";
        }
    }
}

int count = InvoiceManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord+", invoiceid";

InvoiceBean[] invs = InvoiceManager.getInstance().loadByWhere(where+" "+order+" "+limit);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<invs.length;i++){
    ContragentBean contragent = ContragentManager.getInstance().loadByPrimaryKey(invs[i].getContragentid());
    //PersonellBean author = PersonellManager.getInstance().loadByPrimaryKey(invs[i].getRegbyid());
    JSONObject ob = new JSONObject();
    ob.put("id",invs[i].getInvoiceid());
    JSONArray cell = new JSONArray();
    cell.add(dt.format(invs[i].getInvoicedate()));
    cell.add(invs[i].getNum());
    cell.add(trs.t(contragent.getName()));
    cell.add("");
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
