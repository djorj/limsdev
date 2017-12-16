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
StringBuilder  insts = new StringBuilder();
Connection c   = Manager.getInstance().getConnection();
int testid = 0;
try
{
    testid   = Integer.parseInt(request.getParameter("analysis"));
    String sql = ""
            + " SELECT ins.institutionid, ins.name"
            + " FROM institution ins, labtestinstitution labins, labtest lab"
            + " WHERE ins.institutionid=labins.institutionid"
            + " AND labins.labtestid=lab.labtestid"
            + " AND lab.labtestid="+testid
            + " ORDER BY lab.name";

    ResultSet rs = c.createStatement().executeQuery(sql);
    while(rs.next())
    {
        insts.append("<option value="+rs.getInt(1)+">"+(rs.getString(2))+"</option>");
    }
}
catch(Exception e){
    e.printStackTrace();
}
finally {
    Manager.getInstance().releaseConnection(c);
}
%>
<form id="frminstitution" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" value="researchtest3" type="hidden">
<input name="contractid" type="hidden" value="<%=request.getParameter("contractid")%>">
<input name="ids"  type="hidden" value="<%=request.getParameter("samplelist")%>">
<input name="ids2" type="hidden" value="">
<input name="box" type="hidden" value="<%=request.getParameter("samplebox")%>">
<input name="testparent" type="hidden" value="<%=testid%>">
<section class="col col-sm-12">
    <label class='label'><%=trs.t("ლაბორატორია")%></label>
    <label class="select">
        <select id="institution" name="institutionid"  style="width:100%;">
        <option value=""></option>
        <%=insts.toString()%>
        </select>
    </label>
</section>
</form>

