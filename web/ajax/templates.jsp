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

    var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);

        function run_jqgrid_function() {

            var tbldata = [{
                    date: "27/07/2016",
                    org: "ორგანიზაცია",
                    price: "15.00"
                }, {
                    date: "27/07/2016",
                    org: "ორგანიზაცია",
                    price: "15.00"
                }];

            jQuery("#test").jqGrid({
                data: tbldata,
                datatype: "local",
                colNames: ['<%=trs.t("თარიღი")%>', '<%=trs.t("ორგანიზაცია")%>', '<%=trs.t("ფასი")%>'],
                colModel: [
                    {name: 'date', index: 'date', editable: true, align: "left", width: 100},
                    {name: 'org', index: 'org', editable: true, align: "left", width: 100},
                    {name: 'price', index: 'price', editable: true, align: "left", width: 100}
                ],
                rowNum: 20,
                height: 350,
                width: 900,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagertest'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/upd.jsp",
                ondblClickRow: function (id, ri, ci) {
                    jQuery("#test").jqGrid('editGridRow', id, {dataheight: 450, width: 800, closeAfterEdit: true, reloadAfterSubmit: false, afterSubmit: checkStatus});
                    return;
                }
            })

                    .navGrid('#pagertest', {edit: false, add: false, del: false, view: false, search: false},
                            {dataheight: 450, width: 800, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for edit
                            {dataheight: 450, width: 800, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for add
                            {closeAfterDelete: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 450, width: 800, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    )
                    .navButtonAdd('#pagertest', {id: 'exporttest', caption: '<i class="fa fa-file-excel-o"></i> <%=trs.t("ექსპორტი")%>', buttonicon: "none", onClickButton: function () {

                        }, position: 'last'})
                    .navButtonAdd('#pagertest', {id: 'printtest', caption: '<i class="fa fa-print"></i>', buttonicon: "none", onClickButton: function () {

                        }, position: 'last'});

            $('.navtable .ui-pg-button').tooltip({
                container: 'body'
            });

            // remove classes
            $(".ui-jqgrid").removeClass("ui-widget ui-widget-content");
            $(".ui-jqgrid-view").children().removeClass("ui-widget-header ui-state-default");
            $(".ui-jqgrid-labels, .ui-search-toolbar").children().removeClass("ui-state-default ui-th-column ui-th-ltr");
            $(".ui-jqgrid-pagertest").removeClass("ui-state-default");
            $(".ui-jqgrid").removeClass("ui-widget-content");

            // add classes
            $(".ui-jqgrid-htable").addClass("table table-bordered table-hover");
            $(".ui-jqgrid-btable").addClass("table table-bordered table-striped");


            $(".ui-pg-div").removeClass().addClass("btn btn-sm btn-primary");

            $(".ui-icon.ui-icon-1").removeClass().addClass("fa fa-trash").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");

            $(".ui-icon.ui-icon-plus").removeClass().addClass("fa fa-plus").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");
            $(".ui-icon.ui-icon-pencil").removeClass().addClass("fa fa-pencil").parent(".btn-primary").removeClass("btn-primary").addClass("btn-warning");
            $(".ui-icon.ui-icon-trash").removeClass().addClass("fa fa-trash-o").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");
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
                jQuery("#test").jqGrid('setGridWidth', $(".test-size").width());
            })
        }
    }
    $(document).on("click", ".test", function () {
        loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);
    });
    $(document).on("click", ".save", function () {
        $("li.active.open ul").append('<li><a href="#">შაბლონი</a></li>');
    });
    $(document).on("change", "#upload-template", function () {
        $(".hid").show();
    });
    $(function () {

        $('#from, #to').datepicker({
            beforeShow: customRange,
            dateFormat: "dd M yy"
        });

    });

    function customRange(input) {

        if (input.id == 'to') {
            var minDate = new Date($('#from').val());
            minDate.setDate(minDate.getDate() + 1)

            return {
                minDate: minDate

            };
        }

        return {}

    }
</script>
<div class="smart-form col-md-6">
    <section class="col col-md-6">
        <label class="input"> <i class="icon-append fa fa-address-book"></i>
            <input name="contragent" list="templatename" type="text" value="" placeholder="<%=trs.t("შაბლონის დასახელება")%>">
            <b class="tooltip tooltip-top-right"><i class="fa fa-address-book txt-color-teal"></i> <%=trs.t("შაბლონის დასახელება")%></b>
            <datalist id="templatename">
                <option value="შაბლონი 1"></option>
                <option value="შაბლონი 2"></option>
                <option value="შაბლონი 3"></option>
                <option value="შაბლონი 4"></option>
                <option value="შაბლონი 5"></option>
            </datalist>
        </label>
    </section>
    <section class="col col-md-6">
        <label class="btn btn-primary change-pic contract-file">
            <span id="template"><%=trs.t("შაბლონის ატვირთვა")%></span>
            <input type="file" class="upload" id="upload-template"/>
        </label>
    </section>
    <section class="col col-md-3 hid" style="display: none;">
        <label class="input"> <i class="icon-append fa fa-calendar"></i>
            <input id="from" placeholder="<%=trs.t("თარიღიდან")%>" type="text">
            <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("თარიღიდან")%></b>
        </label>
    </section> 
    <section class="col col-md-3 hid" style="display: none;">
        <label class="input"> <i class="icon-append fa fa-calendar"></i>
            <input id="to" placeholder="<%=trs.t("თარიღამდე")%>" type="text">
            <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("თარიღამდე")%></b>
        </label>
    </section>  
    <section class="col col-md-6 hid" style="display: none;">
        <label class="input"> <i class="icon-append fa fa-institution"></i>
            <input name="contragent" list="receiver" type="text" value="" placeholder="<%=trs.t("შემკვეთი")%>">
            <b class="tooltip tooltip-top-right"><i class="fa fa-institution txt-color-teal"></i> <%=trs.t("შემკვეთი")%></b>
            <datalist id="receiver">
                <option value="ააიპ 107-ე საბავშვო ბაგა ბაღი"></option>
                <option value="ი.მ.,,აგიგათ მაშოვი"></option>
                <option value="ააიპ საბავშვო ბაგა-ბაღი N50"></option>
                <option value="ააიპ იმედის ექოსთან არსებული მარტოხელა ხანდაზმულთა პანსიონატი"></option>
                <option value="ააიპ #63-ე საბავშვო ბაგა ბაღი ,,ბატი-ბუტა"></option>
            </datalist>
        </label>
    </section>
    <section class="col col-md-12 hid" style="display: none;">
        <button class="btn btn-info test"><%=trs.t("შემოწმება")%></button>
        <button class="btn btn-success save"><%=trs.t("შენახვა")%></button>
        <button class="btn btn-danger"><%=trs.t("წაშლა")%></button>
    </section>
</div>
<div class="col-md-6 test-size">
    <div class="table-size1">
        <table id="test"></table>
        <div id="pagertest"></div>
    </div> 
</div>


