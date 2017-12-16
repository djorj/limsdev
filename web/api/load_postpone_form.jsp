<%-- 
    Document   : service
    Created on : Nov 22, 2014, 3:24:54 PM
    Author     : Gocha Tortladze
--%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
try
{
    long id = Long.parseLong(request.getParameter("id"));
    VLabRequestBean[] sam = VLabRequestManager.getInstance().loadByWhere("WHERE sampleitemreseachid="+id);
    
//    ContractsampleitemBean sam = ContractsampleitemManager.getInstance().loadByPrimaryKey(id);
%>
<form id="frmpostpone" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" value="postphone" type="hidden">
<input name="id" type="hidden" value="<%=request.getParameter("id")%>">
    <section class="col col-md-12">
    <div class="form-group">
      <label class="control-label col-md-2">ნიმუში:</label>
      <div class="col-sm-10">
        <%=sam[0].getSamplename()%>
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="email">ბარკოდი:</label>
      <div class="col-sm-10">
        <%=sam[0].getContractsampleitemid()%>
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="email">ანალიზი:</label>
      <div class="col-sm-10">
        <%=sam[0].getLabtestname()%>
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="email">ვადა:</label>
      <div class="col-sm-10">
        12/12/2017
      </div>
    </div>
    </section>
    <section class="col col-md-6">
        <label class="label"> <%=trs.t("ახალი ვადა")%></label>
        <label class="input"> <i class="icon-append fa fa-calendar"></i>
        <input name="enddate" type="text"/>
        </label>
    </section>
</form>
<%
}
catch(Exception e){
    e.printStackTrace();
}
%>
