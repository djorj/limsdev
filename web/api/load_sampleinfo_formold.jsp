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
try
{
    System.out.println(request.getParameter("sampletypeid"));
    if (request.getParameter("sampletypeid")!=null)
    {
        long id  = Long.parseLong(request.getParameter("sampletypeid"));
        ContractsampletypeBean sample = ContractsampletypeManager.getInstance().loadByPrimaryKey(id);
        
%>
<form id="frmclose" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" value="sampletypeinfo" type="hidden">
<input name="sampletypeid" type="hidden" value="<%=sample.getContractsampletypeid()%>">
<section class="col col-sm-12">
    <label class="textarea"> <i class="icon-append fa fa-info"></i>
    <textarea  name="info"><%=sample.getInfo()==null ? "" : sample.getInfo()%></textarea>
    </label>
</section>
<%--section class="col col-sm-12">
    <label class="input"> <i class="icon-append fa fa-lock"></i>
        <input type='text' name='stamp' value="<%=sample.getStamp()==null ? "" : sample.getStamp()%>" placeholder="<%=trs.t("ლუქის ნომერი")%>"/>
    </label>
</section--%>
</form>
<%
    }
    else if (request.getParameter("sampleitemid")!=null)
    {
        long id  = Long.parseLong(request.getParameter("sampleitemid"));
        ContractsampleitemBean sample = ContractsampleitemManager.getInstance().loadByPrimaryKey(id);
        String stamp = "";
        if(sample.getContractsampletypeid() != null){
            ContractsampletypeBean cb = ContractsampletypeManager.getInstance().loadByPrimaryKey(sample.getContractsampletypeid());
            stamp = cb.getStamp();
            if(stamp == null)   stamp = "";
        }
%>
<form id="frmclose" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" value="sampleiteminfo" type="hidden">
<input name="sampleitemid" type="hidden" value="<%=sample.getContractsampleitemid()%>">
<section class="col col-sm-12">
    <label class="textarea"> <i class="icon-append fa fa-info"></i>
    <textarea  name="info"><%=sample.getInfo()==null ? "" : sample.getInfo()%></textarea>
    </label>
</section>
<%--section class="col col-sm-12">
    <label class="input"> <i class="icon-append fa fa-lock"></i>
        <input type='text' name='stamp' value="<%=stamp%>" placeholder="<%=trs.t("ლუქის ნომერი")%>"/>
    </label>
</section--%>
</form>
<%
    }
}
catch(Exception e){
    e.printStackTrace();
}
%>
