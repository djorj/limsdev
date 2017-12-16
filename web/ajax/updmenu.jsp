<%@page contentType="text/html; charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%
SimpleDateFormat sdt0 = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat sdt1 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
String msg = "";

String sid = "0";
String oper = request.getParameter("oper");
Manager.getInstance().beginTransaction();
try{
    if(oper.equalsIgnoreCase("del")){
        sid = request.getParameter("id");
        MenuBean menu = MenuManager.getInstance().loadByPrimaryKey(new Integer(sid));
        if(MenuManager.getInstance().countWhere("where parentid = "+menu.getMenuid()) > 0)
            throw new Exception("ჯერ წაშალეთ ქვემენიუ(ები)");
        PlevelManager.getInstance().deleteByMenuid(menu.getMenuid());
        MenuManager.getInstance().deleteByPrimaryKey(menu.getMenuid());
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        MenuBean menu = MenuManager.getInstance().loadByPrimaryKey(new Integer(sid));
        
        String name=request.getParameter("name").trim();
        String fname=request.getParameter("file").trim();
        int ord = Integer.parseInt(request.getParameter("ord").trim());
        int parentid = Integer.parseInt(request.getParameter("parentid").trim());
        if(name.length() == 0)  throw new Exception("მენიუს დასახელება ცარიელია!");
        String sql = "where menuid != "+sid+" and upper(name) = '"+name.toUpperCase().replaceAll("'", "''") +"' ";
        if(parentid > 0)    sql += "and parentid = "+parentid;
        else                sql += "and parentid is null";
        if(MenuManager.getInstance().countWhere(sql) > 0)
            throw new Exception("მენიუს დასახელება უკვე არსებობს!");
        menu.setName(name);
        menu.setFile(fname);
        menu.setOrd(ord);
        if(parentid > 0)    menu.setParentid(parentid);
        else                menu.setParentid(null);
        menu = MenuManager.getInstance().save(menu);
        
    } else if(oper.equalsIgnoreCase("add")){
        String name=request.getParameter("name").trim();
        String fname=request.getParameter("file").trim();
        int parentid = Integer.parseInt(request.getParameter("parentid").trim());
        int ord = Integer.parseInt(request.getParameter("ord").trim());
        
        if(name.length() == 0)  throw new Exception("მენიუს დასახელება ცარიელია!");
        String sql = "where upper(name) = '"+name.toUpperCase().replaceAll("'", "''") +"' ";
        if(parentid > 0)    sql += "and parentid = "+parentid;
        else                sql += "and parentid is null";
        if(MenuManager.getInstance().countWhere(sql) > 0)
            throw new Exception("მენიუს დასახელება უკვე არსებობს!");
        MenuBean menu = MenuManager.getInstance().createMenuBean();
        menu.setName(name);
        menu.setFile(fname);
        menu.setOrd(ord);
        if(parentid > 0)    menu.setParentid(parentid);
        else                menu.setParentid(null);

        
        menu = MenuManager.getInstance().save(menu);
        sid = menu.getMenuid().toString();
    }

    Manager.getInstance().endTransaction(true);
    msg = "{\"result\":1,\"id\":"+sid+"}";
}catch(Exception e){Manager.getInstance().endTransaction(false);e.printStackTrace();msg = "{\"result\":0,\"error\":\""+e.getMessage().replaceAll("\n"," ").replaceAll("\"", "\\\\\"")+"\"}"; e.printStackTrace();}
%>
<%=msg%>
