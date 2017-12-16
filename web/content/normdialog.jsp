<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
if(labtest.getRestypeid().intValue() == 1){
%>
<jsp:include page="normdialog1.jsp">
    <jsp:param name="id" value="<%=labtest.getLabtestid()%>"></jsp:param>
</jsp:include>
<%}else if(labtest.getRestypeid().intValue() == 2){%>
<jsp:include page="normdialog2.jsp">
    <jsp:param name="id" value="<%=labtest.getLabtestid()%>"></jsp:param>
</jsp:include>
<%}else if(labtest.getRestypeid().intValue() == 3){%>
<jsp:include page="normdialog3.jsp">
    <jsp:param name="id" value="<%=labtest.getLabtestid()%>"></jsp:param>
</jsp:include>
<%}%>
