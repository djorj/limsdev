<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%@include file="../api/api.inc.jsp"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%
Connection c   = Manager.getInstance().getConnection();
long appealid = 0;
long actid = 0;
long contractid = Long.parseLong(request.getParameter("contractid"));
if(request.getParameter("appealid") != null && request.getParameter("appealid").trim().length() > 0)    appealid = Long.parseLong(request.getParameter("appealid"));
if(request.getParameter("actid") != null && request.getParameter("actid").trim().length() > 0)    actid = Long.parseLong(request.getParameter("actid"));
String sql0 = "";
if(appealid > 0)    sql0 = " and st.appealid = "+appealid+" ";
if(actid > 0)    sql0 = " and st.actid = "+actid+" ";
try
{
    long cid = Long.parseLong(request.getParameter("contractid"));
    if (request.getParameter("sampleid")!=null)
    {
        long sid = Long.parseLong(request.getParameter("sampleid"));
        JSONArray rows = new JSONArray();
    
        ResultSet rs;
        String   sql = ""
            + " SELECT ca.sampleitemreseachid,ca.price,ca.daynum,ca.status,ca.contractsampleitemid,lt.name testname,ins.name labname,cs.parentid"
            + " FROM sampleitemreseach ca, contractsampleitem cs, contractsampletype st, labtest lt, institution ins"
            + " WHERE ca.contractsampleitemid=cs.contractsampleitemid"
            + " AND ca.institutionid=ins.institutionid"
            + " AND ca.labtestid=lt.labtestid"
            + " AND cs.contractsampletypeid=st.contractsampletypeid"
            + " AND ca.deleted<>true"
            + " AND cs.deleted<>true"
            + " AND st.deleted<>true"
            + " AND ca.contractid="+cid
            + " AND st.sampletypeid="+sid+sql0;

        rs = c.createStatement().executeQuery(sql);
        while(rs.next())
        {
            String srcbarcode = "";
            if(rs.getString("parentid") != null){
                ContractsampleitemBean parent = ContractsampleitemManager.getInstance().loadByPrimaryKey(rs.getLong("parentid"));
                srcbarcode = parent.getBarcode();
            }
            JSONObject ob = new JSONObject();
            ob.put("id",    rs.getLong("sampleitemreseachid"));
            ob.put("price", rs.getDouble("price"));
            ob.put("srcbarcode", srcbarcode);
            ob.put("enddays", "<div class=\"smart-form\"><label class=\"input\"><input value=\""+rs.getInt("daynum")+"\" type=\"text\"></label></div>");
            ob.put("name",  trs.t(rs.getString("testname")));
            ob.put("code",  trs.t(rs.getString("contractsampleitemid")));
            ob.put("laboratory",  trs.t(rs.getString("labname")));
            ob.put("status", rs.getInt("status"));
            ob.put("act",   ""
                + "<button data-itemid=\""+rs.getLong("sampleitemreseachid")+"\" class=\"btn btn-danger  btn-sm deltanalisys\" type=\"button\" data-original-title=\""+trs.t("წაშლა")+"\"><i class=\"fa fa-trash\"></i></button> "
                + "<button data-itemid=\""+rs.getLong("contractsampleitemid")+"\" class=\"btn btn-primary btn-sm showcode\" type=\"button\" data-original-title=\""+trs.t("ბეჭდვა")+"\"><i class=\"fa fa-print\"></i></button>"
                + "<button data-itemid=\""+rs.getLong("sampleitemreseachid")+"\" class=\"btn btn-warning btn-sm stopanalisys\" data-original-title=\""+trs.t("შეჩერება")+"\" style=\"margin-left: 5px;\"><i class=\"fa fa-stop\"></i></button>"
            );
            ob.put("cbb", "<input type=checkbox data-itemid=\""+rs.getLong("sampleitemreseachid")+"\" class=sampleitemreseach value="+rs.getString("contractsampleitemid")+" >");
            rows.add(ob);
        }
        rs.close();
System.out.println(rows.toString());
        out.print(rows.toString());
        out.flush();
    }
    else if (request.getParameter("sampleboxid")!=null)
    {
        long sid = Long.parseLong(request.getParameter("sampleboxid"));
        JSONArray rows = new JSONArray();
    
        ResultSet rs;
        String   sql = ""
            + " SELECT ca.sampleboxreseachid,ca.price,ca.daynum,ca.contractsampletypeid,lt.name testname,ins.name labname"
            + " FROM sampleboxreseach ca, contractsampletype st, labtest lt, institution ins"
            + " WHERE ca.contractsampletypeid=st.contractsampletypeid"
            + " AND ca.institutionid=ins.institutionid"
            + " AND ca.labtestid=lt.labtestid"
            + " AND ca.deleted<>true"
            + " AND st.deleted<>true"
            + " AND st.contractid="+cid
            + " AND st.parentid="+sid+sql0;
System.out.println(sql);
        rs = c.createStatement().executeQuery(sql);
        while(rs.next())
        {
            JSONObject ob = new JSONObject();
            ob.put("id",    rs.getLong("sampleboxreseachid"));
            ob.put("price", "-");
            ob.put("srcbarcode", "-");
            ob.put("enddays", "<div class=\"smart-form\"><label class=\"input\"><input value=\""+rs.getInt("daynum")+"\" type=\"text\"></label></div>");
            ob.put("name",  trs.t(rs.getString("testname")));
            ob.put("code",  "-");
            ob.put("laboratory",  trs.t(rs.getString("labname")));
            ob.put("act",   ""
                + "<button data-itemid=\""+rs.getLong("sampleboxreseachid")+"\" class=\"btn btn-danger  btn-sm deltanalisys\" type=\"button\" data-original-title=\""+trs.t("წაშლა")+"\"><i class=\"fa fa-trash\"></i></button> "
            );
            ob.put("cbb", "<input type=checkbox data-itemid=\""+rs.getLong("sampleboxreseachid")+"\" class=sampleboxreseach value="+rs.getLong("sampleboxreseachid")+" >");
            rows.add(ob);
        }
        rs.close();
System.out.println(rows.toString());
        out.print(rows.toString());
        out.flush();
    }
}
catch(Exception e){
    e.printStackTrace();
}
finally{Manager.getInstance().releaseConnection(c);}

%>
