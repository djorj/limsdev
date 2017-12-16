<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%-- restypeid = 2 რიცხვი --%>
<%
LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
String val1 = (labtest.getNormmin() == null) ? "":dc.format(labtest.getNormmin());
String val2 = (labtest.getNormmax() == null) ? "":dc.format(labtest.getNormmax());
%>
<div class="widget-body padding-10">
    <form action="" id="checkout-form" class="smart-form" novalidate="novalidate">
        <fieldset>
            <label class="input"> <i class="icon-append fa fa-arrow-down"></i>
                <input name="normmin" id="normmin" placeholder="<%=trs.t("მინიმალური მნიშვნელობა")%>" type="text" value="<%=val1%>">
            </label>
            <br>
            <label class="input"> <i class="icon-append fa fa-arrow-up"></i>
                <input name="normmax" id="normmax" placeholder="<%=trs.t("მაქსიმალური მნიშვნელობა")%>" type="text" value="<%=val2%>">
            </label>
        </fieldset>
    </form>
</div>
