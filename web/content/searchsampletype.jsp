<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String name = request.getParameter("term").trim().replaceAll("'", "''").toUpperCase();
SampletypeBean[] recs = SampletypeManager.getInstance().loadByWhere("where companyid = "+user.getCompanyid()+" and upper(name) like '%"+name+"%'");
JSONArray js=new JSONArray();
for(int i=0;i<recs.length;i++){
    JSONObject object=new JSONObject();
    object.put("id",recs[i].getSampletypeid());
    object.put("value",trs.t(recs[i].getName()));
    js.add((JSONObject)object);
}
out.print(js.toString());
out.flush();
%>