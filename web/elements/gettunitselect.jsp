<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
int countryid = Integer.parseInt(request.getParameter("countryid"));
String sz = request.getParameter("sz");
if(sz.length() > 0) sz = "-"+sz;
String label = request.getParameter("label");
String idname = request.getParameter("idname");
int punitid = 0;
if(request.getParameter("punitid") != null)
    punitid = Integer.parseInt(request.getParameter("punitid"));
int selid = Integer.parseInt(request.getParameter("selid"));
String sql = "where countryid = "+countryid+" and punitid";
if(punitid > 0) sql += " = "+punitid;
else            sql += " is null";
sql += " order by name";
TunitBean[] tunits = TunitManager.getInstance().loadByWhere(sql);
%>
<label class="select">
    <select class="input<%=sz%> req" id="<%=idname%>" onchange="<%=idname%>changed($(this).val());" style="width: 250px;">
        <option value="0">-- <%=label%> --</option>
        <%
        for(int i=0;i<tunits.length;i++){
            String sel = "";
            if(selid == tunits[i].getTunitid().intValue())
                sel = "selected";
        %>
        <option value="<%=tunits[i].getTunitid()%>"><%=tunits[i].getName()%></option>
        <%
        }
        %>
    </select> 
    <i></i> 
</label>