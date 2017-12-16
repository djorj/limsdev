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
    if(oper.equalsIgnoreCase("del")){
        sid = request.getParameter("id");
        ContragentBean ptp = ContragentManager.getInstance().loadByPrimaryKey(new Long(sid));
        if(StockmovementManager.getInstance().countWhere("where mcontragentid = "+ptp.getContragentid()) > 0)
            throw new Exception(trs.t("წაშლა შეუძლებელია - კონტრაგენტი გამოყენებულია"));
        ContragentManager.getInstance().deleteByPrimaryKey(ptp.getContragentid());
        rspJsonMessage(response, "OK", trs.t("ოპერაცია შესრულებულია."));
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("contragentid");
        ContragentBean ptp = ContragentManager.getInstance().loadByPrimaryKey(new Long(sid));
        
        int contragenttypeid = Integer.parseInt(request.getParameter("contragenttypeid"));
        String name = request.getParameter("name").trim();
        String lname = request.getParameter("lname");
        String idn = request.getParameter("idn").trim();
        String address = request.getParameter("address").trim();
        String phone = request.getParameter("phone").trim();
        String email = request.getParameter("email").trim();
        String url = request.getParameter("url").trim();
        String contact = request.getParameter("contact").trim();
        String bankdata = request.getParameter("bankdata").trim();
        String note = request.getParameter("note").trim();
        String vat = request.getParameter("vat");
        
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        if(ContragentManager.getInstance().countWhere("where contragentid != "+sid+" and upper(name) = '"+name.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("კონტრაგენტი სახელით ~NAME~ უკვე არსებობს!",name));
        if(ContragentManager.getInstance().countWhere("where contragentid != "+sid+" and upper(idn) = '"+idn.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("კონტრაგენტი ნომრით ~NAME~ უკვე არსებობს!",idn));
        
        ptp.setAddress(address);
        ptp.setBankdata(bankdata);
        ptp.setContact(contact);
        ptp.setContragenttypeid(contragenttypeid);
        ptp.setEmail(email);
        ptp.setIdn(idn);
        if (contragenttypeid==1)
        {
            ptp.setName(name+" "+lname);
            ptp.setFname(name);
            ptp.setLname(lname);
        }
        else
        {
            ptp.setName(name);
            ptp.setFname("");
            ptp.setLname("");
        }
        ptp.setName(name);
        ptp.setNote(note);
        ptp.setPhone(phone);
        ptp.setUrl(url);
        ptp.setType(2);
        if(vat == null) ptp.setVat(false);
        else            ptp.setVat(true);
        ptp = ContragentManager.getInstance().save(ptp);
        rspJsonMessage(response, "OK", trs.t("ოპერაცია შესრულებულია."));
        
    } else if(oper.equalsIgnoreCase("add")){
        System.out.println("A");
        ContragentBean ptp = ContragentManager.getInstance().createContragentBean();
        System.out.println("B");
        
        String lname = request.getParameter("lname");
        String name     = request.getParameter("name").trim();
        String idn      = request.getParameter("idn").trim();
        String phone    = request.getParameter("phone").trim();
        String email    = request.getParameter("email").trim();
        String url      = request.getParameter("url").trim();
        String contact  = request.getParameter("contact").trim();
        String bankdata = request.getParameter("bankdata").trim();
        String note     = request.getParameter("note").trim();
        String region   = request.getParameter("region");
        String raion    = request.getParameter("raion");
        String city     = request.getParameter("city");
        String vat = request.getParameter("vat");
        
        if(request.getParameter("contragenttypeid").length() == 0)  
            throw new Exception(trs.t("ორგანიზაციის ტიპი არჩეული არ არის!"));
        if(name.length() == 0)  
            throw new Exception(trs.t("დასახელება ცარიელია!"));
        if(idn.length() == 0)  
            throw new Exception(trs.t("საიდენტიფიკაციო კოდი ცარიელია!"));
        if(ContragentManager.getInstance().countWhere("where upper(idn) = '"+idn.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("კონტრაგენტი ნომრით ~NAME~ უკვე არსებობს!",idn));


        try { ptp.setAddress(request.getParameter("address").trim());  } catch (Exception ign) {};
        try { ptp.setRegionid(Integer.parseInt(region)); } catch (Exception ign) {};
        try { ptp.setRaionid(Integer.parseInt(raion)); } catch (Exception ign) {};
        try {ptp.setVillageid(Integer.parseInt(city)); } catch (Exception ign) {};
        ptp.setBankdata(bankdata);
        ptp.setContact(contact);
        ptp.setContragenttypeid(Integer.parseInt(request.getParameter("contragenttypeid")));
        ptp.setEmail(email);
        ptp.setIdn(idn);
        if (ptp.getContragenttypeid()==1)
        {
            ptp.setName(name+" "+lname);
            ptp.setFname(name);
            ptp.setLname(lname);
        }
        else
        {
            ptp.setName(name);
            ptp.setFname("");
            ptp.setLname("");
        }
        ptp.setNote(note);
        ptp.setPhone(phone);
        ptp.setUrl(url);
        ptp.setType(2); 
        ptp.setCompanyid(user.getCompanyid());
        ptp.setRegbyid(user.getPersonellid());
        if(vat == null) ptp.setVat(false);
        else            ptp.setVat(true);
        ptp = ContragentManager.getInstance().save(ptp);
        sid = ptp.getContragentid().toString();
        rspJsonMessage(response, "OK", trs.t("კონტრაგენტი დამატებულია."),sid);
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