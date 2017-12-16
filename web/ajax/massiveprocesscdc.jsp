<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
%>
<script>
    pageSetUp();

    function showmsg(text) {
        $("#msgModal").modal("show");
        $("#message").html(text);
    }

    function showmsgban() {
        $("#banModal").modal("show");
    }

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
                    n: "1",
                    id: "1",
                    num: "120",
                    diagnos: "",
                    code: '<img src="img/code.png" alt="" height="25"/>',
                    ans: "",
                    print: '<button class="btn btn-danger" type="button" onclick="showmsg(\'დარწმუნებული ხართ, რომ გნებავთ ჩანაწერის წაშლა?\')" style="height: 34px !important;"><i class="fa fa-xm fa-trash"></i> </button> <button class="btn btn-warning" type="button" onclick="showmsgban()" style="height: 34px !important;"><i class="fa fa-xm fa-ban"></i> </button>'
                }, {
                    n: "2",
                    id: "2",
                    num: "2",
                    diagnos: "",
                    code: '<img src="img/code.png" alt="" height="25"/>',
                    ans: "",
                    print: '<button class="btn btn-danger" type="button" onclick="showmsg(\'დარწმუნებული ხართ, რომ გნებავთ ჩანაწერის წაშლა?\')" style="height: 34px !important;"><i class="fa fa-xm fa-trash"></i> </button> <button class="btn btn-warning" type="button" onclick="showmsgban()" style="height: 34px !important;"><i class="fa fa-xm fa-ban"></i> </button>'
                }, {
                    n: "3",
                    id: "3",
                    num: "980",
                    diagnos: "",
                    code: '<img src="img/code.png" alt="" height="25"/>',
                    ans: "",
                    print: '<button class="btn btn-danger" type="button" onclick="showmsg(\'დარწმუნებული ხართ, რომ გნებავთ ჩანაწერის წაშლა?\')" style="height: 34px !important;"><i class="fa fa-xm fa-trash"></i> </button> <button class="btn btn-warning" type="button" onclick="showmsgban()" style="height: 34px !important;"><i class="fa fa-xm fa-ban"></i> </button>'
                }];
            var tbldata1 = [{
                    n: "1",
                    id: "1",
                    num: "122",
                    diagnos: "",
                    code: '',
                    ans: "",
                    print: '<button class="btn btn-success" type="button" onclick="showmsg(\'დარწმუნებული ხართ, რომ გნებავთ დაწუნებულის უკან დაბრუნება?\')" style="height: 34px !important;"><i class="fa fa-xm fa-refresh"></i> </button>'
                }, {
                    n: "2",
                    id: "2",
                    num: "23",
                    diagnos: "",
                    code: '',
                    ans: "",
                    print: '<button class="btn btn-success" type="button" onclick="showmsg(\'დარწმუნებული ხართ, რომ გნებავთ დაწუნებულის უკან დაბრუნება?\')" style="height: 34px !important;"><i class="fa fa-xm fa-refresh"></i> </button>'
                }];
            jQuery("#numeration").jqGrid({
                data: tbldata,
                datatype: "local",
                colNames: ['N', '<%=trs.t("საველე N")%>', '<%=trs.t("სავარაუდო დიაგნოზი")%>', '<%=trs.t("ბარკოდი")%>', '<%=trs.t("პასუხი")%>', '<%=trs.t("მოქმედება")%>'],
                colModel: [
                    {name: 'n', index: 'n', editable: true, align: "right", width: 50, edittype: "text", editoptions: {size: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'num', index: 'num', editable: true, align: "center", width: 200, edittype: "text", editoptions: {size: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'diagnos', index: 'diagnos', editable: true, align: "center", width: 200, edittype: "text", editoptions: {size: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'code', index: 'code', editable: true, align: "center", width: 200, edittype: "textarea", editoptions: {rows: "3", cols: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'ans', index: 'ans', editable: true, align: "center", width: 150, edittype: "text", editoptions: {size: "8"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'print', index: 'print', editable: true, align: "center", width: 150, edittype: "text", editoptions: {size: "8"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}}
                ],
                rowNum: 20,
                height: 300,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagernumeration'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updpersonelltype.jsp",
                caption: ''
            })
                    .navGrid('#pagernumeration', {edit: false, add: false, del: false, view: false, search: false},
                            {dataheight: 150, width: 350, closeAfterEdit: true, reloadAfterSubmit: false, afterSubmit: checkStatus}, //  default settings for edit
                            {dataheight: 150, width: 350, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for add
                            {dataheight: 150, width: 350, reloadAfterSubmit: false, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 150, width: 350, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    );

            jQuery("#numeration1").jqGrid({
                data: tbldata1,
                datatype: "local",
                colNames: ['N', '<%=trs.t("საველე N")%>', '<%=trs.t("სავარაუდო დიაგნოზი")%>', '<%=trs.t("დაწუნების მიზეზი")%>', '<%=trs.t("პასუხი")%>', '<%=trs.t("მოქმედება")%>'],
                colModel: [
                    {name: 'n', index: 'n', editable: true, align: "right", width: 50, edittype: "text", editoptions: {size: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'num', index: 'num', editable: true, align: "center", width: 200, edittype: "text", editoptions: {size: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'diagnos', index: 'diagnos', editable: true, align: "center", width: 200, edittype: "text", editoptions: {size: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'code', index: 'code', editable: true, align: "center", width: 200, edittype: "textarea", editoptions: {rows: "3", cols: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'ans', index: 'ans', editable: true, align: "center", width: 150, edittype: "text", editoptions: {size: "8"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'print', index: 'print', editable: true, align: "center", width: 150, edittype: "text", editoptions: {size: "8"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}}
                ],
                rowNum: 20,
                height: 300,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagernumeration1'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updpersonelltype.jsp",
                caption: ''
            })
                    .navGrid('#pagernumeration1', {edit: false, add: false, del: false, view: false, search: false},
                            {dataheight: 150, width: 350, closeAfterEdit: true, reloadAfterSubmit: false, afterSubmit: checkStatus}, //  default settings for edit
                            {dataheight: 150, width: 350, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for add
                            {dataheight: 150, width: 350, reloadAfterSubmit: false, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 150, width: 350, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    )
                    ;

            /* Add tooltips */
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
                jQuery("#numeration").jqGrid('setGridWidth', $(".gridsize").width() - 50);
                jQuery("#numeration1").jqGrid('setGridWidth', $(".gridsize").width() - 50);
            });


        }


    };
    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);
</script>
<div class="jarviswidget jarviswidget-sortable" id="wid-id-3" data-widget-editbutton="false" data-widget-custombutton="false" role="widget" style="position: relative; opacity: 1; left: 0px; top: 0px;">
    <header role="heading">
        <span class="widget-icon"> <i class="fa fa-edit"></i> </span>
        <h2><%=trs.t("ხელშეკრულება")%> <b>#2565</b></h2>				
        <span class="jarviswidget-loader"><i class="fa fa-refresh fa-spin"></i></span>
    </header>
    <div role="content">
        <div class="jarviswidget-editbox"></div>
        <div class="widget-body no-padding">
            <div id="order-form" class="smart-form" novalidate="novalidate">
                <fieldset>
                    <div class="row">
                        <div class="col col-4">
                            <section class="col col-md-12">
                                <label class="select">
                                    <select>
                                        <option value="0" selected=""><%=trs.t("- კვლევა -")%></option>
                                    </select> <i></i> 
                                </label>
                            </section>
                            <section class="col col-md-12">
                                <div class="inline-group">
                                    <label class="radio">
                                        <input name="radio-inline" checked="checked" type="radio">
                                        <i></i><%=trs.t("დადებითი")%></label>
                                    <label class="radio">
                                        <input name="radio-inline" type="radio">
                                        <i></i><%=trs.t("უარყოფითი")%></label>
                                </div>
                            </section>      
                            <section class="col col-md-12">
                                <div class="input-group">
                                    <label class="input"> 
                                        <input name="num" id='num' type="text" value="" placeholder="<%=trs.t("ნიმუშის ნომერი")%>">
                                    </label>
                                    <div class="input-group-btn">
                                        <button class="btn btn-success" type="button" onclick="setNum()" style="height: 34px !important;">
                                            <i class="fa fa-lg fa-check"></i> 
                                        </button>
                                    </div>
                                </div>
                            </section>
                            <section class="col col-md-12">
                                <ol class="dd-list">
                                    <li class="dd-item"><div class="dd-handle" style="border: none !important; background: none !important;"><div class="row"><div class="col-xs-8"><%=trs.t("ნიმუშების რაოდენობა")%>:</div><div class="col-xs-4"><span class=" text-align-right text-warning">100</span></div></div></div></li>
                                    <li class="dd-item"><div class="dd-handle" style="border: none !important; background: none !important;"><div class="row"><div class="col-xs-8"><%=trs.t("გატარებულია")%>:</div><div class="col-xs-4"><span class=" text-align-right text-primary">40</span></div></div></div></li>
                                    <li class="dd-item"><div class="dd-handle" style="border: none !important; background: none !important;"><div class="row"><div class="col-xs-8"><%=trs.t("მიღებულია")%>:</div><div class="col-xs-4"><span class=" text-align-right text-success">37</span></div></div></div></li>
                                    <li class="dd-item"><div class="dd-handle" style="border: none !important; background: none !important;"><div class="row"><div class="col-xs-8"><%=trs.t("დაწუნებულია")%>:</div><div class="col-xs-4"><span class=" text-align-right text-danger">3</span></div></div></div></li>
                                    <li class="dd-item"><div class="dd-handle" style="border: none !important; background: none !important;"><div class="row"><div class="col-xs-8"><%=trs.t("დარჩენილია")%>:</div><div class="col-xs-4"><span class=" text-align-right text-primary">60</span></div></div></div></li>
                                    <li class="dd-item">
                                        <div class="dd-handle" style="border: none !important; background: none !important;">
                                            <div class="row">
                                                <div class="col-xs-12">
                                                    <div class="progress progress-striped active no-margin">
                                                        <div class="progress-bar progress-bar-primary" role="progressbar" style="width: 40%;">40%</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </ol>
                            </section>
                            <section class="col col-md-12" id="end-field">
                                <button class="btn btn-success btn-full"><%=trs.t("დასრულება")%></button>
                            </section>
                        </div>
                        <div class="col col-8 gridsize">
                            <div class="btn-box">
                                <button class="btn btn-danger pull-right" onclick="showmsg('დარწმუნებული ხართ, რომ გნებავთ მთლიანი ცხრილის გასუფთავება?')"><i class="fa fa-trash"></i> <%=trs.t("ყველას წაშლა")%></button>
                            </div>
                            <ul id="stockmovementmain" class="nav nav-tabs bordered half">
                                <li class="active">
                                    <a href="#i1" data-toggle="tab"> <%=trs.t("მიღებული")%></a>
                                </li>
                                <li>
                                    <a href="#i2" data-toggle="tab"> <%=trs.t("დაწუნებული")%></a>
                                </li>
                            </ul>
                            <div id="stockmovementmaincontent" class="tab-content padding-10">
                                <div class="tab-pane fade in active" id="i1" style="height: calc(100vh - 345px) !important;">
                                    <section class="col col-md-12">
                                        <div class="table-size3">
                                            <table id="numeration" width='100%'></table>
                                            <div id="pagernumeration"></div>
                                        </div>
                                    </section>
                                </div>
                                <div class="tab-pane fade" id="i2" style="height: calc(100vh - 345px) !important;">
                                    <section class="col col-md-12">
                                        <div class="table-size3">
                                            <table id="numeration1" width='100%'></table>
                                            <div id="pagernumeration1"></div>
                                        </div>
                                    </section>
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="msgModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ყურადღება")%></h4>
            </div>
            <div class="modal-body">
                <h2 id="message"><%=trs.t("დარწმუნებული ხართ, რომ გნებავთ ამ მოქმედების შესრულება?")%></h2>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("არა")%>
                </button>
                <button type="button" class="btn btn-success" data-dismiss="modal">
                    <%=trs.t("დიახ")%>
                </button>
            </footer>
        </div>
    </div>
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
                    <%=trs.t("არა")%>
                </button>
                <button type="button" class="btn btn-warning" data-dismiss="modal">
                    <%=trs.t("დაწუნება")%>
                </button>
            </footer>
        </div>
    </div>
</div>