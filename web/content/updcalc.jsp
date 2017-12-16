<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%

JSONObject res = new JSONObject();
String sid = "0";
String oper = request.getParameter("oper");
Manager.getInstance().beginTransaction();
int labtestid = Integer.parseInt(request.getParameter("labtestid"));
try{
    if(oper.equalsIgnoreCase("del")){
        sid = request.getParameter("id");
        LabtestprodManager.getInstance().deleteByPrimaryKey(labtestid,new Long(sid));
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        
        LabtestprodBean pr = LabtestprodManager.getInstance().loadByPrimaryKey(labtestid,new Long(sid));
        
        double qty = Double.parseDouble(request.getParameter("qty"));
        pr.setQty(qty);
        pr = LabtestprodManager.getInstance().save(pr);
        
    } else if(oper.equalsIgnoreCase("add")){
        
        LabtestprodBean pr = LabtestprodManager.getInstance().createLabtestprodBean();
        
        double qty = Double.parseDouble(request.getParameter("qty"));
        long productid = Long.parseLong(request.getParameter("productid"));
        
        pr.setLabtestid(labtestid);
        pr.setProductid(productid);
        pr.setQty(qty);
        pr = LabtestprodManager.getInstance().save(pr);
        sid = pr.getProductid().toString();
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

