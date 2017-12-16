<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String where = "where contractid > 0 ";


// ლაბორატორიის უფროსი
if(user.getPersonelltypeid().intValue() == 12)
    where += "and institutionid = "+user.getInstitutionid();

// დეპარტამენტის უფროსი
if(user.getPersonelltypeid().intValue() == 9){
    where += "and institutionid in (select institutionid from institution where parentid = "+user.getInstitutionid()+")";
    
}

// რეგიონალური ადმინისტრატორი
if(user.getPersonelltypeid().intValue() == 36){
    where += "and (institutionid in (select institutionid from institution where parentid = "+user.getInstitutionid()+") or institutionid = "+user.getInstitutionid()+")";
    
}

if(request.getParameter("_search") != null && request.getParameter("_search").equalsIgnoreCase("true")){
    String name = request.getParameter("name");
    if(name == null)   name = "";
    name = name.trim().toUpperCase().replaceAll("'", "''");
    if(name.length() > 0)  where += " and upper(name) like '%"+name+"%'";
}

String barcode = request.getParameter("reqbarcode");
if(barcode == null) barcode = "";

if(barcode.trim().length() > 0)
    where += " and (barcode::text like '%"+barcode.trim().replaceAll("'", "''") +"' or contractsampleitemid in (select parentid from contractsampleitem where barcode::text like '%"+barcode.trim().replaceAll("'", "''")+"') or contractsampleitemid in (select contractsampleitemid from contractsampleitem where parentid::text like '%"+barcode.trim().replaceAll("'", "''")+"'))";
if(request.getParameter("regdate") != null && request.getParameter("regdate").trim().length() > 0){
    String regdate = request.getParameter("regdate").trim();
    String[] search_date = regdate.split("-");
    if(search_date.length == 1){
        where += " and regdate::date = to_date('"+search_date[0]+"','DD/MM/YYYY')";
    } else if(search_date.length == 2){
        where += " and regdate::date >= to_date('"+search_date[0].trim()+"','DD/MM/YYYY')";
        where += " and regdate::date <= to_date('"+search_date[1].trim()+"','DD/MM/YYYY')";
    }
}
if(request.getParameter("resultdate") != null && request.getParameter("resultdate").trim().length() > 0){
    String resultdate = request.getParameter("resultdate").trim();
    String[] search_date = resultdate.split("-");
    if(search_date.length == 1){
        where += " and resultdate::date = to_date('"+search_date[0]+"','DD/MM/YYYY')";
    } else if(search_date.length == 2){
        where += " and resultdate::date >= to_date('"+search_date[0].trim()+"','DD/MM/YYYY')";
        where += " and resultdate::date <= to_date('"+search_date[1].trim()+"','DD/MM/YYYY')";
    }
}
if(request.getParameter("plandate") != null && request.getParameter("plandate").trim().length() > 0){
    String plandate = request.getParameter("plandate").trim();
    String[] search_date = plandate.split("-");
    if(search_date.length == 1){
        where += " and plandate::date = to_date('"+search_date[0]+"','DD/MM/YYYY')";
    } else if(search_date.length == 2){
        where += " and plandate::date >= to_date('"+search_date[0].trim()+"','DD/MM/YYYY')";
        where += " and plandate::date <= to_date('"+search_date[1].trim()+"','DD/MM/YYYY')";
    }
}
if(request.getParameter("note") != null && request.getParameter("note").trim().length() > 0)  where += " and note like = '%"+request.getParameter("note").replaceAll("'", "''") +"%' ";
if(request.getParameter("research") != null && request.getParameter("research").trim().length() > 0)  where += " and labtestid = "+request.getParameter("research") +" ";
if(request.getParameter("author") != null && request.getParameter("author").trim().length() > 0)  where += " and authorid = "+request.getParameter("author") +" ";
if(request.getParameter("sampletype") != null && request.getParameter("sampletype").trim().length() > 0)  where += " and sampletypeid = "+request.getParameter("sampletype") +" ";
if(request.getParameter("contragentid")!=null && request.getParameter("contragentid").trim().length()>0)  where += " and contragentid in (select contragentid from contragent where upper(name) like '%"+request.getParameter("contragentid")+"%' or upper(fname || ' ' || lname) like '%"+request.getParameter("contragentid")+"%' or upper(lname || ' ' || fname) like '%"+request.getParameter("contragentid")+"%' or idn = '"+request.getParameter("contragentid")+"')";
if(request.getParameter("method") != null && request.getParameter("method").trim().length() > 0)  where += " and labtestid in (select labtestid from labteststandard where standardid = "+request.getParameter("method") +") ";
if(request.getParameter("contract") != null && request.getParameter("contract").trim().length() > 0)  where += " and contractid in (select contractid from contract where upper(num) like '%"+request.getParameter("contract").replaceAll("'", "''") +"%') ";
if(request.getParameter("act") != null && request.getParameter("act").trim().length() > 0)  where += " and actid in (select actid from act where upper(num) like '%"+request.getParameter("act").replaceAll("'", "''") +"%') ";
if(request.getParameter("appeal") != null && request.getParameter("appeal").trim().length() > 0)  where += " and appealid in (select appealid from appeal where upper(num) like '%"+request.getParameter("appeal").replaceAll("'", "''") +"%') ";
if(request.getParameter("institutionid") != null && request.getParameter("institutionid").trim().length() > 0)  where += " and institutionid = "+request.getParameter("institutionid") +" ";

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
//if(isidx == 0) isidx = 1;


int count = VAnswersManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord;
System.out.println("select * from v_answers "+where+" "+order+" "+limit);
VAnswersBean[] res = VAnswersManager.getInstance().loadByWhere(where+" "+order+" "+limit);
Connection con = Manager.getInstance().getConnection();
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<res.length;i++){
    JSONObject params = new JSONObject();
    params.put("contractid",res[i].getContractid());
    params.put("appealid",(res[i].getAppealid() == null) ? 0:res[i].getAppealid());
    params.put("actid",(res[i].getActid() == null) ? 0:res[i].getActid());
    params.put("sampletypeid",res[i].getSampletypeid());
    String sqllevel = "select case "
            + "when s.confirmation3id is not null then 3 "
            + "when s.confirmation2id is not null then 2 "
            + "when s.confirmation1id is not null then 1 "
            + "else 0 end as level "
            + "from contractsampleitem i, contractsampletype t, sampleitemreseach s "
            + "where t.contractsampletypeid = i.contractsampletypeid and "
            + "i.parentid is not null and "
            + "i.contractsampleitemid = s.contractsampleitemid and ";
    if(res[i].getAppealid() != null)    sqllevel += "t.appealid = "+res[i].getAppealid();
    else if(res[i].getActid() != null)    sqllevel += "t.actid = "+res[i].getActid();
    else    sqllevel += "t.contractid = "+res[i].getContractid();
    if(user.getPersonelltypeid().intValue() != 1)
        sqllevel += " and s.institutionid = "+user.getInstitutionid();
    int lv = -1;
    boolean nonfullconfirm = false;
    ResultSet rs = con.createStatement().executeQuery(sqllevel);
    while(rs.next()){
        int lvl = rs.getInt(1);
        if(lv != lvl && lv >= 0){
            nonfullconfirm = true;
            break;
        }
        lv = lvl;
    }
    rs.close();
    int level = (int)getSum("select f_getconfirmlevel("+((res[i].getAppealid() == null) ? 0:res[i].getAppealid())+","+((res[i].getActid() == null) ? 0:res[i].getActid())+","+res[i].getContractid()+","+res[i].getSampletypeid()+")");
    JSONObject ob = new JSONObject();
    ob.put("id",res[i].getSampleitemreseachid());
    JSONArray cell = new JSONArray();
    String lvl = "<span class='pull-right' style='margin-top: -20px; margin-right: 45px;'>კონფირმაცია ";
    if(!nonfullconfirm){
        if(level == 3)  lvl += "III";
        else if(level == 2)  lvl += "II";
        else if(level == 1)  lvl += "I";
        else    lvl += "არაა";
    } else {
        lvl += "არასრული";
        level = 4;
    }
    lvl += "</span>";
    params.put("level",level);
    String frow = res[i].getNum()+" <input type='hidden' value='"+params.toString()+"'/>"+lvl;
    if(level == 3)
        frow += "<span style='cursor: pointer; margin-top: -20px;' class='pull-right'><a class='btn btn-primary btn-xs' onclick=\"printAnswer("+((res[i].getAppealid() == null) ? 0:res[i].getAppealid())+","+((res[i].getActid() == null) ? 0:res[i].getActid())+","+res[i].getContractid()+","+res[i].getSampletypeid()+")\" style='padding: 1px 7px !important;'><i class='fa fa-print'></i> </a></span>";
    String frw = res[i].getSamplename()+" <span style='cursor: pointer; margin-top: -20px;' class='pull-right'><a class='btn btn-warning btn-xs' onclick=\"printAnswer1("+((res[i].getAppealid() == null) ? 0:res[i].getAppealid())+","+((res[i].getActid() == null) ? 0:res[i].getActid())+","+res[i].getContractid()+","+res[i].getSampletypeid()+")\" style='padding: 1px 7px !important;'><i class='fa fa-print'></i> </a></span>";
   
    cell.add(frow);
    cell.add(frw);
    cell.add(res[i].getBarcode());
    cell.add(res[i].getLabtestname());
    cell.add(res[i].getContractsampleitemid());
    cell.add(res[i].getSname());
    cell.add(dt.format(res[i].getRegdate()));
    cell.add((res[i].getResultdate()== null) ? "-":dt.format(res[i].getResultdate()));
    cell.add(dt.format(res[i].getPlandate()));
    cell.add(res[i].getNote());
    int c1 = (res[i].getConfirmation1id() != null) ? res[i].getConfirmation1id().intValue():0;
    int c2 = (res[i].getConfirmation2id() != null) ? res[i].getConfirmation2id().intValue():0;
    int c3 = (res[i].getConfirmation3id() != null) ? res[i].getConfirmation3id().intValue():0;

    cell.add((res[i].getConfirmation1id() != null) ? c1:"0");
    cell.add((res[i].getConfirmation2id() != null) ? c2:"0");
    cell.add((res[i].getConfirmation3id() != null) ? c3:"0");
    cell.add(res[i].getSampleitemreseachid());
    ob.put("cell",cell);
    rows.add(ob);
}
Manager.getInstance().releaseConnection(con);
obj.put("rows",rows);
JSONObject userdata = new JSONObject();
//userdata.put("price",dc.format(total));
obj.put("userdata",userdata);
out.print(obj.toString());
out.flush();
%>
