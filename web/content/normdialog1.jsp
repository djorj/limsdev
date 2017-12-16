<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%-- restypeid = 1 ლოგიკური --%>
<%
LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
String val1 = (labtest.getBnormval1() == null) ? "":labtest.getBnormval1();
String val2 = (labtest.getBnormval2() == null) ? "":labtest.getBnormval2();
%>
<div class="widget-body padding-10">
    <form action="" id="checkout-form" class="smart-form" novalidate="novalidate">
        <fieldset>
            <label class="input"> <i class="icon-append fa fa-plus-circle"></i>
                <input name="normpositive" id="normpositive" placeholder="<%=trs.t("დადებითი")%>" type="text" value="<%=val1%>">
            </label>
            <br>
            <label class="input"> <i class="icon-append fa fa-minus-circle"></i>
                <input name="normnegative" id="normnegative" placeholder="<%=trs.t("უარყოფითი")%>" type="text" value="<%=val2%>">
            </label>
        </fieldset>
    </form>
</div>