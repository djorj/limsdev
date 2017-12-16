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
                            <input placeholder="<%=trs.t("ლოტის N")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                            <input placeholder="<%=trs.t("ბარკოდი")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                            <input placeholder="<%=trs.t("რეაგენტი")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("თარიღი")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-user"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("ვინ ჩაატარა")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                            <input placeholder="<%=trs.t("ნორმატივი")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                            <input placeholder="<%=trs.t("შედეგი")%>" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-12" style="padding: 0;">
                        <button class="btn btn-info pull-right" style="margin-right: 5px;"><i class="fa fa-times"></i> <%=trs.t("გასუფთავება")%></button>
                        <button class="btn btn-success pull-right" style="margin-right: 5px;"><i class="fa fa-search"></i> <%=trs.t("ძებნა")%></button>
                    </section>
                </div>
            </div>
        </div>
    </div>
</section>
<div class="table-size12 active">
    <table id="qcregistry"></table>
    <div id="pagerqcregistry"></div>
</div>
<div class="modal fade" id="qcregistryModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("კვლევები")%></h4>
            </div>
            <div class="modal-body">
                <ul style="list-style: none; padding: 0;">
                    <li><a href="documents/F-005-2016-G (V 08).pdf" target="_blank">21/07/2017 ენტერობაქტერია (Enterobacter sakazakii)</a></li>
                    <li><a href="documents/F-005-2016-G (V 08).pdf" target="_blank">22/07/2017 ენტერობაქტერია (Enterobacter sakazakii)</a></li>
                </ul>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("დახურვა")%>
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
                    number: "3489",
                    code: '<img src="img/code.png" alt="" style="height: 34px;"/>',
                    reag: "",
                    date: "22/05/2017",
                    user: "გიორგი გიორგაძე",
                    norm: "",
                    result: "",
                    count: '<button class="btn btn-default" onclick="showList()">2</button>'
                }, {
                    id: "2",
                    number: "3454",
                    code: '<img src="img/code.png" alt="" style="height: 34px;"/>',
                    reag: "",
                    date: "02/06/2017",
                    user: "გიორგი გიორგაძე",
                    norm: "",
                    result: "",
                    count: '<button class="btn btn-default" onclick="showList()">3</button>'
                }];

            jQuery("#qcregistry").jqGrid({
                treeGrid: true,
                treeGridModel: "adjacency",
                ExpandColumn: "code",
                treedatatype: "local",
                datatype: "jsonstring",
                datastr: tbldata,
                colNames: ["id", '<%=trs.t("ლოტის N")%>', '<%=trs.t("შტრიხკოდი")%>', '<%=trs.t("რეაგენტი")%>', '<%=trs.t("თარიღი/დრო")%>', '<%=trs.t("ვინ ჩაატარა")%>', '<%=trs.t("ნორმატივი")%>', '<%=trs.t("შედეგი")%>', '<%=trs.t("კვლევების რაოდენობა")%>'],
                colModel: [
                    {name: 'id', index: 'id', editable: true, align: "left", hidden: true, width: 1},
                    {name: 'number', index: 'number', editable: true, align: "left"},
                    {name: 'code', index: 'code', editable: true, align: "center"},
                    {name: 'reag', index: 'reag', editable: true, align: "left"},
                    {name: 'date', index: 'date', editable: true, align: "left"},
                    {name: 'user', index: 'user', editable: true, align: "left"},
                    {name: 'norm', index: 'norm', editable: true, align: "left"},
                    {name: 'result', index: 'result', editable: true, align: "left"},
                    {name: 'count', index: 'count', editable: true, align: "center"}
                ],
                rowNum: 20,
                height: 350,
                width: 900,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagerqcregistry'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updqcregistry.jsp"
            })
                    .navGrid('#pagerqcregistry', {edit: false, add: false, del: false, refresh: false, view: false, search: false},
                            {dataheight: 450, width: 800, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for edit
                            {dataheight: 450, width: 800, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for add
                            {closeAfterDelete: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 450, width: 800, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
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
                jQuery("#qcregistry").jqGrid('setGridWidth', $("#content").width() - 10);
            })
        }
    }

    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);
    $(document).on("click", ".jarviswidget-toggle-btn", function () {
        $(".table-size12").toggleClass("active");
    });
    function showList() {
        $("#qcregistryModal").modal("show");
    }
</script>


