<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%    JSONObject obj = getFromFile(basedir + "json/registrycdc.json");
    session.setAttribute("REGISTRYCDC", (JSONObject) obj);
    JSONArray parts = obj.getJSONArray("parts");
%>
<style>
    #exportreestr {
        line-height: 1.19 !important;
    }
    .frontbtn {
        cursor: pointer;
        height: 167px;
        font-weight: bold;
        color: #37375E;
        background: url("img/bg-blue.png");
        background-size: 100% 100%;
        box-shadow: 6px 6px 6px #909090;
        border-radius: 0;
    }
    #mainselection .col-sm-4:nth-child(2) .frontbtn {
        background: url("img/bg-blue2.png");
        background-size: 100% 100%;
    }
    #mainselection .col-sm-4:nth-child(3) .frontbtn {
        background: url("img/bg-blue.png");
    }
    #mainselection .col-sm-4:nth-child(4) .frontbtn {
        background: url("img/bg-blue2.png");
    }
    #mainselection .col-sm-4:nth-child(5) .frontbtn {
        background: url("img/bg-blue.png");
        background-size: 200% 200%;
    }
    #mainselection .col-sm-4:nth-child(6) .frontbtn {
        background: url("img/bg-blue2.png");
        background-size: 200% 200%;
    }
    
    .frontbtn:hover {  }

    .frontbtn:active {
      box-shadow: 2px 2px 2px #585555;
      transform: translateY(4px);
    }
</style>
<script src="js/plugin/bootstrap-tags/bootstrap-tagsinput.min.js" type="text/javascript"></script>
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript">
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
        $(".table-size2").toggleClass("active");
    });

    $("#registrymaincontent").hide();

    function showRegistry(part) {
        $.post("content/registrycdc.jsp", {partidx: part}, function (data) {
            $("#registrycontent").html(data);
            $("#mainselection").hide();
            $("#registrymaincontent").show();
        });
    }

    function hideRegistry() {
        $("#registrycontent").html("");
        $("#mainselection").show();
        $("#registrymaincontent").hide();
    }

    function savepatnext() {
        $('#patModal').modal('hide');
        addOrder(id, name);
    }

    function addPatient(id, name) {
        $.post("content/" + name + ".jsp", {id: id}, function (data) {
            //var name = jQuery('#analizelist').jqGrid('getCell',id,'name');
            $("#patModalTitle").html("<%=trs.t("საკვლევი ობიექტის დამატება")%>");
            $('#patModal').modal('show');
            //showLoader("pricebody");
            $("#patbody").html(data);
        });
    }

    function addOrder(id, name) {
        if (id > 0) {
            $.post("content/" + name + ".jsp", {id: id}, function (data) {
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

    function addOrderg(id, name) {
        $.post("content/" + name + ".jsp", {id: id}, function (data) {
            //var name = jQuery('#analizelist').jqGrid('getCell',id,'name');
            $("#orderModalTitle").html("<%=trs.t("შეკვეთის რეგისტრაცია")%>");
            $('#orderModal').modal('show');
            //showLoader("pricebody");
            $("#orderbody").html(data);
        });
    }

    function sendOrder(id, name) {
        if (id > 0) {
            $.post("content/" + name + ".jsp", {id: id}, function (data) {
                //var name = jQuery('#analizelist').jqGrid('getCell',id,'name');
                $("#sendbtn").html('<%=trs.t("გაგზავნა")%> <span class="fa fa-send"></span>');
                $("#sendorderModalTitle").html("<%=trs.t("შეკვეთის გადაგზავნა")%>");
                $('#sendorderModal').modal('show');
                //showLoader("pricebody");
                $("#sendorderbody").html(data);
            });
        } else {
            alert('<%=trs.t("აირიეთ ჩანაწერი")%>');
        }
    }

    function getOrder(id, name) {
        if (id > 0) {
            $.post("content/" + name + ".jsp", {id: id}, function (data) {
                //var name = jQuery('#analizelist').jqGrid('getCell',id,'name');
                $("#sendbtn").html('<%=trs.t("მიღება")%> <span class="fa fa-level-down"></span>');
                $("#sendorderModalTitle").html("<%=trs.t("შეკვეთის მიღება")%>");
                $('#sendorderModal').modal('show');
                //showLoader("pricebody");
                $("#sendorderbody").html(data);
            });
        } else {
            alert('<%=trs.t("აირიეთ ჩანაწერი")%>');
        }
    }

    function vieweditReg(n) {
        var id = jQuery('#reestr' + n).jqGrid('getGridParam', 'selrow');
        if (id > 0) {
            alert('<%=trs.t("აქ იქნება რედაქტირების დიალოგი")%>');
        } else
            alert('<%=trs.t("აირიეთ ჩანაწერი")%>');
    }

    function printReg(n) {
        var id = jQuery('#reestr' + n).jqGrid('getGridParam', 'selrow');
        if (id > 0) {
            window.open("forms/regcdc1.pdf");
        } else
            alert('<%=trs.t("აირიეთ ჩანაწერი")%>');
    }

    function deleteReg(n) {
        var id = jQuery('#reestr' + n).jqGrid('getGridParam', 'selrow');
        if (id > 0) {
            confirm('<%=trs.t("დარწმუნებული ხართ რორ გინდათ ჩანაწერის წაშლა?")%>');
        } else
            alert('<%=trs.t("აირიეთ ჩანაწერი")%>');
    }


    $("#aa2").hide();
</script>
<div id="mainselection">
    <%for (int i = 0; i < parts.size(); i++) {
            JSONObject part = parts.getJSONObject(i);
            JSONArray icons = part.getJSONArray("icons");
    %>
    <div class="col-sm-4">
        <div class="well well-lg text-center frontbtn" onclick="showRegistry(<%=i%>)" id="<%=part.getString("name")%>">
            <%for (int j = 0; j < icons.size(); j++) {%>
            <i class="<%=icons.getString(j)%>"></i>
            <%}%>
            <h1><b><%=trs.t(part.getString("title"))%></b></h1>
        </div>
    </div>
    <%}%>
</div>
<div id="registrymaincontent">


    <section id="widget-grid" class="" style="padding-right: 5px;">
        <div class="jarviswidget" data-widget-collapsed="true" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false">
            <header>
                <h2><%=trs.t("ფილტრი")%></h2>
            </header>
            <div>
                <div class="smart-form col-sm-12" style="padding: 0;">
                    <div class="col-sm-12">
                        <section class="col custwidth">
                            <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                                <input placeholder="<%=trs.t("პირადი ნომერი")%>" type="text">
                                <b class="tooltip tooltip-top-right"><i class="fa fa-list-ol txt-color-teal"></i> <%=trs.t("პირადი ნომერი")%></b>
                            </label>
                        </section>
                        <section class="col custwidth">
                            <label class="input"> <i class="icon-append fa fa-code"></i>
                                <input placeholder="<%=trs.t("ბარკოდი")%>" type="text">
                                <b class="tooltip tooltip-top-right"><i class="fa fa-code txt-color-teal"></i> <%=trs.t("ბარკოდი")%></b>
                            </label>
                        </section>
                        <section class="col custwidth">
                            <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                                <input placeholder="<%=trs.t("დამცავი კონტეინერი N")%>" type="text">
                                <b class="tooltip tooltip-top-right"><i class="fa fa-list-ol txt-color-teal"></i> <%=trs.t("დამცავი კონტეინერი N")%></b>
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
                            <label class="input"> <i class="icon-append fa fa-user"></i>
                                <input placeholder="<%=trs.t("პაციენტის სახელი")%>" type="text">
                                <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("პაციენტის სახელი")%></b>
                            </label>
                        </section>
                        <section class="col custwidth">
                            <label class="input"> <i class="icon-append fa fa-user"></i>
                                <input placeholder="<%=trs.t("პაციენტის გვარი")%>" type="text">
                                <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("პაციენტის გვარი")%></b>
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
                        <section class="col custwidth">
                            <label class="input"> <i class="icon-append fa fa-user"></i>
                                <input placeholder="<%=trs.t("დამკვეთი")%>" type="text">
                                <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("დამკვეთი")%></b>
                            </label>
                        </section>
                        <section class="col custwidth">
                            <label class="input"> <i class="icon-append fa fa-institution"></i>
                                <input placeholder="<%=trs.t("გამომგზავნი დაწესებულება")%>" type="text">
                                <b class="tooltip tooltip-top-right"><i class="fa fa-institution txt-color-teal"></i> <%=trs.t("გამომგზავნი დაწესებულება")%></b>
                            </label>
                        </section>
                        <section class="col custwidth">
                            <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                <input class="daterangepicker" placeholder="<%=trs.t("გაგზავნის თარიღი")%>" type="text">
                                <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("გაგზავნის თარიღი")%></b>
                            </label>
                        </section>
                        <section class="col custwidth">
                            <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                <input class="daterangepicker" placeholder="<%=trs.t("მიღების თარიღი")%>" type="text">
                                <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("მიღების თარიღი")%></b>
                            </label>
                        </section>
                        <section class="col custwidth">
                            <label class="input"> <i class="icon-append fa fa-globe"></i>
                                <input placeholder="<%=trs.t("პროექტი/პროგრამა")%>" type="text">
                                <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("პროექტი ან პროგრამა")%></b>
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
                        <button class="btn btn-info pull-right" style='margin-right: 5px;' data-original-title="<%=trs.t("გასუფთავება")%>"><i class="fa fa-times"></i></button>
                        <button class="btn btn-success pull-right" style='margin-right: 5px;' data-original-title="<%=trs.t("ძებნა")%>"><i class="fa fa-search"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <%--div class="col-md-12 btn-panel">
        <button class="btn btn-warning pull-right"><i class="fa fa-book"></i> <%=trs.t("შემოწმება")%></button>
        <button class="btn btn-success pull-right"><i class="fa fa-book"></i> <%=trs.t("მიღება")%></button>
    </div--%>
    <div id="registrycontent"></div>
</div>
<div class="modal fade" id="patModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 800px !important;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id='patModalTitle'></h4>
            </div>
            <div class="modal-body">
                <div class="table-sizeModal" id='patbody'>

                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-warning" onclick="savepatnext()">
                    <%=trs.t("შენახვა და რეგისტრაცია")%> <span class="fa fa-list-alt"></span>
                </button>
                <button type="button" class="btn btn-success" onclick="savepat()">
                    <%=trs.t("შენახვა")%> <span class="fa fa-save"></span>
                </button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">
                    <%=trs.t("დახურვა")%> <span class="fa fa-close"></span>
                </button>
            </footer>
        </div>
    </div>
</div>

<div class="modal fade" id="orderModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 900px !important;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id='orderModalTitle'></h4>
            </div>
            <div class="modal-body">
                <div class="table-sizeModal" id='orderbody'>

                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-warning" onclick="savepatnext()">
                    <%=trs.t("შენახვა და მიღება")%> <span class="fa fa-save"></span>
                </button>
                <button type="button" class="btn btn-success" onclick="saveorder()">
                    <%=trs.t("შენახვა")%> <span class="fa fa-save"></span>
                </button>
                <button type="button" class="btn btn-success" onclick="saveorder()">
                    <%=trs.t("გაგზავნა")%> <span class="fa fa-send"></span>
                </button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">
                    <%=trs.t("დახურვა")%> <span class="fa fa-close"></span>
                </button>
            </footer>
        </div>
    </div>
</div>

<div class="modal fade" id="sendorderModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 800px !important;">
        <div class="modal-content">
            <div class="modal-header modal-header-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id='sendorderModalTitle'></h4>
            </div>
            <div class="modal-body">
                <div class="table-sizeModal" id='sendorderbody'>

                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-success" onclick="sendorder()" id="sendbtn">
                    <%=trs.t("გაგზავნა")%> <span class="fa fa-send"></span>
                </button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">
                    <%=trs.t("დახურვა")%> <span class="fa fa-close"></span>
                </button>
            </footer>
        </div>
    </div>
</div>

