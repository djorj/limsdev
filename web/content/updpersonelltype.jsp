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
        PersonelltypeBean ptp = PersonelltypeManager.getInstance().loadByPrimaryKey(new Integer(sid));
        if(PersonellManager.getInstance().countWhere("where personelltypeid = "+ptp.getPersonelltypeid()) > 0)
            throw new Exception("ჯერ წაშალეთ შესაბამისი თანამშრომელი");
        PlevelManager.getInstance().deleteByPersonelltypeid(ptp.getPersonelltypeid());
        PersonelltypeManager.getInstance().deleteByPrimaryKey(ptp.getPersonelltypeid());
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        PersonelltypeBean ptp = PersonelltypeManager.getInstance().loadByPrimaryKey(new Integer(sid));
        
        String name=request.getParameter("name").trim();
        String description=request.getParameter("description").trim();
        String code=request.getParameter("code").trim();
        
        if(name.length() == 0)  throw new Exception(trs.t("თანამდებობის დასახელება ცარიელია!"));
        if(code.length() == 0)  throw new Exception(trs.t("თანამდებობის კოდი ცარიელია!"));
        if(PersonelltypeManager.getInstance().countWhere("where companyid = "+user.getCompanyid()+" and personelltypeid != "+sid+" and upper(name) = '"+name.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("თანამდებობა სახელით ~NAME~ უკვე არსებობს!",name));
        if(PersonelltypeManager.getInstance().countWhere("where companyid = "+user.getCompanyid()+" and personelltypeid != "+sid+" and upper(code) = '"+code.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("კოდი ~NAME~ უკვე გამოყენებულია!",name));
        
        ptp.setCode(code);
        ptp.setName(name);
        ptp.setDescription(description);
        ptp.setCompanyid(user.getCompanyid());
        
        ptp = PersonelltypeManager.getInstance().save(ptp);
        
    } else if(oper.equalsIgnoreCase("add")){
        String name=request.getParameter("name").trim();
        String description=request.getParameter("description").trim();
        String code=request.getParameter("code").trim();
        
        if(name.length() == 0)  throw new Exception(trs.t("თანამდებობის დასახელება ცარიელია!"));
        if(code.length() == 0)  throw new Exception(trs.t("თანამდებობის კოდი ცარიელია!"));
        if(PersonelltypeManager.getInstance().countWhere("where companyid = "+user.getCompanyid()+" and upper(name) = '"+name.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("თანამდებობა სახელით ~NAME~ უკვე არსებობს!",name));
        if(PersonelltypeManager.getInstance().countWhere("where companyid = "+user.getCompanyid()+" and upper(code) = '"+code.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("კოდი ~NAME~ უკვე გამოყენებულია!",name));
        
        PersonelltypeBean ptp = PersonelltypeManager.getInstance().createPersonelltypeBean();
        ptp.setCode(code);
        ptp.setName(name);
        ptp.setDescription(description);
        ptp.setCompanyid(user.getCompanyid());
        ptp = PersonelltypeManager.getInstance().save(ptp);
        sid = ptp.getPersonelltypeid().toString();
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
