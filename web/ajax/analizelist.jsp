<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    String editypes = "\"1:"+trs.t("ტესტი")+";2:"+trs.t("ჯგუფი")+";3:"+trs.t("კონტროლი")+"\"";
    String searchtypes = "\"0:"+trs.t("-- ყველა -- ")+";1:"+trs.t("ტესტი")+";2:"+trs.t("ჯგუფი")+";3:"+trs.t("კონტროლი")+"\"";
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
        } else {
            id = json.id;
            RefreshGridData("analizelist");
        }
        return [retval, msg, id];
    }
    
    function getParams(id){
        if(id > 0){
            $.post("content/paramdialog.jsp",{ id: id },function(data){ 
                var name = jQuery('#analizelist').jqGrid('getCell',id,'name');
                $("#paramsModalTitle").html(name);
                $('#paramsModal').modal('show');
                //showLoader("paramsbody");
                $("#paramsbody").html(data);
            });
        } else {
            alert('<%=trs.t("აირიეთ ჩანაწერი")%>');
        }
    }
    
    function saveparams(){
    
        var id = $("#labtestidparamdialog").val(); //jQuery('#analizelist').jqGrid('getGridParam','selrow');
        if(id > 0)
        $.post("content/savelabtestparams.jsp",{ id: id },function(data){
            if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
            else {
                $('#paramsModal').modal('hide');
                $("#paramsbody").html('');
                RefreshGridData("analizelist");
            }
        },"json");
        else alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ კვლევა")%>','<%=trs.t("დახურვა")%>');
        /*
        var groupid = $("input[name='groupid']:checked").map(function() { return this.value; }).get();
        var sampleid = $("input[name='sampleid']:checked").map(function() { return this.value; }).get();
        var institutionid = $("input[name='institutionid']:checked").map(function() { return this.value; }).get();
        var standardid = $("input[name='standardid']:checked").map(function() { return this.value; }).get();
        var pars = new Object();
        pars.groupid = groupid;
        pars.sampleid = sampleid;
        pars.institutionid = institutionid;
        pars.standardid = standardid;
        
        $.post("content/savelabtestparams.jsp",{
            id: id,
            pars: JSON.stringify(pars)
        },function(data){
            if(data.result == 1){
                $('#paramsModal').modal('hide');
                $("#paramsbody").html('');
                RefreshGridData("analizelist");
            } else {
                alert(data.error);
            }
        },"json");
        */
    }
    
    function getPrices(id){
        if(id > 0){
            $.post("content/pricedialog.jsp",{ id: id },function(data){ 
                var name = jQuery('#analizelist').jqGrid('getCell',id,'name');
                $("#priceModalTitle").html("<%=trs.t("ფასები")%>: "+name);
                $('#priceModal').modal('show');
                //showLoader("pricebody");
                $("#pricebody").html(data);
            });
        } else {
            alert('<%=trs.t("აირიეთ ჩანაწერი")%>');
        }
    }
    
    function getCalc(id){
        if(id > 0){
            $.post("content/calcdialog.jsp",{ id: id },function(data){ 
                var name = jQuery('#analizelist').jqGrid('getCell',id,'name');
                $("#calcModalTitle").html("<%=trs.t("ფასები")%>: "+name);
                $('#calcModal').modal('show');
                //showLoader("pricebody");
                $("#calcbody").html(data);
            });
        } else {
            alert('<%=trs.t("აირიეთ ჩანაწერი")%>');
        }
    }
    
    function getNorm(id){
        if(id > 0){
            $.post("content/normdialog.jsp",{ id: id },function(data){ 
                var name = jQuery('#analizelist').jqGrid('getCell',id,'name');
                $("#normModalTitle").html("<%=trs.t("ნორმატივები")%>: "+name);
                $('#normModal').modal('show');
                //showLoader("pricebody");
                $("#normbody").html(data);
            });
        } else {
            alert('<%=trs.t("აირიეთ ჩანაწერი")%>');
        }
    }
    
    function getDevices(id){
        if(id > 0){
            $.post("content/devicedialog.jsp",{ id: id },function(data){ 
                var name = jQuery('#analizelist').jqGrid('getCell',id,'name');
                $("#deviceModalTitle").html("<%=trs.t("აპარატურა")%>: "+name);
                $('#deviceModal').modal('show');
                //showLoader("pricebody");
                $("#devicebody").html(data);
            });
        } else {
            alert('<%=trs.t("აირიეთ ჩანაწერი")%>');
        }
    }
    
    function getControl(id){
        if(id > 0){
            $.post("content/controldialog.jsp",{ id: id },function(data){ 
                var name = jQuery('#analizelist').jqGrid('getCell',id,'name');
                $("#controlModalTitle").html("<%=trs.t("ხარისხის ტესტები")%>: "+name);
                $('#controlModal').modal('show');
                //showLoader("pricebody");
                $("#controlbody").html(data);
            });
        } else {
            alert('<%=trs.t("აირიეთ ჩანაწერი")%>');
        }
    }
    
    function savecontrol(){
        var id = jQuery('#analizelist').jqGrid('getGridParam','selrow');
        var types = $("input[type=radio].scdtype:checked").map(function() { 
            var ob = new Object();
            ob.testid = $(this).attr('testid');
            ob.val = this.value;
            if(ob.val == 3){
                ob.wday = $("input[name='weekdays_"+ob.testid+"']:checked").map(function() {
                    var wd = new Object();
                    wd.weekday = this.value;
                    wd.time = $("#time3"+wd.weekday+"_"+ob.testid).val();
                    return wd; 
                });
            } else if(ob.val == 2){
                ob.time = $("#time2_"+ob.testid).val();
            } else if(ob.val == 4){
                ob.minutesbefore = $("#minutesbefore_"+ob.testid).val();
            } else if(ob.val == 5){
                ob.minutesafter = $("#minutesafter_"+ob.testid).val();
            } else if(ob.val == 6){
                ob.positive = $("#positive_"+ob.testid).val();
                ob.negative = $("#negative_"+ob.testid).val();
                ob.extra = $("#extra_"+ob.testid).val();
            }
            return ob; 
        }).get();
        
        $.post("content/savecontrol.jsp",{
            id: id,
            procdescr: $("#procdescr").val(),
            schedule: JSON.stringify(types)
        },function(data){
            if(data.result == 0)    alert(data.error);
            else {
                $('#controlModal').modal('hide');
                $("#controlbody").html('');
            }
        },"json");
        
    }
    
    function savenorm(){
    
        var id = jQuery('#analizelist').jqGrid('getGridParam','selrow');
        var restypeid = jQuery('#analizelist').jqGrid('getCell',id,'rid');
        var obj = new Object();
        obj.id = id;
        if(restypeid == 1){
            obj.normpositive = $("#normpositive").val();
            obj.normnegative = $("#normnegative").val();
        } else if(restypeid == 2){
            obj.normmin = $("#normmin").val();
            obj.normmax = $("#normmax").val();
        } else if(restypeid == 3){
            obj.txttype = $("input[name='texttype']:checked").val();
            if(obj.txttype == 1)    obj.freetextnorm = $("#freetextnorm").val();
            else                    obj.listsessionname = "NORMTXT";
        }
        $.post("content/savelabtestnorms.jsp",{
            id: id,
            pars: JSON.stringify(obj)
        },function(data){
            if(data.result == 1){
                $('#normModal').modal('hide');
                $("#normbody").html('');
                jQuery('#analizelist').jqGrid('setCell',id,'norms',data.normtext);
//                jQuery("#analizelist").trigger("reloadGrid");
            } else {
                alert(data.error);
            }
        },"json");
    }

    var scrollPosition = 0

    function RefreshGridData(id) {
        scrollPosition = jQuery("#"+id).closest(".ui-jqgrid-bdiv").scrollTop()
        $("#"+id).trigger("reloadGrid");
    }

    var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);

        $('[tool-tip-toggle="tooltip-demo"]').tooltip({
            placement: 'top'
        });

        function run_jqgrid_function() {

            jQuery("#analizelist").jqGrid({
                url:'content/getlabtestlist.jsp',
                datatype: "json",
                colNames: ['<%=trs.t("კატეგორია")%>','<%=trs.t("დასახელება")%>', '<%=trs.t("აღწერა")%>', '<%=trs.t("ტიპი")%>', '<%=trs.t("ერთეული")%>', '<%=trs.t("პასუხის ტიპი")%>', '<%=trs.t("სტანდარტი")%>', '<%=trs.t("მიმდინარე ფასი")%>', '<%=trs.t("ნორმატივები")%>','rid'],
                colModel: [
                    {width: 150, name: 'testcategoryid', index: 'testcategoryid', hidden: false, editable: true, sortable: false, align: "left", edittype: "select", editoptions: {dataUrl:'content/gettypes.jsp?edit=1&objname=Testcategory&cols=Testcategoryid&cols=Name&where=order by name', style:"width: 200px;"}, editrules: {edithidden: true, required: true}, search: true, stype:"select",searchoptions:{dataUrl:'content/gettypes.jsp?objname=Testcategory&cols=Testcategoryid&cols=Name&where=order by name'}},
                    {width: 200, name: 'name', index: 'name', hidden: false, editable: true, sortable: false, align: "left", edittype: "text", editoptions: {size: "30"}, editrules: {edithidden: true, required: true}, search: true},
                    {width: 200, name: 'description', index: 'description', hidden: true, editable: true, sortable: false, align: "left", edittype: "textarea", editoptions: {cols: "30", rows: "3"}, editrules: {edithidden: true, required: false}, search: true},
                    {width: 50, name: 'type', index: 'type', hidden: false, editable: true, sortable: false, align: "left", edittype: "select", editoptions:{value: <%=editypes%>}, stype:"select", searchoptions:{value: <%=searchtypes%>}, serach:true},
                    {width: 50, name: 'unitsid', index: 'unitsid', hidden: false, editable: true, sortable: false, align: "left", edittype: "select", editoptions:{dataUrl:'content/gettypes.jsp?nmand=<%=trs.t("არ აქვს")%>&objname=Units&cols=Unitsid&cols=Name&where=order by name', style:"width: 200px;"}, search: false},
                    {width: 50, name: 'restypeid', index: 'restypeid', hidden: false, editable: true, sortable: false, align: "left", edittype: "select", editoptions:{dataUrl:'content/gettypes.jsp?edit=1&objname=Restype&cols=Restypeid&cols=Name&where=order by name', style:"width: 200px;"}, search: false},
                    {width: 100, name: 'standards', index: 'standards', hidden: false, editable: false, sortable: false, align: "left",search:true},
                    {width: 50, name: 'price', index: 'price', hidden: false, editable: false, sortable: false, align: "right",search:false},
                    {width: 50, name: 'norms', index: 'norms', hidden: false, editable: false, sortable: false, align: "center",search:false},
                    {name: 'rid', index: 'rid', hidden: true, search:false}
                ],
                rowNum: 20,
                height: 350,
                width: 900,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pageranalizelist'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updanalizelist.jsp",
                loadComplete: function(){jQuery("#analizelist").closest(".ui-jqgrid-bdiv").scrollTop(scrollPosition)}
            })
                .jqGrid('filterToolbar', { searchOnEnter: true, enableClear: true })
                .navGrid('#pageranalizelist', {edit:<%=permissions[1]%>,add:<%=permissions[0]%>,del:<%=permissions[2]%>,view:false,search:false},
                            {dataheight: 300, width: 400, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus,recreateForm:true,afterShowForm : function (formid) {rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>');}}, //  default settings for edit
                            {dataheight: 300, width: 400, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus,recreateForm:true,afterShowForm : function (formid) {rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>');}}, //  default settings for add
                            {closeAfterDelete: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 300, width: 400, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    )
                .navButtonAdd('#pageranalizelist', {id: 'exportanalizelist', caption: '<i class="fa fa-file-excel-o"></i> <%=trs.t("ექსპორტი")%>', buttonicon: "none", onClickButton: function () { }, position: 'last'})
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
                jQuery("#analizelist").jqGrid('setGridWidth', $("#content").width() - 13);
            })
        }
    }

    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);
    $(document).on("click", ".jarviswidget-toggle-btn", function () {
        $(".table-size2").toggleClass("active");
    });
    $(document).on("click", ".addinput", function(){
        $(this).prev().append('<input class="clockpicker" type=text size="5" value="09:00" style="margin: 0 5px; position: relative; left: 0;">');
    });
</script>
<div class="col-md-12 btn-panel">
    <button class="btn btn-warning pull-right" onclick="getControl(jQuery('#analizelist').jqGrid('getGridParam','selrow'));"><i class="fa fa-warning"></i> <%=trs.t("ხარისხი")%></button>
    <button class="btn btn-info pull-right" onclick="getCalc(jQuery('#analizelist').jqGrid('getGridParam','selrow'));"><i class="fa fa-calculator"></i> <%=trs.t("კალკულაცია")%></button>
    <button class="btn btn-info pull-right" onclick="getParams(jQuery('#analizelist').jqGrid('getGridParam','selrow'));"><i class="fa fa-wrench"></i> <%=trs.t("ნიმუშები")%></button>
    <button class="btn btn-info pull-right" onclick="getDevices(jQuery('#analizelist').jqGrid('getGridParam','selrow'));"><i class="fa fa-list"></i> <%=trs.t("პარამეტრები")%></button>
    <button class="btn btn-info pull-right" onclick="getNorm(jQuery('#analizelist').jqGrid('getGridParam','selrow'));"><i class="fa fa-thermometer"></i> <%=trs.t("ნორმატივები")%></button>
    <button class="btn btn-info pull-right" onclick="getPrices(jQuery('#analizelist').jqGrid('getGridParam','selrow'));"><i class="fa fa-dollar"></i> <%=trs.t("ფასები")%></button>
</div>
<div class="table-size2 active">
    <table id="analizelist"></table>
    <div id="pageranalizelist"></div>
</div>

<div class="modal fade" id="normModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id='normModalTitle'></h4>
            </div>
            <div class="modal-body">
                <div class="table-sizeModal" id='normbody'>
                    
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-success" onclick="savenorm()">
                    <%=trs.t("შენახვა")%> <span class="fa fa-save"></span>
                </button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">
                    <%=trs.t("დახურვა")%> <span class="fa fa-close"></span>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="controlModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog large">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id='controlModalTitle'></h4>
            </div>
            <div class="modal-body">
                <div class="table-sizeModal" id='controlbody'>
                    
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-success" onclick="savecontrol()">
                    <%=trs.t("შენახვა")%> <span class="fa fa-save"></span>
                </button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">
                    <%=trs.t("დახურვა")%> <span class="fa fa-close"></span>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="priceModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id='priceModalTitle'></h4>
            </div>
            <div class="modal-body">
                <div class="table-sizeModal" id='pricebody'>
                    
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">
                    <%=trs.t("დახურვა")%> <span class="fa fa-close"></span>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="calcModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog large">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id='calcModalTitle'><%=trs.t("კალკულაცია")%></h4>
            </div>
            <div class="modal-body" id='calcbody'>
                
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">
                    <%=trs.t("დახურვა")%> <span class="fa fa-close"></span>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="deviceModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog large">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id='deviceModalTitle'><%=trs.t("აპარატურა")%></h4>
            </div>
            <div class="modal-body" id='devicebody'>
                
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-danger" data-dismiss="modal">
                    <%=trs.t("დახურვა")%> <span class="fa fa-close"></span>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="paramsModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog large">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id='paramsModalTitle'></h4>
            </div>
            <div class="modal-body" id='paramsbody'>
                
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-success" onclick="saveparams()">
                    <%=trs.t("შენახვა")%> <span class="fa fa-save"></span>
                </button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">
                    <%=trs.t("დახურვა")%> <span class="fa fa-close"></span>
                </button>
            </footer>
        </div>
    </div>
</div>

