<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%
for(Enumeration e=request.getParameterNames();e.hasMoreElements();){
    String name = (String)e.nextElement();
    String val = request.getParameter(name);
System.out.println(name+" = "+val);
}
JSONObject res = new JSONObject();
String sid = "0";
String oper = request.getParameter("oper");
Manager.getInstance().beginTransaction();
try{
    if(oper.equalsIgnoreCase("del")){
        sid = request.getParameter("id");
        StockBean stock = StockManager.getInstance().loadByPrimaryKey(new Integer(sid));
        if(StockManager.getInstance().countWhere("where parentid = "+stock.getStockid()) > 0)
            throw new Exception(trs.t("ჯერ წაშალეთ შემავალი საწყობ(ებ)ი"));
        StockManager.getInstance().deleteByPrimaryKey(stock.getStockid());
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        
        StockBean stock = StockManager.getInstance().loadByPrimaryKey(new Integer(sid));
        
        String name=request.getParameter("name").trim();
        if(name.length() == 0)  throw new Exception(trs.t("საწყობის დასახელება ცარიელია!"));
        String sql = "where stockid != "+sid+" and upper(name) = '"+name.toUpperCase().replaceAll("'", "''") +"' ";
        if(StockManager.getInstance().countWhere(sql) > 0)
            throw new Exception(trs.t("საწყობის დასახელება უკვე არსებობს!"));
        stock.setName(name);
        stock = StockManager.getInstance().save(stock);
        
    } else if(oper.equalsIgnoreCase("add")){
        int parentid = 0;
        try{ parentid = Integer.parseInt(request.getParameter("parent")); }catch(Exception ign){}
        StockBean stock = StockManager.getInstance().createStockBean();
        
        String name=request.getParameter("name").trim();
        if(name.length() == 0)  throw new Exception(trs.t("საწყობის დასახელება ცარიელია!"));
        String sql = "where upper(name) = '"+name.toUpperCase().replaceAll("'", "''") +"' ";
        if(parentid > 0)    sql += "and parentid = "+parentid;
        else                sql += "and parentid is null";
        if(MenuManager.getInstance().countWhere(sql) > 0)
            throw new Exception(trs.t("საწყობის დასახელება უკვე არსებობს!"));
        stock.setName(name);
        if(parentid > 0)    stock.setParentid(parentid);
        else                stock.setParentid(null);
        stock = StockManager.getInstance().save(stock);
        sid = stock.getStockid().toString();
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

