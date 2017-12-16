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
String sid = "0";
String oper = request.getParameter("oper");
Manager.getInstance().beginTransaction();
Connection c = Manager.getInstance().getConnection();

try{
    if(oper.equalsIgnoreCase("contractclosing")){
        
        long cid = Long.parseLong(request.getParameter("contractid"));
        ContractBean obj = ContractManager.getInstance().loadByPrimaryKey(cid);

        String sq2 = ""
            + " SELECT distinct ins.institutionid, ins.name"
            + " FROM institution ins, sampleitemreseach res"
            + " WHERE ins.institutionid=res.institutionid"
            + " AND res.contractid="+cid
            + " ORDER BY ins.name";
        String sql = ""
            + " SELECT distinct ins.institutionid, ins.name"
            + " FROM institution ins, sampleitemreseach res,contractsampleitem itm,contractsampletype sam"
            + " WHERE ins.institutionid=res.institutionid"
            + " AND res.contractsampleitemid=itm.contractsampleitemid"
            + " AND itm.contractsampletypeid=sam.contractsampletypeid"
            + " AND res.deleted=false"
            + " AND itm.deleted=false"
            + " AND sam.deleted=false"
            + " AND res.contractid="+cid
            + " ORDER BY ins.name";
        long actid = 0;
        long appealid = 0;
        if(request.getParameter("actid") != null){
            try{actid = Long.parseLong(request.getParameter("actid"));}catch(Exception ign){};
        }
        if(request.getParameter("appealid") != null){
            try{appealid = Long.parseLong(request.getParameter("appealid"));}catch(Exception ign){};
        }
        ResultSet rs = c.createStatement().executeQuery(sql);
        while(rs.next())
        {
            int ins = rs.getInt("institutionid");
            String lnm = rs.getString("name");
            
            
            ContractclosingBean[] cbs = ContractclosingManager.getInstance().loadByWhere("WHERE contractid="+cid+" AND institutionid="+ins);
            ContractclosingBean cb = (cbs.length==0) ? ContractclosingManager.getInstance().createContractclosingBean() : cbs[0];
            cb.setContractid(cid);
            cb.setInstitutionid(ins);
            cb.setRegbyid(user.getPersonellid());
            if(actid > 0)   cb.setActid(actid);
            if(appealid > 0)    cb.setAppealid(appealid);
            if (request.getParameter("chkins_"+ins)!=null)
            {
                str2date(request.getParameter("reminddate_"+ins),lnm+": შეხსენების თარიღი არ არის მითითებული");
                str2time(request.getParameter("remindtime_"+ins),lnm+": შეხსენების დრო არ არის მითითებული");
                String dtm = request.getParameter("reminddate_"+ins)+" "+request.getParameter("remindtime_"+ins);
                cb.setIsinfo(false);
                cb.setReminddate(str2datetime(dtm,lnm+": შეხსენების თარიღი არ არის მითითებული"));
                ContractclosingManager.getInstance().save(cb);
            }
            else if (request.getParameter("takedate_"+ins)!=null)
            {
                str2date(request.getParameter("takedate_"+ins),lnm+": წაღების თარიღი არ არის მითითებული");
                str2time(request.getParameter("taketime_"+ins),lnm+": წაღების დრო არ არის მითითებული");
                if (request.getParameter("takeperson_"+ins)==null || request.getParameter("takeperson_"+ins).length()==0)
                    throw new Exception(trs.t(lnm+": არ არის მითითებული ვინ წაიღო!"));
                String[] ids = request.getParameterValues("takeperson_"+ins);
                    
                String dtm = request.getParameter("takedate_"+ins)+" "+request.getParameter("taketime_"+ins);
                cb.setIsinfo(true);
                cb.setTakedate(str2datetime(dtm,lnm+": წაღების თარიღი არ არის მითითებული"));
                cb.setPersonels(StringUtils.join(ids,","));
                ContractclosingManager.getInstance().save(cb);
            }
        }
        
        /*
        ContractsampletypeBean[] sams = ContractsampletypeManager.getInstance().loadByContractid(cid);
        for(int i=0;i<sams.length;i++){
            if(actid > 0)            sams[i].setActid(actid);
            if(appealid > 0)         sams[i].setAppealid(appealid);
            sams[i] = ContractsampletypeManager.getInstance().save(sams[i]);
        }
        */
        rspJsonMessage(response, "OK", trs.t("ნიმუშები გადაცემულია."));
    }
    else if(oper.equalsIgnoreCase("sendcontract"))
    {
        long cid = Long.parseLong(request.getParameter("contractid"));
        long appealid = 0;
        try{ appealid = Long.parseLong(request.getParameter("appealid")); }catch(Exception ign){}
        long actid = 0;
        try{ actid = Long.parseLong(request.getParameter("actid")); }catch(Exception ign){}
        ContractBean obj = ContractManager.getInstance().loadByPrimaryKey(cid);
        obj.setStatus(3);
        ContractManager.getInstance().save(obj);
        String sql = "where contractsampleitemid in ("
                + "select i.contractsampleitemid from contractsampleitem i, contractsampletype t where i.contractsampletypeid = t.contractsampletypeid and t.deleted = false and ";
        if(appealid > 0) sql += " appealid = "+appealid;
        else if(actid > 0) sql += " actid = "+actid;
        else sql += " contractid = "+cid;
        sql += ")";
        ContractsampleitemBean[] items = ContractsampleitemManager.getInstance().loadByWhere(sql);
        for(int i=0;i<items.length;i++){
            if(TransitsampleitemManager.getInstance().countWhere("where contractsampleitemid = "+items[i].getContractsampleitemid()) == 0){
                //ContractsampletypeBean cb = ContractsampletypeManager.getInstance().loadByPrimaryKey(items[i].getContractsampletypeid());
                int instid = 0;
                if(items[i].getParentid() != null){
                    SampleitemreseachBean[] sr = SampleitemreseachManager.getInstance().loadByContractsampleitemid(items[i].getContractsampleitemid());
                    if(sr.length == 0)
                        throw new Exception(trs.t("კვლევა არაა დანიშნული "+items[i].getBarcode()+"-ზე"));
                    if(sr[0].getInstitutionid() == null)
                        throw new Exception(trs.t("კვლევა არაა დანიშნული "+items[i].getBarcode()+"-ზე"));
                    instid = sr[0].getInstitutionid();
                }
                TransitsampleitemBean tb = TransitsampleitemManager.getInstance().createTransitsampleitemBean();
                tb.setContractsampleitemid(items[i].getContractsampleitemid());
                tb.setLocationid(instid);
                tb.setOutside(false);
                tb.setRegbyid(user.getPersonellid());
                tb.setStatus(1);
                tb = TransitsampleitemManager.getInstance().save(tb);
            }
        }
        //TransitsampleitemBean[] tr = TransitsampleitemManager.getInstance().loadByWhere(sql);
        
        
        rspJsonMessage(response, "OK", trs.t("მონაცემები დამახსოვრებულია."));
    }
    else
        throw new Exception(trs.t("ოპერაციის კოდი არასწორია!"));

    Manager.getInstance().endTransaction(true);
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    rspJsonMessage(response, "ER", e.getMessage());
}
out.flush();
%>       