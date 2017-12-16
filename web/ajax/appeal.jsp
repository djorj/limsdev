<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%    
    String gridname = "appeal";
    String ses = "EXPORT_BAR_" + (new Date()).getTime();
    jqexport exp = new jqexport(ses, null, null, "EXPORT_STOP", "content/export_" + gridname + ".jsp", "");
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

function addAppeal() {
    $("#frmappealtitle").html('<%=trs.t("ახალი მიმართვის დამატება")%>');
    $("#frmappeal textare,input").each(function(){$(this).val("");});
    $("#frmappeal select").each(function(){$(this).val("").trigger("change");});
    $('#frmappeal input[name="oper"]').val("add");
   
    $("#chlabModal").modal('show');
}
   
function editAppeal() {
    var myGrid = $('#list<%=gridname%>');
    var RowId = myGrid.jqGrid('getGridParam', 'selrow');
    if (RowId==null)
    {
        alertError('<%=trs.t("შეცდომა")%>',"ჩანაწერი არჩეული არ არის",'<%=trs.t("დახურვა")%>');
        return;
    }
    
    value = myGrid.jqGrid ('getCell', RowId, 'id');
    res = getObject({"appealid": value, "obj":"objappeal"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',res.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $("#chlabModal").modal('show');
        $.each(res.data, function(n,v) {$("#frmappeal input[name='"+n+"']").val(v);});
        $("#frmappealtitle").html('<%=trs.t("ჩანაწერის რედაქტირება")%>');
        loadRegion(res.data.region,res.data.raion,res.data.city);
    }
}
function delAppeal() {
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
    sendRequest("api/delobject.jsp",{obj:"objappeal",id: value},cbDeleteAppeal);
  }
}

        function run_jqgrid_function() {

            jQuery("#list<%=gridname%>").jqGrid({
                url: 'content/get<%=gridname%>list.jsp',
                datatype: "json",
                colNames: ['id','<%=trs.t("დამკვეთი")%>', '<%=trs.t("ხელშეკრულების N")%>', '<%=trs.t("მიმართვის N")%>', '<%=trs.t("თარიღი")%>', '<%=trs.t("სინჯის რაოდენობა")%>', '<%=trs.t("რეგიონი")%>', '<%=trs.t("დოკუმენტი")%>'],
                colModel: [
                    {name: 'id', index: 'id', editable: true, align: "left", width: 0, hidden:true}, //hidden: true},
                    {name: 'contragent', index: 'contragent', editable: true, align: "left", width: 300},
                    {name: 'contract', index: 'contract', editable: true, align: "left", width: 100},
                    {name: 'num', index: 'num', editable: true, align: "left", width: 100},
                    {name: 'appealdate', index: 'appealdate', editable: true, align: "left", width: 100},
                    {name: 'samplenum', index: 'samplenum', editable: true, align: "left", width: 100},
                    {name: 'region', index: 'region', editable: true, align: "left", width: 100},
                    {name: 'doc', index: 'doc', editable: true, align: "center", width: 50}
                ],
                rowNum: 20,
                height: 350,
                width: 900,
                rownumbers:true,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pager<%=gridname%>'),
                sortname: 'appealdate',
                viewrecords: true,
                sortorder: "desc",
                editurl: "content/upd<%=gridname%>.jsp"
            })
            .navGrid('#pager<%=gridname%>', {edit:false, add:false, del:false, view: false, search: false})
    <%if (permissions[0]) {%>
            .navButtonAdd('#pager<%=gridname%>', {title:'<%=trs.t("ახალი ჩანაწერის დამატება")%>', id: 'add<%=gridname%>', caption: '<i class="fa fa-plus"></i>', buttonicon: 'none', onClickButton: addAppeal})
    <%}%>
    <%if (permissions[1]) {%>
            .navButtonAdd('#pager<%=gridname%>', {title:'<%=trs.t("აირჩეული ჩანაწერის ნახვა")%>', id: 'edit<%=gridname%>', caption: '<i class="fa fa-file-text-o"></i>', buttonicon: 'none', onClickButton: addAppeal})
            .navButtonAdd('#pager<%=gridname%>', {title:'<%=trs.t("აირჩეული ჩანაწერის რედაქტირება")%>', id: 'edit<%=gridname%>', caption: '<i class="fa fa-pencil"></i>', buttonicon: 'none', onClickButton: editAppeal})
    <%}%>
    <%if (permissions[2]) {%>
            .navButtonAdd('#pager<%=gridname%>', {title:'<%=trs.t("არჩეული ჩანაწერის წაშლა")%>', id: 'del<%=gridname%>', caption: '<i class="fa fa-trash-o"></i>', buttonicon: 'none', onClickButton: delAppeal})
    <%}%>
    <%if (permissions[4]) {%>
            .navButtonAdd('#pager<%=gridname%>', {id: 'export<%=gridname%>', caption: '<i class="fa fa-file-excel-o"></i> <%=trs.t("ექსპორტი")%>', buttonicon: "none", onClickButton: function () {
    <%=exp.getClickCode()%>
                }, position: 'last'})
    <%}%>
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

            $("#add<%=gridname%>").find("div").removeClass().addClass("btn").addClass("btn-sm").addClass("btn-success");
            $("#edit<%=gridname%>").find("div").removeClass().addClass("btn").addClass("btn-sm").addClass("btn-warning");
            $("#del<%=gridname%>").find("div").removeClass().addClass("btn").addClass("btn-sm").addClass("btn-danger");

            $(".ui-pg-div").removeClass().addClass("btn btn-sm btn-primary");
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
        $(".table-size5").toggleClass("active");
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
    <div class="col-sm-12">
                    <section class="col col-sm-2">
                        <label class="label"> <%=trs.t("მიმართვის N")%></label>
                        <label class="input input-sm"> <i class="icon-append fa fa-pencil-square-o"></i>
                            <input name="num" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="label"> <%=trs.t("ხელშეკრულების N")%></label>
                        <label class="input input-sm"> <i class="icon-append fa fa-pencil-square-o"></i>
                            <input name="contractnum" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-3">
                        <label class="label"> <%=trs.t("თარიღი")%></label>
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input name="daterange" class="daterangepicker" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="label"> <%=trs.t("სინჯის რაოდენობა")%></label>
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input name="samplenum" type="text">
                        </label>
                    </section>
                    <button class="btn btn-info pull-right" style="margin-right: 5px;" id="clearfilter"><i class="fa fa-times"></i> <%=trs.t("გასუფთავება")%></button>
                    <button class="btn btn-success pull-right" style="margin-right: 5px;" id="startfilter"><i class="fa fa-search"></i> <%=trs.t("ძებნა")%></button>
                </div>
    </form>
            </div>
        </div>
    </div>
</section>
<div class="table-size5 active">
    <table id="list<%=gridname%>"></table>
    <div id="pager<%=gridname%>"></div>
</div>


<div class="modal fade" id="chlabModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 id="frmappealtitle" class="modal-title"><%=trs.t("ახალი მიმართვის დამატება")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
                        <form id="frmappeal" enctype="multipart/form-data" action="api/setappeal.jsp" enctype="multipart/form-data" accept-charset="UTF-8">
                        <input name="oper" type="hidden">
                        <input name="id" type="hidden">
                                    
                                    
                                <section class="col col-md-3">
                        <label class="label"><%=trs.t("მიმართვის N")%></label>
                                    <label class="input"> <i class="icon-append fa fa-file-o"></i>
                                        <input class="req" name="num" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-3">
                        <label class="label"><%=trs.t("ხელშეკრულების N")%></label>
                                    <label class="input"> <i class="icon-append fa fa-file-o"></i>
                                        <input class="req" name="contractnum" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-3">
                        <label class="label"><%=trs.t("თარიღი")%></label>
                                    <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                        <input class="hasDatepicker req" name="appealdate"  type="text">
                                    </label>
                                </section>
                                <section class="col col-md-3">
                        <label class="label"><%=trs.t("ნიმუშების რაოდენობა")%></label>
                                    <label class="input" > <i class="icon-append fa fa-list-ol"></i>
                                        <input name="samplenum" type="text">
                                    </label>
                                </section>
                    <section class="col col-sm-4" id="contragenregion">
                        <label class="label"><%=trs.t("რეგიონი")%></label>
                        <label class="select">
                            <select name="region"  style="width:100%;"></select> 
                        </label>
                    </section>
                    <section class="col col-sm-4" id="contragentraion" >
                        <label class="label"><%=trs.t("რაიონი/ქალაქი")%></label>
                        <label class="select">
                            <select name="raion"  style="width:100%;" disabled></select> 
                        </label>
                    </section>
                    <section class="col col-sm-4" id="contragentcity">
                        <label class="label"><%=trs.t("სოფელი")%></label>
                        <label class="select">
                            <select name="city"  style="width:100%;" disabled></select> 
                        </label>
                    </section>
                    <section class="col col-md-12" id="contragentaddress">
                        <label class="label"><%=trs.t("მისამართი")%></label>
                        <label class="textarea"> 
                            <i class="icon-append fa fa-id-card"></i><textarea name="address" disabled></textarea>
                        </label>
                    </section>
                    <section class="col col-md-12"></section>
                                <section class="col col-md-3">
                                    <label class="btn btn-primary change-pic contract-file">
                                        <span id="filename-appeal"><%=trs.t("მიმართვის ატვირთვა")%></span>
                                        <input name=docfile type="file" id="upload-appeal"/>
                                    </label>
                                </section>
                        </form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i><%=trs.t("გაუქმება")%></button>
                <button type="button" class="btn btn-success" onclick="submitAppeal(); return false;"><i class="fa fa-plus"></i><%=trs.t("შენახვა")%></button>
            </footer>
        </div>
    </div>
</div>

                
<script>
$(document).on("click", "#clearfilter", function (e) {e.preventDefault();$(this).closest('form').find("input[type=text], textarea").val(""); $("#list<%=gridname%>").jqGrid('setGridParam',{url:'content/get<%=gridname%>list.jsp'}).trigger("reloadGrid"); });
$(document).on("click", "#startfilter", function (e) {e.preventDefault();$("#list<%=gridname%>").jqGrid('setGridParam',{url:'content/get<%=gridname%>list.jsp?'+$(this).closest('form').serialize()}).trigger("reloadGrid"); });
$(document).on("change", "#upload-appeal", function () {if ($(this).val()){$('#filename-appeal').html('<span><span id="remove-appeal" class="fa fa-times"></span>' + $(this).val() + '</span>');}else{$('#filename-appeal').html("<%=trs.t("დოკუმენტისს ატვირთვა")%>");}});
$(document).on("click", "#remove-appeal", function (e) {e.preventDefault();$('#upload-appeal').val("").change();});
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
function submitAppeal() {
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
        $("#chlabModal").modal("hide");
        $('#list<%=gridname%>').trigger( 'reloadGrid' );
    }
}
function cbDeleteAppeal(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
        $("#chlabModal").modal("hide");
        $('#list<%=gridname%>').trigger( 'reloadGrid' );
    }
}

function loadRegion(region,raion,city)
{
 $.getJSON("api/getobject.jsp?obj=region", function (json) {
    $o = $("#frmappeal select[name=region]");
    $o.select2('destroy').empty();
    $o.append($('<option>').text("").attr('value', ""));
    $.each(json.data, function(i, v) {$o.append($('<option>').text(v.text).attr('value', v.id));});
    if(typeof region !== 'undefined')
        $o.val(region);
    
    $o.select2({allowClear: true,placeholder: "<%=trs.t("რეგიონი")%>",
    formatNoMatches: function () {return "<%=trs.t("რეგიონი არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
    });
    if(typeof raion !== 'undefined')
        loadRaion(region,raion, city);
 });
}
    
function loadRaion(region,raion,city){
    $.getJSON("api/getobject.jsp?obj=region&punitid="+region, function (json) {
        select2raion(json.data,raion);
        if(typeof raion !== 'undefined')
            loadCity(raion, city);
    });
}
function loadCity(raion,city) {
    $.getJSON("api/getobject.jsp?obj=region&punitid="+raion, function (json) {
        select2city(json.data,city);
    });
}

$(document).on("change", "#frmappeal select[name='region']", function () {
    loadRaion($("#frmappeal select[name='region']").val());
    if ($("#frmappeal select[name='region']").val()=="")
    {
        select2raion();
        select2city();
    }
  });
$(document).on("change", "#frmappeal select[name='raion']", function () {
    loadCity($("#frmappeal select[name='raion']").val());
    if ($("#frmappeal select[name='raion']").val()=="")
    {
        select2city();
    }
  });
$(document).on("change", "#frmappeal select[name='city']", function () {
    $("#frmappeal textare[name='address']").attr("disabled",false);
    });

function select2raion(opt,raion)
{
    opt = (typeof opt !== 'undefined') ? opt :[];
    $o = $("#frmappeal select[name='raion']");
    $o.select2('destroy').empty();
    $o.append($('<option>').text("").attr('value', ""));
    $.each(opt, function(i, v) {$o.append($('<option>').text(v.text).attr('value', v.id));});
    if(typeof raion !== 'undefined')
        $o.val(raion);
    
    $o.select2({allowClear: true,placeholder: "<%=trs.t("რაიონი/ქალაქი")%>",
    formatNoMatches: function () {return "<%=trs.t("რაიონი/ქალაქი არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
    });
    $o.attr("disabled",opt.length==0);
}
function select2city(opt,city)
{
    opt = (typeof opt !== 'undefined') ? opt :[];

    $o = $("#frmappeal select[name='city']");
    $o.select2('destroy').empty();
    $o.append($('<option>').text("").attr('value', ""));
    $.each(opt, function(i, v) {$o.append($('<option>').text(v.text).attr('value', v.id));});
    if(typeof city !== 'undefined')
        $o.val(city);
    $o.select2({allowClear: true,placeholder: "<%=trs.t("სოფელი")%>",
    formatNoMatches: function () {return "<%=trs.t("სოფელი არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
    });
    $o.attr("disabled",opt.length==0);
    $("#frmappeal textarea[name=address]").attr("disabled",false);
}

$(document).on("click", ".viewdocs", function () {
    printReport('appeal',$(this).attr("data-itemid"));
});

$(function() {
loadRegion();
select2raion();
select2city();
});

</script>

