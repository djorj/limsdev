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

        DeviceBean ptp = DeviceManager.getInstance().loadByPrimaryKey(new Integer(sid));
        try{
            DeviceManager.getInstance().deleteByPrimaryKey(ptp.getDeviceid());
        }catch(Exception e)
        {
            e.printStackTrace();
            throw new Exception("აპარატურის წაშლა შეუძლებელია!");
        }
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        DeviceBean ptp = DeviceManager.getInstance().loadByPrimaryKey(new Integer(sid));
        
        String name = (request.getParameter("name")).trim();
        String model = (request.getParameter("model")).trim();
        String sn = (request.getParameter("sn")).trim();
        String screatedate = (request.getParameter("createdate")).trim();
        String condition = (request.getParameter("condition")).trim();
        int institutionid = Integer.parseInt(request.getParameter("institutionid"));
        String hasplate = request.getParameter("hasplate");

        if(name.length() == 0)  throw new Exception("დასახელება ცარიელია!");
        if(DeviceManager.getInstance().countWhere("where deviceid != "+sid+" and institutionid = "+institutionid+" and upper(name) = '"+name.toUpperCase().replaceAll("'", "''") +"'") > 0)
            throw new Exception("აპარატურის სახელი "+name+" უკვე არსებობს!");
        
        ptp.setName(name);
        ptp.setConditioin(condition);
        ptp.setModel(model);
        ptp.setSn(sn);
        ptp.setInstitutionid(institutionid);
        if(hasplate.equalsIgnoreCase(trs.t("დიახ")))    ptp.setHasplate(true);
        else                                            ptp.setHasplate(false);
        try{
        ptp.setCreatedate(dt.parse(screatedate));
               }catch(Exception ex){
                   
               }
        
        ptp = DeviceManager.getInstance().save(ptp);
        
    } else if(oper.equalsIgnoreCase("add")){
        
        DeviceBean ptp = DeviceManager.getInstance().createDeviceBean();
        
        String name = (request.getParameter("name")).trim();
        String model = (request.getParameter("model")).trim();
        String sn = (request.getParameter("sn")).trim();
        String screatedate = (request.getParameter("createdate")).trim();
        String condition = (request.getParameter("condition")).trim();
        int institutionid = Integer.parseInt(request.getParameter("institutionid"));
        String hasplate = request.getParameter("hasplate");
        
        if(name.length() == 0)  throw new Exception("დასახელება ცარიელია!");
        if(DeviceManager.getInstance().countWhere("where institutionid = "+institutionid+" and upper(name) = '"+name.toUpperCase().replaceAll("'", "''") +"'") > 0)
            throw new Exception("აპარატურის სახელი "+name+" უკვე არსებობს!");
        
        ptp.setName(name);
        ptp.setConditioin(condition);
        ptp.setModel(model);
        ptp.setSn(sn);
        ptp.setInstitutionid(institutionid);
        if(hasplate.equalsIgnoreCase(trs.t("დიახ")))    ptp.setHasplate(true);
        else                                            ptp.setHasplate(false);
        try{
        ptp.setCreatedate(dt.parse(screatedate));
               }catch(Exception ex){
                   
               }
        
        ptp = DeviceManager.getInstance().save(ptp);
        sid = ptp.getDeviceid().toString();
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
