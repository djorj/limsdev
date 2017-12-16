<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
JSONObject msg = new JSONObject();
String sid = "0";
Manager.getInstance().beginTransaction();
try{
    sid = request.getParameter("id");
    String oper = request.getParameter("oper");
    if(oper.equalsIgnoreCase("del")){
        InventoryitemBean ib = InventoryitemManager.getInstance().loadByPrimaryKey(new Long(sid));
        InventoryitemManager.getInstance().deleteByPrimaryKey(ib.getInventoryitemid());
        try{
            if(InventoryitemManager.getInstance().countWhere("where productid = "+ib.getProductid()) == 0)
                ProductManager.getInstance().deleteByPrimaryKey(ib.getProductid());
        }catch(Exception ign){}
    } else if(oper.equalsIgnoreCase("edit")){
        InventoryitemBean ib = InventoryitemManager.getInstance().loadByPrimaryKey(new Long(sid));
        String roomnumber = request.getParameter("room");
        String note = request.getParameter("note");
        String barcode = request.getParameter("barcode");
        if(barcode.trim().length() > 0 && ProductManager.getInstance().countWhere("where productid != "+ib.getProductid()+" and code = '"+barcode+"'") > 0)
            throw new Exception(trs.t("ასეთი ბარკოდი უკვე გამოყენებულია!"));
        double realamount = Double.parseDouble(request.getParameter("realamount"));
        int ownerid = Integer.parseInt(request.getParameter("ownerid"));
        String brandname = request.getParameter("brandname");
        String model = request.getParameter("model");
        String serialnum = request.getParameter("serialnum");
        
        int productgroupid = Integer.parseInt(request.getParameter("productgroupid"));
        String invnum = request.getParameter("invnum");
        String productname = request.getParameter("productname");
        int punitid = Integer.parseInt(request.getParameter("punitid"));
        double amount = Double.parseDouble(request.getParameter("amount"));
        double price = Double.parseDouble(request.getParameter("price"));       
        ib.setPrice(price);
        ib.setAmount(amount);
        
        ib.setRealamount(realamount);
        ib.setNote(note);
        ib.setRoomnumber(roomnumber);
        
        if(ownerid > 0)
            ib.setOwnerid(ownerid);
        else
            ib.setOwnerid(null);
        
        ProductBean pr = ProductManager.getInstance().loadByPrimaryKey(ib.getProductid());
        if(!pr.getName().equalsIgnoreCase(productname)){
            pr = ProductManager.getInstance().createProductBean();
            pr.setName(productname);
        }
        pr.setInvnumber(invnum);
        pr.setProductgroupid(productgroupid);
        pr.setPunitid(punitid);
        pr.setCode(barcode.trim());
        pr.setBrandname(brandname);
        pr.setModel(model);
        pr.setSerialnum(serialnum);
        pr = ProductManager.getInstance().save(pr);
        if(ib.getProductid().longValue() != pr.getProductid().longValue())
            ib.setProductid(pr.getProductid());
        ib = InventoryitemManager.getInstance().save(ib);
    } else if(oper.equalsIgnoreCase("add")){
        InventoryitemBean ib = InventoryitemManager.getInstance().createInventoryitemBean();
        ib.setInventoryid(new Integer(request.getParameter("invid")));
        String roomnumber = request.getParameter("room");
        String note = request.getParameter("note");
        String barcode = request.getParameter("barcode");
        if(barcode.trim().length() > 0 && ProductManager.getInstance().countWhere("where code = '"+barcode+"'") > 0)
            throw new Exception(trs.t("ასეთი ბარკოდი უკვე გამოყენებულია!"));
        double realamount = Double.parseDouble(request.getParameter("realamount"));
        int ownerid = Integer.parseInt(request.getParameter("ownerid"));
        String brandname = request.getParameter("brandname");
        String model = request.getParameter("model");
        String serialnum = request.getParameter("serialnum");
        
        int productgroupid = Integer.parseInt(request.getParameter("productgroupid"));
        String invnum = request.getParameter("invnum");
        String productname = request.getParameter("productname");
        int punitid = Integer.parseInt(request.getParameter("punitid"));
        double amount = Double.parseDouble(request.getParameter("amount"));
        double price = Double.parseDouble(request.getParameter("price"));       
        ib.setPrice(price);
        ib.setAmount(amount);
        
        ib.setRealamount(realamount);
        ib.setNote(note);
        ib.setRoomnumber(roomnumber);
        
        if(ownerid > 0)
            ib.setOwnerid(ownerid);
        else
            ib.setOwnerid(null);
        
        ProductBean pr = ProductManager.getInstance().createProductBean();
        pr.setName(productname);
        pr.setInvnumber(invnum);
        pr.setProductgroupid(productgroupid);
        pr.setPunitid(punitid);
        pr.setCode(barcode.trim());
        pr.setBrandname(brandname);
        pr.setModel(model);
        pr.setSerialnum(serialnum);
        pr = ProductManager.getInstance().save(pr);
        
        ib.setProductid(pr.getProductid());
        ib = InventoryitemManager.getInstance().save(ib);
    } else if(oper.equalsIgnoreCase("move")){
        InventoryitemBean ibold = InventoryitemManager.getInstance().loadByPrimaryKey(new Long(sid));
        InventoryitemBean ib = InventoryitemManager.getInstance().createInventoryitemBean();
        String roomnumber = request.getParameter("roomnumber");
        String note = request.getParameter("note");
        String barcode = request.getParameter("barcode");
        if(barcode.trim().length() > 0 && ProductManager.getInstance().countWhere("where productid != "+ib.getProductid()+" and code = '"+barcode+"'") > 0)
            throw new Exception(trs.t("ასეთი ბარკოდი უკვე გამოყენებულია!"));
        double realamount = Double.parseDouble(request.getParameter("realamount"));
        int ownerid = Integer.parseInt(request.getParameter("ownerid"));
        ib.setRealamount(realamount);
        ib.setNote(note);
        ib.setRoomnumber(roomnumber);
        if(ownerid > 0)
            ib.setOwnerid(ownerid);
        else
            ib.setOwnerid(null);
        ProductBean pr = ProductManager.getInstance().loadByPrimaryKey(ibold.getProductid());
        pr.setCode(barcode.trim());
        pr = ProductManager.getInstance().save(pr);
        
        ib.setAmount(0);
        ib.setInventoryid(new Integer(request.getParameter("inventoryid")));
        ib.setLocation("");
        ib.setPrice(ibold.getPrice());
        ib.setProductid(ibold.getProductid());
        ib.setResponsibleid(ibold.getResponsibleid());
        ib = InventoryitemManager.getInstance().save(ib);
        ibold.setMoveinventoryitemid(ib.getInventoryitemid());
        ibold = InventoryitemManager.getInstance().save(ibold);
    } else if(oper.equalsIgnoreCase("quickedit")){
        InventoryitemBean ib = InventoryitemManager.getInstance().loadByPrimaryKey(new Long(sid));
        ProductBean product = ProductManager.getInstance().loadByPrimaryKey(ib.getProductid());
        //if(product.getCode() != null && product.getCode().trim().length() > 0)
        //    throw new Exception(trs.t("პროდუქტს ბარკოდი უკვე აქვს მინიჭებული!"));
        String roomnumber = request.getParameter("room");
        String barcode = request.getParameter("barcode");
        if(barcode.trim().length() > 0 && ProductManager.getInstance().countWhere("where productid != "+ib.getProductid()+" and code = '"+barcode+"'") > 0)
            throw new Exception(trs.t("ასეთი ბარკოდი უკვე გამოყენებულია სხვა პროდუქტზე!"));
        double realamount = Double.parseDouble(request.getParameter("realamount"));
        int ownerid = Integer.parseInt(request.getParameter("ownerid"));
        ib.setRealamount(realamount);
        ib.setRoomnumber(roomnumber);
        String owner = "";
        if(ownerid > 0) {
            ib.setOwnerid(ownerid);
            PersonellBean ow = PersonellManager.getInstance().loadByPrimaryKey(ownerid);
            owner = ow.getFname()+" "+ow.getLname();
        } else
            ib.setOwnerid(null);
        //if(barcode.trim().length() > 0){
            ProductBean pr = ProductManager.getInstance().loadByPrimaryKey(ib.getProductid());
            pr.setCode(barcode.trim());
            pr = ProductManager.getInstance().save(pr);
        //}
        ib = InventoryitemManager.getInstance().save(ib);
        msg.put("owner", owner);
    }
    
    Manager.getInstance().endTransaction(true);
    msg.put("result", 1);
    msg.put("id", sid);
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    msg.put("result", 0);
    msg.put("error", e.getMessage());
}
out.print(msg.toString());
out.flush();
%>
