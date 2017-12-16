<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
JSONObject res = new JSONObject();
String sid = "0";
String oper = request.getParameter("oper");
Manager.getInstance().beginTransaction();
try{
    int type = Integer.parseInt(request.getParameter("type"));
    if(oper.equalsIgnoreCase("del")){
        sid = request.getParameter("id");
        OperBean opr = OperManager.getInstance().loadByPrimaryKey(new Integer(sid));
        if(StockmovementManager.getInstance().countWhere("where operid = "+opr.getOperid()) > 0)
            throw new Exception(trs.t("ოპერაცია გამოყენებულია - წაშლა შეუძლებელია!"));
        OperManager.getInstance().deleteByPrimaryKey(opr.getOperid());
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        
        OperBean opr = OperManager.getInstance().loadByPrimaryKey(new Integer(sid));
        
        String name=request.getParameter("name").trim();
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        String sql = "where operid != "+sid+" and upper(name) = '"+name.toUpperCase().replaceAll("'", "''") +"' ";
        if(OperManager.getInstance().countWhere(sql) > 0)
            throw new Exception(trs.t("დასახელება უკვე არსებობს!"));
        opr.setName(name);
        opr.setType(type);
        opr = OperManager.getInstance().save(opr);
        
    } else if(oper.equalsIgnoreCase("add")){
        OperBean opr = OperManager.getInstance().createOperBean();
        
        String name=request.getParameter("name").trim();
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        String sql = "where upper(name) = '"+name.toUpperCase().replaceAll("'", "''") +"' ";
        if(OperManager.getInstance().countWhere(sql) > 0)
            throw new Exception(trs.t("დასახელება უკვე არსებობს!"));
        opr.setName(name);
        opr.setType(type);
        opr = OperManager.getInstance().save(opr);
        sid = opr.getOperid().toString();
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

