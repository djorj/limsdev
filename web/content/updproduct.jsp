<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%
for(Enumeration e=request.getParameterNames();e.hasMoreElements();){
    String name = (String)e.nextElement();
    String val = request.getParameter(name);
System.out.println(name+" = "+val);
}
JSONObject res = new JSONObject();
String sid = "0";
String oper = request.getParameter("oper");
Manager.getInstance().beginTransaction();
try{
    if(oper.equalsIgnoreCase("del")){
        sid = request.getParameter("id");
        ProductBean pr = ProductManager.getInstance().loadByPrimaryKey(new Long(sid));
        ProductunitManager.getInstance().deleteByProductid(pr.getProductid());
        ProductManager.getInstance().deleteByPrimaryKey(pr.getProductid());
    } else if(oper.equalsIgnoreCase("edit")){
        sid = request.getParameter("id");
        
        ProductBean pr = ProductManager.getInstance().loadByPrimaryKey(new Long(sid));
        
        String name=request.getParameter("name").trim();
        String code=request.getParameter("code").trim();
        int productgroupid = Integer.parseInt(request.getParameter("productgroupid"));
        int punitid = Integer.parseInt(request.getParameter("punitid"));
        double limitqty = Double.parseDouble(request.getParameter("limitqty"));
        long exp1 = 0;
        long exp2 = 0;
        try{ exp1 = Long.parseLong(request.getParameter("exp1")); }catch(Exception e){}
        try{ exp2 = Long.parseLong(request.getParameter("exp2")); }catch(Exception e){}
        int unit1 = -1;
        try{ unit1 = Integer.parseInt(request.getParameter("unit1")); }catch(Exception e){}
        int unit2 = -1;
        try{ unit2 = Integer.parseInt(request.getParameter("unit2"));}catch(Exception e){}
        for (int i = 0; i < ageunitvals.length; i++) {
            if (unit1 == i) {
                exp1 = unit1 * exp1;
                break;
            }
        }
        for (int i = 0; i < ageunitvals.length; i++) {
            if (unit2 == i) {
                exp2 = unit2 * exp2;
                break;
            }
        }
        
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        //if(code.length() == 0)  throw new Exception(trs.t("კოდი ცარიელია!"));
        
        String sql = "where productid != "+sid+" and upper(name) = '"+name.toUpperCase().replaceAll("'", "''") +"' and productgroupid = "+productgroupid;
        if(ProductManager.getInstance().countWhere(sql) > 0)
            throw new Exception(trs.t("დასახელება უკვე არსებობს!"));
        sql = "where productid != "+sid+" and upper(code) = '"+code.toUpperCase().replaceAll("'", "''") +"'";
        //if(pr.getParentid() != null)    sql += "= "+pr.getParentid();
        //else                            sql += "is null";
        if(code.length() > 0 && ProductManager.getInstance().countWhere(sql) > 0)
            throw new Exception(trs.t("კოდი უკვე არსებობს!"));
        
        if(exp1 > 0)    pr.setExp1(exp1);
        else            pr.setExp1(null);
        if(exp2 > 0)    pr.setExp2(exp2);
        else            pr.setExp2(null);
        pr.setName(name);
        pr.setCode(code);
        if(punitid > 0) pr.setPunitid(punitid);
        else            pr.setPunitid(null);
        pr.setProductgroupid(productgroupid);
        pr.setLimitqty(limitqty);
        pr = ProductManager.getInstance().save(pr);
        
    } else if(oper.equalsIgnoreCase("add")){
        
        ProductBean pr = ProductManager.getInstance().createProductBean();
        
        int productgroupid = Integer.parseInt(request.getParameter("productgroupid"));
        String name=request.getParameter("name").trim();
        String code=request.getParameter("code").trim();
        int punitid = Integer.parseInt(request.getParameter("punitid"));
        double limitqty = Double.parseDouble(request.getParameter("limitqty"));
        long exp1 = 0;
        long exp2 = 0;
        try{ exp1 = Long.parseLong(request.getParameter("exp1")); }catch(Exception e){}
        try{ exp2 = Long.parseLong(request.getParameter("exp2")); }catch(Exception e){}
        int unit1 = -1;
        try{ unit1 = Integer.parseInt(request.getParameter("unit1")); }catch(Exception e){}
        int unit2 = -1;
        try{ unit2 = Integer.parseInt(request.getParameter("unit2"));}catch(Exception e){}
        for (int i = 0; i < ageunitvals.length; i++) {
            if (unit1 == i) {
                exp1 = unit1 * exp1;
                break;
            }
        }
        for (int i = 0; i < ageunitvals.length; i++) {
            if (unit2 == i) {
                exp2 = unit2 * exp2;
                break;
            }
        }
        
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
        //if(code.length() == 0)  throw new Exception(trs.t("კოდი ცარიელია!"));
        
        String sql = "where upper(name) = '"+name.toUpperCase().replaceAll("'", "''") +"' and productgroupid = "+productgroupid;
        if(ProductManager.getInstance().countWhere(sql) > 0)
            throw new Exception(trs.t("დასახელება უკვე არსებობს!"));
        sql = "where upper(code) = '"+code.toUpperCase().replaceAll("'", "''") +"'";
//        if(pr.getParentid() != null)    sql += "= "+pr.getParentid();
//        else                            sql += "is null";
        if(code.length() > 0 && ProductManager.getInstance().countWhere(sql) > 0)
            throw new Exception(trs.t("კოდი უკვე არსებობს!"));
        
        if(exp1 > 0)    pr.setExp1(exp1);
        else            pr.setExp1(null);
        if(exp2 > 0)    pr.setExp2(exp2);
        else            pr.setExp2(null);
        pr.setName(name);
        pr.setCode(code);
        pr.setProductgroupid(productgroupid);
        if(punitid > 0) pr.setPunitid(punitid);
        pr.setLimitqty(limitqty);
        pr = ProductManager.getInstance().save(pr);
        sid = pr.getProductid().toString();
    } else if(oper.equalsIgnoreCase("delgroup")){
        sid = request.getParameter("id");
        ProductgroupBean pr = ProductgroupManager.getInstance().loadByPrimaryKey(new Integer(sid));
        if(ProductgroupManager.getInstance().countWhere("where parentid = "+pr.getProductgroupid()) > 0)
            throw new Exception(trs.t("ჯერ წაშალეთ ჯგუფში შემავალი ქვეჯგუფები"));
        if(ProductManager.getInstance().countWhere("where productgroupid = "+pr.getProductgroupid()) > 0)
            throw new Exception(trs.t("ჯერ წაშალეთ ჯგუფში შემავალი პროდუქტები"));
        ProductgroupManager.getInstance().deleteByPrimaryKey(pr.getProductgroupid());
    } else if(oper.equalsIgnoreCase("editgroup")){
        sid = request.getParameter("id");
        
        ProductgroupBean pr = ProductgroupManager.getInstance().loadByPrimaryKey(new Integer(sid));
        
        String name=request.getParameter("name").trim();
        String code=request.getParameter("code").trim();
        
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
//        if(code.length() == 0)  throw new Exception(trs.t("კოდი ცარიელია!"));
        
        String sql = "where productgroupid != "+pr.getProductgroupid()+" and upper(name) = '"+name.toUpperCase().replaceAll("'", "''") +"'";
        if(ProductManager.getInstance().countWhere(sql) > 0)
            throw new Exception(trs.t("დასახელება უკვე არსებობს!"));
//        sql = "where upper(code) = '"+code.toUpperCase().replaceAll("'", "''") +"'";
//        if(ProductgroupManager.getInstance().countWhere(sql) > 0)
//            throw new Exception(trs.t("კოდი უკვე არსებობს!"));
        pr.setName(name);
        pr.setCode(code);
        pr = ProductgroupManager.getInstance().save(pr);
        
    } else if(oper.equalsIgnoreCase("addgroup")){
        
        ProductgroupBean pr = ProductgroupManager.getInstance().createProductgroupBean();
        
        int parentid = Integer.parseInt(request.getParameter("id"));
        String name=request.getParameter("name").trim();
        String code=request.getParameter("code").trim();
        
        if(name.length() == 0)  throw new Exception(trs.t("დასახელება ცარიელია!"));
//        if(code.length() == 0)  throw new Exception(trs.t("კოდი ცარიელია!"));
        
        String sql = "where upper(name) = '"+name.toUpperCase().replaceAll("'", "''") +"'";
        if(ProductManager.getInstance().countWhere(sql) > 0)
            throw new Exception(trs.t("დასახელება უკვე არსებობს!"));
//        sql = "where upper(code) = '"+code.toUpperCase().replaceAll("'", "''") +"'";
//        if(ProductgroupManager.getInstance().countWhere(sql) > 0)
//            throw new Exception(trs.t("კოდი უკვე არსებობს!"));
        if(parentid > 0)    pr.setParentid(parentid);
        pr.setName(name);
        pr.setCode(code);
        pr.setCompanyid(user.getCompanyid());
        pr = ProductgroupManager.getInstance().save(pr);
        sid = pr.getProductgroupid().toString();
    } else if(oper.equalsIgnoreCase("chgroup")){
        
        ProductBean pr = ProductManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("id")));
        pr.setProductgroupid(new Integer(request.getParameter("gid")));
        
        pr = ProductManager.getInstance().save(pr);
        sid = pr.getProductgroupid().toString();
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

