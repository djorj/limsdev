<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String sql = "where personellid = "+user.getPersonellid();
sql += " and deleted = false";
sql += " order by read, messagedate";
MessagesBean[] msg = MessagesManager.getInstance().loadByWhere(sql);
for(int i=0;i<msg.length;i++){
    String alerttype = "info";
    String s = dtlong.format(msg[i].getMessagedate());
    if(!msg[i].getRead().booleanValue()){
        s = "<b>"+s+"</b>";
        alerttype = "warning";
    }
    s += "<br>"+msg[i].getContent();
%>
<div class="alert alert-<%=alerttype%> fade in">
    <%=s%>
    <button title='<%=trs.t("დაარქივება")%>' class='btn btn-danger pull-right' style='margin-left: 10px; margin-top: -16px;' onclick="updmsg(<%=msg[i].getMessagesid()%>,'del')"><i class='fa fa-times'></i></button>
    <%if(!msg[i].getRead().booleanValue()){%>
    <button title='<%=trs.t("წაკითხვა")%>' class='btn btn-info pull-right' style='margin-left: 10px; margin-top: -16px;' onclick="updmsg(<%=msg[i].getMessagesid()%>,'read')"><i class='fa fa-check'></i></button>
    <%}else{%>
    <button title='<%=trs.t("წაკითხვის გაუქმება")%>' class='btn btn-warning pull-right' style='margin-left: 10px; margin-top: -16px;' onclick="updmsg(<%=msg[i].getMessagesid()%>,'unread')"><i class='fa fa-undo'></i></button>
    <%}%>
</div>
<%}%>