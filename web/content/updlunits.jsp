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
        UnitsManager.getInstance().deleteByPrimaryKey(new Integer(sid));
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        UnitsBean ptp = UnitsManager.getInstance().loadByPrimaryKey(new Integer(sid));
        
        String name = request.getParameter("name").trim();
        
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        if(UnitsManager.getInstance().countWhere("where unitsid != "+sid+" and upper(name) = '"+name.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("ერთეული სახელით ~NAME~ უკვე არსებობს!",name));
        
        ptp.setName(name);
        ptp = UnitsManager.getInstance().save(ptp);
        
    } else if(oper.equalsIgnoreCase("add")){
        UnitsBean ptp = UnitsManager.getInstance().createUnitsBean();
        
        String name = request.getParameter("name").trim();
        
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        if(UnitsManager.getInstance().countWhere("where upper(name) = '"+name.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("ერთეული სახელით ~NAME~ უკვე არსებობს!",name));
        
        ptp.setName(name);
        ptp = UnitsManager.getInstance().save(ptp);
        sid = ptp.getUnitsid().toString();
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
