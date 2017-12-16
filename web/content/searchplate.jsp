<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String term = (request.getParameter("term")).replaceAll("'", "''").toUpperCase();
PlateBean[] plates = PlateManager.getInstance().loadByWhere("where upper(num) like '%"+term+"%'");
System.out.println("select * from plate where upper(num) like '%"+term+"%'");
JSONArray js=new JSONArray();
for(int i=0;i<plates.length;i++){
    JSONObject object=new JSONObject();
    object.put("label",plates[i].getNum());
    object.put("value",plates[i].getPlateid());
    js.add((JSONObject)object);
    
    
//    js.add((String)icds[i].getName1() + "; " + icds[i].getCode());
}

out.println(js.toString());
out.flush();
%>

