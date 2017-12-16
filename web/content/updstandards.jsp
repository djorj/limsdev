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
        StandardManager.getInstance().deleteByPrimaryKey(new Integer(sid));
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        StandardBean ptp = StandardManager.getInstance().loadByPrimaryKey(new Integer(sid));
        
        String name = request.getParameter("name").trim();
        String description = request.getParameter("description").trim();
        int certid = Integer.parseInt(request.getParameter("certificateid"));
        
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        if(StandardManager.getInstance().countWhere("where standardid != "+sid+" and upper(name) = '"+name.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("სტანდარტი სახელით ~NAME~ უკვე არსებობს!",name));
        if(certid > 0)  ptp.setCertificateid(certid);
        else            ptp.setCertificateid(null);
        ptp.setDescription(description);
        ptp.setName(name);
        ptp = StandardManager.getInstance().save(ptp);
        
    } else if(oper.equalsIgnoreCase("add")){
        StandardBean ptp = StandardManager.getInstance().createStandardBean();
        
        String name = request.getParameter("name").trim();
        String description = request.getParameter("description").trim();
        int certid = Integer.parseInt(request.getParameter("certificateid"));
        
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        if(StandardManager.getInstance().countWhere("where upper(name) = '"+name.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("სტანდარტი სახელით ~NAME~ უკვე არსებობს!",name));
        if(certid > 0)  ptp.setCertificateid(certid);
        else            ptp.setCertificateid(null);
        ptp.setDescription(description);
        ptp.setName(name);
        ptp = StandardManager.getInstance().save(ptp);
        sid = ptp.getStandardid().toString();
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
