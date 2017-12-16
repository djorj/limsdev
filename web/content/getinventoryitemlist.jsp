<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String where = "where inventoryid = "+request.getParameter("id");

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
    
    int productgroupid = Integer.parseInt(request.getParameter("productgroupid"));
    if(productgroupid > 0)
        where += " and productid in (select productid from product where productgroupid = "+productgroupid+")";
    
    int productgroup = Integer.parseInt(request.getParameter("productgroup"));
    if(productgroup > 0)
        where += " and productid in (select productid from product where productgroupid = "+productgroup+")";
    
    String invnum = request.getParameter("invnum");
    if(invnum == null)   invnum = "";
    invnum = invnum.trim().toUpperCase().replaceAll("'", "''");
    if(invnum.length() > 0)  where += " and productid in (select productid from product where upper(invnumber) like '%"+invnum+"%')";
    
    String barcode = request.getParameter("barcode");
    if(barcode == null)   barcode = "";
    barcode = barcode.trim().toUpperCase().replaceAll("'", "''");
    if(barcode.length() > 0)  where += " and productid in (select productid from product where upper(code) like '%"+barcode+"%')";
    
    String productname = request.getParameter("productname");
    if(productname == null)   productname = "";
    productname = productname.trim().toUpperCase().replaceAll("'", "''");
    if(productname.length() > 0)  where += " and productid in (select productid from product where upper(name) like '%"+productname+"%')";
    
    
    int punitid = Integer.parseInt(request.getParameter("punitid"));
    if(punitid > 0)
        where += " and productid in (select productid from product where punitid = "+punitid+")";
    
    int ownerid = Integer.parseInt(request.getParameter("ownerid"));
    if(ownerid > 0)
        where += " and ownerid = "+ownerid;
    
    String roomnumber = request.getParameter("room");
    if(roomnumber == null)   roomnumber = "";
    roomnumber = roomnumber.trim().toUpperCase().replaceAll("'", "''");
    if(roomnumber.length() > 0)  where += " and upper(roomnumber) like '%"+roomnumber+"%'";
    
    String note = request.getParameter("note");
    if(note == null)   note = "";
    note = note.trim().toUpperCase().replaceAll("'", "''");
    if(note.length() > 0)  where += " and upper(note) like '%"+note+"%'";
}

int count = InventoryitemManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by ";

if(sidx.equals("productgroupid"))   order += "(select r.code from productgroup r, product p where p.productgroupid = r.productgroupid and p.productid = inventoryitem.productid limit 1)";
else if(sidx.equals("productgroup"))   order += "(select r.name from productgroup r, product p where p.productgroupid = r.productgroupid and p.productid = inventoryitem.productid limit 1)";
else if(sidx.equals("invnum"))   order += "(select invnumber from product where productid = inventoryitem.productid limit 1)";
else if(sidx.equals("barcode"))   order += "(select code from product where productid = inventoryitem.productid limit 1)";
else if(sidx.equals("productname"))   order += "(select name from product where productid = inventoryitem.productid limit 1)";
else if(sidx.equals("punitid"))   order += "(select r.name from punit r, product p where p.punitid = r.punitid and p.productid = inventoryitem.productid limit 1)";
else if(sidx.equals("amount"))   order += "amount";
else if(sidx.equals("realamount"))   order += "realamount";
else if(sidx.equals("price"))   order += "price";
else if(sidx.equals("roomnumber"))   order += "roomnumber";
else if(sidx.equals("note"))   order += "note";
else if(sidx.equals("ownerid"))   order += "ownerid";
else order += sidx;

order += " "+sord+", inventoryitemid";

System.out.println(order);
//String order = "order by (select code from product where productid = inventoryitem.productid limit 1), inventoryitemid";

InventoryitemBean[] invs = InventoryitemManager.getInstance().loadByWhere(where+" "+order+" "+limit);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<invs.length;i++){
    ProductBean pr = ProductManager.getInstance().loadByPrimaryKey(invs[i].getProductid());
    ProductgroupBean prg = ProductgroupManager.getInstance().loadByPrimaryKey(pr.getProductgroupid());
    PunitBean punit = PunitManager.getInstance().loadByPrimaryKey(pr.getPunitid());
    String owner = "";
    if(invs[i].getOwnerid() != null){
        PersonellBean pers = PersonellManager.getInstance().loadByPrimaryKey(invs[i].getOwnerid());
        owner = pers.getFname()+" "+pers.getLname();
    }
    JSONObject ob = new JSONObject();
    ob.put("id",invs[i].getInventoryitemid());
    JSONArray cell = new JSONArray();
    cell.add(prg.getCode());
    cell.add(trs.t(prg.getName()));
    cell.add(pr.getInvnumber().replaceAll("\\.0", ""));
    cell.add((pr.getCode() == null) ? "":pr.getCode());
    cell.add(trs.t(pr.getName()));
    
    cell.add((pr.getBrandname() != null) ? trs.t(pr.getBrandname()):"");
    cell.add((pr.getModel() != null) ? trs.t(pr.getModel()):"");
    cell.add((pr.getSerialnum() != null) ? trs.t(pr.getSerialnum()):"");
    
    cell.add(trs.t(punit.getName()));
    cell.add(dc.format(invs[i].getAmount()));
    cell.add(dc.format(invs[i].getRealamount()));
    cell.add(dc.format(invs[i].getPrice()));
    cell.add((invs[i].getRoomnumber() != null) ? trs.t(invs[i].getRoomnumber()):"");
    cell.add(trs.t(owner));
    cell.add(trs.t(invs[i].getNote()));
    cell.add((invs[i].getOwnerid() != null) ? invs[i].getOwnerid():0);
    cell.add((invs[i].getMoveinventoryitemid() != null) ? invs[i].getMoveinventoryitemid():0);
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
