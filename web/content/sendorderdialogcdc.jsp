<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
%>
<script>
    $("#transit").hide();
    $("#place").on("change", function () {
        var pl = $("#place").val();
        if (pl == 0) {
            $("#local").show();
            $("#transit").hide();
        } else {
            $("#local").hide();
            $("#transit").show();
        }
    });
    $(document).on("change", "#condition", function () {
        if ($(this).val() == "2") {
            $(".condition-reason").show();
            $(".rejected").show();
        } else {
            $(".condition-reason").hide();
            $(".condition-reason-other").hide();
            $("#condition-reason").val("0");
            $(".rejected").hide();
        }
    });
    $(document).on("change", "#condition-reason", function () {
        if ($(this).val() == "4") {
            $(".condition-reason-other").show();
        } else {
            $(".condition-reason-other").hide();
        }
    });
    $(document).on("change", ".place", function () {
        if ($(this).val() == "3") {
            $(".place-other").show();
        } else {
            $(".place-other").hide();
        }
    });
    $(document).on("change", ".detection", function () {
        if ($(this).val() == "3") {
            $(".detection-other").show();
        } else {
            $(".detection-other").hide();
        }
    });
    $(document).on("change", ".process", function () {
        if ($(this).val() == "3") {
            $(".process-other").show();
        } else {
            $(".process-other").hide();
        }
    });
    $(document).on("change", ".generating", function () {
        if ($(this).val() == "1") {
            $(".generating-yes").show();
        } else {
            $(".generating-yes").hide();
        }
    });
    $(document).on("change", ".materials", function () {
        if ($(this).val() == "2") {
            $(".materials-other").show();
        } else {
            $(".materials-other").hide();
        }
    });
    $(document).on("change", ".machine", function () {
        if ($(this).val() == "2") {
            $(".machine-other").show();
        } else {
            $(".machine-other").hide();
        }
    });
    $(document).on("change", ".human", function () {
        if ($(this).val() == "2") {
            $(".human-other").show();
        } else {
            $(".human-other").hide();
        }
    });
    $(document).on("change", ".environment", function () {
        if ($(this).val() == "2") {
            $(".environment-other").show();
        } else {
            $(".environment-other").hide();
        }
    });
    $(document).on("change", ".methods", function () {
        if ($(this).val() == "2") {
            $(".methods-other").show();
        } else {
            $(".methods-other").hide();
        }
    });
</script>
<div class="smart-form">
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-5">
            <b><%=trs.t("ნიმუშ(ებ)ის ჭურჭლის N")%>:</b> 27651283
        </div>
        <div class="col col-sm-5">
            <b><%=trs.t("ნიმუშის ტიპი")%>:</b> <%=trs.t("სისხლი")%>
        </div>
        <div class="col col-sm-2 text-right">
            <button class="btn btn-primary showcode"><i class="fa fa-print"></i></button>
        </div>
    </div>

    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-12">
            <label class="select">
                <select id="condition">
                    <option value="0"><%=trs.t("- ნიმუშის მდგომარეობა მიღებისას -")%></option>
                    <option value="1"><%=trs.t("სათანადო")%></option>
                    <option value="2"><%=trs.t("დაწუნება")%></option>
                </select><i></i>
                <b class="tooltip tooltip-top-right"><%=trs.t("ნიმუშის მდგომარეობა მიღებისას")%></b>
            </label>
        </div>
    </div>
    <div class="row condition-reason" style="margin-bottom: 5px !important; display: none;">
        <div class="col col-sm-12" style="">
            <label class="select">
                <select id="condition-reason">
                    <option value="0"><%=trs.t("- დაწუნების მიზეზი -")%></option>
                    <option value="1"><%=trs.t("მიზეზი 1")%></option>
                    <option value="2"><%=trs.t("მიზეზი 2")%></option>
                    <option value="3"><%=trs.t("მიზეზი 3")%></option>
                    <option value="4"><%=trs.t("სხვა")%></option>
                </select><i></i>
                <b class="tooltip tooltip-top-right"><%=trs.t("დაწუნების მიზეზი")%></b>
            </label>
        </div>
    </div>
    <div class="row condition-reason-other" style="margin-bottom: 5px !important; display: none;">
        <div class="col col-sm-12" style="">
            <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                <textarea id="condition-reason-other" placeholder="<%=trs.t("მიუთითეთ მიზეზი")%>"></textarea>
                <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("მიუთითეთ მიზეზი")%></b>
            </label>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-calendar"></i>
                <input class="datetime now" placeholder="<%=trs.t("მიღების თარიღი/დრო")%>" type="text" value="<%=dtlong.format(new Date())%>">
                <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("მიღების თარიღი და დრო")%></b>
            </label>
        </div>
        <div class="col col-sm-6">
            <label class="select">
                <select id="place">
                    <option value="0"><%=trs.t("ადგილზე გამოსაკვლევი")%></option>
                    <option value="1"><%=trs.t("ტრანზიტი")%></option>
                </select><i></i>
                <b class="tooltip tooltip-top-right"><%=trs.t("დანიშნულება")%></b>
            </label>
        </div>
    </div>
    <div id="transit">
        <div class="row" style="margin-bottom: 5px !important;">
            <div class="col col-sm-12">
                <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                    <input placeholder="<%=trs.t("დამცავი კონტეინერის N")%>" type="text">
                    <b class="tooltip tooltip-top-right"><i class="fa fa-list-ol txt-color-teal"></i> <%=trs.t("დამცავი კონტეინერის N")%></b>
                </label>
            </div>
        </div>
        <div class="row" style="margin-bottom: 5px !important;">
            <div class="col col-sm-6">
                <label class="input"> <i class="icon-append fa fa-institution"></i>
                    <input placeholder="<%=trs.t("მიმღები დაწესებულება")%>" type="text">
                    <b class="tooltip tooltip-top-right"><i class="fa fa-institution txt-color-teal"></i> <%=trs.t("მიმღები დაწესებულება")%></b>
                </label>
            </div>
            <div class="col col-sm-6">
                <label class="input"> <i class="icon-append fa fa-home"></i>
                    <input placeholder="<%=trs.t("გამომკვლევი დაწესებულება")%>" type="text">
                    <b class="tooltip tooltip-top-right"><i class="fa fa-home txt-color-teal"></i> <%=trs.t("გამომკვლევი დაწესებულება")%></b>
                </label>
            </div>
        </div>
        <div class="row" style="margin-bottom: 5px !important;">
            <div class="col col-sm-12">
                <label class="input"> <i class="icon-append fa fa-users"></i>
                    <input class="tagsinput" data-role="tagsinput" placeholder="<%=trs.t("ტრანსპ. პასუხისმგებელი პირები")%>" type="text">
                    <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("ტრანსპ. პასუხისმგებელი პირები (სახელი, გვარი)")%></b>
                </label>
            </div>
        </div>
    </div>

    <div id="local">
        <div class="row" style="margin-bottom: 5px !important;">
            <div class="col col-sm-6">
                <label class="select">
                    <select>
                        <option value="0"><%=trs.t("- გადაეცა პირს -")%></option>
                    </select><i></i>
                    <b class="tooltip tooltip-top-right"><%=trs.t("გადაეცა პირს")%></b>
                </label>
            </div>        
            <div class="col col-sm-6">
                <label class="select">
                    <select>
                        <option value="0"><%=trs.t("- ლაბორატორია -")%></option>
                    </select><i></i>
                    <b class="tooltip tooltip-top-right"><%=trs.t("ლაბორატორია")%></b>
                </label>
            </div>
        </div>        
        <div class="row" style="margin-bottom: 5px !important;">
            <div class="col col-sm-6">
                <label class="select">
                    <select class="onchange">
                        <option value="0"><%=trs.t("- კვლევა -")%></option>
                        <option value="1"><%=trs.t("ადამიანის ნიმუშების კვლევა შავი ჭირის გამომწვევზე.")%></option>
                        <option value="2"><%=trs.t("ადამიანის ნიმუშების კვლევა ჯილეხის გამომწვევზე.")%></option>
                    </select><i></i>
                </label>
            </div>        
            <div class="col col-sm-6">
                <label class="select">
                    <select class="test-list1">
                        <option value="0"><%=trs.t("- ტესტები -")%></option>
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
            </div>        
        </div>
        <div class="row" style="margin-bottom: 5px !important;">
            <div class="col col-sm-12">
                <label class="input"> <i class="icon-append fa fa-calendar"></i>
                    <input class="datepicker" placeholder="<%=trs.t("ლაბორატორიაში გადაცემის თარიღი და დრო")%>" type="text" value="<%=dt.format(new Date())%>">
                    <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("ლაბორატორიაში გადაცემის თარიღი და დრო")%></b>
                </label>
            </div>
        </div>
    </div>
    <div class="rejected" style="display: none;">
        <h2 class="text-title"><%=trs.t("შეუსაბამობები - საჩივრები და გაუმჯობესებასთან დაკავშირებული აქტივობები")%></h2>
        <div class="rejected1">
            <div class="row" style="margin-bottom: 5px !important;">
                <div class="col col-sm-12">
                    <label class="select">
                        <select class="place">
                            <option value="0"><%=trs.t("- ადგილი -")%></option>
                            <option value="1"><%=trs.t("დკსჯეც")%></option>
                            <option value="2"><%=trs.t("ლუგარის ცენტრი")%></option>
                            <option value="3"><%=trs.t("სხვა")%></option>
                        </select><i></i>
                    </label>
                </div>
            </div>
            <div class="row place-other" style="margin-bottom: 5px !important; display: none;">
                <div class="col col-sm-12" style="">
                    <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                        <textarea placeholder="<%=trs.t("მიუთითეთ სხვა ადგილი")%>"></textarea>
                        <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("მიუთითეთ სხვა ადგილი")%></b>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class="col col-sm-12">
                    <label class="select">
                        <select class="detection">
                            <option value="0"><%=trs.t("- შეუსაბამობის აღმოჩენა/განხილვა -")%></option>
                            <option value="1"><%=trs.t("შეფასება/აუდიტი")%></option>
                            <option value="2"><%=trs.t("მოთხოვნა ნიმუშის მიმართ")%></option>
                            <option value="3"><%=trs.t("სხვა")%></option>
                        </select><i></i>
                    </label>
                </div>
            </div>
            <div class="row detection-other" style="margin-bottom: 5px !important; display: none;">
                <div class="col col-sm-12" style="">
                    <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                        <textarea placeholder="<%=trs.t("მიუთითეთ სხვა შეუსაბამობის აღმოჩენა/განხილვა")%>"></textarea>
                        <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("მიუთითეთ სხვა შეუსაბამობის აღმოჩენა/განხილვა")%></b>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class="col col-sm-12">
                    <label class="select">
                        <select class="process">
                            <option value="0"><%=trs.t("- პროცესის ტიპი -")%></option>
                            <option value="1"><%=trs.t("ორგანიზაცია")%></option>
                            <option value="2"><%=trs.t("პრე-ანალიზური")%></option>
                            <option value="3"><%=trs.t("სხვა")%></option>
                        </select><i></i>
                    </label>
                </div>
            </div>
            <div class="row process-other" style="margin-bottom: 5px !important; display: none;">
                <div class="col col-sm-12" style="">
                    <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                        <textarea placeholder="<%=trs.t("მიუთითეთ სხვა პროცესის ტიპი")%>"></textarea>
                        <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("მიუთითეთ სხვა პროცესის ტიპი")%></b>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">   
                <div class="col col-sm-6">
                    <label class="select">
                        <select class="scale">
                            <option value="0"><%=trs.t("- მასშტაბი -")%></option>
                            <option value="1"><%=trs.t("უმნიშვნელო")%></option>
                            <option value="2"><%=trs.t("მნიშვნელოვანი")%></option>
                        </select><i></i>
                    </label>
                </div>
                <div class="col col-sm-6">
                    <label class="input"> <i class="icon-append fa fa-file"></i>
                        <input placeholder="<%=trs.t("ISO15189-ის პუნქტი")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i></b>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class="col col-sm-6">
                    <label class="input"> <i class="icon-append fa fa-calendar"></i>
                        <input class="datepicker" placeholder="<%=trs.t("პრობლების გამოვლენის თარიღი")%>" type="text" value="<%=dt.format(new Date())%>">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("პრობლების გამოვლენის თარიღი")%></b>
                    </label>
                </div>
                <div class="col col-sm-6">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- ვინ გამოავლინა -")%></option>
                            <option value="1"><%=trs.t("გიორგი გიორგაძე")%></option>
                            <option value="2"><%=trs.t("ლერი კობახიძე")%></option>
                        </select><i></i>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class="col col-sm-12">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- სტრუქტურული ერთეული -")%></option>
                            <option value="1"><%=trs.t("მიმღები")%></option>
                        </select><i></i>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class="col col-sm-6">
                    <label class="select">
                        <select class="generating">
                            <option value="0"><%=trs.t("- სამუშაოს შეფერხების გამოწვევა -")%></option>
                            <option value="1"><%=trs.t("დიახ")%></option>
                            <option value="2"><%=trs.t("არა")%></option>
                        </select><i></i>
                    </label>
                </div>
                <div class="col col-sm-6 generating-yes" style="display: none;">
                    <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                        <input placeholder="<%=trs.t("სამუშაოს შეფერხების ხანგრძლივობა")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("სამუშაოს შეფერხების ხანგრძლივობა")%></b>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class="col col-sm-12" style="">
                    <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                        <textarea placeholder="<%=trs.t("პრობლემის აღწერა")%>"></textarea>
                        <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("პრობლემის აღწერა")%></b>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class="col col-sm-12" style="">
                    <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                        <textarea placeholder="<%=trs.t("გადაუდებელი გამოსასწორებელი ღონისძიება")%>"></textarea>
                        <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("გადაუდებელი გამოსასწორებელი ღონისძიება")%></b>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class="col col-sm-6">
                    <label class="select">
                        <select class="generating">
                            <option value="0"><%=trs.t("- ვინ შეასრულა -")%></option>
                            <option value="1"><%=trs.t("გიორგი გიორგაძე")%></option>
                            <option value="2"><%=trs.t("ლერი კობახიძე")%></option>
                        </select><i></i>
                    </label>
                </div>
                <div class="col col-sm-6">
                    <label class="checkbox"><input name="checkbox" type="checkbox"><i></i><%=trs.t("პრევენციული ღონისძიება")%></label>
                </div>
            </div>
            <h2 class="text-title"><%=trs.t("მაკორექტირებელი ღონისძიება")%></h2>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class="col col-sm-12" style="">
                    <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                        <textarea placeholder="<%=trs.t("ძირეული პრობლემები")%>"></textarea>
                        <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("ძირეული პრობლემები")%></b>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class="col col-sm-12" style="">
                    <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                        <textarea placeholder="<%=trs.t("სამოქმედო გეგმა")%>"></textarea>
                        <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("სამოქმედო გეგმა")%></b>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-user"></i>
                        <input placeholder="<%=trs.t("ვის მიერ არის შემოთავაზებული")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("ვის მიერ არის შემოთავაზებული")%></b>
                    </label>
                </div>
            </div>
        </div>
        <div class="rejected2">
            <div class="row" style="margin-bottom: 5px !important;">
                <div class="col col-sm-6">
                    <label class="select">
                        <select class="materials">
                            <option value="0"><%=trs.t("- მასალები (ან წყაროები) -")%></option>
                            <option value="1"><%=trs.t("მიწოდება")%></option>
                            <option value="2"><%=trs.t("სხვა")%></option>
                        </select><i></i>
                    </label>
                </div>
                <div class="col col-sm-6">
                    <label class="input"> <i class="icon-append fa fa-question"></i>
                        <input placeholder="<%=trs.t("მიზეზი")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("მიზეზი")%></b>
                    </label>
                </div>
            </div>
            <div class="row materials-other" style="margin-bottom: 5px !important; display: none;">
                <div class="col col-sm-12" style="">
                    <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                        <textarea placeholder="<%=trs.t("დააკონკრეტეთ")%>"></textarea>
                        <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("დააკონკრეტეთ")%></b>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class="col col-sm-6">
                    <label class="select">
                        <select class="machine">
                            <option value="0"><%=trs.t("- ტექნიკა/აღჭურვილობა -")%></option>
                            <option value="1"><%=trs.t("ტექმომსახურება")%></option>
                            <option value="2"><%=trs.t("სხვა")%></option>
                        </select><i></i>
                    </label>
                </div>
                <div class="col col-sm-6">
                    <label class="input"> <i class="icon-append fa fa-question"></i>
                        <input placeholder="<%=trs.t("მიზეზი")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("მიზეზი")%></b>
                    </label>
                </div>
            </div>
            <div class="row machine-other" style="margin-bottom: 5px !important; display: none;">
                <div class="col col-sm-12" style="">
                    <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                        <textarea placeholder="<%=trs.t("დააკონკრეტეთ")%>"></textarea>
                        <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("დააკონკრეტეთ")%></b>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class="col col-sm-6">
                    <label class="select">
                        <select class="human">
                            <option value="0"><%=trs.t("- ადამიანური ფაქტორი -")%></option>
                            <option value="1"><%=trs.t("დაღლილობა")%></option>
                            <option value="2"><%=trs.t("სხვა")%></option>
                        </select><i></i>
                    </label>
                </div>
                <div class="col col-sm-6">
                    <label class="input"> <i class="icon-append fa fa-question"></i>
                        <input placeholder="<%=trs.t("მიზეზი")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("მიზეზი")%></b>
                    </label>
                </div>
            </div>
            <div class="row human-other" style="margin-bottom: 5px !important; display: none;">
                <div class="col col-sm-12" style="">
                    <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                        <textarea placeholder="<%=trs.t("დააკონკრეტეთ")%>"></textarea>
                        <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("დააკონკრეტეთ")%></b>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class="col col-sm-6">
                    <label class="select">
                        <select class="environment">
                            <option value="0"><%=trs.t("- გარემო -")%></option>
                            <option value="1"><%=trs.t("ორგანიზაცია")%></option>
                            <option value="2"><%=trs.t("სხვა")%></option>
                        </select><i></i>
                    </label>
                </div>
                <div class="col col-sm-6">
                    <label class="input"> <i class="icon-append fa fa-question"></i>
                        <input placeholder="<%=trs.t("მიზეზი")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("მიზეზი")%></b>
                    </label>
                </div>
            </div>
            <div class="row environment-other" style="margin-bottom: 5px !important; display: none;">
                <div class="col col-sm-12" style="">
                    <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                        <textarea placeholder="<%=trs.t("დააკონკრეტეთ")%>"></textarea>
                        <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("დააკონკრეტეთ")%></b>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class="col col-sm-6">
                    <label class="select">
                        <select class="methods">
                            <option value="0"><%=trs.t("- მეთოდები/პროცესები -")%></option>
                            <option value="1"><%=trs.t("პროცედურები")%></option>
                            <option value="2"><%=trs.t("სხვა")%></option>
                        </select><i></i>
                    </label>
                </div>
                <div class="col col-sm-6">
                    <label class="input"> <i class="icon-append fa fa-question"></i>
                        <input placeholder="<%=trs.t("მიზეზი")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("მიზეზი")%></b>
                    </label>
                </div>
            </div>
            <div class="row methods-other" style="margin-bottom: 5px !important; display: none;">
                <div class="col col-sm-12" style="">
                    <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                        <textarea placeholder="<%=trs.t("დააკონკრეტეთ")%>"></textarea>
                        <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("დააკონკრეტეთ")%></b>
                    </label>
                </div>
            </div>
            <div class="row" style="margin-bottom: 5px !important;">
                <div class="col col-sm-12" style="">
                    <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                        <textarea placeholder="<%=trs.t("პრიორიტეტები რისკების მიხედვით")%>"></textarea>
                        <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("პრიორიტეტები რისკების მიხედვით")%></b>
                    </label>
                </div>
            </div>
        </div>
    </div>
</div>
