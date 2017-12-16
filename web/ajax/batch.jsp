<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<script>
    pageSetUp();

    function showmsg(text) {
        $("#msgModal").modal("show");
        $("#message").html(text);
    }
    
    function printBarcodeCmsg(id,num){
        
    }


    checkStatus = function (response, postdata) {
        var retval = true;
        var msg = "";
        var id = 0;
        var json = eval('(' + response.responseText + ')');
        if (json.result == 0)
        {
            msg = json.error;
            retval = false;
        } else
            id = json.id;
        return [retval, msg, id];
    }

    var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);

        function run_jqgrid_function() {
            jQuery("#numeration").jqGrid({
                url: 'content/getcontractsampleitem.jsp?disclaim=0&boxid='+$("#blocknum").val(),
                datatype: "json",
                colNames: ['N', '<%=trs.t("საველე N")%>', '<%=trs.t("ცხოველის N")%>', '<%=trs.t("ბარკოდი")%>', '<%=trs.t("მოქმედება")%>'],
                colModel: [
                    {name: 'n', index: 'n', editable: true, align: "right", width: 50, edittype: "text", editoptions: {size: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'num', index: 'num', editable: true, align: "center", width: 180, edittype: "text", editoptions: {size: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'animal', index: 'animal', editable: true, align: "center", width: 180, edittype: "text", editoptions: {size: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'code', index: 'code', editable: true, align: "center", width: 180, edittype: "textarea", editoptions: {rows: "3", cols: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'print', index: 'print', editable: true, align: "center", width: 200, edittype: "text", editoptions: {size: "8"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}}
                ],
                rowNum: 20,
                height: 300,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagernumeration'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updpersonelltype.jsp",
                caption: '',
                gridComplete: function () {
                    $("button").tooltip({
                        container: 'body'
                    });
                }
            })
            .navGrid('#pagernumeration', {edit: false, add: false, del: false, view: false, search: false});

            jQuery("#numeration1").jqGrid({
                url: 'content/getcontractsampleitem.jsp?disclaim=1&boxid='+$("#blocknum").val(),
                datatype: "json",
                colNames: ['N', '<%=trs.t("საველე N")%>', '<%=trs.t("ცხოველის N")%>', '<%=trs.t("ბარკოდი")%>', '<%=trs.t("დაწუნების მიზეზი")%>', '<%=trs.t("მოქმედება")%>'],
                colModel: [
                    {name: 'n', index: 'n', editable: true, align: "right", width: 50, edittype: "text", editoptions: {size: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'num', index: 'num', editable: true, align: "center", width: 200, edittype: "text", editoptions: {size: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'animal', index: 'animal', editable: true, align: "center", width: 200, edittype: "text", editoptions: {size: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'code', index: 'code', editable: true, align: "center", width: 200},
                    {name: 'disclaim', index: 'disclaim', editable: true, align: "center", width: 200, edittype: "textarea", editoptions: {rows: "3", cols: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'print', index: 'print', editable: true, align: "center", width: 150, edittype: "text", editoptions: {size: "8"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}}
                ],
                rowNum: 20,
                height: 300,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagernumeration1'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updpersonelltype.jsp",
                caption: '',
                gridComplete: function () {
                    $("button").tooltip({
                        container: 'body'
                    });
                }
            })
            .navGrid('#pagernumeration1', {edit: false, add: false, del: false, view: false, search: false})
            ;

            /* Add tooltips */
            $('.navtable .ui-pg-button').tooltip({
                container: 'body'
            });

            // remove classes
            $(".ui-jqgrid").removeClass("ui-widget ui-widget-content");
            $(".ui-jqgrid-view").children().removeClass("ui-widget-header ui-state-default");
            $(".ui-jqgrid-labels, .ui-search-toolbar").children().removeClass("ui-state-default ui-th-column ui-th-ltr");
            $(".ui-jqgrid-pager").removeClass("ui-state-default");
            $(".ui-jqgrid").removeClass("ui-widget-content");

            // add classes
            $(".ui-jqgrid-htable").addClass("table table-bordered table-hover");
            $(".ui-jqgrid-btable").addClass("table table-bordered table-striped");


            $(".ui-pg-div").removeClass().addClass("btn btn-sm btn-primary");
            $(".ui-icon.ui-icon-plus").removeClass().addClass("fa fa-plus").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");
            ;
            $(".ui-icon.ui-icon-pencil").removeClass().addClass("fa fa-pencil").parent(".btn-primary").removeClass("btn-primary").addClass("btn-warning");
            ;
            $(".ui-icon.ui-icon-trash").removeClass().addClass("fa fa-trash-o").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");
            ;
            $(".ui-icon.ui-icon-search").removeClass().addClass("fa fa-search");
            $(".ui-icon.ui-icon-refresh").removeClass().addClass("fa fa-refresh");
            $(".ui-icon.ui-icon-disk").removeClass().addClass("fa fa-save").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");
            $(".ui-icon.ui-icon-cancel").removeClass().addClass("fa fa-times").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");

            $(".ui-icon.ui-icon-seek-prev").wrap("<div class='btn btn-sm btn-default'></div>");
            $(".ui-icon.ui-icon-seek-prev").removeClass().addClass("fa fa-backward");

            $(".ui-icon.ui-icon-seek-first").wrap("<div class='btn btn-sm btn-default'></div>");
            $(".ui-icon.ui-icon-seek-first").removeClass().addClass("fa fa-fast-backward");

            $(".ui-icon.ui-icon-seek-next").wrap("<div class='btn btn-sm btn-default'></div>");
            $(".ui-icon.ui-icon-seek-next").removeClass().addClass("fa fa-forward");

            $(".ui-icon.ui-icon-seek-end").wrap("<div class='btn btn-sm btn-default'></div>");
            $(".ui-icon.ui-icon-seek-end").removeClass().addClass("fa fa-fast-forward");




            // update buttons

            $(window).on('resize.jqGrid', function () {
                jQuery("#numeration").jqGrid('setGridWidth', $(".gridsize").width() - 50);
                jQuery("#numeration1").jqGrid('setGridWidth', $(".gridsize").width() - 100);
            });


        }


    };
    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);

    $("button").tooltip({
        container: 'body'
    });
</script>
<div class="jarviswidget jarviswidget-sortable" id="wid-id-3" data-widget-editbutton="false" data-widget-custombutton="false" role="widget" style="position: relative; opacity: 1; left: 0px; top: 0px;">
    <header role="heading">
        <span class="widget-icon"> <i class="fa fa-edit"></i> </span>
        <h2><%=trs.t("ხელშეკრულება")%> <span id="contractnum"> <b></b></span></h2>				
        <span class="jarviswidget-loader"><i class="fa fa-refresh fa-spin"></i></span>
    </header>
    <div role="content">
        <div class="jarviswidget-editbox"></div>
        <div class="widget-body no-padding">
            <div id="order-form" class="smart-form" novalidate="novalidate">
                <fieldset>
                    <div class="row">
                        <div class="col col-4">
                            <section class="col col-md-12">
                                <div class="input-group">
<label class="select">
    <input type="hidden" id="blocknum" style="width:100%" />
</label>
                                    <div class="input-group-btn">
                                        <button class="btn btn-danger clearbtn"  data-original-title="<%=trs.t("გასუთავება")%>" type="button" onclick="clearBlocknum()">
                                            <i class="fa fa-times"></i>
                                        </button>
                                    </div>
                                </div>
                            </section>
                            <section class="col col-md-12" id="sampletype" style="display: none;">
<label class="select">
    <select id="sample" style="width:100%"></select>
</label>
                            </section>
                            <section class="col col-md-12" id="research" style="display: none;">
<label class="select">
    <select id="labtest" style="width:100%"></select>
</label>
                            </section>
                            <section class="col col-md-12" id="numsample" style="display: none;">
                                <div class="input-group">
<label class="input"> 
    <input id='samplenum' type="text" value="" placeholder="<%=trs.t("ნიმუშის ნომერი")%>">
</label>
                                    <div class="input-group-btn">
                                        <button data-original-title="<%=trs.t("შენახვა")%>" class="btn btn-success" type="button" onclick="submitSamplenum()" style="height: 34px !important;">
                                            <i class="fa fa-lg fa-check"></i> 
                                        </button>
                                    </div>
                                </div>
                            </section>
                            <section class="col col-md-12" id="report" style="display: none;">
                                <ol class="dd-list">
                                    <li class="dd-item">
                                        <div class="dd-handle" style="border: none !important; background: none !important;">
                                            <div class="row">
                                                <div class="col-xs-8"><%=trs.t("ნიმუშების რაოდენობა")%>:</div>
                                                <div class="col-xs-4">

<div class="input-group">
    <label class="input"> 
    <input type="text" value="" id="totalsample">
    </label>
    <div class="input-group-btn">
        <button class="btn btn-xs btn-success" type="button" data-original-title="<%=trs.t("შენახვა")%>" onclick="submitSampleQuantity(); return false;"><i class="fa fa-check"></i></button>
    </div>
</div>


                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="dd-item"><div class="dd-handle" style="border: none !important; background: none !important;"><div class="row"><div class="col-xs-8"><%=trs.t("გატარებულია")%>:</div><div class="col-xs-4"><span class=" text-align-right text-primary" id="submitsample"></span></div></div></div></li>
                                    <li class="dd-item"><div class="dd-handle" style="border: none !important; background: none !important;"><div class="row"><div class="col-xs-8"><%=trs.t("მიღებულია")%>:</div><div class="col-xs-4"><span class=" text-align-right text-success" id="approvedsample"></span></div></div></div></li>
                                    <li class="dd-item"><div class="dd-handle" style="border: none !important; background: none !important;"><div class="row"><div class="col-xs-8"><%=trs.t("დაწუნებულია")%>:</div><div class="col-xs-4"><span class=" text-align-right text-danger" id="disclaimsample"></span></div></div></div></li>
                                    <li class="dd-item"><div class="dd-handle" style="border: none !important; background: none !important;"><div class="row"><div class="col-xs-8"><%=trs.t("დარჩენილია")%>:</div><div class="col-xs-4"><span class=" text-align-right text-primary" id="leftsample"></span></div></div></div></li>
                                    <li class="dd-item">
                                        <div class="dd-handle" style="border: none !important; background: none !important;">
                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <div class="progress progress-striped active no-margin" id="progresspercent">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </ol>
                            </section>
                                    
                                    
                                    
                                    
                                    
                        </div>
                        <div class="col col-8 gridsize" id="details" style="display: none;">
                            <div class="btn-box">
                                <button class="btn btn-danger pull-right" onclick="ConfirmMessage('<%=trs.t("ყურადღება")%>','დარწმუნებული ხართ, რომ გნებავთ მთლიანი ცხრილის გასუფთავება?',['<%=trs.t("არა")%>','<%=trs.t("დიახ")%>'],clearSample)"><i class="fa fa-trash"></i> <%=trs.t("ყველას წაშლა")%></button>
                                <button class="btn btn-primary pull-right" onclick="printAll()"><i class="fa fa-print"></i> <%=trs.t("ყველას ბეჭდვა")%></button>
                            </div>
                            <ul id="stockmovementmain" class="nav nav-tabs bordered half">
                                <li class="active">
                                    <a href="#i1" data-toggle="tab"> <%=trs.t("მიღებული")%></a>
                                </li>
                                <li>
                                    <a href="#i2" data-toggle="tab"> <%=trs.t("დაწუნებული")%></a>
                                </li>
                            </ul>
                            <div id="stockmovementmaincontent" class="tab-content padding-10">
                                <div class="tab-pane fade in active" id="i1" style="height: calc(100vh - 345px) !important;">
                                    <section class="col col-md-12">
                                        <div class="table-size3">
                                            <table id="numeration" width='100%'></table>
                                            <div id="pagernumeration"></div>
                                        </div>
                                    </section>
                                </div>
                                <div class="tab-pane fade" id="i2" style="height: calc(100vh - 345px) !important;">
                                    <section class="col col-md-12">
                                        <div class="table-size3">
                                            <table id="numeration1" width='100%'></table>
                                            <div id="pagernumeration1"></div>
                                        </div>
                                    </section>
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="msgModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ყურადღება")%></h4>
            </div>
            <div class="modal-body">
                <h2 id="message"><%=trs.t("დარწმუნებული ხართ, რომ გნებავთ ამ მოქმედების შესრულება?")%></h2>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("არა")%>
                </button>
                <button type="button" class="btn btn-success" data-dismiss="modal">
                    <%=trs.t("დიახ")%>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="banModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("დაწუნება")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
<form id="frmbanitem" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden" value="banitem">
<input name="id" type="hidden">
                    <section class="col col-sm-12">
                        <label class="label"><%=trs.t("დაწუნების მიზეზი")%></label>
                        <label class="textarea"> <i class="icon-append fa fa-info"></i>
                            <textarea  name="reason"></textarea>
                        </label>
                    </section>
</form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("არა")%></button>
                <button type="button" class="btn btn-warning" onclick="submitBanitem();"><%=trs.t("დაწუნება")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="cancelbanModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ყურადღება")%></h4>
            </div>
            <div class="modal-body">
                <h2 id="message"><%=trs.t("დარწმუნებული ხართ, რომ გნებავთ დაწუნებულის უკან დაბრუნება?")%></h2>
                <div class="smart-form">
<form id="frmcancelban" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden" value="cancelbanitem">
<input name="id" type="hidden">
</form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("არა")%></button>
                <button type="button" class="btn btn-warning" onclick="cancelBanitem();"><%=trs.t("დიახ")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ყურადღება")%></h4>
            </div>
            <div class="modal-body">
                <h2 id="message"><%=trs.t("დარწმუნებული ხართ, რომ გნებავთ ჩანაწერის წაშლა?")%></h2>
                <div class="smart-form">
<form id="frmdeleteban" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden" value="deletebanitem">
<input name="id" type="hidden">
</form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("არა")%></button>
                <button type="button" class="btn btn-warning" onclick="deleteBanitem();"><%=trs.t("დიახ")%></button>
            </footer>
        </div>
    </div>
</div>

            
            
            
            
            
                                    
<script>
$('#blocknum').select2({
        minimumInputLength: 1,
        allowClear: true,
        placeholder: "<%=trs.t("ყუთის ნომერი")%>",
        cache: true,
        ajax: {
            url: "api/getobject.jsp?obj=blocknumlist",
            dataType: 'json',
            data: function (term, page) {
                return {
                    q: term
                  };
            },
            results: function (data, page) {
                return {
                    results: data
                };
            }
        },
    formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
    formatInputTooShort: function () {return "<%=trs.t("შეიტანეთ ყუთის შტრიხკოდის ნომერი")%>";},
    formatNoMatches: function () {return "<%=trs.t("შტრიხკოდი არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
});

$("#samplenum").keypress(function(e) { 
    if(e.keyCode == 13) {
        submitSamplenum();
    }
});

function printAll(){
    $("#printModal").modal();
    $("#frmprintmodal").load("elements/getbarcode.jsp?all=1");
}

function printBcodeNum(id,num){
    $("#printModal").modal();
    $("#frmprintmodal").load("api/getbarcode.jsp?id="+id+"&num="+num);
}

function clearBlocknum() {
    $('#blocknum').select2("val","");
    $("#sampletype").hide();
    $("#research").hide();
    $("#numsample").hide();
    $("#report").hide();
    $("#details").hide();
    }

$(document).on("change", '#blocknum', function (e) {
    $("#sampletype").show();
    $("#research").hide();
    $("#numsample").hide();
    $("#report").hide();
    $("#details").hide();
    loadBoxsamples();
});

$(document).on("change", '#sample', function (e) {
    $("#sampletype").show();
    $("#research").show();
    $("#numsample").show();
    $("#report").show();
    $("#details").show();
    loadSampleDetails();
});

$(document).on("click", ".banitem", function () {
    $("#frmbanitem input[name=id]").val($(this).attr("data-itemid"));
    $("#frmbanitem textarea[name=reason]").val("");
    $("#banModal").modal("show");
});
$(document).on("click", ".cancelban", function () {
    $("#frmcancelban input[name=id]").val($(this).attr("data-itemid"));
    $("#cancelbanModal").modal("show");
});
$(document).on("click", ".deleteban", function () {
    $("#frmdeleteban input[name=id]").val($(this).attr("data-itemid"));
    $("#deleteModal").modal("show");
});
$(document).on("click", ".savenums", function () {
    var id =$(this).attr("data-itemid");
    sendRequest("api/setsampletype.jsp",{oper:"updSampleNums",id:id,num1:$("#num1_"+id).val(),num2:$("#num2_"+id).val()},cbUpdSampleNums);
});


var boxinfo;
function loadBoxsamples() {
    value = $("#blocknum").val();
    if (value == "") 
    {
        clearBlocknum();
        return;
    }
    res = getObject({"boxsample": value, "obj":"boxsamples"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',"სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას",'<%=trs.t("დახურვა")%>');
        $('#appeal').html("");
    }
    else 
    {
        boxinfo=[];
        select2sample(res.data.sampletypes);
        $("#contractnum").html("#"+res.data.contract);
    }
}
function loadSampleDetails() {
    value = $("#sample").val();
    if (value == "") 
    {
        clearBlocknum();
        return;
    }
    res = getObject({"sampleid": value, "obj":"boxsampledetails"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',"სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას",'<%=trs.t("დახურვა")%>');
        $('#appeal').html("");
    }
    else 
    {
        
        boxinfo=res.data;
        select2labtest(res.data.labtests);
        $("#numeration").jqGrid('setGridParam',{url:'content/getcontractsampleitem.jsp?disclaim=0&sampleid='+$("#sample").val()}).trigger("reloadGrid"); 
        $("#numeration1").jqGrid('setGridParam',{url:'content/getcontractsampleitem.jsp?disclaim=1&sampleid='+$("#sample").val()}).trigger("reloadGrid"); 
        Report();
    }
}
function loadBox() {
    value = $("#blocknum").val();
    if (value == "") 
    {
        clearBlocknum();
        return;
    }
    res = getObject({"boxsample": value, "obj":"boxdetails"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',"სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას",'<%=trs.t("დახურვა")%>');
        $('#appeal').html("");
    }
    else 
    {
        boxinfo=res.data;
        select2sample(res.data.sampletypes);
        $("#contractnum").html("#"+res.data.contract);
        $("#numeration").jqGrid('setGridParam',{url:'content/getcontractsampleitem.jsp?disclaim=0&sampleid='+$("#sample").val()}).trigger("reloadGrid"); 
        $("#numeration1").jqGrid('setGridParam',{url:'content/getcontractsampleitem.jsp?disclaim=1&sampleid='+$("#sample").val()}).trigger("reloadGrid"); 
        Report();
    }
}
function Report() {
    $("#totalsample").val(boxinfo.total);
    $("#submitsample").html(boxinfo.submited);
    $("#approvedsample").html(boxinfo.approved);
    $("#disclaimsample").html(boxinfo.disclaim);
    $("#leftsample").html(boxinfo.leftnum);
    var p = boxinfo.total==0 ? 0 : parseInt(100-100*boxinfo.leftnum/boxinfo.total);
    $("#progresspercent").html("<div class=\"progress-bar progress-bar-primary\" role=\"progressbar\" style=\"width: "+p+"%;\">"+p+"%</div>");
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

function select2labtest(opt)
{
  opt = (typeof opt !== 'undefined') ? opt :[];
  var output = [];
  output.push('<option value=""><%=trs.t("კვლევა")%></option>');
  $.each(opt, function(i,v) {output.push('<option value="'+ v.id +'">'+ v.name +'</option>');});
  $('#labtest').html(output.join(''));
  $("#labtest").select2({allowClear: true,placeholder: "<%=trs.t("კვლევა")%>",
    formatNoMatches: function () {return "<%=trs.t("კვლევა არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
   }); 
}


function submitBanitem() {sendForm("frmbanitem",cbSubmitBanitem);}
function cancelBanitem() {sendForm("frmcancelban",cbCancelBanitem);}
function deleteBanitem() {sendForm("frmdeleteban",cbdeleteBanitem);}
function submitSamplenum() {sendRequest("api/setsampletype.jsp",{oper:"addsampleboxitem",boxid:$("#blocknum").val(),sampleid:$("#sample").val(),samplenum:$("#samplenum").val(),labtestid:$("#labtest").val()},cbSampleBoxitem);}
function submitSampleQuantity() {sendRequest("api/setsampletype.jsp",{oper:"updSampleQuantity",id:$("#sample").val(),quantity:$("#totalsample").val()},cbSampleQuantity);}

function cbSampleQuantity(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
        $("#totalsample").val(boxinfo.total);
    }
    else
    {
        $("#numeration").jqGrid('setGridParam',{url:'content/getcontractsampleitem.jsp?disclaim=0&sampleid='+$("#sample").val()}).trigger("reloadGrid"); 
        boxinfo.total=$("#totalsample").val();
        boxinfo.leftnum = boxinfo.total-boxinfo.submited;
        Report();
    }
}
function cbSampleBoxitem(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $("#numeration").jqGrid('setGridParam',{url:'content/getcontractsampleitem.jsp?disclaim=0&sampleid='+$("#sample").val()}).trigger("reloadGrid"); 
        boxinfo.submited++;
        boxinfo.leftnum--;
        Report();
        var samplenum = $("#samplenum").val();
        var len = samplenum.length;
        samplenum = samplenum.replace(/(\d+)$/, function (match, n) {
            return ++n; // parse to int and increment number
        });
        len -= samplenum.length;
        for(var i=0;i<len;i++){
            samplenum = "0"+samplenum;
        }
        $("#samplenum").val(samplenum);
    }
}
function cbSubmitBanitem(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $("#numeration").jqGrid('setGridParam',{url:'content/getcontractsampleitem.jsp?disclaim=0&sampleid='+$("#sample").val()}).trigger("reloadGrid"); 
        $("#numeration1").jqGrid('setGridParam',{url:'content/getcontractsampleitem.jsp?disclaim=1&sampleid='+$("#sample").val()}).trigger("reloadGrid"); 
        $("#banModal").modal("hide");
        boxinfo.approved--;
        boxinfo.disclaim++;
        Report();
    }
}
function cbCancelBanitem(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $("#numeration").jqGrid('setGridParam',{url:'content/getcontractsampleitem.jsp?disclaim=0&sampleid='+$("#sample").val()}).trigger("reloadGrid"); 
        $("#numeration1").jqGrid('setGridParam',{url:'content/getcontractsampleitem.jsp?disclaim=1&sampleid='+$("#sample").val()}).trigger("reloadGrid"); 
        $("#cancelbanModal").modal("hide");
        boxinfo.approved++;
        boxinfo.disclaim--;
        Report();
    }
}
function cbdeleteBanitem(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $("#numeration").jqGrid('setGridParam',{url:'content/getcontractsampleitem.jsp?disclaim=0&sampleid='+$("#sample").val()}).trigger("reloadGrid"); 
        $("#numeration1").jqGrid('setGridParam',{url:'content/getcontractsampleitem.jsp?disclaim=1&sampleid='+$("#sample").val()}).trigger("reloadGrid"); 
        $("#deleteModal").modal("hide");
        boxinfo.submited--;
        boxinfo.leftnum++;
        Report();
    }
}
function clearSample(rs) {
    if (rs)
    {
        sendRequest("api/setsampletype.jsp",{oper:"deletesubmittedsample",boxid:$("#blocknum").val(),sampleid:$("#sample").val()},cbClearSample);
    }
}
function cbClearSample(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $("#numeration").jqGrid('setGridParam',{url:'content/getcontractsampleitem.jsp?disclaim=0&sampleid='+$("#sample").val()}).trigger("reloadGrid"); 
        $("#numeration1").jqGrid('setGridParam',{url:'content/getcontractsampleitem.jsp?disclaim=1&sampleid='+$("#sample").val()}).trigger("reloadGrid"); 
        $("#deleteModal").modal("hide");
        boxinfo.submited=0;
        boxinfo.approved=0;
        boxinfo.disclaim=0;
        boxinfo.leftnum=boxinfo.total;
        Report();
    }
}


function cbUpdSampleNums(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
    }
}
</script>
