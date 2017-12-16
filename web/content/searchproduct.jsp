<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
    JSONObject obj = new JSONObject();
    String q = request.getParameter("q");
    ProductBean[] prods = ProductManager.getInstance().loadByWhere("where productgroupid in (select productgroupid from productgroup where companyid = "+user.getCompanyid()+") and upper(name) like '%"+q.toUpperCase().replaceAll("'", "''") +"%'");
    JSONArray products = new JSONArray();
    for(int i=0;i<prods.length;i++){
        JSONObject product = new JSONObject();
        product.put("id", prods[i].getProductid());
        product.put("name", prods[i].getName());
        products.add(product);
    }
    obj.put("products", products);
    out.print(obj.toString());
    out.flush();
%>