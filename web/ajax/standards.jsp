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
    
    function getcert(cellvalue, options, rowObject){
        return "<a href='documents/certificate/"+rowObject[3]+"' target='_blank'>"+cellvalue+"</a>";
    }
    function ungetcert(cellvalue, options, cell){
        return cellvalue;
    }

    var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);

        function run_jqgrid_function() {

            jQuery("#standards").jqGrid({
                url: 'content/getstandardlist.jsp',
                datatype: "json",
                colNames: ['<%=trs.t("დასახელება")%>','<%=trs.t("აღწერა")%>','<%=trs.t("სერტიფიკატი")%>',''],
                colModel: [
                    {name: 'name', index: 'name', hidden: false, editable: true, sortable: false, align: "left", width: 200, edittype: "text", editoptions: {size: "30"}, editrules: {edithidden: true, required: true}},
                    {name: 'description', index: 'description', hidden: false, editable: true, sortable: false, align: "left", width: 200, edittype: "textarea", editoptions: {cols: "30", rows: "3"}, editrules: {edithidden: true}},
                    {name:'certificateid',index:'certificateid', editable:true, align:"left", width:200, stype:"select", edittype:"select", formatter:getcert, unformat:ungetcert, editoptions:{dataUrl:'content/gettypes.jsp?nmand=არცერთი&objname=Certificate&cols=Certificateid&cols=Name&where=where companyid = <%=user.getCompanyid()%> order by name',style:'width: 200px;'},searchoptions:{dataUrl:'content/gettypes.jsp?objname=Certificate&cols=Certificateid&cols=Name&where=where companyid = <%=user.getCompanyid()%> order by name',sopt:['eq','ne']}},
                    {name: 'logo', index: 'logo', hidden: true, editable: false, sortable: false, editrules: {edithidden: false}}
                ],
                rowNum: 20,
                height: 400,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagerstandards'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updstandards.jsp",
                title: "<%=trs.t("სტანდარტები")%>"
            })
            .jqGrid('bindKeys')
            .jqGrid('filterToolbar', { searchOnEnter: true, enableClear: true })
            .navGrid("#pagerstandards", {edit:<%=permissions[1]%>,add:<%=permissions[0]%>,del:<%=permissions[2]%>,view:false,search:false},
                        {dataheight:200,width:450,closeAfterEdit:true,reloadAfterSubmit:true,recreateForm:true,afterSubmit:checkStatus,afterShowForm : function (formid) {rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>');} }, //  default settings for edit
                        {dataheight:200,width:450,closeAfterAdd:true,reloadAfterSubmit:true,recreateForm:true,afterSubmit:checkStatus,afterShowForm : function (formid) {rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>');}}, //  default settings for add
                        {closeAfterDelete:true,reloadAfterSubmit:true,afterSubmit:checkStatus},  // delete instead that del:false we need this
                        {multipleSearch:true}, // search options
                        {dataheight:200,width:450,labelswidth:"68%",closeOnEscape:true} /* view parameters*/
                );

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
                jQuery("#standards").jqGrid('setGridWidth', $("#content").width());
            })


        } // end function


    }

    loadScript("js/plugin/jqgrid/grid.locale-en.min.js", pagefunction);
</script>
<div class="table-size1">
    <table id="standards"></table>
    <div id="pagerstandards"></div>
</div>

