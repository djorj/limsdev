<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
    LabtestBean[] groups = LabtestManager.getInstance().loadByWhere("where labtestid != "+labtest.getLabtestid()+" and grp = true order by name");
    
    //InstitutionBean[] insts = InstitutionManager.getInstance().loadByWhere("where parentid is null order by name");
    StandardBean[] stds = StandardManager.getInstance().loadByWhere("order by name");
    DeviceBean[] devs = DeviceManager.getInstance().loadByWhere("order by name");
    String sql = "where companyid = "+user.getCompanyid();
    sql += " and institutionid not in (select parentid from institution where parentid is not null)";
    sql += " order by parentid desc, name";
    InstitutionBean[] menu = InstitutionManager.getInstance().loadByWhere(sql);
%>
<script>
    function setDeviceLabtest(lid,did){
        $.post("content/setdevicelabtest.jsp", { lid: lid, did: did }, function(data){ 
            if(data.result == 0) {
                $("#controldialogerror").html(data.error);
                $("#controldialogerrorol").show();
            } else {
                $("#controldialogerrorol").hide();
               $("#documentlist").html(data.dlist);
            }
        },"json");
    }
    
    function setGroupLabtest(lid,gid){
        $.post("content/setgrouplabtest.jsp", { lid: lid, gid: gid }, function(data){ 
            if(data.result == 0) {
                $("#controldialogerror").html(data.error);
                $("#controldialogerrorol").show();
            } else {
                $("#controldialogerrorol").hide();
               $("#documentlist").html(data.dlist);
            }
        },"json");
    }
    
    function setLabtestInst(lid,iid){
        $.post("content/setinstlabtest.jsp", { lid: lid, iid: iid }, function(data){ 
            if(data.result == 0) {
                $("#controldialogerror").html(data.error);
                $("#controldialogerrorol").show();
            } else {
                $("#controldialogerrorol").hide();
               $("#documentlist").html(data.dlist);
            }
        },"json");
    }
    
</script>
<div class="smart-form">
<ul class="nav nav-tabs bordered" id="ptabs">
    <li class="active">
        <a data-toggle="tab" href="#s1"><%=trs.t("ჯგუფები")%></a>
    </li>
    <li>
        <a data-toggle="tab" href="#s2"><%=trs.t("აპარატურა")%></a>
    </li>
    <li>
        <a data-toggle="tab" href="#s3"><%=trs.t("ლაბორატორიები")%></a>
    </li>
</ul>

<div class="col col-md-12">
        <ol style="float: right; margin-right: 5px; display: none;" id='controldialogerrorol'>
            <div class="alert alert-danger fade in">
                <button class="close" data-dismiss="alert">
                    ×
                </button>
                <i class="fa-fw fa fa-times"></i>
                <strong><%=trs.t("Error!")%></strong> <span id='controldialogerror'></span>
            </div>
        </ol>
    </div>
    
<div class="tab-content padding-10"  id="pTabContent" style='height: calc(100vh - 400px); overflow-y: scroll; overflow-x: hidden;'>
    <div class="tab-pane fade in active" id="s1" style="padding-left: 20px;">
        <%
        for(int i=0;i<groups.length;i++){
            String sel = "";
            if(TestgroupManager.getInstance().countWhere("where labtestid = "+labtest.getLabtestid()+" and testgroupid = "+groups[i].getLabtestid()) > 0)
                sel = "checked";
        %>
        <div class="row">
            <div class="col col-12">
                <label class="checkbox" style="cursor: pointer;"><input name="groupid" value="<%=groups[i].getLabtestid()%>" type="checkbox" <%=sel%> onclick="setGroupLabtest(<%=labtest.getLabtestid()%>,<%=groups[i].getLabtestid()%>)"> <i></i><%=trs.t(groups[i].getName())%></label>
            </div>
        </div>
        <%
        }
        %>
    </div>

    <div class="tab-pane fade" id="s2" style="padding-left: 20px;">
        <%
        for(int i=0;i<devs.length;i++){
            String sel = "";
            if(DevicelabtestManager.getInstance().countWhere("where labtestid = "+labtest.getLabtestid()+" and deviceid = "+devs[i].getDeviceid()) > 0)
                sel = "checked";
        %>
        <div class="row">
            <div class="col col-12">
                <label class="checkbox" style="cursor: pointer;"><input name="deviceid" value="<%=devs[i].getDeviceid()%>" type="checkbox" <%=sel%> onclick="setDeviceLabtest(<%=labtest.getLabtestid()%>,<%=devs[i].getDeviceid()%>)"> <i></i><%=trs.t(devs[i].getName())%></label>
            </div>
        </div>
        <%
        }
        %>
    </div>

    <div class="tab-pane fade" id="s3" style="padding-left: 20px;">
        <%
        for(int i=0;i<menu.length;i++){
            String sel = "";
            if(LabtestinstitutionManager.getInstance().countWhere("where labtestid = "+labtest.getLabtestid()+" and institutionid = "+menu[i].getInstitutionid()) > 0)
                sel = "checked";
        %>
        <div class="row">
            <div class="col col-12">
                <label class="checkbox" style="cursor: pointer;"><input name="institutionid" value="<%=menu[i].getInstitutionid()%>" type="checkbox" <%=sel%> onclick="setLabtestInst(<%=labtest.getLabtestid()%>,<%=menu[i].getInstitutionid()%>)"> <i></i><%=trs.t(getFullLabName(menu[i],"=>"))%></label>
            </div>
        </div>
        <%
        }
        %>
    </div>
</div>
</div>