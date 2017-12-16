<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
JSONObject res = new JSONObject();
Manager.getInstance().beginTransaction();
try{
    InventoryitemBean item = InventoryitemManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("id")));
    if(item.getAmount().doubleValue() <= 1)
        throw new Exception(trs.t("რაოდენობა უნდა იყოს 1-ზე მეტი!"));
    if(item.getAmount().intValue() - item.getAmount().doubleValue() != 0)
        throw new Exception(trs.t("ჩაშაშლელი რაოდენობა უნდა იყოს მთელი რიცხვი!"));
    InventoryitemBean[] items = new InventoryitemBean[item.getAmount().intValue()-1];
    for(int i=0;i<items.length;i++){
        ProductBean product = ProductManager.getInstance().loadByPrimaryKey(item.getProductid());
        ProductBean nproduct = ProductManager.getInstance().createProductBean();
        nproduct.setBrandname(product.getBrandname());
        
        nproduct.setExp1(product.getExp1());
        nproduct.setExp2(product.getExp2());
        nproduct.setInvnumber(product.getInvnumber());
        nproduct.setLimitqty(product.getLimitqty());
        nproduct.setModel(product.getModel());
        nproduct.setName(product.getName());
        nproduct.setProductgroupid(product.getProductgroupid());
        nproduct.setPunitid(product.getPunitid());
        nproduct.setSerialnum("");
        nproduct = ProductManager.getInstance().save(nproduct);
        
        items[i] = InventoryitemManager.getInstance().createInventoryitemBean();
        items[i].setAmount(1);
        items[i].setInventoryid(item.getInventoryid());
        items[i].setLocation(item.getLocation());
        items[i].setMoveinventoryitemid(item.getMoveinventoryitemid());
        items[i].setNote(item.getNote());
        items[i].setOwnerid(item.getOwnerid());
        items[i].setPrice(item.getPrice());
        items[i].setProductid(nproduct.getProductid());
        items[i].setResponsibleid(item.getResponsibleid());
        items[i].setRoomnumber(item.getRoomnumber());
        items[i].setRealamount(0);
        items[i] = InventoryitemManager.getInstance().save(items[i]);
    }
    item.setAmount(1);
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
