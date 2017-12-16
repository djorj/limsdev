<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
long id = Long.parseLong(request.getParameter("contragentid"));
ContractBean[] contracts = ContractManager.getInstance().loadByWhere("where companyid = "+user.getCompanyid()+" and contragentid = "+id);

String options = "<option value=\"0\">"+trs.t("ხელშეკრულების N")+"</option>\n";
for(int i=0;i<contracts.length;i++){
    options += "<option value=\""+contracts[i].getContractid()+"\">"+contracts[i].getNum()+"</option>\n";
}
out.print(options);
out.flush();
%>
