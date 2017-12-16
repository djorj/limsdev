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
        LabtestBean ptp = LabtestManager.getInstance().loadByPrimaryKey(new Integer(sid));
        //if(StockmovementManager.getInstance().countWhere("where mcontragentid = "+ptp.getContragentid()) > 0)
        //    throw new Exception(trs.t("წაშლა შეუძლებელია - კონტრაგენტი გამოყენებულია"));
        LabtestManager.getInstance().deleteByPrimaryKey(ptp.getLabtestid());
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        LabtestBean ptp = LabtestManager.getInstance().loadByPrimaryKey(new Integer(sid));
        
        String name = request.getParameter("name").trim();
        String description = request.getParameter("description").trim();
        int testcategoryid = Integer.parseInt(request.getParameter("testcategoryid"));
        int type = Integer.parseInt(request.getParameter("type"));
        int unitsid = Integer.parseInt(request.getParameter("unitsid"));
        int restypeid = Integer.parseInt(request.getParameter("restypeid"));
        
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        if(LabtestManager.getInstance().countWhere("where labtestid != "+sid+" and testcategoryid = "+testcategoryid+" and companyid = "+user.getCompanyid()+" and upper(name) = '"+name.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("ტესტი სახელით ~NAME~ უკვე არსებობს!",name));
                
        if(type == 1) {
            ptp.setGrp(false);
            ptp.setCtr(false);
        } else if(type == 2) {
            ptp.setGrp(true);
            ptp.setCtr(false);
        } else if(type == 3) {
            ptp.setGrp(false);
            ptp.setCtr(true);
        }
        ptp.setDescription(description);
        ptp.setAbbreviation("");
        ptp.setCode("");
        ptp.setName(name);
        ptp.setTestcategoryid(testcategoryid);
        if(unitsid > 0)        ptp.setUnitsid(unitsid);
        ptp.setRestypeid(restypeid);
        ptp = LabtestManager.getInstance().save(ptp);
        
    } else if(oper.equalsIgnoreCase("add")){
        LabtestBean ptp = LabtestManager.getInstance().createLabtestBean();
        
        String name = request.getParameter("name").trim();
        String description = request.getParameter("description").trim();
        int testcategoryid = Integer.parseInt(request.getParameter("testcategoryid"));
        int type = Integer.parseInt(request.getParameter("type"));
        int unitsid = Integer.parseInt(request.getParameter("unitsid"));
        int restypeid = Integer.parseInt(request.getParameter("restypeid"));
        
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        if(LabtestManager.getInstance().countWhere("where testcategoryid = "+testcategoryid+" and companyid = "+user.getCompanyid()+" and upper(name) = '"+name.toUpperCase().replace("'", "''") +"'") > 0)
            throw new Exception(trs.t("ტესტი სახელით ~NAME~ უკვე არსებობს!",name));
                
        if(type == 1) {
            ptp.setGrp(false);
            ptp.setCtr(false);
        } else if(type == 2) {
            ptp.setGrp(true);
            ptp.setCtr(false);
        } else if(type == 3) {
            ptp.setGrp(false);
            ptp.setCtr(true);
        }
        ptp.setDescription(description);
        ptp.setAbbreviation("");
        ptp.setCode("");
        ptp.setName(name);
        ptp.setTestcategoryid(testcategoryid);
        if(unitsid > 0)        ptp.setUnitsid(unitsid);
        ptp.setRestypeid(restypeid);
        ptp.setCompanyid(user.getCompanyid());
        ptp = LabtestManager.getInstance().save(ptp);
        sid = ptp.getLabtestid().toString();
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
