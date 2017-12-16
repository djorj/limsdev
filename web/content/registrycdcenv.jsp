<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
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
    
    function addPatient(id){
            $.post("content/envdialog.jsp",{ id: id },function(data){ 
                //var name = jQuery('#analizelist').jqGrid('getCell',id,'name');
                $("#patModalTitle").html("<%=trs.t("საკვლევი ობიექტის დამატება")%>");
                $('#patModal').modal('show');
                //showLoader("pricebody");
                $("#patbody").html(data);
            });
        
    }
    
    function addOrder(id){
        if(id > 0){
            $.post("content/orderdialogcdc.jsp",{ id: id },function(data){ 
                //var name = jQuery('#analizelist').jqGrid('getCell',id,'name');
                $("#orderModalTitle").html("<%=trs.t("შეკვეთის რეგისტრაცია")%>");
                $('#orderModal').modal('show');
                //showLoader("pricebody");
                $("#orderbody").html(data);
            });
            } else {
                alert('<%=trs.t("აირიეთ ჩანაწერი")%>');
            }
    }

    var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);

        function run_jqgrid_function() {

            var tbldata = [{
                    contr: "მედი ქლაბი",
                    pacient: "გიორგი გიორგაძე",
                    type: "წყლულის შიგთავსი",
                    sender: "ქუთაისის ზდლ",
                    address: "",
                    research: "ბაქტერიოლოგიური, მიკრობიოლოგიური",
                    count: "1",
                    status: "დადასტურებული"
                }];
            jQuery("#reestr").jqGrid({
//                treeGrid: true,
//                treeGridModel: "adjacency",
//                ExpandColumn: "code",
//                treedatatype: "local",
//                datatype: "jsonstring",
//                datastr: tbldata,
                datatype: "local",
                data: tbldata,
                colNames: ['<%=trs.t("დამკვეთი")%>', '<%=trs.t("პაციენტი")%>', '<%=trs.t("ნიმუშ(ებ)ის ტიპი")%>', '<%=trs.t("გამომგზავნი დაწესებულება")%>', '<%=trs.t("მისამართი")%>', '<%=trs.t("მოთხოვნილი გამოკვლევა")%>', '<%=trs.t("ნიმუშების რაოდენობა")%>', '<%=trs.t("სტატუსი")%>'],
                colModel: [
                    {name: 'contr', index: 'contr', editable: true, align: "left", width: 100},
                    {name: 'pacient', index: 'pacient', editable: true, align: "left", width: 100},
                    {name: 'type', index: 'type', editable: true, align: "left", width: 100},
                    {name: 'sender', index: 'sender', editable: true, align: "left", width: 100},
                    {name: 'address', index: 'address', editable: true, align: "left", width: 100},
                    {name: 'research', index: 'research', editable: true, align: "left", width: 100},
                    {name: 'count', index: 'count', editable: true, align: "left", width: 100},
                    {name: 'status', index: 'status', editable: true, align: "left", width: 100}
                ],
                rowNum: 20,
                //height: 200,
                //width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagerreestr'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updpersonelltype.jsp",
                caption: '<b><i class="fa fa-envira"></i> <%=trs.t("გარემო")%></b> <button class="btn btn-primary pull-right" onclick="showRegistry(\'registrycdchuman\')"><i class="fa fa-user"></i> <%=trs.t("ადამიანის ნიმუშზე გადასვლა")%></button>'
            })
                    .navGrid('#pagerreestr', {edit: false, add: false, del: false, view: false, search: false},
                            {dataheight: 150, width: 350, closeAfterEdit: true, reloadAfterSubmit: false, afterSubmit: checkStatus}, //  default settings for edit
                            {dataheight: 150, width: 350, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for add
                            {dataheight: 150, width: 350, reloadAfterSubmit: false, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 150, width: 350, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    )
            .navButtonAdd('#pagerreestr', {id: 'addpatient', caption: '<i class="fa fa-plus"></i> <%=trs.t("დამატება")%>', buttonicon: "none", onClickButton: function () { addPatient(0); }, position: 'last'})
            .navButtonAdd('#pagerreestr', {id: 'addorder', caption: '<i class="fa fa-wrench"></i> <%=trs.t("შეკვეთა")%>', buttonicon: "none", onClickButton: function () { addOrder(jQuery('#reestr').jqGrid('getGridParam','selrow')); }, position: 'last'})
            ;



            $('.navtable .ui-pg-button').tooltip({
                container: 'body'
            });

            // remove classes
            $(".ui-jqgrid-titlebar-close").remove();
            
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




            // update buttons

            $(window).on('resize.jqGrid', function () {
                jQuery("#reestr").jqGrid('setGridWidth', $("#content").width() - 10);
                jQuery("#reestr").jqGrid('setGridHeight', $("#content").height() - 100);
                //calc(100vh - 320px)
            })
        }
    }

    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);

    
</script>

<%--div class="col-md-12 btn-panel">
    <button class="btn btn-warning pull-right"><i class="fa fa-book"></i> <%=trs.t("შემოწმება")%></button>
    <button class="btn btn-success pull-right"><i class="fa fa-book"></i> <%=trs.t("მიღება")%></button>
</div--%>
<div class="table-size2 active">
    <table id="reestr"></table>
    <div id="pagerreestr"></div>
</div>