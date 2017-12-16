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
StringBuilder  opts = new StringBuilder();
String ids = request.getParameter("id");
String script = "";
try
{
    LabtestBean[] tests0 = LabtestManager.getInstance().loadByWhere("where labtestid in (select labtestid from sampleitemreseach where contractsampleitemid in ("+ids+"))");
    
    String sql = "where labtestid in ("
            + "select distinct t.labtestid from "
            + "labtestsampletype t, "
            + "contractsampletype c, "
            + "contractsampleitem i "
            + "where "
            + "t.sampletypeid = c.sampletypeid and "
            + "c.contractsampletypeid = i.contractsampletypeid and "
            + "i.contractsampleitemid in ("+ids+")"
            + ")";

    LabtestBean[] tests = LabtestManager.getInstance().loadByWhere(sql);
    for(int i=0;i<tests.length;i++){
        
        if(tests0.length > 0 && tests0[0].getLabtestid().intValue() == tests[i].getLabtestid().intValue())
            script = "$(\"#testparent\").val("+tests[i].getLabtestid()+");\n$(\"#testparent\").trigger(\"change\");\n";
        opts.append("<option value="+tests[i].getLabtestid()+">"+tests[i].getName()+"</option>");
    }
}
catch(Exception e){
    e.printStackTrace();
}
System.out.println(script);
%>
<form id="frmtestmodal" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden" value="researchtest">
<input name="id" type="hidden" value="<%=ids%>">
<section class="col col-sm-12">
    <label class='label'><%=trs.t("კვლევა")%></label>
    <label class="select">
        <select name="testparent" id="testparent" class="onchange" style="width:100%;">
        <option value=""></option>
        <%=opts.toString()%>
        </select>
    </label>
</section>
<section class="col col-sm-12" id="sectestchild" style="display: none;">
    <label class='label'><%=trs.t("ტესტები")%></label>
    <label class="select">
        <select name="testchild" multiple="multiple" style="width:100%;"></select>
    </label>
</section>
</form>
<script>
    $(function() {
        <%=script%>
    });
</script>