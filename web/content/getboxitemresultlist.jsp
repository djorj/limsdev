<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%@include file="../api/api.inc.jsp"%>
<%
Connection c  = Manager.getInstance().getConnection();
ResultSet rs;
ResultSet rs2;
JSONArray rows = new JSONArray();

try
{
    String boxid = request.getParameter("boxid");
    String testid = request.getParameter("testid");
    if (request.getParameter("disclaim")!=null && request.getParameter("disclaim").equals("0"))
    {
        String sql = ""
        + " SELECT itm.contractsampleitemid, itm.num1, itm.num2, srh.result"
        + " FROM sampleitemreseach srh, contractsampletype sam, contractsampleitem itm"
        + " WHERE srh.labtestid="+testid
                + " AND  srh.contractsampleitemid=itm.contractsampleitemid "
                + " AND  itm.contractsampletypeid=sam.contractsampletypeid "
                + " AND  srh.deleted<>true"
                + " AND  srh.result IS NOT NULL"
                + " AND  srh.status<>2 "
                + " AND  sam.parentid="+boxid;

System.out.println("contractsampleitem: "+sql);

        rs = c.createStatement().executeQuery(sql);
        int n=0;
        while(rs.next())
        {
            JSONObject tmp  = new JSONObject();
            tmp.put("id",     rs.getInt(1));
            tmp.put("num",    rs.getString(2));
            tmp.put("animal", rs.getString(3));
            tmp.put("code",   rs.getInt(1));
            tmp.put("ans",    rs.getString(4));
            tmp.put("print", ""
                    + "<button class=\"btn btn-danger deleteban\" data-itemid=\""+rs.getInt(1)+"\" data-original-title=\""+trs.t("წაშლა")+"\" type=\"button\" style=\"height: 34px !important;\"><i class=\"fa fa-xm fa-trash\"></i></button> "
                    + "<button class=\"btn btn-warning banitem\" data-itemid=\""+rs.getInt(1)+"\" data-original-title=\""+trs.t("დაწუნება")+"\" type=\"button\" style=\"height: 34px !important;\"><i class=\"fa fa-xm fa-ban\"></i></button>");

            rows.add(tmp);
        }
    }
    else
    {
        String sql = ""
        + " SELECT itm.contractsampleitemid, itm.num1, itm.num2, srh.result, srh.sampleitemreseachid"
        + " FROM sampleitemreseach srh, contractsampletype sam, contractsampleitem itm"
        + " WHERE srh.labtestid="+testid
                + " AND  srh.contractsampleitemid=itm.contractsampleitemid "
                + " AND  itm.contractsampletypeid=sam.contractsampletypeid "
                + " AND  srh.deleted<>true"
                + " AND  srh.result IS NOT NULL"
                + " AND  srh.status=2 "
                + " AND  sam.parentid="+boxid;

System.out.println("contractsampleitem: "+sql);

        rs = c.createStatement().executeQuery(sql);
        while(rs.next())
        {
            sql = "SELECT string_agg(reason, '; ') FROM  sampleitemreseachstatushistory WHERE sampleitemreseachid="+rs.getInt(5);
            rs2 = c.createStatement().executeQuery(sql);
            
            JSONObject tmp  = new JSONObject();
            tmp.put("id",     rs.getInt(1));
            tmp.put("num",    rs.getString(2));
            tmp.put("animal", rs.getString(3));
            tmp.put("code",   rs2.next() ? rs2.getString(1) : "");
            tmp.put("ans",    rs.getString(4));
            tmp.put("print", "<button data-itemid=\""+rs.getInt(1)+"\" data-original-title=\""+trs.t("დაწუნების გაუქმება")+"\" class=\"btn btn-success cancelban\" type=\"button\" style=\"height: 34px !important;\"><i class=\"fa fa-xm fa-refresh\"></i> </button>");
            rows.add(tmp);
        }
    }
}
catch (Exception e) { 
    e.printStackTrace();
}
finally {
    Manager.getInstance().releaseConnection( c );
}

System.out.println(rows.toString());
out.print(rows.toString());
out.flush();
%>
