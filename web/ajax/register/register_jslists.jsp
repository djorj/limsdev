<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../includes/init.jsp" %>
<script>
pageSetUp();

var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);


       function run_jqgrid_function() {

        $("#report-field").show();
        
        var cid = $("#contract").val();
        var appealid = $("#appeal").val();
        var actid = $("#act").val();
        
        var res = getObject({contractid: cid, appealid: appealid, actid: actid, obj:"contractsample"});
        var opts = res.data;
        var act='active';
        var $tab = $("#analyses-tab");
        var $con = $("#analyses-tabcontent");
        var $rep = $("#report-sample");
        $tab.html("");
        $con.html("");
        $rep.html("");
        n=opts.length;
        for (i=0; i<n; i++) {
            $tab.append('<li class="'+act+'"><a href="#s'+opts[i].id+'" data-table="gridanalysis'+i+'" data-toggle="tab">'+opts[i].name+'</a></li>');
            $con.append('<div class="tab-pane fade in '+act+'" id="s'+opts[i].id+'" style="height: calc(100vh - 380px) !important;"><div class="table-size2"><table id="gridanalysis'+i+'"></table><div id="pagergridanalysis'+i+'"></div></div></div>');
            $rep.append(opts[i].name+'<br>');
            act = '';


            jQuery("#gridanalysis"+i).jqGrid({
                ajaxGridOptions: {cache: false},
                url: 'content/getcontractanalysislist.jsp?contractid='+cid+'&sampleid='+opts[i].id+"&appealid="+$("#appeal").val()+"&actid="+$("#act").val(),
                datatype: "json",
                colNames: ['id', '', '<%=trs.t("საწყისი")%>', '<%=trs.t("დასახელება")%>', '<%=trs.t("ლაბორატორია")%>', '<%=trs.t("შტრიხკოდი")%>','<%=trs.t("ფასი")%>', '<%=trs.t("ვადა")%>', '<%=trs.t("მოქმედება")%>','status'],
                colModel: [
                    {name: 'id', index: 'id', width: 1, hidden: true, key: true},
                    {name: 'cbb', index:'cbb', width: 30, align:'center', editable: false,  sortable: false },
                    {name: 'srcbarcode', index: 'srcbarcode', hidden: false, editable: true, sortable: false, align: "left", width: 100},
                    {name: 'name', index: 'name', hidden: false, editable: true, sortable: false, align: "left", width: 200},
                    {name: 'laboratory', index: 'laboratory', hidden: false, editable: true, sortable: false, align: "left", width: 150},
                    {name: 'code', index: 'code', hidden: false, editable: true, sortable: false, align: "center", width: 60},
                    {name: 'price', index: 'price', hidden: false, editable: true, sortable: false, align: "right", width: 50},
                    {name: 'enddays', index: 'enddays', hidden: false, editable: true, sortable: false, align: "right", width: 50},
                    {name: 'act', index: 'act', sortable: false, align: "right", width: 100},
                    {name: 'status', index: 'status', sortable: false, hidden: true, width: 0}
                ],
                rowNum: 20,
                height: 100,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery("#pagergridanalysis"+i),
                sortname: 'ord',
                viewrecords: true,
                footerrow: true,
                sortorder: "asc",
                title: "<%=trs.t("ნიმუშები")%>",
                gridComplete: function() {
                    var grid = $(this);
                    var ids = $(this).jqGrid('getDataIDs');
                    for (var i=0;  i<ids.length; i++)  {
                        var s=grid.getCell(ids[i], 'status');
                        if (s=="2") {
                            $('#' + ids[i]).addClass('stoped');            
                        }
                    }

                    $("button").tooltip({
                        container: 'body',
                        trigger : 'hover'
                    });
                    var sum = grid.jqGrid('getCol', 'price', false, 'sum');
                    grid.jqGrid('footerData', 'set', {name: '<%=trs.t("ჯამი")%>', price: sum});
                }
            }).navGrid("#pagergridanalysis"+i, {edit: false, add: false, del: true, view: false, search: false});
            jQuery("#gridanalysis"+i).jqGrid('inlineNav', "#pagergridanalysis"+i);
        }    

        opts = res.box;
        n += opts.length;
        for (; i<n; i++) {
            $tab.append('<li class="'+act+'"><a href="#s'+opts[i].id+'" data-table="gridanalysis'+i+'" data-toggle="tab">'+opts[i].name+'</a></li>');
            $con.append('<div class="tab-pane fade in '+act+'" id="s'+opts[i].id+'" style="height: calc(100vh - 380px) !important;"><div class="table-size2"><table id="gridanalysis'+i+'"></table><div id="pagergridanalysis'+i+'"></div></div></div>');
            $rep.append(opts[i].name+'<br>');
            act = '';


            jQuery("#gridanalysis"+i).jqGrid({
                ajaxGridOptions: {cache: false},
                url: 'content/getcontractanalysislist.jsp?contractid='+cid+'&sampleboxid='+opts[i].id,
                datatype: "json",
                colNames: ['id', '', '<%=trs.t("დასახელება")%>', '<%=trs.t("ლაბორატორია")%>', '<%=trs.t("შტრიხკოდი")%>','<%=trs.t("ფასი")%>', '<%=trs.t("ვადა")%>', '<%=trs.t("მოქმედება")%>'],
                colModel: [
                    {name: 'id', index: 'id', width: 1, hidden: true, key: true},
                    {name: 'cbb', index:'cbb', width: 30, align:'center', editable: false,  sortable: false },
                    {name: 'name', index: 'name', hidden: false, editable: true, sortable: false, align: "left", width: 200},
                    {name: 'laboratory', index: 'laboratory', hidden: false, editable: true, sortable: false, align: "left", width: 150},
                    {name: 'code', index: 'code', hidden: false, editable: true, sortable: false, align: "center", width: 60},
                    {name: 'price', index: 'price', hidden: false, editable: true, sortable: false, align: "right", width: 50},
                    {name: 'enddays', index: 'enddays', hidden: false, editable: true, sortable: false, align: "right", width: 50},
                    {name: 'act', index: 'act', sortable: false, align: "center", width: 100}
                ],
                rowNum: 20,
                height: 100,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery("#pagergridanalysis"+i),
                sortname: 'ord',
                viewrecords: true,
                footerrow: true,
                sortorder: "asc",
                title: "<%=trs.t("ნიმუშები")%>",
                gridComplete: function() {
                    var grid = $(this);

                    $("button").tooltip({
                        container: 'body',
                        trigger : 'hover'
                    });
                    var sum = grid.jqGrid('getCol', 'price', false, 'sum');
                    grid.jqGrid('footerData', 'set', {name: '<%=trs.t("ჯამი")%>', price: sum});
                }
            }).navGrid("#pagergridanalysis"+i, {edit: false, add: false, del: true, view: false, search: false});
            jQuery("#gridanalysis"+i).jqGrid('inlineNav', "#pagergridanalysis"+i);
        }    

            /* Add tooltips */
            $('.navtable .ui-pg-button').tooltip({
                container: 'body',
                trigger : 'hover'
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
            $(".ui-icon.ui-icon-3").removeClass().addClass("fa fa-trash-o").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");
            $(".ui-icon.ui-icon-trash, .ui-icon.ui-icon-refresh, .ui-icon.ui-icon-plus, .ui-icon.ui-icon-pencil, .ui-icon.ui-icon-disk, .ui-icon.ui-icon-cancel").parent().parent().remove();

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
                for (i=0; i<n; i++) 
                    jQuery("#gridanalysis"+i).jqGrid('setGridWidth', $("#grid-box").width() - 30);
            });


        } // end function


    };

var pagefunction2 = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);


       function run_jqgrid_function() {

            jQuery("#sampletable").jqGrid({
                url: 'content/getcontractsamplelist.jsp?contractid='+$("#contract").val()+"&appealid="+$("#appeal").val()+"&actid="+$("#act").val(),
                datatype: "json",
                treeGrid: true,
                treeGridModel: "adjacency",
                ExpandColumn: "sample",
                colNames: ['id', '<%=trs.t("ნიმუში")%>', '<%=trs.t("შტრიხკოდი")%>', '<%=trs.t("სახეობა")%>', '<%=trs.t("საველე.&nbsp;N")%>', '<%=trs.t("ცხოველის.&nbsp;N")%>', '<%=trs.t("რაოდენობა")%>', '<%=trs.t("კვლ.")%>', '<%=trs.t("მოქმედება")%>', '<input type="checkbox" id="selall" onclick="selall()">'],
                colModel: [
                    {name: 'id', index: 'id', width: 1, hidden: true, key: true},
                    {name: 'sample', index: 'sample', hidden: false, editable: true, sortable: false, align: "left", width: 180},
                    {name: 'code', index: 'code', hidden: false, editable: true, sortable: false, align: "center", width: 60, classes: 'barcode'},
                    {name: 'speciesid', index: 'speciesid', hidden: false, editable: true, sortable: false, align: "center", width: 80},
                    {name: 'number', index: 'number', hidden: false, editable: true, sortable: false, align: "center", width: 80},
                    {name: 'animal', index: 'animal', hidden: false, editable: true, sortable: false, align: "center", width: 80},
                    {name: 'count', index: 'count', hidden: false, editable: true, sortable: false, align: "center", width: 80},
                    {name: 'count1', index: 'count1', hidden: false, editable: true, sortable: false, align: "center", width: 30},
                    {name: 'act', index: 'act', hidden: false, editable: true, sortable: false, align: "center", width: 100, classes: 'nowrap'},
                    {name: 'cbb', index:'cbb', width: 30, align:'center', editable: false,  sortable: false }
                ],
                rowNum: 20,
                height: 100,
                //width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagersampletable'),
                sortname: 'ord',
                viewrecords: true,
                //footerrow: true,
                sortorder: "asc",
                //multiboxonly: true,
                //multiselect: true,
                title: "<%=trs.t("ნიმუშები")%>",
                gridComplete: function () {
                    $("button").tooltip({
                        container: 'body',
                        trigger : 'hover'
                    });
                    $('#selall').parent().removeClass('ui-jqgrid-sortable');
                }
            }).navGrid('#pagersampletable', {edit: false, add: false, del: false, view: false, search: false});
            jQuery("#sampletable").jqGrid('inlineNav', "#pagersampletable");

            /* Add tooltips */
            $('.navtable .ui-pg-button').tooltip({
                container: 'body',
                trigger : 'hover'
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
            $(".ui-icon.ui-icon-3").removeClass().addClass("fa fa-trash-o").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");
            $(".ui-icon.ui-icon-trash, .ui-icon.ui-icon-refresh, .ui-icon.ui-icon-plus, .ui-icon.ui-icon-pencil, .ui-icon.ui-icon-disk, .ui-icon.ui-icon-cancel").parent().parent().remove();
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
                jQuery("#sampletable").jqGrid('setGridWidth', $("#sample-box").width() - 30);
            });
        } // end function
    };
    
function researchtabs (opts) {

        var cid  = $("#contract").val();
        var act  ='active';
        var $tab = $("#analyses-tab");
        var $con = $("#analyses-tabcontent");
        var $rep = $("#report-sample");
        $tab.html("");
        $con.html("");
        $rep.html("");
        n=opts.length;
        for (i=0; i<n; i++) {
            $tab.append('<li class="'+act+'"><a href="#s'+opts[i].id+'" data-table="gridanalysis'+i+'" data-toggle="tab">'+opts[i].name+'</a></li>');
            $con.append('<div class="tab-pane fade in '+act+'" id="s'+opts[i].id+'" style="height: calc(100vh - 380px) !important;"><div class="table-size2"><table id="gridanalysis'+i+'"></table><div id="pagergridanalysis'+i+'"></div></div></div>');
            $rep.append(opts[i].name+'<br>');
            act = '';


            jQuery("#gridanalysis"+i).jqGrid({
                url: 'content/getcontractanalysislist.jsp?contractid='+cid+"&appealid="+$("#appeal").val()+"&actid="+$("#act").val()+'&sampleid='+opts[i].id,
                datatype: "json",
                colNames: ['id', '','<%=trs.t("დასახელება")%>', '<%=trs.t("ლაბორატორია")%>', '<%=trs.t("შტრიხკოდი")%>','<%=trs.t("ფასი")%>', '<%=trs.t("ვადა")%>', '<%=trs.t("მოქმედება")%>','status'],
                colModel: [
                    {name: 'id', index: 'id', width: 1, hidden: true, key: true},
                    {name: 'cbb', index:'cbb', width: 30, align:'center', editable: false,  sortable: false },
                    {name: 'name', index: 'name', hidden: false, editable: true, sortable: false, align: "left", width: 200},
                    {name: 'laboratory', index: 'laboratory', hidden: false, editable: true, sortable: false, align: "left", width: 150},
                    {name: 'code', index: 'code', hidden: false, editable: true, sortable: false, align: "center", width: 60},
                    {name: 'price', index: 'price', hidden: false, editable: true, sortable: false, align: "right", width: 50},
                    {name: 'enddays', index: 'enddays', hidden: false, editable: true, sortable: false, align: "right", width: 50},
                    {name: 'act', index: 'act', sortable: false, align: "center", width: 100},
                    {name: 'status', index: 'status', sortable: false, hidden: true, width: 0}
                ],
                rowNum: 20,
                height: 100,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery("#pagergridanalysis"+i),
                sortname: 'ord',
                viewrecords: true,
                footerrow: true,
                sortorder: "asc",
                title: "<%=trs.t("ნიმუშები")%>",
                gridComplete: function() {
                    var grid = $(this);
                    var ids = $(this).jqGrid('getDataIDs');
                    for (var i=0;  i<ids.length; i++)  {
                        var s=grid.getCell(ids[i], 'status');
                        if (s=="2") {
                            $('#' + ids[i]).addClass('stoped');            
                        }
                    }

                    $("button").tooltip({
                        container: 'body',
                        trigger : 'hover'
                    });
                    var sum = grid.jqGrid('getCol', 'price', false, 'sum');
                    grid.jqGrid('footerData', 'set', {name: '<%=trs.t("ჯამი")%>', price: sum});
                }
            }).navGrid("#pagergridanalysis"+i, {edit: false, add: false, del: true, view: false, search: false});
            jQuery("#gridanalysis"+i).jqGrid('inlineNav', "#pagergridanalysis"+i);
           


            /* Add tooltips */
            $('.navtable .ui-pg-button').tooltip({
                container: 'body',
                trigger : 'hover'
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
            $(".ui-icon.ui-icon-3").removeClass().addClass("fa fa-trash-o").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");
            $(".ui-icon.ui-icon-trash, .ui-icon.ui-icon-refresh, .ui-icon.ui-icon-plus, .ui-icon.ui-icon-pencil, .ui-icon.ui-icon-disk, .ui-icon.ui-icon-cancel").parent().parent().remove();

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
                for (i=0; i<n; i++) 
                    jQuery("#gridanalysis"+i).jqGrid('setGridWidth', $("#grid-box").width() - 30);
            });


        } // end function


    };
</script>