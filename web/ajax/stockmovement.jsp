<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
%>
<ul id="stockmovementmain" class="nav nav-tabs bordered half">
    <li class="active">
        <a href="#s1" data-toggle="tab"> <%=trs.t("მიღება")%></a>
    </li>
    <li>
        <a href="#s2" data-toggle="tab"> <%=trs.t("გაცემა")%></a>
    </li>
</ul>

<div id="stockmovementmaincontent" class="tab-content padding-10">
    <div class="tab-pane fade in active" id="s1" style="height: calc(100vh - 250px) !important;">
        <jsp:include page="stockmovement1.jsp"></jsp:include>
        </div>
        <div class="tab-pane fade" id="s2" style="height: calc(100vh - 250px) !important;">
        <jsp:include page="stockmovement2.jsp"></jsp:include>
    </div>
</div>
<script type="text/javascript">
        pageSetUp();

        

        
</script>