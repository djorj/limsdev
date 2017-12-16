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
        TestcategoryBean ptp = TestcategoryManager.getInstance().loadByPrimaryKey(new Integer(sid));
        //if(StockmovementManager.getInstance().countWhere("where mcontragentid = "+ptp.getContragentid()) > 0)
        //    throw new Exception(trs.t("წაშლა შეუძლებელია - კონტრაგენტი გამოყენებულია"));
        TestcategoryManager.getInstance().deleteByPrimaryKey(ptp.getTestcategoryid());
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        TestcategoryBean ptp = TestcategoryManager.getInstance().loadByPrimaryKey(new Integer(sid));
        
        String name = request.getParameter("name").trim();
        
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        if(TestcategoryManager.getInstance().countWhere("where testcategoryid != "+sid+" and companyid = "+user.getCompanyid()+" and upper(name) = '"+name.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("კატეგორია სახელით ~NAME~ უკვე არსებობს!",name));
        
        ptp.setName(name);
        ptp = TestcategoryManager.getInstance().save(ptp);
        
    } else if(oper.equalsIgnoreCase("add")){
        TestcategoryBean ptp = TestcategoryManager.getInstance().createTestcategoryBean();
        
        String name = request.getParameter("name").trim();
        
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        if(TestcategoryManager.getInstance().countWhere("where companyid = "+user.getCompanyid()+" and upper(name) = '"+name.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("კატეგორია სახელით ~NAME~ უკვე არსებობს!",name));
        
        ptp.setName(name);
        ptp.setCompanyid(user.getCompanyid());
        ptp = TestcategoryManager.getInstance().save(ptp);
        sid = ptp.getTestcategoryid().toString();
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
