<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%    String gridname = "supplier";
    String ses = "EXPORT_BAR_" + (new Date()).getTime();
    jqexport exp = new jqexport(ses, null, null, "EXPORT_STOP", "content/export_" + gridname + ".jsp", "");
%>
<style>
    #exportreestr {
        line-height: 1.19 !important;
    }
</style>
<%=exp.getExportAttr()%>
<script src="js/plugin/bootstrap-tags/bootstrap-tagsinput.min.js" type="text/javascript"></script>
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript">
    pageSetUp();

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

            var tbldata = [{
                    contr: "მედი ქლაბი",
                    pacient: "გიორგი გიორგაძე",
                    type: "წყლულის შიგთავსი",
                    sender: "ქუთაისის ზდლ",
                    address: "",
                    research: "ბაქტერიოლოგიური, მიკრობიოლოგიური",
                    count: "1",
                    status: "დადასტურებული"
                }];
            jQuery("#reestr").jqGrid({
//                treeGrid: true,
//                treeGridModel: "adjacency",
//                ExpandColumn: "code",
//                treedatatype: "local",
//                datatype: "jsonstring",
//                datastr: tbldata,
                datatype: "local",
                data: tbldata,
                colNames: ['<%=trs.t("დამკვეთი")%>', '<%=trs.t("პაციენტი")%>', '<%=trs.t("ნიმუშ(ებ)ის ტიპი")%>', '<%=trs.t("გამომგზავნი დაწესებულება")%>', '<%=trs.t("მისამართი")%>', '<%=trs.t("მოთხოვნილი გამოკვლევა")%>', '<%=trs.t("ნიმუშების რაოდენობა")%>', '<%=trs.t("სტატუსი")%>'],
                colModel: [
                    {name: 'contr', index: 'contr', editable: true, align: "left", width: 100},
                    {name: 'pacient', index: 'pacient', editable: true, align: "left", width: 100},
                    {name: 'type', index: 'type', editable: true, align: "left", width: 100},
                    {name: 'sender', index: 'sender', editable: true, align: "left", width: 100},
                    {name: 'address', index: 'address', editable: true, align: "left", width: 100},
                    {name: 'research', index: 'research', editable: true, align: "left", width: 100},
                    {name: 'count', index: 'count', editable: true, align: "left", width: 100},
                    {name: 'status', index: 'status', editable: true, align: "left", width: 100}
                ],
                rowNum: 20,
                height: 300,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagerreestr'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updpersonelltype.jsp",
                caption: ''
            })
                    .navGrid('#pagerreestr', {edit: false, add: false, del: false, view: false, search: false},
                            {dataheight: 150, width: 350, closeAfterEdit: true, reloadAfterSubmit: false, afterSubmit: checkStatus}, //  default settings for edit
                            {dataheight: 150, width: 350, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for add
                            {dataheight: 150, width: 350, reloadAfterSubmit: false, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 150, width: 350, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    );



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
                jQuery("#reestr").jqGrid('setGridWidth', $("#content").width() - 10);
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
        $(".table-size13").toggleClass("active");
    });
</script>
<section id="widget-grid" class="" style="padding-right: 5px;">
    <div class="jarviswidget" data-widget-collapsed="true" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false">
        <header>
            <h2><%=trs.t("ფილტრი")%></h2>
        </header>
        <div>
            <div class="smart-form col-sm-12" style="padding: 0;">
                <div class="col-sm-12">
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input placeholder="<%=trs.t("ნიმუშის ჭურჭლის N")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-list-ol txt-color-teal"></i> <%=trs.t("ნიმუშის ჭურჭლის N")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-code"></i>
                            <input placeholder="<%=trs.t("ბარკოდი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-code txt-color-teal"></i> <%=trs.t("ბარკოდი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input placeholder="<%=trs.t("დამცავი კონტეინერი N")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-list-ol txt-color-teal"></i> <%=trs.t("დამცავი კონტეინერი N")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select multiple="" class="select2" placeholder="<%=trs.t("ნიმუშის ტიპი")%>">
                                <option value="0"><%=trs.t("ნიმუშის ტიპი")%></option>
                            </select>
                            <b class="tooltip tooltip-top-right"><%=trs.t("ნიმუშის ტიპი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-user"></i>
                            <input placeholder="<%=trs.t("პაციენტის სახელი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("პაციენტის სახელი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-user"></i>
                            <input placeholder="<%=trs.t("პაციენტის გვარი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("პაციენტის გვარი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select multiple="" class="select2" placeholder="<%=trs.t("სავარაუდო დიაგნოზი")%>">
                                <option value="0"><%=trs.t("დიაგნოზი")%></option>
                            </select>
                            <b class="tooltip tooltip-top-right"><%=trs.t("სავარაუდო დიაგნოზი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-user"></i>
                            <input placeholder="<%=trs.t("დამკვეთი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("დამკვეთი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-institution"></i>
                            <input placeholder="<%=trs.t("გამომგზავნი დაწესებულება")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-institution txt-color-teal"></i> <%=trs.t("გამომგზავნი დაწესებულება")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("გაგზავნის თარიღი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("გაგზავნის თარიღი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("მიღების თარიღი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("მიღების თარიღი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-globe"></i>
                            <input placeholder="<%=trs.t("პროექტი/პროგრამა")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("პროექტი ან პროგრამა")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select multiple="" class="select2" placeholder="<%=trs.t("სტატუსი")%>">
                                <option value="0"><%=trs.t("სტატუსი")%></option>
                            </select>
                            <b class="tooltip tooltip-top-right"><%=trs.t("სტატუსი")%></b>
                        </label>
                    </section>
                    <button class="btn btn-info pull-right" style='margin-right: 5px;' data-original-title="<%=trs.t("გასუფთავება")%>"><i class="fa fa-times"></i></button>
                    <button class="btn btn-success pull-right" style='margin-right: 5px;' data-original-title="<%=trs.t("ძებნა")%>"><i class="fa fa-search"></i></button>
                </div>
            </div>
        </div>
    </div>
</section>
<div class="col-md-12 btn-panel">
    <button class="btn btn-warning pull-right"><i class="fa fa-book"></i> <%=trs.t("შემოწმება")%></button>
    <button class="btn btn-success pull-right"><i class="fa fa-book"></i> <%=trs.t("მიღება")%></button>
</div>
<div class="table-size13 active">
    <table id="reestr"></table>
    <div id="pagerreestr"></div>
</div>