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
Manager.getInstance().beginTransaction();

try 
{
    if (request.getParameter("obj").equals("objappeal")) 
    {
        AppealBean obj   = AppealManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        obj.setDeleted(true);
        obj = AppealManager.getInstance().save(obj);
        
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("message", trs.t("ჩანაწერი წაიშალა."));
        out.print(ret.toString());
        Manager.getInstance().endTransaction(true);
        return;
    }
    else if (request.getParameter("obj").equals("objact")) 
    {
        ActBean obj = ActManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        obj.setDeleted(true);
        obj = ActManager.getInstance().save(obj);
        
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("message", trs.t("ჩანაწერი წაიშალა."));
        out.print(ret.toString());
        Manager.getInstance().endTransaction(true);
        return;
    }
    else if (request.getParameter("obj").equals("objcontragent")) 
    {
        ContragentBean obj = ContragentManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        obj.setDeleted(true);
        obj = ContragentManager.getInstance().save(obj);
        
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("message", trs.t("ჩანაწერი წაიშალა."));
        out.print(ret.toString());
        Manager.getInstance().endTransaction(true);
        return;
    }
    else if (request.getParameter("obj").equals("objcontract")) 
    {
        ContractBean obj = ContractManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        obj.setDeleted(true);
        obj = ContractManager.getInstance().save(obj);
        
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("message", trs.t("ჩანაწერი წაიშალა."));
        out.print(ret.toString());
        Manager.getInstance().endTransaction(true);
        return;
    }
    else if (request.getParameter("obj").equals("objcontractsample_old")) 
    {
        ContractsampletypeBean obj   = ContractsampletypeManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        if (obj.getIsbox())
        {
            if (obj.getParentid()==null)
            {
                DisclaimsampleitemManager.getInstance().deleteByWhere("WHERE contractsampleitemid in (SELECT contractsampleitemid FROM contractsampleitem,contractsampletype WHERE contractsampleitem.contractsampletypeid=contractsampletype.contractsampletypeid AND contractsampletype.parentid="+obj.getContractsampletypeid()+")");
                ContractsampleitemManager.getInstance().deleteByWhere("WHERE contractsampletypeid in (SELECT contractsampletypeid FROM contractsampletype WHERE parentid="+obj.getContractsampletypeid()+")");
                ContractsampleitemManager.getInstance().deleteByWhere("WHERE contractsampletypeid="+obj.getContractsampletypeid());
                ContractsampletypeManager.getInstance().deleteByWhere("WHERE parentid="+obj.getContractsampletypeid());
                ContractsampletypeManager.getInstance().deleteByPrimaryKey(obj.getContractsampletypeid());
            }
            else
            {
                DisclaimsampleitemManager.getInstance().deleteByWhere("WHERE contractsampleitemid in (SELECT contractsampleitemid FROM contractsampleitem WHERE contractsampletypeid="+obj.getContractsampletypeid()+")");
                ContractsampleitemManager.getInstance().deleteByWhere("WHERE contractsampletypeid="+obj.getContractsampletypeid());
                ContractsampletypeManager.getInstance().deleteByPrimaryKey(obj.getContractsampletypeid());
            }
        }
        else
        {
            DisclaimsampleitemManager.getInstance().deleteByWhere("WHERE contractsampleitemid in (SELECT contractsampleitemid FROM contractsampleitem WHERE contractsampletypeid="+obj.getContractsampletypeid()+")");
            ContractsampleitemManager.getInstance().deleteByContractsampletypeid(obj.getContractsampletypeid());
            ContractsampletypeManager.getInstance().deleteByPrimaryKey(obj.getContractsampletypeid());
        }
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("message", trs.t("ჩანაწერი წაიშალა."));
        out.print(ret.toString());
        Manager.getInstance().endTransaction(true);
        return;
    }
    else if (request.getParameter("obj").equals("objcontractsample")) 
    {
        long id = Long.parseLong(request.getParameter("id"));
        TransitsampleitemBean[] transits = TransitsampleitemManager.getInstance().loadByWhere("where contractsampleitemid in (select contractsampleitemid from contractsampleitem where contractsampletypeid = "+id+")");
        if(transits.length > 0)
            throw new Exception(trs.t("წაშლა შეუძლებელია - ნიმუში გადაცემულია!"));
        SampleitemreseachManager.getInstance().deleteByWhere("where contractsampleitemid in (select contractsampleitemid from contractsampleitem where contractsampletypeid = "+id+")");
        ContractsampleitemManager.getInstance().deleteByContractsampletypeid(id);
        ContractsampletypeManager.getInstance().deleteByPrimaryKey(id);
        
        //obj.setDeleted(true);
        //ContractsampletypeManager.getInstance().save(obj);
        
        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("message", trs.t("ჩანაწერი წაიშალა."));
        out.print(ret.toString());
        Manager.getInstance().endTransaction(true);
        return;
    }
    else if (request.getParameter("obj").equals("objcontractsampleitem")) 
    {
        long id = Long.parseLong(request.getParameter("id"));
        TransitsampleitemBean[] transits = TransitsampleitemManager.getInstance().loadByWhere("where contractsampleitemid = "+id);
        if(transits.length > 0)
            throw new Exception(trs.t("წაშლა შეუძლებელია - ნიმუში გადაცემულია!"));
        SampleitemreseachManager.getInstance().deleteByContractsampleitemid(id);
        ContractsampleitemBean obj    = ContractsampleitemManager.getInstance().loadByPrimaryKey(id);
        ContractsampletypeBean sample = ContractsampletypeManager.getInstance().loadByPrimaryKey(obj.getContractsampletypeid());
        //obj.setDeleted(true);
        //ContractsampleitemManager.getInstance().save(obj);
        ContractsampleitemManager.getInstance().deleteByPrimaryKey(id);

        sample.setQuantity(ContractsampleitemManager.getInstance().countWhere("WHERE deleted=false AND contractsampletypeid="+sample.getContractsampletypeid()));
        ContractsampletypeManager.getInstance().save(sample);

        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("message", trs.t("ჩანაწერი წაიშალა."));
        out.print(ret.toString());
        Manager.getInstance().endTransaction(true);
        return;
    }
    else if (request.getParameter("obj").equals("objcontractsampleitem_old")) 
    {
        ContractsampleitemBean obj    = ContractsampleitemManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        ContractsampletypeBean sample = ContractsampletypeManager.getInstance().loadByPrimaryKey(obj.getContractsampletypeid());
        DisclaimsampleitemManager.getInstance().deleteByContractsampleitemid(obj.getContractsampleitemid());
        ContractsampleitemManager.getInstance().deleteByPrimaryKey(obj.getContractsampleitemid());
        sample.setQuantity(ContractsampleitemManager.getInstance().countWhere("WHERE contractsampletypeid="+obj.getContractsampletypeid()));
        sample = ContractsampletypeManager.getInstance().save(sample);

        JSONObject ret  = new JSONObject();
        ret.put("status", "OK");
        ret.put("message", trs.t("ჩანაწერი წაიშალა."));
        out.print(ret.toString());
        Manager.getInstance().endTransaction(true);
        return;
    }
}
catch (Exception er) 
{
    Manager.getInstance().endTransaction(false);
    
    er.printStackTrace();
    JSONObject obj  = new JSONObject();
    obj.put("status", "ER");
    String msg = er.getMessage();
    if(msg == null || msg.trim().length() == 0)
        msg = trs.t("სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას");
    obj.put("message", msg);
    out.println(obj.toString());
    System.out.println(obj.toString());
}
%>
