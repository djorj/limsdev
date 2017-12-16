<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String where = "where operid > 2";

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


int count = StockmovementManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord+", stockmovementid";

StockmovementBean[] sts = StockmovementManager.getInstance().loadByWhere(where+" "+order+" "+limit);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<sts.length;i++){
    ProductBean product = ProductManager.getInstance().loadByPrimaryKey(sts[i].getProductid());
    InvoiceBean invoice = InvoiceManager.getInstance().loadByPrimaryKey(sts[i].getInvoiceid());
    PunitBean punit = PunitManager.getInstance().loadByPrimaryKey(product.getPunitid());
    ProductgroupBean category = ProductgroupManager.getInstance().loadByPrimaryKey(product.getProductgroupid());
    String invoicetype = "";
    String source = "";
    String account = "";
    String isnew = "";
    String expdate = "";
    String room = "";
    String complect = "";
    
    JSONObject ob = new JSONObject();
    ob.put("id",sts[i].getStockmovementid());
    JSONArray cell = new JSONArray();
    cell.add(product.getCode());
    cell.add(invoice.getNum());
    cell.add(invoicetype);
    cell.add(dt.format(invoice.getInvoicedate()));
    cell.add(product.getName());
    cell.add(punit.getName());
    cell.add(sts[i].getQuantity());
    cell.add(sts[i].getCurquantity());
    cell.add(dc.format(sts[i].getUnitprice()));
    cell.add(dc.format(sts[i].getUnitprice().doubleValue()*sts[i].getQuantity().doubleValue()));
    cell.add(source);
    cell.add(account);
    cell.add(isnew);
    cell.add(expdate);
    cell.add(category.getName());
    cell.add(sts[i].getNote());
    cell.add(dc.format(product.getLimitqty()));
    cell.add(room);
    cell.add(complect);
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
