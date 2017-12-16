<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<link href="js/plugin/bootstrap-datepicker/css/datepicker3.css"  rel="stylesheet">
<script src="js/plugin/bootstrap-datepicker/bootstrap-datepicker.js"></script>
<script src="js/plugin/bootstrap-datepicker/locales/bootstrap-datepicker.ka.js"></script>
<script src="js/plugin/clockpicker/clockpicker.min.js"></script>
<style>
.popover.clockpicker-popover{
    z-index: 1050;
}
</style>
<div class="smart-form">
    <div class="row">
        <div class="col col-sm-6" id="inv">
            <table id="invoices" width="100%"></table>
            <div id="pinvoices" style="background-color: white;"></div>
        </div>
        <div class="col col-sm-6" id="invitem">
            <table id="stmv" width="100%"></table>
            <div id="pstmv" style="background-color: white;"></div>
        </div>
    </div>
</div>

<div class="modal fade" id="inputStock" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 id="frmacttitle" class="modal-title"><%=trs.t("მიღების ოპერაცია")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
                        <form id="frmact" enctype="multipart/form-data" action="api/setact.jsp" method="post" accept-charset="UTF-8">               





















        <div class="smart-form col-sm-12" style="padding: 0;">
            <section class="col col-sm-3">
            <label class="label"><%=trs.t("ზედნადების N")%></label>
            <label class="input"> 
                <input type="text" name="invoicenum" id="invoicenum">
            </label>
            </section>
            <section class="col col-sm-3">
            <label class="label"><%=trs.t("ზედნადების თარიღი")%></label>
            <label class="input"> <i class="icon-append fa fa-calendar"></i>
                <input class="dtpicker" type="text" name="invoicedate" id="invoicedate">
            </label>
            </section>
            <section class="col col-sm-3">
            <label class="label"><%=trs.t("ზედნადების ტიპი")%></label>
            <label class="select">
                <select class="select2" name="invoicetype" id="invoicetype">
        <option value=""></option>
<%
    InvoicetypeBean[] invtype = InvoicetypeManager.getInstance().loadAll();
    for (int i=0;  i<invtype.length; i++)
        out.print("<option value=\""+invtype[i].getInvoicetypeid()+"\">"+invtype[i].getName()+"</option>");
%>
                </select> 
            </label>
            </section>
            </div>
                        
            <div class="smart-form col-sm-12" style="padding: 0;">
            <section class="col col-sm-6">
            <label class="label"><%=trs.t("საქონლის დასახელება")%></label>
            <label class="select">
                <input type="hidden" name="productid" id="productid" style="width:100%" />
            </label>
            </section>
            <section class="col col-sm-6">
            <label class="label"><%=trs.t("მომწოდებელი")%></label>
            <label class="select">
                <input type="hidden" name="contragent" id="contragent" style="width:100%" />
            </label>
            </section>
            <section class="col col-sm-3">
            <label class="label"><%=trs.t("რაოდენობა")%></label>
            <label class="input" > <i class="icon-append fa fa-calculator"></i>
                  <input type="text" name="quantity">
            </label>
            </section>
            <section class="col col-sm-3">
            <label class="label"><%=trs.t("ერთ. ფასი")%></label>
            <label class="input"> <i class="icon-append fa fa-money"></i>
                <input type="text" name="price">
            </label>
            </section>
            <section class="col col-sm-3">
            <label class="label"><%=trs.t("ვადა")%></label>
            <label class="input"> <i class="icon-append fa fa-calendar"></i>
                  <input name="expdate1" type="text" class="dtpicker" >
            </label>
            </section>
            <section class="col col-sm-3">
            <label class="label"><%=trs.t("ვადა გახსნამდე")%></label>
            <label class="input"> <i class="icon-append fa fa-calendar"></i>
                  <input name="expdate2" type="text" class="dtpicker" >
            </label>
            </section>
            </div>
            <div class="smart-form col-sm-12" style="padding: 0;">
            <section class="col col-sm-3">
            <label class="label"><%=trs.t("ვადა გახსნის შემდეგ")%></label>
            <label class="input"> <i class="icon-append fa fa-home"></i>
                <input  type="text">
            </label>
            </section>
            <section class="col col-sm-3">
            <label class="label"><%=trs.t("თარო")%></label>
            <label class="input"> <i class="icon-append fa fa-home"></i>
                  <input type="text">
            </label>
            </section>
            <section class="col col-sm-3">
            <label class="label"><%=trs.t("ადგ. თაროზე")%></label>
            <label class="input"> <i class="icon-append fa fa-home"></i>
                <input type="text">
            </label>
            </section>
            <section class="col col-sm-3">
            <label class="label"><%=trs.t("საიდ. კოდი")%></label>
            <label class="input"> <i class="icon-append fa fa-id-card"></i>
                <input placeholder="<%=trs.t("საიდ. კოდი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-id-card txt-color-teal"></i> <%=trs.t("საიდენტიფიკაციო კოდი")%></b>
            </label>
            </section>
            <section class="col col-sm-12">
            <label class="textarea"> <i class="icon-append fa fa-id-card"></i>
            <textarea name="note" placeholder="<%=trs.t("დამატებითი ინფორმაცია")%>"></textarea>
            </label>
            </section>
            </div>
                        </form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i><%=trs.t("გაუქმება")%></button>
                <button type="button" class="btn btn-success" onclick="submitAct(); return false;"><i class="fa fa-plus"></i><%=trs.t("შენახვა")%></button>
            </footer>
        </div>
    </div>
</div>

            
            
            
            
            
            
            
            
            
            
            
            
<div class="modal fade" id="newProduct" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ახალი საქონლის დამატება")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
<form id="frmnewProduct" action="api/setstock.jsp" method="post" accept-charset="UTF-8">               

        <div class="smart-form col-sm-12" style="padding: 0;">
            <section class="col col-sm-12">
            <label class="label"><%=trs.t("ჯგუფი")%></label>
            <label class="select">
                <select name="productgroup" id="productgroup" style="width:100%">
        <option value=""></option>
<%
    ProductgroupBean[] group = ProductgroupManager.getInstance().loadAll();
    for (int i=0;  i<group.length; i++)
        out.print("<option value=\""+group[i].getProductgroupid()+"\">"+group[i].getName()+"</option>");
%>
                </select> 
            </label>
            </section>
            <section class="col col-sm-12">
            <label class="label"><%=trs.t("დასახელება")%></label>
            <label class="input" > <i class="icon-append fa fa-calculator"></i>
                <input name="productname" />
            </label>
            </section>
            <section class="col col-sm-6">
            <label class="label"><%=trs.t("კოდი")%></label>
            <label class="input" > <i class="icon-append fa fa-calculator"></i>
                  <input type="text" name="productcode">
            </label>
            </section>
            <section class="col col-sm-6">
            <label class="label"><%=trs.t("ერთეული")%></label>
            <label class="select">
                <select name="punitid" id="punitid" style="width:100%">
        <option value=""></option>
<%
    PunitBean[] punit = PunitManager.getInstance().loadAll();
    for (int i=0;  i<punit.length; i++)
        out.print("<option value=\""+punit[i].getPunitid()+"\">"+punit[i].getName()+"</option>");
%>
                </select> 
            </label>
            </section>
            </div>
                        </form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><i class="fa fa-times"></i><%=trs.t("გაუქმება")%></button>
                <button type="button" class="btn btn-success" onclick="submitAct(); return false;"><i class="fa fa-plus"></i><%=trs.t("შენახვა")%></button>
            </footer>
        </div>
    </div>
</div>
            
            
            
            
<div class="modal fade" id="newAgent" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog large">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 id="frmcontragenttitle" class="modal-title"><%=trs.t("ახალი მომწოდებლის დამატება")%></h4>
            </div>
            <div class="modal-body">






<div class="smart-form col-sm-12">
<form id="frmcontragent" action="api/setcontragent.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden">
<input name="contragentid" type="hidden">
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("მომწოდებლის ტიპი")%></label>
                        <label class="select">
                            <select class="select2 req" name="contragenttypeid" id="contragenttypeid">
                                            <option value=""><%=trs.t("დამკვეთის ტიპი")%></option>
                                            <% out.println(ObjOptions.Contragenttype()); %>
                            </select>
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("მომწოდებლის დასახელება")%></label>
                        <label class="input"> <i class="icon-append fa fa-institution"></i>
                            <input type="text" name="name">
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("საიდ. კოდი/პირ. ნომ.")%></label>
                        <label class="input"> <i class="icon-append fa fa-id-card"></i>
                            <input type="text" name="idn">
                        </label>
                    </section>
                        
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("რეგიონი")%></label>
                        <label class="select">
                            <select name="region"  style="width:100%;"></select> 
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("რაიონი/ქალაქი")%></label>
                        <label class="select">
                            <select name="raion"  style="width:100%;" disabled></select> 
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("სოფელი")%></label>
                        <label class="select">
                            <select name="city"  style="width:100%;" disabled></select> 
                        </label>
                    </section>
                    <section class="col col-md-12">
                        <label class="label"><%=trs.t("მისამართი")%></label>
                        <label class="textarea"> 
                            <i class="icon-append fa fa-id-card"></i><textarea name="address" disabled></textarea>
                        </label>
                    </section>
                    <section class="col col-md-12"></section>
                    
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("ტელეფონი")%></label>
                        <label class="input"> <i class="icon-append fa fa-phone"></i>
                            <input type="text" name="phone">
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("ელფოსტა")%></label>
                        <label class="input"> <i class="icon-append fa fa-envelope"></i>
                            <input type="text" name="email">
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("ვებ-გვერდი")%></label>
                        <label class="input"> <i class="icon-append fa fa-link"></i>
                            <input type="text" name="url">
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("კონტაქტი")%></label>
                        <label class="input"> <i class="icon-append fa fa-user"></i>
                            <input type="text" name="contact">
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("საბანკო ინფორმაცია")%></label>
                        <label class="input"> <i class="icon-append fa fa-credit-card"></i>
                            <input type="text" name="bankdata">
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="label"><%=trs.t("შენიშვნა")%></label>
                        <label class="input"> <i class="icon-append fa fa-comment"></i>
                            <input type="text" name="note">
                        </label>
                    </section>
                        </form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" ><%=trs.t("გაუქმება")%></button>
                <button type="button" class="btn btn-success" onclick="submitContragent(); return false;"><%=trs.t("შენახვა")%></button>
            </footer>
        </div>
    </div>
</div>
            
            
            
            
<script type="text/javascript">
        pageSetUp();

        checkStatus1 = function (response, postdata) {
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
                jQuery("#stmv").jqGrid().setGridParam({
                    url:"content/getstockmovement.jsp?id=0"
                }).trigger("reloadGrid");
            }
            return [retval, msg, id];
        }
        
        function addInv(){

        $("#inputStock").modal('show');
/*
                BootstrapDialog.show({
                    title: '<%=trs.t("ზედნადების დამატება")%>',
                    size: BootstrapDialog.SIZE_SMALL,
                    resizable: false,
                    modal: true,
                    draggable: false,
                    closeOnEscape: false,
                    message: $('<div></div>').load("content/addinvoice.jsp"),
                    buttons: [
                        {
                            id: 'btn-cancel',
                            icon: 'fa fa-times',
                            label: ' დახურვა',
                            cssClass: 'btn-danger', 
                            autospin: false,
                            action: function(dialogRef){
                                dialogRef.close();
                            }
                        }
                    ]
                });
  */         
        }
        
        var pagefunction = function () {
            loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);


      function run_jqgrid_function() {

      //$(".bootstrap-datetimepicker-widget").css("z-index","")

      jQuery("#stmv").jqGrid({
        url: 'content/getstockmovement.jsp?id=0',
        datatype: "json",
        colNames: ['<%=trs.t("კოდი")%>','<%=trs.t("ბარკოდი")%>','<%=trs.t("დასახელება")%>', '<%=trs.t("ფასი")%>', '<%=trs.t("რაოდენობა")%>', '<%=trs.t("სულ")%>'],
        colModel: [
                    
                    {name: 'invnum', index: 'invnum', hidden: true},
                    {name: 'barcode', index: 'barcode', hidden: true},
                    {name: 'productid', index: 'productid', editable: false, align: "left"},
                    {name: 'price', index: 'price', editable: false, align: "left",search:false},
                    {name: 'amount', index: 'amount', editable: false, align: "left",search:false},
                    {name: 'tot', index: 'tot', editable: false, align: "left",search:false}
                ],
                rowNum: 20,
                height: 350,
                //width: 900,
                autowidth: true,
                rowList: [20,50,100],
                pager: jQuery('#pstmv'),
                sortname: 'productid',
                viewrecords: true,
                sortorder: "asc",
                pgtext: null,         // disable pager text like 'Page 0 of 10'
                editurl: "content/updstmv.jsp",
                //loadComplete: function(){jQuery("#stmv").closest(".ui-jqgrid-bdiv").scrollTop(scrollPosition)},
                onSelectRow: function(id){
                    
                }
            })
            .jqGrid('filterToolbar', { searchOnEnter: true, enableClear: true })
            .navGrid('#pstmv', {edit:false,add:false,del:<%=permissions[2]%>,view:false,search:false},
                            {dataheight: 250, width: 400, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus1,recreateForm:true,afterShowForm : function (formid) {rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>');}}, //  default settings for edit
                            {dataheight: 250, width: 400, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus1,recreateForm:true,afterShowForm : function (formid) {rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>');}}, //  default settings for add
                            {closeAfterDelete: true, reloadAfterSubmit: true, afterSubmit: checkStatus1}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 250, width: 400, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    )
            //.navButtonAdd('#pinventory', {id: 'exportinventory', caption: '<i class="fa fa-file-excel-o"></i> < %=trs.t("ექსპორტი")%>', buttonicon: "none", onClickButton: function () { }, position: 'last'})
            //.navButtonAdd('#pinventory', {id: 'printinventory', caption: '<i class="fa fa-print"></i> < %=trs.t("ბეჭდვა")%>', buttonicon: "none", onClickButton: function () { printInv($('#inventory').jqGrid('getGridParam','selrow')); }, position: 'last'})
            //.navButtonAdd('#pinventory', {id: 'importinventory', caption: '<i class="fa fa-upload"></i> < %=trs.t("იმპორტი")%>', buttonicon: "none", onClickButton: function () { impInv($('#inventory').jqGrid('getGridParam','selrow')); }, position: 'last'})
            //.navButtonAdd('#pinventory', {id: 'viewinventory', caption: '<i class="fa fa-folder-open"></i> < %=trs.t("აღწერა")%>', buttonicon: "none", onClickButton: function () { viewInv($('#inventory').jqGrid('getGridParam','selrow')); }, position: 'last'})
            //.navButtonAdd('#pinvoices', {id: 'uploadinvoice', caption: '<i class="fa fa-plus"></i>', buttonicon: "none", onClickButton: function () { addInv(); }, position: 'first'})


      jQuery("#invoices").jqGrid({
        url: 'content/getinvoicelist.jsp',
        datatype: "json",
        colNames: ['<%=trs.t("თარიღი")%>','<%=trs.t("ნომერი")%>','<%=trs.t("მომწოდებელი")%>', '<%=trs.t("ფაილი")%>'],
        colModel: [
                    
                    {width:"100", name: 'invoicedate', index: 'invoicedate', editable: true, edittype: 'text', editrules: { required: true}, searchoptions: {dataInit: function(element) {$(element).daterangepicker({autoUpdateInput:true}); $(element).val("");}}},
                    {width:"100",name: 'num', index: 'num', editable: true, edittype: 'text', editrules: { required: true}, editoptions: {size: 16}},
                    {width:"300",name: 'contragentid', index: 'contragentid', editable: false, align: "left"},
                    {name: 'invoice', index: 'invoice', editable: false, align: "center",hidden: true}
                ],
                rowNum: 20,
                height: 350,
                //width: 900,
                autowidth: true,
                rowList: [20,50,100],
                pager: jQuery('#pinvoices'),
                sortname: 'invoicedate',
                sortorder: "desc",
                pgtext: null,         // disable pager text like 'Page 0 of 10'
                viewrecords: true,
                editurl: "content/updinvoice.jsp",
                //loadComplete: function(){jQuery("#invoices").closest(".ui-jqgrid-bdiv").scrollTop(scrollPosition)},
                onSelectRow: function(id){
                    jQuery("#stmv").jqGrid().setGridParam({
                        url:"content/getstockmovement.jsp?id="+id
                    }).trigger("reloadGrid");
                }
            })
            .jqGrid('filterToolbar', { searchOnEnter: true, enableClear: true })
            .navGrid('#pinvoices', {edit:false,add:false,del:<%=permissions[2]%>,view:false,search:false},
                            {dataheight: 250, width: 400, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus1,recreateForm:true,afterShowForm : function (formid) {rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>');}}, //  default settings for edit
                            {dataheight: 250, width: 400, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus1,recreateForm:true,afterShowForm : function (formid) {rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>');}}, //  default settings for add
                            {closeAfterDelete: true, reloadAfterSubmit: true, afterSubmit: checkStatus1}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 250, width: 400, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    )
            //.navButtonAdd('#pinventory', {id: 'exportinventory', caption: '<i class="fa fa-file-excel-o"></i> < %=trs.t("ექსპორტი")%>', buttonicon: "none", onClickButton: function () { }, position: 'last'})
            //.navButtonAdd('#pinventory', {id: 'printinventory', caption: '<i class="fa fa-print"></i> < %=trs.t("ბეჭდვა")%>', buttonicon: "none", onClickButton: function () { printInv($('#inventory').jqGrid('getGridParam','selrow')); }, position: 'last'})
            //.navButtonAdd('#pinventory', {id: 'importinventory', caption: '<i class="fa fa-upload"></i> < %=trs.t("იმპორტი")%>', buttonicon: "none", onClickButton: function () { impInv($('#inventory').jqGrid('getGridParam','selrow')); }, position: 'last'})
            //.navButtonAdd('#pinventory', {id: 'viewinventory', caption: '<i class="fa fa-folder-open"></i> < %=trs.t("აღწერა")%>', buttonicon: "none", onClickButton: function () { viewInv($('#inventory').jqGrid('getGridParam','selrow')); }, position: 'last'})
            .navButtonAdd('#pinvoices', {id: 'uploadinvoice', caption: '<i class="fa fa-plus"></i>', buttonicon: "none", onClickButton: function () { addInv(); }, position: 'first'})
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
            //$("#viewinventory > div").removeClass("btn-primary").addClass("btn-success");
            $("#uploadinvoice > div").removeClass("btn-primary").addClass("btn-success");

            $(window).on('resize.jqGrid', function () {
                $("#invoices").jqGrid('setGridWidth', $("#inv").width() - 5);
                $("#stmv").jqGrid('setGridWidth', $("#invitem").width() - 5);
                //$("#gbox_invoices").height($("#s1").height()-40);
                //$("#gbox_stmv").height($("#s1").height()-40);
                $("#gview_invoices").height($("#s1").height()-40);
                $("#gview_stmv").height($("#s1").height()-40)
            })
        }
    }
        loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);

function getFmtDate(date) {
  var year = date.getFullYear();
  var month = (1 + date.getMonth()).toString();
  month = month.length > 1 ? month : '0' + month;
  var day = date.getDate().toString();
  day = day.length > 1 ? day : '0' + day;
  return  day + '/' + month + '/' + year;
}    

$(function(){
  $('#productid').select2({
        minimumInputLength: 1,
        allowClear: true,
        placeholder: "<%=trs.t("საქონლის დასახელება")%>",
        cache: true,
        ajax: {
            url: "api/getstock.jsp?obj=productlist",
            dataType: 'json',
            data: function (term, page) {return {q: term};},
            results: function (data, page) {return {results: data};}
        },
    formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
    formatInputTooShort: function () {return "<%=trs.t("შეიტანეთ საქონლის დასახელება")%>";},
    formatNoMatches: function () {return "<%=trs.t("საქონელი არ მოიძებნა. <a href='#' onclick='return newProduct()'>დააკლიკეთ თუ გსურთ დამატება</a>")%>";},
    escapeMarkup: function (markup) {return markup;}
  });
  $('#contragent').select2({
        minimumInputLength: 1,
        allowClear: true,
        placeholder: "<%=trs.t("მომწოდებელი")%>",
        cache: true,
        ajax: {
            url: "api/getstock.jsp?obj=contragentlist",
            dataType: 'json',
            data: function (term, page) {return {q: term};},
            results: function (data, page) {return {results: data};}
        },
    formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
    formatInputTooShort: function () {return "<%=trs.t("შეიტანეთ მომწოდებლის დასახელება")%>";},
    formatNoMatches: function () {return "<%=trs.t("მომწოდებელი არ მოიძებნა. <a href='#' onclick='return newAgent()'>დააკლიკეთ თუ გსურთ დამატება</a>")%>";},
    escapeMarkup: function (markup) {return markup;}
    });

  $('#productgroup').select2({
        allowClear: true,
        placeholder: "<%=trs.t("ჯგუფი")%>",
    formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
    formatNoMatches: function () {return "<%=trs.t("ჯგუფი არ მოიძებნა. <a href='#' onclick='return newAgent()'>დააკლიკეთ თუ გსურთ დამატება</a>")%>";},
    escapeMarkup: function (markup) {return markup;}
    });
  $('#punitid').select2({
        allowClear: true,
        placeholder: "<%=trs.t("ერთეული")%>",
    formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
    formatNoMatches: function () {return "<%=trs.t("ერთეული არ მოიძებნა. <a href='#' onclick='return newAgent()'>დააკლიკეთ თუ გსურთ დამატება</a>")%>";},
    escapeMarkup: function (markup) {return markup;}
    });
    
  $(".dtpicker").datepicker({
        format: 'dd/mm/yyyy', 
        startDate: getFmtDate(new Date()),
        autoclose: true, 
        language: 'ka', 
        todayHighlight: true, 
	prevText : '<i class="fa fa-chevron-left"></i>',
	nextText : '<i class="fa fa-chevron-right"></i>'
	});
  $('#invoicetype').select2();
})

function addInv(){
    $("#inputStock").modal('show');
    }
function newProduct(){
    $("#newProduct").modal('show');
    return true;
    }
function newAgent(){
    $("#newAgent").modal('show');
$(':focus').blur();
 //   $("select2-drop").modal('hide');
    return true;
    }

$('#newpProduct').on('shown.bs.modal', function () {
    $('#contragenttypeid').click();
})  
</script>
