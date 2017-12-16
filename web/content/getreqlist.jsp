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
    int ipg = 1;
    int ilmt = 10;
    String pg = request.getParameter("page");
    if(pg != null)  ipg = Integer.parseInt(pg);
    String lmt = request.getParameter("rows");
    if(lmt != null) ilmt = Integer.parseInt(lmt);
    String sidx = request.getParameter("sidx");
    if(sidx == null)    sidx = "";
    String sord = request.getParameter("sord");
    if(sord == null)    sord = "";
    
    
    
    String instid = "";
    if(user.getPersonelltypeid().intValue() == 21 || user.getPersonelltypeid().intValue() == 12)
        instid = user.getInstitutionid().toString();
    else if(user.getPersonelltypeid().intValue() == 9){
        InstitutionBean[] insts = InstitutionManager.getInstance().loadByWhere("where parentid = "+user.getInstitutionid());
        for(int i=0;i<insts.length;i++){
            if(i>0) instid += ",";
            instid += insts[i].getInstitutionid().toString();
        }
    }

    String research = request.getParameter("research");
    String sql0 = " where v.labtestid > 0 and v.parenttest is null ";
    if(research != null && !research.equals("0"))
        sql0 = " where v.labtestid = "+research+" ";
    if(instid.length() > 0){
        sql0 += " and v.labtestid in (select labtestid from labtestinstitution where institutionid in ("+instid+"))";
    }


    if(request.getParameter("reqbarcode") != null && request.getParameter("reqbarcode").trim().length() > 0)  
        sql0 += " and (contractsampleitemid = "+request.getParameter("reqbarcode")+" or contractsampleitemid in (select contractsampleitemid from contractsampleitem where parentid = "+request.getParameter("reqbarcode")+")) ";
    if(request.getParameter("regdate") != null && request.getParameter("regdate").trim().length() > 0){
        String regdate = request.getParameter("regdate").trim();
        String[] search_date = regdate.split("-");
        if(search_date.length == 1){
            sql0 += " and regdate::date = to_date('"+search_date[0]+"','DD/MM/YYYY')";
        } else if(search_date.length == 2){
            sql0 += " and regdate::date >= to_date('"+search_date[0].trim()+"','DD/MM/YYYY')";
            sql0 += " and regdate::date <= to_date('"+search_date[1].trim()+"','DD/MM/YYYY')";
        }
    }
    if(request.getParameter("resultdate") != null && request.getParameter("resultdate").trim().length() > 0){
        String resultdate = request.getParameter("resultdate").trim();
        String[] search_date = resultdate.split("-");
        if(search_date.length == 1){
            sql0 += " and result_datetime::date = to_date('"+search_date[0]+"','DD/MM/YYYY')";
        } else if(search_date.length == 2){
            sql0 += " and result_datetime::date >= to_date('"+search_date[0].trim()+"','DD/MM/YYYY')";
            sql0 += " and result_datetime::date <= to_date('"+search_date[1].trim()+"','DD/MM/YYYY')";
        }
    }
    if(request.getParameter("ansdate") != null && request.getParameter("ansdate").trim().length() > 0){
        String ansdate = request.getParameter("ansdate").trim();
        String[] search_date = ansdate.split("-");
        if(search_date.length == 1){
            sql0 += " and enddate::date = to_date('"+search_date[0]+"','DD/MM/YYYY')";
        } else if(search_date.length == 2){
            sql0 += " and enddate::date >= to_date('"+search_date[0].trim()+"','DD/MM/YYYY')";
            sql0 += " and enddate::date <= to_date('"+search_date[1].trim()+"','DD/MM/YYYY')";
        }
    }
    if(request.getParameter("confdate") != null && request.getParameter("confdate").trim().length() > 0){
        String confdate = request.getParameter("confdate").trim();
        String[] search_date = confdate.split("-");
        if(search_date.length == 1){
            sql0 += " and sampleitemreseachid in (select sampleitemreseachid from sampleitemreseach where confiramtion1date::date = to_date('"+search_date[0]+"','DD/MM/YYYY'))";
        } else if(search_date.length == 2){
            sql0 += " and sampleitemreseachid in (select sampleitemreseachid from sampleitemreseach where confiramtion1date::date >= to_date('"+search_date[0].trim()+"','DD/MM/YYYY'))";
            sql0 += " and sampleitemreseachid in (select sampleitemreseachid from sampleitemreseach where confiramtion1date::date <= to_date('"+search_date[1].trim()+"','DD/MM/YYYY'))";
        }
    }
    if(request.getParameter("controldate") != null && request.getParameter("controldate").trim().length() > 0){
        String controldate = request.getParameter("controldate").trim();
        String[] search_date = controldate.split("-");
        if(search_date.length == 1){
            sql0 += " and qualitycontrol_datetime::date = to_date('"+search_date[0]+"','DD/MM/YYYY')";
        } else if(search_date.length == 2){
            sql0 += " and qualitycontrol_datetime::date >= to_date('"+search_date[0].trim()+"','DD/MM/YYYY')";
            sql0 += " and qualitycontrol_datetime::date <= to_date('"+search_date[1].trim()+"','DD/MM/YYYY')";
        }
    }
    if(request.getParameter("plandate") != null && request.getParameter("plandate").trim().length() > 0){
        String plandate = request.getParameter("plandate").trim();
        String[] search_date = plandate.split("-");
        if(search_date.length == 1){
            sql0 += " and enddate::date = to_date('"+search_date[0]+"','DD/MM/YYYY')";
        } else if(search_date.length == 2){
            sql0 += " and enddate::date >= to_date('"+search_date[0].trim()+"','DD/MM/YYYY')";
            sql0 += " and enddate::date <= to_date('"+search_date[1].trim()+"','DD/MM/YYYY')";
        }
    }
    if(request.getParameter("note") != null && request.getParameter("note").trim().length() > 0)  sql0 += " and result_note like = '%"+request.getParameter("note").replaceAll("'", "''") +"%' ";
    if(request.getParameter("controlresult") != null && request.getParameter("controlresult").trim().length() > 0)  sql0 += " and qualitycontrol_answer = '"+request.getParameter("controlresult").replaceAll("'", "''") +"' ";
    if(request.getParameter("labtest") != null && request.getParameter("labtest").trim().length() > 0)  sql0 += " and labtestid = "+request.getParameter("labtest") +" ";
    if(request.getParameter("author") != null && request.getParameter("author").trim().length() > 0)  sql0 += " and authorid = "+request.getParameter("author") +" ";
    if(request.getParameter("sampletype") != null && request.getParameter("sampletype").trim().length() > 0)  sql0 += " and sampletypeid = "+request.getParameter("sampletype") +" ";
    
    
    String sql = ""
            + "SELECT count(*) "
            + "FROM v_lab_request v "
            + "LEFT JOIN personell ON personell.personellid=v.qualitycontrol_person " +sql0;
    
    rs = c.createStatement().executeQuery(sql);
    int count = 0;
    if(rs.next())   
        count = rs.getInt(1);
    rs.close();
System.out.println(sql);
    int total_pages = 0;
    if(count > 0)    total_pages = (int)(count/ilmt);
    if(total_pages*ilmt < count)    total_pages++;
    if(ipg > total_pages) ipg=total_pages;
    int start = ilmt*ipg - ilmt;
    if(start < 0)   start = 0;
    String limit = "limit "+ilmt+" offset "+start;
    
    if(sidx.equalsIgnoreCase("name"))   sidx = "v.labtestname";
    if(sidx.equalsIgnoreCase("code"))   sidx = "v.contractsampleitemid";
    if(sidx.equalsIgnoreCase("type"))   sidx = "v.samplename";
    if(sidx.equalsIgnoreCase("getdate"))   sidx = "v.regdate";
    if(sidx.equalsIgnoreCase("enddate"))   sidx = "v.enddate";
    if(sidx.equalsIgnoreCase("plandate"))   sidx = "v.result_datetime";
    if(sidx.equalsIgnoreCase("controldate"))   sidx = "v.qualitycontrol_datetime";
    if(sidx.equalsIgnoreCase("author"))   sidx = "v.authorname";
    if(sidx.equalsIgnoreCase("confdate"))   sidx = "(select coalesce(confirm3id,0)::text || coalesce(confirm2id,0)::text || coalesce(confirm1id,0)::text from sampleitemreseach where sampleitemreseachid = v.sampleitemreseachid limit 1)";

    String order = "order by "+sidx+" "+sord+", v.contractsampleitemid DESC";
    
    
    sql = ""
            + "SELECT v.*, concat(personell.fname,' ',personell.lname) as personname "
            + "FROM v_lab_request v "
            + "LEFT JOIN personell ON personell.personellid=v.qualitycontrol_person "+sql0;
            
            sql += order+" " + limit;
            
System.out.println(sql);
            
    rs = c.createStatement().executeQuery(sql);
    while(rs.next())
    {
        String parent = ""+rs.getLong("sampleitemreseachid");
        //LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(rs.getInt("labtestid"));
        //if(labtest.getGrp().booleanValue()){
            
        //}
        
        if (rs.getInt("totalsubtest")>0){
            SampleitemreseachBean sm = SampleitemreseachManager.getInstance().loadByPrimaryKey(rs.getLong("sampleitemreseachid"));
            
            String levelnum = "-";
            if(sm.getConfirmation3id() != null)   levelnum = "III";
            else if(sm.getConfirmation2id() != null)   levelnum = "II";
            else if(sm.getConfirmation1id() != null)   levelnum = "I";
            
            ob = new JSONObject();
            ob.put("id",    parent);    
            ob.put("code",  rs.getLong("contractsampleitemid"));
            ob.put("name",  rs.getString("labtestname"));
            ob.put("type",  rs.getString("samplename"));
            ob.put("getdate",  _DT_.format(rs.getDate("regdate")));
            ob.put("result",  rs.getString("result")!=null ? rs.getString("result") : "-");
            ob.put("plandate",  rs.getString("enddate")!=null ? _DT_.format(rs.getDate("enddate")) : "-");
            ob.put("enddate",rs.getString("result_datetime")!=null ? _DT_.format(rs.getDate("result_datetime")) : "-");
            ob.put("controldate",    rs.getString("qualitycontrol_datetime")!=null ? _DT_.format(rs.getDate("qualitycontrol_datetime")) : "-");
            ob.put("author",  rs.getString("authorname")!=null ? rs.getString("authorname") : "-");
            ob.put("controlresult",rs.getString("qualitycontrol_answer")!=null ? rs.getString("qualitycontrol_answer") : "-");
            ob.put("note",    rs.getString("result_note")!=null ? rs.getString("result_note") : "-");
            ob.put("confdate",levelnum);
            ob.put("status",  rs.getInt("status"));
            
            ob.put("level", 0);
            ob.put("parent","NULL");
            ob.put("isLeaf", false);
            ob.put("loaded", true);
            ob.put("expanded", true);
            rows.add(ob);
            
            sql = "SELECT * FROM v_lab_request WHERE parenttest="+rs.getLong("contractsampleitemid");
            rs2 = c.createStatement().executeQuery(sql);
            int n=0; 
            while(rs2.next())
            {
String dtt = rs2.getString("result_datetime");
if(dtt != null)	dtt = dtlong.format(dtdb.parse(dtt));

                sm = SampleitemreseachManager.getInstance().loadByPrimaryKey(rs2.getLong("sampleitemreseachid"));
                levelnum = "-";
                if(sm.getConfirmation3id() != null)   levelnum = "III";
                else if(sm.getConfirmation2id() != null)   levelnum = "II";
                else if(sm.getConfirmation1id() != null)   levelnum = "I";
                ob = new JSONObject();
                ob.put("id",    sm.getSampleitemreseachid());   //parent+"_"+n);
                ob.put("code",  rs2.getLong("contractsampleitemid"));
                ob.put("name",  rs2.getString("labtestname"));
                ob.put("type",  rs2.getString("samplename"));
                ob.put("getdate",  _DT_.format(rs2.getDate("regdate")));
                ob.put("result",  rs2.getString("result")!=null ? rs2.getString("result") : "-");
                ob.put("enddate",  (dtt != null) ? dtt:"-");	//rs2.getString("result_datetime")!=null ? _DT_.format(rs.getDate("result_datetime")) : "-");
                ob.put("plandate",  rs.getString("enddate")!=null ? _DT_.format(rs.getDate("enddate")) : "-");
                ob.put("controldate",    rs2.getString("qualitycontrol_datetime")!=null ? _DT_.format(rs2.getDate("qualitycontrol_datetime")) : "-");
                ob.put("author",  rs2.getString("authorname")!=null ? rs2.getString("authorname") : "-");
                ob.put("controlresult",rs2.getString("qualitycontrol_answer")!=null ? rs2.getString("qualitycontrol_answer") : "-");
                ob.put("note",    rs2.getString("result_note")!=null ? rs2.getString("result_note") : "-");
                ob.put("confdate",levelnum);
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
            SampleitemreseachBean sm = SampleitemreseachManager.getInstance().loadByPrimaryKey(rs.getLong("sampleitemreseachid"));
            String levelnum = "-";
            if(sm.getConfirmation3id() != null)   levelnum = "III";
            else if(sm.getConfirmation2id() != null)   levelnum = "II";
            else if(sm.getConfirmation1id() != null)   levelnum = "I";
            ob = new JSONObject();
            ob.put("id",    parent);    
            ob.put("code",  rs.getLong("contractsampleitemid"));
            ob.put("name",  rs.getString("labtestname"));
            ob.put("type",  rs.getString("samplename"));
            ob.put("getdate",  _DT_.format(rs.getDate("regdate")));
            ob.put("result",  rs.getString("result")!=null ? rs.getString("result") : "-");
            ob.put("enddate",  rs.getString("result_datetime")!=null ? _DT_.format(rs.getDate("result_datetime")) : "-");
            ob.put("plandate",  rs.getString("enddate")!=null ? _DT_.format(rs.getDate("enddate")) : "-");
            ob.put("controldate",    rs.getString("qualitycontrol_datetime")!=null ? _DT_.format(rs.getDate("qualitycontrol_datetime")) : "-");
            ob.put("author",  rs.getString("authorname")!=null ? rs.getString("authorname") : "-");
            ob.put("controlresult", rs.getString("qualitycontrol_answer")!=null ? rs.getString("qualitycontrol_answer") : "-");
            ob.put("note",    rs.getString("result_note")!=null ? rs.getString("result_note") : "-");
            ob.put("confdate",levelnum);
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
