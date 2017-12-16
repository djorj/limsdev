<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
boolean childonly = false;
if(request.getParameter("childonly") != null)
    childonly = true;
String sql = "where companyid = "+user.getCompanyid();
if(childonly)   sql += " and institutionid not in (select parentid from institution where parentid is not null)";
sql += " order by parentid desc, name";
InstitutionBean[] menu = InstitutionManager.getInstance().loadByWhere(sql);

%>
<select>
    <option value='0'><%=trs.t("პირველი დონე")%></option>
<%for(int i=0;i<menu.length;i++){%>
    <option value='<%=menu[i].getInstitutionid()%>'><%=getFullLabName(menu[i],"=>")%></option>
<%}%>
</select>
