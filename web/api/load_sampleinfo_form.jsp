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
    if (request.getParameter("sampletypeid")!=null){
System.out.println("1");
        long id  = Long.parseLong(request.getParameter("sampletypeid"));
        ContractsampletypeBean sample = ContractsampletypeManager.getInstance().loadByPrimaryKey(id);
        ExtraparamBean[] params = ExtraparamManager.getInstance().loadByWhere("where sampletypeid = "+sample.getSampletypeid()+" order by name, description");
%>
<form id="frmclose" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" value="sampletypeinfo" type="hidden">
<input name="sampletypeid" type="hidden" value="<%=sample.getContractsampletypeid()%>">
<%
for(int i=0;i<params.length;i++){
    ExtravalBean val = ExtravalManager.getInstance().loadByPrimaryKey(params[i].getExtraparamid(), id);
    String value = "";
    if(val != null){
        if(params[i].getRestypeid().intValue() == 1)    value = (val.getBval().booleanValue()) ? "1":"2";
        else if(params[i].getRestypeid().intValue() == 2)    value = dc.format(val.getDval());
        else if(params[i].getRestypeid().intValue() == 3)    value = val.getTval();
    }
    %>
    <section class="col col-sm-4">
        <label class="label">
            <%=params[i].getName()%>
        </label>
    </section>
    <section class="col col-sm-8">
        <%if(params[i].getRestypeid().intValue() == 1){%>
        <label class="select"> 
            <select name="param_<%=params[i].getExtraparamid()%>">
                <option value="0"></option>
                <option value="1" <%=(value.equals("1")) ? "selected":""%>><%=trs.t("დიახ")%></option>
                <option value="2" <%=(value.equals("2")) ? "selected":""%>><%=trs.t("არა")%></option>
            </select><i></i>
        </label>
        <%} else if(params[i].getRestypeid().intValue() == 2){%>
        <label class="input"> <i class="icon-append fa fa-list"></i>
        <input type="text"  name="param_<%=params[i].getExtraparamid()%>" value="<%=value%>">
        </label>
        <%} else if(params[i].getRestypeid().intValue() == 3){%>
        <label class="textarea"> <i class="icon-append fa fa-list"></i>
        <textarea  name="param_<%=params[i].getExtraparamid()%>"><%=value%></textarea>
        </label>
        <%}%>
    </section>
    <%
}
%>
<section class="col col-sm-12">
    <label class="textarea"> <i class="icon-append fa fa-info"></i>
    <textarea  name="info" placeholder="<%=trs.t("შენიშვნა")%>"><%=sample.getInfo()==null ? "" : sample.getInfo()%></textarea>
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
        long tid = 0;
        ExtraparamBean[] params = new ExtraparamBean[0];
        if(sample.getContractsampletypeid() != null){
            ContractsampletypeBean cb = ContractsampletypeManager.getInstance().loadByPrimaryKey(sample.getContractsampletypeid());
            tid = cb.getSampletypeid().intValue();
            stamp = cb.getStamp();
            if(stamp == null)   stamp = "";
            params = ExtraparamManager.getInstance().loadByWhere("where sampletypeid = "+tid+" order by name, description");
        }
        

%>
<form id="frmclose" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" value="sampleiteminfo" type="hidden">
<input name="sampleitemid" type="hidden" value="<%=sample.getContractsampleitemid()%>">
<%
for(int i=0;i<params.length;i++){
    ExtravalBean val = ExtravalManager.getInstance().loadByPrimaryKey(params[i].getExtraparamid(), id);
System.out.println(params[i].getExtraparamid() +" " + tid);
    String value = "";
    if(val != null){
        if(params[i].getRestypeid().intValue() == 1)    value = (val.getBval().booleanValue()) ? "1":"2";
        else if(params[i].getRestypeid().intValue() == 2)    value = dc.format(val.getDval());
        else if(params[i].getRestypeid().intValue() == 3)    value = val.getTval();
    }
    %>
    <section class="col col-sm-4">
        <label class="label">
            <%=params[i].getName()%>
        </label>
    </section>
    <section class="col col-sm-8">
        <%if(params[i].getRestypeid().intValue() == 1){%>
        <label class="select"> 
            <select name="param_<%=params[i].getExtraparamid()%>">
                <option value="0"></option>
                <option value="1" <%=(value.equals("1")) ? "selected":""%>><%=trs.t("დიახ")%></option>
                <option value="2" <%=(value.equals("2")) ? "selected":""%>><%=trs.t("არა")%></option>
            </select><i></i>
        </label>
        <%} else if(params[i].getRestypeid().intValue() == 2){%>
        <label class="input"> <i class="icon-append fa fa-list"></i>
        <input type="text"  name="param_<%=params[i].getExtraparamid()%>" value="<%=value%>">
        </label>
        <%} else if(params[i].getRestypeid().intValue() == 3){%>
        <label class="textarea"> <i class="icon-append fa fa-list"></i>
        <textarea  name="param_<%=params[i].getExtraparamid()%>"><%=value%></textarea>
        </label>
        <%}%>
    </section>
    <%
}
%>
<section class="col col-sm-12">
    <label class="textarea"> <i class="icon-append fa fa-info"></i>
        <textarea  name="info" placeholder="<%=trs.t("შენიშვნა")%>"><%=sample.getInfo()==null ? "" : sample.getInfo()%></textarea>
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
