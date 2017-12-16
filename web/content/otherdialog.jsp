<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    
%>
<div class="smart-form">
    <section class="col col-sm-6">
        <label class="input"> <i class="icon-append fa fa-globe"></i>
            <input placeholder="<%=trs.t("საკვლევი მასალის ტიპი")%>" type="text">
            <b class="tooltip tooltip-bottom-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("საკვლევი მასალის ტიპი")%></b>
        </label>
    </section>
    <section class="col col-sm-6">
        <label class="input"> <i class="icon-append fa fa-globe"></i>
            <input placeholder="<%=trs.t("სერიული ნომერი")%>" type="text">
            <b class="tooltip tooltip-bottom-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("სერიული ნომერი")%></b>
        </label>
    </section>
    <section class="col col-sm-6">
        <label class="input"> <i class="icon-append fa fa-globe"></i>
            <input placeholder="<%=trs.t("დასახელება")%>" type="text">
            <b class="tooltip tooltip-bottom-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("დასახელება")%></b>
        </label>
    </section>
    <section class="col col-sm-6">
        <label class="input"> <i class="icon-append fa fa-globe"></i>
            <input placeholder="<%=trs.t("ვარგისიანობის ვადა")%>" type="text">
            <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("ვარგისიანობის ვადა")%></b>
        </label>
    </section>
</div>
