<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
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


            jQuery("#list1").jqGrid(
                    {
                        url: 'content/getlevellist.jsp?pid=0',
                        datatype: "json",
                        colNames: ['<%=trs.t("მენიუ")%>', '<%=trs.t("ქვემენიუ")%>', '<%=trs.t("წაკითხვა")%>', '<%=trs.t("რედაქტირება")%>', '<%=trs.t("ბეჭდვა")%>', '<%=trs.t("ექსპორტი")%>'],
                        colModel: [
                            {name: 'name', index: 'name', editable: false, sortable: false, align: "left", width: 200},
                            {name: 'sname', index: 'sname', editable: false, sortable: false, align: "left", width: 200},
                            {name: 'read', index: 'read', editable: false, sortable: false, align: "center", width: 100},
                            {name: 'write', index: 'write', editable: false, sortable: false, align: "center", width: 100},
                            {name: 'print', index: 'print', editable: false, sortable: false, align: "center", width: 100},
                            {name: 'export', index: 'export', editable: false, sortable: false, align: "center", width: 100}
                        ],
                        rowNum: 2000,
                        height: 460,
                        autowidth: true,
                        rowList: [],
                        pager: jQuery('#pager1'),
                        sortname: 'ord',
                        viewrecords: true,
                        sortorder: "asc",
                        pgbuttons: false,
                        pgtext: null,
                        grouping: true,
                        groupingView: {
                            groupField: ['name'],
                            groupColumnShow: [false],
                            groupText: ['<b>{0}</b>'],
                            groupCollapse: false,
                            groupOrder: ['asc'],
                            groupSummary: [true],
                            groupSummaryPos: ['header'],
                            groupDataSorted: true
                        }
                    })
                    .jqGrid('bindKeys')
                    ;

            jQuery("#list2").jqGrid(
                    {
                        url: 'content/getpersonelltypelist.jsp',
                        datatype: "json",
                        colNames: ['<%=trs.t("თანამდებობა")%>', '<%=trs.t("აღწერა")%>', '<%=trs.t("კოდი")%>'],
                        colModel: [
                            {name: 'name', index: 'name', editable: true, align: "left", width: 200},
                            {hidden: true, name: 'description', index: 'description', editable: true, align: "left", width: 200},
                            {hidden: true, name: 'code', index: 'code', editable: true, align: "left", width: 50}
                        ],
                        rowNum: 2000,
                        height: 460,
                        autowidth: true,
                        rowList: [],
                        pager: jQuery('#pager2'),
                        sortname: 'name',
                        viewrecords: true,
                        sortorder: "asc",
                        editurl: "content/updpersonelltype.jsp",
                        pgbuttons: false,
                        pgtext: null,
                        onSelectRow: function (id, ri, ci) {
                            jQuery("#list1").jqGrid().setGridParam({
                                url: "content/getlevellist.jsp?pid=" + id
                            }).trigger("reloadGrid");
                        }
                    })
                    .jqGrid('bindKeys')
                    ;
            $(".ui-jqgrid-sortable").css('white-space', 'normal');
            $(".ui-jqgrid-sortable").css('height', 'auto');

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
                //setTimeout(function () {
                    jQuery("#list1").jqGrid('setGridWidth', $(".tbl2").width());
                    jQuery("#list2").jqGrid('setGridWidth', $(".tbl1").width());
                //}, 500);
            })
        }
    }

    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);

    function chLevel(pid, mid, st, tp)
    {
        var st1 = $("#rmenu_" + pid + "_" + mid).prop('checked');
        var st2 = $("#wmenu_" + pid + "_" + mid).prop('checked');
        var st3 = $("#pmenu_" + pid + "_" + mid).prop('checked');
        var st4 = $("#emenu_" + pid + "_" + mid).prop('checked');
        if (!st1 && tp == 1) {
            $("#wmenu_" + pid + "_" + mid).prop('checked', false);
            st2 = false;
        }
        if (st2 && tp == 2) {
            $("#rmenu_" + pid + "_" + mid).prop('checked', true);
            st1 = true;
        }
        if (st3 && tp == 3) {
            $("#rmenu_" + pid + "_" + mid).prop('checked', true);
            st1 = true;
        }
        if (st4 && tp == 4) {
            $("#rmenu_" + pid + "_" + mid).prop('checked', true);
            st1 = true;
        }
        $.post("content/updlevel.jsp", {pid: pid, mid: mid, st1: st1, st2: st2, st3: st3, st4: st4}, function (data) { });
    }
</script>
<div class="table-size4">
    <div class="col-sm-4 tbl1">
        <table id="list2"></table>
        <div id="pager2"></div>
    </div>
    <div class="col-sm-8 tbl2">
        <table id="list1"></table>
        <div id="pager1"></div>
    </div>
</div>
