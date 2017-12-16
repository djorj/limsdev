<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%    String gridname = "supplier";
    String ses = "EXPORT_BAR_" + (new Date()).getTime();
    jqexport exp = new jqexport(ses, null, null, "EXPORT_STOP", "content/export_" + gridname + ".jsp", "");
%>
<style>
    #exportsamplelist {
        line-height: 1.19 !important;
    }
</style>
<%=exp.getExportAttr()%>
<script src="js/plugin/bootstrap-tags/bootstrap-tagsinput.min.js" type="text/javascript"></script>
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>
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
                    id: "1",
                    code: "236547821",
                    name: "გიორგი გიორგაძე",
                    type: "სისხლი",
                    diag: "შავი ჭირი",
                    date: "22/06/2017",
                    contragent: "ააიპ 107-ე საბავშვო ბაგა ბაღი",
                    number: "6516",
                    place: "მაცივარი N2",
                    status: "მიმდინარე",
                    act: '<button onclick="showban()" class="btn btn-warning tip" data-original-title="<%=trs.t("დაწუნება")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-ban"></i> </button> <button onclick="showdestroy()" class="btn btn-danger tip" data-original-title="<%=trs.t("განადგურება")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-bomb"></i> </button> <button onclick="showinfo()" class="btn btn-primary tip" data-original-title="<%=trs.t("ნიმუშის ისტორია")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-info"></i> </button> <button onclick="showDoc()" class="btn btn-primary tip" data-original-title="<%=trs.t("თანმხლები ფორმა")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-file"></i> </button> <button class="btn btn-primary showcode tip" data-original-title="<%=trs.t("ბეჭდვა")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-print"></i> </button>',
                    // level: 0, parent: "NULL", isLeaf: false, loaded: false, expanded: true
                }, {
                    id: "2",
                    code: "143245435",
                    name: "გიორგი გიორგაძე",
                    type: "სისხლი",
                    diag: "შავი ჭირი",
                    date: "22/06/2017",
                    contragent: "ააიპ 107-ე საბავშვო ბაგა ბაღი",
                    number: "6854",
                    place: "მაცივარი N1",
                    status: "დაწუნებული",
                    act: '<button onclick="showban()" class="btn btn-warning tip" data-original-title="<%=trs.t("დაწუნება")%>"  type="button" style="height: 34px !important;"><i class="fa fa-xm fa-ban"></i> </button> <button onclick="showdestroy()" class="btn btn-danger tip" data-original-title="<%=trs.t("განადგურება")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-bomb"></i> </button> <button onclick="showinfo()" class="btn btn-primary tip" data-original-title="<%=trs.t("ნიმუშის ისტორია")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-info"></i> </button> <button onclick="showDoc()" class="btn btn-primary tip" data-original-title="<%=trs.t("თანმხლები ფორმა")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-file"></i> </button> <button class="btn btn-primary showcode tip" data-original-title="<%=trs.t("ბეჭდვა")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-print"></i> </button> <button class="btn btn-danger tip" data-original-title="<%=trs.t("წაშლა")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-trash"></i> </button>',
                    // level: 1, parent: 1, isLeaf: true, loaded: false, expanded: true
                }, {
                    id: "3",
                    code: "235254536",
                    name: "თეონა კვარაცხელია",
                    type: "სისხლი",
                    diag: "შავი ჭირი",
                    date: "22/06/2017",
                    contragent: "ააიპ 107-ე საბავშვო ბაგა ბაღი",
                    number: "8565",
                    place: "მაცივარი N12",
                    status: "გასანადგურებელი",
                    act: '<button onclick="showban()" class="btn btn-warning tip" data-original-title="<%=trs.t("დაწუნება")%>"  type="button" style="height: 34px !important;"><i class="fa fa-xm fa-ban"></i> </button> <button onclick="showdestroy()" class="btn btn-danger tip" data-original-title="<%=trs.t("განადგურება")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-bomb"></i> </button> <button onclick="showinfo()" class="btn btn-primary tip" data-original-title="<%=trs.t("ნიმუშის ისტორია")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-info"></i> </button> <button onclick="showDoc()" class="btn btn-primary tip" data-original-title="<%=trs.t("თანმხლები ფორმა")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-file"></i> </button> <button class="btn btn-primary showcode tip" data-original-title="<%=trs.t("ბეჭდვა")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-print"></i> </button>',
                    //level: 0, parent: "NULL", isLeaf: true, loaded: true, expanded: true
                }, {
                    id: "4",
                    code: "457456456",
                    name: "ხვიჩა გუგულიშვილი",
                    type: "სისხლი",
                    diag: "შავი ჭირი",
                    date: "22/06/2017",
                    contragent: "ააიპ 107-ე საბავშვო ბაგა ბაღი",
                    number: "2344",
                    place: "",
                    status: "გადასაგზავნი",
                    act: '<button onclick="showban()" class="btn btn-warning tip" data-original-title="<%=trs.t("დაწუნება")%>"  type="button" style="height: 34px !important;"><i class="fa fa-xm fa-ban"></i> </button> <button onclick="showdestroy()" class="btn btn-danger tip" data-original-title="<%=trs.t("განადგურება")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-bomb"></i> </button> <button onclick="showinfo()" class="btn btn-primary tip" data-original-title="<%=trs.t("ნიმუშის ისტორია")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-info"></i> </button> <button onclick="showDoc()" class="btn btn-primary tip" data-original-title="<%=trs.t("თანმხლები ფორმა")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-file"></i> </button> <button class="btn btn-primary showcode tip" data-original-title="<%=trs.t("ბეჭდვა")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-print"></i> </button> <button onclick="showsendModal()" class="btn btn-success tip" data-original-title="<%=trs.t("გადაცემა")%>" type="button" style="height: 34px !important;"><i class="fa fa-xm fa-plane"></i> </button>',
                    //level: 0, parent: "NULL", isLeaf: true, loaded: true, expanded: true
                }];
            jQuery("#samplelist").jqGrid({
//                treeGrid: true,
//                treeGridModel: "adjacency",
//                ExpandColumn: "code",
//                treedatatype: "local",
//                datatype: "jsonstring",
//                datastr: tbldata,
                datatype: "local",
                data: tbldata,
                colNames: ['<%=trs.t("ბარკოდი")%>', '<%=trs.t("სახელი, გვარი")%>', '<%=trs.t("ნიმუშის ტიპი")%>', '<%=trs.t("სავარაუდო დიაგნოზი")%>', '<%=trs.t("თარიღი")%>', '<%=trs.t("დამკვეთი")%>', '<%=trs.t("საველე N")%>', '<%=trs.t("ადგილმდებარეობა")%>', '<%=trs.t("სტატუსი")%>', '<%=trs.t("მოქმედება")%>'],
                colModel: [
                    {name: 'code', index: 'code', editable: true, align: "left", width: 100},
                    {name: 'name', index: 'name', editable: true, align: "left", width: 100},
                    {name: 'type', index: 'type', editable: true, align: "left", width: 100},
                    {name: 'diag', index: 'diag', editable: true, align: "left", width: 100},
                    {name: 'date', index: 'date', editable: true, align: "left", width: 100},
                    {name: 'contragent', index: 'contragent', editable: true, align: "left", width: 100},
                    {name: 'number', index: 'number', editable: true, align: "left", width: 100},
                    {name: 'place', index: 'place', editable: true, align: "left", width: 100},
                    {name: 'status', index: 'status', editable: true, align: "left", width: 100},
                    {name: 'act', index: 'act', editable: true, align: "left", width: 250}
                ],
                rowNum: 20,
                height: 300,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagersamplelist'),
                sortname: 'name',
                viewrecords: true,
                multiselect: true,
                sortorder: "asc",
                editurl: "content/updpersonelltype.jsp",
                caption: '',
                gridComplete: function () {
                    $(".tip").tooltip({
                        container: 'body'
                    });
                }
            })
                    .navGrid('#pagersamplelist', {edit: false, add: false, del: false, view: false, search: false},
                            {dataheight: 150, width: 350, closeAfterEdit: true, reloadAfterSubmit: false, afterSubmit: checkStatus}, //  default settings for edit
                            {dataheight: 150, width: 350, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for add
                            {dataheight: 150, width: 350, reloadAfterSubmit: false, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 150, width: 350, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
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
                jQuery("#samplelist").jqGrid('setGridWidth', $("#content").width() - 10);
            })
        }
    }

    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);

    function showban() {
        $("#banModal").modal("show");
    }
    function showdestroy() {
        $("#destroyModal").modal("show");
    }
    function showinfo() {
        $("#infoModal").modal("show");
    }
    function showDoc() {
        $("#docModal").modal("show");
    }

    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!
    var yyyy = today.getFullYear();

    if (dd < 10) {
        dd = '0' + dd;
    }

    if (mm < 10) {
        mm = '0' + mm;
    }

    today = dd + '/' + mm + '/' + yyyy;
    $("#now").val(today);

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
    $(document).on("click", ".jarviswidget-toggle-btn", function () {
        $(".table-size15").toggleClass("active");
    });
    $(document).on("change", "input[name='radio1']", function () {
        var id = $("input[name='radio1']:checked").attr('id');
        if (id == "radio1-1") {
            $(".con1").show();
            $(".con2").hide();
        } else if (id == "radio1-2") {
            $(".con1").hide();
            $(".con2").show();
        }
    });
    $(document).on("change", ".onchange", function () {
        var val = $(".onchange option:selected").html();
        if ($(this).val() == "0") {
            $(".controls0").show();
            $(".controls1").hide();
            $(".controls2").hide();
        } else if ($(this).val() == "1") {
            $(".controls0").hide();
            $(".controls1").show();
            $(".controls2").hide();
        } else if ($(this).val() == "2") {
            $(".controls0").hide();
            $(".controls1").hide();
            $(".controls2").show();
        }
        $("#test-list").append('<div class="full"><span class="chtest">' + val + '<i class="fa fa-times"></i></span></div>');
    });
    $(document).on("change", ".test-list1", function () {
        var val = $(".test-list1 option:selected").html();
        $("#test-list").append('<span class="chtest">' + val + '<i class="fa fa-times"></i></span>');
    });
    $(document).on("change", ".test-list2", function () {
        var val = $(".test-list2 option:selected").html();
        $("#test-list").append('<span class="chtest">' + val + '<i class="fa fa-times"></i></span>');
    });
    $(document).on("change", ".test-list3", function () {
        var val = $(".test-list3 option:selected").html();
        $("#test-list").append('<span class="chtest">' + val + '<i class="fa fa-times"></i></span>');
    });
    function showsendModal() {
        $("#sendModal").modal("show")
    }
    $(document).on("change", "input[name='checkbox3']", function () {
        if ($(this).is(":checked")) {
            $(".con5").show();
            $(".con4").hide();
        } else {
            $(".con5").hide();
            $(".con4").show();
        }
    });
    $(".datetime").datetimepicker({
        format: 'DD/MM/YYYY HH:mm'
    });
    var currentdate = new Date();
    var datetime = currentdate.getDate() + "/"
            + ("0" + (currentdate.getMonth() + 1)).slice(-2) + "/"
            + currentdate.getFullYear() + " "
            + currentdate.getHours() + ":"
            + currentdate.getMinutes()
    $(".now").val(datetime);
</script>
<section id="widget-grid" class="" style="padding-right: 5px;">
    <div class="jarviswidget" data-widget-collapsed="true" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false">
        <header>
            <h2><%=trs.t("ფილტრი")%></h2>
        </header>
        <div>
            <div class="smart-form col-sm-12" style="padding: 0;">
                <div class="col-sm-12">
                    <section class="col col-sm-12">
                        <label class="input"> <i class="icon-append fa fa-barcode"></i>
                            <input class="tagsinput" data-role="tagsinput" placeholder="<%=trs.t("ბარკოდი")%>" type="text" style="display: none;">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-barcode txt-color-teal"></i> <%=trs.t("ბარკოდი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-user"></i>
                            <input placeholder="<%=trs.t("პაციენტის სახელი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-barcode txt-color-teal"></i> <%=trs.t("პაციენტის სახელი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-user"></i>
                            <input placeholder="<%=trs.t("პაციენტის გვარი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-barcode txt-color-teal"></i> <%=trs.t("პაციენტის გვარიწ")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("თარიღი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("თარიღი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input placeholder="<%=trs.t("საველე N")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-list-ol txt-color-teal"></i> <%=trs.t("საველე N")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-map-marker"></i>
                            <input placeholder="<%=trs.t("ადგილმდებარეობა")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-map-marker txt-color-teal"></i> <%=trs.t("ადგილმდებარეობა")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select multiple="" class="select2" placeholder="<%=trs.t("ნიმუშის ტიპი")%>">
                                <option value="0"><%=trs.t("ნიმუშის ტიპი")%></option>
                            </select>
                            <b class="tooltip tooltip-top-right"><%=trs.t("ნიმუშის ტიპი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select multiple="" class="select2" placeholder="<%=trs.t("დამკვეთი")%>">
                                <option value="0"><%=trs.t("დამკვეთი")%></option>
                            </select>
                            <b class="tooltip tooltip-top-right"><%=trs.t("დამკვეთი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select multiple="" class="select2" placeholder="<%=trs.t("სტატუსი")%>">
                                <option value="0"><%=trs.t("სტატუსი")%></option>
                            </select>
                            <b class="tooltip tooltip-top-right"><%=trs.t("სტატუსი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select multiple="" class="select2" placeholder="<%=trs.t("სავარაუდო დიაგნოზი")%>">
                                <option value="0"><%=trs.t("დიაგნოზი")%></option>
                            </select>
                            <b class="tooltip tooltip-top-right"><%=trs.t("სავარაუდო დიაგნოზი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-12">
                        <button class="btn btn-info pull-right"><i class="fa fa-times"></i> <%=trs.t("გასუფთავება")%></button>
                        <button class="btn btn-success pull-right" style='margin-right: 5px;'><i class="fa fa-search"></i> <%=trs.t("ძებნა")%></button>
                    </section>
                </div>
            </div>
        </div>
    </div>
</section>
<div class="col-md-12 btn-panel">
    <button class="btn btn-success pull-right" onclick="$('#testModal').modal('show')"><i class="fa fa-book"></i> <%=trs.t("ტესტის დანიშვნა")%></button>
    <button class="btn btn-primary pull-right" onclick="$('#makeModal').modal('show')"><i class="fa fa-book"></i> <%=trs.t("სინჯის მომზადება")%></button>
    <button class="btn btn-success pull-right" onclick="$('#sendModal').modal('show')"><i class="fa fa-plane"></i> <%=trs.t("გადაცემა")%></button>
</div>
<div class="table-size15 active">
    <table id="samplelist"></table>
    <div id="pagersamplelist"></div>
</div>
<div class="modal fade" id="banModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("დაწუნება")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
                    <section class="col col-sm-12">
                        <label class="label"><%=trs.t("დაწუნების მიზეზი")%></label>
                        <label class="textarea"> <i class="icon-append fa fa-info"></i>
                            <textarea></textarea>
                        </label>
                    </section>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("გაუქმება")%>
                </button>
                <button type="button" class="btn btn-warning" data-dismiss="modal">
                    <%=trs.t("დაწუნება")%>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="destroyModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("განადგურება")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
                    <section class="col col-sm-6">
                        <label class="label"><%=trs.t("მეთოდი")%></label>
                        <label class="select">
                            <select>
                                <option><%=trs.t("მეთოდი")%></option>
                            </select><i></i>
                        </label>
                    </section>
                    <section class="col col-sm-6">
                        <label class="label"><%=trs.t("თარიღი")%></label>
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input id="now" type="text"/>
                        </label>
                    </section>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("გაუქმება")%>
                </button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">
                    <%=trs.t("განადგურება")%>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="infoModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ისტორია")%></h4>
            </div>
            <div class="modal-body">
                <article class="col-xs-12 sortable-grid ui-sortable" id="lp1">
                    <div class="tree smart-form">
                        <ul id='producttree'>
                            <li class="parent_li" role="treeitem">
                                <span groupid="2" title="Collapse this branch"><i class="fa fa-lg fa-minus-circle"></i> ზუგდიდი LSS</span>
                                <ul role="group">
                                    <li>
                                        <span groupid="9" class="pleaf"><i class="icon-leaf"></i> ქუთაისი ZDL</span>
                                        <ul role="group">
                                            <li>
                                                <span groupid="9" class="pleaf"><i class="icon-leaf"></i> ქუთაისი ZDL - ბაქტეროლოგია</span>
                                                <ul role="group">
                                                    <li>
                                                        <span groupid="9" class="pleaf"><i class="icon-leaf"></i> ბაქტეროლოგია</span>
                                                    </li>
                                                    <li>
                                                        <span groupid="9" class="pleaf"><i class="icon-leaf"></i> მიკრობიოლოგია</span>
                                                    </li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </article>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("დახურვა")%>
                </button>
            </footer>
        </div>
    </div>
</div>     
<div class="modal fade" id="testModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ტესტის დანიშვნა")%></h4>
            </div>
            <div class="modal-body">
                <div class='smart-form'>
                    <section class="col col-sm-12">
                        <label class='label'><%=trs.t("კვლევა")%></label>
                        <label class="select">
                            <select class="onchange">
                                <option value="0"><%=trs.t("- ყველა -")%></option>
                                <option value="1"><%=trs.t("ადამიანის ნიმუშების კვლევა შავი ჭირის გამომწვევზე.")%></option>
                                <option value="2"><%=trs.t("ადამიანის ნიმუშების კვლევა ჯილეხის გამომწვევზე.")%></option>
                            </select><i></i>
                        </label>
                    </section>
                    <section class="col col-sm-12 controls0">
                        <label class='label'><%=trs.t("ტესტები")%></label>
                        <label class="select">
                            <select class="test-list1">
                                <option value="0"><%=trs.t("- აირჩიეთ -")%></option>
                                <option value="1"><%=trs.t("დათესვა SBA აგარზე")%></option>
                                <option value="2"><%=trs.t("დათესვა მაკ-კონკის  აგარზე.")%></option>
                                <option value="3"><%=trs.t("დათესვა CIN აგარზე")%></option>
                                <option value="4"><%=trs.t("დათესვა BHIB ბულიონში")%></option>
                                <option value="5"><%=trs.t("დათესვა PLET აგარზე.")%></option>
                                <option value="6"><%=trs.t("ჩათესვა თხევად საკვებ ნიადაგში.")%></option>
                                <option value="7"><%=trs.t("დათესვა SBA აგარზე.")%></option>
                                <option value="8"><%=trs.t("დათესვა BHIB ბულიონში")%></option>
                            </select><i></i>
                        </label>
                    </section>
                    <section class="col col-sm-12 controls1" style="display: none;">
                        <label class='label'><%=trs.t("ტესტები")%></label>
                        <label class="select">
                            <select class="test-list2">
                                <option value="0"><%=trs.t("- აირჩიეთ -")%></option>
                                <option value="1"><%=trs.t("დათესვა SBA აგარზე.")%></option>
                                <option value="2"><%=trs.t("დათესვა მაკ-კონკის  აგარზე.")%></option>
                                <option value="3"><%=trs.t("დათესვა CIN აგარზე")%></option>
                                <option value="4"><%=trs.t("დათესვა BHIB ბულიონში")%></option>
                            </select><i></i>
                        </label>
                    </section>
                    <section class="col col-sm-12 controls2" style="display: none;">
                        <label class='label'><%=trs.t("ტესტები")%></label>
                        <label class="select">
                            <select class="test-list3">
                                <option value="0"><%=trs.t("- აირჩიეთ -")%></option>
                                <option value="1"><%=trs.t("დათესვა PLET აგარზე.")%></option>
                                <option value="2"><%=trs.t("ჩათესვა თხევად საკვებ ნიადაგში.")%></option>
                                <option value="3"><%=trs.t("დათესვა SBA აგარზე.")%></option>
                                <option value="4"><%=trs.t("დათესვა BHIB ბულიონში")%></option>
                            </select><i></i>
                        </label>
                    </section>
                    <section class="col col-sm-12">
                        <div id='test-list'>

                        </div>
                    </section>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("გაუქმება")%>
                </button>
                <button type="button" class="btn btn-success" data-dismiss="modal">
                    <%=trs.t("შენახვა")%>
                </button>
            </footer>
        </div>
    </div>
</div>         
<div class="modal fade" id="makeModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("სინჯის მომზადება")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
                    <section class="col col-sm-12">
                        <div class="inline-group">
                            <label class="radio">
                                <input id="radio1-1" name="radio1" type="radio">
                                <i></i><%=trs.t("ალიქვოტირება")%></label>
                            <label class="radio">
                                <input id="radio1-2" name="radio1" type="radio">
                                <i></i><%=trs.t("დერივატირება")%></label>
                        </div>
                    </section>
                    <section class="col col-sm-6 con1" style='display: none;'>
                        <label class="label"><%=trs.t("რაოდენობა")%></label>
                        <label class="input"> <i class="icon-append fa fa-phone"></i>
                            <input placeholder="<%=trs.t("რაოდენობა")%>" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-6 con2" style='display: none;'>
                        <label class="label"><%=trs.t("რაოდენობა")%></label>
                        <label class="input"> <i class="icon-append fa fa-phone"></i>
                            <input placeholder="<%=trs.t("რაოდენობა")%>" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-6 con2" style='display: none;'>
                        <label class="label"><%=trs.t("ტიპი")%></label>
                        <label class="select">
                            <select>
                                <option value="0"><%=trs.t("- ტიპი -")%></option>
                                <option value="1"><%=trs.t("შრატი")%></option>
                                <option value="2"><%=trs.t("პლაზმა")%></option>
                                <option value="1"><%=trs.t("რნმ")%></option>
                                <option value="2"><%=trs.t("დნმ")%></option>
                            </select><i></i>
                        </label>
                    </section>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("გაუქმება")%>
                </button>
                <button type="button" class="btn btn-success" data-dismiss="modal">
                    <%=trs.t("შენახვა")%>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="sendModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("გადაცემა")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
                    <section class="col col-sm-12">
                        <label class="checkbox">
                            <input name="checkbox3" type="checkbox">
                            <i></i><%=trs.t("გარე გადაცემა")%></label>
                    </section>
                    <section class="col col-sm-6 con4">
                        <label class="label"><%=trs.t("დეპარტამენტი")%></label>
                        <label class="select">
                            <select>
                                <option value="0"><%=trs.t("- დეპარტამენტი -")%></option>
                            </select><i></i>
                        </label>
                    </section>
                    <section class="col col-sm-6 con4">
                        <label class="label"><%=trs.t("გადაცემის თარიღი/დრო")%></label>
                        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                            <input class='datetime now' placeholder="<%=trs.t("გადაცემის თარიღი/დრო")%>" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-4 con5" style='display: none;'>
                        <label class="label"><%=trs.t("დამცავი კონტეინერის N")%></label>
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input placeholder="<%=trs.t("დამცავი კონტეინერის N")%>" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-4 con5" style='display: none;'>
                        <label class="label"><%=trs.t("მიმღები დაწესებულება")%></label>
                        <label class="input"> <i class="icon-append fa fa-institution"></i>
                            <input placeholder="<%=trs.t("მიმღები დაწესებულება")%>" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-4 con5" style='display: none;'>
                        <label class="label"><%=trs.t("გამომკვლევი დაწესებულება")%></label>
                        <label class="input"> <i class="icon-append fa fa-home"></i>
                            <input placeholder="<%=trs.t("გამომკვლევი დაწესებულება")%>" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-12 con5" style='display: none;'>
                        <label class="label"><%=trs.t("ტრანსპ. პასუხისმგებელი პირები")%></label>
                        <label class="input"> <i class="icon-append fa fa-users"></i>
                            <input class="tagsinput" data-role="tagsinput" placeholder="<%=trs.t("ტრანსპ. პასუხისმგებელი პირები")%>" type="text" style="display: none;">
                        </label>
                    </section>
                    <section class="col col-sm-12">
                        <label class="label"><%=trs.t("დანიშნულება")%></label>
                        <label class="textarea"> <i class="icon-append fa fa-globe"></i>
                            <textarea placeholder="" type="text"></textarea>
                        </label>
                    </section>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("გაუქმება")%>
                </button>
                <button type="button" class="btn btn-success" data-dismiss="modal">
                    <%=trs.t("შენახვა")%>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="docModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 1200px;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ფორმა")%></h4>
            </div>
            <div class="modal-body">
                <object data="documents/gggg.pdf" type="application/pdf" width="100%" style="height: calc(100vh - 251px)"><%=trs.t("თქვენ ბრაუზერს არ შეუძლია PDF-ის გახსნა")%></object>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("დახურვა")%>
                </button>
            </footer>
        </div>
    </div>
</div>
