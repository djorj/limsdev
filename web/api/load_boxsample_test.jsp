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
<form id="frmtestmodal" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden" value="boxsampletest">
<input name="id" type="hidden" value="<%=request.getParameter("id")%>">

<%
StringBuilder  opts = new StringBuilder();
Connection c   = Manager.getInstance().getConnection();
ResultSet rs;
long id=0;
try
{
    id = Long.parseLong(request.getParameter("id"));
    ContractsampletypeBean[] chld = ContractsampletypeManager.getInstance().loadByWhere("WHERE deleted=false AND parentid="+id+" ORDER BY contractsampletypeid");
    for (int i=0; i<chld.length; i++)
    {    
        SampletypeBean sam = SampletypeManager.getInstance().loadByPrimaryKey(chld[i].getSampletypeid());
%>
<section class="col col-sm-12">
    <input name="sampleids" type="hidden" value="<%=chld[i].getContractsampletypeid()%>">
    <label class='label'><%=trs.t(sam.getName())%></label>
    <label class="select">
        <select name="testparent_<%=chld[i].getContractsampletypeid()%>" class="onchange" style="width:100%;">
        <option value=""></option> 
<%            
        String sql = ""
            + " SELECT labsam.labtestid, lab.name"
            + " FROM labtestsampletype labsam, labtest lab"
            + " WHERE labsam.labtestid=lab.labtestid"
            + " AND labsam.sampletypeid="+chld[i].getSampletypeid()
            + " ORDER BY lab.name";
        rs = c.createStatement().executeQuery(sql);
        while(rs.next())
        {
            out.print("<option value="+rs.getInt(1)+">"+(rs.getString(2))+"</option>");
        }
%>
        </select>
    </label>
</section>
<%
        rs.close();
    }
}
catch(Exception e){
    e.printStackTrace();
}
finally {
    Manager.getInstance().releaseConnection(c);
}
%>
</form>
