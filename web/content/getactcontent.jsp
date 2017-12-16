<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
JSONObject res = new JSONObject();
try{
    long contractid = 0;
    if(request.getParameter("contract") != null)
        contractid = Long.parseLong(request.getParameter("contract"));
    if(contractid == 0)
        throw new Exception(trs.t("კონტრაქტი არჩეული არაა"));
    ContractBean contract = ContractManager.getInstance().loadByPrimaryKey(contractid);
    ContragentBean contragent = ContragentManager.getInstance().loadByPrimaryKey(contract.getContragentid());
    String actcontent = "საქართველოს სოფლის მეურნეობის სამინისტროს ლაბორატორიის ნიმუშების რეგისტრაციის და სტატისტიკური დამუშავების განყოფილების მთ.სპეციალისტი "+user.getFname()+" "+user.getLname()+" ერთის მხრივ და მეორე მხრივ "+contragent.getName()+"-ის წარმომადგენელი ___________________ ვადგენთ აქტს მასზედ, რომ _______________ ლაბორატორიაში შემოიტანა __________________________________________________________ გამოსაკვლევად.";
    
    res.put("result",1);
    res.put("content",actcontent);
}catch(Exception e){
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>