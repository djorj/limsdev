<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%@page import="sun.misc.BASE64Decoder" %>
<%
JSONObject res = new JSONObject();
Manager.getInstance().beginTransaction();
try{
    InventoryBean inv = InventoryManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
    String location = request.getParameter("location");
    String bcode = request.getParameter("bcode");
    String note = request.getParameter("note");
    double amount = Double.parseDouble(request.getParameter("amount"));
    long itemid = Long.parseLong(request.getParameter("itemid"));
    int ownerid = Integer.parseInt(request.getParameter("responsibleid"));
    double price = 0;
    try{
        price = Double.parseDouble(request.getParameter("price"));
    }catch(Exception ign){}
    int responsibleid = Integer.parseInt(request.getParameter("responsibleid"));
    
    ProductBean[] product = ProductManager.getInstance().loadByWhere("where code = '"+bcode.trim().replaceAll("'", "''") +"'");
    if(product.length == 0)
        product = ProductManager.getInstance().loadByWhere("where invnumber = '"+bcode.trim().replaceAll("'", "''") +"'");
    if(product.length == 0)
        throw new Exception(trs.t("არასწორი ბარკოდი ან ინვენტარიზაციის ნომერი"));
    
    InventoryitemBean item = InventoryitemManager.getInstance().createInventoryitemBean();
    if(itemid > 0)
        item = InventoryitemManager.getInstance().loadByPrimaryKey(itemid);
    else
        item.setAmount(amount);
    item.setRealamount(amount);
    item.setInventoryid(inv.getInventoryid());
    item.setNote(note);
    item.setPrice(price);
    item.setProductid(product[0].getProductid());
    item.setNote("");
    item.setRoomnumber(location);
    if(ownerid > 0) item.setOwnerid(ownerid);
    else            item.setOwnerid(null);
    item = InventoryitemManager.getInstance().save(item);
    
    Manager.getInstance().endTransaction(true);
    res.put("result",1);
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>
