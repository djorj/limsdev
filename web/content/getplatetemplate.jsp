<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
JSONObject js = new JSONObject();
long platetemplateid = Long.parseLong(request.getParameter("platetemplateid"));
if(platetemplateid > 0){
    PlatetemplateBean pl = PlatetemplateManager.getInstance().loadByPrimaryKey(platetemplateid);
    js.put("result",1);
    js.put("w",pl.getW());
    js.put("h",pl.getH());
    js.put("z",pl.getZdefault());
} else js.put("result",0);
out.print(js.toString());
out.flush();
%>
