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
<%@include file="api.inc.jsp"%>
<%
    TransitsampleitemBean[] transfers = TransitsampleitemManager.getInstance().loadByWhere("where contractsampleitemid = "+request.getParameter("id")+" order by transitdate");
    
%>
<li class="parent_li" role="treeitem">
    <%
    for(int i=0;i<transfers.length;i++){
        String instname = "";
        if(transfers[i].getLocationid() != null){
            InstitutionBean inst = InstitutionManager.getInstance().loadByPrimaryKey(transfers[i].getLocationid());
            instname = inst.getName();
        }
    %>
    <span groupid="<%=transfers[i].getLocationid()%>" title=""><i class="fa fa-lg fa-minus-circle"></i> <%=instname%></span>
    <%
    }
    %>
    <span groupid="2" title="Collapse this branch"><i class="fa fa-lg fa-minus-circle"></i> ზუგდიდი LSS</span>
    <ul role="group">
        <li>
            <span groupid="9" class="pleaf"><i class="icon-leaf"></i> ქუთაისი ZDL</span>
            <ul role="group">
                <li>
                    <span groupid="9" class="pleaf"><i class="icon-leaf"></i> ქუთაისი ZDL - ბაქტეროლოგია</span>
                    <ul role="group">
                        <li>
                            <span groupid="9" class="pleaf"><i class="icon-leaf"></i> ბაქტეროლოგია</span>
                        </li>
                        <li>
                            <span groupid="9" class="pleaf"><i class="icon-leaf"></i> მიკრობიოლოგია</span>
                        </li>
                    </ul>
                </li>
            </ul>
        </li>
    </ul>
</li>
