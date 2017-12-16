<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String where = "where companyid = "+user.getCompanyid();

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
if(request.getParameter("_search") != null && request.getParameter("_search").equalsIgnoreCase("true")){
    String name = request.getParameter("name");
    if(name == null)   name = "";
    name = name.trim().toUpperCase().replaceAll("'", "''");
    if(name.length() > 0)  where += " and upper(name) like '%"+name+"%'";
    
    String samples = request.getParameter("samples");
    if(samples == null)   samples = "";
    samples = samples.trim().toUpperCase().replaceAll("'", "''");
    //if(samples.length() > 0)  where += " and upper(name) like '%"+name+"%'";
    
    String departments = request.getParameter("departments");
    if(departments == null)   departments = "";
    departments = departments.trim().toUpperCase().replaceAll("'", "''");
    //if(departments.length() > 0)  where += " and upper(name) like '%"+name+"%'";
    
    String standards = request.getParameter("standards");
    if(standards == null)   standards = "";
    standards = standards.trim().toUpperCase().replaceAll("'", "''");
    //if(standards.length() > 0)  where += " and upper(name) like '%"+name+"%'";
    
    
    int testcategoryid = Integer.parseInt(request.getParameter("testcategoryid"));
    if(testcategoryid > 0)  where += " and testcategoryid = "+testcategoryid;
    
    int type = Integer.parseInt(request.getParameter("type"));
    if(type == 1)   where += " and grp = false and ctr = false";
    if(type == 2)   where += " and grp = true and ctr = false";
    if(type == 3)   where += " and grp = false and ctr = true";
    
}

int count = LabtestManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

String order = "order by "+sidx+" "+sord+", labtestid";

LabtestBean[] tests = LabtestManager.getInstance().loadByWhere(where+" "+order+" "+limit);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<tests.length;i++){
    JSONObject ob = new JSONObject();
    ob.put("id",tests[i].getLabtestid());
    String type = "ტესტი";
    if(tests[i].getGrp().booleanValue())    type = "ჯგუფი";
    else if(tests[i].getCtr().booleanValue())    type = "კონტროლი";
    String unitname = "";
    if(tests[i].getUnitsid() != null){
        UnitsBean unit = UnitsManager.getInstance().loadByPrimaryKey(tests[i].getUnitsid());
        unitname = unit.getName();
    }
    RestypeBean restype = RestypeManager.getInstance().loadByPrimaryKey(tests[i].getRestypeid());
    TestcategoryBean cat = TestcategoryManager.getInstance().loadByPrimaryKey(tests[i].getTestcategoryid());
    /*
    String grouplist = "";
    TestgroupBean[] gr = TestgroupManager.getInstance().loadByWhere("where labtestid = "+tests[i].getLabtestid()+" order by (select l.name from labtest l where l.labtestid = testgroup.testgroupid limit 1)");
    for(int j=0;j<gr.length;j++){
        if(j > 0)   grouplist += " ";
        LabtestBean lb = LabtestManager.getInstance().loadByPrimaryKey(gr[j].getTestgroupid());
        grouplist += lb.getName();
    }
    String samplelist = "";
    LabtestsampletypeBean[] sm = LabtestsampletypeManager.getInstance().loadByWhere("where labtestid = "+tests[i].getLabtestid()+" order by (select l.name from sampletype l where l.sampletypeid = labtestsampletype.sampletypeid limit 1)");
    for(int j=0;j<sm.length;j++){
        if(j > 0)   samplelist += " ";
        SampletypeBean lb = SampletypeManager.getInstance().loadByPrimaryKey(sm[j].getSampletypeid());
        samplelist += lb.getName();
    }
    String instlist = "";
    LabtestinstitutionBean[] ins = LabtestinstitutionManager.getInstance().loadByWhere("where labtestid = "+tests[i].getLabtestid()+" order by (select l.name from institution l where l.institutionid = labtestinstitution.institutionid limit 1)");
    for(int j=0;j<ins.length;j++){
        if(j > 0)   instlist += " ";
        InstitutionBean lb = InstitutionManager.getInstance().loadByPrimaryKey(ins[j].getInstitutionid());
        instlist += lb.getName();
    }
    */
    String standards = "";
    LabteststandardBean[] stds = LabteststandardManager.getInstance().loadByWhere("where labtestid = "+tests[i].getLabtestid()+" order by standardid");
    for(int j=0;j<stds.length;j++){
        if(j > 0)   standards += "<br> ";
        StandardBean std = StandardManager.getInstance().loadByPrimaryKey(stds[j].getStandardid());
        standards += trs.t(std.getName());
    }
    double curprice = getSum("select price from price where labtestid = "+tests[i].getLabtestid()+" order by pricedate desc limit 1");
    
    String norms = "";
    if(tests[i].getRestypeid().intValue() == 1) norms = (tests[i].getBnormval1() != null) ? tests[i].getBnormval1():"";
    else if(tests[i].getRestypeid().intValue() == 2){ 
        if(tests[i].getNormmin() != null) norms = tests[i].getNormmin().toString();
        if(tests[i].getNormmax() != null) norms += " - "+tests[i].getNormmax().toString();
    } else if(tests[i].getRestypeid().intValue() == 3) norms = (tests[i].getTnorm() != null) ? trs.t(tests[i].getTnorm()):"";
    
    JSONArray cell = new JSONArray();
    cell.add(trs.t(cat.getName()));
    cell.add(trs.t(tests[i].getName()));
    cell.add(trs.t((tests[i].getDescription()== null) ? "":tests[i].getDescription()));
    cell.add(trs.t(type));
    cell.add(trs.t(unitname));
    cell.add(trs.t(restype.getName()));
    cell.add(standards);
    cell.add(dc.format(curprice));
    cell.add(norms);
    cell.add(restype.getRestypeid());
    ob.put("cell",cell);
    rows.add(ob);
}
obj.put("rows",rows);
JSONObject userdata = new JSONObject();
//userdata.put("price",dc.format(total));
System.out.println(obj.toString());
obj.put("userdata",userdata);
out.print(obj.toString());
out.flush();
%>
