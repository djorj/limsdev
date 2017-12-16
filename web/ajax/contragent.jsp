<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%    String gridname = "contragent";
    String ses = "EXPORT_BAR_" + (new Date()).getTime();
    jqexport exp = new jqexport(ses, null, null, "EXPORT_STOP", "content/export_" + gridname + ".jsp", "");
%>
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

function addContragent() {
    $("#frmcontragenttitle").html('<%=trs.t("ახალი ჩანაწერის დამატება")%>');
    $("#frmcontragent textare,input").each(function(){$(this).val("");});
    $("#frmcontragent select").each(function(){$(this).val("").trigger("change");});
    $('#frmcontragent input[name="oper"]').val("add");
    $('#frmcontragent input[name="contragentid"]').val("");
    $("#contragentModal").modal('show');
}
function editContragent() {
    var myGrid = $('#list<%=gridname%>');
    var RowId = myGrid.jqGrid('getGridParam', 'selrow');
    if (RowId==null)
    {
        alertError('<%=trs.t("შეცდომა")%>',"ჩანაწერი არჩეული არ არის",'<%=trs.t("დახურვა")%>');
        return;
    }
    
    value = myGrid.jqGrid ('getCell', RowId, 'id');
    res = getObject({"contragentid": value, "obj":"objcontragent"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',res.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $("#contragentModal").modal('show');
        $.each(res.data, function(n,v) {$("#frmcontragent textare,input[name='"+n+"']").val(v);});
        $("#frmcontragenttitle").html('<%=trs.t("ჩანაწერის რედაქტირება")%>');
        $('#frmcontragent input[name="oper"]').val("edit");
        $('#frmcontragent input[name="contragentid"]').val(value);
        loadRegion(res.data.region,res.data.raion,res.data.city);
    }
}
function delContragent() {
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
    sendRequest("api/delobject.jsp",{obj:"objcontragent",id: value},cbDeleteContragent);
  }
}

        function run_jqgrid_function() {


            jQuery("#list<%=gridname%>").jqGrid({
                url: 'content/get<%=gridname%>list.jsp',
                datatype: "json",
                colNames: ['id','<%=trs.t("ტიპი")%>', '<%=trs.t("დასახელება")%>', '<%=trs.t("საიდ. კოდი/პირ. ნომ.")%>', '<%=trs.t("მისამართი")%>', '<%=trs.t("ტელეფონი")%>', '<%=trs.t("ელფოსტა")%>', '<%=trs.t("ვებ-გვერდი")%>', '<%=trs.t("კონტაქტი")%>', '<%=trs.t("საბანკო ინფ.")%>', '<%=trs.t("შენიშვნა")%>'],
                colModel: [
                    {name: 'id', index: 'id', editable: true, align: "left", width: 0, hidden:true},
                    {name: 'contragenttypeid', index: 'contragenttypeid', align: "left", width: 100},
                    {name: 'name', index: 'name', align: "left", width: 200},
                    {name: 'idn', index: 'idn', align: "left", width: 100},
                    {name: 'address', index: 'address', align: "left", width: 100},
                    {name: 'phone', index: 'phone', align: "left", width: 100},
                    {name: 'email', index: 'email', align: "left", width: 100},
                    {name: 'url', index: 'url', align: "left", width: 100},
                    {name: 'contact', index: 'contact', align: "left", width: 100},
                    {name: 'bankdata', index: 'bankdata', align: "left", width: 100},
                    {name: 'note', index: 'note', align: "left", width: 100}
                ],
                rowNum: 20,
                height: 350,
                width: 900,
                rownumbers:true,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pager<%=gridname%>'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/upd<%=gridname%>.jsp"
            })
                    .navGrid('#pager<%=gridname%>', {edit:false, add:false, del:false, view: false, search: false})
    <%if (permissions[0]) {%>
            .navButtonAdd('#pager<%=gridname%>', {title:'<%=trs.t("ახალი ჩანაწერის დამატება")%>', id: 'add<%=gridname%>', caption: '<i class="fa fa-plus"></i>', buttonicon: 'none', onClickButton: addContragent})
    <%}%>
    <%if (permissions[1]) {%>
            .navButtonAdd('#pager<%=gridname%>', {title:'<%=trs.t("აირჩეული ჩანაწერის ნახვა")%>', id: 'edit<%=gridname%>', caption: '<i class="fa fa-file-text-o"></i>', buttonicon: 'none', onClickButton: addContragent})
            .navButtonAdd('#pager<%=gridname%>', {title:'<%=trs.t("აირჩეული ჩანაწერის რედაქტირება")%>', id: 'edit<%=gridname%>', caption: '<i class="fa fa-pencil"></i>', buttonicon: 'none', onClickButton: editContragent})
    <%}%>
    <%if (permissions[2]) {%>
            .navButtonAdd('#pager<%=gridname%>', {title:'<%=trs.t("არჩეული ჩანაწერის წაშლა")%>', id: 'del<%=gridname%>', caption: '<i class="fa fa-trash-o"></i>', buttonicon: 'none', onClickButton: delContragent})
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


            $(".ui-pg-div").removeClass().addClass("btn btn-sm btn-primary");
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
                <div class="col-sm-12">
                    <section class="col col-sm-2">
                        <label class="label"> <%=trs.t("დასახელება")%></label>
                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                            <input name="name" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-address-book txt-color-teal"></i> <%=trs.t("დასახელება")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="label"> <%=trs.t("საიდ. კოდი/პირ. ნომ.")%></label>
                        <label class="input"> <i class="icon-append fa fa-id-card"></i>
                            <input name="idn" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-id-card txt-color-teal"></i> <%=trs.t("საიდენტიფიკაციო კოდი ან პირადი N")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="label"> <%=trs.t("მისამართი")%></label>
                        <label class="input"> <i class="icon-append fa fa-map-marker"></i>
                            <input name="address" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-map-marker txt-color-teal"></i> <%=trs.t("მისამართი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="label"> <%=trs.t("ტელეფონი")%></label>
                        <label class="input"> <i class="icon-append fa fa-phone"></i>
                            <input name="phone" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-phone txt-color-teal"></i> <%=trs.t("ტელეფონი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="label"> <%=trs.t("ელფოსტა")%></label>
                        <label class="input"> <i class="icon-append fa fa-envelope"></i>
                            <input name="email" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-envelope txt-color-teal"></i> <%=trs.t("ელფოსტა")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="label"> <%=trs.t("ვებ-გვერდი")%></label>
                        <label class="input"> <i class="icon-append fa fa-link"></i>
                            <input name="url" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-link txt-color-teal"></i> <%=trs.t("ვებ-გვერდი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="label"> <%=trs.t("კონტაქტი")%></label>
                        <label class="input"> <i class="icon-append fa fa-user"></i>
                            <input name="contact" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("კონტაქტი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="label"> <%=trs.t("საბანკო ინფ.")%></label>
                        <label class="input"> <i class="icon-append fa fa-credit-card"></i>
                            <input name="bankdata" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-credit-card txt-color-teal"></i> <%=trs.t("საბანკო ინფორმაიცა")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="label"> <%=trs.t("შენიშვნა")%></label>
                        <label class="input"> <i class="icon-append fa fa-comment"></i>
                            <input name="note" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-comment txt-color-teal"></i> <%=trs.t("შენიშვნა")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="label"> <%=trs.t("დამკვეთის ტიპი")%></label>
                        <label class="select">
                            <select name="contragenttypeid" class="select2">
                            <option value=""></option>
                            <% out.println(ObjOptions.Contragenttype()); %>
                            </select>
                            <b class="tooltip tooltip-top-right"><%=trs.t("ტიპი")%></b>
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
<div class="table-size3 active">
    <table id="list<%=gridname%>"></table>
    <div id="pager<%=gridname%>"></div>
</div>
<div class="modal fade" id="contragentModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog large">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 id="frmcontragenttitle" class="modal-title"><%=trs.t("დამკვეთის დამატება")%></h4>
            </div>
            <div class="modal-body">






<div class="smart-form col-sm-12">
<form id="frmcontragent" action="api/setcontragent.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden">
<input name="contragentid" type="hidden">
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("დამკვეთის ტიპი")%></label>
                        <label class="select">
                            <select class="select2 req" name="contragenttypeid" >
                                            <option value=""><%=trs.t("დამკვეთის ტიპი")%></option>
                                            <% out.println(ObjOptions.Contragenttype()); %>
                            </select>
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("დამკვეთის დასახელება")%></label>
                        <label class="input"> <i class="icon-append fa fa-institution"></i>
                            <input type="text" name="name">
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("საიდ. კოდი/პირ. ნომ.")%></label>
                        <label class="input"> <i class="icon-append fa fa-id-card"></i>
                            <input type="text" name="idn">
                        </label>
                    </section>
                        
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("რეგიონი")%></label>
                        <label class="select">
                            <select name="region"  style="width:100%;"></select> 
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("რაიონი/ქალაქი")%></label>
                        <label class="select">
                            <select name="raion"  style="width:100%;" disabled></select> 
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("სოფელი")%></label>
                        <label class="select">
                            <select name="city"  style="width:100%;" disabled></select> 
                        </label>
                    </section>
                    <section class="col col-md-12">
                        <label class="label"><%=trs.t("მისამართი")%></label>
                        <label class="textarea"> 
                            <i class="icon-append fa fa-id-card"></i><textarea name="address" disabled></textarea>
                        </label>
                    </section>
                    <section class="col col-md-12"></section>
                    
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("ტელეფონი")%></label>
                        <label class="input"> <i class="icon-append fa fa-phone"></i>
                            <input type="text" name="phone">
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("ელფოსტა")%></label>
                        <label class="input"> <i class="icon-append fa fa-envelope"></i>
                            <input type="text" name="email">
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("ვებ-გვერდი")%></label>
                        <label class="input"> <i class="icon-append fa fa-link"></i>
                            <input type="text" name="url">
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("კონტაქტი")%></label>
                        <label class="input"> <i class="icon-append fa fa-user"></i>
                            <input type="text" name="contact">
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("საბანკო ინფორმაცია")%></label>
                        <label class="input"> <i class="icon-append fa fa-credit-card"></i>
                            <input type="text" name="bankdata">
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("შენიშვნა")%></label>
                        <label class="input"> <i class="icon-append fa fa-comment"></i>
                            <input type="text" name="note">
                        </label>
                    </section>
                        </form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" ><%=trs.t("გაუქმება")%></button>
                <button type="button" class="btn btn-success" onclick="submitContragent(); return false;"><%=trs.t("შენახვა")%></button>
            </footer>
        </div>
    </div>
</div>

<script>
$(document).on("click", "#clearfilter", function (e) {e.preventDefault();$(this).closest('form').find("input[type=text], textarea").val(""); $("#list<%=gridname%>").jqGrid('setGridParam',{url:'content/get<%=gridname%>list.jsp'}).trigger("reloadGrid"); });
$(document).on("click", "#startfilter", function (e) {e.preventDefault();$("#list<%=gridname%>").jqGrid('setGridParam',{url:'content/get<%=gridname%>list.jsp?'+$(this).closest('form').serialize()}).trigger("reloadGrid"); });
function submitContragent() {
        sendForm("frmcontragent",cbSubmitContragent);
}
function cbSubmitContragent(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
        $("#contragentModal").modal("hide");
        $('#list<%=gridname%>').trigger( 'reloadGrid' );
    }
}
function cbDeleteContragent(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
        $("#contragentModal").modal("hide");
        $('#list<%=gridname%>').trigger( 'reloadGrid' );
    }
}

function loadRegion(region,raion,city)
{
 $.getJSON("api/getobject.jsp?obj=region", function (json) {
    $o = $("#frmcontragent select[name=region]");
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

$(document).on("change", "#frmcontragent select[name='region']", function () {
    loadRaion($("#frmcontragent select[name='region']").val());
    if ($("#frmcontragent select[name='region']").val()=="")
    {
        select2raion();
        select2city();
    }
  });
$(document).on("change", "#frmcontragent select[name='raion']", function () {
    loadCity($("#frmcontragent select[name='raion']").val());
    if ($("#frmcontragent select[name='raion']").val()=="")
    {
        select2city();
    }
  });
$(document).on("change", "#frmcontragent select[name='city']", function () {
    $("#frmcontragent textare[name='address']").attr("disabled",false);
    });

function select2raion(opt,raion)
{
    opt = (typeof opt !== 'undefined') ? opt :[];
    $o = $("#frmcontragent select[name='raion']");
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

    $o = $("#frmcontragent select[name='city']");
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
    $("#frmcontragent textarea[name=address]").attr("disabled",false);
}


$(function() {
loadRegion();
select2raion();
select2city();
});

</script>
