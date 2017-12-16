<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
  int labtestid = Integer.parseInt(request.getParameter("labtestid"));
  InstitutionBean[] insts = InstitutionManager.getInstance().loadByWhere("where companyid = "+user.getCompanyid()+" and parentid is null order by name");
%>
<div class="tree smart-form">
    <ul>
        <%
        for(int i=0;i<insts.length;i++){
            InstitutionBean[] insts1 = InstitutionManager.getInstance().loadByWhere("where parentid = "+insts[i].getInstitutionid()+" order by name");
            
        %>
        <li>
            <%if(insts1.length > 0){%>
            <span class="label label-info"><i class="fa fa-lg fa-plus-circle"></i> <%=insts[i].getName()%></span>
            <%} else {
                String sel = "";
                if(LabtestinstitutionManager.getInstance().countWhere("where labtestid = "+labtestid+" and institutionid = "+insts[i].getInstitutionid()) > 0)
                    sel = "checked";
            %>
            <span>
                <input type="checkbox" name="institutionid" id="lab_<%=insts[i].getInstitutionid()%>" value="<%=insts[i].getInstitutionid()%>" style="cursor: pointer;" <%=sel%> onclick="setLabtestInst(<%=labtestid%>,<%=insts[i].getInstitutionid()%>)"/> <label for="lab_<%=insts[i].getInstitutionid()%>" style="cursor: pointer;"><%=insts[i].getName()%></label>
            </span>
            <%}%>
        <%
            if(insts1.length > 0){%><ul><%}
            for(int j=0;j<insts1.length;j++){
                String sel = "";
                if(LabtestinstitutionManager.getInstance().countWhere("where labtestid = "+labtestid+" and institutionid = "+insts1[j].getInstitutionid()) > 0)
                    sel = "checked";
            %>
                <li>
                    <span>
                        <input type="checkbox" name="institutionid" id="lab_<%=insts1[j].getInstitutionid()%>" value="<%=insts1[j].getInstitutionid()%>" style="cursor: pointer;" <%=sel%> onclick="setLabtestInst(<%=labtestid%>,<%=insts1[j].getInstitutionid()%>)"/> <label for="lab_<%=insts1[j].getInstitutionid()%>" style="cursor: pointer;"><%=insts1[j].getName()%></label>
                    </span>
                </li>
            <%
            
            }
            if(insts1.length > 0){%></ul><%}
        %></li><%
        }
        %>
    </ul>
</div>
     