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

<div id="exampleAccordion" data-children=".item">
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

  <div class="item">
    <a data-toggle="collapse" data-parent="#exampleAccordion" href="#boxsamplereport<%=sam.getSampletypeid()%>" aria-expanded="true" aria-controls="boxsamplereport<%=sam.getSampletypeid()%>">
      <%=trs.t(sam.getName())%>
    </a>
    <div id="boxsamplereport<%=sam.getSampletypeid()%>" class="collapse show" role="tabpanel">
      <p class="mb-3">
                                <ol class="dd-list">
                                    <li class="dd-item"><div class="dd-handle" style="border: none !important; background: none !important;"><div class="row"><div class="col-xs-8"><%=trs.t("ნიმუშების რაოდენობა")%>:</div><div class="col-xs-4"><span class=" text-align-right text-primary" id="totalsample"></span></div></div></div></li>
                                    <li class="dd-item"><div class="dd-handle" style="border: none !important; background: none !important;"><div class="row"><div class="col-xs-8"><%=trs.t("გატარებულია")%>:</div><div class="col-xs-4"><span class=" text-align-right text-primary" id="submitsample"></span></div></div></div></li>
                                    <li class="dd-item"><div class="dd-handle" style="border: none !important; background: none !important;"><div class="row"><div class="col-xs-8"><%=trs.t("მიღებულია")%>:</div><div class="col-xs-4"><span class=" text-align-right text-success" id="approvedsample"></span></div></div></div></li>
                                    <li class="dd-item"><div class="dd-handle" style="border: none !important; background: none !important;"><div class="row"><div class="col-xs-8"><%=trs.t("დაწუნებულია")%>:</div><div class="col-xs-4"><span class=" text-align-right text-danger" id="disclaimsample"></span></div></div></div></li>
                                    <li class="dd-item"><div class="dd-handle" style="border: none !important; background: none !important;"><div class="row"><div class="col-xs-8"><%=trs.t("დარჩენილია")%>:</div><div class="col-xs-4"><span class=" text-align-right text-primary" id="leftsample"></span></div></div></div></li>
                                    <li class="dd-item">
                                        <div class="dd-handle" style="border: none !important; background: none !important;">
                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <div class="progress progress-striped active no-margin" id="progresspercent">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </ol>
      </p>
    </div>
  </div>
<%
    }
}
catch(Exception e){
    e.printStackTrace();
}
finally {
    Manager.getInstance().releaseConnection(c);
}
%>
</div>
