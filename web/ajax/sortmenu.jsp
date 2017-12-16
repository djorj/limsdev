<%@page contentType="text/html; charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
String[] neword = request.getParameter("neworder").split(",");
for(int i=0;i<neword.length;i++){
    MenuBean menu = MenuManager.getInstance().loadByPrimaryKey(new Integer(neword[i]));
    menu.setOrd(i);
    menu = MenuManager.getInstance().save(menu);
}
%>
