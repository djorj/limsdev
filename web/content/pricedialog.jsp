<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
    
%>
<script>
    pageSetUp();
    
            jQuery("#pricegrid").jqGrid({
                        url:'content/getpricelist.jsp?labtestid=<%=labtest.getLabtestid()%>',
                        datatype: "json",
                        colNames: ['<%=trs.t("თარიღი")%>', '<%=trs.t("მიზეზი")%>', '<%=trs.t("ფასი")%>'],
                        colModel: [
                            {name: 'pricedate', index: 'pricedate', editable: true, align: "left", datefmt:"dd/mm/yyyy", edittype:"text", editoptions:{size:"10",maxlength:"10",defaultValue:'<%=dt.format(new Date())%>',dataInit: function(element) {$(element).datepicker();}},editrules:{required: true, date: true}},
                            {name: 'reason', index: 'reason', editable: true, align: "left", edittype:"textarea", editoptions:{cols:"30",rows:"3"},editrules:{required: true}},
                            {name: 'price', index: 'price', editable: true, align: "right", edittype:"text",editoptions:{size:"10"},editrules:{required: true,number:true}}
                        ],
                        rowNum: 20,
                        height: 350,
                        width: 900,
                        autowidth: true,
                        rowList: [],
                        pager: jQuery('#pagerpricegrid'),
                        sortname: 'pricedate',
                        pgbuttons: false,
                        pgtext: null,
                        viewrecords: false,
                        sortorder: "desc",
                        editurl: "content/updprice.jsp?labtestid=<%=labtest.getLabtestid()%>"
                    })
                            .navGrid('#pagerpricegrid', {edit:<%=permissions[1]%>,add:<%=permissions[0]%>,del:<%=permissions[2]%>,view:false,search:false},
                                    {dataheight: 230, width: 300, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus,recreateForm:true,afterShowForm : function (formid) {$('.FormElement').on('focusin', function(e) {e.stopPropagation();}); rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>'); $("#reason").focus(); }}, //  default settings for edit
                                    {dataheight: 230, width: 300, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus,recreateForm:true,afterShowForm : function (formid) {$('.FormElement').on('focusin', function(e) {e.stopPropagation();}); rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>'); $("#reason").focus(); }}, //  default settings for add
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

           
            jQuery("#pricegrid").jqGrid('setGridWidth', 550);

    
</script>

<table id="pricegrid"></table>
<div id="pagerpricegrid"></div>