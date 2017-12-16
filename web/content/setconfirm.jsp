<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
JSONObject res = new JSONObject();
Manager.getInstance().beginTransaction();
try{
    long id = Long.parseLong(request.getParameter("id"));
    
    SampleitemreseachBean sm = SampleitemreseachManager.getInstance().loadByPrimaryKey(id);
    
    int level = 1;
    int tp = 0;
    if(request.getParameter("level") != null)
        level = Integer.parseInt(request.getParameter("level"));
    if(level == 1){
        if(sm.getConfirmation1id() != null){
            sm.setConfiramtion1date(null);
            sm.setConfirmation1id(null);
            tp = 0;
        } else {
            sm.setConfiramtion1date(new Date().getTime());
            sm.setConfirmation1id(user.getPersonellid());
            tp = 1;
        }
    } else if(level == 2){
        if(sm.getConfirmation2id() != null){
            sm.setConfiramtion2date(null);
            sm.setConfirmation2id(null);
            tp = 0;
        } else {
            sm.setConfiramtion2date(new Date().getTime());
            sm.setConfirmation2id(user.getPersonellid());
            tp = 1;
        }
    } else if(level == 3){
        if(sm.getConfirmation3id() != null){
            sm.setConfiramtion3date(null);
            sm.setConfirmation3id(null);
            tp = 0;
        } else {
            sm.setConfiramtion3date(new Date().getTime());
            sm.setConfirmation3id(user.getPersonellid());
            tp = 1;
        }
    }
    sm = SampleitemreseachManager.getInstance().save(sm);
    
    Manager.getInstance().endTransaction(true);
    res.put("result",1);
    res.put("tp",tp);
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>

