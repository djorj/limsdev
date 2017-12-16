<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String term = (request.getParameter("term")).replaceAll("'", "''").toUpperCase();
ContragentBean[] objs = ContragentManager.getInstance().loadByWhere("where (upper(name) like '%"+term+"%' or upper(idn) like '%"+term+"%') ");

JSONArray js=new JSONArray();
for(int i=0;i<objs.length;i++){
    JSONObject ob = new JSONObject();
    ob.put("idn", objs[i].getIdn());
    ob.put("name", objs[i].getName());
    ob.put("label",objs[i].getIdn() + "; " + objs[i].getName());
    ob.put("contragentid", objs[i].getContragentid());
    js.add(ob);
}
out.print(js.toString());
out.flush();
%>
