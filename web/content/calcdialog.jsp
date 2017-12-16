<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
    
%>
<style>
.ui-autocomplete {
    z-index: 10000 !important;
}

#gview_calcgrid .ui-jqgrid-bdiv{
    height: 300px !important;
}
</style>
<script>
    pageSetUp();
    
    function addProduct(){
        var pid = $("#pid").val();
        if(pid == 0)    alert("აირჩიეთ პროდუქტი");
        else {
            var qty = $("#quantity").val();
            if(qty == '' || isNaN(qty)) alert("არასწორი რაოდენობა: "+qty);
            else
                $.post("content/updcalc.jsp",{ oper: "add", productid: pid, qty: qty, labtestid: <%=labtest.getLabtestid()%> }, function(data){
                    if(data.result == 0)    alert(data.error);
                    else {
                        $("#pid").val(0);
                        $("#productname").val("");
                        $("#quantity").val("");
                        $("#unitname").html("");
                        jQuery("#calcgrid").trigger("reloadGrid");
                    }
                },"json");
        }
    }
    
    function reloadlist10(rowid, result) {
      $("#calcgrid").trigger("reloadGrid"); 
    }
    
    $("#productname").autocomplete({
        source: "content/searchproductname.jsp",
        minLength: 3,
        select: function( event, ui ) {
            $("#pid").val(ui.item.id);
            $("#unitname").html(" "+ui.item.unitname+" ");
            $("#quantity").focus();
            setTimeout(function(){$("#productname").val(ui.item.value)},1000);
        }
    });
    var lastSel;
        jQuery("#calcgrid").jqGrid({
                    url:'content/getcalclist.jsp?labtestid=<%=labtest.getLabtestid()%>',
                    datatype: "json",
                    colNames: ['<%=trs.t("დასახელება")%>', '<%=trs.t("რაოდენობა")%>', '<%=trs.t("ერთეული")%>', '<%=trs.t("ერთ. თვითღირებულება")%>', '<%=trs.t("თვითღირებულება")%>'],
                    colModel: [
                        {width: 200, name: 'productid', index: 'productid', editable: false, align: "left"},
                        {width: 100, name: 'qty', index: 'qty', editable: true, align: "right", edittype:"text",editoptions:{size:"10"},editrules:{required: true,number:true}},
                        {width: 100, name: 'punitid', index: 'punitid', editable: false, align: "left"},
                        {width: 100, name: 'selfprice', index: 'selfprice', editable: false, align: "right"},
                        {width: 100, name: 'price', index: 'price', editable: false, align: "right", edittype:"text"}
                    ],
                    rowNum: 20,
                    height: 200,
                    //width: 900,
                    autowidth: true,
                    rowList: [],
                    pager: jQuery('#pagercalcgrid'),
                    sortname: 'productid',
                    pgbuttons: false,
                    pgtext: null,
                    viewrecords: false,
                    sortorder: "asc",
                    footerrow: true,
                    userDataOnFooter: true,
                    onSelectRow: function(id){
                        if(id && id!==lastSel){
                            $('#calcgrid').restoreRow(lastSel); 
                            lastSel=id;
                        }
                        $('#calcgrid').editRow(id, true,'','','','',reloadlist10); 
                    },
                    editurl: "content/updcalc.jsp?labtestid=<%=labtest.getLabtestid()%>"
                })
                        .navGrid('#pagercalcgrid', {edit:false,add:false,del:<%=permissions[2]%>,view:false,search:false},
                                {dataheight: 230, width: 300, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus,recreateForm:true,afterShowForm : function (formid) {$('.FormElement').on('focusin', function(e) {e.stopPropagation();}); rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>'); }}, //  default settings for edit
                                {dataheight: 230, width: 300, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus,recreateForm:true,afterShowForm : function (formid) {$('.FormElement').on('focusin', function(e) {e.stopPropagation();}); rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>'); }}, //  default settings for add
                                {closeAfterDelete: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, // delete instead that del:false we need this
                                {multipleSearch: true}, // search options
                                {dataheight: 230, width: 300, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                        );

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

        jQuery("#calcgrid").jqGrid('setGridWidth', 900);
	jQuery("#calcgrid").jqGrid('setGridHeight', 200);

    
</script>


<div class="smart-form col-sm-12" style="padding: 0;">
    <div class="col-sm-12">
        <section class="col col-sm-5">
            <label class="input">
                <input placeholder="<%=trs.t("პროდუქტი")%>" type="text" id='productname'>
                <input type='hidden' id='pid' value="0"/>
            </label>
        </section>
        <section class="col col-sm-3">
            <label class="input">
                <input placeholder="<%=trs.t("რაოდენობა")%>" type="text" id='quantity'>
            </label>
        </section>
        <section class="col col-sm-2">
            <label class="label">
                <span class="badge bg-color-blue txt-color-white" id='unitname' style='padding: 10px;'></span>
            </label>
        </section>
        <section class="col col-sm-2">
            <button type="submit" class="btn btn-success" onclick="addProduct()">
                <%=trs.t("დამატება")%> <span class="fa fa-plus"></span>
            </button>
        </section>
    </div>
</div>
        
<table id="calcgrid"></table>
<div id="pagercalcgrid"></div>
