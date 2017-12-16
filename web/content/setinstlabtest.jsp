<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
JSONObject res = new JSONObject();
Manager.getInstance().beginTransaction();
try{
    int iid = Integer.parseInt(request.getParameter("iid"));
    int lid = Integer.parseInt(request.getParameter("lid"));
System.out.println(iid+"; "+lid);    
    LabtestinstitutionBean dl = LabtestinstitutionManager.getInstance().loadByPrimaryKey(lid, iid);
    if(dl == null){
        dl = LabtestinstitutionManager.getInstance().createLabtestinstitutionBean();
        dl.setInstitutionid(iid);
        dl.setLabtestid(lid);
        dl = LabtestinstitutionManager.getInstance().save(dl);
    } else LabtestinstitutionManager.getInstance().deleteByPrimaryKey(lid, iid);
    
    Manager.getInstance().endTransaction(true);
    res.put("result",1);
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>

