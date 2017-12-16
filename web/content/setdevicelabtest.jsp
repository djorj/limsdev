<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
JSONObject res = new JSONObject();
Manager.getInstance().beginTransaction();
try{
    int did = Integer.parseInt(request.getParameter("did"));
    int lid = Integer.parseInt(request.getParameter("lid"));
    DevicelabtestBean dl = DevicelabtestManager.getInstance().loadByPrimaryKey(did, lid);
    if(dl == null){
        dl = DevicelabtestManager.getInstance().createDevicelabtestBean();
        dl.setDeviceid(did);
        dl.setLabtestid(lid);
        dl = DevicelabtestManager.getInstance().save(dl);
    } else DevicelabtestManager.getInstance().deleteByPrimaryKey(did, lid);
    
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

