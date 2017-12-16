<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String where = "where productid > 0";

if(request.getParameter("_search") != null && request.getParameter("_search").equalsIgnoreCase("true")){
    String code = request.getParameter("code");
    if(code == null)   code = "";
    code = code.trim().replaceAll("'", "''");
    if(code.length() > 0)  where += " and code = '"+code+"'";
    String name = request.getParameter("name");
    if(name == null)   name = "";
    name = name.trim().toUpperCase().replaceAll("'", "''");
    if(name.length() > 0)  where += " and upper(name) like '%"+name+"%'";
    
    String note = request.getParameter("note");
    if(note == null)   note = "";
    note = note.trim().toUpperCase().replaceAll("'", "''");
    if(note.length() > 0)  where += " and productid in (select i.productid from inventoryitem i, inventory t where i.inventoryid = t.inventoryid and upper(i.note) like '%"+note+"%' order by t.startdate desc limit 1)";
    
    String room = request.getParameter("room");
    if(room == null)   room = "";
    room = room.trim().toUpperCase().replaceAll("'", "''");
    if(room.length() > 0)  where += " and productid in (select i.productid from inventoryitem i, inventory t where i.inventoryid = t.inventoryid and upper(i.roomname) like '%"+room+"%' order by t.startdate desc limit 1)";
    
    int punitid = Integer.parseInt(request.getParameter("punitid"));
    if(punitid > 0) where += " and punitid = "+punitid;
    int productgroupid = Integer.parseInt(request.getParameter("productgroupid"));
    if(productgroupid > 0)  where += " and productgroupid = "+productgroupid;
    int categoryid = Integer.parseInt(request.getParameter("categoryid"));
    if(categoryid > 0)  where += " and productgroupid = "+categoryid;
    
    int sourcetypeid = Integer.parseInt(request.getParameter("sourcetypeid"));
    int isnew = Integer.parseInt(request.getParameter("isnew"));
    String expdate = request.getParameter("expdate");
    String indate = request.getParameter("indate");
    
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


int count = ProductManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord+", productid";

ProductBean[] products = ProductManager.getInstance().loadByWhere(where+" "+order+" "+limit);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<products.length;i++){
    String invnum = "";
    String invtype = "";
    String invdate = "";
    PunitBean punit = PunitManager.getInstance().loadByPrimaryKey(products[i].getPunitid());
    double inamount = 0;
    double curamount = 0;
    double price = 0;
    String srcname = "";
    String secondary = "";
    String expdate = "";
    if(products[i].getExp1() != null){
        long indate = 0;
        long lexpdate = indate + products[i].getExp1().longValue();
        expdate = dt.format(new Date(lexpdate));
    }
    String room = "";
    String note = "";
    ProductgroupBean prg = ProductgroupManager.getInstance().loadByPrimaryKey(products[i].getProductgroupid());
    InventoryitemBean[] item = InventoryitemManager.getInstance().loadByWhere("where productid = "+products[i].getProductid()+" and inventoryid in (select inventoryid from inventory order by startdate desc limit 1) limit 1");
    if(item.length > 0){
        room = (item[0].getRoomnumber() != null) ? item[0].getRoomnumber():"";
        note = (item[0].getNote() != null) ? item[0].getNote():"";
        curamount = item[0].getRealamount().doubleValue();
    }
    JSONObject ob = new JSONObject();
    ob.put("id",products[i].getProductid());
    JSONArray cell = new JSONArray();
    cell.add(products[i].getCode());
    cell.add(invnum);
    cell.add(invdate);
    cell.add(trs.t(products[i].getName()));
    cell.add(trs.t(punit.getName()));
    cell.add(dc.format(inamount));
    cell.add(dc.format(curamount));
    cell.add(dc.format(price));
    cell.add(dc.format(price*curamount));
    cell.add(srcname);
    cell.add(prg.getCode());
    cell.add(secondary);
    cell.add(expdate);
    cell.add(prg.getName());
    cell.add(note);
    
    cell.add(dc.format(products[i].getLimitqty()));
    cell.add(room);
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
