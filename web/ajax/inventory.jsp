<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    
%>
<style>
    
</style>
<div class="table-size8 active">
    <table id="inventory"></table>
    <div id="pinventory"></div>
</div>

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
        } else {
            id = json.id;
            RefreshGridData("analizelist");
        }
        return [retval, msg, id];
    }
    
    function viewInv(id){
        if(id > 0){
            $.post("content/inventoryitem.jsp", { id: id }, function (data) {
                //$("#content").hide("slide", {direction: "right"}, 500);
                //setTimeout(function () {
                    $("#content").html(data);
                //    $('#content').hide().show("slide", {direction: "left"}, 500);
                //}, 500);
            });
        } else alertError('<%=trs.t("შეცდომა")%>',"აირჩიეთ ჩანაწერი",'<%=trs.t("დახურვა")%>');
    }
    
    function closeInv(id){
        if(id > 0){
            ConfirmMessageArg('<%=trs.t("დარწმუნებული ხართ რომ გინდათ აღწერის დახურვა?")%>','<%=trs.t("დახურულ აღწერაში ცვლილებები დაუშვებელია!")%>',['<%=trs.t("გაუქმება")%>','<%=trs.t("დიახ, დარწმუნებული ვარ")%>'],doCloseInv,{id:id});
        } else alertError('<%=trs.t("შეცდომა")%>',"აირჩიეთ ჩანაწერი",'<%=trs.t("დახურვა")%>');
    }
    
    function doCloseInv(result,id){
        if(result){
            $.post("content/updinventory.jsp", { id: id.id, oper: 'close' }, function (data) {
                if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                else                    $("#inventory").trigger("reloadGrid");
            });
        }
    }
    
    var scrollPosition = 0;

    function RefreshGridData(id) {
        scrollPosition = jQuery("#"+id).closest(".ui-jqgrid-bdiv").scrollTop()
        $("#"+id).trigger("reloadGrid");
    }

    var pagefunction = function () {
      loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);
      function run_jqgrid_function() {

      //$(".bootstrap-datetimepicker-widget").css("z-index","")


      jQuery("#inventory").jqGrid({
        url: 'content/getinventorylist.jsp',
        datatype: "json",
        colNames: ['<%=trs.t("თარიღი")%>','<%=trs.t("საწყობი")%>', '<%=trs.t("ავტორი")%>', '<%=trs.t("სტატუსი")%>', 'closed'],
        colModel: [
                    
                    {name: 'inventorydate', index: 'inventorydate', editable: true, edittype: 'text', editrules: { required: true}, editoptions: {size: 16, maxlengh: 16, dataInit: function(element) {$(element).val("<%=dtlong.format(new Date().getTime())%>")}}, searchoptions: {dataInit: function(element) {$(element).daterangepicker()}}},
                    {name: 'institutionid', index: 'institutionid', editable: true, align: "left", edittype: "select", editoptions: {dataUrl:'content/getlablistselect.jsp', style:"width: 200px;"}, editrules: {edithidden: true, required: true}, search: true, stype:"select",searchoptions:{dataUrl:'content/getlablistselect.jsp'}},
                    {name: 'regbyid', index: 'regbyid', editable: false, align: "left"},
                    {name: 'status', index: 'status', editable: false, align: "left"},
                    {name: 'closed', index: 'closed', hidden:true, editable: false, search: false, editrules:{edithidden:false}}
                ],
                rowNum: 20,
                //height: 350,
                //width: 900,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pinventory'),
                sortname: 'startdate',
                viewrecords: true,
                sortorder: "desc",
                editurl: "content/updinventory.jsp",
                loadComplete: function(){jQuery("#inventory").closest(".ui-jqgrid-bdiv").scrollTop(scrollPosition)},
                onSelectRow: function(id){
                    var closed = $('#inventory').jqGrid('getCell',id,'closed');
                    if(closed == 1){
                        $("#closeinventory").hide();
                        $("#edit_inventory").hide();
                        $("#del_inventory").hide();
                    } else {
                        $("#closeinventory").show();
                        $("#edit_inventory").show();
                        $("#del_inventory").show();
                    }
                }
            })
            .jqGrid('filterToolbar', { searchOnEnter: true, enableClear: true })
            .navGrid('#pinventory', {edit:<%=permissions[1]%>,add:<%=permissions[0]%>,del:<%=permissions[2]%>,view:false,search:false},
                            {dataheight: 250, width: 400, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus,recreateForm:true,afterShowForm : function (formid) {rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>');}}, //  default settings for edit
                            {dataheight: 250, width: 400, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus,recreateForm:true,afterShowForm : function (formid) {rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>');}}, //  default settings for add
                            {closeAfterDelete: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 250, width: 400, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    )
            //.navButtonAdd('#pinventory', {id: 'exportinventory', caption: '<i class="fa fa-file-excel-o"></i> < %=trs.t("ექსპორტი")%>', buttonicon: "none", onClickButton: function () { }, position: 'last'})
            //.navButtonAdd('#pinventory', {id: 'printinventory', caption: '<i class="fa fa-print"></i> < %=trs.t("ბეჭდვა")%>', buttonicon: "none", onClickButton: function () { printInv($('#inventory').jqGrid('getGridParam','selrow')); }, position: 'last'})
            //.navButtonAdd('#pinventory', {id: 'importinventory', caption: '<i class="fa fa-upload"></i> < %=trs.t("იმპორტი")%>', buttonicon: "none", onClickButton: function () { impInv($('#inventory').jqGrid('getGridParam','selrow')); }, position: 'last'})
            .navButtonAdd('#pinventory', {id: 'viewinventory', caption: '<i class="fa fa-folder-open"></i> <%=trs.t("აღწერა")%>', buttonicon: "none", onClickButton: function () { viewInv($('#inventory').jqGrid('getGridParam','selrow')); }, position: 'last'})
            .navButtonAdd('#pinventory', {id: 'closeinventory', caption: '<i class="fa fa-folder"></i> <%=trs.t("დახურვა")%>', buttonicon: "none", onClickButton: function () { closeInv($('#inventory').jqGrid('getGridParam','selrow')); }, position: 'last'})
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
            $("#viewinventory > div").removeClass("btn-primary").addClass("btn-success");
            $("#closeinventory > div").removeClass("btn-primary").addClass("btn-danger");

            $(window).on('resize.jqGrid', function () {
                jQuery("#inventory").jqGrid('setGridWidth', $("#content").width() - 10);
            })
        }
    }

    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);
    
    $(document).on("click", ".jarviswidget-toggle-btn", function () {
        $(".table-size8").toggleClass("active");
    });
    $('.daterangepicker').daterangepicker({
        autoUpdateInput: false,
        locale: {
            format: 'DD/MM/YYYY',
            cancelLabel: '<%=trs.t("გასუფთავება")%>'
        }
    });
    $('.daterangepicker').on('apply.daterangepicker', function (ev, picker) {
        $(this).val(picker.startDate.format('MM/DD/YYYY') + ' - ' + picker.endDate.format('MM/DD/YYYY'));
    });

    $('.daterangepicker').on('cancel.daterangepicker', function (ev, picker) {
        $(this).val('');
    });
    $(document).on("change", ".confcheck", function (){
        $("#confModal").modal("show");
    });
</script>


