<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
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
                    name: "სისხლი",
                    code: "BL"
                }, {
                    name: "სისხლი2",
                    code: "BL2"
                }, {
                    name: "სისხლი3",
                    code: "BL3"
                }, {
                    name: "სისხლი4",
                    code: "BL4"
                }, {
                    name: "სისხლი5",
                    code: "BL5"
                }, {
                    name: "სისხლი6",
                    code: "BL6"
                }];

            jQuery("#ordering").jqGrid({
                data: tbldata,
                datatype: "local",
//                treeGridModel: 'adjacency',
//                treeGrid: true,
//                ExpandColumn: 'contact',
                colNames: ['<%=trs.t("დასახელება")%>', '<%=trs.t("კოდი")%>'],
                colModel: [
                    {name: 'name', index: 'name', hidden: false, editable: true, sortable: false, align: "left", width: 200, edittype: "text", editoptions: {size: "30"}, editrules: {edithidden: true}},
                    {name: 'code', index: 'code', hidden: false, editable: true, sortable: false, align: "left", width: 200, edittype: "text", editoptions: {size: "30"}, editrules: {edithidden: true}}

                ],
                rowNum: 20,
                height: 400,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagerordering'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updordering.jsp",
                title: "<%=trs.t("ანალიზის ჯგუფები")%>"
            });
            jQuery("#ordering").sortableRows();
            jQuery("#ordering").jqGrid('navGrid', "#pagerordering", {
                edit: false,
                add: false,
                del: true,
                view: false,
                search: false
            });
            jQuery("#ordering").jqGrid('inlineNav', "#pagerordering");

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
                jQuery("#ordering").jqGrid('setGridWidth', $("#content").width());
            })


        } // end function


    }

    loadScript("js/plugin/jqgrid/grid.locale-en.min.js", pagefunction);
</script>
<div class="smart-form">
    <label class="select" style="width: 200px; margin-bottom: 15px;">
        <select>
            <option value="0"><%=trs.t("ანალიზის ჯგუფი")%></option>
        </select><i></i> 
    </label>
</div>
<div class="table-size1">
    <table id="ordering"></table>
    <div id="pagerordering"></div>
</div>
