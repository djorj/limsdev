<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
%>
<section id="widget-grid" class="" style="padding-right: 5px;">
    <div class="jarviswidget" data-widget-collapsed="true" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false">
        <header>
            <h2><%=trs.t("ფილტრი")%></h2>
        </header>
        <div>
            <div class="smart-form col-sm-12" style="padding: 0;">
                <div class="col-sm-12">
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-barcode"></i>
                            <input placeholder="<%=trs.t("ბარკოდი")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                            <input placeholder="<%=trs.t("დასახელება")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("რეგ. თარიღი")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("მიღების თარიღი")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("ჩატარების თარიღი")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("პასუხის თარიღი")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-comment"></i>
                            <input placeholder="<%=trs.t("შენიშვნა")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("კონფ. თარიღი")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("სავარაუდო დას.")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select multiple="" class="select2" placeholder="<%=trs.t("მეთოდი")%>">
                                <option value="0"><%=trs.t("მეთოდი")%></option>
                            </select>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select multiple="" class="select2" placeholder="<%=trs.t("დამკვეთი")%>">
                                <option value="0"><%=trs.t("დამკვეთი")%></option>
                            </select>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select multiple="" class="select2" placeholder="<%=trs.t("ნიმუშის ტიპი")%>">
                                <option value="0"><%=trs.t("ნიმუშის ტიპი")%></option>
                            </select>
                        </label>
                    </section>
                    <button class="btn btn-info pull-right" style="margin-right: 5px;"><i class="fa fa-times"></i> <%=trs.t("გასუფთავება")%></button>
                    <button class="btn btn-success pull-right" style="margin-right: 5px;"><i class="fa fa-search"></i> <%=trs.t("ძებნა")%></button>
                </div>
            </div>
        </div>
    </div>
</section>
<div class="col-md-12 btn-panel">
    <button class="btn btn-info pull-right"><i class="fa fa-print"></i> <%=trs.t("ბეჭდვა")%></button>
    <button class="btn btn-info pull-right"><i class="fa fa-file-excel-o"></i> <%=trs.t("ექსპორტი")%></button>
</div>
<div class="table-size8 active">
    <table id="answers"></table>
    <div id="pageranswers"></div>
</div>
<div class="modal fade" id="confModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("კონფირმაცია")%></h4>
            </div>
            <div class="modal-body">
                <object data="documents/contracts/contracttemplate.pdf" type="application/pdf" width="100%" style="height: calc(100vh - 320px);"><%=trs.t("თქვენ ბრაუზერს არ შეუძლია PDF-ის გახსნა")%></object>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("გაუქმება")%>
                </button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">
                    <%=trs.t("უარყოფა")%>
                </button>
                <button type="button" class="btn btn-success" data-dismiss="modal">
                    <%=trs.t("კონფირმაცია")%>
                </button>
            </footer>
        </div>
    </div>
</div>
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
                    id: "1",
                    code: "ი.მ. აგიგათ მაშოვი - კონტრაქტის N: 25614",
                    name: "",
                    type: "",
                    test: "",
                    regdate: "",
                    getdate: "",
                    enddate: "",
                    result: "",
                    note: "",
                    conf1: '<div class="smart-form"><label class="checkbox cust"><input disabled="" name="checkbox-inline" checked="checked" type="checkbox"><i class="tip" data-original-title="27/07/2016 - 15:00, გიორგი გიორგაძე"></i></label></div>',
                    level: 0, parent: "NULL", isLeaf: false, loaded: true, expanded: true
                }, {
                    id: "2",
                    code: "257844563",
                    name: "1000 მარცვლის მასის განსაზღვრა",
                    type: "",
                    test: "",
                    regdate: "27/07/2016 - 15:00",
                    getdate: "27/07/2016 - 15:00",
                    enddate: "27/07/2016 - 15:00",
                    result: "ზრდა Aრინიშნება",
                    note: "",
                    conf1: '<div class="smart-form"><label class="checkbox cust"><input disabled="" name="checkbox-inline" checked="checked" type="checkbox"><i class="tip" data-original-title="27/07/2016 - 15:00, გიორგი გიორგაძე"></i></label></div>',
                    level: 1, parent: 1, isLeaf: true, loaded: true, expanded: true
                }, {
                    id: "3",
                    code: "257844563",
                    name: "1000 მარცვლის მასის განსაზღვრა",
                    type: "",
                    test: "",
                    regdate: "27/07/2016 - 15:00",
                    getdate: "27/07/2016 - 15:00",
                    enddate: "27/07/2016 - 15:00",
                    result: "ზრდა Aრინიშნება",
                    note: "",
                    conf1: '<div class="smart-form"><label class="checkbox cust"><input class="confcheck" name="checkbox-inline" type="checkbox"><i></i></label></div>',
                    level: 1, parent: 1, isLeaf: true, loaded: true, expanded: true
                }, {
                    id: "4",
                    code: "257844563",
                    name: "1000 მარცვლის მასის განსაზღვრა",
                    type: "",
                    test: "",
                    regdate: "27/07/2016 - 15:00",
                    getdate: "27/07/2016 - 15:00",
                    enddate: "27/07/2016 - 15:00",
                    result: "ზრდა Aრინიშნება",
                    note: "",
                    conf1: '<div class="smart-form"><label class="checkbox cust"><input disabled="" name="checkbox-inline" checked="checked" type="checkbox"><i class="tip" data-original-title="27/07/2016 - 15:00, გიორგი გიორგაძე"></i></label></div>',
                    level: 1, parent: 1, isLeaf: true, loaded: true, expanded: true
                }];

            jQuery("#answers").jqGrid({
                treeGrid: true,
                treeGridModel: "adjacency",
                ExpandColumn: "code",
                treedatatype: "local",
                datatype: "jsonstring",
                datastr: tbldata,
                colNames: ["id", '<%=trs.t("ბარკოდი")%>', '<%=trs.t("დასახელება")%>', '<%=trs.t("ნიმუშის ტიპი")%>', '<%=trs.t("ტესტი")%>', '<%=trs.t("რეგისტრაცია")%>', '<%=trs.t("მიღება")%>', '<%=trs.t("ტესტის დასრულება")%>', '<%=trs.t("შედეგი")%>', '<%=trs.t("შენიშვნა")%>', '<%=trs.t("I დონე")%>'],
                colModel: [
                    {name: 'id', index: 'id', editable: true, align: "left", hidden: true, width: 1},
                    {name: 'code', index: 'code', editable: true, align: "left"},
                    {name: 'name', index: 'name', editable: true, align: "left"},
                    {name: 'type', index: 'type', editable: true, align: "left"},
                    {name: 'test', index: 'test', editable: true, align: "left"},
                    {name: 'regdate', index: 'regdate', editable: true, align: "left"},
                    {name: 'getdate', index: 'getdate', editable: true, align: "left"},
                    {name: 'enddate', index: 'enddate', editable: true, align: "left"},
                    {name: 'result', index: 'result', editable: true, align: "left"},
                    {name: 'note', index: 'note', editable: true, align: "left"},
                    {name: 'conf1', index: 'conf1', editable: true, align: "left"}
                ],
                rowNum: 20,
                height: 350,
                width: 900,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pageranswers'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updanswers.jsp",
                gridComplete: function () {
                    $(".tip").tooltip({
                        container: 'body'
                    });
                }
            })
                    .navGrid('#pageranswers', {edit: false, add: false, del: false, refresh: false, view: false, search: false},
                            {dataheight: 450, width: 800, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for edit
                            {dataheight: 450, width: 800, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for add
                            {closeAfterDelete: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 450, width: 800, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    );

            jQuery("#answers").jqGrid('setGroupHeaders', {
                useColSpanStyle: false,
                groupHeaders: [
                    {startColumnName: 'regdate', numberOfColumns: 4, titleText: '<em>თარიღი</em>'}
                ]
            });

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

            $(".ui-icon.ui-icon-2").removeClass().addClass("fa fa-pencil").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");

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
                jQuery("#answers").jqGrid('setGridWidth', $("#content").width() - 10);
                jQuery("#answersanswer").jqGrid('setGridWidth', 600);
            })
        }
    }

    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);
    $(document).on("click", ".jarviswidget-toggle-btn", function () {
        $(".table-size8").toggleClass("active");
    });
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
    $(document).on("change", ".confcheck", function (){
        $("#confModal").modal("show");
    });
</script>


