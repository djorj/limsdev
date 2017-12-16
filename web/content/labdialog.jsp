<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    TestcategoryBean testcategory = TestcategoryManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
%>
<div class="smart-form">
    <jsp:include page="labtreec.jsp">
        <jsp:param name="id" value="<%=testcategory.getTestcategoryid()%>"></jsp:param>
    </jsp:include>
</div>