<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String where = "where companyid = "+user.getCompanyid()+" and parenttest is null";

if(request.getParameter("_search") != null && request.getParameter("_search").equalsIgnoreCase("true")){
    String name = request.getParameter("name");
    if(name == null)   name = "";
    name = name.trim().toUpperCase().replaceAll("'", "''");
    if(name.length() > 0)  where += " and upper(name) like '%"+name+"%'";
}

String barcode = request.getParameter("reqbarcode");
if(barcode == null) barcode = "";

if(barcode.trim().length() > 0)
    where += " and barcode = '"+barcode.trim().replaceAll("'", "''") +"'";
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
if(request.getParameter("labtest") != null && request.getParameter("labtest").trim().length() > 0)  where += " and labtestid = "+request.getParameter("labtest") +" ";
if(request.getParameter("author") != null && request.getParameter("author").trim().length() > 0)  where += " and authorid = "+request.getParameter("author") +" ";
if(request.getParameter("sampletype") != null && request.getParameter("sampletype").trim().length() > 0)  where += " and sampletypeid = "+request.getParameter("sampletype") +" ";
if(request.getParameter("contragentid")!=null && request.getParameter("contragentid").trim().length()>0)  where += " and contragentid in (select contragentid from contragent where upper(name) like '%"+request.getParameter("contragentid")+"%' or upper(fname || ' ' || lname) like '%"+request.getParameter("contragentid")+"%' or upper(lname || ' ' || fname) like '%"+request.getParameter("contragentid")+"%' or idn = '"+request.getParameter("contragentid")+"')";
if(request.getParameter("method") != null && request.getParameter("method").trim().length() > 0)  where += " and labtestid in (select labtestid from labteststandard where standardid = "+request.getParameter("method") +") ";
if(request.getParameter("contract") != null && request.getParameter("contract").trim().length() > 0)  where += " and contractid in (select contractid from contract where upper(num) like '%"+request.getParameter("contract").replaceAll("'", "''") +"%') ";
if(request.getParameter("act") != null && request.getParameter("act").trim().length() > 0)  where += " and contractid in (select contractid from act where upper(num) like '%"+request.getParameter("act").replaceAll("'", "''") +"%') ";
if(request.getParameter("appeal") != null && request.getParameter("appeal").trim().length() > 0)  where += " and contractid in (select contractid from appeal where upper(num) like '%"+request.getParameter("appeal").replaceAll("'", "''") +"%') ";

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


int count = VLabAnsByContragentManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord;
//System.out.println(where+" "+order);
VLabAnsByContragentBean[] res = VLabAnsByContragentManager.getInstance().loadByWhere(where+" "+order+" "+limit);
System.out.println("select * from v_lab_ans_by_contragent "+where);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<res.length;i++){
    JSONObject ob = new JSONObject();
    ob.put("id",res[i].getSampleitemreseachid());
    JSONArray cell = new JSONArray();
    ContractBean contract = ContractManager.getInstance().loadByPrimaryKey(res[i].getContractid());
    String num = " "+trs.t("ხელშეკრულება") +" # "+contract.getNum();
    String cid = "contract_"+contract.getContractid().longValue();
    if(res[i].getActid() != null && res[i].getActid().longValue() > 0){
        ActBean act = ActManager.getInstance().loadByPrimaryKey(res[i].getActid());
        cid = "act_"+act.getActid().longValue();
        num += " "+trs.t("აქტი") +" # "+act.getNum();
    }
    if(res[i].getAppealid() != null && res[i].getAppealid().longValue() > 0){
        AppealBean act =AppealManager.getInstance().loadByPrimaryKey(res[i].getAppealid());
        cid = "appeal_"+act.getAppealid().longValue();
        num += " "+trs.t("მომართვა") +" # "+act.getNum();
    }
    
    cell.add(res[i].getContragent()+num);
    cell.add(cid);
    cell.add(res[i].getLabtestname());
    cell.add(res[i].getBarcode());
    cell.add(res[i].getSampletype());
    cell.add(dt.format(res[i].getRegdate()));
    cell.add((res[i].getResultdate()== null) ? "-":dt.format(res[i].getResultdate()));
    cell.add(dt.format(res[i].getPlandate()));
    cell.add(res[i].getNote());
    cell.add((res[i].getConfirmation1id() != null) ? res[i].getConfirmation1id():"0");
    cell.add((res[i].getConfirmation2id() != null) ? res[i].getConfirmation2id():"0");
    cell.add((res[i].getConfirmation3id() != null) ? res[i].getConfirmation3id():"0");
    cell.add(res[i].getSampleitemreseachid());
    ob.put("cell",cell);
    rows.add(ob);
}
obj.put("rows",rows);
JSONObject userdata = new JSONObject();
//userdata.put("price",dc.format(total));
obj.put("userdata",userdata);
out.print(obj.toString());
out.flush();
%>
