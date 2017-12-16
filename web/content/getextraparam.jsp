<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
String oper = request.getParameter("oper");
String url = "op="+oper;
if(oper.equalsIgnoreCase("sampletype"))
    url += "&sampletypeid="+request.getParameter("sampletypeid");
else if(oper.equalsIgnoreCase("labtest"))
    url += "&labtestid="+request.getParameter("labtestid");
%>
<style>
    div#gbox_extraparameter.ui-jqgrid .ui-jqgrid-bdiv {
        height: 330px !important;
    }
</style>
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
            jQuery("#extraparameter").jqGrid({
                url:'content/getextraparameterlist.jsp?<%=url%>',
                datatype: "json",
                colNames: ['<%=trs.t("დასახელება")%>','<%=trs.t("აღწერა")%>','<%=trs.t("ტიპი")%>'],
                colModel: [
                    {width: 250, name: 'name', index: 'name', hidden: false, editable: true, sortable: false, align: "left", width: 200, edittype: "text", editoptions: {size: "30"}, editrules: {edithidden: true, required: true}},
                    {width: 450, name: 'description', index: 'description', hidden: false, editable: true, sortable: false, align: "left", width: 200, edittype: "textarea", editoptions: {cols: "30", rows:"3"}, editrules: {edithidden: true}},
                    {width: 100, name: 'restypeid', index: 'restypeid', hidden: false, editable: true, sortable: false, align: "left", edittype: "select", editoptions:{dataUrl:'content/gettypes.jsp?edit=1&objname=Restype&cols=Restypeid&cols=Name&where=order by name', style:"width: 200px;"}}
                ],
                rowNum: 20,
                height: "auto",
                width: 800,
                autowidth: false,
                rowList: [20, 50, 100],
                pager: jQuery('#pagerextraparameter'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updextraparameter.jsp?<%=url%>",
                title: "<%=trs.t("საანალიზო მასალის ტიპები")%>"
            })
            .navGrid('#pagerextraparameter', {edit:<%=permissions[1]%>,add:<%=permissions[0]%>,del:<%=permissions[2]%>,view:false,search:false},
                        {dataheight: 200, width: 400, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus,recreateForm:true,afterShowForm : function (formid) {rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>'); $('.FormElement').on('focusin', function(e) {e.stopPropagation();});}}, //  default settings for edit
                        {dataheight: 200, width: 400, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus,recreateForm:true,afterShowForm : function (formid) {rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>'); $('.FormElement').on('focusin', function(e) {e.stopPropagation();});}}, //  default settings for add
                        {closeAfterDelete: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, // delete instead that del:false we need this
                        {multipleSearch: true}, // search options
                        {dataheight: 200, width: 400, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                )
            ;

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
            $(".ui-icon.ui-icon-4").removeClass().addClass("fa fa-minus").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");

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
                //jQuery("#extraparameter").jqGrid('setGridWidth', 800);
            })


        } // end function


    }

    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);
</script>
<div style="height: 400px !important;">
    <table id="extraparameter" align="center"></table>
    <div id="pagerextraparameter"></div>
</div>