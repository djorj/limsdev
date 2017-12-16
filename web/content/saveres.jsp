<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
JSONObject res = new JSONObject();
Manager.getInstance().beginTransaction();
try{
    Vector v = (Vector)session.getAttribute("UPLOADEDRESULTS");
    if(v == null)   v = new Vector();
    JSONArray ar = (JSONArray)session.getAttribute("UPLOADEDRESULTSARRAY");
    boolean passed = (java.lang.Boolean)session.getAttribute("UPLOADEDCONTROLSPASSED");
    for(int i=0;i<v.size();i++){
        DeviceresultBean dr = (DeviceresultBean)v.elementAt(i);
        if(dr.getSampleitemreseachid() == null)    continue;
        JSONObject result = JSONObject.fromObject(dr.getResult());
        SampleitemreseachBean item = SampleitemreseachManager.getInstance().loadByPrimaryKey(dr.getSampleitemreseachid());
        LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(item.getLabtestid());
System.out.println("labtest.getRestypeid() = "+labtest.getRestypeid());
        if(labtest.getRestypeid().intValue() == 2){
            item.setResult(result.getString("quantitative"));
            item.setNresult(new Double(result.getString("quantitative")));
        } else if(labtest.getRestypeid().intValue() == 1){
            if(result.getString("qualitative").toUpperCase().indexOf("POS") >= 0)  {
                if(item.getBresult() != null){
                    boolean bval = item.getBresult().booleanValue();
                    if(bval)    item.setBresult(true);
                    else        item.setBresult(true);
                } else item.setBresult(true);
            }
            else if(result.getString("qualitative").toUpperCase().indexOf("NEG") >= 0)  {
                if(item.getBresult() != null){
                    boolean bval = item.getBresult().booleanValue();
                    if(bval)    item.setBresult(true);
                    else        item.setBresult(false);
                } else item.setBresult(false);
            }
            item.setResult(result.getString("qualitative"));
        } else {
            item.setResult(result.getString("qualitative")+" "+result.getString("quantitative"));
            item.setTresult(result.getString("qualitative")+" "+result.getString("quantitative"));
        }
        item.setDeviceid(dr.getDeviceid());
        item.setResultDatetime(dr.getResultdate());
        item.setRegbyid(user.getPersonellid());
        if(passed)  item.setQualitycontrolAnswer(trs.t("გაიარა"));
        else        item.setQualitycontrolAnswer(trs.t("ვერ გაიარა"));
        item.setQualitycontrolDatetime(dr.getResultdate());
        item.setQualitycontrolPerson(user.getPersonellid());
        item = SampleitemreseachManager.getInstance().save(item);
        result.put("alldata", ar);
        dr.setResult(result.toString());
        dr = DeviceresultManager.getInstance().save(dr);
        v.setElementAt((DeviceresultBean)dr, i);
    }
    session.setAttribute("UPLOADEDRESULTS",(Vector)v);
    
    
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

