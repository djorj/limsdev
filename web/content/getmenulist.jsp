<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%!
    JSONArray displayNode(int parentid,int level,JSONArray rows,int companyid) throws Exception{
        String where = "parentid is null";
        if(parentid > 0){
            where = "parentid = "+parentid;
        }
        where += " and companyid = "+companyid;

        MenuBean[] menu = MenuManager.getInstance().loadByWhere("WHERE "+where+" order by ord");
        for(int i=0;i<menu.length;i++){
            String pid = "NULL";
            int pd = 0;
            if(menu[i].getParentid() != null){
                pid = menu[i].getParentid().toString();
                pd = menu[i].getParentid().intValue();
            }
            String leaf = "true";
            if(MenuManager.getInstance().countWhere("where companyid = "+companyid+" and menuid = "+menu[i].getMenuid()+" and menuid in (select parentid from menu where companyid = "+companyid+" and parentid is not null)") > 0){
                leaf = "false";
            }
            JSONObject ob = new JSONObject();
            ob.put("id",menu[i].getMenuid());
            ob.put("menuid",menu[i].getMenuid());
            ob.put("name",menu[i].getName());
            
            ob.put("file",menu[i].getFile());
            ob.put("iconname",menu[i].getIcon());
            ob.put("ord",menu[i].getOrd());
            ob.put("parentid",pd);
            ob.put("level",level);
            ob.put("parent",pid);
            ob.put("isLeaf",leaf);
            ob.put("expanded",false);
            ob.put("loaded",true);
            
            rows.add(ob);
            
            rows = displayNode(menu[i].getMenuid().intValue(),level+1,rows,companyid);
            
        }

        return rows;
    }
%>
<%
JSONArray rows = displayNode(0,0,new JSONArray(),user.getCompanyid().intValue());
out.print(rows.toString());
out.flush();
//System.out.println(obj.toString());
%>
