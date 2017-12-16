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
        MenuBean menu = MenuManager.getInstance().loadByPrimaryKey(new Integer(sid));
        if(MenuManager.getInstance().countWhere("where parentid = "+menu.getMenuid()) > 0)
            throw new Exception(trs.t("ჯერ წაშალეთ ქვემენიუ(ები)"));
        PlevelManager.getInstance().deleteByMenuid(menu.getMenuid());
        MenuManager.getInstance().deleteByPrimaryKey(menu.getMenuid());
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        MenuBean menu = MenuManager.getInstance().loadByPrimaryKey(new Integer(sid));
        
        String name=request.getParameter("name").trim();
        String fname=request.getParameter("file").trim();
        String icon=request.getParameter("iconname").trim();
        int ord = Integer.parseInt(request.getParameter("ord").trim());
        int parentid = Integer.parseInt(request.getParameter("parentid").trim());
        if(name.length() == 0)  throw new Exception(trs.t("მენიუს დასახელება ცარიელია!"));
        String sql = "where companyid = "+user.getCompanyid()+" and menuid != "+sid+" and upper(name) = '"+name.toUpperCase().replaceAll("'", "''") +"' ";
        if(parentid > 0)    sql += "and parentid = "+parentid;
        else                sql += "and parentid is null";
        if(MenuManager.getInstance().countWhere(sql) > 0)
            throw new Exception(trs.t("მენიუს დასახელება უკვე არსებობს!"));
        menu.setName(name);
        menu.setFile(fname);
        menu.setIcon(icon);
        menu.setOrd(ord);
        if(parentid > 0)    menu.setParentid(parentid);
        else                menu.setParentid(null);
        menu.setCompanyid(user.getCompanyid());
        menu = MenuManager.getInstance().save(menu);
        
    } else if(oper.equalsIgnoreCase("add")){
        String name=request.getParameter("name").trim();
        String fname=request.getParameter("file").trim();
        String icon=request.getParameter("iconname").trim();
        int parentid = Integer.parseInt(request.getParameter("parentid").trim());
        int ord = Integer.parseInt(request.getParameter("ord").trim());
        
        if(name.length() == 0)  throw new Exception(trs.t("მენიუს დასახელება ცარიელია!"));
        String sql = "where companyid = "+user.getCompanyid()+" and upper(name) = '"+name.toUpperCase().replaceAll("'", "''") +"' ";
        if(parentid > 0)    sql += "and parentid = "+parentid;
        else                sql += "and parentid is null";
        if(MenuManager.getInstance().countWhere(sql) > 0)
            throw new Exception(trs.t("მენიუს დასახელება უკვე არსებობს!"));
        MenuBean menu = MenuManager.getInstance().createMenuBean();
        menu.setName(name);
        menu.setFile(fname);
        menu.setIcon(icon);
        menu.setOrd(ord);
        if(parentid > 0)    menu.setParentid(parentid);
        else                menu.setParentid(null);
        menu.setCompanyid(user.getCompanyid());
        
        menu = MenuManager.getInstance().save(menu);
        sid = menu.getMenuid().toString();
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

