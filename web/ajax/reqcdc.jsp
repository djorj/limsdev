<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
%>
<section id="widget-grid" class="" style="padding-right: 5px;">
    <div class="jarviswidget" data-widget-collapsed="true" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false">
        <header>
            <h2><%=trs.t("ფილტრი")%></h2>
        </header>
        <div>
            <div class="smart-form col-sm-12" style="padding: 0;">
                <div class="col-sm-12">
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-barcode"></i>
                            <input placeholder="<%=trs.t("ბარკოდი")%>" type="text">
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
                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                            <input placeholder="<%=trs.t("კვლევის დასახელება")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-address-book txt-color-teal"></i> <%=trs.t("დასახელება")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("რეგ. თარიღი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("რეგისტრაციის თარიღი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("მიღების თარიღი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("მიღების თარიღი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("ჩატარების თარიღი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("ჩატარების თარიღი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("პასუხის თარიღი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("პასუხის თარიღი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-comment"></i>
                            <input placeholder="<%=trs.t("შენიშვნა")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-comment txt-color-teal"></i> <%=trs.t("შენიშვნა")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("კონფ. თარიღი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("კონფირმაციის თარიღი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("ხარ. კონტრ. თარიღი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("ხარისხის კონტროლის ჩატარების თარიღი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" placeholder="<%=trs.t("სავარაუდო დას.")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("სავარაუდო დასრულების თარიღი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select>
                                <option><%=trs.t("შედეგი")%></option>
                                <option>გაიარა</option>
                                <option>არ გაიარა</option>
                            </select><i></i>
                            <b class="tooltip tooltip-top-right"><%=trs.t("შედეგი")%></b>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select multiple="" class="select2" placeholder="<%=trs.t("მეთოდი")%>">
                                <option value="0"><%=trs.t("მეთოდი")%></option>
                            </select>
                            <b class="tooltip tooltip-top-right"><%=trs.t("მეთოდი")%></b>
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
                            <select multiple="" class="select2" placeholder="<%=trs.t("ავტორი")%>">
                                <option value="0"><%=trs.t("გიორგი გიორგაძე")%></option>
                            </select>
                            <b class="tooltip tooltip-top-right"><%=trs.t("ავტორი")%></b>
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
                    <button class="btn btn-info pull-right" style="margin-right: 5px;"><i class="fa fa-times"></i> <%=trs.t("გასუფთავება")%></button>
                    <button class="btn btn-success pull-right" style="margin-right: 5px;"><i class="fa fa-search"></i> <%=trs.t("ძებნა")%></button>
                </div>
            </div>
        </div>
    </div>
</section>
<div class="col-md-12 btn-panel">
    <button class="btn btn-info pull-right"><i class="fa fa-print"></i> <%=trs.t("ბეჭდვა")%></button>
    <button class="btn btn-info pull-right"><i class="fa fa-file-excel-o"></i> <%=trs.t("ექსპორტი")%></button>
    <button class="btn btn-info pull-right" onclick="$('#ansModal').modal('show')"><i class="fa fa-pencil-square"></i> <%=trs.t("პასუხ(ებ)ი")%></button>
    <button class="btn btn-danger pull-right" onclick="$('#ansModal2').modal('show')"><i class="fa fa-check-square"></i> <%=trs.t("ხარისხი")%></button>
</div>
<div class="table-size9 active">
    <table id="req"></table>
    <div id="pagerreq"></div>
</div>
<div class="modal fade" id="ansModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog large">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ანალიზის პასუხ(ებ)ი")%></h4>
            </div>
            <div class="modal-body">
                <ul class="nav nav-tabs bordered half">
                    <li class="active">
                        <a href="#i1" data-toggle="tab"> <%=trs.t("პასუხები")%></a>
                    </li>
                    <li>
                        <a href="#i2" data-toggle="tab"> <%=trs.t("კიტის ხარისხის მონაცემები")%></a>
                    </li>
                </ul>
                <div class="tab-content padding-10" style="float: left; width: 100%;">
                    <div class="tab-pane fade in active" id="i1">
                        <div class="pull-left">
                            <table id="reqanswer"></table>
                            <div id="pagerreqanswer"></div>
                        </div>
                        <div class="smart-form pull-right" style="width: 300px;">
                            <section class="col col-md-12">
                                <label class="textarea"> <i class="icon-append fa fa-info"></i>
                                    <textarea placeholder="<%=trs.t("დამატებითი ინფორმაცია")%>"></textarea>
                                    <b class="tooltip tooltip-top-right"><i class="fa fa-info txt-color-teal"></i> <%=trs.t("დამატებითი ინფორმაცია")%></b>
                                </label>
                            </section>
                            <section class="col col-md-12">
                                <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                                    <textarea placeholder="<%=trs.t("შენიშვნა")%>"></textarea>
                                    <b class="tooltip tooltip-top-right"><i class="fa fa-comment txt-color-teal"></i> <%=trs.t("შენიშვნა")%></b>
                                </label>
                            </section>
                            <section class="col col-md-12">
                                <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                                    <input class="datetime" placeholder="<%=trs.t("ჩატარების თარიღი/დრო")%>" type="text">
                                    <b class="tooltip tooltip-top-right"><i class="fa fa-clock-o txt-color-teal"></i> <%=trs.t("ჩატარების თარიღი და დრო")%></b>
                                </label>
                            </section>
                            <section class="col col-md-12">
                                <label class="select">
                                    <select>
                                        <option value="0"><%=trs.t("აპარატი")%></option>
                                    </select> <i></i>
                                    <b class="tooltip tooltip-top-right"><%=trs.t("აპარატი")%></b>
                                </label>
                            </section>
                            <section class="col col-md-12">
                                <button onclick="$('#msgModal2').modal('show')" class="btn btn-success pull-right"><%=trs.t("კონფირმაცია")%></button>
                                <button class="btn btn-danger pull-right" style="margin-right: 5px;"><%=trs.t("უარყოფა")%></button>
                            </section>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="i2">
                        <div class="table-size">
                            <table id="qcregistry"></table>
                            <div id="pagerqcregistry"></div>
                        </div>
                    </div>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("დახურვა")%>
                </button>
                <button type="button" class="btn btn-success" data-dismiss="modal">
                    <%=trs.t("შენახვა")%>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="ansModal2" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ხარისხის კონტროლი")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form col-sm-12">
                    <section class="col col-sm-6">
                        <label class="label"><%=trs.t("ლოტი/კოდი")%></label>
                        <label class="input"> <i class="icon-append fa fa-code"></i>
                            <input class="" placeholder="" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-6">
                        <label class="label"><%=trs.t("აპარატი")%></label>
                        <label class="select">
                            <select>
                                <option value="0"><%=trs.t("- აირჩიეთ -")%></option>
                            </select>
                        </label><i></i>
                    </section>
                    <section class="col col-sm-12">
                        <label class="label"><%=trs.t("ჩაატარა - გიორგი გიორგაძემ")%></label>
                    </section>
                    <section class="col col-sm-12">
                        <label class="label"><%=trs.t("ჩატარების თარიღი და დრო")%></label>
                        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                            <input class="datetime" placeholder="" type="text">
                        </label>
                    </section>
                    <section class="col col-md-12">
                        <label class="label"><%=trs.t("დადებითი (St aureus (ATCC 25923)) - (ლურჯი შეღებვა)")%></label>
                        <label class="select">
                            <select>
                                <option value="0"><%=trs.t("ლურჯი შეღებვა")%></option>
                                <option value="1"><%=trs.t("წითელი შეღებვა")%></option>
                                <option value="2"><%=trs.t("საეჭვო")%></option>
                            </select> <i></i>
                        </label>
                    </section>
                    <section class="col col-md-12">
                        <label class="label"><%=trs.t("უარყოფითი (E. Coli (ATCC 25922)) - (წითელი შეღებვა)")%></label>
                        <label class="select">
                            <select>
                                <option value="0"><%=trs.t("წითელი შეღებვა")%></option>
                                <option value="1"><%=trs.t("ლურჯი შეღებვა")%></option>
                                <option value="2"><%=trs.t("საეჭვო")%></option>
                            </select> <i></i>
                        </label>
                    </section>
                    <section class="col col-sm-6">
                        <label class="label"><%=trs.t("ინტერპრეტაცია/კომენტარი")%></label>
                        <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                            <textarea class="" placeholder="" type="text"></textarea>
                        </label>
                    </section>
                    <section class="col col-sm-6">
                        <label class="label"><%=trs.t("შენიშვნა")%></label>
                        <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                            <textarea class="" placeholder="" type="text"></textarea>
                        </label>
                    </section>
                    <!--                    <section class="col col-sm-12">
                                            <label class="label"><%=trs.t("ტექსტური პასუხი")%></label>
                                            <label class="input">
                                                <label class="input"> <i class="icon-append fa fa-list"></i>
                                                    <input class="" placeholder="" type="text">
                                                </label>
                                        </section>
                                        <section class="col col-sm-12">
                                            <label class="label"><%=trs.t("რიცხვითი პასუხი")%></label>
                                            <label class="input">
                                                <label class="input"> <span class="icon-append" style="font-size: 11px; font-weight: bold; text-align: right;">ml/g</span>
                                                    <input class="numeric right" placeholder="" type="text">
                                                </label>
                                        </section>-->
                    <section class="col col-sm-12">
                        <label class="label"><%=trs.t("ბარკოდი")%></label>
                        <label class="input">
                            <label class="input"> <i class="icon-append fa fa-barcode"></i>
                                <input class="" placeholder="" type="text">
                            </label>
                    </section>
                    <section class="col col-sm-12">
                        <span class="chtest"><%=trs.t("563147842")%><i class="fa fa-times"></i></span>
                        <span class="chtest"><%=trs.t("632158974")%><i class="fa fa-times"></i></span>
                        <span class="chtest"><%=trs.t("125896574")%><i class="fa fa-times"></i></span>
                        <span class="chtest"><%=trs.t("325879888")%><i class="fa fa-times"></i></span>
                        <span class="chtest"><%=trs.t("987455521")%><i class="fa fa-times"></i></span>
                    </section>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("დახურვა")%>
                </button>
                <button type="button" class="btn btn-success" data-dismiss="modal">
                    <%=trs.t("შენახვა")%>
                </button>
            </footer>
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
                <h2 id="message"><%=trs.t("დარწმუნებული ხართ, რომ გნებავთ კვლევის გაუქმება/აღდგენა?")%></h2>
                <div class="smart-form">
                    <section class="col col-md-12">
                        <label class="select">
                            <select>
                                <option value="0"><%=trs.t("- აირჩიეთ მიზეზი -")%></option>
                            </select> <i></i>
                            <b class="tooltip tooltip-top-right"><%=trs.t("აირჩიეთ მიზეზი")%></b>
                        </label>
                    </section>
                    <section class="col col-md-12">
                        <label class="textarea"> <i class="icon-append fa fa-info"></i>
                            <textarea placeholder="<%=trs.t("დაწერეთ მიზეზი")%>"></textarea>
                            <b class="tooltip tooltip-top-right"><i class="fa fa-info txt-color-teal"></i> <%=trs.t("თუ ვერ მოძებნეთ მიზეზი ჩამოსაშლელ მენიუში დაწერეთ აქ")%></b>
                        </label>
                    </section>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("არა")%>
                </button>
                <button onclick='$(".ui-state-highlight").toggleClass("deleted")' type="button" class="btn btn-success" data-dismiss="modal">
                    <%=trs.t("დიახ")%>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="msgModal2" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ყურადღება")%></h4>
            </div>
            <div class="modal-body">
                <h2 id="message"><%=trs.t("დარწმუნებული ხართ, რომ გნებავთ კონფირმაცია?")%></h2>
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
<div class="modal fade" id="qcregistryModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("კვლევები")%></h4>
            </div>
            <div class="modal-body">
                <ul style="list-style: none; padding: 0;">
                    <li><a href="#"><%=trs.t("21/07/2017 ენტერობაქტერია (Enterobacter sakazakii) - 2")%></a></li>
                    <li><a href="#"><%=trs.t("22/07/2017 ენტერობაქტერია (Enterobacter sakazakii) - 3")%></a></li>
                </ul>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("დახურვა")%>
                </button>
            </footer>
        </div>
    </div>
</div>
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

    var currentdate = new Date();
    var datetime = currentdate.getDate() + "/"
            + ("0" + (currentdate.getMonth() + 1)).slice(-2) + "/"
            + currentdate.getFullYear() + " "
            + currentdate.getHours() + ":"
            + currentdate.getMinutes()
    $(".datetime").val(datetime);

    var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);

        function run_jqgrid_function() {

            var tbldata = [{
                    id: "1",
                    code: "236547821",
                    name: "ადამიანის ნიმუშების კვლევა შავი ჭირის გამომწვევზე",
                    type: "",
                    test: "",
                    diagnos: "",
                    regdate: "",
                    enddate: "",
                    getdate: "",
                    result: "",
                    who: "",
                    note: "",
                    level: 0, parent: "NULL", isLeaf: false, loaded: false, expanded: true
                }, {
                    id: "2",
                    code: "236547821",
                    name: "",
                    type: "სისხლი",
                    test: "დათესვა SBA აგარზე",
                    diagnos: "შავი ჭირი",
                    regdate: "27/07/2016 - 15:00",
                    enddate: "27/07/2016 - 15:00",
                    getdate: "27/07/2016 - 15:00",
                    result: "ზრდა აღინიშნება",
                    who: "ლევან ლეონიძე",
                    note: "",
                    level: 1, parent: 1, isLeaf: true, loaded: false, expanded: true
                }, {
                    id: "3",
                    code: "236564785",
                    name: "",
                    type: "Y.pestis საეჭვო კულტურის სასაგნე მინაზე ფიქსირებული ნაცხი",
                    test: "Y.pestis საეჭვო კულტურის შეღებვა გრამის წესით",
                    diagnos: "შავი ჭირი",
                    regdate: "27/07/2016 - 15:00",
                    enddate: "27/07/2016 - 15:00",
                    getdate: "27/07/2016 - 15:00",
                    result: "შერეული სუბკულტურა",
                    who: "ლევან ლეონიძე",
                    note: "",
                    level: 1, parent: 1, isLeaf: true, loaded: false, expanded: true
                }, {
                    id: "4",
                    code: "236564785",
                    name: "ადამიანის ნიმუშების კვლევა ჯილეხის გამომწვევზე",
                    type: "სისხლი",
                    test: "დათესვა PLET აგარზე.",
                    diagnos: "ჯულეხი",
                    regdate: "27/07/2016 - 15:00",
                    enddate: "27/07/2016 - 15:00",
                    getdate: "27/07/2016 - 15:00",
                    result: "არის საეჭვო ჯილეხის გამომწვევზე",
                    who: "ლევან ლეონიძე",
                    note: "",
                    level: 0, parent: "NULL", isLeaf: true, loaded: true, expanded: true
                }];

            var tbldata10 = [{
                    id: "1",
                    number: "3489",
                    reag: "",
                    date: "22/05/2017",
                    user: "გიორგი გიორგაძე",
                    norm: "",
                    result: "",
                    count: '<button class="btn btn-default" onclick="showList()"><i class="fa fa-list"></i></button>'
                }, {
                    id: "2",
                    number: "3454",
                    reag: "",
                    date: "02/06/2017",
                    user: "გიორგი გიორგაძე",
                    norm: "",
                    result: "",
                    count: '<button class="btn btn-default" onclick="showList()"><i class="fa fa-list"></i></button>'
                }];

            jQuery("#qcregistry").jqGrid({
                treeGrid: true,
                treeGridModel: "adjacency",
                ExpandColumn: "code",
                treedatatype: "local",
                datatype: "jsonstring",
                datastr: tbldata10,
                colNames: ["id", '<%=trs.t("ლოტის N")%>', '<%=trs.t("რეაგენტი")%>', '<%=trs.t("თარიღი/დრო")%>', '<%=trs.t("ვინ ჩაატარა")%>', '<%=trs.t("ნორმატივი")%>', '<%=trs.t("შედეგი")%>', '<%=trs.t("კვლევების რაოდენობა")%>'],
                colModel: [
                    {name: 'id', index: 'id', editable: true, align: "left", hidden: true, width: 1},
                    {name: 'number', index: 'number', editable: true, align: "left"},
                    {name: 'reag', index: 'reag', editable: true, align: "left"},
                    {name: 'date', index: 'date', editable: true, align: "left"},
                    {name: 'user', index: 'user', editable: true, align: "left"},
                    {name: 'norm', index: 'norm', editable: true, align: "left"},
                    {name: 'result', index: 'result', editable: true, align: "left"},
                    {name: 'count', index: 'count', editable: true, align: "center"}
                ],
                rowNum: 20,
                height: 350,
                width: 900,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagerqcregistry'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updqcregistry.jsp"
            })
                    .navGrid('#pagerqcregistry', {edit: false, add: false, del: false, refresh: false, view: false, search: false},
                            {dataheight: 450, width: 800, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for edit
                            {dataheight: 450, width: 800, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for add
                            {closeAfterDelete: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 450, width: 800, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    );

            jQuery("#req").jqGrid({
                treeGrid: true,
                treeGridModel: "adjacency",
                ExpandColumn: "code",
                treedatatype: "local",
                datatype: "jsonstring",
                datastr: tbldata,
                colNames: ['id', '<%=trs.t("ბარკოდი")%>', '<%=trs.t("კვლევის დასახელება")%>', '<%=trs.t("ნიმუშის ტიპი")%>', '<%=trs.t("ტესტი")%>', '<%=trs.t("სავარაუდო დიაგნოზი")%>', '<%=trs.t("რეგისტრაციის თარიღი")%>', '<%=trs.t("მიღების თარიღი")%>', '<%=trs.t("დასრულების თარიღი")%>', '<%=trs.t("შედეგი")%>', '<%=trs.t("ვინ ჩაატარა")%>', '<%=trs.t("ხარისხის კონტრ. შედეგი")%>', '<%=trs.t("შენიშვნა")%>'],
                colModel: [
                    {name: 'id', index: 'id', editable: true, align: "left", hidden: true, width: 1},
                    {name: 'code', index: 'code', editable: true, align: "left", width: 100},
                    {name: 'name', index: 'name', editable: true, align: "left"},
                    {name: 'type', index: 'type', editable: true, align: "left"},
                    {name: 'test', index: 'test', editable: true, align: "left"},
                    {name: 'diagnos', index: 'diagnos', editable: true, align: "left"},
                    {name: 'regdate', index: 'regdate', editable: true, align: "left"},
                    {name: 'getdate', index: 'getdate', editable: true, align: "left"},
                    {name: 'enddate', index: 'enddate', editable: true, align: "left"},
                    {name: 'result', index: 'result', editable: true, align: "left"},
                    {name: 'who', index: 'who', editable: true, align: "left"},
                    {name: 'result', index: 'result', editable: true, align: "left"},
                    {name: 'note', index: 'note', editable: true, align: "left"}
                ],
                rowNum: 20,
                height: 350,
                width: 900,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagerreq'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updreq.jsp",
                ondblClickRow: function (id, ri, ci) {
                    jQuery("#req").jqGrid('editGridRow', id, {dataheight: 450, width: 800, closeAfterEdit: true, reloadAfterSubmit: false, afterSubmit: checkStatus});
                    return;
                }
            })
                    .navGrid('#pagerreq', {edit: false, add: false, del: false, refresh: false, view: false, search: false},
                            {dataheight: 450, width: 800, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for edit
                            {dataheight: 450, width: 800, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for add
                            {closeAfterDelete: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 450, width: 800, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    )

                    .navButtonAdd('#pagerreq', {
                        caption: "გაუქმება/აღდგენა",
                        buttonicon: "ui-icon-2",
                        onClickButton: function () {
                            $("#msgModal").modal("show");
                        },
                        position: "last"
                    });
            jQuery("#req").jqGrid('setGroupHeaders', {
                useColSpanStyle: false
            });

            var tbldata2 = [{
                    name: "1000 მარცვლის მასის განსაზღვრა",
                    answer: '<div class="smart-form"><label class="select"><select><option value="0"><%=trs.t("დადებითი")%></option><option value="1"><%=trs.t("უარყოფითი")%></option></select> <i></i></label></div>',
                    norm: "უარყოფითი"
                }, {
                    name: "1000 მარცვლის მასის განსაზღვრა",
                    answer: '<div class="smart-form"><label class="input"><input value="0.37" type="text"></label></div>',
                    norm: "0.1 - 1"
                }, {
                    name: "1000 მარცვლის მასის განსაზღვრა",
                    answer: '<div class="smart-form"><label class="input"><input value="მწვანე" type="text"></label></div>',
                    norm: "წითელი"
                }];

            jQuery("#reqanswer").jqGrid({
                data: tbldata2,
                datatype: "local",
                colNames: ['<%=trs.t("დასახელება")%>', '<%=trs.t("შედეგი")%>', '<%=trs.t("ნორმატივი")%>'],
                colModel: [
                    {name: 'name', index: 'name', editable: true, align: "left"},
                    {name: 'answer', index: 'answer', editable: true, align: "left"},
                    {name: 'norm', index: 'norm', editable: true, align: "left"}
                ],
                rowNum: 20,
                height: 350,
                width: 900,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: false,
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updreq.jsp",
                ondblClickRow: function (id, ri, ci) {
                    jQuery("#reqanswer").jqGrid('editGridRow', id, {dataheight: 450, width: 800, closeAfterEdit: true, reloadAfterSubmit: false, afterSubmit: checkStatus});
                    return;
                }
            })
                    .navGrid('#pagerreqanswer', {edit: false, add: false, del: false, refresh: false, view: false, search: false},
                            {dataheight: 450, width: 800, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for edit
                            {dataheight: 450, width: 800, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for add
                            {closeAfterDelete: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 450, width: 800, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    );


            jQuery("#reqanswer2").jqGrid({
                data: tbldata2,
                datatype: "local",
                colNames: ['<%=trs.t("დასახელება")%>', '<%=trs.t("შედეგი")%>', '<%=trs.t("ნორმატივი")%>'],
                colModel: [
                    {name: 'name', index: 'name', editable: true, align: "left"},
                    {name: 'answer', index: 'answer', editable: true, align: "left"},
                    {name: 'norm', index: 'norm', editable: true, align: "left"}
                ],
                rowNum: 20,
                height: 350,
                width: 900,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: false,
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updreq.jsp",
                ondblClickRow: function (id, ri, ci) {
                    jQuery("#reqanswer2").jqGrid('editGridRow', id, {dataheight: 450, width: 800, closeAfterEdit: true, reloadAfterSubmit: false, afterSubmit: checkStatus});
                    return;
                }
            })
                    .navGrid('#pagerreqanswer2', {edit: false, add: false, del: false, refresh: false, view: false, search: false},
                            {dataheight: 450, width: 800, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for edit
                            {dataheight: 450, width: 800, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for add
                            {closeAfterDelete: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 450, width: 800, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
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
                jQuery("#req").jqGrid('setGridWidth', $("#content").width() - 10);
                jQuery("#reqanswer").jqGrid('setGridWidth', 600);
                jQuery("#reqanswer2").jqGrid('setGridWidth', 600);
                jQuery("#qcregistry").jqGrid('setGridWidth', 920);
            })
        }
    }

    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);
    $(document).on("click", ".jarviswidget-toggle-btn", function () {
        $(".table-size9").toggleClass("active");
    });
    $(".datetime").datetimepicker({
        format: 'DD/MM/YYYY HH:mm'
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
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!
    var yyyy = today.getFullYear();

    if (dd < 10) {
        dd = '0' + dd
    }

    if (mm < 10) {
        mm = '0' + mm
    }

    today = dd + '/' + mm + '/' + yyyy;
    $("#now").val(today)

    function showList() {
        $("#qcregistryModal").modal("show");
    }
</script>


