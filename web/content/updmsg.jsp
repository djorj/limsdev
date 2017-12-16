<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
JSONObject res = new JSONObject();
Manager.getInstance().beginTransaction();
try{
    String oper = request.getParameter("oper");
    long id = 0;
    if(request.getParameter("id") != null)
        id = Long.parseLong(request.getParameter("id"));
    if(oper.equalsIgnoreCase("del")){
        MessagesBean msg = MessagesManager.getInstance().loadByPrimaryKey(id);
        msg.setDeleted(true);
        msg.setDeletedate(new Date().getTime());
        msg = MessagesManager.getInstance().save(msg);
    } else if(oper.equalsIgnoreCase("undel")){
        MessagesBean msg = MessagesManager.getInstance().loadByPrimaryKey(id);
        msg.setDeleted(false);
        msg.setDeletedate(null);
        msg = MessagesManager.getInstance().save(msg);
    } else if(oper.equalsIgnoreCase("read")){
        MessagesBean msg = MessagesManager.getInstance().loadByPrimaryKey(id);
        msg.setRead(true);
        msg.setReaddate(new Date().getTime());
        msg = MessagesManager.getInstance().save(msg);
    } else if(oper.equalsIgnoreCase("unread")){
        MessagesBean msg = MessagesManager.getInstance().loadByPrimaryKey(id);
        msg.setRead(false);
        msg.setReaddate(null);
        msg = MessagesManager.getInstance().save(msg);
    } else if(oper.equalsIgnoreCase("edit")){
        MessagesBean msg = MessagesManager.getInstance().loadByPrimaryKey(id);
        String content = request.getParameter("content").trim();
        int personellid = Integer.parseInt(request.getParameter("personellid"));
        msg.setContent(content);
        msg.setPersonellid(personellid);
        msg = MessagesManager.getInstance().save(msg);
    } else if(oper.equalsIgnoreCase("add")){
        MessagesBean msg = MessagesManager.getInstance().createMessagesBean();
        String content = request.getParameter("content").trim();
        int personellid = Integer.parseInt(request.getParameter("personellid"));
        msg.setContent(content);
        msg.setPersonellid(personellid);
        msg = MessagesManager.getInstance().save(msg);
        id = msg.getMessagesid().longValue();
    }
    res.put("id",id);
    res.put("result",1);
    Manager.getInstance().endTransaction(true);
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>
