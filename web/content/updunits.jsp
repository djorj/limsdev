<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%
JSONObject res = new JSONObject();
String sid = "0";
String oper = request.getParameter("oper");
Manager.getInstance().beginTransaction();
try{
    long productid = Long.parseLong(request.getParameter("productid"));
    if(oper.equalsIgnoreCase("del")){
        sid = request.getParameter("id");
        ProductunitManager.getInstance().deleteByPrimaryKey(productid, new Integer(sid));
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        
        ProductunitBean pr = ProductunitManager.getInstance().loadByPrimaryKey(productid, new Integer(sid));
        if(pr == null){
            pr = ProductunitManager.getInstance().createProductunitBean();
            pr.setProductid(productid);
            pr.setPunitid(new Integer(sid));
        }
        
        double amount = Double.parseDouble(request.getParameter("amount"));
        
        pr.setAmount(amount);
        pr = ProductunitManager.getInstance().save(pr);
        
    } else if(oper.equalsIgnoreCase("add")){
        
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

