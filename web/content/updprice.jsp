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
        PriceBean pr = PriceManager.getInstance().loadByPrimaryKey(new Integer(sid));
        PriceManager.getInstance().deleteByPrimaryKey(pr.getPriceid());
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        
        PriceBean pr = PriceManager.getInstance().loadByPrimaryKey(new Integer(sid));
        
        Date pricedate=dt.parse(request.getParameter("pricedate"));
        String reason=request.getParameter("reason").trim();
        double price = Double.parseDouble(request.getParameter("price"));
        
        pr.setLabtestid(labtestid);
        pr.setPrice(price);
        pr.setPricedate(pricedate);
        pr.setReason(reason);
        pr = PriceManager.getInstance().save(pr);
        
    } else if(oper.equalsIgnoreCase("add")){
        
        PriceBean pr = PriceManager.getInstance().createPriceBean();
        
        Date pricedate=dt.parse(request.getParameter("pricedate"));
        String reason=request.getParameter("reason").trim();
        double price = Double.parseDouble(request.getParameter("price"));
        
        pr.setLabtestid(labtestid);
        pr.setPrice(price);
        pr.setPricedate(pricedate);
        pr.setReason(reason);
        pr = PriceManager.getInstance().save(pr);
        sid = pr.getPriceid().toString();
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

