<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%    
    String gridname = "samplelist";
    String ses = "EXPORT_BAR_" + (new Date()).getTime();
    jqexport exp = new jqexport(ses, null, null, "EXPORT_STOP", "content/export_" + gridname + ".jsp", "");
    String sampletypes = ObjOptions.Sampletypes(user.getCompanyid());
    String species = "";
    SpeciesBean[] sps = SpeciesManager.getInstance().loadByWhere("order by name");
    for(int i=0;i<sps.length;i++){
        species += "<option value='"+sps[i].getSpeciesid()+"'>"+sps[i].getName()+"</option>";
    }
%>
<style>
#exportsamplelist {
        line-height: 1.19 !important;
}
.popover.clockpicker-popover{
    z-index: 1050;
}
</style>
<%=exp.getExportAttr()%>
<link href="js/plugin/bootstrap-datepicker/css/datepicker3.css"  rel="stylesheet">
<script src="js/plugin/bootstrap-tags/bootstrap-tagsinput.min.js" type="text/javascript"></script>
<script src="js/plugin/bootstrap-datepicker/bootstrap-datepicker.js"></script>
<script src="js/plugin/bootstrap-datepicker/locales/bootstrap-datepicker.ka.js"></script>
<script src="js/plugin/clockpicker/clockpicker.min.js"></script>

<script type="text/javascript">
    pageSetUp();

    var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);

        function run_jqgrid_function() {

            jQuery("#list<%=gridname%>").jqGrid({
                url: 'content/get<%=gridname%>list.jsp',
                datatype: "json",
                colNames: ['<%=trs.t("გად. N")%>','<%=trs.t("ბარკოდი")%>', '<%=trs.t("ნიმუშის ტიპი")%>',  '<%=trs.t("სახეობა")%>', '<%=trs.t("კვლევა")%>',  '<%=trs.t("თარიღი")%>', '<%=trs.t("დამკვეთი")%>', '<%=trs.t("საველე&nbsp;N")%>', '<%=trs.t("ადგილმდებარეობა")%>', '<%=trs.t("სტატუსი")%>', '<%=trs.t("მოქმედება")%>','statusid'],
                colModel: [
                    {name: 'transitactid', index: 'transitactid', editable: true, align: "center", width: 40},
                    {name: 'barcode', index: 'barcode', editable: true, align: "center", width: 100},
                    {name: 'sampletype', index: 'sampletype', editable: true, align: "left", width: 100},
                    {name: 'speciesid', index: 'speciesid', editable: true, align: "left", width: 100},
                    {name: 'labtestid', index: 'labtestid', editable: true, align: "left", width: 100},
                    {name: 'regdate', index: 'regdate', editable: true, align: "center", width: 70},
                    {name: 'contragent', index: 'contragent', editable: true, align: "left", width: 120},
                    {name: 'num1', index: 'num1', editable: true, align: "left", width: 70},
                    {name: 'place', index: 'place', editable: true, align: "left", width: 120},
                    {name: 'status', index: 'status', editable: true, align: "left", width: 80},
                    {name: 'act', index: 'act', editable: true, align: "center", width: 160},
                    {name: 'statusid', index: 'statusid', sortable: false, hidden: true, width: 0}
                ],
                rowNum: 20,
                height: 200,
                width: 1000,
                rownumbers:false,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pager<%=gridname%>'),
                sortname: 'regdate',
                viewrecords: true,
                sortorder: "desc",
                multiselect: true,
                caption: '',
                gridComplete: function() {
                    var grid = $(this);
                    var ids = $(this).jqGrid('getDataIDs');
                    for (var i=0;  i<ids.length; i++)  {
                        var s=grid.getCell(ids[i], 'statusid');
                        if (s=="2") {
                            $('#' + ids[i]).addClass('stoped');            
                        }
                        else if (s=="3") {
                            $('#' + ids[i]).addClass('rowbg1');            
                        }
                        
                    }
                }
            })
        .navGrid('#pager<%=gridname%>', {edit:false, add:false, del:false, view: false, search: false});
        



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
                jQuery("#list<%=gridname%>").jqGrid('setGridWidth', $("#content").width() - 10);
            })
            
            
            
            
        }
    }

    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);

    function showban() {
        $("#banmodal").modal("show");
    }
    function showdestroy() {
        $("#destroymodal").modal("show");
    }
    function showinfo() {
        $("#infoModal").modal("show");
    }

    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!
    var yyyy = today.getFullYear();

    if (dd < 10) {
        dd = '0' + dd;
    }

    if (mm < 10) {
        mm = '0' + mm;
    }

    today = dd + '/' + mm + '/' + yyyy;
    $("#now").val(today);

    $('.daterangepicker').daterangepicker({
        autoUpdateInput: false,
        locale: {
            format: 'DD/MM/YYYY',
            cancelLabel: '<%=trs.t("დახურვა")%>'
        }
    });
    $('.daterangepicker').on('apply.daterangepicker', function (ev, picker) {$(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));});
    $('.daterangepicker').on('cancel.daterangepicker', function (ev, picker) {$(this).val('');});
    $(document).on("click", ".jarviswidget-toggle-btn", function () {
        $(".table-size13").toggleClass("active");
    });
    
    $(document).on("click",".getitem", function(){
        var myGrid = $('#list<%=gridname%>');
        var RowId = $(this).attr("data-itemid");
        $('#testmodal').modal('show');
        $("#testmodalbody").html("");
        $("#testmodalbody").load("api/load_samplelist_test.jsp?id="+RowId, function() {
            //fillSendModal1(myGrid,RowId);
          $o = $("#frmtestmodal select[name=testparent]");
          $o.select2({
        allowClear: true,
        formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
        formatNoMatches: function () {return "<%=trs.t("ტესტი არ მოიძებნა")%>";},
        escapeMarkup: function (markup) {return markup;}
        });
        });
    });
    
    
    $(document).on("change", "input[name='sendoutside']", function () {
        if ($(this).is(":checked")) {
            $(".con5").show();
            $(".con4").hide();
        } else {
            $(".con5").hide();
            $(".con4").show();
        }
        departamentid2select("frmsendmodal",$('#frmsendmodal input[name=id]').val());
    });
    
    $(document).on("change", "input[name=itemaction]", function () {
        var id = $("input[name=itemaction]:checked").val();
        if (id == "1") {
            $(".con1").show();
            $(".con2").hide();
            $(".con3").hide();
        } else if (id == "2") {
            $(".con1").show();
            $(".con2").show();
            $(".con3").hide();
        } else if (id == "3") {
            $(".con1").show();
            $(".con2").hide();
            $(".con3").show();
        }
    });
    
    $("#frmfilter").keypress(function(e) { 
        if(e.keyCode == 13) {
            var op = $(this).serialize();
            $("#list<%=gridname%>").jqGrid('setGridParam',{url:'content/get<%=gridname%>list.jsp?'+op}).trigger("reloadGrid");
        }
    })
    
    function printForm1(){
        var myGrid = $('#list<%=gridname%>');
        var RowId = myGrid.jqGrid('getGridParam', 'selrow');
        if (RowId===null)
            alertError('<%=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        else
        {
            printReport("F-138-2016-G", RowId)
        }
    }
    
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
                        <label class="input"> <i class="icon-append fa fa-barcode"></i>
                            <input name="barcode" type="text" onkeydown="searchonenter" placeholder="<%=trs.t("ბარკოდი")%>">
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input name="daterange" class="daterangepicker" type="text" onkeydown="searchonenter" placeholder="<%=trs.t("თარიღი")%>">
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input name="num1" type="text" onkeydown="searchonenter" placeholder="<%=trs.t("საველე N")%>">
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-search"></i>
                            <input name="location" type="text" onkeydown="searchonenter" placeholder="<%=trs.t("ადგილმდებარეობა")%>">
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="input"> <i class="icon-append fa fa-institution"></i>
                            <input name="contragentid" type="text" onkeydown="searchonenter" placeholder="<%=trs.t("დამკვეთი")%>">
                        </label>
                    </section>
                </div>
                <div class="col-sm-12">
                    <section class="col col-sm-4">
                        <label class="select">
                            <select id="sampletype" name="sampletype" style="width: 100%;">
                                <option value=""><%=trs.t("ნიმუშის ტიპი")%></option>
                                    <%=sampletypes%>
                           </select>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="select">
                            <select id="speciesid" name="speciesid" style="width: 100%;">
                                <option value=""><%=trs.t("სახეობა")%></option>
                                    <%=species%>
                           </select><i></i>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="select">
                            <select name="statusid" class="select2">
                                <option value=""><%=trs.t("სტატუსი")%></option>
<%
SamplestatusBean[] samsts = SamplestatusManager.getInstance().loadAll();
for(int i=0;i<samsts.length; i++)
    out.print("<option value="+samsts[i].getSamplestatusid()+">"+trs.t(samsts[i].getName())+"</option>");
%>
                            </select>
                        </label>
                    </section>
                    <button class="btn btn-info pull-right" style="margin-right: 5px; margin-bottom: 0px;" id="clearfilter"><i class="fa fa-times"></i> <%=trs.t("გასუფთავება")%></button>
                    <button class="btn btn-success pull-right" style="margin-right: 5px;" id="startfilter"><i class="fa fa-search"></i> <%=trs.t("ძებნა")%></button>
                </div>
    </form>
            </div>
        </div>
    </div>
</section>
<div class="col-md-12 btn-panel">
    <button class="btn btn-primary pull-left" onclick="printForm1();"><i class="fa fa-print"></i> <%=trs.t("შიდა ფორმა")%></button>
    
    <%--button class="btn btn-success pull-right" onclick="setTest();"><i class="fa fa-flask"></i> <%=trs.t("ტესტის დანიშვნა")%></button>
    <button class="btn btn-warning pull-right" onclick="setPlate();"><i class="fa fa-object-group"></i> <%=trs.t("ტესტის მომზადება")%></button--%>
    <button class="btn btn-primary pull-right" onclick="setAliq();"><i class="fa fa-book"></i> <%=trs.t("ალიქვოტი/დერივატი")%></button>
    <button class="btn btn-success pull-right" onclick="setSend();"><i class="fa fa-plane"></i> <%=trs.t("გადაცემა")%></button>
</div>
<div class="table-size13 active">
    <table id="list<%=gridname%>"></table>
    <div id="pager<%=gridname%>"></div>
</div>
<div class="modal fade" id="banmodal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
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
<form id="frmbanmodal" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden" value="status">
<input name="status" type="hidden" value="2">
<input name="id" type="hidden">
                    <section class="col col-sm-12">
                        <label class="label"><%=trs.t("დაწუნების მიზეზი")%></label>
                        <label class="textarea"> <i class="icon-append fa fa-info"></i>
                            <textarea name="reason"></textarea>
                        </label>
                    </section>
</form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("გაუქმება")%></button>
                <button type="button" class="btn btn-warning" onclick="saveForm('banmodal')"><%=trs.t("დაწუნება")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="destroymodal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("განადგურება")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
<form id="frmdestroymodal" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden" value="status">
<input name="status" type="hidden" value="3">
<input name="id" type="hidden">
                    <section class="col col-sm-12">
                        <label class="label"> <%=trs.t("მეთოდი")%></label>
                        <label class="select">
                            <select name="method" style="width:100%;">
                                <option value=""></option>
<%
DestroymethodBean[] dms = DestroymethodManager.getInstance().loadAll();
for(int i=0;i<dms.length; i++)
    out.print("<option value="+dms[i].getDestroymethodid()+">"+trs.t(dms[i].getName())+"</option>");
%>
                            </select>
                        </label>
                    </section>
                    <section class="col col-sm-6">
                        <label class="label"> <%=trs.t("განადგურების თარიღი")%></label>
                        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                            <input name="destroydate" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-6">
                        <label class="label"> <%=trs.t("განადგურების დრო")%></label>
                        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                            <input name="destroytime" type="text">
                        </label>
                    </section>
</form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("გაუქმება")%></button>
                <button type="button" class="btn btn-danger" onclick="saveForm('destroymodal')"><%=trs.t("განადგურება")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ისტორია")%></h4>
            </div>
            <div class="modal-body">
                <article class="col-xs-12 sortable-grid ui-sortable" id="lp1">
                    <div class="tree smart-form">
                        <ul id="historytree"></ul>
                    </div>
                </article>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("დახურვა")%>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="testmodal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ტესტის დანიშვნა")%></h4>
            </div>
            <div class="modal-body">
                <div class='smart-form' id="testmodalbody">
<form id="frmtestmodal" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden" value="gettest">
<input name="id" type="hidden">
                    
                    <section class="col col-sm-12">
                        <label class="label"> <%=trs.t("დეპარტამენტი")%></label>
                        <label class="select">
                            <select name="departamentid1" style="width:100%;"></select>
                        </label>
                    </section>
                    <section class="col col-sm-3">
                        <label class="label"> <%=trs.t("გადაცემის თარიღი")%></label>
                        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                            <input name="senddate1" type="text">
                        </label>
                    </section>
                    
                    <section class="col col-sm-4 con5" style='display: none;'>
                        <label class="label"> <%=trs.t("დამცავი კონტეინერის N")%></label>
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input name="container1" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-12 con5" style='display: none;'>
                        <label class="label"> <%=trs.t("ტრანსპ. პასუხისმგებელი პირები")%></label>
                        <label class="input"> <i class="icon-append fa fa-users"></i>
                            <input name="personells1"  type="text">
                        </label>
                    </section>
                    <section class="col col-sm-12 con5">
                        <label class="label"> <%=trs.t("გადაგზავნის მიზეზი")%></label>
                        <label class="input"> <i class="icon-append fa fa-comment"></i>
                            <input name="sendreason1" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-12 con5">
                        <label class="label"> <%=trs.t("გადატანის პირობები")%></label>
                        <label class="input"> <i class="icon-append fa fa-comment"></i>
                            <input name="sendcondition1" type="text">
                        </label>
                    </section>



                    <section class="col col-sm-12">
                        <label class='label'><%=trs.t("კვლევა")%></label>
                        <label class="select">
                            <select name="testparent" class="onchange" style="width:100%;"></select>
                        </label>
                    </section>
                    <section class="col col-sm-12 controls0" style="display: none;">
                        <label class='label'><%=trs.t("ტესტები")%></label>
                        <label class="select">
                            <select name="testchild" class="test-list1" style="width:100%;">
                            </select>
                        </label>
                    </section>
                    <section class="col col-sm-12">
                        <div id='test-list'>

                        </div>
                    </section>
</form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("გაუქმება")%></button>
                <button type="button" class="btn btn-success" onclick="saveForm('testmodal')"><%=trs.t("შენახვა")%></button>
            </footer>
        </div>
    </div>
</div>         
<div class="modal fade" id="makemodal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ალიქვოტი/დერივატი")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form" id="makemodalform">
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("გაუქმება")%></button>
                <button type="button" class="btn btn-success" onclick="saveForm('makemodal')"><%=trs.t("შენახვა")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="sendmodal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog  modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("გადაცემა")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
<form id="frmsendmodal" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden" value="transit">
<input name="id" type="hidden">
<input name="tid" type="hidden">
                    <section class="col col-sm-12">
                        <label class="checkbox">
                            <input name="sendoutside" type="checkbox">
                            <i></i><%=trs.t("ტრანზიტი (გარე გადაცემა)")%></label>
                    </section>
                    <section class="col col-sm-12">
                        <label class="label"> <%=trs.t("დეპარტამენტი")%></label>
                        <label class="select">
                            <select name="departamentid" style="width:100%;"></select>
                        </label>
                    </section>
                    <section class="col col-sm-3">
                        <label class="label"> <%=trs.t("გადაცემის თარიღი")%></label>
                        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                            <input name="senddate" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-3 con4">
                        <label class="label"> <%=trs.t("გადაცემის დრო")%></label>
                        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                            <input name="sendtime" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-4 con5" style='display: none;'>
                        <label class="label"> <%=trs.t("დამცავი კონტეინერის N")%></label>
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input name="container" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-12 con5" style='display: none;'>
                        <label class="label"> <%=trs.t("ტრანსპ. პასუხისმგებელი პირები")%></label>
                        <label class="input"> <i class="icon-append fa fa-users"></i>
                            <input name="personells"  type="text">
                        </label>
                    </section>
                    <section class="col col-sm-12 con5">
                        <label class="label"> <%=trs.t("გადაგზავნის მიზეზი")%></label>
                        <label class="input"> <i class="icon-append fa fa-comment"></i>
                            <input name="sendreason" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-12 con5">
                        <label class="label"> <%=trs.t("გადატანის პირობები")%></label>
                        <label class="input"> <i class="icon-append fa fa-comment"></i>
                            <input name="sendcondition" type="text">
                        </label>
                    </section>
                    <%--section class="col col-sm-12">
                        <label class="label"> <%=trs.t("დამატებითი ინფორმაცია")%></label>
                        <label class="input"> <i class="icon-append fa fa-comment"></i>
                            <input class="tagsinput" data-role="tagsinput" name="note"  type="text">
                        </label>
                    </section--%>   
</form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("გაუქმება")%></button>
                <button id="savesendmodal" type="button" class="btn btn-success" onclick="saveForm('sendmodal')"><%=trs.t("შენახვა")%></button>
                <button id="delsendmodal" style="display: none;" type="button" class="btn btn-danger" onclick="delSend()"><%=trs.t("წაშლა")%></button>
                <button type="button" class="btn btn-primary" onclick="savePrintForm('sendmodal','F-002-2016-G')"><%=trs.t("ბეჭდვა")%></button>
            </footer>
        </div>
    </div>
</div>
                
                
<script>
$(document).on("click", "#clearfilter", function (e) {e.preventDefault();$(this).closest('form').find("input[type=text], textarea").val(""); $("#list<%=gridname%>").jqGrid('setGridParam',{url:'content/get<%=gridname%>list.jsp'}).trigger("reloadGrid"); });
$(document).on("click", "#startfilter", function (e) {
    e.preventDefault();
    $("#list<%=gridname%>").jqGrid('setGridParam',{
        url:'content/get<%=gridname%>list.jsp?'+$(this).closest('form').serialize()}).trigger("reloadGrid"); 
});
function setTest() {
    var myGrid = $('#list<%=gridname%>');
    var RowId = myGrid.jqGrid('getGridParam', 'selarrrow');
    if (RowId.length==0)
        alertError('<%=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
    else
    {
        $('#testmodal').modal('show');
        $("#testmodalbody").html("");
        $("#testmodalbody").load("api/load_samplelist_test.jsp?id="+RowId.join(","), function() {
          $o = $("#frmtestmodal select[name=testparent]");
          $o.select2({
        allowClear: true,
        formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
        formatNoMatches: function () {return "<%=trs.t("ტესტი არ მოიძებნა")%>";},
        escapeMarkup: function (markup) {return markup;}
          });
          });
        //testparent2select("frmtestmodal",RowId);
        //$("#frmtestmodal input[name=id]").val(RowId);
    }
}

function setPlate(){
    //var myGrid = $('#list< %=gridname%>');
    //var RowId = myGrid.jqGrid('getGridParam', 'selarrrow');
    //if (RowId.length==0)
    //    alertError('< %=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'< %=trs.t("დახურვა")%>');
    //else
    {
        BootstrapDialog.show({
            title: 'ნიმუშების მომზადება',
            size: BootstrapDialog.SIZE_WIDE,
            resizable: false,
            modal: true,
            draggable: false,
            closeOnEscape: false,
            message: function(dialog){
                var $message = $('<div></div>');
                $message.load("content/getdevicemap1.jsp");
                return $message;
            },
            buttons: [{
                id: 'btn-cancel',
                icon: 'fa fa-print',
                label: ' ბეჭდვა',
                cssClass: 'btn-primary', 
                autospin: false,
                action: function(dialogRef){
                    var values = Array();
                    $(".wellval").each(function( index ) {
                        var o = new Object();
                        o.wellno = $( this ).attr("title");
                        o.barcode = $(this).attr("set");
                        if(o.barcode === undefined)
                            o.barcode = '';
                        values[index] = o;
                    });
                    $.post("content/saveplate.jsp",{
                        platename: $("#platename").val(),
                        pateid: $("#plateid").val(),
                        platetemplateid: $("#platetemplateid").val(),
                        values: JSON.stringify(values),
                        print: true,
                        labtestid: $("#labtestid").val()
                    },function(data){
                        if(data.result == 0)    alert(data.error);
                        else window.open(data.fname);
                    },"json");
                    dialogRef.close();
                }
            },{
            id: 'btn-cancel',
            icon: 'fa fa-save',
            label: ' შენახვა',
            cssClass: 'btn-success', 
            autospin: false,
            action: function(dialogRef){
                var values = Array();
                $(".wellval").each(function( index ) {
                    var o = new Object();
                    o.wellno = $( this ).attr("title");
                    o.barcode = $(this).attr("set");
                    if(o.barcode === undefined)
                        o.barcode = '';
                    values[index] = o;
                });
                
                $.post("content/saveplate.jsp",{
                    platename: $("#platename").val(),
                    pateid: $("#plateid").val(),
                    platetemplateid: $("#platetemplateid").val(),
                    values: JSON.stringify(values)
                },function(data){
                    if(data.result == 0)    alert(data.error);
                    else alert("მონაცემები წარმატებით შეინახა");
                },"json");
                
            }
            },{
            id: 'btn-cancel',
            icon: 'fa fa-times',
            label: ' დახურვა',
            cssClass: 'btn-danger', 
            autospin: false,
            action: function(dialogRef){
                dialogRef.close();
            }
            }
            ]
        });
    }
}

function setAliq() {
    var myGrid = $('#list<%=gridname%>');
    var RowId = myGrid.jqGrid('getGridParam', 'selarrrow');
    if (RowId.length==0)
        alertError('<%=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
    else
    {
        $('#makemodal').modal('show');
        $("#makemodalform").load("api/load_aliquote_derivate_form.jsp?id="+RowId, function() {
            derivate2select("frmmakemodal",RowId);
            $("#frmmakemodal input[name=id]").val(RowId);
            $("#frmmakemodal input[name=number]").val("");
        });
    }
}

function fillSendModal(myGrid,RowId){
    $.post(
        "api/getpar.jsp",
        {
            oper: "transititem",
            ids: RowId.join()
        },
        function(data){
            if(data.result == 0){
                $("#sendmodal").modal("hide");
                alertError(data.error,"",'<%=trs.t("დახურვა")%>');
            } else {
                if(data.transit == 1){
                    if(!$("#frmsendmodal input[name=sendoutside]").is(":checked"))
                        $("#frmsendmodal input[name=sendoutside]").trigger("click");
                } console.log("data.ids = "+data.ids);
                $("#frmsendmodal input[name=id]").val(data.ids);
                $("#frmsendmodal input[name=senddate]").val(data.senddate);
                $("#frmsendmodal input[name=sendtime]").val(data.sendtime);

                $("#frmsendmodal select[name=departamentid]").val(data.departamentid).trigger('change');

                $("#frmsendmodal input[name=container]").val(data.container);
                $("#frmsendmodal input[name=personells]").val(data.personells);
                $("#frmsendmodal input[name=sendreason]").val(data.sendreason);
                $("#frmsendmodal input[name=sendcondition]").val(data.sendcondition);
                //$("#frmsendmodal input[name=tid]").val(data.tid);
//console.log(data.tid);
                var rowArray = data.ids.split(",");
                $.each(rowArray, function(_, rowId) {
                    myGrid.setSelection(rowId, false);
                });
                $("#frmsendmodal input[name=senddate]").datepicker({format: 'dd/mm/yyyy'});
                $("#frmsendmodal input[name=sendtime]").clockpicker({donetext: 'Done',twelvehour: false,autoclose: true});
                
                if(data.canedit == 1){
                    $("#savesendmodal").show();
                } else {
                    $("#savesendmodal").hide();
                }
                if(data.candelete == 1){
                    $("#delsendmodal").show();
                } else {
                    $("#delsendmodal").hide();
                }
            }
        },
        "json"
    );
}


function fillSendModal1(myGrid,RowId){
    $.post(
        "api/getpar.jsp",
        {
            oper: "transititem",
            ids: RowId
        },
        function(data){
            if(data.result == 0){
                
                alertError(data.error,"",'<%=trs.t("დახურვა")%>');
            } else {
                
                $("#frmtestmodal input[name=senddate1]").val(data.senddate);
                

                $("#frmtestmodal select[name=departamentid1]").val(data.departamentid).trigger('change');

                $("#frmtestmodal input[name=container1]").val(data.container);
                $("#frmtestmodal input[name=personells1]").val(data.personells);
                $("#frmtestmodal input[name=sendreason1]").val(data.sendreason);
                $("#frmtestmodal input[name=sendcondition1]").val(data.sendcondition);
                //$("#frmsendmodal input[name=tid]").val(data.tid);
//console.log(data.tid);
                var rowArray = data.ids.split(",");
                $.each(rowArray, function(_, rowId) {
                    myGrid.setSelection(rowId, false);
                });
                $("#frmtestmodal input[name=senddate1]").datepicker({format: 'dd/mm/yyyy'});
                $("#frmtestmodal input[name=sendtime1]").clockpicker({donetext: 'Done',twelvehour: false,autoclose: true});
                
                
            }
        },
        "json"
    );
}

function setSend() {
    var myGrid = $('#list<%=gridname%>');
    var RowId = myGrid.jqGrid('getGridParam', 'selarrrow');
    if (RowId.length==0)
        alertError('<%=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
    else
    {
        $('#sendmodal').modal('show');
        setTimeout(function(){
            departamentid2select("frmsendmodal",RowId[0]);
            setTimeout(function(){fillSendModal(myGrid,RowId);},500);
        },500)
    }
}

function cdDelConfirm(rs) {
  if (rs===true)
  {
    var myGrid = $('#list<%=gridname%>');
    var RowId = myGrid.jqGrid('getGridParam', 'selrow');
    value = myGrid.jqGrid ('getCell', RowId, 'id');
    sendRequest("api/delobject.jsp",{obj:"objact",id: value},cbDeleteAct);
  }
}

$(document).on("click", ".showban", function () {
    $("#frmbanmodal input[name=id]").val($(this).attr("data-itemid"));
    $("#frmbanmodal textarea[name=reason]").val("");
    $("#banmodal").modal("show");

});
$(document).on("click", ".showdestroy", function () {
    var cd = new Date();
    var id = $(this).attr("data-itemid");
    $("#destroymodal").modal("show");
    $("#frmdestroymodal input[name=id]").val(id);
    destroyid2select("frmdestroymodal",id);
    $("#frmdestroymodal input[name=destroydate]").val(cd.getDate() + "/"+ ("0" + (cd.getMonth()+1)).slice(-2) + "/"+ cd.getFullYear());
    $("#frmdestroymodal input[name=destroytime]").val(cd.getHours() + ":"+ cd.getMinutes());
    $("#frmdestroymodal input[name=destroydate]").datepicker({format: 'dd/mm/yyyy'});
    $("#frmdestroymodal input[name=destroytime]").clockpicker({
	donetext: 'Done',
        twelvehour: false,
        autoclose: true
        });
});
$(document).on("click", ".showinfo", function () {
    $("#historytree").html("");
    $("#historytree").load("api/gethistory.jsp?id="+$(this).attr("data-itemid"))
    $("#infoModal").modal("show");
});

function select2sample(opt)
{
//  $o =$("#frmfilter select[name=sampletype]");
  $o =$("#sampletype");
  /*
  opt = (typeof opt !== 'undefined') ? opt :[];
  var output = [];
  output.push('<option value=""><%=trs.t("ნიმუში")%></option>');
  $.each(opt, function(i,v) {output.push('<option value="'+ v.id +'">'+ v.name +'</option>');});
  $o.html(output.join(''));
  */
  $o.select2({allowClear: true,
    formatNoMatches: function () {return "<%=trs.t("ნიმუში არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
   }); 
}
/*
function contragentid2select(form) {
    $("#"+form+" input[name=contragentid]").select2({
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
        
        
        
        formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> < %=trs.t("მიმდინარეობს ძიება")%> </span>"},
        formatInputTooShort: function () {return "< %=trs.t("შეიტანეთ დამკვეთის დასახელება ან ნომერი")%>";},
        formatNoMatches: function () {return "< %=trs.t("დამკვეთი არ მოიძებნა")%>";},
        escapeMarkup: function (markup) {return markup;}
    });
}
*/

function departamentid2select(form,pid) {
  var transit = false;
  if($('input[name=sendoutside]:checked').length>0)
      transit = true;
  
  $.getJSON("api/getobject.jsp?obj=departamentlist&sampleitemid="+pid+"&transit="+transit, function (opt) {
    $o = $("#"+form+" select[name=departamentid]");
    $o.select2('destroy').empty();
    $o.append($('<option>').text("").attr('value', ""));
    $.each(opt.data, function(i, v) {$o.append($('<option>').text(v.text).attr('value', v.id));});
    
    $o.select2({
        allowClear: true,
        formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
        formatNoMatches: function () {return "<%=trs.t("დეპარტამენტი არ მოიძებნა")%>";},
        escapeMarkup: function (markup) {return markup;}
        });
    
  });
}

function destroyid2select(form,pid) {
    $o = $("#"+form+" select[name=method]");
    $o.select2({
        allowClear: true,
        formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
        formatNoMatches: function () {return "<%=trs.t("მეთოდი არ მოიძებნა")%>";},
        escapeMarkup: function (markup) {return markup;}
        });
}
function testparent2select (form,pid) {
  $.getJSON("api/getobject.jsp?obj=testlist&sampleitemid="+pid, function (opt) {
    $o = $("#"+form+" select[name=testparent]");
    $o.select2('destroy').empty();
    $o.append($('<option>').text("").attr('value', ""));
    $.each(opt.data, function(i, v) {$o.append($('<option>').text(v.text).attr('value', v.id));});
    
    $o.select2({
        allowClear: true,
        formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
        formatNoMatches: function () {return "<%=trs.t("ტესტი არ მოიძებნა")%>";},
        escapeMarkup: function (markup) {return markup;}
        });
    
  });
}
function derivate2select(form,pid) {
return;
  $.getJSON("api/getobject.jsp?obj=departamentlist&sampleitemid="+pid, function (opt) {
    $o = $("#"+form+" select[name=departamentid]");
    $o.select2('destroy').empty();
    $o.append($('<option>').text("").attr('value', ""));
    $.each(opt.data, function(i, v) {$o.append($('<option>').text(v.text).attr('value', v.id));});
    
    $o.select2({
        allowClear: true,
        formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
        formatNoMatches: function () {return "<%=trs.t("დეპარტამენტი არ მოიძებნა")%>";},
        escapeMarkup: function (markup) {return markup;}
        });
    
  });
}
$(function(){
//contragentid2select("frmfilter");
departamentid2select("frmsendmodal","");
select2sample();
});


function saveForm(frm) {
    showLoader();
    var form = $("#frm"+frm)[0];
    $.ajax({
        type: "POST",
        url: form.action,
        data: $(form).serialize(),
        dataType: "json"
    }).done(function(rs) { 
        hideLoader();
        if (rs.status=='ER')
        {
            alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
        }
        else
        {
            alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
            $("#"+frm).modal("hide");
            $('#list<%=gridname%>').trigger( 'reloadGrid' );
        }
    }).fail(function(xhr, textStatus, errorThrown) {
        hideLoader(); 
        alertError('<%=trs.t("შეცდომა")%>',textStatus,'<%=trs.t("დახურვა")%>');
    });
}

function savePrintForm(frm,reportname) {
    showLoader();
    var form = $("#frm"+frm)[0];
    $.ajax({
        type: "POST",
        url: form.action,
        data: $(form).serialize(),
        dataType: "json"
    }).done(function(rs) { 
        hideLoader();
        if (rs.status=='ER')
        {
            alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
        }
        else
        {
            //alertMessage(rs.message,'','< %=trs.t("დახურვა")%>');
            //$("#"+frm).modal("hide");
            $('#list<%=gridname%>').trigger( 'reloadGrid' );
            printReport(reportname,rs.data);
        }
    }).fail(function(xhr, textStatus, errorThrown) {
        hideLoader(); 
        alertError('<%=trs.t("შეცდომა")%>',textStatus,'<%=trs.t("დახურვა")%>');
    });
}

function delSend(){
    $.post("api/getpar.jsp",{ oper: "delete", ids: $("#frmsendmodal input[name=tid]").val() },function(data){ 
        if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
        else {
            $('#list<%=gridname%>').trigger( 'reloadGrid' );
            $("#sendmodal").modal("hide");
        }
    },"json");
}

function printForm(frm,reportname) {
    showLoader();
    var form = $("#frm"+frm)[0];
    $.ajax({
        type: "POST",
        url: form.action,
        data: $(form).serialize(),
        dataType: "json"
    }).done(function(rs) { 
        hideLoader();
        if (rs.status=='ER')
        {
            alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
        }
        else
        {
            //alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
            $("#"+frm).modal("hide");
            $('#list<%=gridname%>').trigger( 'reloadGrid' );
            printReport(reportname,rs.data);
        }
    }).fail(function(xhr, textStatus, errorThrown) {
        hideLoader(); 
        alertError('<%=trs.t("შეცდომა")%>',textStatus,'<%=trs.t("დახურვა")%>');
    });
}

    $(document).on("change", "select[name=testparent]", function () {
        var id=$(this).val();
        if (id != "") {
            $.getJSON("api/getobject.jsp?obj=testgroup&id="+id, function (opt) {
                $("#sectestchild").hide();
                $("#testchild-list").html("");
                $o = $("select[name=testchild]");
                $o.select2('destroy').empty();
                $o.append($('<option>').text("").attr('value', ""));
                if (opt.data.length==0)
                    return;
                $("#sectestchild").show();
                $.each(opt.data, function(i, v) {$o.append($('<option>').text(v.text).attr('value', v.id));});
                $o.select2({
                    allowClear: true,
                    formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
                    formatNoMatches: function () {return "<%=trs.t("ტესტი არ მოიძებნა")%>";},
                    escapeMarkup: function (markup) {return markup;}
                    });
            });
        }
    });
</script>
