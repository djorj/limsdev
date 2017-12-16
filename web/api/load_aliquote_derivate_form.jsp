<%-- 
    Document   : service
    Created on : Nov 22, 2014, 3:24:54 PM
    Author     : Gocha Tortladze
--%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>

<%
StringBuilder  opts2 = new StringBuilder();
StringBuilder  opts3 = new StringBuilder();
String ids = request.getParameter("id");
opts2.append("<option value=\"\"></option>");
opts3.append("<option value=\"\"></option>");
try
{
    String sql = "where type = 1 and derivatetypeid in ("
            + "select distinct t.derivatetypeid from "
            + "sampletypederivate t, "
            + "contractsampletype c, "
            + "contractsampleitem i "
            + "where "
            + "t.sampletypeid = c.sampletypeid and "
            + "c.contractsampletypeid = i.contractsampletypeid and "
            + "i.contractsampleitemid in ("+ids+")"
            + ")";

    DerivatetypeBean[] tests = DerivatetypeManager.getInstance().loadByWhere(sql);
    for(int i=0;i<tests.length;i++){
       opts2.append("<option value="+tests[i].getDerivatetypeid()+">"+tests[i].getName()+"</option>");
    }
    
    sql = "where type = 2 and derivatetypeid in ("
            + "select distinct t.derivatetypeid from "
            + "sampletypederivate t, "
            + "contractsampletype c, "
            + "contractsampleitem i "
            + "where "
            + "t.sampletypeid = c.sampletypeid and "
            + "c.contractsampletypeid = i.contractsampletypeid and "
            + "i.contractsampleitemid in ("+ids+")"
            + ")";

    tests = DerivatetypeManager.getInstance().loadByWhere(sql);
    for(int i=0;i<tests.length;i++){
       opts3.append("<option value="+tests[i].getDerivatetypeid()+">"+tests[i].getName()+"</option>");
    }
}
catch(Exception e){
    e.printStackTrace();
}
%>
<form id="frmmakemodal" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden" value="aliqderi">
<input name="ids" type="hidden" value="<%=ids%>">
    <section class="col col-sm-12">
        <div class="inline-group">
            <label class="radio"><input name="itemaction" value="1" type="radio"><i></i><%=trs.t("ალიქვოტირება")%></label>
            <label class="radio"><input name="itemaction" value="2" type="radio"><i></i><%=trs.t("დერივატირება")%></label>
            <label class="radio"><input name="itemaction" value="3" type="radio"><i></i><%=trs.t("სხვა")%></label>
        </div>
    </section>
    <section class="col col-sm-6 con1" style='display: none;'>
        <label class="label"> <%=trs.t("რაოდენობა")%></label>
        <label class="input"> <i class="icon-append fa fa-phone"></i>
        <input name="number"  type="text">
        </label>
    </section>
    <section class="col col-sm-6 con2" style='display: none;'>
        <label class="label"> <%=trs.t("ტიპი")%></label>
        <label class="select">
            <select name="nid2"><%= opts2.toString() %></select><i></i>
        </label>
    </section>
    <section class="col col-sm-6 con3" style='display: none;'>
            <label class="label"> <%=trs.t("ტიპი")%></label>
            <label class="select">
                <select name="nid3"><%= opts3.toString() %></select><i></i>
            </label>
    </section>
    <section class="col col-sm-6">
        <label class="label"> <%=trs.t("თარიღი")%></label>
        <label class="input"> <i class="icon-append fa fa-calendar"></i>
        <input name="regdate" value="<%=dt.format(new Date())%>" type="text">
        </label>
    </section>
    <section class="col col-sm-6">
        <label class="label"><%=trs.t("საერთო კვლევა")%></label>
        <label class="checkbox">
            <input name="sharedresearch" value="1" type="checkbox">
            <i></i></label>
    </section>
    
</form>
