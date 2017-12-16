<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
JSONObject res = new JSONObject();
try{
    JSONArray unread = new JSONArray();
    JSONArray read = new JSONArray();
    String sql = "where personellid = "+user.getPersonellid();
    if(request.getParameter("onlyunread") != null)
        sql += " and read = false";
    sql += " order by messagedate";
    MessagesBean[] msg = MessagesManager.getInstance().loadByWhere(sql);
    for(int i=0;i<msg.length;i++){
        JSONObject m = new JSONObject();
        m.put("read",msg[i].getRead());
        m.put("content",msg[i].getContent());
        m.put("msgdate",msg[i].getMessagedate().getTime());
        if(msg[i].getRead().booleanValue())
            read.add(m);
        else
            unread.add(m);
    }
    res.put("read",read);
    res.put("unread",unread);
    res.put("result",1);
}catch(Exception e){
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
System.out.println(res.toString());
out.print(res.toString());
out.flush();
%>
