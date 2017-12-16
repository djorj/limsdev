<%-- 
    Document   : service
    Created on : Nov 22, 2014, 3:24:54 PM
    Author     : Gocha Tortladze
--%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>

<%
    String id=request.getParameter("id");
    String num=request.getParameter("num");
    pageContext.setAttribute("id",id);
    pageContext.setAttribute("num",num);
%>
<jsp:include page="/elements/getbarcode.jsp">
    <jsp:param name="w" value="350"></jsp:param>
    <jsp:param name="h" value="150"></jsp:param>
    <jsp:param name="code" value="${id}"></jsp:param>
    <jsp:param name="num" value="${num}"></jsp:param>
</jsp:include>

