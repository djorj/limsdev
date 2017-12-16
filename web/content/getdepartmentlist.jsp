<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%!
    JSONArray displayNode(int companyid, int parentid,int level,JSONArray rows) throws Exception{
        String where = "parentid is null";
        if(parentid > 0){
            where = "parentid = "+parentid;
        }
        where = "companyid = "+companyid+" and "+where;

        InstitutionBean[] menu = InstitutionManager.getInstance().loadByWhere("WHERE "+where+" order by parentid, name");
        for(int i=0;i<menu.length;i++){
            String pid = "NULL";
            int pd = 0;
            if(menu[i].getParentid() != null){
                pid = menu[i].getParentid().toString();
                pd = menu[i].getParentid().intValue();
            }
            String leaf = "true";
            if(InstitutionManager.getInstance().countWhere("where institutionid = "+menu[i].getInstitutionid()+" and institutionid in (select parentid from institution where parentid is not null)") > 0){
                leaf = "false";
            }
            JSONObject ob = new JSONObject();
            ob.put("id",menu[i].getInstitutionid());
            ob.put("institutionid",menu[i].getInstitutionid());
            ob.put("name",menu[i].getName());
            
            ob.put("address",menu[i].getAddress());
            ob.put("logo",menu[i].getHeaderlogo());
            
            ob.put("level",level);
            ob.put("parent",pid);
            ob.put("isLeaf",leaf);
            ob.put("expanded",false);
            ob.put("loaded",true);
            
            rows.add(ob);
            
            rows = displayNode(companyid,menu[i].getInstitutionid().intValue(),level+1,rows);
            
        }

        return rows;
    }
%>
<%
JSONArray rows = displayNode(user.getCompanyid().intValue(),0,0,new JSONArray());
out.print(rows.toString());
out.flush();
//System.out.println(obj.toString());
%>
