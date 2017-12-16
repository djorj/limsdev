<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../includes/init.jsp" %>
<script>
    //Add/Edit....
    function addContragent() {
        clearContragent();
        $(".rightside").hide();
        $("#frmcontragent input[name='oper']").val("add");
        $("#frmcontragent input[name='contragentid']").val("");
        $("#contragent-box").show();
    }
    
    function editContragent() {
        loadContragent();
        $(".rightside").hide();
        //$("#frmcontragent input[name='oper']").val("edit");
        //$("#frmcontragent input[name='contragentid']").val("");
        $("#contragent-box").show();
        activecontent = "contragent-box";
    }
    
    // Resetting...
    function clearContragent() {
        $('#contragent').select2("val","");
        $(".editform").hide();
        $("#contract-field").hide();
        $("#editcontragentbtn").hide();
        clearContragentForm();
        clearContract();
    }
    function clearContragentForm() {
        $('#frmcontragent').find("input[type=text], textarea").val("");
        $('#frmcontragent select[name=region]').select2("val","").change();
    }
    function clearContract() {
        $('#contract').select2("val",'');
        $("#sample-field").hide();
        $("#appeal-field").hide();
        $("#act-field").hide();
        $("#analysis-field").hide();
        $("#report-field").hide();
        $("#end-field").hide();
        $("#submit-field").hide();
        $(".editform").hide();
        $(".rightside").hide();
    }
    
    function addContract() {
    resetContactForm();
    clearContract();
    $("#contract-box").show();
}

function delConctract(){
    var cid = $("#contract").val();
    if (cid=="0" || cid==null || cid=="")
    {
        alertError('<%=trs.t("ხელშეკრულება არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        return;
    } else {
        if(confirm('<%=trs.t("დარწმუნებული ხართ რომ გინდათ ხელშეკრულების წაშლა?")%>')){
            $.post("api/delcontract.jsp",{ oper: "contract", cid: cid },function(data){
                if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                else {
                    resetContactForm();
                    clearContract();
                    loadContract();
                    $("#contract-box").hide();
                }
            },"json");
        }
    }
}

function delAppeal(){
    var aid = $("#appeal").val();
    if (aid=="0" || aid==null || aid=="")
    {
        alertError('<%=trs.t("მიმართვა არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        return;
    } else {
        if(confirm('<%=trs.t("დარწმუნებული ხართ რომ გინდათ მიმართვის წაშლა?")%>')){
            $.post("api/delcontract.jsp",{ oper: "appeal", aid: aid },function(data){
                if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                else {
                    $("#appeal-box").hide();
                    loadAppeal();
                }
            },"json");
        }
    }
}

function delAct(){
    var aid = $("#act").val();
    if (aid=="0" || aid==null || aid=="")
    {
        alertError('<%=trs.t("აქტი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        return;
    } else {
        if(confirm('<%=trs.t("დარწმუნებული ხართ რომ გინდათ აქტის წაშლა?")%>')){
            $.post("api/delcontract.jsp",{ oper: "act", aid: aid },function(data){
                if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                else {
                    $("#act-box").hide();
                    loadAct();
                }
            },"json");
        }
    }
}

function printContract() {
    var cid = $("#contract").val();
    if (cid=="0" || cid==null || cid=="")
    {
        alertError('<%=trs.t("ხელშეკრულება არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        return;
    }
    printReport('contract',cid);
    //    $(".rightside").hide();
    //    $("#print-box1").hide();
}


function editContract() {
    var cid = $("#contract").val();
    if (cid=="0" || cid==null || cid=="")
    {
        alertError('<%=trs.t("ხელშეკრულება არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        return;
    }
    res = getObject({"contract": cid, "obj":"objcontract"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',res.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        resetContactForm();
        $(".rightside").hide();
        $("#contract-type").val(res.data.contracttype).change();
        $("#frmcontract input[name='contactid']").val(cid);
        $.each(res.data, function(n,v) {
            if(n == "bills"){
                $.each(v,function(nm,vl){
                    var billnum = vl.num;
                    var tm = vl.id;
                    var s = "<li class='list-group-item justify-content-between' id='bill"+tm+"' style='padding: 10px 15px !important; margin-top: 5px !important;'><a href='";
                    s += vl.path;
                    s += "' target='_blank'>"+billnum+"</a><span class='pull-right' style='cursor: pointer;'><a class='btn btn-danger btn-xs' onclick='$(\"#bill"+tm+"\").remove();' style='padding: 1px 7px !important;'><i class='fa fa-times'></i> </a></span>";
                    s += "<input type='hidden' name='bill' value='"+billnum+"'/><input type='hidden' name='bill_"+billnum+"' value='ID_"+tm+"_"+vl.path+"'/></li>";
                    $("#billlist").append(s);
                });
            } else if(n == "docs"){
                $.each(v,function(nm,vl){
                    var tm = vl.id;
                    var s = "<li class='list-group-item justify-content-between' id='docs"+tm+"' style='padding: 10px 15px !important; margin-top: 5px !important;'><a href='";
                    s += vl.path;
                    s += "' target='_blank'>"+vl.doctype+"</a><span class='pull-right' style='cursor: pointer;'><a class='btn btn-danger btn-xs' onclick='$(\"#docs"+tm+"\").remove();' style='padding: 1px 7px !important;'><i class='fa fa-times'></i> </a></span>";
                    s += "<input type='hidden' name='docs_"+vl.doctypeid+"' value='ID_"+tm+"_"+vl.path+"'/></li>";
                    $("#docslist").append(s);
                });
            } else $("#frmcontract input[name='"+n+"']").val(v);
        });
        if  (res.data.contracttype==2){
            $.each(res.data.labtest, function(i,t) {insLabtest(t.id, t.sampleid,t.labtestid,t.maxprice,t.maxnum,t.minday,t.maxday,t.comment);});
        } else {
            $("#frmcontract input[name=transfer]").prop("checked",res.data.hasOwnProperty("transfer")&&res.data.transfer);
            if (res.data.hasOwnProperty("owner")) {
                $("#frmcontract input[name=owner]").prop("checked",true).change();
                $.each(res.data.owner, function(n,v) {$("#frmcontract textarea,input[name='"+n+"']").val(v);});
            }
        }
        $("#frmcontract input[name=contracttype]").change();
        $("#contract-box").show();
        $("#frmcontracttitle").html('<%=trs.t("ხელშეკრულების რედაქტირება")%> <a class="btn btn-danger pull-right" onclick="delConctract()"><i class="fa fa-trash"></i> <%=trs.t("ხელშეკრულების წაშლა")%></a>');
    }
}

function editAppeal() {

    value = $("#appeal").val();
    if (value=="0" || value==null || value=="")
    {
        alertError('<%=trs.t("მიმართვა არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        return;
    }
    res = getObject({"appealid": value, "obj":"objappeal"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',"სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას",'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $.each(res.data, function(n,v) {$("#frmappeal input[name='"+n+"']").val(v);});
        $("#region").val(res.data.region);
        $('#region').select2().trigger('change');
        $(".rightside").hide();
        $("#appeal-box").show();
        $("#frmappealtitle").html('<%=trs.t("მიმართვის რედაქტირება")%> <a class="btn btn-danger pull-right" onclick="delAppeal()"><i class="fa fa-trash"></i> <%=trs.t("მიმართვის წაშლა")%></a>');
    }
}
function addAppeal() {
    clearAppealForm();
    $("#frmappealtitle").html('<%=trs.t("ახალი მიმართვის დამატება")%>');
    $(".rightside").hide();
    $("#appeal-box").show();
    $("#frmappeal input[name='oper']").val("add");
}

function clearAppealForm() {
    $('#frmappeal').find("input[type=text], textarea, input[type=number]").val("");
    $('#upload-appeal').val("").change();
    $('#frmappeal select[name=region]').select2("val","").change();
}

function printAppeal() {
    value = $("#appeal").val();
    if (value=="0" || value==null || value=="")
    {
        alertError('<%=trs.t("მიმართვა არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        return;
    }
    printReport('appeal',value);
}

function printAct() {
    value = $("#act").val();
    if (value=="0" || value==null || value=="")
    {
        alertError('<%=trs.t("აქტი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        return;
    }
    printReport('act',value);
}

function editAct() {

    value = $("#act").val();
    if (value=="0" || value==null || value=="")
    {
        alertError('<%=trs.t("აქტი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        return;
    }
    
    res = getObject({"actid": value, "obj":"objact"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',"სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას",'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $.each(res.data, function(n,v) {$("#frmact input[name='"+n+"']").val(v);});
        $(".rightside").hide();
        $("#act-box").show();
        $("#frmacttitle").html('<%=trs.t("აქტის რედაქტირება")%> <a class="btn btn-danger pull-right" onclick="delAct()"><i class="fa fa-trash"></i> <%=trs.t("აქტის წაშლა")%></a>');
        $("#frmact input[name='oper']").val("edit");
    }
}
function addAct() {
    clearActForm();
    $("#frmacttitle").html('<%=trs.t("ახალი აქტის დამატება")%>');
    $(".rightside").hide();
    $("#act-box").show();
    $("#frmact input[name='oper']").val("add");
}
function clearActForm() {
    $('#frmact').find("input[type=text], input[type=number]").val("");
    $('#frmact textarea').val("<%=actcontent%>");
    $('#frmact select[name=region]').select2("val","").change();
}

function addSample() {
   sendForm("frmsampletype",cbAddSample);
}
function editSample() {
    $(".editform").hide();
    $("#grid-box").hide();
    $("#sample-box").show();
    jQuery("#sampletable").jqGrid('setGridWidth', $("#sample-box").width() - 30);
    $("#sampletable").jqGrid('setGridParam',{
        url:"content/getcontractsamplelist.jsp?contractid="+$("#contract").val()+"&appealid="+$("#appeal").val()+"&actid="+$("#act").val()
    }).trigger("reloadGrid"); 
}
function cbAddSample(res)
{
    $("#sample").select2("val","");
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',res.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $("#sampleModal").modal("hide");
        $("#grid-box").hide();
        $("#sample-box").show();
        resetAnalysis();
        $("#sampletable").jqGrid('setGridParam',{url:"content/getcontractsamplelist.jsp?contractid="+$("#contract").val()+"&appealid="+$("#appeal").val()+"&actid="+$("#act").val()}).trigger("reloadGrid"); 
    }
}

function editAnalysis() {
    $(".editform").hide();
    $("#sample-box").hide();
    $("#grid-box").show();
    loadScript("js/plugin/jqgrid/grid.locale-en.min.js", pagefunction);
    $('#'+$("ul#analyses-tab li.active a").attr("data-table")).trigger('reloadGrid');
    resetReport();
    showEnd();
}

function resetAnalysis()
{
// $.getJSON("api/getobject.jsp?obj=contractlabtest&contractid="+$("#contract").val(), function (json) {

 $.getJSON("api/getobject.jsp?obj=contractreport&contractid="+$("#contract").val()+"&appealid="+$("#appeal").val()+"&actid="+$("#act").val(), function (json) {
    $("#analysis").select2('destroy').empty();
    $('#analysis').append($('<option>').text("<%=trs.t("ანალიზები")%>").attr('value', ""));
    $.each(json.data.testlist, function(i, v) {$('#analysis').append($('<option>').text(v.text).attr('value', v.id));});
    select2analysis();
    showReport(json.data.contractsample,json.data.contractanalysis, json.data.leftamount);
 });
}
function resetReport()
{
 $.getJSON("api/getobject.jsp?obj=contractreport&contractid="+$("#contract").val(), function (json) {
    showReport(json.data.contractsample,json.data.contractanalysis, json.data.leftamount);
 });
}

function select2contract()
{
 $("#contract").select2({allowClear: true,placeholder: "<%=trs.t("ხელშეკრულების N")%>",
    formatNoMatches: function () {return "<%=trs.t("ხელშეკრულება არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
   }); 
}

function select2appeal(opt)
{
  opt = (typeof opt !== 'undefined') ? opt :[];
  var output = [];
  output.push('<option value=""><%=trs.t("მიმართვა")%></option>');
  $.each(opt, function(i,v) {output.push('<option value="'+ v.id +'">'+ v.num +'</option>');});
  $('#appeal').html(output.join(''));
  $("#appeal").select2({allowClear: true,placeholder: "<%=trs.t("მიმართვა")%>",
    formatNoMatches: function () {return "<%=trs.t("მიმართვა არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
   }); 
}
function select2act(opt)
{
  opt = (typeof opt !== 'undefined') ? opt :[];
  var output = [];
  output.push('<option value=""><%=trs.t("აქტის N")%></option>');
  $.each(opt, function(i,v) {output.push('<option value="'+ v.id +'">'+ v.num +'</option>');});
  $('#act').html(output.join(''));
  $("#act").select2({allowClear: true,placeholder: "<%=trs.t("აქტის N")%>",
    formatNoMatches: function () {return "<%=trs.t("აქტის N არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
   }); 
}
function select2sample(opt)
{
  opt = (typeof opt !== 'undefined') ? opt :[];
  var output = [];
  output.push('<option value=""><%=trs.t("ნიმუში")%></option>');
  $.each(opt, function(i,v) {output.push('<option value="'+ v.id +'">'+ v.name +'</option>');});
  $('#sample').html(output.join(''));
  $("#sample").select2({allowClear: true,placeholder: "<%=trs.t("ნიმუში")%>",
    formatNoMatches: function () {return "<%=trs.t("ნიმუში არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
   }); 
}
function select2analysis()
{
 $("#analysis").select2({allowClear: true,placeholder: "<%=trs.t("ანალიზები")%>",
    formatNoMatches: function () {return "<%=trs.t("ანალიზი არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
   }); 
}
function select2institution()
{
 $("#institution").select2({allowClear: true,placeholder: "<%=trs.t("ლაბორატორია")%>",
    formatNoMatches: function () {return "<%=trs.t("ლაბორატორია არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
   }); 
}

function loadRegion()
{
 $.getJSON("api/getobject.jsp?obj=region", function (json) {
    $o = $("#frmcontragent select[name='region']");
    $o.select2('destroy').empty();
    $o.append($('<option>').text("").attr('value', ""));
    $.each(json.data, function(i, v) {$o.append($('<option>').text(v.text).attr('value', v.id));});
    $o.select2({allowClear: true,placeholder: "<%=trs.t("რეგიონი")%>"});
 });
}
    
function loadRaion(punitid)
{
 $.getJSON("api/getobject.jsp?obj=region&punitid="+punitid, function (json) {
    $o = $("#frmcontragent select[name='raion']");
    $o.select2('destroy').empty();
    $o.append($('<option>').text("").attr('value', ""));
    $.each(json.data, function(i, v) {$o.append($('<option>').text(v.text).attr('value', v.id));});
    $o.select2({allowClear: true,placeholder: "<%=trs.t("რაიონი/ქალაქი")%>"});
    $("#contragentraion").show();
 });
}
    
function loadCity(punitid)
{
 $.getJSON("api/getobject.jsp?obj=region&punitid="+punitid, function (json) {
    $o = $("#frmcontragent select[name='city']");
    $o.select2('destroy').empty();
    $o.append($('<option>').text("").attr('value', ""));
    $.each(json.data, function(i, v) {$o.append($('<option>').text(v.text).attr('value', v.id));});
    $o.select2({allowClear: true,placeholder: "<%=trs.t("სოფელი")%>"});
    if (json.data.length>0)
        $("#contragentcity").show();
    else
    {
        $("#contragentcity").hide();
        $("#contragentaddress").show();
    }
 });
}
    
function resetContactForm()
{
    $("#frmcontracttitle").html('<%=trs.t("ახალი ხელშეკრულების დამატება")%>');
    $("#frmcontract input[name='contractid']").val("");
    $("#frmcontract input[name='startdate']").val("");
    $("#frmcontract input[name='enddate']").val("");
    $("#frmcontract input[name='num']").val("");
    $("#frmcontract input[name='contractprice']").val("");
    $("#frmcontract textarea[name='info']").val("");
    $("#frmcontract input[name='fname']").val("");
    $("#frmcontract input[name='lname']").val("");
    $("#frmcontract input[name='idn']").val("");
    $("#frmcontract textarea[name='address']").val("");
    $("#frmcontract input[name='owner']").prop('checked', false).change();
    $("#billlist").html("");
    $("#docslist").html("");
    $("#contract-type").val("0").change();
    $(".contr1").hide();
    $(".contr2").hide();

    $(".limits").find('.limit-item').html("");
    $(".limits").find('.limit-edit').html("");
    addLabtest("","","","","","");
    calcTotalPrice();
}

var  optLabtest ='<option value=""><%=trs.t("კვლევა")%></option><%=ObjOptions.Labtest().replace("'","\\'").replace("\n","")%>';
var  optSample  ='<option value=""><%=trs.t("ნიმუში")%></option><%=sampletypes.replace("'","\\'").replace("\n","")%>';
function addLabtest(sampletype, labtest,maxprice,maxnum,minday,maxday)
{
   
    var $fg = $(".limits").find('.limit-item').length;
    $clone = $('<div class="limit-item">\n\
<section class="col col-md-12"><div class="col-xs-12"><hr></div></section>\n\
<section class="col col-md-6"><label class="select"><select class="contractsample" name="sampletype'+$fg+'" id="sampletype'+$fg+'" style="width:100%" >'+optSample+'</select></label></section>\n\
<section class="col col-md-6"><label class="select"><select class="contracttest" name="labtest'+$fg+'" id="labtest'+$fg+'" style="width:100%" >'+optLabtest+'</select></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-money"></i><input value="'+maxprice+'" name="maxprice'+$fg+'" id="maxprice'+$fg+'" class="testprice" placeholder="<%=trs.t("მაქს. ფასი")%>" type="number" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-money txt-color-teal\"></i> <%=trs.t("მაქსიმალური ფასი")%></b></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-list-ol"></i><input value="'+maxnum+'" name="maxnum'+$fg+'" id="maxnum'+$fg+'" placeholder="<%=trs.t("მაქს. რაოდენობა")%>" type="number" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-list-ol txt-color-teal\"></i> <%=trs.t("მაქსიმალური რაოდენობა")%></b></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-list-ol"></i><input value="'+minday+'" name="minday'+$fg+'" id="minday'+$fg+'" placeholder="<%=trs.t("მინ.ვადა")%>" type="number" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-list-ol txt-color-teal\"></i> <%=trs.t("მინიმალური ვადა")%></b></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-list-ol"></i><input value="'+maxday+'" name="maxday'+$fg+'" id="maxday'+$fg+'" placeholder="<%=trs.t("მაქს.ვადა")%>" type="number" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-list-ol txt-color-teal\"></i> <%=trs.t("მაქსიმალური ვადა")%></b></label></section>\n\
<section class="col col-md-11"><label class="textarea"> <i class="icon-append fa fa-id-card"></i><textarea name="comment'+$fg+'" placeholder="<%=trs.t("კომენტარი")%>"></textarea></label></section>\n\
<section class="col col-md-1"><button class="btn btn-success addnew"><i class="fa fa-plus"></i></button></section></div>');
  $(".limits").append($clone);
  $("#labtest"+$fg).val(labtest);
  $("#sampletype"+$fg).val(sampletype);
  $("#labtest"+$fg).select2({allowClear: true,placeholder: "<%=trs.t("კვლევა")%>",formatNoMatches: function () {return "<%=trs.t("კვლევა არ მოიძებნა")%>";},escapeMarkup: function (markup) {return markup;}});
  $("#sampletype"+$fg).select2({allowClear: true,placeholder: "<%=trs.t("ნიმუში")%>",formatNoMatches: function () {return "<%=trs.t("ნიმუში არ მოიძებნა")%>";},escapeMarkup: function (markup) {return markup;}});
}
function insLabtest(id,sampletype, labtest,maxprice,maxnum,minday,maxday,comment)
{
    var $fg = id;
    $clone = $('<div class="limit-edit">\n\
<section class="col col-md-12"><div class="col-xs-12"><hr></div></section>\n\
<section class="col col-md-6"><label class="select"><select name="edsample'+$fg+'" id="edsample'+$fg+'" style="width:100%" >'+optSample+'</select></label></section>\n\
<section class="col col-md-6"><label class="select"><select name="edlab'+$fg+'" id="edlab'+$fg+'" style="width:100%" >'+optLabtest+'</select></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-money"></i><input value="'+maxprice+'" class="testprice" name="edmaxpri'+$fg+'" placeholder="<%=trs.t("მაქს. ფასი")%>" type="number" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-money txt-color-teal\"></i> <%=trs.t("მაქსიმალური ფასი")%></b></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-list-ol"></i><input value="'+maxnum+'" name="edmaxnum'+$fg+'" placeholder="<%=trs.t("მაქს. რაოდენობა")%>" type="number" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-list-ol txt-color-teal\"></i> <%=trs.t("მაქსიმალური რაოდენობა")%></b></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-list-ol"></i><input value="'+minday+'" name="edminday'+$fg+'" placeholder="<%=trs.t("მინ.ვადა")%>" type="number" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-list-ol txt-color-teal\"></i> <%=trs.t("მინიმალური ვადა")%></b></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-list-ol"></i><input value="'+maxday+'" name="edmaxday'+$fg+'" placeholder="<%=trs.t("მაქს.ვადა")%>" type="number" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-list-ol txt-color-teal\"></i> <%=trs.t("მაქსიმალური ვადა")%></b></label></section>\n\
<section class="col col-md-11"><label class="textarea"> <i class="icon-append fa fa-id-card"></i><textarea name="edcomment'+$fg+'" placeholder="<%=trs.t("კომენტარი")%>">'+comment+'</textarea></label></section>\n\
<section class="col col-md-1"><button class="btn btn-danger removeold"><i class="fa fa-times"></i></button></section></div>');
  $(".limits").prepend($clone);
  $("#edlab"+$fg).val(labtest);
  $("#edsample"+$fg).val(sampletype);
  $("#edlab"+$fg).select2({allowClear: true,placeholder: "<%=trs.t("კვლევა")%>",formatNoMatches: function () {return "<%=trs.t("კვლევა არ მოიძებნა")%>";},escapeMarkup: function (markup) {return markup;}});
  $("#edsample"+$fg).select2({allowClear: true,placeholder: "<%=trs.t("ნიმუში")%>",formatNoMatches: function () {return "<%=trs.t("ნიმუში არ მოიძებნა")%>";},escapeMarkup: function (markup) {return markup;}});
}



function cbUpdSample(res)
{
    $('.samplequantity').tooltip('destroy');
    $('.samplenums').tooltip('destroy');
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',"სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას",'<%=trs.t("დახურვა")%>');
    }
    else
    {

        $('#sampletable').trigger( 'reloadGrid' );
    }
}

function updSample(id) {
    sendRequest("api/setsampletype.jsp",{oper:"updSample",id:id,num1:$("#num1_"+id).val(),num2:$("#num2_"+id).val(),quantity:$("#quantity_"+id).val()},cbUpdSample);
}
function updSampleNums(id) {
    sendRequest("api/setsampletype.jsp",{oper:"updSampleNums",id:id,num1:$("#num1_"+id).val(),num2:$("#num2_"+id).val()},cbUpdSample);
}
function updSampleQuantity(id) {
    sendRequest("api/setsampletype.jsp",{oper:"updSampleQuantity",id:id,quantity:$("#quantity_"+id).val()},cbUpdSample);
}
function cbDeleteContractSample(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
//        alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
        $('#sampletable').trigger( 'reloadGrid' );
        resetAnalysis();
    }
}






function addAnalysis() {
    if ($("#analysis").val()!=="")
    {
        sendRequest("api/setanalysis.jsp",{oper:"add",contractid:$("#contract").val(),labtestid: $("#analysis").val()},cbAddAnalysis);
    }
}
    
function cbAddAnalysis(res)
{
    if (res.status=="ER")
    {
            alertError('<%=trs.t("შეცდომა")%>',"სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას",'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $("#analysis").val("");
    }
}

function submitInstitution() {
    sendForm("frminstitution",cbSubmitInstitution);
}
function cbSubmitInstitution(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $("#chlabModal").modal("hide");
        if ($("#sample-box").css('visibility') != 'hidden') {
            $("#sampletable").trigger("reloadGrid"); 
        }

        $('#'+$("ul#analyses-tab li.active a").attr("data-table")).trigger('reloadGrid');
        resetReport();
    }
}

function submitClosing() {
        sendForm("frmclose",cbSubmitClosing);
}

function cbSubmitClosing(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
        $("#msgModal").modal("hide");
    }
}

function sendContract2Lab() {
    $("#frmsendcontract2lab input[name='contractid']").val($('#contract').val().trim());
    $("#frmsendcontract2lab input[name='appealid']").val($('#appeal').val().trim());
    $("#frmsendcontract2lab input[name='actid']").val($('#act').val().trim());
    sendForm("frmsendcontract2lab",cbSendContract2Lab);
}
function cbSendContract2Lab(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
        $("#sendcontract2labModal").modal("hide");
    }
}

function submitBanitem() {
    sendForm("frmbanitem",cbSubmitBanitem);
}
function cbSubmitBanitem(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
        $("#banModal").modal("hide");
    }
}

function changeActContent(){
    $.post("content/getactcontent.jsp",{ contract: $("#contract").val() },function(data){
        $("#actcontent").val(data.content)
    },"json");
}

function cbDelAnalysis(rs)
{
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
    $('#'+$("ul#analyses-tab li.active a").attr("data-table")).trigger('reloadGrid');
    resetAnalysis();
    }
}
function cbStopAnalysis(rs)
{
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
    $('#'+$("ul#analyses-tab li.active a").attr("data-table")).trigger('reloadGrid');
    }
}

function printForm(){

        var RowId = $.map($(".sampleitemreseach:checkbox:checked"), function(n, i){return n.value;});
        if (RowId.length == 0)
            alertError('<%=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        else
        {
            printReport("F-138-2016-G", RowId[0])
        }
    }
    
function showcontract2lab() {
    $("#sendcontractModal").modal("show");
    //activecontent = "sendcontractModal";
    }

function showmsg() {
    $("#msgModal").modal("show");
    $("#frmclosingbody").load("api/load_closing_form.jsp?contractid="+$("#contract").val()+"&actid="+$("#actid").val()+"&appealid="+$("#appealid").val(), function (json) {
        var cd = new Date();
        $("#frmclose .select2").select2();
        $("#frmclose .dtpicker").datepicker({
        format: 'dd/mm/yyyy', 
        startDate: getFmtDate(new Date()),
        autoclose: true, 
        language: 'ka', 
        todayHighlight: true, 
	prevText : '<i class="fa fa-chevron-left"></i>',
	nextText : '<i class="fa fa-chevron-right"></i>'
	});
        $("#frmclose .clockpicker").clockpicker({
            donetext: 'Done',
            twelvehour: false,
            autoclose: true
            }); 
        });
    }
    
function printSample() {
    $(".contr3").show();
}

function cbSubmitContragent(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
        $("#contragent-box").hide();
        $("#contract-field").show();
        var cname = $("#org-code").val() + " " + $("#org-name").val();
        if ($("#contragenttypeid").val()==1)
            cname += " "+ $("#frmcontragent input[name=lname]").val();
        $("#contragent").select2('data', {id: rs.data, text: cname, selected: true});
        loadContract("");
    }
}
function submitContragent() {
    sendForm("frmcontragent",cbSubmitContragent);
}
function closeContract() 
{
    $("#frmcontract").find("input[type=text], select, textarea").val("");
    $("#contract-box").hide();
}
function submitContract() {
    var $fg = $(".limits").find('.limit-item').length-1;
    var sampletype = $("#sampletype"+$fg).val().length;
    var labtest = $("#labtest"+$fg).val().length;
    var maxprice = $("#maxprice"+$fg).val().length;
    var maxnum = $("#maxnum"+$fg).val().length;
    if(sampletype > 0 && maxnum === 0)
        alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ რაოდენობა!")%>','<%=trs.t("დახურვა")%>');
    else if(labtest > 0 && maxnum === 0 && maxprice === 0)
        alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ მაქსიმალური ფასი ან რაოდენობა!")%>','<%=trs.t("დახურვა")%>');
    else {
        if(sampletype === 0 && labtest === 0 && maxprice === 0){
            $("#maxnum"+$fg).val("");
            $("#minday"+$fg).val("");
            $("#maxday"+$fg).val("");
        }
        $("#frmcontract input[name='contragentid']").val($('#contragent').val());
        if ($("#contract-type").val() == "1") {
            sendMPForm("frmcontract",cbSubmitContract);
        } else if ($("#contract-type").val() == "2") {
            sendMPForm("frmcontract",cbSubmitContract);
        } else {
            alertError('<%=trs.t("აირჩიეთ ხელშეკრულების ტიპი")%>','','<%=trs.t("დახურვა")%>');
        }
    }
}
function cbSubmitContract(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
        //$("#contact").append($('<option>', {value: rs.data.id, text: rs.data.num, selected: true})).trigger("change");
        loadContract(rs.data.id);
        //loadContractDetails();
    }
}
function submitAppeal() {
    $("#frmappeal input[name='contractid']").val($('#contract').val().trim());
    sendMPForm("frmappeal",cbSubmitAppeal);
}
function cbSubmitAppeal(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
        $('#appeal option:first').after($('<option />', { "value": rs.data.id, text: rs.data.num, selected: true }));
        $('#appeal').val(rs.data.id);
        $('#appeal').select2().trigger("change");
        $("#analysis-field").show2();
        $(".rightside").hide();
        $("#appeal-box").hide();
    }
}
function submitAct() {
    $("#frmact input[name='contractid']").val($('#contract').val().trim());
    sendMPForm("frmact",cbSubmitAct);
}
function cbSubmitAct(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
        $("#analysis-field").show2();
//            $("#act").select2('data', {id: rs.data, text: rs.data.num, selected: true});
        $('#act option:first').after($('<option />', { "value": rs.data.id, text: rs.data.num }));
        $("#act").select2("val",rs.data.id).change();
        $("#act-box").hide();
    }
}
function showEnd() {
    $("#end-field").show();
    $("#submit-field").show();
}

function cbSetResearch(rs){
    if (rs.status=='ER')
    {
        if (rs.message=='multiplelab')
        {
            var v = $("#analysis").val().trim();
            if (v=="")
                return;
            var boxids = $.map($(".contactsampleboxitem:checkbox:checked"), function(n, i){return n.value;}).join(',');
            var itmids = $.map($(".contactsampleitem:checkbox:checked"), function(n, i){return n.value;}).join(',');
            $("#chlabModal").modal('show');
            $("#frmchlab").load("api/load_institution_test.jsp?samplelist="+itmids+"&samplebox="+boxids+"&analysis="+v+"&contractid="+$("#contract").val(), function (json) {
                select2institution();
            });
        }
        else
            alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else 
    {
        if ($("#sample-box").css('visibility') != 'hidden') {
            $("#sampletable").trigger("reloadGrid"); 
        }
        if ($("#grid-box").css('visibility') != 'hidden') {
            var tb = $("#analyses-tab .active > a").attr("data-table");
            //var tb = $("#analyses-tab .active").attr("data-table");
            $('#'+tb).trigger('reloadGrid');
            //$("#"+tb).jqGrid('setGridWidth', $("#grid-box").width() - 30);
        }
        resetReport();
        alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
    }
    $("#analysis").select2("val", "");
}

function LoadOptionList(response) {
    if (request.status === 200) {
      var jsonOptions = JSON.parse(request.responseText);
      jsonOptions.forEach(function(item) {
        var option = document.createElement('option');
        option.value = item;
        dataList.appendChild(option);
      });
      
      // Update the placeholder text.
      input.placeholder = "e.g. datalist";
    } else {
      // An error occured :(
      input.placeholder = "Couldn't load datalist options :(";
    }
};


function loadContragent() {
    var obj = getObject({"contragentid": $('#contragent').val(), "obj":"exactcontragent"});
    $("#contragenttypeid").select2("val",obj.contragenttypeid).change();
    $("#org-code").val(obj.idn);
    if(obj.vat)
        $("#vat").prop("checked",true);
    else
        $("#vat").prop("checked",false);
    if(obj.contragenttypeid == 1)
        $("#org-name").val(obj.fname);
    else
        $("#org-name").val(obj.name);
    $("#lname").val(obj.lname);
    
    $("#regionid").select2("val",obj.regionid).change();
    setTimeout(function(){
        $("#raionid").select2("val",obj.raionid).change();
        setTimeout(function(){
            $("#cityid").select2("val",obj.villageid).change();
        },500);
    },500);
    
    $("#address").val(obj.address);
    $("#phone").val(obj.phone);
    $("#email").val(obj.email);
    $("#url").val(obj.url);
    $("#contact").val(obj.contact);
    $("#bankdata").val(obj.bankdata);
    $("#note").val(obj.note);
    $("#appealstamp").val(obj.stamp);
    $("#frmcontragent input[name='oper']").val("edit");
    $("#frmcontragent input[name='contragentid']").val(obj.contragentid);
    return obj;
}

function setContragentOptions(opts) {
    var datalist = document.getElementById('contragent');
    datalist.textContent = '';
    for (var i = 0; i < opts.length; i++) {
        var option = document.createElement('option');
        option.value = opts[i];
        datalist.appendChild(option);
    }
}

function loadContract(cid) {
  value = $('#contragent').val().trim();
  if (value.length > 0) {
    $.getJSON("api/getobject.jsp?obj=contractlist&contragentid="+value, function (json) {
        $("#contract").select2('destroy').empty();
        $('#contract').append($('<option>').text("").attr('value', ""));
        $.each(json.data, function(i, v) {
            $('#contract').append($('<option>').text(v.num).attr('value', v.id));
            });
    if (cid!=undefined &&cid!=null)
        $('#contract').val(cid);
    select2contract();
    if (cid!=undefined &&cid!=null){
        loadContractDetails();
        }
    });
  }
}

function loadContractDetails() {

    value = $("#contract").val();
    if (value == "" || value == "0" || value == null) 
        return;
   
    res = getObject({"contractid": value, "obj":"contractdetails"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',"სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას",'<%=trs.t("დახურვა")%>');
        $('#appeal').html("");
    }
    else if (res.data.type==1)
    {
        select2appeal();
        select2act(res.data.acts);
        select2sample(res.data.sampletypes);
        resetAnalysis();
        
        $(".editform").hide();
        $("#appeal-field").hide();
        $("#act-field").hide();
        $("#sample-field").show();
        $("#analysis-field").show();
        $("#report-field").show();
        $(".isleft").show();
    }
    else if (res.data.type==2)
    {
        select2appeal(res.data.appeals);
        select2act(res.data.acts);
        select2sample(res.data.sampletypes);
        resetAnalysis();
        
        $(".editform").hide();
        
        $("#act-field").show();
        $("#appeal-field").show();
        $("#sample-field").show();
        $("#analysis-field").show();
        $("#report-field").show();
        $(".isleft").show();
    }
    
    showReport(res.data.contractsample,res.data.contractanalysis,res.data.leftamount);
    showEnd();
}

function showReport(contractsample,contractanalysis,leftamount) {
    var $rp2 = $("#report-analysis");
    $rp2.html("");
    $.each(contractanalysis, function(i,v) {$rp2.append(v.name+'<br>');});
    var $rp2 = $("#report-sample");
    $rp2.html("");
    $.each(contractsample, function(i,v) {$rp2.append(v.name+'<br>');});
    $("#leftamount").html(leftamount);
}

function loadAppeal() {

    value = $("#contract").val();
    res = getObject({"contract": value, "obj":"appeal"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',"სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას",'<%=trs.t("დახურვა")%>');
        $('#appeal').html("");
    }
    else
    {
        var output = [];
        output.push('<option value="0"><%=trs.t("მიმართვა")%></option>');
        $.each(res.data, function(i,v) {output.push('<option value="'+ v.id +'">'+ v.num +'</option>');});
        $('#appeal').html(output.join(''));
    }
}
function loadAct() {

    value = $("#contract").val();
    res = getObject({"contract": value, "obj":"act"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',"სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას",'<%=trs.t("დახურვა")%>');
        $('#act').html("");
    }
    else
    {
        var output = [];
        output.push('<option value="0"><%=trs.t("აქტის N")%></option>');
        $.each(res.data, function(i,v) {output.push('<option value="'+ v.id +'">'+ v.num +'</option>');});
        $('#act').html(output.join(''));
        $("#appeal-field").show();
        $("#sample-field").show();
        $("#act-field").show();
        $(".isleft").show();
    }
}

function getFmtDate(date) {
  var year = date.getFullYear();
  var month = (1 + date.getMonth()).toString();
  month = month.length > 1 ? month : '0' + month;
  var day = date.getDate().toString();
  day = day.length > 1 ? day : '0' + day;
  return  day + '/' + month + '/' + year;
}

function calcTotalPrice(){
    var s=0.0;
    $(".testprice").each(function(){ 
        var x = $(this).val();
        if(x > 0)
            s+= parseInt(x);
    });
    $("#frmcontract input[name='contractprice']").val(s);
}

function selall(){
//    $('#sampletable .contactsampleitem').each(function () { this.checked = $("#selall").is(":checked"); });
//    $('#sampletable .contactsampleboxitem').each(function () { this.checked = $("#selall").is(":checked"); });
  $('#sampletable td input:checkbox').each(function () { this.checked = $("#selall").is(":checked"); });
}

</script>