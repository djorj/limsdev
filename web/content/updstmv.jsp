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
        StockmovementBean stm = StockmovementManager.getInstance().loadByPrimaryKey(new Long(sid));
        if(stm.getCurquantity().doubleValue() < stm.getQuantity().doubleValue())
            throw new Exception(trs.t("პარტიიდან საქონელი გაცემულია - წაშლა შეუძლებელია!"));
        StockmovementManager.getInstance().deleteByPrimaryKey(stm.getStockmovementid());
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
