<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
JSONObject res = new JSONObject();
Manager.getInstance().beginTransaction();
try{
    int gid = Integer.parseInt(request.getParameter("gid"));
    int lid = Integer.parseInt(request.getParameter("lid"));
    
    TestgroupBean dl = TestgroupManager.getInstance().loadByPrimaryKey(gid, lid);
    if(dl == null){
        dl = TestgroupManager.getInstance().createTestgroupBean();
        dl.setTestgroupid(gid);
        dl.setLabtestid(lid);
        dl = TestgroupManager.getInstance().save(dl);
    } else TestgroupManager.getInstance().deleteByPrimaryKey(gid, lid);
    
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

