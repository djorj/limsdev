<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="sun.misc.BASE64Decoder" %>
<%@include file="includes/init.jsp"%>
<%=PasswordService.getInstance().encrypt(request.getParameter("pass"))%>