<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
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
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        ContragentBean ptp = ContragentManager.getInstance().loadByPrimaryKey(new Long(sid));
        
        int contragenttypeid = Integer.parseInt(request.getParameter("contragenttypeid"));
        String name = request.getParameter("name").trim();
        String idn = request.getParameter("idn").trim();
        String address = request.getParameter("address").trim();
        String phone = request.getParameter("phone").trim();
        String email = request.getParameter("email").trim();
        String url = request.getParameter("url").trim();
        String contact = request.getParameter("contact").trim();
        String bankdata = request.getParameter("bankdata").trim();
        String note = request.getParameter("note").trim();
        
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        if(ContragentManager.getInstance().countWhere("where companyid = "+user.getCompanyid()+" and contragentid != "+sid+" and upper(name) = '"+name.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("კონტრაგენტი სახელით ~NAME~ უკვე არსებობს!",name));
        if(ContragentManager.getInstance().countWhere("where companyid = "+user.getCompanyid()+" and contragentid != "+sid+" and upper(idn) = '"+idn.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("კონტრაგენტი ნომრით ~NAME~ უკვე არსებობს!",idn));
        
        ptp.setAddress(address);
        ptp.setBankdata(bankdata);
        ptp.setContact(contact);
        ptp.setContragenttypeid(contragenttypeid);
        ptp.setEmail(email);
        ptp.setIdn(idn);
        ptp.setName(name);
        ptp.setNote(note);
        ptp.setPhone(phone);
        ptp.setUrl(url);
        ptp.setType(2);
        ptp.setCompanyid(user.getCompanyid());
        ptp = ContragentManager.getInstance().save(ptp);
        
    } else if(oper.equalsIgnoreCase("add")){
        ContragentBean ptp = ContragentManager.getInstance().createContragentBean();
        
        int contragenttypeid = Integer.parseInt(request.getParameter("contragenttypeid"));
        String name = request.getParameter("name").trim();
        String idn = request.getParameter("idn").trim();
        String address = request.getParameter("address").trim();
        String phone = request.getParameter("phone").trim();
        String email = request.getParameter("email").trim();
        String url = request.getParameter("url").trim();
        String contact = request.getParameter("contact").trim();
        String bankdata = request.getParameter("bankdata").trim();
        String note = request.getParameter("note").trim();
        
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        if(ContragentManager.getInstance().countWhere("where companyid = "+user.getCompanyid()+" and upper(name) = '"+name.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("კონტრაგენტი სახელით ~NAME~ უკვე არსებობს!",name));
        if(ContragentManager.getInstance().countWhere("where companyid = "+user.getCompanyid()+" and upper(idn) = '"+idn.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("კონტრაგენტი ნომრით ~NAME~ უკვე არსებობს!",idn));
        
        ptp.setAddress(address);
        ptp.setBankdata(bankdata);
        ptp.setContact(contact);
        ptp.setContragenttypeid(contragenttypeid);
        ptp.setEmail(email);
        ptp.setIdn(idn);
        ptp.setName(name);
        ptp.setNote(note);
        ptp.setPhone(phone);
        ptp.setUrl(url);
        ptp.setType(2);
        ptp.setCompanyid(user.getCompanyid());
        ptp = ContragentManager.getInstance().save(ptp);
        sid = ptp.getContragentid().toString();
    }

    Manager.getInstance().endTransaction(true);
    res.put("result",1);
    res.put("id",sid);
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>
