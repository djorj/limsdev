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
        PunitBean ptp = PunitManager.getInstance().loadByPrimaryKey(new Integer(sid));
        if(ProductManager.getInstance().countWhere("where punitid = "+ptp.getPunitid()) > 0)
            throw new Exception(trs.t("ჯერ წაშალეთ შესაბამისი პროდუქტი"));
        PunitManager.getInstance().deleteByPrimaryKey(ptp.getPunitid());
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        PunitBean ptp = PunitManager.getInstance().loadByPrimaryKey(new Integer(sid));
        
        String name=request.getParameter("name").trim();
        String fullname=request.getParameter("fullname").trim();
        
        if(name.length() == 0)  throw new Exception(trs.t("ერთეულის შემოკლებული დასახელება ცარიელია!"));
        if(fullname.length() == 0)  throw new Exception(trs.t("ერთეულის დასახელება ცარიელია!"));
        if(PunitManager.getInstance().countWhere("where punitid != "+sid+" and upper(name) = '"+name.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("ერთეული შემოკლებული დასახელებით ~NAME~ უკვე არსებობს!",name));
        if(PunitManager.getInstance().countWhere("where punitid != "+sid+" and upper(fullname) = '"+fullname.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("ერთეული დასახელებით ~NAME~ უკვე არსებობს!",name));
        
        ptp.setName(name);
        ptp.setFullname(fullname);
        ptp = PunitManager.getInstance().save(ptp);
        
    } else if(oper.equalsIgnoreCase("add")){
        PunitBean ptp = PunitManager.getInstance().createPunitBean();
        String name=request.getParameter("name").trim();
        String fullname=request.getParameter("fullname").trim();
        if(name.length() == 0)  throw new Exception(trs.t("ერთეულის შემოკლებული დასახელება ცარიელია!"));
        if(fullname.length() == 0)  throw new Exception(trs.t("ერთეულის დასახელება ცარიელია!"));
        if(PunitManager.getInstance().countWhere("where upper(name) = '"+name.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("ერთეული შემოკლებული დასახელებით ~NAME~ უკვე არსებობს!",name));
        if(PunitManager.getInstance().countWhere("where upper(fullname) = '"+fullname.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("ერთეული დასახელებით ~NAME~ უკვე არსებობს!",name));
        ptp.setName(name);
        ptp.setFullname(fullname);
        ptp = PunitManager.getInstance().save(ptp);
        sid = ptp.getPunitid().toString();
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
