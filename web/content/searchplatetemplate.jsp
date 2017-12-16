<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
int labtestid = Integer.parseInt(request.getParameter("labtestid"));
long plateid = Long.parseLong(request.getParameter("plateid"));
String platename = request.getParameter("platename");
PlatetemplateBean[] templs = PlatetemplateManager.getInstance().loadByWhere("where labtestid = "+labtestid+" order by name");
int w = 12;
int h = 8;
if(plateid > 0){
    PlateBean plate = PlateManager.getInstance().loadByPrimaryKey(plateid);
    PlatetemplateBean template = PlatetemplateManager.getInstance().loadByPrimaryKey(plate.getPlatetemplateid());
    w = template.getW();
    h = template.getH();
}
%>
<div class="input-group">
    <label class="select"> 
        <select id="platetemplateid" class="select2" onchange="seltemplate()">
            <option value="0">- <%=trs.t("აირჩიეთ შაბლონი")%> -</option>
            <%for(int i=0;i<templs.length;i++){
                String sel = "";
                if(templs[i].getZdefault().booleanValue())
                    sel = "selected";
            %>
            <option value="<%=templs[i].getPlatetemplateid()%>" <%=sel%>><%=templs[i].getName()%></option>
            <%}%>
        </select><i></i>
    </label>
    <label class="input">
        <input id='platename' placeholder="<%=trs.t("დაფის ნომერი")%>" type="text" value="">
        <input id='plateid' type="hidden" value="0">
    </label>
    <div class="input-group-btn">
        <button type="button" class="btn btn-success" onclick="gettemplates()">
            <i class="fa fa-check"></i>
        </button>
    </div>
</div>