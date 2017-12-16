<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/elements/getbarcode.jsp">
    <jsp:param name="w" value="350"></jsp:param>
    <jsp:param name="h" value="150"></jsp:param>
    <jsp:param name="code" value="123456789"></jsp:param>
</jsp:include>