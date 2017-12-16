<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
String name = request.getParameter("term").trim().replaceAll("'", "''").toUpperCase();
ProductBean[] products = ProductManager.getInstance().loadByWhere("where upper(name) like '%"+name+"%'");
JSONArray js=new JSONArray();
for(int i=0;i<products.length;i++){
    PunitBean punit = PunitManager.getInstance().loadByPrimaryKey(products[i].getPunitid());
    JSONObject object=new JSONObject();
    object.put("id",products[i].getProductid());
    object.put("unitname",trs.t(punit.getName()));
    object.put("value",trs.t(products[i].getName()));
    js.add((JSONObject)object);
}
out.print(js.toString());
out.flush();
%>