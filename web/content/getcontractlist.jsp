<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%@include file="../api/api.inc.jsp"%>
<%
    try {
String where = "where deleted=false ";
String pg   = request.getParameter("page");
String lmt  = request.getParameter("rows");
String sidx = request.getParameter("sidx")==null ? "" : request.getParameter("sidx");
String sord = request.getParameter("sord")==null ? "" : request.getParameter("sord");
int ipg  = (pg != null) ? Integer.parseInt(pg) : 1;
int ilmt = (lmt != null) ? Integer.parseInt(lmt) : 10;

if (request.getParameter("name")!=null&&request.getParameter("name").trim().length()>0)  where += " and upper(name) like '%"+request.getParameter("name").trim().toUpperCase().replaceAll("'", "''")+"%'";
if (request.getParameter("address")!=null&&request.getParameter("address").trim().length()>0)  where += " and upper(address) like '%"+request.getParameter("address").trim().toUpperCase().replaceAll("'", "''")+"%'";
if (request.getParameter("email")!=null&&request.getParameter("email").trim().length()>0)  where += " and upper(email) like '%"+request.getParameter("email").trim().toUpperCase().replaceAll("'", "''")+"%'";
if (request.getParameter("contact")!=null&&request.getParameter("contact").trim().length()>0)  where += " and upper(contact) like '%"+request.getParameter("contact").trim().toUpperCase().replaceAll("'", "''")+"%'";

if (request.getParameter("num")!=null&&request.getParameter("num").trim().length()>0)  where += " and upper(num) like '%"+request.getParameter("num").trim().toUpperCase().replaceAll("'", "''")+"%'";
if (request.getParameter("status")!=null&&request.getParameter("status").trim().length()>0)  where += " and status = "+Integer.parseInt(request.getParameter("status"));
if (request.getParameter("contragentid")!=null&&request.getParameter("contragentid").trim().length()>0)  where += " and contragentid = "+Integer.parseInt(request.getParameter("contragentid"));
if (request.getParameter("contracttype")!=null&&request.getParameter("contracttype").trim().length()>0)  where += " and contracttype = "+Integer.parseInt(request.getParameter("contracttype"));

int count = ContractManager.getInstance().countWhere(where);
int total_pages = count > 0 ? (int)(count/ilmt) : 0;
if (total_pages*ilmt < count)
    total_pages++;
if (ipg > total_pages)
    ipg=total_pages;

int start = ilmt*ipg - ilmt;
if(start < 0)
    start = 0;

where = where+" order by "+sidx+" "+sord+" limit "+ilmt+" offset "+start;
System.out.println(where);

String[] _CONTRACTTYPE_ = 
{
    "",
    "ერთჯერადი",
    "მრავალჯერადი"
};
String[] _CONTRACTSTATUS_ = 
{
    "",
    "აქტიური",
    "არაქტიური",
    "ნიმუშები გადაცემულია"
};

ContractBean[] list = ContractManager.getInstance().loadByWhere(where);
JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
JSONArray rows = new JSONArray();
for(int i=0;i<list.length;i++){
    ContragentBean contragent = ContragentManager.getInstance().loadByPrimaryKey(list[i].getContragentid());
    int cnt = BillManager.getInstance().countWhere("where contractid = "+list[i].getContractid());
    String checked = "";
    if(cnt > 0) checked = "checked";
    JSONObject ob = new JSONObject();
    ob.put("id",list[i].getContractid());
    JSONArray cell = new JSONArray();
    if (1==list[i].getContracttype())
    {
        cell.add(list[i].getContractid());
        cell.add(_CONTRACTTYPE_[list[i].getContracttype()]);
        cell.add(contragent.getName());
        cell.add(list[i].getNum());
        cell.add(_DT_.format(list[i].getStartdate()));
        cell.add("-");
        cell.add(_DT_.format(list[i].getEnddate()));
        cell.add(_CONTRACTSTATUS_[list[i].getStatus()]);
        cell.add("<button class=\"btn btn-sm btn-default printcontract\" data-itemid=\""+list[i].getContractid()+"\" style=\"height: 34px !important;\" onclick=\"printReport('contract',"+list[i].getContractid()+")\"><i class=\"fa fa-xm fa-print\"></i></button> ");
        cell.add("<button class=\"btn btn-sm btn-default viewbill\" data-itemid=\""+list[i].getContractid()+"\" style=\"height: 34px !important;\" data-original-title=\""+trs.t("ქვითარი")+"\"><i class=\"fa fa-xm fa-print\"></i></button>");
        cell.add("<button class=\"btn btn-sm btn-default viewdocs\" data-itemid=\""+list[i].getContractid()+"\" style=\"height: 34px !important;\" data-original-title=\""+trs.t("დოკუმენტები")+"\"><i class=\"fa fa-xm fa-print\"></i></button>");
        cell.add("<input type=\"checkbox\" onclick=\"checkpaid("+list[i].getContractid()+")\" data-original-title=\""+trs.t("მონიშნეთ თუ გადახდილია")+"\" "+checked+">");
    }
    else
    {
        cell.add(list[i].getContractid());
        cell.add(_CONTRACTTYPE_[list[i].getContracttype()]);
        cell.add(contragent.getName());
        cell.add(list[i].getNum());
        cell.add(_DT_.format(list[i].getStartdate()));
        cell.add(list[i].getPrice());
        cell.add(_DT_.format(list[i].getEnddate()));
        cell.add(_CONTRACTSTATUS_[list[i].getStatus()]);
        cell.add("<button class=\"btn btn-sm btn-default printcontract\" data-itemid=\""+list[i].getContractid()+"\" style=\"height: 34px !important;\" onclick=\"printReport('contract',"+list[i].getContractid()+")\"><i class=\"fa fa-xm fa-print\"></i></button> ");
        cell.add("");
        cell.add("");
        cell.add("<input type=\"checkbox\" onclick=\"checkpaid("+list[i].getContractid()+")\" data-original-title=\""+trs.t("მონიშნეთ თუ გადახდილია")+"\" "+checked+">");
    }
    ob.put("cell",cell);
    rows.add(ob);
}
obj.put("rows",rows);
JSONObject userdata = new JSONObject();
System.out.println(obj.toString());
obj.put("userdata",userdata);
out.print(obj.toString());
out.flush();
}
catch (Exception e) 
{
    e.printStackTrace();
}
%>
