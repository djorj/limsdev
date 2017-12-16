<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
JSONObject res = new JSONObject();
String sid = "0";
String oper = request.getParameter("oper");
Manager.getInstance().beginTransaction();
try{
    if(oper.equalsIgnoreCase("del")){
        sid = request.getParameter("id");
        for(int j=1;j<langs.length;j++)
            TrlibManager.getInstance().deleteByWhere("where langid = "+langs[j].getLangid()+" and phraseid = "+sid);
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        for(int j=1;j<langs.length;j++)
            TrlibManager.getInstance().deleteByWhere("where langid = "+langs[j].getLangid()+" and phraseid = "+sid);
        for(int j=1;j<langs.length;j++){
            String s = request.getParameter("name"+j);
            TrlibBean tr = TrlibManager.getInstance().createTrlibBean();
            tr.setLangid(langs[j].getLangid());
            tr.setPhrase(s);
            tr.setPhraseid(new Long(sid));
            tr = TrlibManager.getInstance().save(tr);
        }
    }

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
