<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
JSONArray v = (JSONArray)session.getAttribute("NORMTXT");
if(v == null) v = new JSONArray();
if(request.getParameter("add") != null){
    JSONObject ob = new JSONObject();
    ob.put("name",request.getParameter("add").trim());
    ob.put("checked","");
    v.add(ob);
} else if(request.getParameter("norm") != null){
    int n = Integer.parseInt(request.getParameter("norm"));
    for(int i=0;i<v.size();i++){
        JSONObject ob = v.getJSONObject(i);
        if(i == n) ob.put("checked","checked");
        else ob.put("checked","");
    }
} else if(request.getParameter("del") != null){
    int n = Integer.parseInt(request.getParameter("del"));
    v.remove(n);
}
session.setAttribute("NORMTXT", (JSONArray)v);
if(v.size() > 0){
%>
<table class="table table-bordered table-hover">
    <thead>
        <tr>
            <th class="centered text-align-center" width="80%"><b><%=trs.t("დასახელება")%></b></th>
            <th class="centered text-align-center" width="15%"><b><%=trs.t("ნორმა")%></b></th>
            <th class="centered text-align-center"><b></b></th>
        </tr>
    </thead>
    <tbody>
<%
for(int i=0;i<v.size();i++){
    JSONObject ob = v.getJSONObject(i);
%>
        <tr>
            <td><%=trs.t(ob.getString("name"))%></td>
            <td class="centered text-align-center" align="center">
                    <label class="radio centered text-align-center" style="margin-left: 20px;">
                        <input name="normlist" id="normlist<%=i%>" type="radio" <%=ob.getString("checked")%>  onclick="setNorm(<%=i%>)"><i></i>
                    </label>
            </td>
            <td class="centered text-align-center">
                <i class="fa fa-close" style="cursor: pointer; color: #A90329;" onclick="delNorm(<%=i%>)"></i>
            </td>
        </tr>
<%}%>
    </tbody>
</table>
<%}%>
