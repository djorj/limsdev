<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
int labtestid = Integer.parseInt(request.getParameter("labtestid"));
long plateid = Long.parseLong(request.getParameter("plateid"));
//String platename = request.getParameter("platename");
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

    <section class="col col-sm-3">
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
    </section>
    <section class="col col-sm-2">
        <label class="input"> <i class="icon-append fa fa-arrows-v"></i>
            <input id='vert' placeholder="<%=trs.t("ჰორიზონტალური")%>" type="text" value="<%=w%>">
        </label>
    </section>
    <section class="col col-sm-1">
        <i class="fa fa-times fa-3x"></i>
    </section>
    <section class="col col-sm-2">
        <label class="input"> <i class="icon-append fa fa-arrows-h"></i>
            <input id='horiz' placeholder="<%=trs.t("ვერტიკალური")%>" type="text" value="<%=h%>">
        </label>
    </section>
    <section class="col col-sm-2">
        <label class="checkbox">
            <input id="zdefault" type="checkbox" value="1">
            <i></i><%=trs.t("მთავარი")%>
        </label>
    </section>
    <section class="col col-sm-2">
        <button type="button" class="btn btn-success" onclick="getBoardMap()">
            <i class="fa fa-check"></i> <%=trs.t("დამახსოვრება")%>
        </button>
    </section>
        <script>
            seltemplate();
        </script>



