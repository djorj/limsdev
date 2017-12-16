<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String where = "where companyid = "+user.getCompanyid()+" and parentid is not null";
int pid = Integer.parseInt(request.getParameter("pid"));

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


int count = MenuManager.getInstance().countWhere(where);
int total_pages = 0;
if(count > 0)    total_pages = (int)(count/ilmt);
if(total_pages*ilmt < count)    total_pages++;
if(ipg > total_pages) ipg=total_pages;
int start = ilmt*ipg - ilmt;
if(start < 0)   start = 0;
String limit = "limit "+ilmt+" offset "+start;

JSONObject obj = new JSONObject();
obj.put("page",ipg);
obj.put("total",total_pages);
obj.put("records",count);
if(pid > 0){
    MenuBean[] menus = MenuManager.getInstance().loadByWhere(where+" order by parentid, ord "+limit);
    JSONArray rows = new JSONArray();
    for(int i=0;i<menus.length;i++){
        MenuBean parent = MenuManager.getInstance().loadByPrimaryKey(menus[i].getParentid());
        JSONObject ob = new JSONObject();
        ob.put("id",menus[i].getMenuid());
        JSONArray cell = new JSONArray();
        cell.add(trs.t(parent.getName()));
        cell.add(trs.t(menus[i].getName()));

        String checked = "";
        if(PlevelManager.getInstance().countWhere("where read = true and personelltypeid = "+pid+" and menuid = "+menus[i].getMenuid()) > 0)    checked = "checked";
        String chkbox = "<div class='smart-form'><label class='checkbox cust'><input type='checkbox' class='gText' name='rmenu_"+pid+"_"+menus[i].getMenuid()+"' id='rmenu_"+pid+"_"+menus[i].getMenuid()+"' value='"+menus[i].getMenuid()+"' onclick='chLevel("+pid+","+menus[i].getMenuid()+",this.checked,1)' "+checked+"><i></i></label></div>";
        cell.add(chkbox);

        checked = "";
        if(PlevelManager.getInstance().countWhere("where write = true and personelltypeid = "+pid+" and menuid = "+menus[i].getMenuid()) > 0)   checked = "checked";
        chkbox = "<div class='smart-form'><label class='checkbox cust'><input type='checkbox' class='gText' name='wmenu_"+pid+"_"+menus[i].getMenuid()+"' id='wmenu_"+pid+"_"+menus[i].getMenuid()+"' value='"+menus[i].getMenuid()+"' onclick='chLevel("+pid+","+menus[i].getMenuid()+",this.checked,2)' "+checked+"><i></i></label></div>";
        cell.add(chkbox);

        checked = "";
        if(PlevelManager.getInstance().countWhere("where print = true and personelltypeid = "+pid+" and menuid = "+menus[i].getMenuid()) > 0)   checked = "checked";
        chkbox = "<div class='smart-form'><label class='checkbox cust'><input type='checkbox' class='gText' name='pmenu_"+pid+"_"+menus[i].getMenuid()+"' id='pmenu_"+pid+"_"+menus[i].getMenuid()+"' value='"+menus[i].getMenuid()+"' onclick='chLevel("+pid+","+menus[i].getMenuid()+",this.checked,3)' "+checked+"><i></i></label></div>";
        cell.add(chkbox);

        checked = "";
        if(PlevelManager.getInstance().countWhere("where export = true and personelltypeid = "+pid+" and menuid = "+menus[i].getMenuid()) > 0)  checked = "checked";
        chkbox = "<div class='smart-form'><label class='checkbox cust'><input type='checkbox' class='gText' name='emenu_"+pid+"_"+menus[i].getMenuid()+"' id='emenu_"+pid+"_"+menus[i].getMenuid()+"' value='"+menus[i].getMenuid()+"' onclick='chLevel("+pid+","+menus[i].getMenuid()+",this.checked,4)' "+checked+"><i></i></label></div>";
        cell.add(chkbox);            

        ob.put("cell",cell);
        rows.add(ob);
    }
    obj.put("rows",rows);
}
JSONObject userdata = new JSONObject();
//userdata.put("price",dc.format(total));
obj.put("userdata",userdata);
out.print(obj.toString());
out.flush();
%>
