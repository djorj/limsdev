<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%
/*
for(Enumeration e=request.getParameterNames();e.hasMoreElements();){
    String name = (String)e.nextElement();
    String val = request.getParameter(name);
System.out.println(name+" = "+val);
}*/
JSONObject res = new JSONObject();
String sid = "0";
String oper = request.getParameter("oper");
Manager.getInstance().beginTransaction();
try{
    if(oper.equalsIgnoreCase("del")){
        sid = request.getParameter("id");
        InstitutionBean inst = InstitutionManager.getInstance().loadByPrimaryKey(new Integer(sid));
        if(MenuManager.getInstance().countWhere("where parentid = "+inst.getInstitutionid()) > 0)
            throw new Exception(trs.t("ჯერ წაშალეთ ქვედეპარტამენტ(ები)"));
        PlevelManager.getInstance().deleteByMenuid(inst.getInstitutionid());
        InstitutionManager.getInstance().deleteByPrimaryKey(inst.getInstitutionid());
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        InstitutionBean inst = InstitutionManager.getInstance().loadByPrimaryKey(new Integer(sid));
        
        String name=request.getParameter("name").trim();
        String address=request.getParameter("address").trim();
        int parentid = Integer.parseInt(request.getParameter("parentid").trim());
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        String sql = "where companyid = "+user.getCompanyid()+" and institutionid != "+sid+" and upper(name) = '"+name.toUpperCase().replaceAll("'", "''") +"' ";
        if(parentid > 0)    sql += "and parentid = "+parentid;
        else                sql += "and parentid is null";
        if(InstitutionManager.getInstance().countWhere(sql) > 0)
            throw new Exception(trs.t("დასახელება უკვე არსებობს!"));
        inst.setName(name);
        inst.setAddress(address);
        if(parentid > 0)    inst.setParentid(parentid);
        else                inst.setParentid(null);
        inst.setCompanyid(user.getCompanyid());
        inst = InstitutionManager.getInstance().save(inst);
        
    } else if(oper.equalsIgnoreCase("add")){
        String name=request.getParameter("name").trim();
        String address=request.getParameter("address").trim();
        int parentid = Integer.parseInt(request.getParameter("parentid").trim());
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        String sql = "where companyid = "+user.getCompanyid()+" and upper(name) = '"+name.toUpperCase().replaceAll("'", "''") +"' ";
        if(parentid > 0)    sql += "and parentid = "+parentid;
        else                sql += "and parentid is null";
        if(InstitutionManager.getInstance().countWhere(sql) > 0)
            throw new Exception(trs.t("დასახელება უკვე არსებობს!"));
        InstitutionBean inst = InstitutionManager.getInstance().createInstitutionBean();
        inst.setName(name);
        inst.setAddress(address);
        if(parentid > 0)    inst.setParentid(parentid);
        else                inst.setParentid(null);
        inst.setCompanyid(user.getCompanyid());
        
        inst = InstitutionManager.getInstance().save(inst);
        sid = inst.getInstitutionid().toString();
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

