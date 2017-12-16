<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
    int w = 12;
    int h = 8;
    String sql = "where labtestid in (select l.labtestid from devicelabtest l, device d where l.deviceid = d.deviceid and d.hasplate = true)";
    if(user.getPersonelltypeid().intValue() != 1)
        sql += " and labtestid in (select labtestid from labtrestinstitution where institutionid = "+user.getInstitutionid()+")";
    LabtestBean[] labtests = LabtestManager.getInstance().loadByWhere(sql);
%>
<style>
    .ui-autocomplete { z-index:2147483647; }
</style>
<script>
    function getBoardMap(){
        var w = $("#horiz").val();
        var h = $("#vert").val();
        if(w == '') {
            alert("აირჩიეთ ჰორიზონტალური რაოდენობა");
            return;
        }
        if(h == '') {
            alert("აირჩიეთ ვერტიკალური რაოდენობა");
            return;
        }
        var platetemplateid = $("#platetemplateid").val();
        var nm = "";
        if(platetemplateid == 0)
            nm = prompt("შეიყვანეთ დასახელება","");
        $.post("content/boardmap.jsp",{ 
            labtestid: $("#labtestid").val(), 
            plateid: $("#plateid").val(),
            platetemplateid: platetemplateid,
            zdefault: $("#zdefault").is(':checked'),
            platename: $("#platename").val(),
            nm: nm,
            w: w,
            h: h
        },function(data){
            $("#boardmap").html(data);
            $("#boardmap").show();
            //gettemplates();
        },"html");
    }
    
    function gettemplates(){
        $.post("content/platetemplate.jsp",{ labtestid: $("#labtestid").val(), plateid: $("#plateid").val(), platename: $("#platename").val() },function(data){
            $("#template").html(data);
            $("#template").show();
        },"html");
    }
    
    function seltemplate(){
        $.post("content/getplatetemplate.jsp",{ platetemplateid: $("#platetemplateid").val() },function(data){
            if(data.result == 1){
                $("#vert").val(data.w);
                $("#horiz").val(data.h);
                $("#zdefault").prop('checked', data.z);
                setTimeout(function(){getBoardMap();},500);
            }
        },"json");
    }
    
    $("#platenumber").hide();
    $("#template").hide();
    $("#boarmap").hide();
    
    $("#platename").autocomplete({
        autoFocus: true,
        minLength: 1,
        my: "right top",
        at: "right bottom",
        source: "content/searchplate.jsp",
        //appendTo: ".smart-form",
        select: function (event, ui) {
            $("#platename").val(ui.item.label);
            $("#plateid").val(ui.item.value);
            $("#platename").trigger('change');
            $("#plateid").trigger('change');
            
            return false;
        }
    });
    $(".paletnumberpicker").autocomplete( "option", "appendTo", "#platenumber" );
    
    function seltest(){
        var labtestid = $("#labtestid").val();
        if(labtestid > 0)   $("#platenumber").show();
        else                $("#platenumber").hide();
    }
</script>
<div class="smart-form">
    <section class="col col-sm-6">
        <label class="select"> 
            <select id="labtestid" class="select2" onchange="seltest()">
                <option value="0">- <%=trs.t("აირჩიეთ ტესტი")%> -</option>
                <%for(int i=0;i<labtests.length;i++){%>
                <option value="<%=labtests[i].getLabtestid()%>"><%=labtests[i].getName()%></option>
                <%}%>
            </select><i></i>
        </label>
    </section>
    <section class="col col-sm-6" id="platenumber">
        <div class="input-group">
            <label class="input ui-widget">
                <input id='platename' class="paletnumberpicker" placeholder="<%=trs.t("დაფის ნომერი")%>" type="text" value="">
                <input id='plateid' type="hidden" value="0">
            </label>
            <div class="input-group-btn">
                <button type="button" class="btn btn-success" onclick="gettemplates()">
                    <i class="fa fa-check"></i>
                </button>
            </div>
        </div>
    </section>
    <div id="template">
        
    </div>
    <div id="boardmap">
        
    </div>
</div>