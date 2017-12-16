<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
JSONObject res = new JSONObject();
Manager.getInstance().beginTransaction();
try{
    String oper = request.getParameter("oper");
    int id = 0;
    if(oper.equalsIgnoreCase("del")){
        id = Integer.parseInt(request.getParameter("id"));
        SampletypeManager.getInstance().deleteByPrimaryKey(id);
    } else if(oper.equalsIgnoreCase("edit")){
        id = Integer.parseInt(request.getParameter("id"));
        SampletypeBean msg = SampletypeManager.getInstance().loadByPrimaryKey(id);
        String name = request.getParameter("name").trim();
        msg.setName(name);
        msg = SampletypeManager.getInstance().save(msg);
    } else if(oper.equalsIgnoreCase("add")){
        SampletypeBean msg = SampletypeManager.getInstance().createSampletypeBean();
        String name = request.getParameter("name").trim();
        msg.setName(name);
        msg.setCompanyid(user.getCompanyid());
        msg = SampletypeManager.getInstance().save(msg);
        id = msg.getSampletypeid().intValue();
    }
    res.put("id",id);
    res.put("result",1);
    Manager.getInstance().endTransaction(true);
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>
