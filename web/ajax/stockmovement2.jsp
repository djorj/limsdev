<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
%>
<%--
<section id="widget-grid" class="" style="padding-right: 5px;">
    <div class="jarviswidget" data-widget-collapsed="true" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false">
        <header>
            <h2><%=trs.t("ფილტრი")%></h2>
        </header>
        <div>
            <div class="smart-form col-sm-12" style="padding: 0;">
                <div class="col-sm-9">
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-barcode"></i>
                            <input placeholder="<%=trs.t("ბარკოდი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-barcode txt-color-teal"></i> <%=trs.t("ბარკოდი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input placeholder="<%=trs.t("ზედნადების N")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-list-ol txt-color-teal"></i> <%=trs.t("ზედნადების N")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("ზედნ. თარიღი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("ზედნადების თარიღი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                            <input placeholder="<%=trs.t("დასახელება")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-address-book txt-color-teal"></i> <%=trs.t("დასახელება")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calculator"></i>
                            <input placeholder="<%=trs.t("რაოდენობა")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-calculator txt-color-teal"></i> <%=trs.t("რაოდენობა")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-money"></i>
                            <input placeholder="<%=trs.t("ერთ. ფასი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-money txt-color-teal"></i> <%=trs.t("ერთეულის ფასი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-credit-card"></i>
                            <input placeholder="<%=trs.t("საქ. ანგარიში")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa--credit-card txt-color-teal"></i> <%=trs.t("საქონლის ანგარიში")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar-check-o"></i>
                            <input placeholder="<%=trs.t("ვადა")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-calendar-check-o txt-color-teal"></i> <%=trs.t("ვადა")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-sort-numeric-desc"></i>
                            <input placeholder="<%=trs.t("მინ. რაოდენობა")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-sort-numeric-desc txt-color-teal"></i> <%=trs.t("მინიმალური რაოდენობა")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-home"></i>
                            <input placeholder="<%=trs.t("ოთახი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-home txt-color-teal"></i> <%=trs.t("ოთახი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-home"></i>
                            <input placeholder="<%=trs.t("თარო")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-home txt-color-teal"></i> <%=trs.t("თარო")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-home"></i>
                            <input placeholder="<%=trs.t("ადგ. თაროზე")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-home txt-color-teal"></i> <%=trs.t("ადგილი თაროზე")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-id-card"></i>
                            <input placeholder="<%=trs.t("საიდ. კოდი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-id-card txt-color-teal"></i> <%=trs.t("საიდენტიფიკაციო კოდი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-university"></i>
                            <input placeholder="<%=trs.t("ფირმის დასახელება")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-university txt-color-teal"></i> <%=trs.t("ფირმის დასახელება")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-phone"></i>
                            <input placeholder="<%=trs.t("ფირმის ტელეფონი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-phone txt-color-teal"></i> <%=trs.t("ფირმის ტელეფონი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-map-marker"></i>
                            <input placeholder="<%=trs.t("ფირმის მისამართი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-map-marker txt-color-teal"></i> <%=trs.t("ფირმის მისამართი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-envelope"></i>
                            <input placeholder="<%=trs.t("ფირმის ელ-ფოსტა")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-envelope txt-color-teal"></i> <%=trs.t("ფირმის ელ-ფოსტა")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-id-card"></i>
                            <input placeholder="<%=trs.t("უფლ. პირის პ/N")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-id-card txt-color-teal"></i> <%=trs.t("უფლებამოსილი პირის პირადი N")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-user"></i>
                            <input placeholder="<%=trs.t("უფლ. პ/სახელი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("უფლებამოსილი პირის სახელი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-user"></i>
                            <input placeholder="<%=trs.t("უფლ. პ/გვარი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("უფლებამოსილი პირის გვარი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-phone"></i>
                            <input placeholder="<%=trs.t("უფლ. პ/ტელეფონი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-phone txt-color-teal"></i> <%=trs.t("უფლებამოსილი პირის ტელეფონი")%></b>
                        </label>
                    </section>
                </div>
                <div class="col-sm-3">
                    <section class="col col-sm-6">
                        <label class="select">
                            <select class="select2" multiple="" placeholder="<%=trs.t("ზომის ერთ.")%>">
                                <option value="0">0</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                                <option value="8">8</option>
                            </select> 
                            <b class="tooltip tooltip-top-right"><%=trs.t("ზომის ერთეული")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-6">
                        <label class="select">
                            <select class="select2" multiple="" placeholder="<%=trs.t("დაფ. წყარო")%>">
                                <option value="0">0</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                                <option value="8">8</option>
                            </select> 
                            <b class="tooltip tooltip-top-right"><%=trs.t("დაფინანსების წყარო")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-6">
                        <label class="select">
                            <select class="select2" multiple="" placeholder="<%=trs.t("საქ. კატეგორია")%>">
                                <option value="0">0</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                                <option value="8">8</option>
                            </select> 
                            <b class="tooltip tooltip-top-right"><%=trs.t("საქონლის კატეგორია")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-6">
                        <label class="select">
                            <select class="select2" multiple="" placeholder="<%=trs.t("ზედ. ტიპი")%>">
                                <option value="0">0</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                                <option value="8">8</option>
                            </select> 
                            <b class="tooltip tooltip-top-right"><%=trs.t("ზედნადების ტიპი")%></b>
                        </label>
                    </section>
                </div>
                <div class="col-sm-12">
                    <section class="col" style="width: 320px;">
                        <label class="label"><%=trs.t("შემომტანი")%></label>
                        <div class="inline-group">
                            <label class="checkbox">
                                <input type="checkbox" name="checkbox-inline" checked="">
                                <i></i><%=trs.t("იურიდიული პირი")%></label>
                            <label class="checkbox">
                                <input type="checkbox" name="checkbox-inline" checked="">
                                <i></i><%=trs.t("კერძო პირი")%></label>
                        </div>
                    </section>
                    <section class="col" style="height: 54px; width: 170px;">
                        <label class="label"><%=trs.t("მეორადი")%></label>
                        <div class="inline-group">
                            <label class="checkbox">
                                <input type="checkbox" name="checkbox-inline" checked="">
                                <i></i><%=trs.t("კი")%></label>
                            <label class="checkbox">
                                <input type="checkbox" name="checkbox-inline" checked="">
                                <i></i><%=trs.t("არა")%></label>
                        </div>
                    </section>
                    <section class="col" style="height: 54px; width: 170px;">
                        <label class="label"><%=trs.t("კომპლექტი")%></label>
                        <div class="inline-group">
                            <label class="checkbox">
                                <input type="checkbox" name="checkbox-inline" checked="">
                                <i></i><%=trs.t("კი")%></label>
                            <label class="checkbox">
                                <input type="checkbox" name="checkbox-inline" checked="">
                                <i></i><%=trs.t("არა")%></label>
                        </div>
                    </section>
                    <button class="btn btn-info pull-right" style="margin: 18px 10px;"><i class="fa fa-times"></i> <%=trs.t("გასუფთავება")%></button>
                    <button class="btn btn-success pull-right" style="margin: 18px 10px;"><i class="fa fa-search"></i> <%=trs.t("ძებნა")%></button>
                </div>
            </div>
        </div>
    </div>
</section>
                
--%>
<div class="table-size6 active">
    <table id="stockinv"></table>
    <div id="pagerstockinv"></div>
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
        } else
            id = json.id;
        return [retval, msg, id];
    }
    
    function addBarcode(id){
        if(id > 0){
            $.post("content/setbcode.jsp",{ id: id, oper: "set" },function(data){
                if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                else {
                    $("#stockinv").trigger("reloadGrid");
                    seTimeout(function(){$("#stockinv").resetSelection().setSelection(id, false);},500);
                }
            },"json");
        } else alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ პროდუქტი")%>','<%=trs.t("დახურვა")%>');
    }
    
    function move(id){
        if(id > 0){
            
        } else alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ პროდუქტი")%>','<%=trs.t("დახურვა")%>');
    }
    
    function printBarcode(id){
        if(id > 0){
            $.post("content/setbcode.jsp",{ id: id, oper: "print" },function(data){
                if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                else {
                    $("#stockinv").trigger("reloadGrid");
                    seTimeout(function(){$("#stockinv").resetSelection().setSelection(id, false);},500);
                    window.open(data.url);
                }
            },"json");
        } else alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ პროდუქტი")%>','<%=trs.t("დახურვა")%>');
    }

    var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);

        function run_jqgrid_function() {

            jQuery("#stockinv").jqGrid({
                url: 'content/getstockinvlist.jsp',
                datatype: "json",
                colNames: ['<%=trs.t("ბარკოდი")%>', '<%=trs.t("ზედ. N")%>', '<%=trs.t("ზედ. თარიღი")%>', '<%=trs.t("დასახელება")%>', '<%=trs.t("ზომის ერთეული")%>', '<%=trs.t("რაოდენობა")%>', '<%=trs.t("დარჩა")%>', '<%=trs.t("ერთეულის ფასი")%>', '<%=trs.t("ღირებულება")%>', '<%=trs.t("დაფინანსების წყარო")%>', '<%=trs.t("საქონლის ანგარიში")%>', '<%=trs.t("მეორადი")%>', '<%=trs.t("ვადა")%>', '<%=trs.t("საქ. კატეგორია")%>', '<%=trs.t("შენიშვნა")%>', '<%=trs.t("მინიმალური რაოდენობა")%>', '<%=trs.t("ოთახი")%>'],
                colModel: [
                    {name: 'code', index: 'code', editable: true, align: "left",search:true},
                    {name: 'invnum', index: 'invnum', editable: true, align: "left",search:true},
                    {name: 'indate', index: 'indate', editable: true, align: "left",search:true,searchoptions:{dataInit: function(element) {$(element).daterangepicker()}}},
                    {name: 'name', index: 'name', editable: true, align: "left",search:true},
                    {name: 'punitid', index: 'punitid', editable: true, align: "left",search:true,stype:"select",searchoptions:{dataUrl:'content/gettypes.jsp?objname=Punit&cols=Punitid&cols=Name&where=order by name'}},
                    {name: 'count', index: 'count', editable: true, align: "left",search:false},
                    {name: 'left', index: 'left', editable: true, align: "left",search:false},
                    {name: 'price', index: 'price', editable: true, align: "left",search:false},
                    {name: 'total', index: 'total', editable: true, align: "left",search:false},
                    {name: 'sourcetypeid', index: 'sourcetypeid', editable: true, align: "left",search:true,stype:"select",searchoptions:{dataUrl:'content/gettypes.jsp?objname=Sourcetype&cols=Sourcetypeid&cols=Name&where=order by name'}},
                    {name: 'productgroupid', index: 'productgroupid', editable: true, align: "left",search:true,stype:"select",searchoptions:{dataUrl:'content/gettypes.jsp?objname=Productgroup&cols=Productgroupid&cols=Code&where=order by code'}},
                    {name: 'isnew', index: 'isnew', editable: true, align: "left",search:true,stype:"select",searchoptions:{value:'0:ყველა;1:ახალი;2:მეორადი'}},
                    {name: 'expdate', index: 'expdate', editable: true, align: "left",search:true,searchoptions:{dataInit: function(element) {$(element).daterangepicker()}}},
                    {name: 'categoryid', index: 'categoryid', editable: true, align: "left",search:true,stype:"select",searchoptions:{dataUrl:'content/gettypes.jsp?objname=Productgroup&cols=Productgroupid&cols=Name&where=order by name'}},
                    {name: 'note', index: 'note', editable: true, align: "left",search:true},
                    {name: 'min', index: 'min', editable: true, align: "left",search:false},
                    {name: 'room', index: 'room', editable: true, align: "left",search:true}
                ],
                rowNum: 20,
                height: 350,
                width: 900,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagerstockinv'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updstockinv.jsp",
                ondblClickRow: function (id, ri, ci) {
                    //jQuery("#stockinv").jqGrid('editGridRow', id, {dataheight: 450, width: 800, closeAfterEdit: true, reloadAfterSubmit: false, afterSubmit: checkStatus});
                    return;
                }
            })
            .jqGrid('filterToolbar', { searchOnEnter: true, enableClear: true })
                    .navGrid('#pagerstockinv', {edit: false, add: false, del: false, refresh: true, view: false, search: false},
                            {dataheight: 450, width: 800, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for edit
                            {dataheight: 450, width: 800, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for add
                            {closeAfterDelete: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 450, width: 800, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    )

                    .navButtonAdd('#pagerstockinv', {id: 'exportstockinv', caption: '<i class="fa fa-file-excel-o"></i> <%=trs.t("ექსპორტი")%>', buttonicon: "none", onClickButton: function () { }, position: 'last'})
            .navButtonAdd('#pagerstockinv', {id: 'addbarcode', caption: '<i class="fa fa-barcode"></i>', buttonicon: "none", onClickButton: function () { addBarcode($('#stockinv').jqGrid('getGridParam','selrow')); }, position: 'first'})
            .navButtonAdd('#pagerstockinv', {id: 'printbarcode', caption: '<i class="fa fa-print"></i>', buttonicon: "none", onClickButton: function () { printBarcode($('#stockinv').jqGrid('getGridParam','selrow')); }, position: 'first'})
            .navButtonAdd('#pagerstockinv', {id: 'move', caption: '<i class="fa fa-arrow"></i>  <%=trs.t("გაცემა")%>', buttonicon: "none", onClickButton: function () { move($('#stockinv').jqGrid('getGridParam','selrow')); }, position: 'first'})

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

            $(".ui-icon.ui-icon-2").removeClass().addClass("fa fa-pencil").parent(".btn-primary").removeClass("btn-primary").addClass("btn-warning");

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
                jQuery("#stockinv").jqGrid('setGridWidth', $("#content").width() - 10);
            })
        }
    }

    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);
    $(document).on("click", ".jarviswidget-toggle-btn", function () {
        $(".table-size6").toggleClass("active");
    });
    $('.daterangepicker').daterangepicker({
        autoUpdateInput: false,
        locale: {
            format: 'DD-MM-YYYY',
            cancelLabel: '<%=trs.t("გასუფთავება")%>'
        }
    });
    $('.daterangepicker').on('apply.daterangepicker', function (ev, picker) {
        $(this).val(picker.startDate.format('MM/DD/YYYY') + ' - ' + picker.endDate.format('MM/DD/YYYY'));
    });

    $('.daterangepicker').on('cancel.daterangepicker', function (ev, picker) {
        $(this).val('');
    });
</script>


