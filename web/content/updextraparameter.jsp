<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
JSONObject res = new JSONObject();
String sid = "0";
String oper = request.getParameter("oper");
Manager.getInstance().beginTransaction();
try{
    String op = request.getParameter("op");
    int sampletypeid = 0;
    int labtestid = 0;
    String where = "";
    if(op.equalsIgnoreCase("sampletype")){
        sampletypeid = Integer.parseInt(request.getParameter("sampletypeid"));
        where = "where sampletypeid = "+sampletypeid;
    } else if(oper.equalsIgnoreCase("labtest")){
        labtestid = Integer.parseInt(request.getParameter("labtestid"));
        where = "where labtestid = "+labtestid;
    }
    if(oper.equalsIgnoreCase("del")){
        sid = request.getParameter("id");
        if(ExtravalManager.getInstance().countWhere("where extraparamid = "+sid) > 0)
            throw new Exception(trs.t("წაშლა შეულებელია - პარამეტერი გამოყენებულია ხელშეკრულებაში"));
        ExtraparamManager.getInstance().deleteByPrimaryKey(new Long(sid));
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        String name = request.getParameter("name").trim();
        if(name.length() == 0)
            throw new Exception(trs.t("დასახელება ცარიელია"));
        if(ExtraparamManager.getInstance().countWhere(where+" and extraparamid != "+sid+" and upper(name) = '"+name.toUpperCase().replaceAll("'", "''") +"'") > 0)
            throw new Exception(trs.t("დასახელება მეორდება"));
        String description = request.getParameter("description").trim();
        int restypeid = Integer.parseInt(request.getParameter("restypeid"));
        ExtraparamBean eb = ExtraparamManager.getInstance().loadByPrimaryKey(new Long(sid));
        eb.setDescription(description);
        eb.setRestypeid(restypeid);
        eb.setName(name);
        eb = ExtraparamManager.getInstance().save(eb);
    } else if(oper.equalsIgnoreCase("add")){
        String name = request.getParameter("name").trim();
        if(name.length() == 0)
            throw new Exception(trs.t("დასახელება ცარიელია"));
        if(ExtraparamManager.getInstance().countWhere(where+" and upper(name) = '"+name.toUpperCase().replaceAll("'", "''") +"'") > 0)
            throw new Exception(trs.t("დასახელება მეორდება"));
        String description = request.getParameter("description").trim();
        int restypeid = Integer.parseInt(request.getParameter("restypeid"));
        ExtraparamBean eb = ExtraparamManager.getInstance().createExtraparamBean();
        eb.setDescription(description);
        eb.setRestypeid(restypeid);
        eb.setName(name);
        if(sampletypeid > 0)    eb.setSampletypeid(sampletypeid);
        if(labtestid > 0)       eb.setLabtestid(labtestid);
        eb = ExtraparamManager.getInstance().save(eb);
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
