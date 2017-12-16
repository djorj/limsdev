<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%

    DeviceBean device = DeviceManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
    LabtestBean[] tests = LabtestManager.getInstance().loadByWhere("order by name");
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
            
        jQuery("#labtestlist").jqGrid(
            {
                url:'content/getdevicelabtestlist.jsp',
                datatype: "json",
                colNames:['დასახელება'],
                colModel:[
                    {name:'name',index:'name', editable:true, align:"left", width:200, edittype:"text", editoptions:{size:"30"}, editrules: {edithidden:true, required:true}}
                ],
                rowNum:20,
                height: 300,
                width:550,
                autowidth: false,
                rowList:[20,50,100],
                pager: jQuery('#plabtestlist'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl:"content/upddevicelabtestlist.jsp",
                title: "<%=trs.t("კვლევები/ტესტები")%>",
                ondblClickRow: function(id, ri, ci) {
                    
                }
            })
            .navGrid('#plabtestlist',{edit:false,add:false,del:<%=permissions[2]%>,view:false,search:false},
                        {dataheight:300,width:400,closeAfterEdit:true,reloadAfterSubmit:true,afterSubmit:checkStatus}, //  default settings for edit
                        {dataheight:300,width:400,closeAfterAdd:true,reloadAfterSubmit:true,afterSubmit:checkStatus}, //  default settings for add
                        {closeAfterDelete:true,reloadAfterSubmit:true,afterSubmit:checkStatus},  // delete instead that del:false we need this
                        {multipleSearch:true}, // search options
                        {dataheight:300,width:400,labelswidth:"68%",closeOnEscape:true} /* view parameters*/
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
                jQuery("#labtestlist").jqGrid('setGridWidth', $("#modal-body").width());
            })
            jQuery("#labtestlist").jqGrid('setGridWidth', $("#modal-body").width());

        } // end function


    }

    loadScript("js/plugin/jqgrid/grid.locale-en.min.js", pagefunction);
    
    
</script>
<div id="smart-form">
    <div class="row">
        <section class="col col-md-8">
            <label class="input"> <i class="icon-append fa fa-flask"></i>
                <input name="labtestname" type="text">
            </label>
        </section>
        <section class="col col-md-4">
            <button type="button" class="btn btn-success" onclick="addnewtest()">
                <%=trs.t("დამატება")%> <span class="fa fa-plus"></span>
            </button>
        </section>
    </div>
    <div class="row">
        <section class="col col-md-12">
            <div class="table-size2 active">
                <table id="labtestlist" width="100%"></table>
                <div id="plabtestlist"></div>
            </div>
        </section>
    </div>
</div>
