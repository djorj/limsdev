<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
%>
<script>
    pageSetUp();

    var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);

        function run_jqgrid_function() {

            var tbldata = [{
                    id: "1",
                    code: "236984567",
                    type: "ნაცხი",
                    analys: "ფრინველის გრიპი - ანტისხეული",
                    lab: "ვირუსოლოგიისა და მოლეკულური ბიოლოგიის ლაბორატორია"
                }, {
                    id: "2",
                    code: "214785239",
                    type: "დაზიანებული და ნეკროზული ქსოვილი",
                    analys: "ნიუკასლი - ანტისხეული ",
                    lab: "ვირუსოლოგიისა და მოლეკულური ბიოლოგიის ლაბორატორია"
                }, {
                    id: "3",
                    code: "226685478",
                    type: "ნაყინი",
                    analys: "ქუ ცხელება - ანტისხეული",
                    lab: "ვირუსოლოგიისა და მოლეკულური ბიოლოგიის ლაბორატორია"
                }];

            jQuery("#aliquotation").jqGrid({
                data: tbldata,
                datatype: "local",
//                treeGridModel: 'adjacency',
//                treeGrid: true,
//                ExpandColumn: 'contact',
                colNames: ['id', '<%=trs.t("ბარკოდი")%>', '<%=trs.t("ნიმუშის ტიპი")%>', '<%=trs.t("კვლევა")%>', '<%=trs.t("ლაბორატოირა")%>', '<%=trs.t("მოქმედება")%>'],
                colModel: [
                    {name: 'id', index: 'id', width: 1, hidden: true, key: true},
                    {name: 'code', index: 'code', hidden: false, editable: true, sortable: false, align: "left", width: 100},
                    {name: 'type', index: 'type', hidden: false, editable: true, sortable: false, align: "left", width: 200},
                    {name: 'analys', index: 'analys', hidden: false, editable: true, sortable: false, align: "left", width: 200},
                    {name: 'lab', index: 'lab', hidden: false, editable: true, sortable: false, align: "left", width: 200},
                    {name: 'act', index: 'act', sortable: false, align: "center", width: 100}

                ],
                rowNum: 20,
                height: 100,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pageraliquotation'),
                sortname: 'ord',
                sortorder: "asc",
                editurl: "content/updaliquotation.jsp",
                title: "<%=trs.t("ნიმუშები")%>",
                gridComplete: function () {
                    var ids = jQuery("#aliquotation").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        be = '<button class="btn btn-danger btn-sm" style="margin-left: 5px;"><i class="fa fa-trash"></i></button>';
                        ce = '<button class="btn btn-info btn-sm showcode" style="margin-left: 5px;"><i class="fa fa-print"></i></button>';
                        de = '<button class="btn btn-default btn-sm countModal" style="margin-left: 5px;"><i class="fa fa-plus"></i></button>';
                        jQuery("#aliquotation").jqGrid('setRowData', ids[i], {
                            act: ce + be + de
                        });
                    }
                }
            }).navGrid('#pageraliquotation', {edit: false, add: false, del: true, view: false, search: false},
                    {dataheight: 450, width: 800, closeAfterEdit: true, reloadAfterSubmit: true}, //  default settings for edit
                    {dataheight: 450, width: 800, closeAfterAdd: true, reloadAfterSubmit: true}, //  default settings for add
                    {closeAfterDelete: true, reloadAfterSubmit: true}, // delete instead that del:false we need this
                    {multipleSearch: true}, // search options
                    {dataheight: 450, width: 800, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
            );
            jQuery("#aliquotation").jqGrid('inlineNav', "#pageraliquotation");

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
            $(".ui-icon.ui-icon-1").removeClass().addClass("fa fa-plus").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");
            $(".ui-icon.ui-icon-2").removeClass().addClass("fa fa-pencil").parent(".btn-primary").removeClass("btn-primary").addClass("btn-warning");
            $(".ui-icon.ui-icon-3").removeClass().addClass("fa fa-trash-o").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");
            $(".ui-icon.ui-icon-trash, .ui-icon.ui-icon-refresh, .ui-icon.ui-icon-plus, .ui-icon.ui-icon-pencil, .ui-icon.ui-icon-disk, .ui-icon.ui-icon-cancel").parent().parent().remove();

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
                jQuery("#aliquotation").jqGrid('setGridWidth', $("#content").width() - 10);
            });


        } // end function


    };

    loadScript("js/plugin/jqgrid/grid.locale-en.min.js", pagefunction);



    $(document).on("click", ".countModal", function () {
        $("#countModal").modal("show");
    });
    $(document).on("change", "#aliq", function () {
        var val = $(this).val();
        $(".aliq-box").append('<span>' + val + ' <i class="fa fa-times r-par"></i></span>');
        $(this).val("0");
    });
    $(document).on("click", ".r-par", function () {
        $(this).parent().remove();
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
                <div class="col-sm-12">
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-code"></i>
                            <input placeholder="<%=trs.t("ბარკოდი")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select multiple="" class="select2" placeholder="<%=trs.t("ნიმუშის ტიპი")%>">
                                <option value="0"><%=trs.t("ნიმუშის ტიპი")%></option>
                            </select>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select multiple="" class="select2" placeholder="<%=trs.t("კვლევა")%>">
                                <option value="0"><%=trs.t("კვლევა")%></option>
                            </select>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select multiple="" class="select2" placeholder="<%=trs.t("ლაბორატოირა")%>">
                                <option value="0"><%=trs.t("ლაბორატოირა")%></option>
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
<div class="table-size5 active">
    <table id="aliquotation"></table>
    <div id="pageraliquotation"></div>
</div>
<div class="modal fade" id="countModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog small text-center">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ნაცხის - ალიქვოტირება")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
                    <section class="col col-md-12">
                        <label class="select">
                            <select id="aliq">
                                <option value="0"><%=trs.t("- აირჩიეთ -")%></option>
                                <option value="ფრინველის გრიპი - ანტისხეული">ფრინველის გრიპი - ანტისხეული</option>
                                <option value="ნიუკასლი - ანტისხეული">ნიუკასლი - ანტისხეული </option>
                                <option value="ქუ ცხელება - ანტისხეული">ქუ ცხელება - ანტისხეული</option>
                                <option value="გადაგზავნა">გადაგზავნა</option>
                            </select> <i></i>
                        </label>
                    </section>
                    <div class="aliq-box">

                    </div>
                </div>
            </div>
            <footer class="modal-footer text-center" style="padding: 10px;">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("გაუქმება")%>
                </button>
                <button type="button" class="btn btn-success" data-dismiss="modal">
                    <%=trs.t("დასრულება")%>
                </button>
            </footer>
        </div>
    </div>
</div>