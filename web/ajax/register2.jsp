<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%    SampletypeBean[] sampletypes = SampletypeManager.getInstance().loadByWhere("where companyid = " + user.getCompanyid() + " order by name");
    String actcontent = "საქართველოს სოფლის მეურნეობის სამინისტროს ლაბორატორიის ნიმუშების რეგისტრაციის და სტატისტიკური დამუშავების განყოფილების მთ.სპეციალისტი ნანა მელაძე ერთის მხრივ და მეორე მხრივ შ.პ.ს. ,,კავკასია 2“-ის წარმომადგენელი ემზარ ძამაშვილი ვადგენთ აქტს მასზედ, რომ ემზარ ძამაშვილმა ლაბორატორიაში შემოიტანა წრპ-ს (ცხვარი) სისხლის  სინჯი  957(ცხრაას ორმოცდა ჩვიდმეტი) ბრუცელოზზე და თურქულის არასტრუქტურულ ცილებზე გამოსაკვლევად.";
%>
<style>
    .ui-autocomplete {
        width: auto !important;
    }
</style>
<div class="jarviswidget jarviswidget-sortable" id="wid-id-3" data-widget-editbutton="false" data-widget-custombutton="false" role="widget" style="position: relative; opacity: 1; left: 0px; top: 0px;">
    <header role="heading">
        <span class="widget-icon"> <i class="fa fa-edit"></i> </span>
        <h2><%=trs.t("მოთხოვნის რეგისტრაცია")%> </h2>				
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
                                <div class="input-group">
                                    <label class="input"> 
                                        <input name="contragent" list="contragent" type="text" value="" placeholder="<%=trs.t("დამკვეთი")%>">
                                        <datalist id="contragent">
                                            <option value="209472505 ააიპ 107-ე საბავშვო ბაგა ბაღი"></option>
                                            <option value="204861042 ააიპ 192 - რე საბავშო ბაგა - ბაღი"></option>
                                            <option value="211361776 ააიპ # 197 - ე საბავშო ბაგა - ბაღი"></option>
                                            <option value="460010011 ააიპ 198-ე საბავშვო ბაგა ბაღი"></option>
                                            <option value="211351883 ააიპ 198 საბავშო ბაგა _ბაღი"></option>
                                        </datalist>
                                    </label>
                                    <div class="input-group-btn">
                                        <button class="btn btn-success" data-original-title="<%=trs.t("დამკვეთის დამატება")%>" type="button" onclick="addContragent()">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-danger clearbtn" data-original-title="<%=trs.t("გასუთავება")%>" type="button" onclick="clearAll()">
                                            <i class="fa fa-times"></i>
                                        </button>
                                    </div>
                                </div>
                                <input name="contragentid" id='contragentid' type="hidden" value="0">
                            </section>
                            <section class="col col-md-12" id="contract-field" style="display: none;">
                                <div class="input-group">
                                    <label class="select">
                                        <select id="contract">
                                            <option value="0"><%=trs.t("ხელშეკრულების N")%></option>
                                            <option value="1">21616915</option>
                                            <option value="2">21191959</option>
                                            <option value="3">55899149</option>
                                            <option value="4">51494998</option>
                                            <option value="5">89212651</option>
                                            <option value="6">65195149</option>
                                            <option value="7">21614515</option>
                                        </select><i></i> 
                                        <input name="contractid" id='contractid' type="hidden" value="0">
                                    </label>
                                    <div class="input-group-btn">
                                        <button class="btn btn-success" type="button" data-original-title="<%=trs.t("ხელშეკრულების დამატება")%>" onclick="addContract()">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-warning" data-original-title="<%=trs.t("ხელშეკრულების რედაქტირება")%>" type="button" onclick="addContract()">
                                            <i class="fa fa-pencil"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-danger clearbtn" data-original-title="<%=trs.t("გასუთავება")%>" type="button">
                                            <i class="fa fa-times"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-primary" data-original-title="<%=trs.t("ხელშეკრულების ბეჭდვა")%>" type="button" onclick="printContract()">
                                            <i class="fa fa-print"></i>
                                        </button>
                                    </div>
                                </div>
                            </section>
                            <section class="col col-md-12" id="sample-field" style="display: none;">
                                <div class="input-group">
                                    <label class="select">
                                        <select id="sample">
                                            <option value="0"><%=trs.t("ნიმუში")%></option>
                                            <%
                                                for (int i = 0; i < sampletypes.length; i++) {
                                            %>
                                            <option value="<%=sampletypes[i].getSampletypeid()%>"><%=sampletypes[i].getName()%></option>
                                            <%
                                                }
                                            %>
                                        </select><i></i>
                                    </label>
                                    <div class="input-group-btn">
                                        <button class="btn btn-success" type="button" onclick="addSample()" data-original-title="<%=trs.t("ნიმუშის დამატება")%>">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-primary" type="button" data-original-title="<%=trs.t("ნიმუშის ბეჭდვა")%>">
                                            <i class="fa fa-print"></i>
                                        </button>
                                    </div>
                                </div>
                            </section>
                            <section class="col col-md-12" id="appeal-field" style="display: none;">
                                <div class="input-group">
                                    <label class="select">
                                        <select id="appeal">
                                            <option value="0"><%=trs.t("მიმართვა")%></option>
                                            <option value="1">268</option>
                                            <option value="2">359</option>
                                            <option value="3">425</option>
                                            <option value="4">487</option>
                                            <option value="5">536</option>
                                        </select><i></i> 
                                        <input name="appealid" id='appealid' type="hidden" value="0">
                                    </label>
                                    <div class="input-group-btn">
                                        <button class="btn btn-success" type="button" data-original-title="<%=trs.t("მიმართვის დამატება")%>" onclick="addAppeal()">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-warning" type="button" data-original-title="<%=trs.t("მიმართვის რედაქტირება")%>" onclick="addAppeal()">
                                            <i class="fa fa-pencil"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-danger clearbtn" data-original-title="<%=trs.t("გასუთავება")%>" type="button">
                                            <i class="fa fa-times"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-primary" type="button" data-original-title="<%=trs.t("მიმართვის ბეჭდვა")%>" onclick="printAct()">
                                            <i class="fa fa-print"></i>
                                        </button>
                                    </div>
                                </div>
                            </section>
                            <section class="col col-md-12" id="act-field" style="display: none;">
                                <div class="input-group">
                                    <label class="select">
                                        <select id="act">
                                            <option value="0"><%=trs.t("აქტის N")%></option>
                                            <option value="1">268</option>
                                            <option value="2">359</option>
                                            <option value="3">425</option>
                                            <option value="4">487</option>
                                            <option value="5">536</option>
                                        </select><i></i> 
                                        <input name="actid" id='actid' type="hidden" value="0">
                                    </label>
                                    <div class="input-group-btn">
                                        <button class="btn btn-success" type="button" data-original-title="<%=trs.t("აქტის დამატება")%>" onclick="addAct()">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-warning" type="button" data-original-title="<%=trs.t("აქტის რედაქტირება")%>" onclick="addAct()">
                                            <i class="fa fa-pencil"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-danger clearbtn" data-original-title="<%=trs.t("გასუთავება")%>" type="button">
                                            <i class="fa fa-times"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-primary" type="button" data-original-title="<%=trs.t("აქტის ბეჭდვა")%>" onclick="printAct()">
                                            <i class="fa fa-print"></i>
                                        </button>
                                    </div>
                                </div>
                            </section>
                            <section class="col col-md-12" id="analysis-field" style="display: none;">
                                <div class="input-group">
                                    <label class="input"> 
                                        <input name="analysis" list='analysis' type="text" value="" placeholder="<%=trs.t("ანალიზი")%>">
                                        <datalist id="analysis">
                                            <option value="ფრინველის გრიპი - ანტისხეული"></option>
                                            <option value="ნიუკასლი - ანტისხეული "></option>
                                            <option value="ქუ ცხელება - ანტისხეული"></option>
                                        </datalist>
                                    </label>
                                    <div class="input-group-btn">
                                        <button class="btn btn-warning" type="button" data-original-title="<%=trs.t("ანალიზების რედაქტირება")%>" onclick="editAnalysis()">
                                            <i class="fa fa-pencil"></i>
                                        </button>
                                    </div>
                                </div>
                                <input name="contragentid" id='contragentid' type="hidden" value="0">
                            </section>
                            <section class="col col-md-12">
                                <div class="well well-lg" style="padding: 10px;">
                                    <b><%=trs.t("ნიმუშები:")%><br></b>
                                    <%=trs.t("დაზიანებული და ნეკროზული ქსოვილი")%>; <%=trs.t("ნაცხი")%><br>
                                    <b><%=trs.t("ანალიზები:")%><br></b>
                                    <%=trs.t("ნიუკასლი - ანტისხეული")%><br>
                                    <span class="isleft"><%=trs.t("დარჩენილია 570 ლარი")%></span>
                                </div>
                            </section>
                            <section class="col col-md-12" id="end-field" style="display: none;">
                                <button class="btn btn-success btn-full" onclick="showmsg()"><%=trs.t("დასრულება")%></button>
                            </section>
                        </div>
                        <div class="col col-8">
                            <div class="bordered-box" id="contragent-box" style="display: none;">
                                <h2><%=trs.t("ახალი დამკვეთის დამატება")%></h2>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                        <input class="req" id="org-name" placeholder="<%=trs.t("სახელი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="select">
                                        <select class="req">
                                            <option value="0"><%=trs.t("ორგანიზაციის ტიპი")%></option>
                                            <option value="1">type</option>
                                        </select><i></i>
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-id-card"></i>
                                        <input class="req" id="org-code" placeholder="<%=trs.t("საიდენტიფიკაციო კოდი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-map-marker"></i>
                                        <input class="req" placeholder="<%=trs.t("მისამართი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-phone"></i>
                                        <input class="req" placeholder="<%=trs.t("ტელეფონი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-envelope"></i>
                                        <input placeholder="<%=trs.t("ელ-ფოსტა")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-link"></i>
                                        <input placeholder="<%=trs.t("ვებ-გვერდი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-user"></i>
                                        <input placeholder="<%=trs.t("საკონტაქტო პირი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-credit-card"></i>
                                        <input placeholder="<%=trs.t("საბანკო ანგარიში")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-comment"></i>
                                        <input placeholder="<%=trs.t("შენიშვნა")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-12 text-right">
                                    <a class="btn btn-default closeall"><i class="fa fa-times"></i> <%=trs.t("დახურვა")%></a>
                                    <a class="btn btn-success" onclick="showContract()"><i class="fa fa-plus"></i> <%=trs.t("დამატება")%></a>
                                </section>
                            </div>
                            <div class="bordered-box" id="contract-box" style="display: none;">
                                <h2><%=trs.t("ახალი ხელშეკრულების დამატება")%></h2>
                                <section class="col col-md-4">
                                    <label class="select">
                                        <select class="req" id="contract-type">
                                            <option value="0"><%=trs.t("ხელშეკრულების ტიპი")%></option>
                                            <option value="1"><%=trs.t("ერთჯერადი")%></option>
                                            <option value="2"><%=trs.t("მრავალჯერადი")%></option>
                                        </select><i></i>
                                    </label>
                                </section>
                                <section class="col col-md-4 contr2" style="display: none;">
                                    <label class="input"> <i class="icon-append fa fa-file-o"></i>
                                        <input class="req" placeholder="<%=trs.t("ხელშეკრულების N")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                        <input class="datepicker req" placeholder="<%=trs.t("თარიღი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4 contr2" style="display: none;">
                                    <label class="input"> <i class="icon-append fa fa-money"></i>
                                        <input placeholder="<%=trs.t("ფასი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                                        <input class="datepicker req" placeholder="<%=trs.t("დასრულების ვადა")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4 contr2" style="display: none;">
                                    <label class="btn btn-primary change-pic contract-file">
                                        <span id="filename"><%=trs.t("ხელშეკრულების ატვირთვა")%></span>
                                        <input type="file" id="upload-contract"/>
                                    </label>
                                </section>
                                <section class="col col-md-12 contr3" style="display: none;">
                                    <object data="img/imagetopdf.pdf" type="application/pdf" style="width: 200px; height: 200px;"><%=trs.t("თქვენ ბრაუზერს არ შეუძლია PDF-ის გახსნა")%></object>
                                </section>
                                <div class="smart-form custcheck">
                                    <label class="checkbox contr1" style="display: none;">
                                        <input class="checkshow" name="checkbox" type="checkbox">
                                        <i></i><%=trs.t("მფლობელი")%></label>
                                </div>
                                <section class="col col-md-4 contr4" style="display: none;">
                                    <label class="input"> <i class="icon-append fa fa-user"></i>
                                        <input placeholder="<%=trs.t("სახელი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4 contr4" style="display: none;">
                                    <label class="input"> <i class="icon-append fa fa-user"></i>
                                        <input placeholder="<%=trs.t("გვარი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4 contr4" style="display: none;">
                                    <label class="input"> <i class="icon-append fa fa-id-card"></i>
                                        <input placeholder="<%=trs.t("პირადი N")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-12 contr4" style="display: none;">
                                    <label class="textarea"> <i class="icon-append fa fa-id-card"></i>
                                        <textarea placeholder="<%=trs.t("მისამართი")%>"></textarea>
                                    </label>
                                </section>
                                <div class="limits contr2" style="display: none;">
                                    <div class="limit-item">
                                        <section class="col col-md-4">
                                            <label class="select">
                                                <select>
                                                    <option value="0"><%=trs.t("- კვლევა -")%></option>
                                                    <option value="1"><%=trs.t("კვლევა1")%></option>
                                                    <option value="2"><%=trs.t("კვლევა2")%></option>
                                                </select><i></i>
                                            </label>
                                        </section>
                                        <section class="col col-md-3">
                                            <label class="input"> <i class="icon-append fa fa-money"></i>
                                                <input placeholder="<%=trs.t("მაქს. ფასი")%>" type="text">
                                            </label>
                                        </section>
                                        <section class="col col-md-3">
                                            <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                                                <input placeholder="<%=trs.t("მაქს. რაოდენობა")%>" type="text">
                                            </label>
                                        </section>
                                        <section class="col col-md-2">
                                            <button class="btn btn-success addnew"><i class="fa fa-plus"></i></button>
                                        </section>
                                    </div>
                                </div>
                                <section class="col col-md-12 text-right">
                                    <button class="btn btn-default closeall"><i class="fa fa-times"></i> <%=trs.t("დახურვა")%></button>
                                    <button class="btn btn-success" onclick="showAppealAct()"><i class="fa fa-plus"></i> <%=trs.t("დამატება")%></button>
                                </section>
                            </div>
                            <div class="bordered-box" id="sample-box" style="display: none;">
                                <section class="col col-md-12">
                                    <a class="btn btn-default closeall" style="margin-top: 10px;"><i class="fa fa-times"></i> <%=trs.t("დახურვა")%></a>
                                </section>
                                <section class="col col-md-12">
                                    <div class="table-size2">
                                        <table id="sampletable"></table>
                                        <div id="pagersampletable"></div>
                                    </div>
                                </section>
                            </div>
                            <div class="bordered-box" id="appeal-box" style="display: none;">
                                <h2><%=trs.t("ახალი მიმართვის დამატება")%></h2>
                                <section class="col col-md-3">
                                    <label class="input"> <i class="icon-append fa fa-file-o"></i>
                                        <input class="req" placeholder="<%=trs.t("მიმართვის N")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-3">
                                    <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                        <input class="req" placeholder="<%=trs.t("თარიღი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-3">
                                    <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                                        <input placeholder="<%=trs.t("ნიმუშების რაოდენობა")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-3">
                                    <label class="select">
                                        <select name="region" id='region'>
                                            <option value="0" selected=""><%=trs.t("- რეგიონი -")%></option>
                                        </select> <i></i> 
                                    </label>
                                </section>
                                <section class="col col-md-3">
                                    <label class="btn btn-primary change-pic contract-file">
                                        <span id="filename"><%=trs.t("მიმართვის ატვირთვა")%></span>
                                        <input type="file" id="upload-contract"/>
                                    </label>
                                </section>
                                <section class="col col-md-12 text-right">
                                    <a class="btn btn-default closeall"><i class="fa fa-times"></i> <%=trs.t("დახურვა")%></a>
                                    <a class="btn btn-success" onclick="showAnalysis()"><i class="fa fa-plus"></i> <%=trs.t("დამატება")%></a>
                                </section>
                            </div>
                            <div class="bordered-box" id="act-box" style="display: none;">
                                <h2><%=trs.t("ახალი აქტის დამატება")%></h2>
                                <section class="col col-md-3">
                                    <label class="input"> <i class="icon-append fa fa-file-o"></i>
                                        <input class="req" placeholder="<%=trs.t("აქტის N")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-3">
                                    <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                        <input class="req" placeholder="<%=trs.t("თარიღი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-3">
                                    <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                                        <input placeholder="<%=trs.t("ნიმუშების რაოდენობა")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-3">
                                    <label class="select">
                                        <select name="region2" id='region2'>
                                            <option value="0" selected=""><%=trs.t("- რეგიონი -")%></option>
                                        </select> <i></i> 
                                    </label>
                                </section>
                                <section class="col col-md-3">
                                    <label class="btn btn-primary change-pic contract-file">
                                        <span id="filename"><%=trs.t("აქტის ატვირთვა")%></span>
                                        <input type="file" id="upload-contract"/>
                                    </label>
                                </section>
                                <section class="col col-md-12">
                                    <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                                        <textarea placeholder="<%=trs.t("აქტი")%>" rows="4"><%=actcontent%></textarea>
                                    </label>
                                </section>
                                <section class="col col-md-12 text-right">
                                    <a class="btn btn-default closeall"><i class="fa fa-times"></i> <%=trs.t("დახურვა")%></a>
                                    <a class="btn btn-success" onclick="showAnalysis()"><i class="fa fa-plus"></i> <%=trs.t("დამატება")%></a>
                                </section>
                            </div>
                            <div class="bordered-box" id="print-box1" style="display: none;">
                                <section class="col col-md-12">
                                    <a class="btn btn-default closeall" style="margin-top: 10px;"><i class="fa fa-times"></i> <%=trs.t("დახურვა")%></a>
                                </section>
                                <section class="col col-md-12">
                                    <object data="documents/contracts/contracttemplate.pdf" type="application/pdf" width="100%" style="height: calc(100vh - 320px);"><%=trs.t("თქვენ ბრაუზერს არ შეუძლია PDF-ის გახსნა")%></object>
                                </section>
                            </div>
                            <div class="bordered-box" id="print-box2" style="display: none;">
                                <section class="col col-md-12">
                                    <a class="btn btn-default closeall" style="margin-top: 10px;"><i class="fa fa-times"></i> <%=trs.t("დახურვა")%></a>
                                </section>
                                <section class="col col-md-12">
                                    <object data="documents/acts/acttemplate.pdf" type="application/pdf" width="100%" style="height: calc(100vh - 320px);"><%=trs.t("თქვენ ბრაუზერს არ შეუძლია PDF-ის გახსნა")%></object>
                                </section>
                            </div>
                            <div class="bordered-box" id="grid-box" style="display: none;">
                                <section class="col col-md-12">
                                    <a class="btn btn-default closeall" style="margin-top: 10px;"><i class="fa fa-times"></i> <%=trs.t("დახურვა")%></a>
                                </section>
                                <section class="col col-md-12">
                                    <ul class="nav nav-tabs">
                                        <li class="active">
                                            <a href="#s1" data-toggle="tab"> <%=trs.t("დაზიანებული და ნეკროზული ქსოვილი")%></a>
                                        </li>
                                        <li>
                                            <a href="#s2" data-toggle="tab"> <%=trs.t("ნაცხი")%></a>
                                        </li>
                                    </ul>
                                    <div class="tab-content">
                                        <div class="tab-pane fade in active" id="s1" style="height: calc(100vh - 380px) !important;">
                                            <div class="table-size2">
                                                <table id="gridanalysis"></table>
                                                <div id="pagergridanalysis"></div>
                                            </div>
                                        </div>
                                        <div class="tab-pane fade in" id="s2" style="height: calc(100vh - 380px) !important;">
                                            <div class="table-size2">
                                                <table id="gridanalysis1"></table>
                                                <div id="pagergridanalysis1"></div>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                            </div>
                        </div>
                    </div>
                </fieldset>
                <fieldset style="display: none;">
                    <div class="row">
                        <section class="col col-4">
                            <label class="select">
                                <select name="sampletypeid" id='sampletypeid'>
                                    <option value="0" selected=""><%=trs.t("ნიმუშის ტიპი")%></option>
                                    <%
                                        for (int i = 0; i < sampletypes.length; i++) {
                                    %>
                                    <option value="<%=sampletypes[i].getSampletypeid()%>"><%=sampletypes[i].getName()%></option>
                                    <%
                                        }
                                    %>
                                </select> <i></i> 
                            </label>
                        </section>
                        <section class="col col-3">
                            <label class="input"> <i class="icon-append fa fa-deaf"></i>
                                <input name="samplenumber" id='samplenumber' placeholder="<%=trs.t("ნიმუშების რაოდენობა")%>" type="text">
                            </label>
                        </section>
                        <section class="col col-5">
                            <label class="select">
                                <select name="sampletypeid" id='sampletypeid'>
                                    <option value="0" selected=""><%=trs.t("მოთხოვნილი კვლევები")%></option>
                                    <%
                                        for (int i = 0; i < sampletypes.length; i++) {
                                    %>
                                    <option value="<%=sampletypes[i].getSampletypeid()%>"><%=sampletypes[i].getName()%></option>
                                    <%
                                        }
                                    %>
                                </select> <i></i> 
                            </label>
                        </section>
                    </div>
                </fieldset>
                <footer style='display: none;'>
                    <button type="submit" class="btn btn-primary"><%=trs.t("რეგისტრაცია")%></button>
                </footer>
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
                <div class="smart-form">
                    <section class="col col-sm-12">
                        <label class="checkbox">
                            <input name="checkbox3" type="checkbox">
                            <i></i><%=trs.t("წაღების შესახებ ინფორმაცია არ არის")%></label>
                    </section>
                    <section class="col col-md-6 controler1">
                        <label class="input"> <i class="icon-append fa fa-file-o"></i>
                            <input class="datetime now" placeholder="<%=trs.t("წაღების თარიღი/დრო")%>" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-12 controler1">
                        <label class="textarea"> <i class="icon-append fa fa-info"></i>
                            <textarea placeholder="<%=trs.t("ვინ წაიღო")%>"></textarea>
                        </label>
                    </section>
                    <section class="col col-md-6 controler2" style="display: none;">
                        <label class="input"> <i class="icon-append fa fa-file-o"></i>
                            <input class="datetime" placeholder="<%=trs.t("შეხსენების თარიღი/დრო")%>" type="text">
                        </label>
                    </section>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("დახურვა")%>
                </button>
                <button type="button" class="btn btn-success" data-dismiss="modal">
                    <%=trs.t("დასრულება")%>
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
                <h4 class="modal-title"><%=trs.t("ყურადღება")%></h4>
            </div>
            <div class="modal-body">
                <h2 id="message"><%=trs.t("დარწმუნებული ხართ, რომ გნებავთ ნიმუშის დაწუნება?")%></h2>
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
                <button type="button" class="btn btn-success" data-dismiss="modal">
                    <%=trs.t("დიახ")%>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="chlabModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("აირჩიეთ ლაბორატორია")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
                    <section class="col col-sm-12">
                        <label class="select">
                            <select>
                                <option value="0" selected=""><%=trs.t("- ლაბორატორია -")%></option>
                                <option>ვირუსოლოგიისა და მოლეკულური ბიოლოგიის ლაბორატორია</option>
                            </select> <i></i> 
                        </label>
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
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>
<script>
    pageSetUp();


    function showmsg() {
        $("#msgModal").modal("show");
    }

    function printContract() {
        $("#contragent-box").hide();
        $("#contract-box").hide();
        $("#appeal-box").hide();
        $("#print-box1").show();
        $("#print-box2").hide();
        $("#grid-box").hide();
        $("#sample-box").hide();
        $("#act-box").hide();
    }

    function printAct() {
        $("#contragent-box").hide();
        $("#contract-box").hide();
        $("#appeal-box").hide();
        $("#print-box1").hide();
        $("#print-box2").show();
        $("#grid-box").hide();
        $("#sample-box").hide();
        $("#act-box").hide();
    }

    function addContragent() {
        $("#contragent-box").show();
        $("#contract-box").hide();
        $("#appeal-box").hide();
        $("#print-box1").hide();
        $("#print-box2").hide();
        $("#grid-box").hide();
        $("#sample-box").hide();
        $("#act-box").hide();
    }
    function addContract() {
        $("#contragent-box").hide();
        $("#contract-box").show();
        $("#appeal-box").hide();
        $("#print-box1").hide();
        $("#print-box2").hide();
        $("#grid-box").hide();
        $("#sample-box").hide();
        $("#act-box").hide();
    }
    function addAct() {
        $("#contragent-box").hide();
        $("#contract-box").hide();
        $("#appeal-box").hide();
        $("#act-box").show();
        $("#print-box1").hide();
        $("#print-box2").hide();
        $("#grid-box").hide();
        $("#sample-box").hide();
    }
    function addAppeal() {
        $("#contragent-box").hide();
        $("#contract-box").hide();
        $("#appeal-box").show();
        $("#print-box1").hide();
        $("#print-box2").hide();
        $("#grid-box").hide();
        $("#sample-box").hide();
        $("#act-box").hide();
    }
    function clearAll() {
        $('#contragent').val('');
        $('#contragentid').val('0');
        $("#contragent-box").hide();
        $("#contract-box").hide();
        $("#appeal-box").hide();
        $("#print-box1").hide();
        $("#print-box2").hide();
        $("#grid-box").hide();
        $("#sample-box").hide();
        $("#act-box").hide();
    }
    function addSample() {
        $("#contragent-box").hide();
        $("#contract-box").hide();
        $("#appeal-box").hide();
        $("#print-box1").hide();
        $("#print-box2").hide();
        $("#grid-box").hide();
        $("#sample-box").show();
        $("#act-box").hide();
        var text = $("#sample option:selected").text();
        $("#sample").val("0");
        loadScript("js/plugin/jqgrid/grid.locale-en.min.js", pagefunction);
    }
    $(document).on("click", ".closeall", function () {
        $("#contragent-box").hide();
        $("#contract-box").hide();
        $("#appeal-box").hide();
        $("#print-box1").hide();
        $("#print-box2").hide();
        $("#grid-box").hide();
        $("#sample-box").hide();
        $("#act-box").hide();
    });
    $(document).on("click", ".banitem", function () {
        $("#banModal").modal("show");
    });
    $(document).on("change", "#contract-type", function () {
        if ($(this).val() == "0") {
            $(".contr1").hide();
            $(".contr2").hide();
        } else if ($(this).val() == "1") {
            $(".contr1").show();
            $(".contr2").hide();
        } else {
            $(".contr1").hide();
            $(".contr2").show();
        }
    });
    $(document).on("change", "#upload-contract", function () {
        var filename = $(this).val();
        $('#filename').html('<span> ' + filename + ' <span id="remove-contr" class="fa fa-times"></span></span>');
    });
    $(document).on("click", "#remove-contr", function (e) {
        e.preventDefault();
        $('#filename').html("<%=trs.t("ხელშეკრულების ატვირთვა")%>");
    });
    $(document).on("click", ".clearbtn", function () {
        $(this).parent().parent().find("select").val("0").trigger("change");
    });

//    $("#contragent").autocomplete({
//        autoFocus: true,
//        minLength: 1,
//        my: "right top",
//        at: "right bottom",
//        source: "content/searchcontragent.jsp",
//        select: function (event, ui)
//        {
//            $("#contragentid").val(ui.item.contragentid);
//            if (ui.item.contragentid == 0) {
//                addContragent();
//            } else {
//                $.post("content/getcontractsbycontragent.jsp", {id: ui.item.contragentid}, function (data) {
//                    $("#contract").html(data);
//                }, "html");
//            }
//        }
//    });

    function printSample() {
        $(".contr3").show();
    }

    var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);

        function run_jqgrid_function() {

            var tbldata = [{
                    id: "1",
                    name: "ფრინველის გრიპი - ანტისხეული",
                    laboratory: "ვირუსოლოგიისა და მოლეკულური ბიოლოგიის ლაბორატორია",
                    price: "6.00",
                    end: '<div class="smart-form"><label class="input"><input value="2-3" type="text"></label></div>'
                }, {
                    id: "2",
                    name: "ნიუკასლი - ანტისხეული	",
                    laboratory: "ვირუსოლოგიისა და მოლეკულური ბიოლოგიის ლაბორატორია",
                    price: "4.50",
                    end: '<div class="smart-form"><label class="input"><input value="2-3" type="text"></label></div>'
                }, {
                    id: "3",
                    name: "ქუ ცხელება - ანტისხეული",
                    laboratory: "ვირუსოლოგიისა და მოლეკულური ბიოლოგიის ლაბორატორია",
                    price: "60.00",
                    end: '<div class="smart-form"><label class="input"><input value="2-3" type="text"></label></div>'
                }];

            jQuery("#gridanalysis").jqGrid({
                data: tbldata,
                datatype: "local",
//                treeGridModel: 'adjacency',
//                treeGrid: true,
//                ExpandColumn: 'contact',
                colNames: ['id', '<%=trs.t("დასახელება")%>', '<%=trs.t("ლაბორატორია")%>', '<%=trs.t("ფასი")%>', '<%=trs.t("ვადა")%>', '<%=trs.t("მოქმედება")%>'],
                colModel: [
                    {name: 'id', index: 'id', width: 1, hidden: true, key: true},
                    {name: 'name', index: 'name', hidden: false, editable: true, sortable: false, align: "left", width: 200},
                    {name: 'laboratory', index: 'laboratory', hidden: false, editable: true, sortable: false, align: "left", width: 200},
                    {name: 'price', index: 'price', hidden: false, editable: true, sortable: false, align: "right", width: 50},
                    {name: 'end', index: 'end', hidden: false, editable: true, sortable: false, align: "right", width: 50},
                    {name: 'act', index: 'act', sortable: false, align: "center", width: 100}

                ],
                rowNum: 20,
                height: 100,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagergridanalysis'),
                sortname: 'ord',
                viewrecords: true,
                footerrow: true,
                sortorder: "asc",
                editurl: "content/updgridanalysis.jsp",
                title: "<%=trs.t("ნიმუშები")%>",
                gridComplete: function () {
                    var ids = jQuery("#gridanalysis").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        be = '<button class="btn btn-danger btn-sm" data-original-title="<%=trs.t("წაშლა")%>" style="margin-left: 5px;"><i class="fa fa-trash"></i></button>';
                        ce = '<button class="btn btn-info btn-sm showcode" data-original-title="<%=trs.t("ბეჭდვა")%>" style="margin-left: 5px;"><i class="fa fa-print"></i></button>';
                        de = '<button class="btn btn-warning btn-sm stop" data-original-title="<%=trs.t("შეჩერება")%>" style="margin-left: 5px;"><i class="fa fa-stop"></i></button>';
                        jQuery("#gridanalysis").jqGrid('setRowData', ids[i], {
                            act: ce + be + de
                        });
                    }
                    $("button").tooltip({
                        container: 'body'
                    });
                    var grid = $("#gridanalysis"),
                            sum = grid.jqGrid('getCol', 'price', false, 'sum');
                    grid.jqGrid('footerData', 'set', {name: '<%=trs.t("ჯამი")%>', price: sum});
                }
            }).navGrid('#pagergridanalysis', {edit: false, add: false, del: true, view: false, search: false},
                    {dataheight: 450, width: 800, closeAfterEdit: true, reloadAfterSubmit: true}, //  default settings for edit
                    {dataheight: 450, width: 800, closeAfterAdd: true, reloadAfterSubmit: true}, //  default settings for add
                    {closeAfterDelete: true, reloadAfterSubmit: true}, // delete instead that del:false we need this
                    {multipleSearch: true}, // search options
                    {dataheight: 450, width: 800, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
            );
            jQuery("#gridanalysis").jqGrid('inlineNav', "#pagergridanalysis");


            jQuery("#gridanalysis1").jqGrid({
                data: tbldata,
                datatype: "local",
//                treeGridModel: 'adjacency',
//                treeGrid: true,
//                ExpandColumn: 'contact',
                colNames: ['id', '<%=trs.t("დასახელება")%>', '<%=trs.t("ლაბორატორია")%>', '<%=trs.t("ფასი")%>', '<%=trs.t("ვადა")%>', '<%=trs.t("მოქმედება")%>'],
                colModel: [
                    {name: 'id', index: 'id', width: 1, hidden: true, key: true},
                    {name: 'name', index: 'name', hidden: false, editable: true, sortable: false, align: "left", width: 200},
                    {name: 'laboratory', index: 'laboratory', hidden: false, editable: true, sortable: false, align: "left", width: 200},
                    {name: 'price', index: 'price', hidden: false, editable: true, sortable: false, align: "right", width: 50},
                    {name: 'end', index: 'end', hidden: false, editable: true, sortable: false, align: "right", width: 50},
                    {name: 'act', index: 'act', sortable: false, align: "center", width: 100}

                ],
                rowNum: 20,
                height: 100,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagergridanalysis1'),
                sortname: 'ord',
                viewrecords: true,
                footerrow: true,
                sortorder: "asc",
                editurl: "content/updgridanalysis1.jsp",
                title: "<%=trs.t("ნიმუშები")%>",
                gridComplete: function () {
                    var ids = jQuery("#gridanalysis1").jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        be = '<button class="btn btn-danger btn-sm" data-original-title="<%=trs.t("წაშლა")%>" style="margin-left: 5px;"><i class="fa fa-trash"></i></button>';
                        ce = '<button class="btn btn-info btn-sm showcode" data-original-title="<%=trs.t("ბეჭდვა")%>" style="margin-left: 5px;"><i class="fa fa-print"></i></button>';
                        de = '<button class="btn btn-warning btn-sm stop" data-original-title="<%=trs.t("შეჩერება")%>" style="margin-left: 5px;"><i class="fa fa-stop"></i></button>';
                        jQuery("#gridanalysis1").jqGrid('setRowData', ids[i], {
                            act: ce + be + de
                        });
                    }
                    $("button").tooltip({
                        container: 'body'
                    });
                    var grid = $("#gridanalysis1"),
                            sum = grid.jqGrid('getCol', 'price', false, 'sum');
                    grid.jqGrid('footerData', 'set', {name: '<%=trs.t("ჯამი")%>', price: sum});
                }
            }).navGrid('#pagergridanalysis1', {edit: false, add: false, del: true, view: false, search: false},
                    {dataheight: 450, width: 800, closeAfterEdit: true, reloadAfterSubmit: true}, //  default settings for edit
                    {dataheight: 450, width: 800, closeAfterAdd: true, reloadAfterSubmit: true}, //  default settings for add
                    {closeAfterDelete: true, reloadAfterSubmit: true}, // delete instead that del:false we need this
                    {multipleSearch: true}, // search options
                    {dataheight: 450, width: 800, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
            );
            jQuery("#gridanalysis1").jqGrid('inlineNav', "#pagergridanalysis1");

            var tbldata3 = [{
                    id: "1",
                    sample: "ყუთი",
                    code: '<img src="img/code.png" alt="" height="25">',
                    number: "",
                    animal: "",
                    count: '<div class="input-group"><label class="input"><input type="text" value="1"></label><div class="input-group-btn"><button class="btn btn-success" type="button" data-original-title="<%=trs.t("შენახვა")%>"><i class="fa fa-check"></i></button></div></div>',
                    act: '<button class="btn btn-danger" type="button" data-original-title="<%=trs.t("წაშლა")%>"><i class="fa fa-trash"></i></button>',
                    level: 0, parent: "NULL", isLeaf: false, loaded: true, expanded: true
                }, {
                    id: "2",
                    sample: "ნაყინი",
                    code: '',
                    number: '',
                    animal: "",
                    count: '<div class="input-group"><label class="input"><input type="text" value="1"></label><div class="input-group-btn"><button class="btn btn-success" type="button" data-original-title="<%=trs.t("შენახვა")%>"><i class="fa fa-check"></i></button></div></div>',
                    act: '<button class="btn btn-danger" type="button" data-original-title="<%=trs.t("წაშლა")%>"><i class="fa fa-trash"></i></button>',
                    level: 1, parent: 1, isLeaf: false, loaded: true, expanded: true
                }, {
                    id: "21",
                    sample: "ნაყინი",
                    code: '<img src="img/code.png" alt="" height="25">',
                    number: '<div class="input-group"><label class="input min"><input type="text" value="21"></label></div></div>',
                    animal: '<div class="input-group"><label class="input min"><input type="text" value="0"></label></div>',
                    count: '',
                    act: '<button class="btn btn-danger" type="button" data-original-title="<%=trs.t("წაშლა")%>"><i class="fa fa-trash"></i></button> <button class="btn btn-primary showcode" type="button" data-original-title="<%=trs.t("ბეჭდვა")%>"><i class="fa fa-print"></i></button> <button class="btn btn-warning banitem" data-original-title="<%=trs.t("დაწუნება")%>" type="button"><i class="fa fa-ban"></i></button>',
                    level: 2, parent: 2, isLeaf: true, loaded: true, expanded: true
                }, {
                    id: "22",
                    sample: "ნაყინი",
                    code: '<img src="img/code.png" alt="" height="25">',
                    number: '<div class="input-group"><label class="input min"><input type="text" value="22"></label></div>',
                    animal: '<div class="input-group"><label class="input min"><input type="text" value="0"></label></div>',
                    count: '',
                    act: '<button class="btn btn-danger" type="button" data-original-title="<%=trs.t("წაშლა")%>"><i class="fa fa-trash"></i></button> <button class="btn btn-primary showcode" type="button" data-original-title="<%=trs.t("ბეჭდვა")%>"><i class="fa fa-print"></i></button> <button class="btn btn-warning banitem" data-original-title="<%=trs.t("დაწუნება")%>" type="button"><i class="fa fa-ban"></i></button>',
                    level: 2, parent: 2, isLeaf: true, loaded: true, expanded: true
                }, {
                    id: "3",
                    sample: "ნაცხი",
                    code: '<img src="img/code.png" alt="" height="25">',
                    number: '<div class="input-group"><label class="input min"><input type="text" value="2"></label></div>',
                    animal: '<div class="input-group"><label class="input min"><input type="text" value="0"></label></div>',
                    count: '<div class="input-group"><label class="input"><input type="text" value="1"></label><div class="input-group-btn"><button class="btn btn-success" type="button" data-original-title="<%=trs.t("შენახვა")%>"><i class="fa fa-check"></i></button></div></div>',
                    act: '<button class="btn btn-danger" type="button" data-original-title="<%=trs.t("წაშლა")%>"><i class="fa fa-trash"></i></button> <button class="btn btn-primary showcode" type="button" data-original-title="<%=trs.t("ბეჭდვა")%>"><i class="fa fa-print"></i></button> <button class="btn btn-warning banitem" data-original-title="<%=trs.t("დაწუნება")%>" type="button"><i class="fa fa-ban"></i></button>',
                    level: 1, parent: 1, isLeaf: true, loaded: true, expanded: true
                }, {
                    id: "4",
                    sample: "რძე",
                    code: '<img src="img/code.png" alt="" height="25">',
                    number: '<div class="input-group"><label class="input min"><input type="text" value="3"></label></div>',
                    animal: '<div class="input-group"><label class="input min"><input type="text" value="0"></label></div>',
                    count: '<div class="input-group"><label class="input"><input type="text" value="1"></label><div class="input-group-btn"><button class="btn btn-success" type="button" data-original-title="<%=trs.t("შენახვა")%>"><i class="fa fa-check"></i></button></div></div>',
                    act: '<button class="btn btn-danger" type="button" data-original-title="<%=trs.t("წაშლა")%>"><i class="fa fa-trash"></i></button> <button class="btn btn-primary showcode" type="button" data-original-title="<%=trs.t("ბეჭდვა")%>"><i class="fa fa-print"></i></button> <button class="btn btn-warning banitem" data-original-title="<%=trs.t("დაწუნება")%>" type="button"><i class="fa fa-ban"></i></button>',
                    level: 1, parent: 1, isLeaf: true, loaded: true, expanded: true
                }, {
                    id: "5",
                    sample: "ნაყინი",
                    code: '<img src="img/code.png" alt="" height="25">',
                    number: '<div class="input-group"><label class="input min"><input type="text" value="9"></label></div>',
                    animal: '<div class="input-group"><label class="input min"><input type="text" value="0"></label></div>',
                    count: '<div class="input-group"><label class="input"><input type="text" value="1"></label><div class="input-group-btn"><button class="btn btn-success" type="button" data-original-title="<%=trs.t("შენახვა")%>"><i class="fa fa-check"></i></button></div></div>',
                    act: '<button class="btn btn-danger" type="button" data-original-title="<%=trs.t("წაშლა")%>"><i class="fa fa-trash"></i></button> <button class="btn btn-primary showcode" type="button" data-original-title="<%=trs.t("ბეჭდვა")%>"><i class="fa fa-print"></i></button>',
                    level: 0, parent: "NULL", isLeaf: true, loaded: true, expanded: true
                }, {
                    id: "6",
                    sample: "ნაცხი",
                    code: '<img src="img/code.png" alt="" height="25">',
                    number: '<div class="input-group"><label class="input min"><input type="text" value="10"></label></div>',
                    animal: '<div class="input-group"><label class="input min"><input type="text" value="0"></label></div>',
                    count: '<div class="input-group"><label class="input"><input type="text" value="1"></label><div class="input-group-btn"><button class="btn btn-success" type="button" data-original-title="<%=trs.t("შენახვა")%>"><i class="fa fa-check"></i></button></div></div>',
                    act: '<button class="btn btn-danger" type="button" data-original-title="<%=trs.t("წაშლა")%>"><i class="fa fa-trash"></i></button> <button class="btn btn-primary showcode" type="button" data-original-title="<%=trs.t("ბეჭდვა")%>"><i class="fa fa-print"></i></button>',
                    level: 0, parent: "NULL", isLeaf: true, loaded: true, expanded: true
                }];

            jQuery("#sampletable").jqGrid({
                treeGrid: true,
                treeGridModel: "adjacency",
                ExpandColumn: "sample",
                treedatatype: "local",
                datatype: "jsonstring",
                datastr: tbldata3,
                colNames: ['id', '<%=trs.t("ნიმუში")%>', '<%=trs.t("ბარკოდი")%>', '<%=trs.t("საველე N")%>', '<%=trs.t("ცხოველის N")%>', '<%=trs.t("რაოდენობა")%>', '<%=trs.t("მოქმედება")%>'],
                colModel: [
                    {name: 'id', index: 'id', width: 1, hidden: true, key: true},
                    {name: 'sample', index: 'sample', hidden: false, editable: true, sortable: false, align: "left", width: 200},
                    {name: 'code', index: 'code', hidden: false, editable: true, sortable: false, align: "center", width: 50},
                    {name: 'number', index: 'number', hidden: false, editable: true, sortable: false, align: "center", width: 50},
                    {name: 'animal', index: 'animal', hidden: false, editable: true, sortable: false, align: "center", width: 50},
                    {name: 'count', index: 'count', hidden: false, editable: true, sortable: false, align: "center", width: 50},
                    {name: 'act', index: 'act', hidden: false, editable: true, sortable: false, align: "center", width: 100}

                ],
                rowNum: 20,
                height: 100,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagersampletable'),
                sortname: 'ord',
                viewrecords: true,
                footerrow: true,
                sortorder: "asc",
                editurl: "content/updgridanalysis1.jsp",
                title: "<%=trs.t("ნიმუშები")%>",
                gridComplete: function () {
                    $("button").tooltip({
                        container: 'body'
                    });
                }
            }).navGrid('#pagersampletable', {edit: false, add: false, del: true, view: false, search: false},
                    {dataheight: 450, width: 800, closeAfterEdit: true, reloadAfterSubmit: true}, //  default settings for edit
                    {dataheight: 450, width: 800, closeAfterAdd: true, reloadAfterSubmit: true}, //  default settings for add
                    {closeAfterDelete: true, reloadAfterSubmit: true}, // delete instead that del:false we need this
                    {multipleSearch: true}, // search options
                    {dataheight: 450, width: 800, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
            );
            jQuery("#sampletable").jqGrid('inlineNav', "#pagersampletable");

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
                jQuery("#gridanalysis").jqGrid('setGridWidth', $("#grid-box").width() - 30);
                jQuery("#gridanalysis1").jqGrid('setGridWidth', $("#grid-box").width() - 30);
                jQuery("#sampletable").jqGrid('setGridWidth', $("#sample-box").width() - 30);
            });


        } // end function


    };
//    var availableTags = [
//        "ცოფი",
//        "ცხენის ტრიპანოზომა",
//        "ცხენის ინფექციური ანემია",
//        "წვრილი რქოსანი პირუტყვის  ჭირი - ანტისხეული",
//        "ქოთაო - ანტისხეული"
//    ];
//    $("#analysis").autocomplete({
//        autoFocus: true,
//        minLength: 0,
//        my: "right top",
//        at: "right bottom",
//        minChars: 0,
//        source: availableTags,
//        select: function (event, ui)
//        {
//            $("#grid-box").show();
//            $("#contragent-box").hide();
//            $("#contract-box").hide();
//            $("#appeal-box").hide();
//            $("#print-box1").hide();
//            $("#print-box2").hide();
//            $("#sample-box").hide();
//            $("#act-box").hide();
//            loadScript("js/plugin/jqgrid/grid.locale-en.min.js", pagefunction);
//            $(".jqgrow").removeClass("ui-state-highlight");
//            setTimeout(function () {
//                $("#gridanalysis tbody").append('<tr role="row" id="3" tabindex="0" class="ui-widget-content jqgrow ui-row-ltr ui-state-highlight" aria-selected="true"><td role="gridcell" style="display:none;" title="3" aria-describedby="gridanalysis_id">3</td><td role="gridcell" style="text-align:left;" title="' + ui.item.label + '" aria-describedby="gridanalysis_name">' + ui.item.label + '</td><td role="gridcell" style="text-align:left;" title="ვირუსოლოგიისა და მოლეკულური ბიოლოგიის ლაბორატორია" aria-describedby="gridanalysis_laboratory">ვირუსოლოგიისა და მოლეკულური ბიოლოგიის ლაბორატორია</td><td role="gridcell" style="text-align:right;" title="0.00" aria-describedby="gridanalysis_price">0.00</td><td role="gridcell" style="text-align:center;" title="" aria-describedby="gridanalysis_act"><button class="btn btn-info btn-sm" style="margin-left: 5px;"><i class="fa fa-print"></i></button><button class="btn btn-danger btn-sm" style="margin-left: 5px;"><i class="fa fa-trash"></i></button><button class="btn btn-warning btn-sm stop" style="margin-left: 5px;"><i class="fa fa-ban"></i></button></td></tr>');
//            }, 500);
//        }
//    }).focus(function () {
//        $("#analysis").autocomplete('search', "");
//    });
    function editAnalysis() {
        $("#grid-box").show();
        $("#contragent-box").hide();
        $("#contract-box").hide();
        $("#appeal-box").hide();
        $("#print-box1").hide();
        $("#print-box2").hide();
        $("#sample-box").hide();
        $("#act-box").hide();
        loadScript("js/plugin/jqgrid/grid.locale-en.min.js", pagefunction);
        $('#gridanalysis').trigger('reloadGrid');
        showEnd();
    }
//    $(document).on("click", ".sendall", function () {
//        $("#gridanalysis tbody tr").remove();
//    });
//    $(document).on("click", ".sendone", function () {
//        $(this).parent().parent().remove();
//    });
    $(document).on("click", ".stop", function () {
        $(this).parent().parent().toggleClass("stoped");
    });
    function showContract() {
        var name = $("#org-name").val();
        var code = $("#org-code").val();
        $("#contract-field").show();
        $('input[list$="contragent"]').val(code + " " + name);
    }
    function showAppealAct() {
        if ($("#contract-type").val() == "1") {
            $("#act-field").hide();
            $("#appeal-field").hide();
            $("#sample-field").show();
            $("#analysis-field").show();
            $("#contract").val("1");
            $(".isleft").hide();
        } else if ($("#contract-type").val() == "2") {
            $("#appeal-field").show();
            $("#act-field").show();
            $("#sample-field").show();
            $("#analysis-field").hide();
            $("#contract").val("2");
            $(".isleft").show();
        } else {
            alert("აირჩიეთ ხელშეკრულების ტიპი");
        }
    }
    function showAnalysis() {
        $("#analysis-field").show();
        $("#appeal").val("2");
        $("#act").val("2");
    }
    function showEnd() {
        $("#end-field").show();
    }
    $(document).on("input", 'input[list$="contragent"]', function () {
        $("#contract-field").show();
    });
    $(document).on("change", '#contract', function () {
        if ($(this).val() != "0") {
            $("#appeal-field").show();
            $("#sample-field").show();
            $("#act-field").show();
            $(".isleft").show();
        } else {
            $("#appeal-field").hide();
            $("#act-field").hide();
            $("#sample-field").hide();
            $(".isleft").hide();
        }
    });
    $(document).on("change", '#appeal, #act', function () {
        if ($(this).val() != "0") {
            $("#analysis-field").show();
        } else {
            $("#analysis-field").hide();
        }
    });
    $(document).on("input", 'input[list$="analysis"]', function () {
        $("#grid-box").show();
        $("#contragent-box").hide();
        $("#contract-box").hide();
        $("#appeal-box").hide();
        $("#print-box1").hide();
        $("#print-box2").hide();
        $("#sample-box").hide();
        $("#act-box").hide();
        loadScript("js/plugin/jqgrid/grid.locale-en.min.js", pagefunction);
        $('#gridanalysis').trigger('reloadGrid');
        showEnd();
        $("#chlabModal").modal('show');
    });
    $("button").tooltip({
        container: 'body'
    });
    $(document).on("change", ".checkshow", function () {
        if ($(".checkshow").is(':checked')) {
            $(".contr4").show();
        } else {
            $(".contr4").hide();
        }
    });
    $(document).on("click", ".addnew", function () {
        $(".limits").append('<div class="limit-item"><section class="col col-md-4"><label class="select"><select><option value="0"><%=trs.t("- კვლევა -")%></option><option value="1"><%=trs.t("კვლევა1")%></option><option value="2"><%=trs.t("კვლევა2")%></option></select><i></i></label></section><section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-money"></i><input placeholder="<%=trs.t("მაქს. ფასი")%>" type="text"></label></section><section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-list-ol"></i><input placeholder="<%=trs.t("მაქს. რაოდენობა")%>" type="text"></label></section><section class="col col-md-2"><button class="btn btn-success addnew"><i class="fa fa-plus"></i></button></section></div>');
        $(this).removeClass("addnew").removeClass("btn-success").addClass("btn-danger").addClass("removenew");
        $(this).find(".fa").removeClass("fa-plus").addClass("fa-times");
    });
    $(document).on("click", ".removenew", function () {
        $(this).parent().parent().remove();
    });
    $(".datetime").datetimepicker({
        format: 'DD/MM/YYYY HH:mm'
    });
    $(document).on("change", "input[name='checkbox3']", function () {
        if ($(this).is(":checked")) {
            $(".controler2").show();
            $(".controler1").hide();
        } else {
            $(".controler2").hide();
            $(".controler1").show();
        }
    });
    var currentdate = new Date();
    var datetime = currentdate.getDate() + "/"
            + ("0" + (currentdate.getMonth() + 1)).slice(-2) + "/"
            + currentdate.getFullYear() + " "
            + currentdate.getHours() + ":"
            + currentdate.getMinutes()
    $(".now").val(datetime);
</script>