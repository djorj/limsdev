<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    InventoryBean inv = InventoryManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
    InstitutionBean stock = InstitutionManager.getInstance().loadByPrimaryKey(inv.getInstitutionid());
    String stk = stock.getInstitutionid()+"";
    if(stock.getParentid() != null)
        stk += ", "+stock.getParentid();
    InstitutionBean[] stocks = InstitutionManager.getInstance().loadByWhere("where parentid = "+inv.getInstitutionid());
    for(int i=0;i<stocks.length;i++)
        stk += ", "+stocks[i].getInstitutionid();
    boolean canedit = true;
    if(inv.getEnddate() != null){
        canedit = false;
        permissions[0] = false;
        permissions[1] = false;
        permissions[2] = false;
    }
    PersonellBean[] pers = PersonellManager.getInstance().loadByWhere("where institutionid in ("+stk+") order by lname, fname");
%>
<style>
    #gview_inventoryitem .ui-jqgrid-bdiv {
        height: calc(100vh - 470px) !important;
    }
</style>
<div class="row alert alert-info alert-block">
    <div class="col col-sm-5">
        <h4 class="alert-heading">
            აღწერა: <%=stock.getName()%> <%=dtlong.format(inv.getStartdate())%>
        </h4>
    </div>
    <div class="col col-sm-5 pull-right">
        <label class="btn btn-warning pull-right" onclick="backInv();"><i class="fa fa-backward"></i> <%=trs.t("უკან")%></label>
        <%if(canedit){%>
        <label class="btn btn-success pull-right" style="margin-right: 5px;">
            <i class="fa fa-upload"></i> <%=trs.t("იმპორტი")%>
            <input type="file" id="import_inv" class="upload"/>
        </label>
        <%}%>
        <%--label class="btn btn-success pull-right" onclick="exportInv(<%=inv.getInventoryid()%>);" style="margin-right: 5px;"><i class="fa fa-file-excel-o"></i> <%=trs.t("ექსპორტი")%></label--%>
        <label class="btn btn-primary pull-right" onclick="pintInv(<%=inv.getInventoryid()%>);" style="margin-right: 5px;"><i class="fa fa-print"></i> <%=trs.t("ბეჭდვა")%></label>
    </div>
</div>
<%if(canedit){%>
<div class="row smart-form" id="topform">
    <div class="col col-sm-3">
        <label class="input"> <i class="icon-prepend fa fa-building"></i>
            <input type="text" placeholder="<%=trs.t("ოთახი")%>" value="" id='room'>
        </label>
    </div>
    <div class="col col-sm-2">
        <label class="input"> <i class="icon-prepend">N</i>
            <input type="number" placeholder="<%=trs.t("რაოდენობა")%>" value="1" id='realamount'>
        </label>
    </div>
    <div class="col col-sm-3">
        <label class="select">
            <select name='ownerid' id='ownerid'>
                <option value="0"><%=trs.t("მფლობელი")%></option>
                <%
                for(int i=0;i<pers.length;i++){
                    String sel = "";
                %>
                <option value="<%=pers[i].getPersonellid()%>" <%=sel%>><%=trs.t(pers[i].getLname())%> <%=trs.t(pers[i].getFname())%></option>
                <%
                }
                %>
            </select>
        </label>
    </div>
    <div class="col col-sm-3">
        <label class="input"> <i class="icon-prepend fa fa-barcode"></i>
            <input type="text" placeholder="<%=trs.t("ბარკოდი")%>" value="" id='barcode'>
        </label>
    </div>
    <div class="col col-sm-1">
        <label class="btn btn-success pull-right" onclick="addNewItem();"><i class="fa fa-plus"></i></label>
    </div>
</div>
<%}%>
<div class="row">
    <div class="col col-sm-12"><hr></div>
</div>
<div class="row">
    <div class="col col-sm-12">
        <div class="active" style="">
            <table id="inventoryitem"></table>
            <div id="pinventoryitem"></div>
        </div>
    </div>
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
    
    function importInv(input) {

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                if(e.target.result.indexOf("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") < 0)
                    alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("არასწორი ექსელის ფაილი - უნდა იყოს .XLS")%>','<%=trs.t("დახურვა")%>');
                else
                $.post("content/importinv.jsp",{ oper: "import", id: <%=inv.getInventoryid()%>, xls: e.target.result },function(data){
                    if(data.result == 0) {
                        alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                    } else {
                        $("#inventoryitem").trigger("reloadGrid");
                    }
                },"json");
            }

            reader.readAsDataURL(input.files[0]);
        }
    }
    
    function pintInv(id){
        printReportFname("inventory", id, "<%=stock.getName().replaceAll(" ","_")%>_<%=dtrepfile.format(inv.getStartdate())%>.pdf");
    }
    
    function backInv(){
        $.post("ajax/inventory.jsp", {  }, function (data) {
            //$("#content").hide("slide", {direction: "left"}, 500);
            //setTimeout(function () {
                $("#content").html(data);
            //    $('#content').hide().show("slide", {direction: "right"}, 500);
            //}, 500);
        });
    }
    
    function addNewItem(){
        var itemid = $('#inventoryitem').jqGrid('getGridParam','selrow');
        if(itemid > 0){
            var room = $("#room").val();
            var realamount = $("#realamount").val();
            var barcode = $("#barcode").val();
            var ownerid = $("#ownerid").val();
            if(barcode.length > 0){
                $.post("content/updinventoryitem.jsp",{
                    id: itemid,
                    room: room,
                    realamount: realamount,
                    barcode: barcode,
                    ownerid: ownerid,
                    oper: "quickedit"
                },function(data){
                    if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                    else {
                        $("#barcode").val("");
                        $("#barcode").focus();

                        var gridArr = $("#inventoryitem").getDataIDs();
                        var selrow = itemid;
                        var curr_index = 0;

                        for(var i = 0; i < gridArr.length; i++){
                            if(gridArr[i] == selrow)
                                curr_index = i;
                        }
                        //$("#inventoryitem").trigger("reloadGrid");

                        $('#inventoryitem').jqGrid('setCell',itemid,'room',room);
                        $('#inventoryitem').jqGrid('setCell',itemid,'realamount',realamount);
                        $('#inventoryitem').jqGrid('setCell',itemid,'barcode',barcode);
                        $('#inventoryitem').jqGrid('setCell',itemid,'ownerid',data.owner);
                        $('#inventoryitem').jqGrid('setCell',itemid,'oid',ownerid);
                        if((curr_index + 1) < gridArr.length)
                            $("#inventoryitem").resetSelection().setSelection(gridArr[curr_index + 1], true);
                        //$("#inventoryitem").closest(".ui-jqgrid-bdiv").scrollTop(scrollPosition);
                    }
                },"json");
            } else alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("ბარკოდი ცარიელია")%>','<%=trs.t("დახურვა")%>');
        } else alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ ჩანაწერი")%>','<%=trs.t("დახურვა")%>');
    }
    
    function addBarcode(id){
        if(id > 0){
            $.post("content/setbarcode.jsp",{ id: id, oper: "set" },function(data){
                if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                else {
                    $("#inventoryitem").trigger("reloadGrid");
                }
            },"json");
        } else alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ პროდუქტი")%>','<%=trs.t("დახურვა")%>');
    }
    
    function printBarcode(id){
        if(id > 0){
            $.post("content/setbarcode.jsp",{ id: id, oper: "print" },function(data){
                if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                else {
                    $("#inventoryitem").trigger("reloadGrid");
                    window.open(data.url);
                }
            },"json");
        } else alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ პროდუქტი")%>','<%=trs.t("დახურვა")%>');
    }
    
    function splitProduct(id){
        if(id > 0){
            $.post("content/splitinventoryitem.jsp",{ id: id },function(data){
                if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                else {
                    $("#inventoryitem").trigger("reloadGrid");
                }
            },"json");
        } else alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ პროდუქტი")%>','<%=trs.t("დახურვა")%>');
    }
    
    function moveItem(id){
        if(id > 0){
            BootstrapDialog.show({
                title: '<%=trs.t("გადატანა სხვა განყოფილებაში")%>',
                size: BootstrapDialog.SIZE_NORMAL,
                resizable: false,
                modal: true,
                draggable: false,
                closeOnEscape: false,
                message: $('<div></div>').load("content/moveitem.jsp?id="+id),
                buttons: [
                    {
                        id: 'btn-save',
                        icon: 'fa fa-save',
                        label: ' შენახვა',
                        cssClass: 'btn-success', 
                        autospin: false,
                        action: function(dialogRef){
                            $.post("content/updinventoryitem.jsp",{ 
                                oper: "move",
                                id: id, 
                                ownerid: $("#newownerid").val(), 
                                inventoryid: $("#newinventoryid").val(),
                                realamount: $("#newrealamount").val(),
                                roomnumber: $("#newroom").val(),
                                barcode: $("#newbarcode").val(),
                                note: $("#newnote").val()
                            },function(data){
                                if(data.result == 1){
                                    $("#inventoryitem").trigger("realodGrid");
                                    dialogRef.close();
                                } else {
                                    $("#errormsg").html(data.error);
                                    $("#errormsg").show();
                                }
                            },"json");

                        }
                    },
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
        } else alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ პროდუქტი")%>','<%=trs.t("დახურვა")%>');
    }
    
    var scrollPosition = 0;

    function RefreshGridData(id) {
        scrollPosition = jQuery("#"+id).closest(".ui-jqgrid-bdiv").scrollTop();
        $("#"+id).trigger("reloadGrid");
    }
    
    function getStatus(cellvalue, options, rowObject){
        var icon = "square-o";
        if(Number(rowObject[10]) > 0){
            icon = "check-square-o";
        }
        return "<span class=\"fa fa-"+icon+"\" style=\"color: green;\"></span>";
    }

    var pagefunction = function () {
      loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);
      function run_jqgrid_function() {

      //$(".bootstrap-datetimepicker-widget").css("z-index","")

      $("#barcode").on("keydown",function(e){
        var code = (e.keyCode ? e.keyCode : e.which);
        if(code==13 || code==9){
            addNewItem();
        }
      });

      $("#import_inv").change(function () {
        importInv(this);
      });
      
      jQuery("#inventoryitem").jqGrid({
        url: 'content/getinventoryitemlist.jsp?id=<%=inv.getInventoryid()%>',
        datatype: "json",
        colNames: ['<%=trs.t("ანგ. ნომერი")%>', '<%=trs.t("კატეგორია")%>', '<%=trs.t("ინვ. ნომერი")%>', '<%=trs.t("ბარკოდი")%>', '<%=trs.t("დასახელება")%>','<%=trs.t("მწარმოებელი")%>','<%=trs.t("მოდელი")%>','<%=trs.t("ს.ნ.")%>','<%=trs.t("ზომის ერთ.")%>', '<%=trs.t("რაოდენობა")%>', '<%=trs.t("აღწერილი")%>', '<%=trs.t("ფასი")%>', '<%=trs.t("ოთახი")%>','<%=trs.t("მფლობელი")%>', '<%=trs.t("შენიშვნა")%>','ownerid',''],
        colModel: [
                    
                    {width: 60, align: 'center', name: 'productgroupid', index: 'productgroupid',editable:true,edittype:"select",editoptions:{dataUrl:'content/gettypes.jsp?edit=1&objname=Productgroup&cols=Productgroupid&cols=Code&where=where companyid = <%=user.getCompanyid()%> order by code',style:'width: 200px;'}, search:true, stype:"select",searchoptions:{dataUrl:'content/gettypes.jsp?objname=Productgroup&cols=Productgroupid&cols=Code&where=where companyid = <%=user.getCompanyid()%> order by code'}},
                    {width: 100, align: 'left', name: 'productgroup', index: 'productgroup', editable: false,edittype:"select",editoptions:{dataUrl:'content/gettypes.jsp?edit=1&objname=Productgroup&cols=Productgroupid&cols=Name&where=where companyid = <%=user.getCompanyid()%> order by name',style:'width: 200px;'}, search: true, stype:"select",searchoptions:{dataUrl:'content/gettypes.jsp?objname=Productgroup&cols=Productgroupid&cols=Name&where=where companyid = <%=user.getCompanyid()%> order by name'}},
                    {width: 60, align: 'left', name: 'invnum', index: 'invnum', editable: true, search:true},
                    {width: 60, align: 'left', name: 'barcode', index: 'barcode', editable: true, search:true, formoptions: {rowpos: 16}},
                    {width: 100, align: 'left', name: 'productname', index: 'productname', editable: true, search:true},
                    {width: 80, align: 'left', name: 'brandname', index: 'brandname', editable: true, search:false},
                    {width: 80, align: 'left', name: 'model', index: 'model', editable: true, search:false},
                    {width: 60, align: 'left', name: 'serialnum', index: 'serialnum', editable: true, search:false},
                    {width: 50, align: 'center', name: 'punitid', index: 'punitid', editable: true, search: true,edittype:"select",editoptions:{dataUrl:'content/gettypes.jsp?edit=1&sel=6&objname=Punit&cols=Punitid&cols=Fullname&where=order by fullname',style:'width: 200px;'}, stype:"select",searchoptions:{dataUrl:'content/gettypes.jsp?objname=Punit&cols=Punitid&cols=Fullname&where=order by fullname'}},
                    {width: 60, align: 'right', name: 'amount', index: 'amount', editable: true, search:false, edirules:{number: true}},
                    {width: 60, align: 'right', name: 'realamount', index: 'realamount', editable: true, search:false, edirules:{number: true}},
                    {width: 60, align: 'right', name: 'price', index: 'price', editable: true, search:false, edirules:{number: true}},
                    {width: 100, align: 'left', name: 'room', index: 'room', editable: true, search:true},
                    {width: 100, align: 'left', name: 'ownerid', index: 'ownerid', editable: true, search: true,edittype:"select",editoptions:{dataUrl:'content/gettypes.jsp?edit=1&objname=Personell&cols=Personellid&cols=Fname&cols=Lname&where=where institutionid in (<%=stk%>) order by lname, fname',style:'width: 200px;'}, stype:"select",searchoptions:{dataUrl:'content/gettypes.jsp?objname=Personell&cols=Personellid&cols=Fname&cols=Lname&where=where institutionid in (<%=stk%>) order by lname, fname'}},
                    {width: 100, align: 'left', name: 'note', index: 'note', editable: true, search:true},
                    {name: 'oid', index: 'oid', hidden:true, editable: false, search: false, editrules:{edithidden:false}},
                    {width: 20, align: 'center', name: 'mid', index: 'mid', hidden:false, editable: false, search: false, editrules:{edithidden:false}, formatter:getStatus}
                ],
                rowNum: 20,
                //height: 'height: calc(100vh - 370px) !important;',
                //width: 900,
                autowidth: true,
                rowList: [20, 50, 100, 500],
                pager: jQuery('#pinventoryitem'),
                sortname: '(select r.code from productgroup r, product p where p.productgroupid = r.productgroupid and p.productid = inventoryitem.productid limit 1)',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updinventoryitem.jsp?invid=<%=inv.getInventoryid()%>",
                scrollrows: true,
                loadComplete: function(){
                    $("#inventoryitem").closest(".ui-jqgrid-bdiv").scrollTop(scrollPosition);
                },
                gridComplete: function(){
                    /*var rows = $("#inventoryitem").getDataIDs(); 
                    for (var i = 0; i < rows.length; i++){
                        var mid = $("#inventoryitem").getCell(rows[i],"mid");
                        if(mid > 0)    $("#inventoryitem").jqGrid('setRowData',rows[i],false, {background: '#E66280', color: '#A90329'});
                        else {
                            var amt = $("#inventoryitem").getCell(rows[i],"realamount");
                            if(amt > 0) $("#inventoryitem").jqGrid('setRowData',rows[i],false, {background: '#739E73', color: '#076207'});
                        }
                    }*/
                },
                onSelectRow: function(id){
                    var room = $('#inventoryitem').jqGrid('getCell',id,'room');
                    var realamount = $('#inventoryitem').jqGrid('getCell',id,'realamount');
                    var ownerid = $('#inventoryitem').jqGrid('getCell',id,'oid');
                    var barcode = $('#inventoryitem').jqGrid('getCell',id,'barcode');
                    if(room.length > 0)
                        $("#room").val(room);
                    if(realamount > 0)
                        $("#amount").val(realamount);
                    $("#barcode").val(barcode);
                    if(ownerid > 0)
                        $("#ownerid").val(ownerid);
                    $("#barcode").focus();
                    /*var mid = $('#inventoryitem').jqGrid('getCell',id,'mid');
                    if(mid > 0){
                        $("#unmoveitem").show();
                        $("#moveitem").hide();
                    } else {
                        $("#moveitem").show();
                        $("#unmoveitem").hide();
                    }*/
                },
                ondblClickRow: function(id, ri, ci) {
                    $("#inventoryitem").jqGrid('editGridRow',id,{savekey:[true,13], closeOnEscape: true, dataheight:400,width:400,closeAfterEdit:true,reloadAfterSubmit:true,afterSubmit:checkStatus,recreateForm:true,afterShowForm : function (formid) {rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>');}});
                    return;
                }
            })
            .jqGrid('filterToolbar', { searchOnEnter: true, enableClear: true })
            .navGrid('#pinventoryitem', {edit:<%=permissions[0]%>,add:<%=permissions[1]%>,del:<%=permissions[1]%>,view:false,search:false},
                            {savekey:[true,13], closeOnEscape: true, dataheight: 400, width: 400, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus,recreateForm:true,afterShowForm : function (formid) {rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>');}}, //  default settings for edit
                            {savekey:[true,13], closeOnEscape: true, dataheight: 400, width: 400, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus,recreateForm:true,afterShowForm : function (formid) {rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>');}}, //  default settings for add
                            {closeAfterDelete: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 350, width: 400, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    )
            <%if(permissions[0]){%>
                //.navButtonAdd('#pinventoryitem', {id: 'moveitem', caption: '<i class="fa fa-share"></i> < %=trs.t("გადატანა")%>', buttonicon: "none", onClickButton: function () { moveItem($('#inventoryitem').jqGrid('getGridParam','selrow')); }, position: 'first'})
                //.navButtonAdd('#pinventoryitem', {id: 'unmoveitem', caption: '<i class="fa fa-reply"></i> < %=trs.t("გადმოტანა")%>', buttonicon: "none", onClickButton: function () { unMoveItem($('#inventoryitem').jqGrid('getGridParam','selrow')); }, position: 'first'})
                .navButtonAdd('#pinventoryitem', {id: 'addbarcode', caption: '<i class="fa fa-barcode"></i>', buttonicon: "none", onClickButton: function () { addBarcode($('#inventoryitem').jqGrid('getGridParam','selrow')); }, position: 'first'})
                .navButtonAdd('#pinventoryitem', {id: 'printbarcode', caption: '<i class="fa fa-print"></i>', buttonicon: "none", onClickButton: function () { printBarcode($('#inventoryitem').jqGrid('getGridParam','selrow')); }, position: 'first'})
                .navButtonAdd('#pinventoryitem', {id: 'expanditem', caption: '<i class="fa fa-list"></i> <%=trs.t("ჩაშლა")%>', buttonicon: "none", onClickButton: function () { splitProduct($('#inventoryitem').jqGrid('getGridParam','selrow')); }, position: 'first'})
            <%}%>
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

            $("#addbarcode > div").removeClass("btn-primary").addClass("btn-success");
            $("#moveitem > div").removeClass("btn-primary").addClass("btn-warning");
            $("#unmoveitem > div").removeClass("btn-primary").addClass("btn-danger");
            $("#unmoveitem").hide();
            // update buttons

            $(window).on('resize.jqGrid', function () {
                $("#inventoryitem").jqGrid('setGridWidth', $("#content").width() - 10);
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