<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%    boolean canwrite = true;
    String ses = "EXPORT_BAR_" + (new Date()).getTime();
    jqexport exp = new jqexport(ses, null, null, "EXPORT_STOP", "content/export_personelltype.jsp", "");
%>
<%=exp.getExportAttr()%>
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

            jQuery("#personelltypelist").jqGrid({
                url: 'content/getpersonelltypelist.jsp',
                datatype: "json",
                colNames: ['<%=trs.t("თანამდებობა")%>', '<%=trs.t("აღწერა")%>', '<%=trs.t("კოდი")%>'],
                colModel: [
                    {name: 'name', index: 'name', editable: true, align: "left", width: 200, edittype: "text", editoptions: {size: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'description', index: 'description', editable: true, align: "left", width: 200, edittype: "textarea", editoptions: {rows: "3", cols: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'code', index: 'code', editable: true, align: "left", width: 50, edittype: "text", editoptions: {size: "8"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}}
                ],
                rowNum: 20,
                height: 400,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#personelltypepager'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updpersonelltype.jsp",
                ondblClickRow: function (id, ri, ci) {
                    jQuery("#personelltypelist").jqGrid('editGridRow', id, {height: 150, width: 350, closeAfterEdit: true, reloadAfterSubmit: false, afterSubmit: checkStatus});
                    return;
                }
            })
                    .navGrid('#personelltypepager', {edit:<%=canwrite%>, add:<%=canwrite%>, del:<%=canwrite%>, view: false},
                            {dataheight: 150, width: 350, closeAfterEdit: true, reloadAfterSubmit: false, afterSubmit: checkStatus}, //  default settings for edit
                            {dataheight: 150, width: 350, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for add
                            {dataheight: 150, width: 350, reloadAfterSubmit: false, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 150, width: 350, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    )
                    .navButtonAdd('#pager1', {caption: '<i class="fa fa-file-excel-o"></i> <%=trs.t("ექსპორტი")%>', buttonicon: 'ui-icon-calculator', onClickButton: function () {
                            <%=exp.getClickCode()%>
                    }, position: 'last'})
                    ;

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
                jQuery("#menulist").jqGrid('setGridWidth', $("#content").width());
            })


        } // end function


    }

    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);
    $(document).on("focus", "#iconname", function () {
        $("#iconsModal").modal("show");
    });
    function setIcon(icon) {
        $("#iconname").val(icon);
        $("#iconsModal").modal("hide");
    }
</script>


<%


%>



<div class="table-size1">
    <table id="personelltypelist" width="100%" align="center"></table>
    <div id="personelltypepager"></div>
</div>
