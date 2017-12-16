<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%@include file="../api/api.inc.jsp"%>
<%
JSONArray rows = new JSONArray();
Connection c   = Manager.getInstance().getConnection();
try
{
  ResultSet  rs;
  ResultSet  rs2;
  String sql = ""
        + " SELECT con.*, age.name agentname, age.idn agentidn"
        + " FROM contract con, contragent age"
        + " WHERE con.contragentid=age.contragentid AND con.deleted=false  AND age.deleted=false AND age.companyid="+user.getCompanyid();
System.out.println(sql);
  rs = c.createStatement().executeQuery(sql);
  while(rs.next())
  {
    JSONObject ob = new JSONObject();
    sql = ""
        + " SELECT con.regdate, sam.name samplename, itm.contractsampleitemid, itm.num1, itm.num2, itm.regdate getdate, research.labtestid, research.name testname "
        + " FROM contractsampletype con, sampletype sam, contractsampleitem itm "
        + " LEFT JOIN ("
            + "SELECT lt.labtestid, lt.name, sr.contractsampleitemid "
            + "FROM sampleitemreseach sr,labtest lt "
            + "WHERE sr.labtestid=lt.labtestid AND sr.parenttest IS NULL"
            + ") AS research ON  itm.contractsampleitemid=research.contractsampleitemid"
        + " WHERE con.contractsampletypeid=itm.contractsampletypeid "
            + "AND con.sampletypeid=sam.sampletypeid "
            + "AND con.contractid="+rs.getInt("contractid") 
            + "AND labtestid is not null";
    sql = ""
        + " SELECT con.regdate, sam.name samplename, itm.contractsampleitemid, itm.num1, itm.num2, itm.regdate getdate, "
            + " confirm1date,confirm1byid,confirm1status,confirm1person,"
            + " confirm2date,confirm2byid,confirm2status,confirm2person,"
            + " confirm3date,confirm3byid,confirm3status,confirm3person,"
            + " labtestid, labtestname "
        + " FROM contractsampletype con, sampletype sam, contractsampleitem itm "
        + " LEFT JOIN v_lab_research ON  itm.contractsampleitemid=v_lab_research.contractsampleitemid"
        + " WHERE con.contractsampletypeid=itm.contractsampletypeid "
            + "AND con.sampletypeid=sam.sampletypeid "
            + "AND con.contractid="+rs.getInt("contractid") 
            + "AND labtestid is not null";
System.out.println(sql);
    rs2 = c.createStatement().executeQuery(sql);
    int n=-1;
    while(rs2.next())
    {
        n++;
        ob = new JSONObject();
        ob.put("id",     rs2.getInt("contractsampleitemid"));
        ob.put("contragent",  rs.getString("agentidn")+" - "+rs.getString("agentname"));
        ob.put("code",   rs2.getInt("contractsampleitemid"));
        ob.put("name",   rs2.getString("labtestname"));
        ob.put("type",   rs2.getString("samplename"));
        ob.put("method", "-");
        ob.put("regdate",_DTF_.format(rs2.getTimestamp("regdate")));
        ob.put("getdate",_DTF_.format(rs2.getTimestamp("regdate")));
        ob.put("dodate", "-");
        ob.put("ansdate","-");
        ob.put("end",    "27/07/2016 - 15:00");
        ob.put("note",   "");
        ob.put("conf1",  "<div class=\"smart-form\"><label class=\"checkbox cust\"><input disabled=\"\" name=\"checkbox-inline\" checked=\"checked\" type=\"checkbox\"><i class=\"tip\" data-original-title=\"27/07/2016 - 15:00, გიორგი გიორგაძე\"></i></label></div>");
        ob.put("conf2",  "<div class=\"smart-form\"><label class=\"checkbox cust\"><input disabled=\"\" name=\"checkbox-inline\" checked=\"checked\" type=\"checkbox\"><i class=\"tip\" data-original-title=\"27/07/2016 - 15:00, გიორგი გიორგაძე\"></i></label></div>");
        ob.put("conf3",  "<div class=\"smart-form\"><label class=\"checkbox cust\"><input class=\"confcheck\" name=\"checkbox-inline\" type=\"checkbox\"><i class=\"tip\" data-original-title=\"27/07/2016 - 15:00, გიორგი გიორგაძე\"></i></label></div>");
        rows.add(ob);
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
