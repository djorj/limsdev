<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    boolean canwrite = true;
    String colnames = "";
    String colmodel = "";
    for(int i=0;i<langs.length;i++){
        String editable = "false";
        if(i > 0)   {
            colnames += ",";
            colmodel += ",\n";
            editable = "true";
        }
        colnames += "'"+trs.t(langs[i].getName())+"'";
        colmodel += "{name: 'name"+i+"', index: 'name"+i+"', editable: true, sortable: false, align: \"left\", width: 200, edittype: \"text\", editoptions: {size: \"60\"}, editable:"+editable+"}";
    }
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
            var lastSel;
            jQuery("#translationlist").jqGrid({
                url: 'content/gettranslationlist.jsp',
                datatype: "json",
                colNames: [<%=colnames%>],
                colModel: [<%=colmodel%>],
                rowNum: 20,
                height: 400,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagertranslationlist'),
                sortname: 'phrase',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updtranslation.jsp",
                onSelectRow: function(id){
                    if(id && id!==lastSel){ 
                        jQuery('#translationlist').restoreRow(lastSel); 
                        lastSel=id; 
                    }
                    jQuery('#translationlist').editRow(id, true); 
                },
                ondblClickRow: function (id, ri, ci) {
                    jQuery("#translationlist").jqGrid('editGridRow', id, {dataheight: 110, width: 460, closeAfterEdit: true, reloadAfterSubmit: false, afterSubmit: checkStatus});
                    return;
                },
                title: "<%=trs.t("თარგმნა")%>"
            })
            .jqGrid('bindKeys')
            .jqGrid('filterToolbar', { searchOnEnter: true, enableClear: true })
            .navGrid('#pagertranslationlist', {edit:<%=canwrite%>, add:false, del:<%=canwrite%>, view: false, search: false},
                    {dataheight: 110, width: 460, closeAfterEdit: true, reloadAfterSubmit: false, afterSubmit: checkStatus},
                    {dataheight: 110, width: 460, closeAfterAdd: true, reloadAfterSubmit: false, afterSubmit: checkStatus},
                    {dataheight: 110, width: 460, reloadAfterSubmit: true, afterSubmit: checkStatus},
                    {multipleSearch: true},
                    {dataheight: 110, width: 460, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
            )

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
            $(".ui-icon.ui-icon-plus").removeClass().addClass("fa fa-plus").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");;
            $(".ui-icon.ui-icon-pencil").removeClass().addClass("fa fa-pencil").parent(".btn-primary").removeClass("btn-primary").addClass("btn-warning");;
            $(".ui-icon.ui-icon-trash").removeClass().addClass("fa fa-trash-o").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");;
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
    
</script>
<div class="table-size1">
    <table id="translationlist"></table>
    <div id="pagertranslationlist"></div>
</div>

