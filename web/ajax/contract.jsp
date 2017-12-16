<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
    String gridname = "contract";
    String ses = "EXPORT_BAR_" + (new Date()).getTime();
    jqexport exp = new jqexport(ses, null, null, "EXPORT_STOP", "content/export_" + gridname + ".jsp", "");
    String sampletypes = ObjOptions.Sampletypes(user.getCompanyid());
%>
<link href="js/plugin/bootstrap-datepicker/css/datepicker3.css"  rel="stylesheet">
<script src="js/plugin/bootstrap-datepicker/bootstrap-datepicker.js"></script>
<script src="js/plugin/bootstrap-datepicker/locales/bootstrap-datepicker.ka.js"></script>
<style>
#export<%=gridname%> {
    line-height: 1.19 !important;
}
</style>
<%=exp.getExportAttr()%>
<script type="text/javascript">
pageSetUp();

var pagefunction = function () {
    loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);

function addContract() {
    resetContactForm();

    $('#frmcontract').attr('action', 'api/setcontract.jsp');
    $("#frmcontract input[name='oper']").val("add");
    $("#contractfield").show();
    $(".limits").hide();
    $("#formModal").modal('show');
}
function editContract() {
    var myGrid = $('#list<%=gridname%>');
    var RowId = myGrid.jqGrid('getGridParam', 'selrow');
    if (RowId==null)
    {
        alertError('<%=trs.t("შეცდომა")%>',"ჩანაწერი არჩეული არ არის",'<%=trs.t("დახურვა")%>');
        return;
    }
    
    value = myGrid.jqGrid ('getCell', RowId, 'id');
    res = getObject({"contract": value, "obj":"objcontract"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',res.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        resetContactForm();
        $('#frmcontract').attr('action', 'api/updcontractfields.jsp');
        $("#contract-type").val(res.data.contracttype).change();
        $("#frmcontract select[name=status]").val(res.data.status).change();
        $("#frmcontract input[name='contactid']").val(value);
        $("#frmcontract input[name='editmode']").val("1");
        $.each(res.data, function(n,v) {$("#frmcontract input[name='"+n+"']").val(v);});
        if  (res.data.contracttype==2){
            $.each(res.data.labtest, function(i,t) {insLabtest(t.id, t.sampleid,t.labtestid,t.maxprice,t.maxnum,t.minday,t.maxday,t.comment);});
        } else if (res.data.hasOwnProperty("owner")) {
            $("#frmcontract input[name=owner]").prop("checked",true).change();
            $.each(res.data.owner, function(n,v) {$("#frmcontract textarea,input[name='"+n+"']").val(v);});
        }
        $("#frmcontract input[name=contragentid]").select2('data', {id: res.data.contragentid,text:res.data.agentname, selected: true});
        $("#frmcontracttitle").html('<%=trs.t("ხელშეკრულების რედაქტირება")%>');
        $("#contractfield").show();
        $(".limits").hide();
        $("#formModal").modal('show');
    }
}
function editLimit() {
    var myGrid = $('#list<%=gridname%>');
    var RowId = myGrid.jqGrid('getGridParam', 'selrow');
    if (RowId==null)
    {
        alertError('<%=trs.t("შეცდომა")%>',"ჩანაწერი არჩეული არ არის",'<%=trs.t("დახურვა")%>');
        return;
    }
    
    value = myGrid.jqGrid ('getCell', RowId, 'id');
    res = getObject({"contract": value, "obj":"objcontract"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',res.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        resetContactForm();
        $('#frmcontract').attr('action', 'api/updcontractlimits.jsp');
        $("#contract-type").val(res.data.contracttype).change();
        $("#frmcontract input[name='contactid']").val(value);
        $("#frmcontract input[name='editmode']").val("1");
        
        $.each(res.data, function(n,v) {$("#frmcontract input[name='"+n+"']").val(v);});
        if  (res.data.contracttype==2){
            $.each(res.data.labtest, function(i,t) {insLabtest(t.id, t.sampleid,t.labtestid,t.maxprice,t.maxnum,t.minday,t.maxday,t.comment);});
        }
        $("#frmcontracttitle").html('<%=trs.t("ლიმიტების რედაქტირება")%>');
        $("#contractfield").hide();
        $(".limits").show();
        $("#formModal").modal('show');
    }
}

function checkpaid(id){
    $("#billModal").modal("show");
}

function delContract() {
    var myGrid = $('#list<%=gridname%>');
    var RowId = myGrid.jqGrid('getGridParam', 'selrow');
    if (RowId==null)
        alertError('<%=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
    else
        ConfirmMessage('<%=trs.t("ყურადღება")%>','დარწმუნებული ხართ, რომ გნებავთ ჩანაწერის წაშლა?',['<%=trs.t("არა")%>','<%=trs.t("დიახ")%>'],cdDelConfirm);
}
function cdDelConfirm(rs) {
  if (rs===true)
  {
    var myGrid = $('#list<%=gridname%>');
    var RowId = myGrid.jqGrid('getGridParam', 'selrow');
    value = myGrid.jqGrid ('getCell', RowId, 'id');
    sendRequest("api/delobject.jsp",{obj:"objcontract",id: value},cbDeleteContract);
  }
}

        function run_jqgrid_function() {
            jQuery("#list<%=gridname%>").jqGrid({
                url: 'content/get<%=gridname%>list.jsp',
                datatype: "json",
                colNames: ['id','<%=trs.t("ტიპი")%>', '<%=trs.t("დამკვეთი")%>', '<%=trs.t("ხელშეკრულების N")%>', '<%=trs.t("თარიღი")%>', '<%=trs.t("ფასი")%>', '<%=trs.t("დასრულების ვადა")%>', '<%=trs.t("სტატუსი")%>', '<%=trs.t("ხელშ-ბა")%>', '<%=trs.t("ქვითარი")%>', '<%=trs.t("დოკ-ები")%>', '<%=trs.t("გადახდილი")%>'],
                colModel: [
                    {name: 'id', index: 'id', editable: true, align: "left", width: 0, hidden:true}, //hidden: true},
                    {name: 'contacttype', index: 'contacttype', editable: true, align: "left", width: 100},
                    {name: 'contragentid', index: 'contragentid', editable: true, align: "left", width: 100},
                    {name: 'num', index: 'num', editable: true, align: "left", width: 100},
                    {name: 'startdate', index: 'startdate', editable: true, align: "center", width: 100},
                    {name: 'price', index: 'price', editable: true, align: "right", width: 100},
                    {name: 'enddate', index: 'enddate', editable: true, align: "center", width: 100},
                    {name: 'status', index: 'status', editable: true, align: "left", width: 50},
                    {name: 'contract', index: 'contract', editable: true, align: "center", width: 50},
                    {name: 'bill', index: 'bill', editable: true, align: "center", width: 50},
                    {name: 'docs', index: 'docs', editable: true, align: "center", width: 50},
                    {name: 'paid', index: 'paid', editable: true, align: "center", width: 50}
                ],
                rowNum: 20,
                height: 350,
                width: 900,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pager<%=gridname%>'),
                sortname: 'startdate',
                rownumbers:true,
                viewrecords: true,
                sortorder: "desc",
                gridComplete: function () {
                    $("button").tooltip({
                        container: 'body',
                        trigger : 'hover'
                    });
                }
            })
            .navGrid('#pager<%=gridname%>', {edit: false, add: false, del:false, view: false, search: false})
     <%--if (permissions[0]) {%>
            .navButtonAdd('#pager<%=gridname%>', {title:'<%=trs.t("ახალი ჩანაწერის დამატება")%>', id: 'add<%=gridname%>', caption: '<i class="fa fa-plus"></i>', buttonicon: 'none', onClickButton: addContract})
    <%}%>
    <%if (permissions[1]) {%>
            .navButtonAdd('#pager<%=gridname%>', {title:'<%=trs.t("აირჩეული ჩანაწერის ნახვა")%>', id: 'edit<%=gridname%>', caption: '<i class="fa fa-file-text-o"></i>', buttonicon: 'none', onClickButton: addContract})
            .navButtonAdd('#pager<%=gridname%>', {title:'<%=trs.t("აირჩეული ჩანაწერის რედაქტირება")%>', id: 'view<%=gridname%>', caption: '<i class="fa fa-pencil"></i>', buttonicon: 'none', onClickButton: editContract})
            .navButtonAdd('#pager<%=gridname%>', {caption: '',title:'<%=trs.t("ლიმიტების რედაქტირება")%>',buttonicon: "ui-icon-3",onClickButton: editLimit})
    <%}%>
    <%if (permissions[2]) {%>
            .navButtonAdd('#pager<%=gridname%>', {title:'<%=trs.t("არჩეული ჩანაწერის წაშლა")%>', id: 'del<%=gridname%>', caption: '<i class="fa fa-trash-o"></i>', buttonicon: 'none', onClickButton: delContract})
    <%}%>
    <%if (permissions[4]) {%>
            .navButtonAdd('#pager<%=gridname%>', {id: 'export<%=gridname%>', caption: '<i class="fa fa-file-excel-o"></i> <%=trs.t("ექსპორტი")%>', buttonicon: "none", onClickButton: function () {<%=exp.getClickCode()%>}, position: 'last'})
    <%}--%>
        ;

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
            $(".ui-icon.ui-icon-2").removeClass().addClass("fa fa-pencil").parent(".btn-primary").removeClass("btn-primary").addClass("btn-warning");
            $(".ui-icon.ui-icon-3").removeClass().addClass("fa fa-handshake-o").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");

            $(".ui-icon.ui-icon-plus").removeClass().addClass("fa fa-plus").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");
            ;
            $(".ui-icon.ui-icon-pencil").removeClass().addClass("fa fa-pencil").parent(".btn-primary").removeClass("btn-primary").addClass("btn-warning");
            ;
            $(".ui-icon.ui-icon-trash").removeClass().addClass("fa fa-trash-o").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");
            ;
            
            $("#add<%=gridname%>").find("div").removeClass().addClass("btn").addClass("btn-sm").addClass("btn-success");
            $("#edit<%=gridname%>").find("div").removeClass().addClass("btn").addClass("btn-sm").addClass("btn-warning");
            $("#del<%=gridname%>").find("div").removeClass().addClass("btn").addClass("btn-sm").addClass("btn-danger");
            
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
                jQuery("#list<%=gridname%>").jqGrid('setGridWidth', $("#content").width() - 10);
            })
        }
    }

    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);
    function hideModals() {
        $("#limitsModal").modal("hide");
        $("#reasonModal").modal("hide");
    }
    $('.daterangepicker').daterangepicker({
        autoUpdateInput: false,
        locale: {
            format: 'DD/MM/YYYY',
            cancelLabel: '<%=trs.t("გასუფთავება")%>'
        }
    });
    $('.daterangepicker').on('apply.daterangepicker', function (ev, picker) {
        $(this).val(picker.startDate.format('MM/DD/YYYY') + ' - ' + picker.endDate.format('MM/DD/YYYY'));
    });

    $('.daterangepicker').on('cancel.daterangepicker', function (ev, picker) {
        $(this).val('');
    });
    
    $(document).on("click", ".jarviswidget-toggle-btn", function () {
        $(".table-size3").toggleClass("active");
    });
</script>
<section id="widget-grid" class="" style="padding-right: 5px;">
    <div class="jarviswidget" data-widget-collapsed="true" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false">
        <header>
            <h2><%=trs.t("ფილტრი")%></h2>
        </header>
        <div>
            <div class="smart-form col-sm-12" style="padding: 0;">
    <form id="frmfilter" method="post" accept-charset="UTF-8">               
                <div class="row">    
                    <section class="col col-md-2">
                        <label class="input"> <%=trs.t("ხელშეკრულების N")%></label>
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input name="num" type="text">
                        </label>
                    </section>
                    <section class="col col-md-2">
                        <label class="input"> <%=trs.t("თარიღი")%></label>
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input name="daterange" class="daterangepicker" type="text">
                        </label>
                    </section>
                    <section class="col col-md-2">
                        <label class="input"> <%=trs.t("დასრულების ვადა")%></label>
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input name="enddate" class="daterangepicker"  type="text">
                        </label>
                    </section>
                    <section class="col col-md-3">
                        <label class="input"> <%=trs.t("დამკვეთი")%></label>
                        <label class="input"><i class="icon-append fa fa-money"></i>
                            <input name="contragentid" select2 type="hidden" style="width: 100%;">
                        </label>
                    </section>
                    <section class="col col-md-2">
                        <label class="input"> <%=trs.t("ქვითარი")%></label>
                        <label class="select">
                            <select name="status" class="select2" >
                                <option value=""></option>
                                <option value="1"><%=trs.t("აქვს")%></option>
                                <option value="2"><%=trs.t("არ აქვს")%></option>
                            </select>
                        </label>
                    </section>
                </div>    
                <div class="row">    
                    <section class="col col-md-2">
                        <label class="input"> <%=trs.t("მაქსიმალური ფასი")%></label>
                        <label class="input"> <i class="icon-append fa fa-money"></i>
                            <input name="maxprice" type="text">
                        </label>
                    </section>
                    <section class="col col-md-2">
                        <label class="input"> <%=trs.t("მაქსიმალური რაოდენობა")%></label>
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input name="maxnumber" type="text">
                        </label>
                    </section>
                    <section class="col col-md-2">
                        <label class="input"> <%=trs.t("სტატუსი")%></label>
                        <label class="select">
                            <select name="status" class="select2" >
                                <option value=""></option>
                                <option value="1"><%=trs.t("აქტიური")%></option>
                                <option value="2"><%=trs.t("არაქტიური")%></option>
                            </select>
                        </label>
                    </section>
                    <section class="col col-md-2">
                        <label class="input"> <%=trs.t("ტიპი")%></label>
                        <label class="select">
                            <select name="contracttype" class="select2">
                                <option value=""></option>
                                <option value="1"><%=trs.t("ერთჯერადი")%></option>
                                <option value="2"><%=trs.t("მრავალჯერადი")%></option>
                            </select>
                        </label>
                    </section>
                    <section class="col col-md-4">
                        <label class="input">&nbsp;</label>
                        <label>
                    <button class="btn btn-info pull-right" style="margin-right: 5px;" id="clearfilter"><i class="fa fa-times"></i> <%=trs.t("გასუფთავება")%></button>
                    <button class="btn btn-success pull-right" style="margin-right: 5px;" id="startfilter"><i class="fa fa-search"></i> <%=trs.t("ძებნა")%></button>
                        </label>
                    </section>
                </div>
    </form>
            </div>
        </div>
    </div>
</section>
<div class="table-size3 active">
    <table id="list<%=gridname%>"></table>
    <div id="pager<%=gridname%>"></div>
</div>
<div class="modal fade" id="billModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ქვითრები")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form" id="frmbill">
                                   
                    <input name="oper" value="edit" type="hidden">
                    <input name="contractid" type="hidden">
                    <input name="id" type="hidden">
                    <section class="col col-md-12">
                        <div class="row" id='errorbill' style="display: none;">
                            <div class="col col-md-12">
                                <div class="alert alert-danger fade in">
                                    <strong><%=trs.t("შეცდომა!")%></strong> <span id='errorbilltxt'></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col col-md-6">
                                <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                                    <div class="input-group">
                                    <span class="input-group-addon">ქვითრის N:</span>
                                    <input class="form-control" name="billnum" id="billnum" placeholder="<%=trs.t("ქვითრის ნომერი")%>" type="text" data-autoclose="true">
                                    </div>
                                </label>
                            </div>
                            <div class="col col-md-3">
                                <label class="btn btn-primary change-pic contract-file">
                                    <span id="filename-bill"><%=trs.t("ატვირთვა")%></span>
                                    <input name=docfile type="file" id="upload-bill"/>
                                </label>
                            </div>
                            <div class="col col-md-3">
                                <a class="btn btn-primary" onclick="scanToJpg();"><%=trs.t("სკანირება")%></a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col col-md-12">
                                <ul class="list-group" id='billlist'>
                                    
                                </ul>
                            </div>
                        </div>
                    </section>
                    
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("დახურვა")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="formModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="frmcontracttitle" ><%=trs.t("ხელშეკრულება")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
<form id="frmcontract" action="api/setcontract.jsp" enctype="multipart/form-data" accept-charset="UTF-8">
<input name="contractid" type="hidden">
<input name="editmode" type="hidden">
    <div id="contractfield">
    <section class="col col-md-6" >
    <label class="input"> <%=trs.t("დამკვეთი")%></label>
<label class="select">
    <input type="hidden" name="contragentid" style="width:100%" />
</label>
    </section>
                                <section class="col col-md-3">
                        <label class="input"> <%=trs.t("ხელშეკრულების ტიპი")%></label>
                                    <label class="select">
                                        <select class="req" id="contract-type" name="contracttype">
                                            <option value=""></option>
                                            <option value="1"><%=trs.t("ერთჯერადი")%></option>
                                            <option value="2"><%=trs.t("მრავალჯერადი")%></option>
                                        </select><i></i>
                                    </label>
                                </section>
                                <section class="col col-md-3" >
                        <label class="input"> <%=trs.t("ხელშეკრულების N")%></label>
                                    <label class="input"> <i class="icon-append fa fa-file-o"></i>
                                        <input class="req" name="num" type="text">
                                    </label>
                                </section>
                    <section class="col col-md-3">
                        <label class="input"> <%=trs.t("სტატუსი")%></label>
                        <label class="select">
                            <select name="status">
                                <option value=""></option>
                                <option value="1"><%=trs.t("აქტიური")%></option>
                                <option value="2"><%=trs.t("არაქტიური")%></option>
                            </select><i></i> 
                        </label>
                    </section>
                                <section class="col col-md-3">
                        <label class="input"> <%=trs.t("თარიღი")%></label>
                                    <label class="input"> 
    <div class="input-group">
    <input class="form-control hasDatepicker req" name="startdate" id="cotract_startdate" type="text" data-autoclose="true">
    <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
    </div>
                                    </label>
                                </section>
                                <section class="col col-md-3">
                        <label class="input"> <%=trs.t("დასრულების ვადა")%></label>
                                    <label class="input"> <i class="icon-append fa fa-clock-o"></i>
    <div class="input-group">
    <input class="form-control hasDatepicker req" name="enddate" id="cotract_enddate" type="text" data-autoclose="true">
    <span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
    </div>
                                    </label>
                                </section>
                                <section class="col col-md-3 contr2" style="display: none;">
                        <label class="input"> <%=trs.t("ფასი")%></label>
                                    <label class="input"> <i class="icon-append fa fa-money"></i>
                                        <input name="price" type="number" min="0">
                                    </label>
                                </section>
                                <section class="col col-md-4 contr2" style="display: none;">
                                    <label class="btn btn-primary change-pic contract-file">
                                        <span id="filename-contract"><%=trs.t("ხელშეკრულების ატვირთვა")%></span>
                                        <input name="docfile" type="file" id="upload-contract"/>
                                    </label>
                                </section>
                                <section class="col col-md-12 contr3" style="display: none;">
                                    <object data="img/imagetopdf.pdf" type="application/pdf" style="width: 200px; height: 200px;"><%=trs.t("თქვენ ბრაუზერს არ შეუძლია PDF-ის გახსნა")%></object>
                                </section>
                                <section class="col col-md-12 contr2" style="display: none;">
                                    <label class="textarea"> 
                                        <i class="icon-append fa fa-id-card"></i><textarea name="info" placeholder="<%=trs.t("კომენტარი")%>"></textarea>
                                    </label>
                                </section>
                                <div class="smart-form custcheck">
                                    <label class="checkbox contr1" style="display: none;">
                                        <input name="owner" class="checkshow" name="checkbox" type="checkbox">
                                        <i></i><%=trs.t("მფლობელი")%></label>
                                </div>
                                <section class="col col-md-4 contr1 contr4" style="display: none;">
                        <label class="input"> <%=trs.t("სახელი")%></label>
                                    <label class="input"> <i class="icon-append fa fa-user"></i>
                                        <input name="fname" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4 contr1 contr4" style="display: none;">
                        <label class="input"> <%=trs.t("გვარი")%></label>
                                    <label class="input"> <i class="icon-append fa fa-user"></i>
                                        <input name="lname" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4 contr1 contr4" style="display: none;">
                        <label class="input"> <%=trs.t("პირადი N")%></label>
                                    <label class="input"> <i class="icon-append fa fa-id-card"></i>
                                        <input name="idn" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-12 contr1 contr4" style="display: none;">
                                    <label class="textarea"> <i class="icon-append fa fa-id-card"></i>
                                        <textarea name="address" placeholder="<%=trs.t("მისამართი")%>"></textarea>
                                    </label>
                                </section>
                                </div>
                                <div class="limits contr2" style="display: none;">
                                    <div class="limit-item"></div>
                                </div>
                    
                                </form>
                </div>
            </div>
            <footer class="modal-footer">
                <button class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i> <%=trs.t("გაუქმება")%></button>
                <button type="button" class="btn btn-success" onclick="submitContract(); return false;"><i class="fa fa-plus"></i> <%=trs.t("შენახვა")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="reasonModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("მიზეზი")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
                    <section class="col col-sm-12">
                        <label class="label"><%=trs.t("რედაქტირების მიზეზი")%></label>
                        <label class="textarea"> <i class="icon-append fa fa-info"></i>
                            <textarea></textarea>
                        </label>
                    </section>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-danger" onclick="hideModals()"><%=trs.t("რედაქტირება")%></button>
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("გაუქმება")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="billModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ქვითრები")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form" id="frmbill">
                                   
<form id="frmbill" action="api/updcontractfield.jsp" enctype="multipart/form-data" accept-charset="UTF-8">
<input name="oper" value="editbill" type="hidden">
<input name="contractid" type="hidden">
                    <section class="col col-md-12">
                        <div class="row" id='errorbill' style="display: none;">
                            <div class="col col-md-12">
                                <div class="alert alert-danger fade in">
                                    <strong><%=trs.t("შეცდომა!")%></strong> <span id='errorbilltxt'></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col col-md-6">
                                <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                                    <div class="input-group">
                                    <span class="input-group-addon">ქვითრის N:</span>
                                    <input class="form-control" name="billnum" id="billnum" placeholder="<%=trs.t("ქვითრის ნომერი")%>" type="text" data-autoclose="true">
                                    </div>
                                </label>
                            </div>
                            <div class="col col-md-3">
                                <label class="btn btn-primary change-pic contract-file">
                                    <span id="filename-bill"><%=trs.t("ატვირთვა")%></span>
                                    <input name=docfile type="file" id="upload-bill"/>
                                </label>
                            </div>
                            <div class="col col-md-3">
                                <a class="btn btn-primary" onclick="scanToJpg();"><%=trs.t("სკანირება")%></a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col col-md-12">
                                <ul class="list-group" id='billlist'>
                                    
                                </ul>
                            </div>
                        </div>
                    </section>
</form>                    
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("დახურვა")%></button>
                <button type="button" class="btn btn-success" onclick="submitContractBill(); return false;"><i class="fa fa-plus"></i> <%=trs.t("შენახვა")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="docsModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("დოკუმენტები")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form" id="frmdocs">
<form id="frmdocs" action="api/updcontractfield.jsp" enctype="multipart/form-data" accept-charset="UTF-8">
<input name="oper" value="editdocs" type="hidden">
<input name="contractid" type="hidden">
                    <section class="col col-md-12">
                        <div class="row" id='errordocs' style="display: none;">
                            <div class="col col-md-12">
                                <div class="alert alert-danger fade in">
                                    <strong><%=trs.t("შეცდომა!")%></strong> <span id='errordocstxt'></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col col-md-6">
                                <label class="input"> 
                                    <div class="input-group">
                                    <span class="input-group-addon">ტიპი:</span>
                                    <select class="form-control select2" name="doctypeid" placeholder="<%=trs.t("დოკუმენტის ტიპი")%>">
        <option value=""></option> 
<%            
        DoctypeBean[]  dtb = DoctypeManager.getInstance().loadAll();
        for(int i=0; i<dtb.length;i++) 
            out.print("<option value="+dtb[i].getDoctypeid()+">"+dtb[i].getName()+"</option>");
%>
        </select>
                                    </div>
                                </label>
                            </div>
                            <div class="col col-md-3">
                                <label class="btn btn-primary change-pic contract-file">
                                    <span id="filename-docs"><%=trs.t("ატვირთვა")%></span>
                                    <input name=docfile type="file" id="upload-docs"/>
                                </label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col col-md-12">
                                <ul class="list-group" id='docslist'>
                                    
                                </ul>
                            </div>
                        </div>
                    </section>
                    
</form>                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("დახურვა")%></button>
                <button type="button" class="btn btn-success" onclick="submitContractDocs(); return false;"><i class="fa fa-plus"></i> <%=trs.t("შენახვა")%></button>
            </footer>
        </div>
    </div>
</div>

<script>
$(document).on("click", "#clearfilter", function (e) {e.preventDefault();$(this).closest('form').find("input[type=text], textarea").val(""); $("#list<%=gridname%>").jqGrid('setGridParam',{url:'content/get<%=gridname%>list.jsp'}).trigger("reloadGrid"); });
$(document).on("click", "#startfilter", function (e) {e.preventDefault();$("#list<%=gridname%>").jqGrid('setGridParam',{url:'content/get<%=gridname%>list.jsp?'+$(this).closest('form').serialize()}).trigger("reloadGrid"); });
$(document).on("change","#upload-contract", function () {if ($(this).val()){$('#filename-contract').html('<span> ' + $(this).val() + ' <span id="remove-contract" class="fa fa-times"></span></span>');}else{$('#filename-contract').html("<%=trs.t("ხელშეკრულების ატვირთვა")%>");}});
$(document).on("click", "#remove-contract", function (e) {e.preventDefault();$('#upload-contract').val("").change();});
$(document).on("change", "#upload-bill", function () {
        var billnum = $("#billnum").val();
        var input = this;
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            if(billnum == '')   {
                    $("#errorbill").show();
                    $("#errorbilltxt").html('<%=trs.t("მიუთითეთ ქვითრის ნომერი")%>');
                    setTimeout(function(){ $("#errorbill").hide(); $("#errorbilltxt").html(""); }, 5000);
                } else {
                    reader.onload = function (e) {
                        var tm = new Date().valueOf();
                        var s = "<li class='list-group-item justify-content-between' id='bill"+tm+"' style='padding: 10px 15px !important; margin-top: 5px !important;'><a href='";
                        s += e.target.result;
                        s += "' target='_blank'>"+billnum+"</a><span class='pull-right' style='cursor: pointer;'><a class='btn btn-danger btn-xs' onclick='$(\"#bill"+tm+"\").remove();' style='padding: 1px 7px !important;'><i class='fa fa-times'></i> </a></span>";
                        s += "<input type='hidden' name='bill' value='"+billnum+"'/><input type='hidden' name='bill_"+billnum+"' value='"+e.target.result+"'/></li>";
                        $("#billlist").append(s);
                        $("#billnum").val("");
                    };
                    reader.readAsDataURL(input.files[0]);
                }
        }
});
$(document).on("change", "#upload-docs", function () {
        var doctype = $("#frmdocs select[name=doctypeid]").val();
        var input = this;
        if (input.files && input.files[0]) {
            if(doctype == '')   {
                $("#errordocs").show();
                $("#errordocstxt").html('<%=trs.t("აირჩიეთ დოკუმენტის ტიპი")%>');
                setTimeout(function(){ $("#errordocs").hide(); $("#errordocstxt").html(""); }, 5000);
            } else {
                var docsnum = $("#upload-docs").val();
                var reader = new FileReader();
                reader.onload = function (e) {
                        var tm = new Date().valueOf();
                        var s = "<li class='list-group-item justify-content-between' id='docs"+tm+"' style='padding: 10px 15px !important; margin-top: 5px !important;'><a href='";
                        s += e.target.result;
                        s += "' target='_blank'>"+docsnum+"</a><span class='pull-right' style='cursor: pointer;'><a class='btn btn-danger btn-xs' onclick='$(\"#docs"+tm+"\").remove();' style='padding: 1px 7px !important;'><i class='fa fa-times'></i> </a></span>";
                        s += "<input type='hidden' name='docs_"+doctype+"' value='"+e.target.result+"'/></li>";
                        $("#docslist").append(s);
                        $("#docsnum").val("");
                    };
                reader.readAsDataURL(input.files[0]);
            }
        }
});
    
$(document).on("click", "#remove-bill", function (e) {e.preventDefault();$('#upload-bill').val("").change();});
$(document).on("click", "#remove-docs", function (e) {e.preventDefault();$('#upload-docs').val("").change();});
    
$(document).on("click", ".viewbill", function () {
    var cid = $(this).attr("data-itemid");
    $("#billModal").modal("show");
    $("#billlist").html("");
    $("#frmbill input[name='contractid']").val(cid);
    $.getJSON("api/getobject.jsp?obj=contractbill&contractid="+cid, function (res) {
        $.each(res.data,function(nm,vl){
            var billnum = vl.num;
            var tm = vl.id;
            var s = "<li class='list-group-item justify-content-between' id='bill"+tm+"' style='padding: 10px 15px !important; margin-top: 5px !important;'><a href='";
            s += vl.path;
            s += "' target='_blank'>"+billnum+"</a><span class='pull-right' style='cursor: pointer;'><a class='btn btn-danger btn-xs' onclick='$(\"#bill"+tm+"\").remove();' style='padding: 1px 7px !important;'><i class='fa fa-times'></i> </a></span>";
            s += "<input type='hidden' name='bill' value='"+billnum+"'/><input type='hidden' name='bill_"+billnum+"' value='ID_"+tm+"_"+vl.path+"'/></li>";
            $("#billlist").append(s);
        });
    });
});
$(document).on("click", ".viewdocs", function () {
    var cid = $(this).attr("data-itemid");
    $("#docsModal").modal("show");
    $("#docslist").html("");
    $("#frmdocs input[name='contractid']").val(cid);
    $.getJSON("api/getobject.jsp?obj=contractdocs&contractid="+cid, function (res) {
        $.each(res.data,function(nm,vl){
            var tm = vl.id;
            var s = "<li class='list-group-item justify-content-between' id='docs"+tm+"' style='padding: 10px 15px !important; margin-top: 5px !important;'><a href='";
            s += vl.path;
            s += "' target='_blank'>"+vl.doctype+"</a><span class='pull-right' style='cursor: pointer;'><a class='btn btn-danger btn-xs' onclick='$(\"#docs"+tm+"\").remove();' style='padding: 1px 7px !important;'><i class='fa fa-times'></i> </a></span>";
            s += "<input type='hidden' name='docs_"+vl.doctypeid+"' value='ID_"+tm+"_"+vl.path+"'/></li>";
            $("#docslist").append(s);
        });
    });
});

function submitContractBill() {
    sendMPForm("frmbill",cbSubmitContractBill);
}
function cbSubmitContractBill(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $("#billModal").modal("hide");
    }
}

function submitContractDocs() {
    sendMPForm("frmdocs",cbSubmitContractDocs);
}
function cbSubmitContractDocs(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $("#docsModal").modal("hide");
    }
}

function submitContract() {
    if  ($("#frmcontract input[name='editmode']").val()=="2") {    
            $('#reasonModal').modal('show');
    } else if ($("#contract-type").val() == "1") {
            sendMPForm("frmcontract",cbSubmitContract);
    } else if ($("#contract-type").val() == "2") {
            sendMPForm("frmcontract",cbSubmitContract);
    } else {
            alertError('<%=trs.t("აირჩიეთ ხელშეკრულების ტიპი")%>','','<%=trs.t("დახურვა")%>');
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
        $("#formModal").modal("hide");
        $('#list<%=gridname%>').trigger( 'reloadGrid' );
    }
}
function cbDeleteContract(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
        $("#formModal").modal("hide");
        $('#list<%=gridname%>').trigger( 'reloadGrid' );
    }
}

$(document).on("change", "#contract-type", function () {
    if ($(this).val() == "") {
        $(".contr1").hide();
        $(".contr2").hide();
    } else if ($(this).val() == "1") {
        $(".contr1").show();
        $(".contr2").hide();
        resetowner()
    } else {
        $(".contr1").hide();
        $(".contr2").show();
    }
});
$(document).on("change", ".checkshow", function () {
    resetowner()
});

function resetowner()
{
    if ($(".checkshow").is(':checked')) {$(".contr4").show();} else {$(".contr4").hide();}
}

function resetContactForm()
{
    $("#frmcontracttitle").html('<%=trs.t("ახალი ხელშეკრულების დამატება")%>');
    $('#frmcontract').attr('action', 'api/setcontract.jsp');
    $("#frmcontract input[name='editmode']").val("");
    $("#frmcontract input[name='contragentid']").val("");
    $("#frmcontract input[name='contactid']").val("");
    $("#frmcontract input[name='startdate']").val("");
    $("#frmcontract input[name='enddate']").val("");
    $("#frmcontract input[name='num']").val("");
    $("#frmcontract input[name='price']").val("");
    $("#frmcontract textarea[name='info']").val("");
    contragent2select("frmcontract","contragentid");
    $("#contract-type").val("").change();
    $(".contr1").hide();
    $(".contr2").hide();
    $("#contractfield").show();

    $(".limits").find('.limit-item').html("");
    $(".limits").find('.limit-edit').html("");
    addLabtest("","","","","","");
}
var  optLabtest ='<option value=""><%=trs.t("კვლევა")%></option><%=ObjOptions.Labtest().replace("'","\\'").replace("\n","")%>';
var  optSample  ='<option value=""><%=trs.t("ნიმუში")%></option><%=sampletypes.replace("'","\\'").replace("\n","")%>';
function addLabtest(sampletype, labtest,maxprice,maxnum,minday,maxday)
{
    var $fg = $(".limits").find('.limit-item').length;
    $clone = $('<div class="limit-item">\n\
<section class="col col-md-12"><div class="col-xs-12"><hr></div></section>\n\
<section class="col col-md-6"><label class="select"><select name="sampletype'+$fg+'" id="sampletype'+$fg+'" style="width:100%" >'+optSample+'</select></label></section>\n\
<section class="col col-md-6"><label class="select"><select name="labtest'+$fg+'" id="labtest'+$fg+'" style="width:100%" >'+optLabtest+'</select></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-money"></i><input value="'+maxprice+'" name="maxprice'+$fg+'" class="testprice" placeholder="<%=trs.t("მაქს. ფასი")%>" type="number" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-money txt-color-teal\"></i> <%=trs.t("მაქსიმალური ფასი")%></b></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-list-ol"></i><input value="'+maxnum+'" name="maxnum'+$fg+'" placeholder="<%=trs.t("მაქს. რაოდენობა")%>" type="number" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-list-ol txt-color-teal\"></i> <%=trs.t("მაქსიმალური რაოდენობა")%></b></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-list-ol"></i><input value="'+minday+'" name="minday'+$fg+'" placeholder="<%=trs.t("მინ.ვადა")%>" type="number" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-list-ol txt-color-teal\"></i> <%=trs.t("მინიმალური ვადა")%></b></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-list-ol"></i><input value="'+maxday+'" name="maxday'+$fg+'" placeholder="<%=trs.t("მაქს.ვადა")%>" type="number" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-list-ol txt-color-teal\"></i> <%=trs.t("მაქსიმალური ვადა")%></b></label></section>\n\
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
<section class="col col-md-6"><label class="select"><select name="edlab'+$fg+'" id="edlab'+$fg+'" style="width:100%" ><option value=""><%=trs.t("- კვლევა -")%></option>'+optLabtest+'</select></label></section>\n\
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

    $(document).on("click", ".addnew", function (e) {
        e.preventDefault();
        addLabtest("","","","","","");
        $(this).removeClass("addnew").removeClass("btn-success").addClass("btn-danger").addClass("removenew");
        $(this).find(".fa").removeClass("fa-plus").addClass("fa-times");
    });
    $(document).on("click", ".removenew", function () {
        $(this).parent().parent().remove();
        var $fg = $(".limits").find('.limit-item').length;
        for(i=0; i<$fg.length; i++) {
            $($fg[i]).find("input[type='text'], select, textarea").each(function () {
                    this.name = this.name.substr(0,this.name.length-1)+(i+1);
                    this.id = this.id.substr(0,this.id.length-1)+(i+1);
            });
        };
    });
    $(document).on("click", ".removeold", function () {
        $(this).parent().parent().remove();
    });

function getFmtDate(date) {
  var year = date.getFullYear();
  var month = (1 + date.getMonth()).toString();
  month = month.length > 1 ? month : '0' + month;
  var day = date.getDate().toString();
  day = day.length > 1 ? day : '0' + day;
  return  day + '/' + month + '/' + year;
}    

 $(".hasDatepicker").each(function(){
    $(this).datepicker({
        format: 'dd/mm/yyyy', 
        //startDate: getFmtDate(new Date()),
        autoclose: true, 
        language: 'ka', 
        todayHighlight: true, 
	prevText : '<i class="fa fa-chevron-left"></i>',
	nextText : '<i class="fa fa-chevron-right"></i>'
	})
	.on('changeDate', function(e) {
            if (this.id=="cotract_startdate") {
                $("#cotract_enddate").datepicker('setStartDate',e.date);
                $("#cotract_enddate").datepicker('update');
            } else if (this.id=="cotract_enddate") {
                $("#cotract_startdate").datepicker('setEndDate',e.date);
                $("#cotract_startdate").datepicker('update');
            }
        });
    });

function contragent2select(form,name) {
    $("#"+form+" input[name="+name+"]").select2({
        minimumInputLength: 1,
        allowClear: true,
        cache: true,
        ajax: {
            url: "api/getobject.jsp?obj=contragentlist",
            dataType: 'json',
            data: function (term, page) {
                return {
                    q: term
                  };
            },
            results: function (data, page) {
                return {results: data
                };
            }
        },
        
        
        formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
        formatInputTooShort: function () {return "<%=trs.t("შეიტანეთ დამკვეთის დასახელება ან ნომერი")%>";},
        formatNoMatches: function () {return "<%=trs.t("დამკვეთი არ მოიძებნა")%>";},
        escapeMarkup: function (markup) {return markup;}
    });
}
contragent2select("frmcontract","contragentid");
contragent2select("frmfilter","contragentid");

</script>
