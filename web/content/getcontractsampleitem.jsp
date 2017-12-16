<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%@include file="../api/api.inc.jsp"%>
<%
/*
            var tbldata = [{
                    n: "1",
                    id: "1",
                    num: "120",
                    animal: "",
                    code: '<img src="img/code.png" alt="" height="25"/>',
                    print: '<button data-original-title="<%=trs.t("ბეჭდვა")% >" class="btn btn-primary showcode" style="height: 34px !important;"><i class="fa fa-xm fa-print"></i> </button> <button data-original-title="<%=trs.t("წაშლა")% >" class="btn btn-danger" type="button" onclick="showmsg(\'დარწმუნებული ხართ, რომ გნებავთ ჩანაწერის წაშლა?\')" style="height: 34px !important;"><i class="fa fa-xm fa-trash"></i> </button> <button data-original-title="<%=trs.t("დაწუნება")% >" class="btn btn-warning" type="button" onclick="showmsgban()" style="height: 34px !important;"><i class="fa fa-xm fa-ban"></i> </button>'
                }, {
                    n: "2",
                    id: "2",
                    num: "2",
                    animal: "",
                    code: '<img src="img/code.png" alt="" height="25"/>',
                    print: '<button data-original-title="<%=trs.t("ბეჭდვა")% >" class="btn btn-primary showcode" style="height: 34px !important;"><i class="fa fa-xm fa-print"></i> </button> <button data-original-title="<%=trs.t("წაშლა")% >" class="btn btn-danger" type="button" onclick="showmsg(\'დარწმუნებული ხართ, რომ გნებავთ ჩანაწერის წაშლა?\')" style="height: 34px !important;"><i class="fa fa-xm fa-trash"></i> </button> <button data-original-title="<%=trs.t("დაწუნება")% >" class="btn btn-warning" type="button" onclick="showmsgban()" style="height: 34px !important;"><i class="fa fa-xm fa-ban"></i> </button>'
                }, {
                    n: "3",
                    id: "3",
                    num: "980",
                    animal: "",
                    code: '<img src="img/code.png" alt="" height="25"/>',
                    print: '<button data-original-title="<%=trs.t("ბეჭდვა")% >" class="btn btn-primary showcode" style="height: 34px !important;"><i class="fa fa-xm fa-print"></i> </button> <button data-original-title="<%=trs.t("წაშლა")% >" class="btn btn-danger" type="button" onclick="showmsg(\'დარწმუნებული ხართ, რომ გნებავთ ჩანაწერის წაშლა?\')" style="height: 34px !important;"><i class="fa fa-xm fa-trash"></i> </button> <button data-original-title="<%=trs.t("დაწუნება")% >" class="btn btn-warning" type="button" onclick="showmsgban()" style="height: 34px !important;"><i class="fa fa-xm fa-ban"></i> </button>'
                }];
            var tbldata1 = [{
                    n: "1",
                    id: "1",
                    num: "122",
                    animal: "",
                    code: '',
                    print: '<button data-original-title="<%=trs.t("დაწუნების გაუქმება")% >" class="btn btn-success" type="button" onclick="showmsg(\'დარწმუნებული ხართ, რომ გნებავთ დაწუნებულის უკან დაბრუნება?\')" style="height: 34px !important;"><i class="fa fa-xm fa-refresh"></i> </button>'
                }, {
                    n: "2",
                    id: "2",
                    num: "23",
                    animal: "",
                    code: '',
                    print: '<button data-original-title="<%=trs.t("დაწუნების გაუქმება")% >" class="btn btn-success" type="button" onclick="showmsg(\'დარწმუნებული ხართ, რომ გნებავთ დაწუნებულის უკან დაბრუნება?\')" style="height: 34px !important;"><i class="fa fa-xm fa-refresh"></i> </button>'
                }];
                
*/

Connection c  = Manager.getInstance().getConnection();
ResultSet rs;
ResultSet rs2;
JSONArray rows = new JSONArray();

try
{
    String boxid = request.getParameter("sampleid");//.trim().replaceAll("\\","\\\\");
    if (request.getParameter("disclaim")!=null && request.getParameter("disclaim").equals("0"))
    {
        String sql = ""
        + " SELECT itm.contractsampleitemid, itm.num1, itm.num2"
        + " FROM contractsampletype con, contractsampleitem itm"
        + " WHERE con.contractsampletypeid=itm.contractsampletypeid AND itm.disclaim<>true AND itm.num1 is not null AND con.contractsampletypeid="+boxid
        + " ORDER BY itm.num1 " +(request.getParameter("sord")!=null ? request.getParameter("sord") : "");
session.setAttribute("CONTRACTSAMPLEITEMS_BOX_SQL", (String)sql);
System.out.println("contractsampleitem: "+sql);

        rs = c.createStatement().executeQuery(sql);
        int n=0;
        while(rs.next())
        {
            n++;
            String num = rs.getString(2);
            if(num == null) num = "";
            JSONObject tmp  = new JSONObject();
            tmp.put("n",      n);
            tmp.put("id",     rs.getInt(1));
            tmp.put("num",    num);
            tmp.put("num",   "<div class=\"input-group\"><label class=\"input min\"><input type=\"text\" id=\"num1_"+rs.getInt(1)+"\" value=\""+(rs.getString(2)!=null ? rs.getString(2) : "")+"\"></label></div>");
            tmp.put("animal","<div class=\"input-group\"><label class=\"input min\"><input type=\"text\" id=\"num2_"+rs.getInt(1)+"\" value=\""+(rs.getString(3)!=null ? rs.getString(3) : "")+"\"></label></div>");
            tmp.put("code",   "<img src=\"img/code.png\" alt=\"\" height=\"25\"/>");
            tmp.put("print", ""
                    + "<button class=\"btn btn-success savenums\" data-itemid=\""+rs.getInt(1)+"\" data-original-title=\""+trs.t("შენახვა")+"\" style=\"height: 34px !important;\"><i class=\"fa fa-xm fa-check\"></i></button> "
                    + "<button class=\"btn btn-primary\" onclick=\"printBcodeNum("+rs.getInt(1)+",'"+num+"');\" data-original-title=\""+trs.t("ბეჭდვა")+"\" style=\"height: 34px !important;\"><i class=\"fa fa-xm fa-print\"></i></button> "
                    + "<button class=\"btn btn-danger deleteban\" data-itemid=\""+rs.getInt(1)+"\" data-original-title=\""+trs.t("წაშლა")+"\" type=\"button\" style=\"height: 34px !important;\"><i class=\"fa fa-xm fa-trash\"></i></button> "
                    + "<button class=\"btn btn-warning banitem\" data-itemid=\""+rs.getInt(1)+"\" data-original-title=\""+trs.t("დაწუნება")+"\" type=\"button\" style=\"height: 34px !important;\"><i class=\"fa fa-xm fa-ban\"></i></button>");

            rows.add(tmp);
        }
    }
    else
    {
        String sql = ""
        + " SELECT itm.contractsampleitemid, itm.num1, itm.num2"
        + " FROM contractsampletype con, contractsampleitem itm"
        + " WHERE con.contractsampletypeid=itm.contractsampletypeid AND itm.disclaim=true AND itm.num1 is not null AND con.contractsampletypeid="+boxid
        + " ORDER BY itm.num1 " +(request.getParameter("sord")!=null ? request.getParameter("sord") : "");


System.out.println("contractsampleitem: "+sql);

        rs = c.createStatement().executeQuery(sql);
        int n=0;
        while(rs.next())
        {
            n++;
            sql = "SELECT string_agg(reason, '; ') FROM  disclaimsampleitem WHERE contractsampleitemid="+rs.getInt(1);
            rs2 = c.createStatement().executeQuery(sql);
            
            JSONObject tmp  = new JSONObject();
            tmp.put("n",      n);
            tmp.put("id",     rs.getInt(1));
            tmp.put("num",   "<div class=\"input-group\"><label class=\"input min\">"+(rs.getString(2)!=null ? rs.getString(2) : "")+"</label></div>");
            tmp.put("animal","<div class=\"input-group\"><label class=\"input min\">"+(rs.getString(3)!=null ? rs.getString(3) : "")+"</label></div>");
            tmp.put("code",   "<img src=\"img/code.png\" alt=\"\" height=\"25\"/>");
            tmp.put("disclaim",   rs2.next() ? rs2.getString(1) : "");
            tmp.put("print", "<button data-itemid=\""+rs.getInt(1)+"\" data-original-title=\""+trs.t("დაწუნების გაუქმება")+"\" class=\"btn btn-success cancelban\" type=\"button\" style=\"height: 34px !important;\"><i class=\"fa fa-xm fa-refresh\"></i> </button>");
            rows.add(tmp);
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
