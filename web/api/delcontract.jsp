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
JSONObject res = new JSONObject();
Manager.getInstance().beginTransaction();
try 
{
    String oper = request.getParameter("oper");
    
    if(oper.equalsIgnoreCase("contract")){

        ContractBean contract = ContractManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("cid")));
        if(user.getPersonelltypeid().intValue() == 1){
            SampleitemreseachManager.getInstance().deleteByContractid(contract.getContractid());
            String deltypesql = "where "
                    + "contractid = "+contract.getContractid()+" or "
                    + "appealid in (select appealid from appeal where contractid = "+contract.getContractid()+") or "
                    + "actid in (select actid from act where contractid = "+contract.getContractid()+")";
            TransitsampleitemManager.getInstance().deleteByWhere("where contractsampleitemid in (select contractsampleitemid from contractsampleitem where contractsampletypeid in (select contractsampletypeid from contractsampletype "+deltypesql+"))");
            ContractsampleitemManager.getInstance().deleteByWhere("where contractsampletypeid in (select contractsampletypeid from contractsampletype "+deltypesql+")");
            ContractsampletypeManager.getInstance().deleteByWhere(deltypesql);
            ActManager.getInstance().deleteByContractid(contract.getContractid());
            AppealManager.getInstance().deleteByContractid(contract.getContractid());
            ContractanalysisManager.getInstance().deleteByContractid(contract.getContractid());
        }
        DocsManager.getInstance().deleteByContractid(contract.getContractid());
        BillManager.getInstance().deleteByContractid(contract.getContractid());
        ContractclosingManager.getInstance().deleteByContractid(contract.getContractid());
        ContractManager.getInstance().deleteByPrimaryKey(contract.getContractid());
    } else if(oper.equalsIgnoreCase("appeal")){
        AppealBean appeal = AppealManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("aid")));
    
        String deltypesql = "where "
                + "appealid = "+appeal.getAppealid();
        SampleitemreseachManager.getInstance().deleteByWhere("where contractsampleitemid in (select contractsampleitemid from contractsampleitem where contractsampletypeid in (select contractsampletypeid from contractsampletype "+deltypesql+"))");
        ContractsampleitemManager.getInstance().deleteByWhere("where contractsampletypeid in (select contractsampletypeid from contractsampletype "+deltypesql+")");
        ContractsampletypeManager.getInstance().deleteByWhere(deltypesql);
    
        AppealManager.getInstance().deleteByPrimaryKey(appeal.getAppealid());
        
    } else if(oper.equalsIgnoreCase("act")){
        ActBean act = ActManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("aid")));
    
        String deltypesql = "where "
                + "actid = "+act.getActid();
        SampleitemreseachManager.getInstance().deleteByWhere("where contractsampleitemid in (select contractsampleitemid from contractsampleitem where contractsampletypeid in (select contractsampletypeid from contractsampletype "+deltypesql+"))");
        ContractsampleitemManager.getInstance().deleteByWhere("where contractsampletypeid in (select contractsampletypeid from contractsampletype "+deltypesql+")");
        ContractsampletypeManager.getInstance().deleteByWhere(deltypesql);
    
        ActManager.getInstance().deleteByPrimaryKey(act.getActid());
    }
    
    Manager.getInstance().endTransaction(true);
    res.put("result",1);
    
}catch (Exception e){
    Manager.getInstance().endTransaction(false);
    
    String msg = e.getMessage();
    if(msg.toUpperCase().indexOf("UPDATE OR DELETE") >= 0){
        msg = trs.t("ხელშეკრულების წაშლა შეუძლებელია ავტორიზაციის გარეშე - დაუკავშირდით სისტემის ადმინისტრატორს");
    }
    
    e.printStackTrace();
    res.put("result",0);
    res.put("error", msg);
}
out.print(res.toString());
out.flush();
%>