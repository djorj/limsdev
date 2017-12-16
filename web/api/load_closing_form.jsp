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
SimpleDateFormat DT = new SimpleDateFormat("dd/MM/yyyy");
SimpleDateFormat TM = new SimpleDateFormat("HH:mm");

StringBuilder  insts = new StringBuilder();
StringBuilder  perss = new StringBuilder();
Connection c   = Manager.getInstance().getConnection();
try
{
    long contractid   = Integer.parseInt(request.getParameter("contractid"));
    ContractBean contract = ContractManager.getInstance().loadByPrimaryKey(contractid);
%>
<link href="js/plugin/bootstrap-datepicker/css/datepicker3.css"  rel="stylesheet">
<style>
.select2-search-choice {
    background-color: #ffffff !Important;
    color: #000000 !Important;
    border: none !Important;
}
.select2-search-choice-close:before {
    color: blue !Important;
    content: "\f057";
}
</style>
<form id="frmclose" action="api/updcontractfield.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" value="contractclosing" type="hidden">
<input name="contractid" type="hidden" value="<%=request.getParameter("contractid")%>">
<input name="appealid" type="hidden" value="<%=request.getParameter("appealid")%>">
<input name="actid" type="hidden" value="<%=request.getParameter("actid")%>">
<%
    
    long appealid = 0;
    long actid = 0;
    try{ appealid = Long.parseLong(request.getParameter("appealid")); }catch(Exception ign){}
    try{ actid = Long.parseLong(request.getParameter("actid")); }catch(Exception ign){}
    String sql0 = "";
    if(appealid > 0)  sql0 += " and sam.appealid = "+appealid;
    if(actid > 0)  sql0 += " and sam.actid = "+actid;
    
    
    
    PersonellBean[] per = PersonellManager.getInstance().loadByWhere("WHERE deleted<>true and companyid="+user.getCompanyid()+" ORDER BY lname,fname");
    for (int i=0;  i<per.length; i++)
        perss.append("<option value=\""+per[i].getPersonellid()+"\">"+per[i].getFname()+" "+per[i].getLname()+"</option>");
    
    Map<Integer, ContractclosingBean> ccs = new HashMap<Integer, ContractclosingBean>();
    ContractclosingBean[] tmp = ContractclosingManager.getInstance().loadByWhere("WHERE deleted=false and contractid="+contractid);
    for (int i=0;  i<tmp.length; i++)
        ccs.put(tmp[i].getInstitutionid(),tmp[i]);
    String sql = ""
            + " SELECT distinct res.institutionid"
            + " FROM sampleitemreseach res,contractsampleitem itm,contractsampletype sam"
            + " WHERE res.contractsampleitemid=itm.contractsampleitemid"
            + " AND itm.contractsampletypeid=sam.contractsampletypeid"
            + " AND res.deleted=false"
            + " AND itm.deleted=false"
            + " AND sam.deleted=false"
            + " AND res.contractid="+contractid
            + sql0;
    
    InstitutionBean[] inst = InstitutionManager.getInstance().loadByWhere("where institutionid in ("+sql+") order by name");
    if(inst.length == 0)
        sql = "select distinct d.parentid "
                + "from labtestsampletype s, labtestinstitution i, contractsampletype sam, institution d "
                + "where s.labtestid = i.labtestid and i.institutionid = d.institutionid and "
                + "s.sampletypeid = sam.sampletypeid and "
                + "sam.contractid = "+contractid+sql0;
    int iid = user.getInstitutionid().intValue();
    if(iid == 0)    iid = 30;
System.out.println("where institutionid in ("+sql+") and rootansestor(institutionid) = rootansestor("+iid+") order by name");
    inst = InstitutionManager.getInstance().loadByWhere("where institutionid in ("+sql+") and rootansestor(institutionid) = rootansestor("+iid+") order by name");
    
    int n=0;
    for(int i=0;i<inst.length;i++)
    {
        n++;
        int ins = inst[i].getInstitutionid().intValue();
        ContractclosingBean cb = ccs.get(ins);
        boolean rmd = (cb!=null)&&(cb.getIsinfo()==false);
%>
    <section class="col col-sm-12">
        <label class="label"><h5>  <%=inst[i].getName()%></h5></label>
        <label class="checkbox">
            <input name="chkins_<%=ins%>" class="contractclosing" value="<%=n%>" type="checkbox" <%=rmd ? "checked" : ""%>>
        <i></i><h7><%=trs.t("წაღების შესახებ ინფორმაცია არ არის")%></h7></label>
    </section>
    <section class="col col-sm-3 controler<%=n%>_2" <%=rmd ? "" : "style=\"display: none;\""%>>
        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
        <input name="reminddate_<%=ins%>" type="text"  class="dtpicker" placeholder="<%=trs.t("შეხსენების თარიღი")%>" value="<%=cb!=null ? DT.format(cb.getReminddate()) : ""%>">
        </label>
    </section>
    <section class="col col-sm-3 controler<%=n%>_2" <%=rmd ? "" : "style=\"display: none;\""%>>
        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
        <input name="remindtime_<%=ins%>" type="text"  class="clockpicker" placeholder="<%=trs.t("შეხსენების დრო")%>"   value="<%=cb!=null ? TM.format(cb.getReminddate()) : ""%>">
        </label>
    </section>
        
    <section class="col col-sm-2 controler<%=n%>_1" <%=rmd ? "style=\"display: none;\"" : ""%>>
        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
        <input name="takedate_<%=ins%>" type="text"  class="dtpicker" placeholder="<%=trs.t("წაღების თარიღი")%>" value="<%=cb!=null ? DT.format(cb.getTakedate()) : ""%>">
        </label>
    </section>
    <section class="col col-sm-2 controler<%=n%>_1" <%=rmd ? "style=\"display: none;\"" : ""%>>
        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
        <input name="taketime_<%=ins%>" type="text"  class="clockpicker" placeholder="<%=trs.t("წაღების დრო")%>"   value="<%=cb!=null ? TM.format(cb.getTakedate()) : ""%>">
        </label>
    </section>
    <section class="col col-sm-8 controler<%=n%>_1" <%=rmd ? "style=\"display: none;\"" : ""%>>
        <label class="select">
        <select name="takeperson_<%=ins%>"  multiple="multiple"  placeholder="<%=trs.t("ვინ წაიღო")%>"   class="select2" style="width:100%;">>
<%
    for (int j=0;  j<per.length; j++)
    {
        String sel = "";
        if (!rmd && (cb!=null) && (cb.getPersonels()!=null))
            sel = cb.getPersonels().contains(""+per[j].getPersonellid()) ? "selected" : "";
        out.print("<option value=\""+per[j].getPersonellid()+"\" "+sel+">"+per[j].getFname()+" "+per[j].getLname()+"</option>");
    }
%>
        </select>
        </label>
    </section>
    <hr class="col-sm-12" />
<%
    }
}
catch(Exception e){
    e.printStackTrace();
}
%>
</form>
