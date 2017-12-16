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
    long id = Long.parseLong(request.getParameter("id"));
    SampleitemreseachBean research = SampleitemreseachManager.getInstance().loadByPrimaryKey(id);
    LabtestBean[] controls = LabtestManager.getInstance().loadByWhere("where labtestid in (select controlid from labtestcontrol where labtestid = "+research.getLabtestid()+" and schedule not like '%\"val\":\"1\"%')");
    
    if(oper.equalsIgnoreCase("del")){

        rspJsonMessage(response, "OK", trs.t("ოპერაცია შესრულებულია."));
        
    } else if(oper.equalsIgnoreCase("edit")){
        String qualitycontrolresult = "";
        String pos = "";
        String neg = "";
        for(int i=0;i<controls.length;i++){
            //if(controls[i].getRestypeid().intValue() == 1)
            String val = request.getParameter("labtestid_"+controls[i].getLabtestid());
            if(controls[i].getRestypeid().intValue() == 1){
                if(controls[i].getName().indexOf("დადებითი") >= 0)
                    pos = val;
                if(controls[i].getName().indexOf("უარყოფითი") >= 0)
                    neg = val;
                if(val.equals("1"))
                    qualitycontrolresult = "გაიaრა";
                if(val.equals("2"))
                    qualitycontrolresult = "ვერ გაიარა";
            }
        }
        
        String lot       = request.getParameter("lot");
        String device    = request.getParameter("device");
        String person    = request.getParameter("person");
        //String positive  = request.getParameter("positive").trim();
        //String negative  = request.getParameter("negative").trim();
        String info      = request.getParameter("info").trim();
        String qcdatetime= request.getParameter("crdate").trim()+" "+request.getParameter("crtime").trim();
        
        if (person.isEmpty())
            throw new Exception(trs.t("ვინ ჩაატარა არჩეული არ არის!"));
        
        str2date(request.getParameter("crdate").trim(),"ჩატარების თარიღი არ არის მითითებული");
        str2time(request.getParameter("crtime").trim(),"ჩატარების დრო არ არის მითითებული");


        String[] codes = request.getParameterValues("barcode");
        if (codes == null || codes.length==0)
            throw new Exception(trs.t("ბარკოდი შეტანილი არ არის!"));
        
        for (int i=0; i<codes.length; i++)
        {
            long itemid = Long.parseLong(codes[i]); 
            QualitycontrolManager.getInstance().deleteByContractsampleitemid(itemid);
            SampleitemreseachBean[] rsh = SampleitemreseachManager.getInstance().loadByContractsampleitemid(itemid);
            if (rsh.length==0)
                throw new Exception("#"+codes[i]+" - "+trs.t("ბარკოდისთვის დანიშნული ტესტი არ მოიძებნა!"));
                
            QualitycontrolBean ptp = QualitycontrolManager.getInstance().createQualitycontrolBean();
            ptp.setContractsampleitemid(itemid);
            ptp.setQcPerson(Integer.parseInt(person));
            ptp.setQcDatetime(str2datetime(qcdatetime, "ჩატარების თარიღი და დრო არასწორია"));
            ptp.setLot(lot);
            ptp.setInfo(info);
            ptp.setPositive(pos);
            ptp.setNegative(neg);
            ptp.setRegbyid(user.getPersonellid());
            if (!device.isEmpty() || !device.equals("0"))
                ptp.setDeviceid(Integer.parseInt(device));
            ptp = QualitycontrolManager.getInstance().save(ptp);
            
            rsh[0].setQualitycontrolDatetime(ptp.getQcDatetime());
            rsh[0].setQualitycontrolPerson(ptp.getQcPerson());
            rsh[0].setQualitycontrolAnswer(qualitycontrolresult);
            rsh[0] = SampleitemreseachManager.getInstance().save(rsh[0]);
        }
        rspJsonMessage(response, "OK", trs.t("ოპერაცია შესრულებულია."));
        
    } else if(oper.equalsIgnoreCase("add")){
        String qualitycontrolresult = "";
        String pos = "";
        String neg = "";
        for(int i=0;i<controls.length;i++){
            //if(controls[i].getRestypeid().intValue() == 1)
            String val = request.getParameter("labtestid_"+controls[i].getLabtestid());
            if(controls[i].getRestypeid().intValue() == 1){
                if(controls[i].getName().indexOf("დადებითი") >= 0)
                    pos = val;
                if(controls[i].getName().indexOf("უარყოფითი") >= 0)
                    neg = val;
                if(val.equals("1"))
                    qualitycontrolresult = "გაიaრა";
                if(val.equals("2"))
                    qualitycontrolresult = "ვერ გაიარა";
            }
        }
        
        String lot       = request.getParameter("lot");
        String device    = request.getParameter("device");
        String person    = request.getParameter("person");
        //String positive  = request.getParameter("positive").trim();
        //String negative  = request.getParameter("negative").trim();
        String info      = request.getParameter("info").trim();
        String qcdatetime= request.getParameter("crdate").trim()+" "+request.getParameter("crtime").trim();
        
        if (person.isEmpty())
            throw new Exception(trs.t("ვინ ჩაატარა არჩეული არ არის!"));
        
        str2date(request.getParameter("crdate").trim(),"ჩატარების თარიღი არ არის მითითებული");
        str2time(request.getParameter("crtime").trim(),"ჩატარების დრო არ არის მითითებული");


        String[] codes = request.getParameterValues("barcode");
        if (codes == null || codes.length==0)
            throw new Exception(trs.t("ბარკოდი შეტანილი არ არის!"));
        
        for (int i=0; i<codes.length; i++)
        {
            long itemid = Long.parseLong(codes[i]); 
            SampleitemreseachBean[] rsh = SampleitemreseachManager.getInstance().loadByContractsampleitemid(itemid);
            if (rsh.length==0)
                throw new Exception("#"+codes[i]+" - "+trs.t("ბარკოდისთვის დანიშნული ტესტი არ მოიძებნა!"));
                
            QualitycontrolBean ptp = QualitycontrolManager.getInstance().createQualitycontrolBean();
            ptp.setContractsampleitemid(itemid);
            ptp.setQcPerson(Integer.parseInt(person));
            ptp.setQcDatetime(str2datetime(qcdatetime, "ჩატარების თარიღი და დრო არასწორია"));
            ptp.setLot(lot);
            ptp.setInfo(info);
            ptp.setPositive(pos);
            ptp.setNegative(neg);
            ptp.setRegbyid(user.getPersonellid());
            if (!device.isEmpty() || !device.equals("0"))
                ptp.setDeviceid(Integer.parseInt(device));
            ptp = QualitycontrolManager.getInstance().save(ptp);
            
            rsh[0].setQualitycontrolDatetime(ptp.getQcDatetime());
            rsh[0].setQualitycontrolPerson(ptp.getQcPerson());
            rsh[0].setQualitycontrolAnswer(qualitycontrolresult);
            rsh[0] = SampleitemreseachManager.getInstance().save(rsh[0]);
            
        }
        rspJsonMessage(response, "OK", trs.t("ოპერაცია შესრულებულია."));
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