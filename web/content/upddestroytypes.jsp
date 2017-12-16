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
        DestroymethodManager.getInstance().deleteByPrimaryKey(new Integer(sid));
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        DestroymethodBean ptp = DestroymethodManager.getInstance().loadByPrimaryKey(new Integer(sid));
        
        String name = request.getParameter("name").trim();
        
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        if(DestroymethodManager.getInstance().countWhere("where destroymethodid != "+sid+" and upper(name) = '"+name.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("განადგურების მეთოდი სახელით ~NAME~ უკვე არსებობს!",name));
        
        ptp.setName(name);
        ptp = DestroymethodManager.getInstance().save(ptp);
        
    } else if(oper.equalsIgnoreCase("add")){
        DestroymethodBean ptp = DestroymethodManager.getInstance().createDestroymethodBean();
        
        String name = request.getParameter("name").trim();
        
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        if(DestroymethodManager.getInstance().countWhere("where upper(name) = '"+name.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("განადგურების მეთოდი სახელით ~NAME~ უკვე არსებობს!",name));
        
        ptp.setName(name);
        ptp = DestroymethodManager.getInstance().save(ptp);
        sid = ptp.getDestroymethodid().toString();
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
