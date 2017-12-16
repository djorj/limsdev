<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%@include file="../api/api.inc.jsp"%>
<%
Connection c   = Manager.getInstance().getConnection();
JSONArray rows = new JSONArray();
JSONObject obj = new JSONObject();

try
{

String where = "where status in (3,6) ";

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
if (request.getParameter("sampletype")!=null && request.getParameter("sampletype").trim().length()>0){
    int stp = Integer.parseInt(request.getParameter("sampletype"));
    if(stp > 3000)   where += " and derivatetypeid = "+stp;
    else             where += " and sampletypeid = "+stp;
}
if (request.getParameter("statusid")!=null && request.getParameter("statusid").trim().length()>0)  where += " and status = "+Integer.parseInt(request.getParameter("statusid"));
if (request.getParameter("speciesid")!=null && request.getParameter("speciesid").trim().length()>0)  where += " and barcode in ("
        + "select c.contractsampleitemid from contractsampleitem c, contractsampletype t where c.contractsampletypeid = t.contractsampletypeid and t.speciesid = "+request.getParameter("speciesid")+")";

String cnt = "SELECT count(*) FROM sampleitemstatushistory WHERE "+where;


int count = (int)getSum(cnt);
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
SampleitemstatushistoryBean[] tmps = SampleitemstatushistoryManager.getInstance().loadByWhere(where+ " ORDER BY "+sidx+" "+sord+" limit "+ilmt+" offset "+start);

for(int i=0;i<tmps.length;i++)
{
    ContractsampleitemBean item = ContractsampleitemManager.getInstance().loadByPrimaryKey(tmps[i].getContractsampleitemid());
    ContractsampletypeBean type = ContractsampletypeManager.getInstance().loadByPrimaryKey(item.getContractsampletypeid());
    SampletypeBean stype = SampletypeManager.getInstance().loadByPrimaryKey(type.getSampletypeid());
    SamplestatusBean status = SamplestatusManager.getInstance().loadByPrimaryKey(tmps[i].getStatus());
    PersonellBean author = PersonellManager.getInstance().loadByPrimaryKey(tmps[i].getRegbyid());
    String place = "";
    SampleitemreseachBean[] sb = SampleitemreseachManager.getInstance().loadByContractsampleitemid(tmps[i].getContractsampleitemid());
    TransitsampleitemBean[] tr = TransitsampleitemManager.getInstance().loadByWhere("where contractsampleitemid = "+tmps[i].getContractsampleitemid()+" order by transitdate desc limit 1");
    if(tr.length > 0){
        InstitutionBean inst = InstitutionManager.getInstance().loadByPrimaryKey(tr[0].getLocationid());
        place = getFullLabName(inst, " - ");
    } else if(sb.length > 0){
        InstitutionBean inst = InstitutionManager.getInstance().loadByPrimaryKey(sb[0].getInstitutionid());
        place = getFullLabName(inst, " - ");
    } else if(item.getInstitutionid() != null){
        InstitutionBean inst = InstitutionManager.getInstance().loadByPrimaryKey(item.getInstitutionid());
        place = getFullLabName(inst, " - ");
    }
    JSONArray cell = new JSONArray();
    cell.add(tmps[i].getContractsampleitemid());
    cell.add(stype.getName());
    cell.add(dt.format(tmps[i].getRegdate()));
    cell.add(item.getNum1());
    cell.add(place);
    cell.add(status.getName());
    cell.add(author.getFname()+" "+author.getLname());
    cell.add(tmps[i].getStatus());

    JSONObject ob = new JSONObject();
    ob.put("id",tmps[i].getContractsampleitemid());
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
