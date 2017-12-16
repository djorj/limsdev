<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
JSONObject res = new JSONObject();
String sid = "0";
String oper = request.getParameter("oper");
Manager.getInstance().beginTransaction();
try{
    Vector v = (Vector)session.getAttribute("LABTESTPARAMS");
    if(v == null)   v = new Vector();
    if(oper.equalsIgnoreCase("del")){
        int id = Integer.parseInt(request.getParameter("id"));
        v.removeElementAt(id);
    } else if(oper.equalsIgnoreCase("edit")){
        
        
    } else if(oper.equalsIgnoreCase("add")){
        int stid = Integer.parseInt(request.getParameter("standardid"));
        LabtestparamsBean lp = LabtestparamsManager.getInstance().createLabtestparamsBean();
        lp.setLabtestid(new Integer(request.getParameter("labtestid")));
        lp.setSampletypeid(new Integer(request.getParameter("sampletypeid")));
        if(stid > 0)        lp.setStandardid(stid);
        
        v.addElement((LabtestparamsBean)lp);
        
        sid = v.size()+"";
    }

    session.setAttribute("LABTESTPARAMS", (Vector)v);
    Manager.getInstance().endTransaction(true);
    res.put("result",1);
    res.put("id",sid);
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>
