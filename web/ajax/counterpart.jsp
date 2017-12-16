<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%    boolean canwrite = true;
    FileInputStream fi = new FileInputStream(session.getServletContext().getRealPath("/") + "/icons.json");
    byte[] b = new byte[fi.available()];
    fi.read(b);
    fi.close();
    JSONObject icons = JSONObject.fromObject(new String(b, "UTF-8"));
%>
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

            jQuery("#counterpart").jqGrid({
                url: 'content/getcounterpartlist.jsp',
                datatype: "json",
//                treeGridModel: 'adjacency',
//                treeGrid: true,
//                ExpandColumn: 'contact',
                colNames: ['id', '<%=trs.t("დასახელება")%>', '<%=trs.t("ტიპი")%>', '<%=trs.t("საიდ. კოდი ან პირ. ნომ.")%>', '<%=trs.t("მისამართი")%>', '<%=trs.t("ტელეფონი")%>', '<%=trs.t("ელფოსტა")%>'],
                colModel: [
                    {name: 'id', index: 'id', width: 1, hidden: true, key: true},
                    {name: 'name', index: 'name', hidden: false, editable: true, sortable: false, align: "left", width: 200, edittype: "text", editoptions: {size: "30"}, editrules: {edithidden: true}},
                    {name: 'type', index: 'type', editable: true, sortable: false, align: "left", width: 200, edittype: "text", editoptions: {size: "30"}},
                    {name: 'code', index: 'code', editable: true, sortable: false, align: "left", width: 200, edittype: "text"},
                    {name: 'address', index: 'address', editable: true, sortable: false, align: "left", width: 200, edittype: "text"},
                    {name: 'phone', index: 'phone', editable: true, sortable: false, align: "left", width: 200, edittype: "text"},
                    {name: 'email', index: 'email', editable: true, sortable: false, align: "left", width: 200, edittype: "text"}

                ],
                rowNum: 20,
                height: 400,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagercounterpart'),
                sortname: 'ord',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updcounterpart.jsp",
                title: "<%=trs.t("დამკვეთი")%>"
            });
            jQuery("#counterpart").jqGrid('navGrid', "#pagercounterpart", {
                edit: false,
                add: false,
                del: true,
                view: false,
                search: false
            }).navButtonAdd('#pagercounterpart', {
                caption: "",
                buttonicon: "ui-icon-1",
                onClickButton: function () {
                    $("#counterpartModal").modal("show");
                },
                position: "last"
            }).navButtonAdd('#pagercounterpart', {
                caption: "",
                buttonicon: "ui-icon-2",
                onClickButton: function () {

                },
                position: "last"
            }).navButtonAdd('#pagercounterpart', {
                caption: "",
                buttonicon: "ui-icon-3",
                onClickButton: function () {
                    $("#counterpartinfoModal").modal("show");
                },
                position: "last"
            }).navButtonAdd('#pagercounterpart', {
                caption: "",
                buttonicon: "ui-icon-4",
                onClickButton: function () {

                },
                position: "last"
            });
            jQuery("#counterpart").jqGrid('inlineNav', "#pagercounterpart");

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
            $(".ui-icon.ui-icon-3").removeClass().addClass("fa fa-address-card-o").parent(".btn-primary").removeClass("btn-primary").addClass("btn-info");
            $(".ui-icon.ui-icon-4").removeClass().addClass("fa fa-trash-o").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");
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
                jQuery("#counterpart").jqGrid('setGridWidth', $("#content").width());
            })


        } // end function


    }

    loadScript("js/plugin/jqgrid/grid.locale-en.min.js", pagefunction);
</script>
<div class="table-size1">
    <table id="counterpart"></table>
    <div id="pagercounterpart"></div>
</div>
<div class="modal fade" id="counterpartModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("დამკვეთი")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form pull-left">
                    <section class="col col-6">
                        <label class="label"><%=trs.t("დასახელება")%></label>
                        <label class="input">
                            <input type="text">
                        </label>
                    </section>
                    <section class="col col-6">
                        <label class="label"><%=trs.t("ტიპი")%></label>
                        <label class="select">
                            <select class="dropdown">
                                <option>ტიპი</option>
                            </select>
                        </label>
                    </section>
                    <section class="col col-6">
                        <label class="label"><%=trs.t("საიდ. კოდი ან პირ. ნომ.")%></label>
                        <label class="input">
                            <input type="text">
                        </label>
                    </section>
                    <section class="col col-6">
                        <label class="label"><%=trs.t("მისამართი")%></label>
                        <label class="input">
                            <input type="text">
                        </label>
                    </section>
                    <section class="col col-6">
                        <label class="label"><%=trs.t("ტელეფონი")%></label>
                        <label class="input">
                            <input type="text">
                        </label>
                    </section>
                    <section class="col col-6">
                        <label class="label"><%=trs.t("ელფოსტა")%></label>
                        <label class="input">
                            <input type="text">
                        </label>
                    </section>
                    <div class="col col-xs-12">
                        <h4><%=trs.t("საკონტაქტოები")%></h4>
                        <hr>
                    </div>
                    <section class="col col-6">
                        <label class="label"><%=trs.t("სახელი")%></label>
                        <label class="input">
                            <input type="text">
                        </label>
                    </section>
                    <section class="col col-6">
                        <label class="label"><%=trs.t("გვარი")%></label>
                        <label class="input">
                            <input type="text">
                        </label>
                    </section>
                    <section class="col col-6">
                        <label class="label"><%=trs.t("ტელეფონი")%></label>
                        <label class="input">
                            <input type="text">
                        </label>
                    </section>
                    <section class="col col-6">
                        <label class="label"><%=trs.t("მისამართი")%></label>
                        <label class="input">
                            <input type="text">
                        </label>
                    </section>
                    <section class="col col-6">
                        <label class="label"><%=trs.t("ელფოსტა")%></label>
                        <label class="input">
                            <input type="text">
                        </label>
                    </section>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("გაუქმება")%>
                </button>
                <button type="button" class="btn btn-success" data-dismiss="modal">
                    <%=trs.t("შენახვა")%>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="counterpartinfoModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog small">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("კონტაქტები")%></h4>
            </div>
            <div class="modal-body">
                <div class="col-sm-12">
                    <h1>John <span class="semi-bold">Doe</span></h1>

                    <ul class="list-unstyled">
                        <li>
                            <p class="text-muted">
                                <i class="fa fa-phone"></i>&nbsp;&nbsp;<span>(+995) 599 999 999</span>
                            </p>
                        </li>
                        <li>
                            <p class="text-muted">
                                <i class="fa fa-map-marker"></i>&nbsp;&nbsp;<span class="txt-color-darken">address</span>
                            </p>
                        </li>
                        <li>
                            <p class="text-muted">
                                <i class="fa fa-envelope"></i>&nbsp;&nbsp;<a href="mail@mail.mail">mail@mail.mail</a>
                            </p>
                        </li>
                    </ul>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("დახურვა")%>
                </button>
            </footer>
        </div>
    </div>
</div>
