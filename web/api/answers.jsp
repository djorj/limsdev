<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    String restypes = "";
    String sql = "where labtestid > 0 ";
    //if(user.getPersonelltypeid().intValue() != 1)
    //    sql += " and labtestid in (select labtestid from labtestinstitution where institutionid = "+user.getInstitutionid()+")";
    LabtestBean[] tests = LabtestManager.getInstance().loadByWhere(sql);
    for(int i=0;i<tests.length;i++){
        restypes += "<option value='"+tests[i].getLabtestid()+"'>"+tests[i].getName()+"</option>";
    }
    String sampletypes = ObjOptions.Sampletypes(user.getCompanyid());
    //String labtests = ObjOptions.Labtest();
    String labpers = ObjOptions.Labpers(user.getCompanyid());
    String methods = "";
    StandardBean[] standards = StandardManager.getInstance().loadByWhere("where standardid in (select standardid from labteststandard where standardid > 0)");
    for(int i=0;i<standards.length;i++){
        methods += "<option value='"+standards[i].getStandardid()+"'>"+standards[i].getName()+"</option>";
    }
%>
<style>
.ui-jqgrid-sortable {
    top: 0px !important;
}
</style>
<section id="widget-grid" class="" style="padding-right: 5px;">
    <div class="jarviswidget" data-widget-collapsed="true" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false">
        <header>
            <h2><%=trs.t("ფილტრი")%></h2>
        </header>
        <div>
            <div class="smart-form col-sm-12" style="padding: 0;">
                <div class="col-sm-12">
                    <form id="frm1filter" method="post" accept-charset="UTF-8">
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-barcode"></i>
                            <input placeholder="<%=trs.t("ბარკოდი")%>" id="reqbarcode" type="text" onkeydown="searchonenterans">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select id="research" name="research" class="select2" placeholder="<%=trs.t("კვლევა")%>">
                                <option value=""><%=trs.t("კვლევა")%></option>
                                <%=restypes%>
                            </select>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" name='regdate' placeholder="<%=trs.t("რეგ. თარიღი")%>" type="text" onkeydown="searchonenterans">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" name='resultdate' placeholder="<%=trs.t("ჩატარების თარიღი")%>" type="text" onkeydown="searchonenterans">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-comment"></i>
                            <input placeholder="<%=trs.t("შენიშვნა")%>" name='note' type="text" onkeydown="searchonenterans">
                        </label>
                    </section>
                    <%--section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" name='plandate' placeholder="<%=trs.t("სავარაუდო დას.")%>" type="text" onkeydown="searchonenterans">
                        </label>
                    </section--%>
                    <section class="col custwidth">
                        <label class="select">
                            <select class="select2" name='method' placeholder="<%=trs.t("მეთოდი")%>">
                                <option value=""><%=trs.t("მეთოდი")%></option>
                                <%=methods%>
                            </select>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select class="select2" name='author' placeholder="<%=trs.t("ავტორი")%>">
                                <option value=""><%=trs.t("ავტორი")%></option>
                                <%=labpers%>
                            </select>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select class="select2" name='sampletype' placeholder="<%=trs.t("ნიმუშის ტიპი")%>">
                                <option value=""><%=trs.t("ნიმუშის ტიპი")%></option>
                                <%=sampletypes%>
                            </select>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-institution"></i>
                            <input name="contragentid" type="text" onkeydown="searchonenterans" placeholder="<%=trs.t("დამკვეთი")%>">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-folder"></i>
                            <input name="contract" type="text" onkeydown="searchonenterans" placeholder="<%=trs.t("ხელშეკრულება")%>">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-folder-open"></i>
                            <input name="act" type="text" onkeydown="searchonenterans" placeholder="<%=trs.t("აქტი")%>">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-folder-open-o"></i>
                            <input name="appeal" type="text" onkeydown="searchonenterans" placeholder="<%=trs.t("მომართვა")%>">
                        </label>
                    </section>
                    </form>
                    <button class="btn btn-info pull-right" style="margin-right: 5px;" onclick="clearans()"><i class="fa fa-times"></i> <%=trs.t("გასუფთავება")%></button>
                    <button class="btn btn-success pull-right" style="margin-right: 5px;" onclick="searchans()"><i class="fa fa-search"></i> <%=trs.t("ძებნა")%></button>
                </div>
            </div>
        </div>
    </div>
</section>
<%--div class="col-md-12 btn-panel">
    <button class="btn btn-info pull-right"><i class="fa fa-print"></i> <%=trs.t("ბეჭდვა")%></button>
    <button class="btn btn-info pull-right"><i class="fa fa-file-excel-o"></i> <%=trs.t("ექსპორტი")%></button>
</div--%>
<div class="table-size8 active">
    <table id="answers2"></table>
    <div id="pageranswers"></div>
</div>
<script type="text/javascript">
    pageSetUp();

    function searchans(){
        $('#answers2').setGridParam({
            url:"content/getanswerslist.jsp?"+$("#frm1filter").serialize()
        }).trigger("reloadGrid");

    }

    function clearans(){
        $("#frm1filter").find("input[type=text], textarea, select").val("");
        $(".select2").val("").trigger('change');
        $("#research").val("0").trigger('change');
        $('#answers2').setGridParam({
            url:"content/getanswerslist.jsp"
        }).trigger("reloadGrid");

    }
    
    function searchonenterans(e){
        if(e.keyCode == 13) {
            searchans();
        }
    }

    function confirm1(cellvalue, options, rowObject){
        var icon = "square-o";
        if(Number(cellvalue) > 0){
            icon = "check";
        }
        return "<span class=\"fa fa-"+icon+"\" style=\"color: green;\"></span>";
    }
    
    function confirm2(cellvalue, options, rowObject){
        var level1 = rowObject[8];
        var tp = "warning";
        if(Number(cellvalue) > 0){
            tp = "success";
        }
        var btn = '<button class="btn btn-'+tp+'" onclick="setconfirm2('+rowObject[11]+',2)"><i class="fa fa-check"></i> </button>';
        if(level1 == 0)
            btn = "";
        return btn;
    }
    
    function confirm3(cellvalue, options, rowObject){
        var level2 = rowObject[9];
        var tp = "warning";
        if(Number(cellvalue) > 0){
            tp = "success";
        }
        var btn = '<button class="btn btn-'+tp+'" onclick="setconfirm2('+rowObject[11]+',3)"><i class="fa fa-check"></i> </button>';
        if(level2 == 0)
            btn = "";
        return btn;
    }
    
    function setconfirm2(id,level){
        BootstrapDialog.show({
            title: '<%=trs.t("კვლევის შედეგის დამოწმება")%>',
            message: function(dialog){
                var $message = $('<div></div>');
                $message.load("content/getconfirmlevel.jsp?level="+level+"&id="+id);
                return $message;
            },
            type: BootstrapDialog.TYPE_SUCCESS,
            size: BootstrapDialog.SIZE_WIDE,
            buttons: [{
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
    }

    function printAnswer(id){
        //alert(id);
        printReport('F-003-2016-G',id);
    }

    var pagefunction = function () {
      loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);
      function run_jqgrid_function() {

      jQuery("#answers2").jqGrid({
        url: 'content/getanswerslist.jsp',
        datatype: "json",
        grouping:true,
        groupingView : { 
            groupField: ['contragent','actcontractappealid'],
            groupOrder: ['asc','asc'],
            groupColumnShow: [false,false],
            hideFirstGroupCol: true,
            groupCollapse: true,
            groupText: ["{0}","{1} კვლევა <span style='cursor: pointer;'><a class='btn btn-primary btn-xs' onclick='printAnswer(\"{0}\")' style='padding: 1px 7px !important;'><i class='fa fa-print'></i> </a></span>"],
            groupDataSorted: true
        }, 
        colNames: [
            '<%=trs.t("დამკვეთი")%>','actcontractappealid','<%=trs.t("კვლევა")%>', '<%=trs.t("ბარკოდი")%>', '<%=trs.t("ნიმუშის ტიპი")%>', '<%=trs.t("ნიმუშის მიღება")%>', 
            '<%=trs.t("ტესტის დასრულება")%>', '<%=trs.t("სავარაუდო დასრულება")%>', 
            '<%=trs.t("შენიშვნა")%>', '<%=trs.t("I დონე")%>', '<%=trs.t("II დონე")%>', '<%=trs.t("III დონე")%>','sampleitemreseachid'],
        colModel: [
                    {name: 'contragent', index: 'contragent', hidden: false},
                    {name: 'actcontractappealid', index: 'actcontractappealid', hidden: true},
                    {width: 150, name: 'labtestname', index: 'labtestname', editable: true, align: "left",sortable:"true"},
                    {width: 80, name: 'barcode', index: 'barcode', editable: true, align: "left",sortable:"true"},
                    {width: 150, name: 'sampletype', index: 'sampletype', editable: true, align: "left",sortable:"true"},
                    {width: 80, name: 'regdate', index: 'regdate', editable: true, align: "center",sortable:"true"},
                    {width: 80, name: 'resultdate', index: 'resultdate', editable: true, align: "center",sortable:"true"},
                    {width: 80, name: 'plandate', index: 'plandate', editable: true, align: "center",sortable:"true"},
                    {width: 150, name: 'note', index: 'note', editable: true, align: "left",sortable:"true"},
                    {width: 80, name: 'confirmation1id', index: 'confirmation1id', editable: true, align: "center",sortable:"false",formatter:confirm1},
                    {width: 80, name: 'confirmation2id', index: 'confirmation2id', editable: true, align: "center",sortable:"false",formatter:confirm2},
                    {width: 80, name: 'confirmation3id', index: 'confirmation3id', editable: true, align: "center",sortable:"false",formatter:confirm3},
                    {name: 'sampleitemreseachid', index: 'sampleitemreseachid', hidden: true}
                ],
                rowNum: 20000,
                //height: 350,
                //width: 900,
                autowidth: false,
                rowList: [20, 50, 100],
                pager: jQuery('#pageranswers'),
                sortname: 'sampleitemreseachid',
                viewrecords: true,
                sortorder: "asc",
                gridComplete: function () {
                    $(".tip").tooltip({
                        container: 'body'
                    });
                }
            })
            .navGrid('#pageranswers', {edit: false, add: false, del: false, refresh: true, view: false, search: false})
            /*.navButtonAdd('#pageranswers', {
                caption: "ბეჭდვა",
                buttonicon: "ui-icon-print",
                onClickButton: function () {
                    var myGrid = $('#answers2');
                    var RowId = myGrid.jqGrid('getGridParam', 'selrow');
                    if (RowId > 0)
                        printReport('F-003-2016-G',RowId);
                    else
                        alertError('< %=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'< %=trs.t("დახურვა")%>');
                },
                position: "last"
            })*/
            ;
            
            jQuery("#answers2").jqGrid('setGroupHeaders', {
                useColSpanStyle: true,
                groupHeaders: [
                    {startColumnName: 'confirmation1id', numberOfColumns: 3, titleText: '<%=trs.t("კონფირმაცია")%>'}
                ]
            });

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

            $(".ui-icon.ui-icon-2").removeClass().addClass("fa fa-pencil").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");

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
                jQuery("#answers2").jqGrid('setGridWidth', $("#content").width() - 10);
            })
            var gridName = "answers2";
            var objHeader = $("table[aria-labelledby=gbox_" + gridName+ "] tr[role=rowheader] th");

            for (var i = 0; i < objHeader.length; i++) {
               var col = $("table[id=" + gridName+ "] td[aria-describedby=" + objHeader[i].id + "]");
               var width= col.outerWidth();
               $(objHeader[i]).css("width", width);
            }
            
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


