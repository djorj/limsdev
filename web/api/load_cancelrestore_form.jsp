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
    LabtestBean tst  = LabtestManager.getInstance().loadByPrimaryKey(sam[0].getLabtestid());
    UnitsBean unit = UnitsManager.getInstance().loadByPrimaryKey(tst.getUnitsid());
    
%>

<h2 id="message"><%=trs.t("დარწმუნებული ხართ, რომ გნებავთ კვლევის "+(sam[0].getStatus()==1 ? "გაუქმება" : "აღდგენა")+"?")%></h2>
<div class="smart-form">
<form id="frmcancelrestore" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" value="cancelrestore" type="hidden">
<input name="id" type="hidden" value="<%=request.getParameter("id")%>">
<input name="status" type="hidden" value="<%= sam[0].getStatus()==1 ? 2 : 1 %>">
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
    </section>
    <section class="col col-md-12">
        <label class="label"><%=trs.t("მიზეზი")%></label>
        <label class="select">
        <select name="reason">
            <option value="0"><%=trs.t("აირჩიეთ")%></option>
<%
    CancelreasonBean[] cr = CancelreasonManager.getInstance().loadAll();
    for (int i=0;  i<cr.length; i++)
    {
        String sel = "";
        out.print("<option value=\""+cr[i].getCancelreasonid()+"\" "+sel+">"+cr[i].getName()+"</option>");
    }
%>
        </select>
        </label>
    </section>
    <section class="col col-md-12">
        <label class="textarea"> <i class="icon-append fa fa-info"></i>
            <textarea name="other" placeholder="<%=trs.t("დაწერეთ სხვა მიზეზი")%>"></textarea>
        </label>
    </section>
</form>                        
</div>


<%
}
catch(Exception e){
    e.printStackTrace();
}
%>
