<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
    String gridname = "product";
    String ses = "EXPORT_BAR_" + (new Date()).getTime();
    jqexport exp = new jqexport(ses, null, null, "EXPORT_STOP", "content/export_" + gridname + ".jsp", "");
%>
<%=exp.getExportAttr()%>
<style>
    .categoryover {
        background-color: #739E73 !important;
        color: white;
        height: 50px;
        line-height: 50px;
        font-weight: bold;
        -moz-border-radius: 5px;
        -webkit-border-radius: 5px;
        border-radius: 5px;
    }
    
    .categoryactivate {
        border-color: #A90329 !important;
    }
    
    .draggedValue {
        background-color: #3276B1 !important;
        color: white;
        height: 30px;
        line-height: 30px;
        -moz-border-radius: 5px;
        -webkit-border-radius: 5px;
        border-radius: 5px;
        padding-left: 5px;
        padding-right: 5px;
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

    var ageunits = [
        {age: 31540000000, name: 'წელი'},
        {age: 2628000000, name: 'თვე'},
        {age: 86400000, name: 'დღე'},
        {age: 3600000, name: 'საათი'},
        {age: 60000, name: 'წუთი'},
        {age: 1000, name: 'წამი'}
    ];

    function expFmatter(cellvalue, options, rowObject)
    {
        var suff = "";
        var vl = cellvalue;
        if (!isNaN(vl)) {
            for (var i = 0; i < ageunits.length; i++) {
                if (vl > ageunits[i].age) {
                    vl = Math.round(vl / ageunits[i].age);
                    suff = ageunits[i].name;
                    break;
                }
            }
        }
        return vl + " " + suff;
    }

    function unformatExp(cellvalue, options)
    {
        var vl = cellvalue;
        for (var i = 0; i < ageunits.length; i++) {
            if (cellvalue.indexOf(ageunits[i].name) > 0) {
                vl = ageunits[i].age * cellvalue.replace(" " + ageunits[i].name, "");
                break;
            }
        }
        return vl;
    }

    function ageelem(value, options) {
        var val = value;
        var sl = 0;
        if (!isNaN(val)) {
            for (var i = 0; i < ageunits.length; i++) {
                if (val > ageunits[i].age) {
                    val = Math.round(val / ageunits[i].age);
                    sl = i;
                    break;
                }
            }
        }
        var el = '<input class="FormElement ui-widget-content ui-corner-all" type="text" size="10" idc="' + options.id + '_text" style="text-align: right;" value="' + val + '"/> <select idc="' + options.id + '_select" class="FormElement ui-widget-content ui-corner-all">';
        for (var i = 0; i < ageunits.length; i++) {
            var sel = '';
            if (i == sl)
                sel = 'selected';
            el += '<option value="' + i + '" ' + sel + '>' + ageunits[i].name + '</option>';
        }
        el += '</select>';
        return el;
    }

    function agevalue(elem, operation, value) {
        if (operation === 'set')
            return $(elem).val();
        if (operation === 'get') {
            var id = $(elem).attr('id');
            var idx = $("select[idc='" + id + "_select']").val();
            var val = Number($("input[idc='" + id + "_text']").val());
            var vl = val * ageunits[idx].age;
            return vl;
        }
    }
    
    var selectedgroupid = 0;
    
    function detailsGrid(id) {
        $(".pleaf").css("background-color","#F0F1F1");
        if(id == 0){
            $("#lp2").hide();
        } else {
            jQuery("#list<%=gridname%>").jqGrid().setGridParam({
                url: "content/get<%=gridname%>list.jsp?gid=" + id,
                editurl: "content/upd<%=gridname%>.jsp?gid=" + id
            }).trigger("reloadGrid");
            $("#lp2").show();
            $("#pleaf_"+id).css("background-color","#D9EDF7");
            selectedgroupid = id;
        }
    }
    
    function pModal(id, oper) {
        $.post("elements/modalGroup.jsp",{ id: id, oper: oper },function(data){
            $("#product_container").html(data);
            $("#addModal").modal("show");
        },"html");
        
    }
    
    function showError(errortxt){
        var errortag = '<div class="alert alert-danger fade in"><button class="close" data-dismiss="alert"> × </button>';
        errortag += '<i class="fa-fw fa fa-times"></i><strong><%=trs.t("შეცდომა!")%></strong> ';
        errortag += '<span id="modalproducterrorcontext">'+errortxt+'</span></div>';
        $("#modalproducterror").html(errortag);
    }
    
    function saveProduct(id, oper){
        $.post("content/updproduct.jsp",{
            parent: $("#parent").val(),
            oper: oper,
            id: id,
            name: $("#name").val(),
            code: $("#code").val(),
            punitid: $("#punitid").val(),
            limitqty: $("#limitqty").val(),
            exp1: $("#exp1").val(),
            unit1: $("#unit1").val(),
            exp2: $("#exp2").val(),
            unit2: $("#unit2").val()
        },function(data){
            if(data.result == 0){
                showError(data.error);
            } else {
                $("#modalproducterror").html("");
                $.post("elements/productTree.jsp",{ productid: data.id },function(html){
                    $("#producttree").html(html);
                    $(".modal-header>.close").click();
                },"html");
            }
        },"json");
    }
    
    function saveChangeGroup(id, gid){
        $.post("content/updproduct.jsp",{
            gid: gid,
            oper: "chgroup",
            id: id
        },function(data){
            if(data.result == 0){
                showError(data.error);
            } else {
                $("#modalproducterror").html("");
                $(".modal-header>.close").click();
                jQuery("#list<%=gridname%>").jqGrid().trigger("reloadGrid");
            }
        },"json");
    }
    
    function saveGroup(id, oper){
        $.post("content/updproduct.jsp",{
            parent: $("#parent").val(),
            oper: oper,
            id: id,
            name: $("#name").val(),
            code: $("#code").val()
        },function(data){
            if(data.result == 0){
                showError(data.error);
            } else {
                $("#modalproducterror").html("");
                $.post("elements/productTree.jsp",{ productid: data.id },function(html){
                    $("#producttree").html(html);
                    $(".modal-header>.close").click();
                },"html");
            }
        },"json");
    }
    
    function makeGridRowsDraggable(grid) {
        createDroppableElements();
        $("#"+grid).val(new Date().getTime());
        //var $searchResultsGrid = grid;
        var searchResultsRows = $("#"+grid+" .ui-row-ltr");

        searchResultsRows.draggable({ appendTo: "body" }); searchResultsRows.draggable({
            create: function (event, ui) { }
        });

        searchResultsRows.css("cursor", "move").draggable("option", "helper", "clone").draggable({
            revert: "true",
            appendTo: 'body',
            cursor: "move",
            snap: "true",
            cursorAt: {
                top: 10,
                left: -5
            },
            helper: function (event) {
                //get a hold of the row id
                var rowId = $(this).attr('id');

                //my code
                var rowData = jQuery("#"+grid).getRowData(rowId);
                var name = rowData['name'];
                //set the data on this to the value to grab when you drop into input box
                $(this).data('colValue', name);
                var dialog = ($('#DragableWidget').length > 0) ? $('#DragableWidget') :
                             $('<div id="DragableWidget" class="draggedValue ui-widget-header ui-corner-all"></div>').appendTo('body');
                dialog.html(name);
                return dialog;
            }
            , start: function (event, ui) {
                //fade the grid
                $(this).parent().fadeTo('fast', 0.5);
            }
            , stop: function (event, ui) {
                $(this).parent().fadeTo(0, 1);
            }
        });
    }
    
    function createDroppableElements() {
        $(".pleaf").droppable({
            tolerance: 'pointer',
            hoverClass: 'active',
            activate: function (event, ui) {
                $(this).addClass("categoryactivate");
            },
            deactivate: function (event, ui) {
                $(this).removeClass("categoryactivate");
                $(this).removeClass("categoryover");
            },
            over: function (event, ui) {
                $(this).addClass("categoryover");
            },
            out: function (event, ui) {
                $(this).removeClass("categoryactivate");
                $(this).removeClass("categoryover");
            },
            drop: function (event, ui) {
                var groupid = $(this).attr("groupid");
                var productid = ui.draggable.attr("id");
                changeCategory(productid,groupid);
            }
        });
    }

    function changeCategory(productid,groupid){
        $.post("elements/modalChangeGroup.jsp",{ productid: productid, groupid: groupid },function(data){
            $("#product_container").html(data);
            $("#addModal").modal("show");
        },"html");
    }
    
    function setDefaults<%=gridname%>(){
        setTimeout(function(){
            $("#productgroupid").val(selectedgroupid);
        },500);
    }
    
    var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);

        function run_jqgrid_function() {

            var lastSel;
            
            jQuery("#list<%=gridname%>").jqGrid({
                url: 'content/get<%=gridname%>list.jsp?gid=0',
                datatype: "json",
                colNames: ['<%=trs.t("ჯგუფი")%>', '<%=trs.t("დასახელება")%>', '<%=trs.t("კოდი")%>','<%=trs.t("ერთეული")%>','<%=trs.t("ლიმიტი")%>','<%=trs.t("ვადა გახსნამდე")%>','<%=trs.t("ვადა გახსნის შემდეგ")%>'],
                colModel: [
                    {name: 'productgroupid', index: 'productgroupid', editable: true, hidden:true, align: "left", width: 80, edittype:'select', editoptions:{dataUrl:'content/gettypes.jsp?edit=1&objname=Productgroup&cols=Productgroupid&cols=Name&where=where productgroupid not in (select parentid from productgroup where parentid > 0) order by name',style:'width: 200px;'},editrules:{edithidden:true}},
                    {name: 'name', index: 'name', editable: true, align: "left", width: 300, editoptions:{size:"30"},editrules:{required: true},search:true},
                    {name: 'code', index: 'code', editable: true, align: "left", width: 100, editoptions:{size:"10"},editrules:{required: false},search:true},
                    {name: 'punitid', index: 'punitid', editable: true, align: "left", width: 80, edittype:'select', editoptions:{dataUrl:'content/gettypes.jsp?edit=1&objname=Punit&cols=Punitid&cols=Name&where=order by name',style:'width: 200px;'},search:true,stype:'select',searchoptions:{dataUrl:'content/gettypes.jsp?objname=Punit&cols=Punitid&cols=Name&where=order by name',style:'width: 200px;'}},
                    {name: 'limitqty', index: 'limitqty', editable: true, align: "right", width: 40, editoptions:{defaultValue: "0", size:"10",style:"text-align: right"},editrules:{required: true, number:true},search:false},
                    {name: 'exp1', index: 'exp1', editable: true, align: "left", width: 100, hidden: true, editrules:{edithidden:true},edittype:'custom', editoptions:{custom_element: ageelem, custom_value: agevalue}},
                    {name: 'exp2', index: 'exp2', editable: true, align: "left", width: 100, hidden: true, editrules:{edithidden:true},edittype:'custom', editoptions:{custom_element: ageelem, custom_value: agevalue}}
                ],
                rowNum: 20,
                autowidth: true,
                rowList: [20,50,100],
                pager: jQuery('#pager<%=gridname%>'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/upd<%=gridname%>.jsp?gid=0",
                gridComplete: function(){makeGridRowsDraggable("list<%=gridname%>");},
                title: "<%=trs.t("პროდუქტები")%>"
            })
            .jqGrid('filterToolbar', { searchOnEnter: true, enableClear: true })
            .navGrid('#pager<%=gridname%>', {edit:<%=permissions[1]%>,add:<%=permissions[0]%>,del:<%=permissions[2]%>,view:false,search:false},
                    {dataheight: 400, width: 500, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus, afterShowForm : function (formid) { setDefaults<%=gridname%>(); } }, //  default settings for edit
                    {dataheight: 400, width: 500, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus, afterShowForm : function (formid) { setDefaults<%=gridname%>(); }}, //  default settings for add
                    {closeAfterDelete: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, // delete instead that del:false we need this
                    {multipleSearch: true}, // search options
                    {dataheight: 320, width: 400, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
            )
            <%if(permissions[1]){%>
            .navButtonAdd('#pager<%=gridname%>',{caption:'<i class="fa fa-graduation-cap"></i> ', buttonicon:'none',onClickButton: function(){ uploadSignature(jQuery('#listpersonell').jqGrid('getGridParam','selrow')); },position:'last'})
            <%}%>
            <%--if(permissions[4]){%>
            .navButtonAdd('#pager<%=gridname%>',{caption:'<i class="fa fa-file-excel-o"></i> ', buttonicon:'none',onClickButton: function(){ <%=exp.getClickCode()%> },position:'last'})
            <%}--%>
            ;
                    
            jQuery("#listunits").jqGrid({
                url: 'content/getunitslist.jsp?productid=0',
                datatype: "json",
                colNames: ['<%=trs.t("ერთეული")%>', '<%=trs.t("რაოდენობა")%>'],
                colModel: [
                    {name: 'punitsid', index: 'punitsid', editable: false, align: "left", width: 100},
                    {name: 'amount', index: 'amount', editable: true, align: "right", width: 100, edittype: "text", editoptions: {size: "10", style: "text-align: right;", defaultValue: '0.00'}, editrules: {edithidden: true, required: true, number: true}, search: false}
                ],
                rowNum: 20000,
                autowidth: true,
                rowList: [],
                pager: jQuery('#pagerunits'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                pgtext: "",
                pginput: false,
                pgbuttons: false,
                sortorder: "asc",
                        editurl: "content/updunits.jsp?productid=0",
                onSelectRow: function (id) {
                    if (id && id !== lastSel) {
                        jQuery('#listunits').restoreRow(lastSel);
                        lastSel = id;
                    }
                    jQuery('#listunits').editRow(id, true);
                }
            })
                    .navGrid('#pagerunits', {edit: false, add: false, del: false, view: false, search: false},
                            {dataheight: 200, width: 500, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for edit
                            {dataheight: 200, width: 500, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for add
                            {closeAfterDelete: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 320, width: 400, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    )
                    ;

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


            $("#lp2").hide();

            $(window).on('resize.jqGrid', function () {
                jQuery("#list<%=gridname%>").jqGrid('setGridWidth', $("#lp2").width() - 10);
                $("#gview_list<%=gridname%>").height(window.innerHeight - 220);
            });
            
            $.contextMenu('destroy', 'li>span');
            $.contextMenu({
                selector: 'li>span',
                callback: function (key, options) {
                    var groupid = options.$trigger.attr("groupid");
                    
                    if(key == "add")   pModal(groupid,"add");
                    if(key == "edit")   pModal(groupid,"edit");
                    if(key == "delete")   pModal(groupid,"del");
                },
                items: {
                    "edit": {
                        name: "რედაქტირება",
                        icon: function (opt, $itemElement, itemKey, item) {
                            $itemElement.html('<span class="fa fa-pencil" aria-hidden="true"></span> რედაქტირება');
                            // Add the context-menu-icon-updated class to the item
                            return 'context-menu-icon-updated';
                        }
                    },
                    "add": {
                        name: "დამატება",
                        icon: function (opt, $itemElement, itemKey, item) {
                            $itemElement.html('<span class="fa fa-plus" aria-hidden="true"></span> დამატება');
                            // Add the context-menu-icon-updated class to the item
                            return 'context-menu-icon-updated';
                        }
                    },
                    "delete": {
                        name: "წაშლა",
                        icon: function (opt, $itemElement, itemKey, item) {
                            $itemElement.html('<span class="fa fa-remove" aria-hidden="true"></span> წაშლა');
                            // Add the context-menu-icon-updated class to the item
                            return 'context-menu-icon-updated';
                        }
                    }
                },
                show: function (options) {
                    $(".pleaf").css("background-color","#F0F1F1");
                    $("#pleaf_"+productid).css("background-color","#D9EDF7");
                    $(".rleaf").css("background-color","#F0F1F1");
                    $("#rleaf_"+productid).css("background-color","#D9EDF7");
                }
            });
            
            $('.numeric').keyup(function () {
                var val = $(this).val();
                if (isNaN(val)) {
                    val = val.replace(/[^0-9\.]/g, '');
                    if (val.split('.').length > 2)
                        val = val.replace(/\.+$/, "");
                }
                $(this).val(val);
            });
            
            $.post("elements/productTree.jsp",{ productid: 9 },function(html){
                $("#producttree").html(html);
            },"html");
        }
        
        
        
    };
    
    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);

</script>
<div class="row">
    <article class="col-xs-12 col-sm-4 col-md-4 col-lg-4 sortable-grid ui-sortable" id="lp1">
        <a class="btn btn-warning" href="javascript:pModal(0, 'add');"><i class="fa fa-plus"></i> <%=trs.t("ახალი ჯგუფის დამატება")%></a>
        <div class="tree smart-form">
            <ul id='producttree'>
                
            </ul>
        </div>
    </article>
    <article class="col-xs-12 col-sm-8 col-md-8 col-lg-8 sortable-grid ui-sortable" id="lp2">
        <table id='list<%=gridname%>' width='100%'></table><div id='pager<%=gridname%>'></div>
    </article>
</div>
<div id="product_container"></div>
