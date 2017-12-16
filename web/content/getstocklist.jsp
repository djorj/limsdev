<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%!
    JSONArray displayNode(int parentid,int level,JSONArray rows) throws Exception{
        String where = "parentid is null";
        if(parentid > 0){
            where = "parentid = "+parentid;
        }

        StockBean[] stock = StockManager.getInstance().loadByWhere("WHERE "+where+" order by name");
        for(int i=0;i<stock.length;i++){
            String pid = "NULL";
            if(stock[i].getParentid() != null){
                pid = stock[i].getParentid().toString();
            }
            String leaf = "true";
            if(StockManager.getInstance().countWhere("where parentid = "+stock[i].getStockid()) > 0){
                leaf = "false";
            }
            JSONObject ob = new JSONObject();
            ob.put("id",stock[i].getStockid());
            ob.put("name",stock[i].getName());
            ob.put("level",level);
            ob.put("parent",pid);
            ob.put("isLeaf",leaf);
            ob.put("expanded",false);
            ob.put("loaded",true);
            
            rows.add(ob);
            
            rows = displayNode(stock[i].getStockid().intValue(),level+1,rows);
            
        }

        return rows;
    }
%>
<%
JSONArray rows = displayNode(0,0,new JSONArray());
out.print(rows.toString());
out.flush();
//System.out.println(obj.toString());
%>
