<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%@include file="../api/api.inc.jsp"%>
<%
Connection c = Manager.getInstance().getConnection();
ResultSet rs;
String where = "AND act.deleted=false ";
int    count = 0;
try
{
    String pg   = request.getParameter("page");
    String lmt  = request.getParameter("rows");
    String sidx = request.getParameter("sidx")==null ? "" : request.getParameter("sidx");
    String sord = request.getParameter("sord")==null ? "" : request.getParameter("sord");
    int ipg  = (pg != null) ? Integer.parseInt(pg) : 1;
    int ilmt = (lmt != null) ? Integer.parseInt(lmt) : 10;

    if (request.getParameter("num")!=null&&request.getParameter("num").trim().length()>0)  where += " and upper(act.num) like '%"+request.getParameter("num").trim().toUpperCase().replaceAll("'", "''")+"%'";
    if (request.getParameter("contractnum")!=null&&request.getParameter("contractnum").trim().length()>0)  where += " and upper(contract.num) like '%"+request.getParameter("contractnum").trim().toUpperCase().replaceAll("'", "''")+"%'";
    if (request.getParameter("samplenum")!=null&&request.getParameter("samplenum").trim().length()>0)  where += " and sampleamount="+request.getParameter("samplenum").trim();
    if (request.getParameter("keyword")!=null&&request.getParameter("keyword").trim().length()>0)  where += " and upper(act.content) like '%"+request.getParameter("keyword").trim().toUpperCase().replaceAll("'", "''")+"%'";
    if (request.getParameter("daterange")!=null&&request.getParameter("daterange").trim().length()>0) 
    {
        String tmp[] = request.getParameter("daterange").trim().split("-");
        where += " and act.actdate>='"+tmp[0].trim()+"'";
        where += " and act.actdate<'"+tmp[1].trim()+"'";
    }

    String sql = ""
        + " SELECT count(*)"
        + " FROM act,contract,contragent "
        +  "WHERE act.contractid=contract.contractid AND contract.contragentid=contragent.contragentid "+where;
System.out.println(sql);
    try 
    {
        rs = c.createStatement().executeQuery(sql);        
        count = rs.next() ? rs.getInt(1) : 0;
    } 
    catch (Exception e) 
    {
        count =0;
    }
    int total_pages = count > 0 ? (int)(count/ilmt) : 0;
    if (total_pages*ilmt < count)
        total_pages++;
    if (ipg > total_pages)
        ipg=total_pages;

    int start = ilmt*ipg - ilmt;
    if(start < 0)
        start = 0;

    JSONObject obj = new JSONObject();
    obj.put("page",ipg);
    obj.put("total",total_pages);
    obj.put("records",count);
    
    JSONArray rows = new JSONArray();
    if (count>0)
    {
        sql = ""
        + " SELECT act.*,contract.num as contractnum, contragent.name as agentname"
        + " FROM act,contract,contragent "
        + " WHERE act.contractid=contract.contractid AND contract.contragentid=contragent.contragentid "+where
        + " ORDER by "+sidx+" "+sord
        +"  LIMIT "+ilmt+" offset "+start;
System.out.println(sql);


        rs = c.createStatement().executeQuery(sql);        
        while(rs.next())
        {
            TunitBean tmp = TunitManager.getInstance().loadByPrimaryKey(rs.getInt("regionid"));
            JSONArray cell = new JSONArray();
            cell.add(rs.getLong("actid"));
            cell.add(trs.t(rs.getString("content")));
            cell.add(_DT_.format(rs.getDate("actdate")));
            cell.add(rs.getInt("sampleamount"));
            cell.add(rs.getString("contractnum"));
            cell.add(rs.getString("num"));
            cell.add("<button class=\"btn btn-default viewdocs\" data-itemid=\""+rs.getLong("actid")+"\" data-original-title=\""+trs.t("აქტის დოკუმენტი")+"\" style=\"height: 34px !important;\"><i class=\"fa fa-xm fa-print\"></i></button>");
    
            JSONObject ob = new JSONObject();
            ob.put("id",rs.getLong("actid"));
            ob.put("cell",cell);
            rows.add(ob);
        }
    }
    obj.put("rows",rows);
    JSONObject userdata = new JSONObject();
    obj.put("userdata",userdata);
    out.print(obj.toString());
    out.flush();
}
catch (Exception e) { 
    e.printStackTrace();
}
finally {
    Manager.getInstance().releaseConnection( c );
}
%>
