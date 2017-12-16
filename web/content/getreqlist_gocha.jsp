<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%@include file="../api/api.inc.jsp"%>
<%

JSONArray rows = new JSONArray();
JSONObject ob  = new JSONObject();
Connection c   = Manager.getInstance().getConnection();
ResultSet  rs;
ResultSet  rs2;
try
{
    String sql = ""
            + "SELECT v.*, concat(personell.fname,' ',personell.lname) as personname "
            + "FROM v_lab_request v "
            + "LEFT JOIN personell ON personell.personellid=v.qualitycontrol_person "
            + "ORDER by v.contractsampleitemid DESC "
            + "LIMIT 500";
    rs = c.createStatement().executeQuery(sql);
    while(rs.next())
    {
        String parent = ""+rs.getLong("sampleitemreseachid");
        if (rs.getInt("totalsubtest")>1)
        {
            ob = new JSONObject();
            ob.put("id",    parent);    
            ob.put("code",  rs.getLong("contractsampleitemid"));
            ob.put("name",  rs.getString("labtestname"));
            ob.put("type",  rs.getString("samplename"));
            ob.put("getdate",  _DT_.format(rs.getDate("regdate")));
            ob.put("result",  rs.getString("qualitycontrol_person")!=null ? rs.getString("qualitycontrol_answer") : "-");
            ob.put("enddate",  rs.getString("result_datetime")!=null ? _DT_.format(rs.getDate("result_datetime")) : "-");
            ob.put("plandate","-");
            ob.put("controldate",    rs.getString("qualitycontrol_datetime")!=null ? _DT_.format(rs.getDate("qualitycontrol_datetime")) : "-");
            ob.put("author",  rs.getString("qualitycontrol_person")!=null ? rs.getString("personname") : "-");
            ob.put("controlresult","");
            ob.put("note",    rs.getString("result_note")!=null ? rs.getString("result_note") : "-");
            ob.put("confdate","-");
            ob.put("status",  rs.getInt("status"));
            
            ob.put("level", 0);
            ob.put("parent","NULL");
            ob.put("isLeaf", false);
            ob.put("loaded", true);
            ob.put("expanded", true);
            rows.add(ob);
            
            sql = "SELECT * FROM v_lab_request WHERE parenttest="+rs.getLong("sampleitemreseachid");
            rs2 = c.createStatement().executeQuery(sql);
            int n=0; 
            while(rs2.next())
            {
                ob = new JSONObject();
                ob.put("id",    parent+"_"+n);
                ob.put("code",  rs2.getLong("contractsampleitemid"));
                ob.put("name",  rs2.getString("labtestname"));
                ob.put("type",  rs2.getString("samplename"));
                ob.put("method","-");

                ob.put("regdate",  _DT_.format(rs2.getDate("regdate")));
                ob.put("getdate","-");
                ob.put("dodate","-");
                ob.put("ansdate",  rs2.getString("result_datetime")!=null ? _DT_.format(rs.getDate("result_datetime")) : "-");
                ob.put("end",     _DT_.format(rs2.getDate("enddate")));
                ob.put("date",    rs2.getString("qualitycontrol_person")!=null ? _DT_.format(rs2.getDate("qualitycontrol_datetime")) : "-");
                ob.put("author",  rs2.getString("qualitycontrol_person")!=null ? rs2.getString("personname") : "-");
                ob.put("result",  rs2.getString("qualitycontrol_person")!=null ? rs2.getString("qualitycontrol_answer") : "-");
                ob.put("note",    rs2.getString("result_note")!=null ? rs2.getString("result_note") : "-");
                ob.put("confdate","-");
                ob.put("status",  rs2.getInt("status"));

                ob.put("level", 1);
                ob.put("parent", parent);
                ob.put("isLeaf", true);
                ob.put("loaded", true);
                ob.put("expanded", true);
                rows.add(ob);
                n++;
            }
        }
        else
        {
            ob = new JSONObject();
            ob.put("id",    parent);    
            ob.put("code",  rs.getLong("contractsampleitemid"));
            ob.put("name",  rs.getString("labtestname"));
            ob.put("type",  rs.getString("samplename"));
                ob.put("method","-");

                ob.put("regdate",  _DT_.format(rs.getDate("regdate")));
                ob.put("getdate","-");
                ob.put("dodate","-");
            ob.put("ansdate",  rs.getString("result_datetime")!=null ? _DT_.format(rs.getDate("result_datetime")) : "-");
            ob.put("end",  _DT_.format(rs.getDate("enddate")));
            ob.put("date",    rs.getString("qualitycontrol_person")!=null ? _DT_.format(rs.getDate("qualitycontrol_datetime")) : "-");
            ob.put("author",  rs.getString("qualitycontrol_person")!=null ? rs.getString("personname") : "-");
            ob.put("result",  rs.getString("qualitycontrol_person")!=null ? rs.getString("qualitycontrol_answer") : "-");
            ob.put("note",    rs.getString("result_note")!=null ? rs.getString("result_note") : "-");
                ob.put("confdate","-");
            ob.put("status",  rs.getInt("status"));

            ob.put("level", 0);
            ob.put("parent","NULL");
            ob.put("isLeaf", true);
            ob.put("loaded", true);
            ob.put("expanded", true);
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
