<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
JSONObject res = new JSONObject();
String sid = "0";
String oper = request.getParameter("oper");
Manager.getInstance().beginTransaction();
try{
    String platename = request.getParameter("platename");
    long pateid = Long.parseLong(request.getParameter("pateid"));
    long platetemplateid = Integer.parseInt(request.getParameter("platetemplateid"));
    JSONArray js = JSONArray.fromObject(request.getParameter("values"));

    PlatetemplateBean ptp = PlatetemplateManager.getInstance().loadByPrimaryKey(platetemplateid);
    DeviceBean[] devs = DeviceManager.getInstance().loadByWhere("where deviceid in (select deviceid from devicelabtest where labtestid = "+ptp.getLabtestid()+")");
    
    PlateBean plate = PlateManager.getInstance().createPlateBean();
    if(pateid > 0)
        plate = PlateManager.getInstance().loadByPrimaryKey(pateid);
    plate.setDeviceid(devs[0].getDeviceid());
    plate.setNum(platename);
    plate.setPlatetemplateid(platetemplateid);
    plate.setRegbyid(user.getPersonellid());
    plate.setPlatedate(new Date().getTime());
    plate = PlateManager.getInstance().save(plate);
    PlatemapManager.getInstance().deleteByPlateid(plate.getPlateid());
    
    for(int i=0;i<js.size();i++){
        JSONObject o = js.getJSONObject(i);
        String barcode = o.getString("barcode");
        if(barcode.length() > 0){
            PlatemapBean map = PlatemapManager.getInstance().createPlatemapBean();
            map.setPlateid(plate.getPlateid());
            map.setWellno(o.getString("wellno"));
            map.setBarcode(barcode);
            map = PlatemapManager.getInstance().save(map);
        }
    }
    if(request.getParameter("print") != null && request.getParameter("print").equalsIgnoreCase("true")){
        res.put("fname", "content/plateformpdf.jsp?plateid="+plate.getPlateid()+"&labtestid="+request.getParameter("labtestid"));
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
