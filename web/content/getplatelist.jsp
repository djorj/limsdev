<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
    PlateBean[] plates = PlateManager.getInstance().loadByWhere("where deviceid = "+request.getParameter("deviceid")+" order by num");
    //if(plates.length > 0){
    %>
    <label class="select">
        <select id="plateid" onchange="checkUpload($(this).val())">
            <option value="0">- <%=trs.t("აირჩიეთ დაფა")%> -</option>
            <%
            for(int i=0;i<plates.length;i++){
                String sel = "";
            %>
            <option value="<%=plates[i].getPlateid()%>" <%=sel%>><%=plates[i].getNum()%></option>
            <%
            }
            %>
        </select><i></i>
    </label>
    <%
    //}
%>