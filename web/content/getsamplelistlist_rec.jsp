<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%@include file="../api/api.inc.jsp"%>
<%
Connection c   = Manager.getInstance().getConnection();
JSONArray rows = new JSONArray();
JSONObject obj = new JSONObject();

try
{

SamplestatusBean[] samsts = SamplestatusManager.getInstance().loadAll();
Map<Integer, String> st  = new HashMap<Integer, String>();
for(int i=0;i<samsts.length; i++)
    st.put(samsts[i].getSamplestatusid(), trs.t(samsts[i].getName()));

String where = "companyid = "+user.getCompanyid();

String pg   = request.getParameter("page");
String lmt  = request.getParameter("rows");
String sidx = request.getParameter("sidx")==null ? "" : request.getParameter("sidx");
String sord = request.getParameter("sord")==null ? "" : request.getParameter("sord");
int ipg  = (pg != null) ? Integer.parseInt(pg) : 1;
int ilmt = (lmt != null) ? Integer.parseInt(lmt) : 10;

if (request.getParameter("barcode")!=null && request.getParameter("barcode").trim().length()>0)  where += " and barcode= "+request.getParameter("barcode").trim();
if (request.getParameter("daterange")!=null && request.getParameter("daterange").trim().length()>0)  {
    String daterange = request.getParameter("daterange").trim();
    String[] search_date = daterange.split("-");
    if(search_date.length == 1){
        where += " and regdate::date = to_date('"+search_date[0]+"','DD/MM/YYYY')";
    } else if(search_date.length == 2){
        where += " and regdate::date >= to_date('"+search_date[0].trim()+"','DD/MM/YYYY')";
        where += " and regdate::date <= to_date('"+search_date[1].trim()+"','DD/MM/YYYY')";
    }
}
if (request.getParameter("num1")!=null && request.getParameter("num1").trim().length()>0)  where += " and num1 like '%"+request.getParameter("num1").trim().toUpperCase().replaceAll("'", "''")+"%'";
if (request.getParameter("location")!=null && request.getParameter("location").trim().length()>0)  where += " and contractsampleitemid in ("
        + "select s.contractsampleitemid from sampleitemreseach s, i institution where s.institutionid = i.institutionid and i.name like '%"+request.getParameter("location").trim().toUpperCase().replaceAll("'", "''")+"%'"
        + ")";
if (request.getParameter("contragentid")!=null && request.getParameter("contragentid").trim().length()>0)  where += " and contragentid in (select contragentid from contragent where upper(name) like '%"+request.getParameter("contragentid")+"%' or upper(fname || ' ' || lname) like '%"+request.getParameter("contragentid")+"%' or upper(lname || ' ' || fname) like '%"+request.getParameter("contragentid")+"%' or idn = '"+request.getParameter("contragentid")+"')";
if (request.getParameter("sampletype")!=null && request.getParameter("sampletype").trim().length()>0)  where += " and sampletypeid = "+Integer.parseInt(request.getParameter("sampletype"));
if (request.getParameter("statusid")!=null && request.getParameter("statusid").trim().length()>0)  where += " and status = "+Integer.parseInt(request.getParameter("statusid"));
if (request.getParameter("speciesid")!=null && request.getParameter("speciesid").trim().length()>0)  where += " and barcode in ("
        + "select c.contractsampleitemid from contractsampleitem c, contractsampletype t where c.contractsampletypeid = t.contractsampletypeid and t.speciesid = "+request.getParameter("speciesid")+")";

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

if(instid.length() > 0){
    where += " and barcode in (select contractsampleitemid from sampleitemreseach where institutionid in ("+instid+"))";
}


String cnt = "SELECT count(*) FROM v_lab_sampleitem WHERE "+where;

System.out.println("where: "+where);

ResultSet rs   = c.createStatement().executeQuery(cnt);

int count = rs.next() ? rs.getInt(1) : 0;
int total_pages = count > 0 ? (int)(count/ilmt) : 0;
if (total_pages*ilmt < count)
    total_pages++;
if (ipg > total_pages)
    ipg=total_pages;

int start = ilmt*ipg - ilmt;
if(start < 0)
    start = 0;


obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);

String sql = ""
        + " SELECT * "
        + " FROM v_lab_sampleitem"
        + " WHERE "+where
        + " ORDER BY "+sidx+" "+sord+" limit "+ilmt+" offset "+start;

rs   = c.createStatement().executeQuery(sql);
//System.out.println(sql);
while(rs.next())
{
    String name = "";
    ContractsampleitemBean cb = ContractsampleitemManager.getInstance().loadByPrimaryKey(rs.getLong(1));
    SampleitemreseachBean[] sb = SampleitemreseachManager.getInstance().loadByWhere("where contractsampleitemid = "+cb.getContractsampleitemid());
    if(sb.length > 0){
        InstitutionBean inst = InstitutionManager.getInstance().loadByPrimaryKey(sb[0].getInstitutionid());
        name = getFullLabName(inst, "\\");
    }
    String spc = "";
    ContractsampletypeBean ct = ContractsampletypeManager.getInstance().loadByPrimaryKey(cb.getContractsampletypeid());
    if(ct.getSpeciesid() != null){
        SpeciesBean sp = SpeciesManager.getInstance().loadByPrimaryKey(ct.getSpeciesid());
        spc = sp.getName();
    }
    JSONArray cell = new JSONArray();
    cell.add(rs.getLong(1));
    cell.add(rs.getString("smname"));
    cell.add(spc);
    cell.add(_DT_.format(rs.getDate("regdate")));
    cell.add(rs.getString("contragent"));
    cell.add(rs.getString("num1"));
    cell.add(name);
    cell.add(st.get(rs.getInt("status")));
    cell.add(""
            + "<button data-itemid=\""+rs.getInt(1)+"\" class=\"btn btn-warning showban\" type=\"button\" style=\"height: 34px !important;\"><i class=\"fa fa-xm fa-ban\"></i> </button> "
            + "<button data-itemid=\""+rs.getInt(1)+"\" class=\"btn btn-danger showdestroy\" type=\"button\" style=\"height: 34px !important;\"><i class=\"fa fa-xm fa-bomb\"></i> </button> "
            + "<button data-itemid=\""+rs.getInt(1)+"\" class=\"btn btn-primary showinfo\" type=\"button\" style=\"height: 34px !important;\"><i class=\"fa fa-xm fa-info\"></i> </button> "
            + "<button data-itemid=\""+rs.getInt(1)+"\" class=\"btn btn-primary showcode\" type=\"button\" style=\"height: 34px !important;\"><i class=\"fa fa-xm fa-print\"></i> </button> "
//            + "<button data-itemid=\""+rs.getInt(1)+"\" class=\"btn btn-danger tip\" data-original-title=\""+trs.t("წაშლა")+"\" type=\"button\" style=\"height: 34px !important;\"><i class=\"fa fa-xm fa-trash\"></i> </button>"
            );
    cell.add(rs.getInt("status"));

    JSONObject ob = new JSONObject();
    ob.put("id",rs.getInt(1));
    ob.put("cell",cell);
    rows.add(ob);
}






}
catch (Exception e) { 
    e.printStackTrace();
}
finally {
    Manager.getInstance().releaseConnection( c );
}

obj.put("rows",rows);
JSONObject userdata = new JSONObject();
System.out.println(obj.toString());
obj.put("userdata",userdata);
out.print(obj.toString());
out.flush();
%>
