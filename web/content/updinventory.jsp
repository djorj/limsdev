<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
JSONObject res = new JSONObject();
String sid = "0";
String oper = request.getParameter("oper");
Manager.getInstance().beginTransaction();
try{
    if(oper.equalsIgnoreCase("del")){
        sid = request.getParameter("id");
        InventoryBean ptp = InventoryManager.getInstance().loadByPrimaryKey(new Integer(sid));
        if(ptp.getEnddate() != null)
            throw new Exception(trs.t("ინვენტარიზაცია დახურულია - წაშლა შეუძლებელია!"));
        ProductBean[] prods = ProductManager.getInstance().loadByWhere("where productid in (select productid from inventoryitem where inventoryid = "+sid+")");
        InventoryitemManager.getInstance().deleteByInventoryid(ptp.getInventoryid());
        InventoryManager.getInstance().deleteByPrimaryKey(ptp.getInventoryid());
        for(int i=0;i<prods.length;i++){
            if(!checkProductUsage(prods[i].getProductid().intValue()))
                ProductManager.getInstance().deleteByPrimaryKey(prods[i].getProductid());
        }
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        InventoryBean ptp = InventoryManager.getInstance().loadByPrimaryKey(new Integer(sid));
        if(ptp.getEnddate() != null)
            throw new Exception(trs.t("ინვენტარიზაცია დახურულია - რედაქტირება შეუძლებელია!"));
        Date inventorydate = dtlong.parse(request.getParameter("inventorydate").trim());
        int institutionid = Integer.parseInt(request.getParameter("institutionid"));
        
        if(InventoryManager.getInstance().countWhere("where inventoryid != "+ptp.getInventoryid()+" and institutionid = "+institutionid+" and enddate is not null and enddate >= to_timestamp('"+dtlong.format(inventorydate)+"','DD/MM/YYYY HH24:MI')") > 0)
            throw new Exception(trs.t("აღწერის დაწყების თარიღი ფარავს ძველი აღწერის თარიღს!"));
        if(InventoryManager.getInstance().countWhere("where inventoryid != "+ptp.getInventoryid()+" and institutionid = "+institutionid+" and enddate is null") > 0)
            throw new Exception(trs.t("ძველი აღწერა არაა დასრულებული!"));
        ptp.setStartdate(inventorydate.getTime());
        ptp.setInstitutionid(institutionid);
        ptp.setRegbyid(user.getPersonellid());
        
        ptp = InventoryManager.getInstance().save(ptp);
        
    } else if(oper.equalsIgnoreCase("add")){
        InventoryBean ptp = InventoryManager.getInstance().createInventoryBean();
        
        Date inventorydate = dtlong.parse(request.getParameter("inventorydate").trim());
        int institutionid = Integer.parseInt(request.getParameter("institutionid"));
        
        if(InventoryManager.getInstance().countWhere("where institutionid = "+institutionid+" and enddate is not null and enddate >= to_timestamp('"+dtlong.format(inventorydate)+"','DD/MM/YYYY HH24:MI')") > 0)
            throw new Exception(trs.t("აღწერის დაწყების თარიღი ფარავს ძველი აღწერის თარიღს!"));
        if(InventoryManager.getInstance().countWhere("where institutionid = "+institutionid+" and enddate is null") > 0)
            throw new Exception(trs.t("ძველი აღწერა არაა დასრულებული!"));
        ptp.setStartdate(inventorydate.getTime());
        ptp.setInstitutionid(institutionid);
        ptp.setRegbyid(user.getPersonellid());
        
        ptp = InventoryManager.getInstance().save(ptp);
        sid = ptp.getInventoryid().toString();
    } else if(oper.equalsIgnoreCase("close")){
        sid = request.getParameter("id");
        InventoryBean ptp = InventoryManager.getInstance().loadByPrimaryKey(new Integer(sid));
        if(ptp.getEnddate() != null)
            throw new Exception(trs.t("ინვენტარიზაცია უკვე დახურულია!"));
        ptp.setEnddate(new Date().getTime());
        ptp = InventoryManager.getInstance().save(ptp);
    }

    Manager.getInstance().endTransaction(true);
    res.put("result",1);
    res.put("id",sid);
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>
