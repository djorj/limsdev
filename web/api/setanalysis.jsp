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
try{
    if (oper.equalsIgnoreCase("del"))
    {
        //ContractanalysisManager.getInstance().deleteByPrimaryKey(Long.parseLong(request.getParameter("id")));
        SampleitemreseachBean samres = SampleitemreseachManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        samres.setDeleted(true);
        SampleitemreseachManager.getInstance().save(samres);
        rspJsonMessage(response, "OK", trs.t("ჩანაწერი  წაიშალა."));
        
    } 
    else if (oper.equalsIgnoreCase("status"))
    {
//        ContractanalysisBean ptp = ContractanalysisManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
//        ptp.setStatus(Integer.parseInt(request.getParameter("status")));
//        ptp = ContractanalysisManager.getInstance().save(ptp);
        SampleitemreseachBean samres = SampleitemreseachManager.getInstance().loadByPrimaryKey(Long.parseLong(request.getParameter("id")));
        samres.setStatus(Integer.parseInt(request.getParameter("status")));
        SampleitemreseachManager.getInstance().save(samres);
        rspJsonMessage(response, "OK", trs.t("ჩანაწერის სტატუსი შეიცვალა."));
    } 
    else if(oper.equalsIgnoreCase("edit"))
    {
        
        System.out.println("Edit Analysis>>>>");
        String tmp[] = request.getParameter("id").trim().split("\\.");
        int labtestid    = Integer.parseInt(tmp[0]);
        int sampleid     = Integer.parseInt(tmp[1]);
        int institutionid = Integer.parseInt(request.getParameter("institutionid"));
        long contractid   = Long.parseLong(request.getParameter("contractid"));
        
        PriceBean[] prc = PriceManager.getInstance().loadByLabtestid(labtestid);
        ContractanalysisBean[] ptp = ContractanalysisManager.getInstance().loadByWhere("WHERE labtestid="+labtestid+" AND sampletypeid="+sampleid+" AND contractid="+contractid);
        if (ptp.length>0)
        {
            ptp[0].setInstitutionid(institutionid);
            ptp[0].setLabtestid(labtestid);
            ptp[0].setSampletypeid(sampleid);
            ptp[0].setContractid(contractid);
            ptp[0].setPrice(prc.length>0 ? prc[0].getPrice() : 0.0);
//            ptp[0].setEnddays(Integer.parseInt(request.getParameter("enddays")));
        
            ptp[0].setRegbyid(user.getPersonellid());
            ptp[0] = ContractanalysisManager.getInstance().save(ptp[0]);
            sid = ptp[0].getContractanalysisid().toString();
            rspJsonMessage(response, "OK", trs.t("ჩანაწერი  განახლებულია."),sid);
        }
        else
        {
            ContractanalysisBean pt2 = ContractanalysisManager.getInstance().createContractanalysisBean();
            pt2.setInstitutionid(institutionid);
            pt2.setLabtestid(labtestid);
            pt2.setSampletypeid(sampleid);
            pt2.setContractid(contractid);
            pt2.setPrice(prc.length>0 ? prc[0].getPrice() : 0.0);
            pt2.setEnddays(2);
            pt2.setRegbyid(user.getPersonellid());
            pt2.setStatus(1);
            pt2.setDeleted(false);
            pt2 = ContractanalysisManager.getInstance().save(pt2);
            sid = pt2.getContractanalysisid().toString();
            rspJsonMessage(response, "OK", trs.t("ჩანაწერი  დამატებულია."),sid);
        }
    } else if(oper.equalsIgnoreCase("add")){
        System.out.println("Add Analysis>>>>");
        ContractanalysisBean ptp = ContractanalysisManager.getInstance().createContractanalysisBean();
        
        ptp.setContractid(Long.parseLong(request.getParameter("contractid")));
        ptp.setLabtestid(Integer.parseInt(request.getParameter("labtestid")));
//      ptp.setSampletypeid(Integer.parseInt(request.getParameter("sampleid")));
        ptp.setPrice(0.0);
        ptp.setEnddays(5);
        ptp.setRegbyid(user.getPersonellid());
        ptp = ContractanalysisManager.getInstance().save(ptp);
        sid = ptp.getContractanalysisid().toString();
        rspJsonMessage(response, "OK", trs.t("ანალიზი დამატებულია."),sid);
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