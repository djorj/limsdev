<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
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

            var tbldata = [{
                    id: "1",
                    name: "არაჟანი"
                }, {
                    id: "2",
                    name: "ბიო-სუბსტრატი  (სოკოზე, ჰიდროპონიკაზე სამუშაოდ)"
                }, {
                    id: "3",
                    name: "ბოსტნეული"
                }, {
                    id: "4",
                    name: "ბოსტნეული (ახალი, მწვანე, ფოლლოვანი)"
                }, {
                    id: "5",
                    name: "ბოსტნეული და კართოფილი (ხმელი)"
                }, {
                    id: "6",
                    name: "ბოსტნეული, ბოსტნეული მწვანე და ფოთლოვანი, ახალი, ახლად გაყინული და მათი გადამუშავების პროდუქტები"
                }, {
                    id: "7",
                    name: "ბოსტნეულის ნახევარფაბრიკატები"
                }, {
                    id: "8",
                    name: "ბუნებრივი ხვრელებიდან გამონადენი"
                }, {
                    id: "9",
                    name: "გარნირები"
                }, {
                    id: "10",
                    name: "გარნირი (ბრინჯი, მაკარონის, კარტოფილის და ა.შ.)"
                }, {
                    id: "11",
                    name: "დაზიანებული და ნეკროზული ქსოვილი"
                }, {
                    id: "12",
                    name: "დეზინფექციის ხარისხის განსაზღვრა"
                }, {
                    id: "13",
                    name: "ერბო (ძროხის, გადამდნარი)"
                }, {
                    id: "14",
                    name: "ვაზი"
                }, {
                    id: "15",
                    name: "ვაფლი, თაფლაკვერი"
                }, {
                    id: "16",
                    name: "ზეთების გადამუშავების პროდუქტები(მარგარინები,"
                }];

            jQuery("#samples").jqGrid({
                data: tbldata,
                datatype: "local",
//                treeGridModel: 'adjacency',
//                treeGrid: true,
//                ExpandColumn: 'contact',
                colNames: ['id', '<%=trs.t("დასახელება")%>'],
                colModel: [
                    {name: 'id', index: 'id', width: 1, hidden: true, key: true},
                    {name: 'name', index: 'name', hidden: false, editable: true, sortable: false, align: "left", width: 200, edittype: "text", editoptions: {size: "30"}, editrules: {edithidden: true}}

                ],
                rowNum: 20,
                height: 400,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagersamples'),
                sortname: 'ord',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updsamples.jsp",
                title: "<%=trs.t("ნიმუშები")%>"
            });
            jQuery("#samples").jqGrid('navGrid', "#pagersamples", {
                edit: false,
                add: false,
                del: true,
                view: false,
                search: false
            }).navButtonAdd('#pagersamples', {
                caption: "",
                buttonicon: "ui-icon-1",
                onClickButton: function () {
                    $("#samplesModal").modal("show");
                },
                position: "last"
            }).navButtonAdd('#pagersamples', {
                caption: "",
                buttonicon: "ui-icon-2",
                onClickButton: function () {

                },
                position: "last"
            }).navButtonAdd('#pagersamples', {
                caption: "",
                buttonicon: "ui-icon-3",
                onClickButton: function () {

                },
                position: "last"
            });
            jQuery("#samples").jqGrid('inlineNav', "#pagersamples");

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
                jQuery("#samples").jqGrid('setGridWidth', $("#content").width());
            })


        } // end function


    }

    loadScript("js/plugin/jqgrid/grid.locale-en.min.js", pagefunction);
</script>
<div class="table-size1">
    <table id="samples"></table>
    <div id="pagersamples"></div>
</div>
<div class="modal fade" id="samplesModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ნიმუშები")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form col-sm-12">
                    <section class="col-sm-12">
                        <label class="label"><%=trs.t("დასახელება")%></label>
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
