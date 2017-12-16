<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
int countryid = 76;
if(request.getParameter("countryid") != null) 
        countryid = Integer.parseInt(request.getParameter("countryid"));
String onchange = "";
if(request.getParameter("onchange") != null) 
        onchange = request.getParameter("onchange");
String sz = "sm";
if(request.getParameter("sz") != null)
        sz = request.getParameter("sz");
if(sz.length() > 0) sz = "-"+sz;
String label = eReg(request.getParameter("label"));
String idname = request.getParameter("idname");
String tooltip = eReg(request.getParameter("tooltip"));
%>
<label class="select">
    
    <select class="input<%=sz%> req" id="<%=idname%>" onchange="<%=onchange%>" style="cursor: pointer;">
        <option value="0">-- <%=label%> --</option>
        <%
        for(int i=0;i<countries.length;i++){
            String sel = "";
            if(countryid == countries[i].getCountryid().intValue())
                sel = "selected";
        %>
        <option value="<%=countries[i].getCountryid()%>" <%=sel%>><%=trs.t(countries[i].getNamege())%></option>
        <%
        }
        %>
    </select> 
    <i></i> 
    <b class="tooltip tooltip-top-right"><%=tooltip%></b>
</label>