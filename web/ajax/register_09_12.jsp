<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%    
    String sampletypes = ObjOptions.Sampletypes(user.getCompanyid());
    String actcontent = "საქართველოს სოფლის მეურნეობის სამინისტროს ლაბორატორიის ნიმუშების რეგისტრაციის და სტატისტიკური დამუშავების განყოფილების მთ.სპეციალისტი _______________ ერთის მხრივ და მეორე მხრივ __________________-ის წარმომადგენელი ___________________ ვადგენთ აქტს მასზედ, რომ _______________ ლაბორატორიაში შემოიტანა __________________________________________________________ გამოსაკვლევად.";
%>
<link href="js/plugin/bootstrap-datepicker/css/datepicker3.css"  rel="stylesheet">
<script src="js/plugin/bootstrap-datepicker/bootstrap-datepicker.js"></script>
<script src="js/plugin/bootstrap-datepicker/locales/bootstrap-datepicker.ka.js"></script>
<script src="js/plugin/clockpicker/clockpicker.min.js"></script>

<style>
.nowrap {white-space: nowrap !important;}
.ui-autocomplete {
        width: auto !important;
    }
.select2-container .select2-choice>.select2-chosen {
    white-space: normal !important;
}
.select2-container .select2-choice .select2-arrow {
    width: 27px;
}
.barcode {
        font-size: 10px !important;
}
.labtestcount {
     cursor: pointer; 
     cursor: hand;
     color:blue;
     text-decoration:underline;
     font-weight: bold; 
     
}
.popover.clockpicker-popover{
    z-index: 1050;
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
                                    <label class="select">
                                        <input type="hidden" id="contragent" style="width: 100%"/>
                                    </label>
                                    <div class="input-group-btn">
                                        <button class="btn btn-success btn-sm"  data-original-title="<%=trs.t("კონტრაგენტის დამატება")%>" type="button" onclick="addContragent()">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn" style="display: none;" id="editcontragentbtn">
                                        <button class="btn btn-warning btn-sm"  data-original-title="<%=trs.t("კონტრაგენტის რედაქტირება")%>" type="button" onclick="editContragent()">
                                            <i class="fa fa-pencil"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-danger clearbtn btn-sm"  data-original-title="<%=trs.t("გასუთავება")%>" type="button" onclick="clearContragent()">
                                            <i class="fa fa-times"></i>
                                        </button>
                                    </div>
                                </div>
                            </section>
                            <section class="col col-md-12" id="contract-field" style="display: none;">
                                <div class="input-group">
                                    <label class="select">
                                        <select id="contract"  style="width:100%;"></select>
                                    </label>
                                    <div class="input-group-btn">
                                        <button class="btn btn-success btn-sm" type="button"  data-original-title="<%=trs.t("ხელშეკრულების დამატება")%>" onclick="addContract()">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-warning btn-sm"  data-original-title="<%=trs.t("ხელშეკრულების რედაქტირება")%>" type="button" onclick="editContract()">
                                            <i class="fa fa-pencil"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-danger clearbtn btn-sm"  data-original-title="<%=trs.t("გასუთავება")%>" type="button" onclick="clearContract()">
                                            <i class="fa fa-times"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-primary btn-sm"  data-original-title="<%=trs.t("ხელშეკრულების ბეჭდვა")%>" type="button" onclick="printContract()">
                                            <i class="fa fa-print"></i>
                                        </button>
                                    </div>
                                </div>
                            </section>
                            <section class="col col-md-12" id="appeal-field" style="display: none;">
                                <div class="input-group">
                                    <label class="select">
                                        <select id="appeal" class="select2" style="width:100%;">
                                            <option value="0"><%=trs.t("მიმართვა")%></option>
                                        </select>
                                        <input name="appealid" id='appealid' type="hidden" value="0">
                                    </label>
                                    <div class="input-group-btn">
                                        <button class="btn btn-success btn-sm" type="button" data-original-title="<%=trs.t("მიმართვის დამატება")%>" onclick="addAppeal()">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-warning btn-sm" type="button" data-original-title="<%=trs.t("მიმართვის რედაქტირება")%>" onclick="editAppeal()">
                                            <i class="fa fa-pencil"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-danger clearbtn btn-sm" data-original-title="<%=trs.t("გასუთავება")%>" type="button">
                                            <i class="fa fa-times"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-primary btn-sm" type="button" data-original-title="<%=trs.t("მიმართვის ბეჭდვა")%>" onclick="printAppeal()">
                                            <i class="fa fa-print"></i>
                                        </button>
                                    </div>
                                </div>
                            </section>
                            <section class="col col-md-12" id="act-field" style="display: none;">
                                <div class="input-group">
                                    <label class="select">
                                        <select id="act" class="select2" style="width:100%;">
                                            <option value="0"><%=trs.t("აქტის N")%></option>
                                        </select>
                                        <input name="actid" id='actid' type="hidden" value="0">
                                    </label>
                                    <div class="input-group-btn">
                                        <button class="btn btn-success btn-sm" type="button" data-original-title="<%=trs.t("აქტის დამატება")%>" onclick="addAct()">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-warning btn-sm" type="button" data-original-title="<%=trs.t("აქტის რედაქტირება")%>" onclick="editAct()">
                                            <i class="fa fa-pencil"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-danger clearbtn btn-sm" data-original-title="<%=trs.t("გასუთავება")%>" type="button">
                                            <i class="fa fa-times"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-primary btn-sm" type="button" data-original-title="<%=trs.t("აქტის ბეჭდვა")%>" onclick="printAct()">
                                            <i class="fa fa-print"></i>
                                        </button>
                                    </div>
                                </div>
                            </section>
                            <section class="col col-md-12" id="sample-field" style="display: none;">
                                <div class="input-group">
                                    <label class="select">
                                        <select id="sample"  style="width:100%;"></select>
                                    </label>
                                    <div class="input-group-btn">
                                        <button class="btn btn-default btn-sm" data-original-title="<%=trs.t("ყუთის რეგისტრაციის რეჟიმი")%>" id="boxmode" >
                                            <i class="fa fa-briefcase"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-warning btn-sm" data-original-title="<%=trs.t("ნიმუშის რედაქტირება")%>" type="button" onclick="editSample();return false;">
                                            <i class="fa fa-pencil"></i>
                                        </button>
                                    </div>
                                    <%-- div class="input-group-btn">
                                        <button class="btn btn-primary" type="button" data-original-title="<%=trs.t("ნიმუშის ბეჭდვა")%>">
                                            <i class="fa fa-print"></i>
                                        </button>
                                    </div --%>
                                </div>
                            </section>
                            <section class="col col-md-12" id="analysis-field" style="display: none;">
                                <div class="input-group">
                                    <label class="select">
                                        <select id="analysis" style="width:100%;">
                                        </select>
                                    </label>
                                    <div class="input-group-btn">
                                        <button class="btn btn-warning btn-sm" type="button" data-original-title="<%=trs.t("ანალიზების რედაქტირება")%>" onclick="editAnalysis()">
                                            <i class="fa fa-pencil"></i>
                                        </button>
                                    </div>
                                </div>
                            </section>
                            <section class="col col-md-12" id="report-field" style="display: none;">
                                <div class="well well-lg" style="padding: 10px;">
                                    <b><%=trs.t("ნიმუშები:")%><br></b>
                               <div id="report-sample">
                               </div> 
                                    <b><%=trs.t("ანალიზები:")%><br></b>
                               <div id="report-analysis">
                               </div> 
                                    <span class="isleft" id="leftamount"></span>
                                </div>
                            </section>
                            <section class="col col-md-12" id="submit-field" style="display: none;">
                                <button class="btn btn-success btn-full" onclick="showmsg()"><%=trs.t("გადაცემა")%></button>
                            </section>
                            <section class="col col-md-12" id="end-field" style="display: none;">
                                <button class="btn btn-success btn-full" onclick="showcontract2lab()"><%=trs.t("შენახვა")%></button>
                            </section>
                        </div>
                        <div class="col col-8">
                            <div class="bordered-box rightside editform" id="contragent-box" style="display: none;">
                                <form id="frmcontragent" action="api/setcontragent.jsp">
                                <input name="oper" type="hidden">
                                <input name="contragentid" type="hidden">
                                <h2><%=trs.t("კონტრაგენტი")%></h2>
                                <section class="col col-md-6">
                                    <label class="select">
                                        <select class="select2 req" name="contragenttypeid" id="contragenttypeid" >
                                            <option value=""><%=trs.t("ორგანიზაციის ტიპი")%></option>
                                            <% out.println(ObjOptions.Contragenttype());%>
                                        </select>
                                    </label>
                                </section>
                                <section class="col col-md-6">
                                    <label class="input"> <i class="icon-append fa fa-id-card"></i>
                                        <input class="req" id="org-code" name="idn" placeholder="<%=trs.t("საიდენტიფიკაციო კოდი")%>" type="text">
                                    </label>
                                </section>
                                
                                <section class="col col-md-4">
                                    <label class="checkbox">
                                        <input name="vat" id="vat" type="checkbox" checked="">
                                        <i></i><%=trs.t("დღგ-ს გადამხდელი")%>
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                        <input class="req" id="org-name" name="name" placeholder="<%=trs.t("სახელი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4 contragenttypeid" style="display:none;">
                                    <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                          <input class="req" id="lname" name="lname" placeholder="<%=trs.t("გვარი")%>" type="text">
                                    </label>
                                </section>
                                
                                    
                                
                                <section class="col col-sm-4" id="contragenregion">
                                    <label class="select">
                                        <select name="region" id="regionid"  class="select2"  style="width:100%;"></select> 
                                    </label>
                                </section>
                                <section class="col col-sm-4" id="contragentraion" style="display: none;">
                                    <label class="select">
                                        <select name="raion" id="raionid"  class="select2"  style="width:100%;"></select> 
                                    </label>
                                </section>
                                <section class="col col-sm-4" id="contragentcity" style="display: none;">
                                    <label class="select">
                                        <select name="city" id="cityid" class="select2" style="width:100%;">
                                        </select> 
                                    </label>
                                </section>
                                <section class="col col-md-12" id="contragentaddress" style="display: none;">
                                    <label class="textarea"> 
                                        <i class="icon-append fa fa-id-card"></i><textarea name="address" id="address" placeholder="<%=trs.t("მისამართი")%>"></textarea>
                                    </label>
                                </section>
                                    
                                    
                                <section class="col col-md-12"></section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-phone"></i>
                                        <input name="phone" id="phone" placeholder="<%=trs.t("ტელეფონი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-envelope"></i>
                                        <input name="email" id="email" placeholder="<%=trs.t("ელ-ფოსტა")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-link"></i>
                                        <input name="url" id="url" placeholder="<%=trs.t("ვებ-გვერდი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-user"></i>
                                        <input name="contact" id="contact" placeholder="<%=trs.t("საკონტაქტო პირი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-credit-card"></i>
                                        <input name="bankdata" id="bankdata" placeholder="<%=trs.t("საბანკო ანგარიში")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-comment"></i>
                                        <input name="note" id="note" placeholder="<%=trs.t("შენიშვნა")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-12 text-right">
                                    <a class="btn btn-default closeall"><i class="fa fa-times"></i> <%=trs.t("დახურვა")%></a>
                                    <a class="btn btn-success" onclick="submitContragent()"><i class="fa fa-save"></i> <%=trs.t("შენახვა")%></a>
                                </section>
                                </form>
                            </div>
                            <div class="bordered-box rightside editform" id="contract-box" style="display: none;">
                                <form id="frmcontract" action="api/setcontract.jsp" enctype="multipart/form-data" accept-charset="UTF-8">
                                <input name="contragentid" type="hidden">
                                <input name="contractid" type="hidden">
                                <h2 id="frmcontracttitle">
                                    <%=trs.t("ახალი ხელშეკრულების დამატება")%>
                                </h2>
                                <section class="col col-md-4">
                                    <label class="select">
                                        <select class="req" id="contract-type" name="contracttype">
                                            <option value="0"><%=trs.t("ხელშეკრულების ტიპი")%></option>
                                            <option value="1"><%=trs.t("ერთჯერადი")%></option>
                                            <option value="2"><%=trs.t("მრავალჯერადი")%></option>
                                        </select><i></i>
                                    </label>
                                </section>
                                <section class="col col-md-4" >
                                    <label class="input"> <i class="icon-append fa fa-file-o"></i>
                                        <input class="req" name="num" placeholder="<%=trs.t("ხელშეკრულების N")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> 
                                        <div class="input-group">
                                        <input class="form-control hasDatepicker req" name="startdate" id="cotract_startdate" placeholder="<%=trs.t("თარიღი")%>" type="text" data-autoclose="true">
                                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                        </div>
                                    </label>
                                </section>
                                <section class="col col-md-2">
                                    <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                                        <div class="input-group">
                                        <input class="form-control hasDatepicker req" name="enddate" id="cotract_enddate" placeholder="<%=trs.t("დასრულების ვადა")%>" type="text" data-autoclose="true">
                                        <span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
                                        </div>
                                    </label>
                                </section>
                                <section class="col col-md-2 contr1">
                                    <label class="input"> <i class="icon-append fa fa-lock" style="cursor: pointer;" onclick="calcTotalPrice();"></i>
                                        <input name="contractstamp" placeholder="<%=trs.t("ლუქის ნომერი")%>">
                                    </label>
                                </section>
                                <section class="col col-md-2 contr1">
                                    <label class="checkbox">
                                    <input name="transfer" type="checkbox">
                                    <i></i><%=trs.t("გადარიცხვა")%>
                                    </label>
                                </section>
                                <section class="col col-md-2 contr1">
                                    <a class="btn btn-primary" onclick='$("#billModal").modal("show");'><%=trs.t("ქვითარი")%></a>
                                </section>
                                <section class="col col-md-2 contr1">
                                    <a class="btn btn-primary" onclick='$("#docsModal").modal("show");'><%=trs.t("დოკუმენტი")%></a>
                                </section>
                                        
                                        
                                        
                                <section class="col col-md-4 contr2" style="display: none;">
                                    <label class="input"> <i class="icon-append fa fa-money" style="cursor: pointer;" onclick="calcTotalPrice();"></i>
                                        <input name="contractprice" placeholder="<%=trs.t("ფასი")%>">
                                    </label>
                                </section>
                                <section class="col col-md-4 contr2" style="display: none;">
                                    <label class="btn btn-primary change-pic contract-file">
                                        <span id="filename-contract"><%=trs.t("ხელშეკრულების ატვირთვა")%></span>
                                        <input name="docfile" type="file" id="upload-contract"/>
                                    </label>
                                </section>
                                <section class="col col-md-12 contr2" style="display: none;">
                                    <label class="textarea"> 
                                        <i class="icon-append fa fa-id-card"></i><textarea name="info" placeholder="<%=trs.t("კომენტარი")%>"></textarea>
                                    </label>
                                </section>
                                    
                                <div class="smart-form custcheck">
                                    <label class="checkbox contr1" style="display: none;">
                                        <input name="owner" class="checkshow" name="checkbox" type="checkbox">
                                        <i></i><%=trs.t("მფლობელი")%></label>
                                </div>
                                <section class="col col-md-4 contr4" style="display: none;">
                                    <label class="input"> <i class="icon-append fa fa-user"></i>
                                        <input name="fname" placeholder="<%=trs.t("სახელი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4 contr4" style="display: none;">
                                    <label class="input"> <i class="icon-append fa fa-user"></i>
                                        <input name="lname" placeholder="<%=trs.t("გვარი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4 contr4" style="display: none;">
                                    <label class="input"> <i class="icon-append fa fa-id-card"></i>
                                        <input name="idn" placeholder="<%=trs.t("პირადი N")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-12 contr4" style="display: none;">
                                    <label class="textarea"> <i class="icon-append fa fa-id-card"></i>
                                        <textarea name="address" placeholder="<%=trs.t("მისამართი")%>"></textarea>
                                    </label>
                                </section>
                                <div class="limits contr2" style="display: none;">
                                    <div class="limit-item"></div>
                                </div>
                                <section class="col col-md-12 text-right">
                                    <button class="btn btn-default closeall" onclick="closeContract(); return false;"><i class="fa fa-times"></i> <%=trs.t("დახურვა")%></button>
                                    <button class="btn btn-success" onclick="submitContract(); return false;"><i class="fa fa-save"></i> <%=trs.t("შენახვა")%></button>
                                </section>
                                </form>
                            </div>
                            <div class="bordered-box rightside editform" id="sample-box" style="display: none;">
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
                            <div class="bordered-box rightside editform" id="appeal-box" style="display: none;">
                                <form id="frmappeal" action="api/setappeal.jsp" enctype="multipart/form-data" accept-charset="UTF-8">
                                <input name="oper" type="hidden">
                                <input name="id" type="hidden">
                                <input name="contractid" type="hidden">
                                <h2 id="frmappealtitle" ><%=trs.t("ახალი მიმართვის დამატება")%></h2>
                                <section class="col col-md-3">
                                    <label class="label"> <%=trs.t("მიმართვის N")%></label>
                                    <label class="input"> <i class="icon-append fa fa-file-o"></i>
                                        <input class="req" name="num" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-3">
                                    <label class="label"> <%=trs.t("თარიღი")%></label>
                                    <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                        <div class="input-group">
                                        <input class="form-control hasDatepicker req" name="appealdate" type="text" data-autoclose="true">
                                        <span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
                                        </div>                                
                                    </label>
                                </section>
                                <section class="col col-md-3">
                                    <label class="label"> <%=trs.t("ნიმუშების რაოდენობა")%></label>
                                    <label class="input" > <i class="icon-append fa fa-list-ol"></i>
                                        <input name="samplenum" type="number">
                                    </label>
                                </section>
                                <section class="col col-md-3">
                                    <label class="label"> <%=trs.t("რეგიონი")%></label>
                                    <label class="select">
                                        <select name="region" id='region' class="select2" style="width:100%;">
                                            <option value="0" selected=""></option>
                                            <%=ObjOptions.Region()%>
                                        </select>
                                    </label>
                                </section>
                                <section class="col col-md-3">
                                    <label class="label"> <%=trs.t("ლუქის ნომერი")%></label>
                                    <label class="input" > <i class="icon-append fa fa-lock"></i>
                                        <input name="appealstamp" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-3">
                                    <label class="label"> <%=trs.t("შემომტანი")%></label>
                                    <label class="input" > <i class="icon-append fa fa-user"></i>
                                        <input name="bringer" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-3">
                                    <label class="label"> <br></label>
                                    <label class="btn btn-primary change-pic contract-file">
                                        <span id="filename-appeal"><%=trs.t("მიმართვის ატვირთვა")%></span>
                                        <input name=docfile type="file" id="upload-appeal"/>
                                    </label>
                                </section>
                                <section class="col col-md-12 text-right">
                                    <a class="btn btn-default closeall"><i class="fa fa-times"></i> <%=trs.t("დახურვა")%></a>
                                    <a class="btn btn-success" onclick="submitAppeal(); return false;"><i class="fa fa-save"></i> <%=trs.t("შენახვა")%></a>
                                </section>
                                </form>
                            </div>
                            <div class="bordered-box rightside editform" id="act-box" style="display: none;">
                                <form id="frmact" action="api/setact.jsp" enctype="multipart/form-data" accept-charset="UTF-8">
                                <input name="oper" type="hidden">
                                <input name="id" type="hidden">
                                <input name="contractid" type="hidden">
                                <h2 id="frmacttitle" ><%=trs.t("ახალი აქტის დამატება")%></h2>
                                <section class="col col-md-3">
                                    <label class="label"> <%=trs.t("აქტის N")%></label>
                                    <label class="input"> <i class="icon-append fa fa-file-o"></i>
                                        <input class="req" name="num" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-3">
                                    <label class="label"> <%=trs.t("თარიღი")%></label>
                                    <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                        <div class="input-group">
                                        <input class="form-control hasDatepicker req" name="actdate" type="text" data-autoclose="true">
                                        <span class="input-group-addon"><i class="fa fa-clock-o"></i></span>
                                        </div>                                
                                    </label>
                                </section>
                                <section class="col col-md-2">
                                    <label class="label"> <%=trs.t("ნიმ. რაოდ.")%></label>
                                    <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                                        <input name="samplenum"  type="number">
                                    </label>
                                </section>
                                <section class="col col-md-2">
                                    <label class="label"> <%=trs.t("ლუქის N")%></label>
                                    <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                                        <input name="actstamp">
                                    </label>
                                </section>
                                <section class="col col-md-3">
                                    <label class="label"> <%=trs.t("რეგიონი")%></label>
                                    <label class="select">
                                        <select name="region2" id='region2' class="select2" style="width:100%;">>
                                            <option value="0" selected=""></option>
                                            <%=ObjOptions.Region()%>
                                        </select> 
                                    </label>
                                </section>
                                <section class="col col-md-3">
                                    <label class="label"> <%=trs.t("შემომტანი")%></label>
                                    <label class="input" > <i class="icon-append fa fa-user"></i>
                                        <input name="bringer" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-1">
                                    <a class="btn btn-primary" style="margin-top: 10px;" onclick="changeActContent()"><i class="fa fa-arrow-down"></i> </a>
                                </section>        
                                        
                                        
                                <section class="col col-md-12">
                                    <label class="label"> <%=trs.t("აქტი")%></label>
                                    <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                                        <textarea name="content" rows="8" id="actcontent"><%=actcontent%></textarea>
                                    </label>
                                </section>
                                <section class="col col-md-12 text-right">
                                    <a class="btn btn-default closeall"><i class="fa fa-times"></i> <%=trs.t("დახურვა")%></a>
                                    <a class="btn btn-success" onclick="submitAct(); return false;"><i class="fa fa-save"></i> <%=trs.t("შენახვა")%></a>
                                </section>
                                </form>
                            </div>
                            <div class="bordered-box rightside editform" id="print-box1" style="display: none;">
                                <section class="col col-md-12">
                                    <a class="btn btn-default closeall" style="margin-top: 10px;"><i class="fa fa-times"></i> <%=trs.t("დახურვა")%></a>
                                </section>
                                <section class="col col-md-12">
                                    <object data="documents/contracts/contracttemplate.pdf" type="application/pdf" width="100%" style="height: calc(100vh - 320px);"><%=trs.t("თქვენ ბრაუზერს არ შეუძლია PDF-ის გახსნა")%></object>
                                </section>
                            </div>
                            <div class="bordered-box rightside editform" id="print-box2" style="display: none;">
                                <section class="col col-md-12">
                                    <a class="btn btn-default closeall" style="margin-top: 10px;"><i class="fa fa-times"></i> <%=trs.t("დახურვა")%></a>
                                </section>
                                <section class="col col-md-12">
                                    <object data="documents/acts/acttemplate.pdf" type="application/pdf" width="100%" style="height: calc(100vh - 320px);"><%=trs.t("თქვენ ბრაუზერს არ შეუძლია PDF-ის გახსნა")%></object>
                                </section>
                            </div>
                            <div class="bordered-box rightside editform" id="grid-box" style="display: none;">
                                <section class="col col-md-12">
                                    <a class="btn btn-default closeall" style="margin-top: 10px;"><i class="fa fa-times"></i> <%=trs.t("დახურვა")%></a>
                                    <a class="btn btn-primary pull-right" style="margin-top: 10px;" onclick="printForm();"><i class="fa fa-print"></i> <%=trs.t("შიდა ფორმა")%></a>
                                </section>
                                <section class="col col-md-12">
                                    <ul class="nav nav-tabs" id="analyses-tab"></ul>
                                    <div class="tab-content" id="analyses-tabcontent"></div>
                                </section>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="billModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ქვითრები")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form" id="frmbill">
                                   
                    <input name="oper" value="edit" type="hidden">
                    <input name="contractid" type="hidden">
                    <input name="id" type="hidden">
                    <section class="col col-md-12">
                        <div class="row" id='errorbill' style="display: none;">
                            <div class="col col-md-12">
                                <div class="alert alert-danger fade in">
                                    <strong><%=trs.t("შეცდომა!")%></strong> <span id='errorbilltxt'></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col col-md-6">
                                <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                                    <div class="input-group">
                                    <span class="input-group-addon">ქვითრის N:</span>
                                    <input class="form-control" name="billnum" id="billnum" placeholder="<%=trs.t("ქვითრის ნომერი")%>" type="text" data-autoclose="true">
                                    </div>
                                </label>
                            </div>
                            <div class="col col-md-3">
                                <label class="btn btn-primary change-pic contract-file">
                                    <span id="filename-bill"><%=trs.t("ატვირთვა")%></span>
                                    <input name=docfile type="file" id="upload-bill"/>
                                </label>
                            </div>
                            <div class="col col-md-3">
                                <a class="btn btn-primary" onclick="scanToJpg();"><%=trs.t("სკანირება")%></a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col col-md-12">
                                <ul class="list-group" id='billlist'>
                                    
                                </ul>
                            </div>
                        </div>
                    </section>
                    
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("დახურვა")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="docsModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("დოკუმენტები")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form" id="frmdocs">
                                   
                    <input name="oper" value="edit" type="hidden">
                    <input name="contractid" type="hidden">
                    <input name="id" type="hidden">
                    <section class="col col-md-12">
                        <div class="row" id='errordocs' style="display: none;">
                            <div class="col col-md-12">
                                <div class="alert alert-danger fade in">
                                    <strong><%=trs.t("შეცდომა!")%></strong> <span id='errordocstxt'></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col col-md-6">
                                <label class="input"> 
                                    <div class="input-group">
                                    <span class="input-group-addon">ტიპი:</span>
                                    <select class="form-control select2" name="doctypeid" placeholder="<%=trs.t("დოკუმენტის ტიპი")%>">
        <option value=""></option> 
<%            
        DoctypeBean[]  dtb = DoctypeManager.getInstance().loadAll();
        for(int i=0; i<dtb.length;i++) 
            out.print("<option value="+dtb[i].getDoctypeid()+">"+dtb[i].getName()+"</option>");
%>
        </select>
                                    </div>
                                </label>
                            </div>
                            <div class="col col-md-3">
                                <label class="btn btn-primary change-pic contract-file">
                                    <span id="filename-docs"><%=trs.t("ატვირთვა")%></span>
                                    <input name=docfile type="file" id="upload-docs"/>
                                </label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col col-md-12">
                                <ul class="list-group" id='docslist'>
                                    
                                </ul>
                            </div>
                        </div>
                    </section>
                    
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("დახურვა")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="msgModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog large">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ყურადღება")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form" id="frmclosingbody" >
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("დახურვა")%></button>
                <button type="button" class="btn btn-success" onclick="submitClosing(); return false;"><%=trs.t("გადაცემა")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="sendcontractModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ყურადღება")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form" id="frmclosingbody" >
<form id="frmsendcontract2lab" action="api/updcontractfield.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" value="sendcontract" type="hidden">
<input name="contractid" type="hidden" value="">
<input name="appealid" type="hidden" value="">
<input name="actid" type="hidden" value="">
                    ნიმუშების შენახვა
</form>                  
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("დახურვა")%></button>
                <button type="button" class="btn btn-success" onclick="sendContract2Lab(); return false;"><%=trs.t("შენახვა")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="samplecomment" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("შენიშვნა")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form" id="frmsamplecomment" >
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("დახურვა")%></button>
                <button type="button" class="btn btn-success" onclick="submitClosing(); return false;"><%=trs.t("შენახვა")%></button>
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
<form id="frmbanitem" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden" value="banitem">
<input name="id" type="hidden">
                    <section class="col col-sm-12">
                        <label class="label"><%=trs.t("დაწუნების მიზეზი")%></label>
                        <label class="textarea"> <i class="icon-append fa fa-info"></i>
                            <textarea  name="reason"></textarea>
                        </label>
                    </section>
</form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("არა")%></button>
                <button type="button" class="btn btn-success" onclick="submitBanitem();"><%=trs.t("დიახ")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="chlabModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("აირჩიეთ ლაბორატორია")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form" id="frmchlab">
<form id="frminstitution" action="api/setanalysis.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" value="edit" type="hidden">
<input name="contractid" type="hidden">
<input name="id" type="hidden">
                    <section class="col col-sm-12">
                        <label class="select">
                            <select id="institution" name="institutionid"  style="width:100%;">
                            </select> 
                        </label>
                    </section>
</form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("დახურვა")%></button>
                <button type="button" class="btn btn-success" onclick="submitInstitution(); return false;"><%=trs.t("შენახვა")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="sampleModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ნიმუში")%><span id="h4sampletype"></span></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
<form id="frmsampletype" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" value="add" type="hidden">
<input name="isbox" type="hidden">
<input name="contractid" type="hidden">
<input name="sampleid" type="hidden">
  
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-id-card"></i>
                                        <input name="boxnum" placeholder="<%=trs.t("ყუთის ნომერი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-id-card"></i>
                                        <input name="quantity" placeholder="<%=trs.t("ნიმუშის რაოდენობა")%>" type="text">
                                    </label>
                                </section>
</form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("დახურვა")%></button>
                <button type="button" class="btn btn-success" onclick="addSample(); return false;"><%=trs.t("დამატება")%></button>
            </footer>
        </div>
    </div>
</div>
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>
<script>
    pageSetUp();

var activecontent = "";

function showcontract2lab() {
    $("#sendcontractModal").modal("show");
    activecontent = "sendcontractModal";
    }

function showmsg() {
    $("#msgModal").modal("show");
    $("#frmclosingbody").load("api/load_closing_form.jsp?contractid="+$("#contract").val()+"&actid="+$("#actid").val()+"&appealid="+$("#appealid").val(), function (json) {
        var cd = new Date();
        $("#frmclose .select2").select2();
        $("#frmclose .dtpicker").datepicker({
        format: 'dd/mm/yyyy', 
        startDate: getFmtDate(new Date()),
        autoclose: true, 
        language: 'ka', 
        todayHighlight: true, 
	prevText : '<i class="fa fa-chevron-left"></i>',
	nextText : '<i class="fa fa-chevron-right"></i>'
	});
        $("#frmclose .clockpicker").clockpicker({
            donetext: 'Done',
            twelvehour: false,
            autoclose: true
            }); 
        });
    }

    //Add/Edit....
    function addContragent() {
        clearContragent();
        $(".rightside").hide();
        $("#frmcontragent input[name='oper']").val("add");
        $("#frmcontragent input[name='contragentid']").val("");
        $("#contragent-box").show();
        activecontent = "contragent-box";
    }
    
    function editContragent() {
        loadContragent();
        $(".rightside").hide();
        //$("#frmcontragent input[name='oper']").val("edit");
        //$("#frmcontragent input[name='contragentid']").val("");
        $("#contragent-box").show();
        activecontent = "contragent-box";
    }
    // Resetting...
    function clearContragent() {
        $('#contragent').select2("val","");
        $(".editform").hide();
        $("#contract-field").hide();
        $("#editcontragentbtn").hide();
        clearContragentForm();
        clearContract();
    }
    function clearContragentForm() {
        $('#frmcontragent').find("input[type=text], textarea").val("");
        $('#frmcontragent select[name=region]').select2("val","").change();
    }
    function clearContract() {
        $('#contract').select2("val",'');
        $("#sample-field").hide();
        $("#appeal-field").hide();
        $("#act-field").hide();
        $("#analysis-field").hide();
        $("#report-field").hide();
        $("#end-field").hide();
        $("#submit-field").hide();
        $(".editform").hide();
        $(".rightside").hide();
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
    
    $(document).on("click", ".labtestcount", function () {
        editAnalysis();
        $('#analyses-tab a[href="#s'+$(this).attr("data-itemid")+'"]').trigger('click');
    });
    $(document).on("click", ".banitem", function () {
        $("#frmbanitem input[name=id]").val($(this).attr("data-itemid"));
        $("#frmbanitem textarea[name=reason]").val("");
        $("#banModal").modal("show");
        activecontent = "banModal";
    });
    $(document).on("click", ".delitem", function () {
        ConfirmDelete('api/delobject.jsp',{obj:"objcontractsampleitem",id:$(this).attr("data-itemid")},cbDeleteContractSample);
        //sendRequest("api/delobject.jsp",{obj:"objcontractsampleitem",id:$(this).attr("data-itemid")},cbDeleteContractSample);
    });
    $(document).on("click", ".delsample", function () {
        ConfirmDelete('api/delobject.jsp',{obj:"objcontractsample",id:$(this).attr("data-itemid")},cbDeleteContractSample);
        //sendRequest("api/delobject.jsp",{obj:"objcontractsample",id:$(this).attr("data-itemid")},cbDeleteContractSample);
    });

    $(document).on("click", ".sampletypeinfo", function () {
        $(this).tooltip('destroy');
        var id = $(this).attr("data-itemid");
        $("#samplecomment").modal("show");
        $("#frmsamplecomment").load("api/load_sampleinfo_form.jsp?sampletypeid="+id);
    });
    
    $(document).on("click", ".sampletypeinfoitem", function () {
        $(this).tooltip('destroy');
        var id = $(this).attr("data-itemid");
        $("#samplecomment").modal("show");
        $("#frmsamplecomment").load("api/load_sampleinfo_form.jsp?sampleitemid="+id);
    });
    
    $(document).on("click", ".sampleiteminfo", function () {
        $(this).tooltip('destroy');
        var id = $(this).attr("data-itemid");
        $("#samplecomment").modal("show");
        $("#frmsamplecomment").load("api/load_sampleinfo_form.jsp?sampleitemid="+id);
    });
    $(document).on("click", ".updsample", function () {
        $(this).tooltip('destroy');
        var id = $(this).attr("data-itemid");
        sendRequest("api/setsampletype.jsp",{oper:"updSample",id:id,num1:$("#num1_"+id).val(),num2:$("#num2_"+id).val(),quantity:$("#qnt_"+id).val()},cbUpdSample);
    });
    $(document).on("click", ".samplequantity", function () {
        $(this).tooltip('destroy');
        var id = $(this).attr("data-itemid");
        sendRequest("api/setsampletype.jsp",{oper:"updSampleQuantity",id:id,quantity:$("#quantity_"+id).val()},cbUpdSample);
    });
    $(document).on("click", ".samplenums", function () {
        $(this).tooltip('destroy');
        var id = $(this).attr("data-itemid");
        sendRequest("api/setsampletype.jsp",{oper:"updSampleNums",id:id,num1:$("#num1_"+id).val(),num2:$("#num2_"+id).val()},cbUpdSample);
    });
    $(document).on("click", ".sampleboxnum", function () {
        $(this).tooltip('destroy');
        var id = $(this).attr("data-itemid");
        sendRequest("api/setsampletype.jsp",{oper:"updSampleBoxNum",id:id,num1:$("#boxnum_"+id).val()},cbUpdSample);
    });
    $(document).on("change", ".selspicies", function () {
        $(this).tooltip('destroy');
        var id = $(this).attr("data-itemid");
        sendRequest("api/setsampletype.jsp",{oper:"updSpecies",id:id,spcid:$("#spc_"+id).val(),num1:$("#num1_"+id).val(),num2:$("#num2_"+id).val()},cbUpdSample);
    });
    $(document).on("change", ".selspiciesitem", function () {
        $(this).tooltip('destroy');
        var id = $(this).attr("data-itemid");
        sendRequest("api/setsampletype.jsp",{oper:"updSpeciesItem",id:id,spcid:$("#spc_"+id).val(),num1:$("#num1_"+id).val(),num2:$("#num2_"+id).val()},cbUpdSample);
    });
    $(document).on("click", "#boxmode", function () {
        if ($(this).hasClass("btn-default"))
            $(this).removeClass("btn-default").addClass("btn-success");
        else
            $(this).removeClass("btn-success").addClass("btn-default");
    });
    $(document).on("change", "#contract-type", function () {
        if ($(this).val() == "0") {
            $(".contr1").hide();
            $(".contr2").hide();
            $(".contr4").hide();
        } else if ($(this).val() == "1") {
            $(".contr1").show();
            $(".contr2").hide();
        } else {
            $(".contr1").hide();
            $(".contr4").hide();
            $(".contr2").show();
        }
    });
    $(document).on("change", "#frmcontragent select[name=contragenttypeid]", function () {
        if ($(this).val() == "1") {
            $("#org-code").attr("placeholder","<%=trs.t("პირადი ნომერი")%>");
            $(".contragenttypeid").show();
        } else {
            $("#org-code").attr("placeholder","<%=trs.t("საიდენტიფიკაციო კოდი")%>");
            $(".contragenttypeid").hide();
        }
    });
    
    $(document).on("change", ".contractsample", function () {
      var v = $(this).val();
      var s = this.name.substring(10);
      $.getJSON("api/getobject.jsp?obj=labtest&sample="+v, function (json) {
        opt = json.data;
        var output = [];
        output.push('<option value=""><%=trs.t("კვლევა")%></option>');
        $.each(opt, function(i,v) {output.push('<option value="'+ v.id +'">'+ v.name +'</option>');});
        $("#labtest"+s).html(output.join(''));
        $("#labtest"+s).select2({allowClear: true,placeholder: "<%=trs.t("კვლევა")%>",
            formatNoMatches: function () {return "<%=trs.t("კვლევა არ მოიძებნა")%>";},
            escapeMarkup: function (markup) {return markup;}
            }); 
      });
    });

    $(document).on("change", ".contracttest", function () {
      var v = $(this).val();
      var s = this.name.substring(7);
      $.getJSON("api/getobject.jsp?obj=sampletype&labtest="+v, function (json) {
        opt = json.data;
        var output = [];
        output.push('<option value=""><%=trs.t("ნიმუში")%></option>');
        $.each(opt, function(i,v) {output.push('<option value="'+ v.id +'">'+ v.name +'</option>');});
        $("#sampletype"+s).html(output.join(''));
        $("#sampletype"+s).select2({allowClear: true,placeholder: "<%=trs.t("ნიმუში")%>",
            formatNoMatches: function () {return "<%=trs.t("ნიმუში არ მოიძებნა")%>";},
            escapeMarkup: function (markup) {return markup;}
            }); 
      });
    });
    $(document).on("change", "#upload-contract", function () {if ($(this).val()){$('#filename-contract').html('<span> ' + $(this).val() + ' <span id="remove-contr" class="fa fa-times"></span></span>');}else{$('#filename-contract').html("<%=trs.t("ხელშეკრულების ატვირთვა")%>");}});
    $(document).on("change", "#upload-appeal", function () { if ($(this).val()){$('#filename-appeal').html('<span> ' + $(this).val() + ' <span id="remove-appeal" class="fa fa-times"></span></span>');}else{$('#filename-appeal').html("<%=trs.t("მიმართვის ატვირთვა")%>");}});
    $(document).on("change", "#upload-bill", function () {
        var billnum = $("#billnum").val();
        var input = this;
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            if(billnum == '')   {
                    $("#errorbill").show();
                    $("#errorbilltxt").html('<%=trs.t("მიუთითეთ ქვითრის ნომერი")%>');
                    setTimeout(function(){ $("#errorbill").hide(); $("#errorbilltxt").html(""); }, 5000);
                } else {
                    reader.onload = function (e) {
                        var tm = new Date().valueOf();
                        var s = "<li class='list-group-item justify-content-between' id='bill"+tm+"' style='padding: 10px 15px !important; margin-top: 5px !important;'><a href='";
                        s += e.target.result;
                        s += "' target='_blank'>"+billnum+"</a><span class='pull-right' style='cursor: pointer;'><a class='btn btn-danger btn-xs' onclick='$(\"#bill"+tm+"\").remove();' style='padding: 1px 7px !important;'><i class='fa fa-times'></i> </a></span>";
                        s += "<input type='hidden' name='bill' value='"+billnum+"'/><input type='hidden' name='bill_"+billnum+"' value='"+e.target.result+"'/></li>";
                        $("#billlist").append(s);
                        $("#billnum").val("");
                    };
                    reader.readAsDataURL(input.files[0]);
                }
        }
    });
    $(document).on("change", "#upload-docs", function () {
        var doctype = $("#frmdocs select[name=doctypeid]").val();
        var input = this;
        if (input.files && input.files[0]) {
            if(doctype == '')   {
                $("#errordocs").show();
                $("#errordocstxt").html('<%=trs.t("აირჩიეთ დოკუმენტის ტიპი")%>');
                setTimeout(function(){ $("#errordocs").hide(); $("#errordocstxt").html(""); }, 5000);
            } else {
                var docsnum = $("#upload-docs").val();
                var reader = new FileReader();
                reader.onload = function (e) {
                        var tm = new Date().valueOf();
                        var s = "<li class='list-group-item justify-content-between' id='docs"+tm+"' style='padding: 10px 15px !important; margin-top: 5px !important;'><a href='";
                        s += e.target.result;
                        s += "' target='_blank'>"+docsnum+"</a><span class='pull-right' style='cursor: pointer;'><a class='btn btn-danger btn-xs' onclick='$(\"#docs"+tm+"\").remove();' style='padding: 1px 7px !important;'><i class='fa fa-times'></i> </a></span>";
                        s += "<input type='hidden' name='docs_"+doctype+"' value='"+e.target.result+"'/></li>";
                        $("#docslist").append(s);
                        $("#docsnum").val("");
                    };
                reader.readAsDataURL(input.files[0]);
            }
        }
    });
    $(document).on("click", "#remove-contr", function (e) {e.preventDefault();$('#upload-contract').val("").change();});
    $(document).on("click", "#remove-appeal", function (e) {e.preventDefault();$('#upload-appeal').val("").change();});
    $(document).on("click", "#remove-bill", function (e) {e.preventDefault();$('#upload-bill').val("").change();});
    $(document).on("click", "#remove-docs", function (e) {e.preventDefault();$('#upload-docs').val("").change();});
    $(document).on("click", ".clearbtn", function () {
        $(this).parent().parent().find("select").val("").trigger("change");
    });

    function printSample() {
        $(".contr3").show();
        activecontent = ".contr3";
    }

    $(document).on("shown.bs.tab", 'a[data-toggle="tab"]', function(e) {
        var tb = $(this).attr("data-table");
        $('#'+tb).trigger('reloadGrid');
        $("#"+tb).jqGrid('setGridWidth', $("#grid-box").width() - 30);
    });
    
    var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);


       function run_jqgrid_function() {

        $("#report-field").show();
        activecontent = "report-field";
        
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
    
    
    
    

    function cbSubmitContragent(rs) {
        if (rs.status=='ER')
        {
            alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
        }
        else
        {
            alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
            $("#contragent-box").hide();
            $("#contract-field").show();
            activecontent = "contract-field";
            var cname = $("#org-code").val() + " " + $("#org-name").val();
            if ($("#contragenttypeid").val()==1)
                cname += " "+ $("#frmcontragent input[name=lname]").val();
            $("#contragent").select2('data', {id: rs.data, text: cname, selected: true});
            loadContract("");
        }
    }
    function submitContragent() {
        sendForm("frmcontragent",cbSubmitContragent);
    }
    function closeContract() 
    {
        $("#frmcontract").find("input[type=text], select, textarea").val("");
        $("#contract-box").hide();
    }
    function submitContract() {
        var $fg = $(".limits").find('.limit-item').length-1;
        var sampletype = $("#sampletype"+$fg).val().length;
        var labtest = $("#labtest"+$fg).val().length;
        var maxprice = $("#maxprice"+$fg).val().length;
        var maxnum = $("#maxnum"+$fg).val().length;
        if(sampletype > 0 && maxnum === 0)
            alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ რაოდენობა!")%>','<%=trs.t("დახურვა")%>');
        else if(labtest > 0 && maxnum === 0 && maxprice === 0)
            alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ მაქსიმალური ფასი ან რაოდენობა!")%>','<%=trs.t("დახურვა")%>');
        else {
            if(sampletype === 0 && labtest === 0 && maxprice === 0){
                $("#maxnum"+$fg).val("");
                $("#minday"+$fg).val("");
                $("#maxday"+$fg).val("");
            }
            $("#frmcontract input[name='contragentid']").val($('#contragent').val());
            if ($("#contract-type").val() == "1") {
                sendMPForm("frmcontract",cbSubmitContract);
            } else if ($("#contract-type").val() == "2") {
                sendMPForm("frmcontract",cbSubmitContract);
            } else {
                alertError('<%=trs.t("აირჩიეთ ხელშეკრულების ტიპი")%>','','<%=trs.t("დახურვა")%>');
            }
        }
    }
    function cbSubmitContract(rs) {
        if (rs.status=='ER')
        {
            alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
        }
        else
        {
            alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
            //$("#contact").append($('<option>', {value: rs.data.id, text: rs.data.num, selected: true})).trigger("change");
            loadContract(rs.data.id);
            //loadContractDetails();
        }
    }
    function submitAppeal() {
        $("#frmappeal input[name='contractid']").val($('#contract').val().trim());
        sendMPForm("frmappeal",cbSubmitAppeal);
    }
    function cbSubmitAppeal(rs) {
        if (rs.status=='ER')
        {
            alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
        }
        else
        {
            alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
            $('#appeal option:first').after($('<option />', { "value": rs.data.id, text: rs.data.num, selected: true }));
            $('#appeal').val(rs.data.id);
            $('#appeal').select2().trigger("change");
            $("#analysis-field").show2();
            $(".rightside").hide();
            $("#appeal-box").hide();
        }
    }
    function submitAct() {
        $("#frmact input[name='contractid']").val($('#contract').val().trim());
        sendMPForm("frmact",cbSubmitAct);
    }
    function cbSubmitAct(rs) {
        if (rs.status=='ER')
        {
            alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
        }
        else
        {
            alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
            $("#analysis-field").show2();
//            $("#act").select2('data', {id: rs.data, text: rs.data.num, selected: true});
            $('#act option:first').after($('<option />', { "value": rs.data.id, text: rs.data.num }));
            $("#act").select2("val",rs.data.id).change();
            $("#act-box").hide();
        }
    }
    function showEnd() {
        $("#end-field").show();
        $("#submit-field").show();
    }
    
    
    $('#contragent').select2({
        minimumInputLength: 0,
        allowClear: true,
        placeholder: "<%=trs.t("კონტრაგენტი")%>",
        cache: true,
        ajax: {
            url: "api/getobject.jsp?obj=contragentlist",
            dataType: 'json',
            data: function (term, page) {
                return {
                    q: term
                  };
            },
            results: function (data, page) {
                return {
                    results: data
                };
            }
        },
    formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>";},
    formatInputTooShort: function () {return "<%=trs.t("შეიტანეთ კონტრაგენტის ნომერი ან დასახელება")%>";},
    formatNoMatches: function () {return "<%=trs.t("კონტრაგენტი არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
    });

   
    $(document).on("change", "#sample", function () {
        var v = $("#sample").val().trim();
        if (v=="")
            return;
        else if ($("#boxmode").hasClass("btn-default"))
        {
            sendRequest("api/setsampletype.jsp",{oper:"add",contractid:$("#contract").val(),sampleid:v,appealid: $("#appeal").val(), actid: $("#act").val()},cbAddSample);
        }
        else
        {
        $("#sampleModal").modal('show');
        $("#h4sampletype").html(": "+$("#sample option:selected").text());
        $("#frmsampletype input[name='sampleid']").val(v);
        $("#frmsampletype input[name='quantity']").val("");
        $("#frmsampletype input[name='contractid']").val($("#contract").val());
        }
        $("#sample-box").show();
    });
    
    $(document).on("change", '#contragent', function (e) {
        $("#contract-field").show();
        if($("#contragent").val() > 0)
            $("#editcontragentbtn").show();
        clearContract();
        loadContract("");
    });


    $("#analysis-field").bind("beforeShow", function (){ 
        resetAnalysis();
    });
    $('#analysis').on("select2:selecting", function(e) { 
   // what you would like to happen
    });



    $(document).on("change", "#analysis", function () {
        var v = $("#analysis").val().trim();
        if (v=="")
            return;
        //var ids = "";
        //$('#sampletable td input:checkbox:checked').each(function () { 
        //    if(ids.length > 0)  ids += ",";
        //    ids += $(this).val();
        //});

        boxids = $.map($(".contactsampleboxitem:checkbox:checked"), function(n, i){return n.value;}).join(',');
        itmids = $.map($(".contactsampleitem:checkbox:checked"), function(n, i){return n.value;}).join(',');
        boxids2= $.map($(".contactsampleboxitem:checkbox:checked"), function(n, i){return n.value;}).join(',');
        itmids2= $.map($(".sampleitemreseach:checkbox:checked"), function(n, i){return n.value;}).join(',');
        if (boxids.length+itmids.length+itmids2.length==0)
        {
            $("#analysis").select2("val", "");
            alertError('<%=trs.t("კვლევ(ებ)ის დასანიშნად მონიშნეთ შესაბამისი ნიმუში")%>',"",'<%=trs.t("დახურვა")%>');
        }
        else
        {
            sendRequest("api/setsampletype.jsp",{oper:"researchtest3",ids:itmids,ids2:itmids2,box:boxids,testparent:v,contractid:$("#contract").val()},cbSetResearch);
        }
    });
    
function cbSetResearch(rs)
{
    if (rs.status=='ER')
    {
        if (rs.message=='multiplelab')
        {
            var v = $("#analysis").val().trim();
            if (v=="")
                return;
            var boxids = $.map($(".contactsampleboxitem:checkbox:checked"), function(n, i){return n.value;}).join(',');
            var itmids = $.map($(".contactsampleitem:checkbox:checked"), function(n, i){return n.value;}).join(',');
            $("#chlabModal").modal('show');
            $("#frmchlab").load("api/load_institution_test.jsp?samplelist="+itmids+"&samplebox="+boxids+"&analysis="+v+"&contractid="+$("#contract").val(), function (json) {
                select2institution();
            });
        }
        else
            alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else 
    {
        if ($("#sample-box").css('visibility') != 'hidden') {
            $("#sampletable").trigger("reloadGrid"); 
        }
        if ($("#grid-box").css('visibility') != 'hidden') {
            var tb = $("#analyses-tab .active > a").attr("data-table");
            //var tb = $("#analyses-tab .active").attr("data-table");
            $('#'+tb).trigger('reloadGrid');
            //$("#"+tb).jqGrid('setGridWidth', $("#grid-box").width() - 30);
        }
        resetReport();
        alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
    }
    $("#analysis").select2("val", "");
}
    
    $(document).on("change", '#contract', function () {
        if ($(this).val() != "" && $(this).val() != null) {
            loadContractDetails();
        } else {
            $("#appeal-field").hide();
            $("#act-field").hide();
            $("#sample-field").hide();
            $(".isleft").hide();
        }
    });
    $(document).on("change", '#appeal, #act', function () {
        if ($(this).val() != "0") {
            $("#analysis-field").show2();
        } else {
            $("#analysis-field").hide();
        }
        editSample();
    });
    $("button").tooltip({
        container: 'body',
        trigger : 'hover'        
    });
    $(document).on("change", ".checkshow", function () {
        if ($(".checkshow").is(':checked')) {
            $(".contr4").show();
        } else {
            $(".contr4").hide();
        }
    });
    $(document).on("click", ".addnew", function (e) {
        e.preventDefault();
        var $fg = $(".limits").find('.limit-item').length-1;
        var sampletype = $("#sampletype"+$fg).val().length;
        var labtest = $("#labtest"+$fg).val().length;
        var maxprice = $("#maxprice"+$fg).val().length;
        var maxnum = $("#maxnum"+$fg).val().length;
        if(sampletype === 0 && labtest === 0 && maxprice === 0)
            alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("არაა არჩეული არც ნიმუში არც კვლევა და არც მაქსიმალური ფასი!")%>','<%=trs.t("დახურვა")%>');
        else if(sampletype > 0 && maxnum === 0)
            alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ რაოდენობა!")%>','<%=trs.t("დახურვა")%>');
        else if(labtest > 0 && maxnum === 0 && maxprice === 0)
            alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ მაქსიმალური ფასი ან რაოდენობა!")%>','<%=trs.t("დახურვა")%>');
        else {
            addLabtest("","","","","","");
            $(this).removeClass("addnew").removeClass("btn-success").addClass("btn-danger").addClass("removenew");
            $(this).find(".fa").removeClass("fa-plus").addClass("fa-times");
            //calcTotalPrice();
        }
        calculatetotal();
    });
    $(document).on("click", ".removenew", function () {
        $(this).parent().parent().remove();
        var $fg = $(".limits").find('.limit-item').length;
        for(i=0; i<$fg.length; i++) {
            $($fg[i]).find("input[type='text'], select, textarea").each(function () {
                    this.name = this.name.substr(0,this.name.length-1)+(i+1);
                    this.id = this.id.substr(0,this.id.length-1)+(i+1);
            });
        };
        calculatetotal();
    });
    $(document).on("click", ".removeold", function () {
        $(this).parent().parent().remove();
        calculatetotal();
    });
    
    $(".datetime").datetimepicker({
        format: 'DD/MM/YYYY HH:mm'
    });
    
    $("#contragentraion").hide();
    
    $(document).on("change", "#frmcontragent select[name='region']", function () {
        if($("select[name='region']").val() > 0){
            $("#contragentraion").hide();
            $("#contragentcity").hide();
            $("#contragentaddress").hide();
            loadRaion($("#frmcontragent select[name='region']").val());
        }
    });
    
    $(document).on("change", "#contragentraion select[name='raion']", function () {
        $("#contragentcity").hide();
        $("#contragentaddress").hide();
        loadCity($("#frmcontragent select[name='raion']").val());
    });
    
    $(document).on("change", "#contragentcity select[name='city']", function () {
        $("#contragentaddress").show();
    });
    
    $(document).on("change", ".contractclosing", function () {
        if ($(this).is(":checked")) {
            $(".controler"+$(this).val()+"_2").show();
            $(".controler"+$(this).val()+"_1").hide();
        } else {
            $(".controler"+$(this).val()+"_2").hide();
            $(".controler"+$(this).val()+"_1").show();
        }
    });
    var currentdate = new Date();
    var datetime = currentdate.getDate() + "/"
            + ("0" + (currentdate.getMonth() + 1)).slice(-2) + "/"
            + currentdate.getFullYear() + " "
            + currentdate.getHours() + ":"
            + currentdate.getMinutes();
    $(".now").val(datetime);
    

function LoadOptionList(response) {
    if (request.status === 200) {
      var jsonOptions = JSON.parse(request.responseText);
      jsonOptions.forEach(function(item) {
        var option = document.createElement('option');
        option.value = item;
        dataList.appendChild(option);
      });
      
      // Update the placeholder text.
      input.placeholder = "e.g. datalist";
    } else {
      // An error occured :(
      input.placeholder = "Couldn't load datalist options :(";
    }
};


function loadContragent() {
    var obj = getObject({"contragentid": $('#contragent').val(), "obj":"exactcontragent"});
    $("#contragenttypeid").select2("val",obj.contragenttypeid).change();
    $("#org-code").val(obj.idn);
    if(obj.vat)
        $("#vat").prop("checked",true);
    else
        $("#vat").prop("checked",false);
    if(obj.contragenttypeid == 1)
        $("#org-name").val(obj.fname);
    else
        $("#org-name").val(obj.name);
    $("#lname").val(obj.lname);
    
    $("#regionid").select2("val",obj.regionid).change();
    setTimeout(function(){
        $("#raionid").select2("val",obj.raionid).change();
        setTimeout(function(){
            $("#cityid").select2("val",obj.villageid).change();
        },500);
    },500);
    
    $("#address").val(obj.address);
    $("#phone").val(obj.phone);
    $("#email").val(obj.email);
    $("#url").val(obj.url);
    $("#contact").val(obj.contact);
    $("#bankdata").val(obj.bankdata);
    $("#note").val(obj.note);
    $("#appealstamp").val(obj.stamp);
    $("#frmcontragent input[name='oper']").val("edit");
    $("#frmcontragent input[name='contragentid']").val(obj.contragentid);
    return obj;
}

function setContragentOptions(opts) {
    var datalist = document.getElementById('contragent');
    datalist.textContent = '';
    for (var i = 0; i < opts.length; i++) {
        var option = document.createElement('option');
        option.value = opts[i];
        datalist.appendChild(option);
    }
}

function loadContract(cid) {
  value = $('#contragent').val().trim();
  if (value.length > 0) {
    $.getJSON("api/getobject.jsp?obj=contractlist&contragentid="+value, function (json) {
        $("#contract").select2('destroy').empty();
        $('#contract').append($('<option>').text("").attr('value', ""));
        $.each(json.data, function(i, v) {
            $('#contract').append($('<option>').text(v.num).attr('value', v.id));
            });
    if (cid!=undefined &&cid!=null)
        $('#contract').val(cid);
    select2contract();
    if (cid!=undefined &&cid!=null){
        loadContractDetails();
        }
    });
  }
}

function loadContractDetails() {

    value = $("#contract").val();
    if (value == "" || value == "0" || value == null) 
        return;
   
    res = getObject({"contractid": value, "obj":"contractdetails"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',"სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას",'<%=trs.t("დახურვა")%>');
        $('#appeal').html("");
    }
    else if (res.data.type==1)
    {
        select2appeal();
        select2act(res.data.acts);
        select2sample(res.data.sampletypes);
        resetAnalysis();
        
        $(".editform").hide();
        $("#appeal-field").hide();
        $("#act-field").hide();
        $("#sample-field").show();
        $("#analysis-field").show();
        $("#report-field").show();
        $(".isleft").show();
    }
    else if (res.data.type==2)
    {
        select2appeal(res.data.appeals);
        select2act(res.data.acts);
        select2sample(res.data.sampletypes);
        resetAnalysis();
        
        $(".editform").hide();
        
        $("#act-field").show();
        $("#appeal-field").show();
        $("#sample-field").show();
        $("#analysis-field").show();
        $("#report-field").show();
        $(".isleft").show();
    }
    
    showReport(res.data.contractsample,res.data.contractanalysis,res.data.leftamount);
    showEnd();
}

function showReport(contractsample,contractanalysis,leftamount) {
    var $rp2 = $("#report-analysis");
    $rp2.html("");
    $.each(contractanalysis, function(i,v) {$rp2.append(v.name+'<br>');});
    var $rp2 = $("#report-sample");
    $rp2.html("");
    $.each(contractsample, function(i,v) {$rp2.append(v.name+'<br>');});
    $("#leftamount").html(leftamount);
}

function loadAppeal() {

    value = $("#contract").val();
    res = getObject({"contract": value, "obj":"appeal"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',"სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას",'<%=trs.t("დახურვა")%>');
        $('#appeal').html("");
    }
    else
    {
        var output = [];
        output.push('<option value="0"><%=trs.t("მიმართვა")%></option>');
        $.each(res.data, function(i,v) {output.push('<option value="'+ v.id +'">'+ v.num +'</option>');});
        $('#appeal').html(output.join(''));
    }
}
function loadAct() {

    value = $("#contract").val();
    res = getObject({"contract": value, "obj":"act"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',"სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას",'<%=trs.t("დახურვა")%>');
        $('#act').html("");
    }
    else
    {
        var output = [];
        output.push('<option value="0"><%=trs.t("აქტის N")%></option>');
        $.each(res.data, function(i,v) {output.push('<option value="'+ v.id +'">'+ v.num +'</option>');});
        $('#act').html(output.join(''));
        $("#appeal-field").show();
        $("#sample-field").show();
        $("#act-field").show();
        $(".isleft").show();
    }
}

function addContract() {
    resetContactForm();
    clearContract();
    $("#contract-box").show();
}

function delConctract(){
    var cid = $("#contract").val();
    if (cid=="0" || cid==null || cid=="")
    {
        alertError('<%=trs.t("ხელშეკრულება არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        return;
    } else {
        if(confirm('<%=trs.t("დარწმუნებული ხართ რომ გინდათ ხელშეკრულების წაშლა?")%>')){
            $.post("api/delcontract.jsp",{ oper: "contract", cid: cid },function(data){
                if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                else {
                    resetContactForm();
                    clearContract();
                    loadContract();
                    $("#contract-box").hide();
                }
            },"json");
        }
    }
}

function delAppeal(){
    var aid = $("#appeal").val();
    if (aid=="0" || aid==null || aid=="")
    {
        alertError('<%=trs.t("მიმართვა არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        return;
    } else {
        if(confirm('<%=trs.t("დარწმუნებული ხართ რომ გინდათ მიმართვის წაშლა?")%>')){
            $.post("api/delcontract.jsp",{ oper: "appeal", aid: aid },function(data){
                if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                else {
                    $("#appeal-box").hide();
                    loadAppeal();
                }
            },"json");
        }
    }
}

function delAct(){
    var aid = $("#act").val();
    if (aid=="0" || aid==null || aid=="")
    {
        alertError('<%=trs.t("აქტი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        return;
    } else {
        if(confirm('<%=trs.t("დარწმუნებული ხართ რომ გინდათ აქტის წაშლა?")%>')){
            $.post("api/delcontract.jsp",{ oper: "act", aid: aid },function(data){
                if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                else {
                    $("#act-box").hide();
                    loadAct();
                }
            },"json");
        }
    }
}

function printContract() {
    var cid = $("#contract").val();
    if (cid=="0" || cid==null || cid=="")
    {
        alertError('<%=trs.t("ხელშეკრულება არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        return;
    }
    printReport('contract',cid);
    //    $(".rightside").hide();
    //    $("#print-box1").hide();
}


function editContract() {
    var cid = $("#contract").val();
    if (cid=="0" || cid==null || cid=="")
    {
        alertError('<%=trs.t("ხელშეკრულება არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        return;
    }
    res = getObject({"contract": cid, "obj":"objcontract"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',res.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        resetContactForm();
        $(".rightside").hide();
        $("#contract-type").val(res.data.contracttype).change();
        $("#frmcontract input[name='contactid']").val(cid);
        $.each(res.data, function(n,v) {
            if(n == "bills"){
                $.each(v,function(nm,vl){
                    var billnum = vl.num;
                    var tm = vl.id;
                    var s = "<li class='list-group-item justify-content-between' id='bill"+tm+"' style='padding: 10px 15px !important; margin-top: 5px !important;'><a href='";
                    s += vl.path;
                    s += "' target='_blank'>"+billnum+"</a><span class='pull-right' style='cursor: pointer;'><a class='btn btn-danger btn-xs' onclick='$(\"#bill"+tm+"\").remove();' style='padding: 1px 7px !important;'><i class='fa fa-times'></i> </a></span>";
                    s += "<input type='hidden' name='bill' value='"+billnum+"'/><input type='hidden' name='bill_"+billnum+"' value='ID_"+tm+"_"+vl.path+"'/></li>";
                    $("#billlist").append(s);
                });
            } else if(n == "docs"){
                $.each(v,function(nm,vl){
                    var tm = vl.id;
                    var s = "<li class='list-group-item justify-content-between' id='docs"+tm+"' style='padding: 10px 15px !important; margin-top: 5px !important;'><a href='";
                    s += vl.path;
                    s += "' target='_blank'>"+vl.doctype+"</a><span class='pull-right' style='cursor: pointer;'><a class='btn btn-danger btn-xs' onclick='$(\"#docs"+tm+"\").remove();' style='padding: 1px 7px !important;'><i class='fa fa-times'></i> </a></span>";
                    s += "<input type='hidden' name='docs_"+vl.doctypeid+"' value='ID_"+tm+"_"+vl.path+"'/></li>";
                    $("#docslist").append(s);
                });
            } else $("#frmcontract input[name='"+n+"']").val(v);
        });
        if  (res.data.contracttype==2){
            $.each(res.data.labtest, function(i,t) {insLabtest(t.id, t.sampleid,t.labtestid,t.maxprice,t.maxnum,t.minday,t.maxday,t.comment);});
        } else {
            $("#frmcontract input[name=transfer]").prop("checked",res.data.hasOwnProperty("transfer")&&res.data.transfer);
            if (res.data.hasOwnProperty("owner")) {
                $("#frmcontract input[name=owner]").prop("checked",true).change();
                $.each(res.data.owner, function(n,v) {$("#frmcontract textarea,input[name='"+n+"']").val(v);});
            }
        }
        $("#frmcontract input[name=contracttype]").change();
        $("#contract-box").show();
        $("#frmcontracttitle").html('<%=trs.t("ხელშეკრულების რედაქტირება")%> <a class="btn btn-danger pull-right" onclick="delConctract()"><i class="fa fa-trash"></i> <%=trs.t("ხელშეკრულების წაშლა")%></a>');
    }
}

function editAppeal() {

    value = $("#appeal").val();
    if (value=="0" || value==null || value=="")
    {
        alertError('<%=trs.t("მიმართვა არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        return;
    }
    res = getObject({"appealid": value, "obj":"objappeal"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',"სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას",'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $.each(res.data, function(n,v) {$("#frmappeal input[name='"+n+"']").val(v);});
        $("#region").val(res.data.region);
        $('#region').select2().trigger('change');
        $(".rightside").hide();
        $("#appeal-box").show();
        $("#frmappealtitle").html('<%=trs.t("მიმართვის რედაქტირება")%> <a class="btn btn-danger pull-right" onclick="delAppeal()"><i class="fa fa-trash"></i> <%=trs.t("მიმართვის წაშლა")%></a>');
    }
}
function addAppeal() {
    clearAppealForm();
    $("#frmappealtitle").html('<%=trs.t("ახალი მიმართვის დამატება")%>');
    $(".rightside").hide();
    $("#appeal-box").show();
    $("#frmappeal input[name='oper']").val("add");
}

function clearAppealForm() {
    $('#frmappeal').find("input[type=text], textarea, input[type=number]").val("");
    $('#upload-appeal').val("").change();
    $('#frmappeal select[name=region]').select2("val","").change();
}

function printAppeal() {
    value = $("#appeal").val();
    if (value=="0" || value==null || value=="")
    {
        alertError('<%=trs.t("მიმართვა არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        return;
    }
    printReport('appeal',value);
}

function printAct() {
    value = $("#act").val();
    if (value=="0" || value==null || value=="")
    {
        alertError('<%=trs.t("აქტი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        return;
    }
    printReport('act',value);
}

function editAct() {

    value = $("#act").val();
    if (value=="0" || value==null || value=="")
    {
        alertError('<%=trs.t("აქტი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        return;
    }
    
    res = getObject({"actid": value, "obj":"objact"});
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',"სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას",'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $.each(res.data, function(n,v) {$("#frmact input[name='"+n+"']").val(v);});
        $(".rightside").hide();
        $("#act-box").show();
        $("#frmacttitle").html('<%=trs.t("აქტის რედაქტირება")%> <a class="btn btn-danger pull-right" onclick="delAct()"><i class="fa fa-trash"></i> <%=trs.t("აქტის წაშლა")%></a>');
        $("#frmact input[name='oper']").val("edit");
    }
}
function addAct() {
    clearActForm();
    $("#frmacttitle").html('<%=trs.t("ახალი აქტის დამატება")%>');
    $(".rightside").hide();
    $("#act-box").show();
    $("#frmact input[name='oper']").val("add");
}
function clearActForm() {
    $('#frmact').find("input[type=text], input[type=number]").val("");
    $('#frmact textarea').val("<%=actcontent%>");
    $('#frmact select[name=region]').select2("val","").change();
}

function addSample() {
   sendForm("frmsampletype",cbAddSample);
}
function editSample() {
    $(".editform").hide();
    $("#grid-box").hide();
    $("#sample-box").show();
    jQuery("#sampletable").jqGrid('setGridWidth', $("#sample-box").width() - 30);
    $("#sampletable").jqGrid('setGridParam',{
        url:"content/getcontractsamplelist.jsp?contractid="+$("#contract").val()+"&appealid="+$("#appeal").val()+"&actid="+$("#act").val()
    }).trigger("reloadGrid"); 
}
function cbAddSample(res)
{
    $("#sample").select2("val","");
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',res.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $("#sampleModal").modal("hide");
        $("#grid-box").hide();
        $("#sample-box").show();
        resetAnalysis();
        $("#sampletable").jqGrid('setGridParam',{url:"content/getcontractsamplelist.jsp?contractid="+$("#contract").val()+"&appealid="+$("#appeal").val()+"&actid="+$("#act").val()}).trigger("reloadGrid"); 
    }
}

function editAnalysis() {
    $(".editform").hide();
    $("#sample-box").hide();
    $("#grid-box").show();
    loadScript("js/plugin/jqgrid/grid.locale-en.min.js", pagefunction);
    $('#'+$("ul#analyses-tab li.active a").attr("data-table")).trigger('reloadGrid');
    resetReport();
    showEnd();
}
    

function getFmtDate(date) {
  var year = date.getFullYear();
  var month = (1 + date.getMonth()).toString();
  month = month.length > 1 ? month : '0' + month;
  var day = date.getDate().toString();
  day = day.length > 1 ? day : '0' + day;
  return  day + '/' + month + '/' + year;
}    

 $(".hasDatepicker").each(function(){
    $(this).datepicker({
        format: 'dd/mm/yyyy', 
        //startDate: getFmtDate(new Date()),
        autoclose: true, 
        language: 'ka', 
        todayHighlight: true, 
	prevText : '<i class="fa fa-chevron-left"></i>',
	nextText : '<i class="fa fa-chevron-right"></i>'
	})
	.on('changeDate', function(e) {
            if (this.id=="cotract_startdate") {
                $("#cotract_enddate").datepicker('setStartDate',e.date);
                $("#cotract_enddate").datepicker('update');
            } else if (this.id=="cotract_enddate") {
                $("#cotract_startdate").datepicker('setEndDate',e.date);
                $("#cotract_startdate").datepicker('update');
            }
        });
    });

function resetAnalysis()
{
// $.getJSON("api/getobject.jsp?obj=contractlabtest&contractid="+$("#contract").val(), function (json) {

 $.getJSON("api/getobject.jsp?obj=contractreport&contractid="+$("#contract").val()+"&appealid="+$("#appeal").val()+"&actid="+$("#act").val(), function (json) {
    $("#analysis").select2('destroy').empty();
    $('#analysis').append($('<option>').text("<%=trs.t("ანალიზები")%>").attr('value', ""));
    $.each(json.data.testlist, function(i, v) {$('#analysis').append($('<option>').text(v.text).attr('value', v.id));});
    select2analysis();
    showReport(json.data.contractsample,json.data.contractanalysis, json.data.leftamount);
 });
}
function resetReport()
{
 $.getJSON("api/getobject.jsp?obj=contractreport&contractid="+$("#contract").val()+"&appealid="+$("#appeal").val()+"&actid="+$("#act").val(), function (json) {
    showReport(json.data.contractsample,json.data.contractanalysis, json.data.leftamount);
 });
}


jQuery.fn.extend({

    show2:function( speed, easing, callback ) {
        this.trigger('beforeShow');
        this.show(speed, easing, function(){
            $(this).trigger('afterShow');
            if ($.isFunction(callback)) {
                callback.apply(this);
            }
        });
        if(!speed){
            this.trigger('afterShow');            
        }            
    }


});

$(document).ready(function() {
 $("#labtest").select2({allowClear: true});
 loadScript("js/plugin/jqgrid/grid.locale-en.min.js", pagefunction2);
 select2contract();
 select2sample();
 select2analysis();
 loadRegion();    
});

function select2contract()
{
 $("#contract").select2({allowClear: true,placeholder: "<%=trs.t("ხელშეკრულების N")%>",
    formatNoMatches: function () {return "<%=trs.t("ხელშეკრულება არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
   }); 
}

function select2appeal(opt)
{
  opt = (typeof opt !== 'undefined') ? opt :[];
  var output = [];
  output.push('<option value=""><%=trs.t("მიმართვა")%></option>');
  $.each(opt, function(i,v) {output.push('<option value="'+ v.id +'">'+ v.num +'</option>');});
  $('#appeal').html(output.join(''));
  $("#appeal").select2({allowClear: true,placeholder: "<%=trs.t("მიმართვა")%>",
    formatNoMatches: function () {return "<%=trs.t("მიმართვა არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
   }); 
}
function select2act(opt)
{
  opt = (typeof opt !== 'undefined') ? opt :[];
  var output = [];
  output.push('<option value=""><%=trs.t("აქტის N")%></option>');
  $.each(opt, function(i,v) {output.push('<option value="'+ v.id +'">'+ v.num +'</option>');});
  $('#act').html(output.join(''));
  $("#act").select2({allowClear: true,placeholder: "<%=trs.t("აქტის N")%>",
    formatNoMatches: function () {return "<%=trs.t("აქტის N არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
   }); 
}
function select2sample(opt)
{
  opt = (typeof opt !== 'undefined') ? opt :[];
  var output = [];
  output.push('<option value=""><%=trs.t("ნიმუში")%></option>');
  $.each(opt, function(i,v) {output.push('<option value="'+ v.id +'">'+ v.name +'</option>');});
  $('#sample').html(output.join(''));
  $("#sample").select2({allowClear: true,placeholder: "<%=trs.t("ნიმუში")%>",
    formatNoMatches: function () {return "<%=trs.t("ნიმუში არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
   }); 
}
function select2analysis()
{
 $("#analysis").select2({allowClear: true,placeholder: "<%=trs.t("ანალიზები")%>",
    formatNoMatches: function () {return "<%=trs.t("ანალიზი არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
   }); 
}
function select2institution()
{
 $("#institution").select2({allowClear: true,placeholder: "<%=trs.t("ლაბორატორია")%>",
    formatNoMatches: function () {return "<%=trs.t("ლაბორატორია არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
   }); 
}

function loadRegion()
{
 $.getJSON("api/getobject.jsp?obj=region", function (json) {
    $o = $("#frmcontragent select[name='region']");
    $o.select2('destroy').empty();
    $o.append($('<option>').text("").attr('value', ""));
    $.each(json.data, function(i, v) {$o.append($('<option>').text(v.text).attr('value', v.id));});
    $o.select2({allowClear: true,placeholder: "<%=trs.t("რეგიონი")%>"});
 });
}
    
function loadRaion(punitid)
{
 $.getJSON("api/getobject.jsp?obj=region&punitid="+punitid, function (json) {
    $o = $("#frmcontragent select[name='raion']");
    $o.select2('destroy').empty();
    $o.append($('<option>').text("").attr('value', ""));
    $.each(json.data, function(i, v) {$o.append($('<option>').text(v.text).attr('value', v.id));});
    $o.select2({allowClear: true,placeholder: "<%=trs.t("რაიონი/ქალაქი")%>"});
    $("#contragentraion").show();
 });
}
    
function loadCity(punitid)
{
 $.getJSON("api/getobject.jsp?obj=region&punitid="+punitid, function (json) {
    $o = $("#frmcontragent select[name='city']");
    $o.select2('destroy').empty();
    $o.append($('<option>').text("").attr('value', ""));
    $.each(json.data, function(i, v) {$o.append($('<option>').text(v.text).attr('value', v.id));});
    $o.select2({allowClear: true,placeholder: "<%=trs.t("სოფელი")%>"});
    if (json.data.length>0)
        $("#contragentcity").show();
    else
    {
        $("#contragentcity").hide();
        $("#contragentaddress").show();
    }
 });
}
    
function resetContactForm()
{
    $("#frmcontracttitle").html('<%=trs.t("ახალი ხელშეკრულების დამატება")%>');
    $("#frmcontract input[name='contractid']").val("");
    $("#frmcontract input[name='startdate']").val("");
    $("#frmcontract input[name='enddate']").val("");
    $("#frmcontract input[name='num']").val("");
    $("#frmcontract input[name='contractprice']").val("");
    $("#frmcontract textarea[name='info']").val("");
    $("#frmcontract input[name='fname']").val("");
    $("#frmcontract input[name='lname']").val("");
    $("#frmcontract input[name='idn']").val("");
    $("#frmcontract textarea[name='address']").val("");
    $("#frmcontract input[name='owner']").prop('checked', false).change();
    $("#billlist").html("");
    $("#docslist").html("");
    $("#contract-type").val("0").change();
    $(".contr1").hide();
    $(".contr2").hide();

    $(".limits").find('.limit-item').html("");
    $(".limits").find('.limit-edit').html("");
    addLabtest("","","","","","");
    calcTotalPrice();
}

$(document).on("input", ".testprice", function (e) {
    calcTotalPrice();
    });
    
function calcTotalPrice(){
    var s=0.0;
    $(".testprice").each(function(){ 
        var x = $(this).val();
        if(x > 0)
            s+= parseInt(x);
    });
    $("#frmcontract input[name='contractprice']").val(s);
}

var  optLabtest ='<option value=""><%=trs.t("კვლევა")%></option><%=ObjOptions.Labtest().replace("'","\\'").replace("\n","")%>';
var  optSample  ='<option value=""><%=trs.t("ნიმუში")%></option><%=sampletypes.replace("'","\\'").replace("\n","")%>';
function addLabtest(sampletype, labtest,maxprice,maxnum,minday,maxday)
{
   
    var $fg = $(".limits").find('.limit-item').length;
    $clone = $('<div class="limit-item">\n\
<section class="col col-md-12"><div class="col-xs-12"><hr></div></section>\n\
<section class="col col-md-6"><label class="select"><select class="contractsample" name="sampletype'+$fg+'" id="sampletype'+$fg+'" style="width:100%" >'+optSample+'</select></label></section>\n\
<section class="col col-md-6"><label class="select"><select class="contracttest" name="labtest'+$fg+'" id="labtest'+$fg+'" style="width:100%" >'+optLabtest+'</select></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-money"></i><input value="'+maxprice+'" name="maxprice'+$fg+'" id="maxprice'+$fg+'" class="testprice" placeholder="<%=trs.t("მაქს. ფასი")%>" type="text" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-money txt-color-teal\"></i> <%=trs.t("მაქსიმალური ფასი")%></b></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-list-ol"></i><input value="'+maxnum+'" name="maxnum'+$fg+'" id="maxnum'+$fg+'" placeholder="<%=trs.t("მაქს. რაოდენობა")%>" type="text" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-list-ol txt-color-teal\"></i> <%=trs.t("მაქსიმალური რაოდენობა")%></b></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-list-ol"></i><input value="'+minday+'" name="minday'+$fg+'" id="minday'+$fg+'" placeholder="<%=trs.t("მინ.ვადა")%>" type="text" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-list-ol txt-color-teal\"></i> <%=trs.t("მინიმალური ვადა")%></b></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-list-ol"></i><input value="'+maxday+'" name="maxday'+$fg+'" id="maxday'+$fg+'" placeholder="<%=trs.t("მაქს.ვადა")%>" type="text" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-list-ol txt-color-teal\"></i> <%=trs.t("მაქსიმალური ვადა")%></b></label></section>\n\
<section class="col col-md-11"><label class="textarea"> <i class="icon-append fa fa-id-card"></i><textarea name="comment'+$fg+'" placeholder="<%=trs.t("კომენტარი")%>"></textarea></label></section>\n\
<section class="col col-md-1"><button class="btn btn-success addnew"><i class="fa fa-plus"></i></button></section></div>');
  $(".limits").append($clone);
  $("#labtest"+$fg).val(labtest);
  $("#sampletype"+$fg).val(sampletype);
  $("#labtest"+$fg).select2({allowClear: true,placeholder: "<%=trs.t("კვლევა")%>",formatNoMatches: function () {return "<%=trs.t("კვლევა არ მოიძებნა")%>";},escapeMarkup: function (markup) {return markup;}});
  $("#sampletype"+$fg).select2({allowClear: true,placeholder: "<%=trs.t("ნიმუში")%>",formatNoMatches: function () {return "<%=trs.t("ნიმუში არ მოიძებნა")%>";},escapeMarkup: function (markup) {return markup;}});
}
function insLabtest(id,sampletype, labtest,maxprice,maxnum,minday,maxday,comment)
{
    var $fg = id;
    $clone = $('<div class="limit-edit">\n\
<section class="col col-md-12"><div class="col-xs-12"><hr></div></section>\n\
<section class="col col-md-6"><label class="select"><select name="edsample'+$fg+'" id="edsample'+$fg+'" style="width:100%" >'+optSample+'</select></label></section>\n\
<section class="col col-md-6"><label class="select"><select name="edlab'+$fg+'" id="edlab'+$fg+'" style="width:100%" >'+optLabtest+'</select></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-money"></i><input value="'+maxprice+'" class="testprice" name="edmaxpri'+$fg+'" placeholder="<%=trs.t("მაქს. ფასი")%>" type="text" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-money txt-color-teal\"></i> <%=trs.t("მაქსიმალური ფასი")%></b></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-list-ol"></i><input value="'+maxnum+'" name="edmaxnum'+$fg+'" placeholder="<%=trs.t("მაქს. რაოდენობა")%>" type="text" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-list-ol txt-color-teal\"></i> <%=trs.t("მაქსიმალური რაოდენობა")%></b></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-list-ol"></i><input value="'+minday+'" name="edminday'+$fg+'" placeholder="<%=trs.t("მინ.ვადა")%>" type="text" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-list-ol txt-color-teal\"></i> <%=trs.t("მინიმალური ვადა")%></b></label></section>\n\
<section class="col col-md-3"><label class="input"> <i class="icon-append fa fa-list-ol"></i><input value="'+maxday+'" name="edmaxday'+$fg+'" placeholder="<%=trs.t("მაქს.ვადა")%>" type="text" min="0"><b class=\"tooltip tooltip-top-right\"><i class=\"fa fa-list-ol txt-color-teal\"></i> <%=trs.t("მაქსიმალური ვადა")%></b></label></section>\n\
<section class="col col-md-11"><label class="textarea"> <i class="icon-append fa fa-id-card"></i><textarea name="edcomment'+$fg+'" placeholder="<%=trs.t("კომენტარი")%>">'+comment+'</textarea></label></section>\n\
<section class="col col-md-1"><button class="btn btn-danger removeold"><i class="fa fa-times"></i></button></section></div>');
  $(".limits").prepend($clone);
  $("#edlab"+$fg).val(labtest);
  $("#edsample"+$fg).val(sampletype);
  $("#edlab"+$fg).select2({allowClear: true,placeholder: "<%=trs.t("კვლევა")%>",formatNoMatches: function () {return "<%=trs.t("კვლევა არ მოიძებნა")%>";},escapeMarkup: function (markup) {return markup;}});
  $("#edsample"+$fg).select2({allowClear: true,placeholder: "<%=trs.t("ნიმუში")%>",formatNoMatches: function () {return "<%=trs.t("ნიმუში არ მოიძებნა")%>";},escapeMarkup: function (markup) {return markup;}});
}



function cbUpdSample(res)
{
    $('.samplequantity').tooltip('destroy');
    $('.samplenums').tooltip('destroy');
    if (res.status=="ER")
    {
        alertError('<%=trs.t("შეცდომა")%>',"სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას",'<%=trs.t("დახურვა")%>');
    }
    else
    {

        $('#sampletable').trigger( 'reloadGrid' );
    }
}

function updSample(id) {
    sendRequest("api/setsampletype.jsp",{oper:"updSample",id:id,num1:$("#num1_"+id).val(),num2:$("#num2_"+id).val(),quantity:$("#quantity_"+id).val()},cbUpdSample);
}
function updSampleNums(id) {
    sendRequest("api/setsampletype.jsp",{oper:"updSampleNums",id:id,num1:$("#num1_"+id).val(),num2:$("#num2_"+id).val()},cbUpdSample);
}
function updSampleQuantity(id) {
    sendRequest("api/setsampletype.jsp",{oper:"updSampleQuantity",id:id,quantity:$("#quantity_"+id).val()},cbUpdSample);
}
function cbDeleteContractSample(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
//        alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
        $('#sampletable').trigger( 'reloadGrid' );
        resetAnalysis();
    }
}






function addAnalysis() {
    if ($("#analysis").val()!=="")
    {
        sendRequest("api/setanalysis.jsp",{oper:"add",contractid:$("#contract").val(),labtestid: $("#analysis").val()},cbAddAnalysis);
    }
}
    
function cbAddAnalysis(res)
{
    if (res.status=="ER")
    {
            alertError('<%=trs.t("შეცდომა")%>',"სერვისის გამოძახება შეუძლებელია. სცადეთ თავიდან ან დაუკავშირით ტექნიკურ განყოფილებას",'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $("#analysis").val("");
    }
}

function submitInstitution() {
    sendForm("frminstitution",cbSubmitInstitution);
}
function cbSubmitInstitution(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $("#chlabModal").modal("hide");
        if ($("#sample-box").css('visibility') != 'hidden') {
            $("#sampletable").trigger("reloadGrid"); 
        }

        $('#'+$("ul#analyses-tab li.active a").attr("data-table")).trigger('reloadGrid');
        resetReport();
    }
}

function submitClosing() {
        sendForm("frmclose",cbSubmitClosing);
}

function cbSubmitClosing(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
        $("#msgModal").modal("hide");
    }
}

function sendContract2Lab() {
    $("#frmsendcontract2lab input[name='contractid']").val($('#contract').val().trim());
    $("#frmsendcontract2lab input[name='appealid']").val($('#appeal').val().trim());
    $("#frmsendcontract2lab input[name='actid']").val($('#act').val().trim());
    sendForm("frmsendcontract2lab",cbSendContract2Lab);
}

function cbSendContract2Lab(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        $("#sendcontractModal").modal("hide");
        alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
        
    }
}

function submitBanitem() {
    sendForm("frmbanitem",cbSubmitBanitem);
}
function cbSubmitBanitem(rs) {
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
        alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
        $("#banModal").modal("hide");
    }
}

function changeActContent(){
    $.post("content/getactcontent.jsp",{ contract: $("#contract").val() },function(data){
        $("#actcontent").val(data.content)
    },"json");
}

/*
$(document).on("click", ".showanalisys", function () {
    $("#frmcancelban input[name=id]").val($(this).attr("data-itemid"));
    $("#cancelbanModal").modal("show");
});
*/
$(document).on("click", ".deltanalisys", function () {
    ConfirmDelete('api/setanalysis.jsp',{oper:"del",id:$(this).attr("data-itemid")},cbDelAnalysis);
});

$(document).on("click", ".stopanalisys", function () {
    var s = $(this).parent().parent().hasClass("stoped") ? 2 : 1;
    sendRequest("api/setanalysis.jsp",{oper:"status",id:$(this).attr("data-itemid"),status:s},cbStopAnalysis);
});

$(document).on("click", ".contactsampletype", function () {
    var id = $(this).attr("data-itemid");
    $(".contactsampleitem[data-itemid=" + id +"]").prop('checked', this.checked);
});
$(document).on("click", ".contactsampleitem", function () {
    var id = $(this).attr("data-itemid");
    var ch = $(".contactsampleitem:checkbox:not(:checked)[data-itemid=" + id +"]");
    $(".contactsampletype[data-itemid=" + id +"]").prop('checked', ch.length===0);
});
$(document).on("click", ".contactsamplebox", function () {
    var id = $(this).attr("data-itemid");
    $(".contactsampleboxitem[data-itemid=" + id +"]").prop('checked', this.checked);
});
$(document).on("click", ".contactsampleboxitem", function () {
    var id = $(this).attr("data-itemid");
    var ch = $(".contactsampleboxitem:checkbox:not(:checked)[data-itemid=" + id +"]");
    $(".contactsamplebox[data-itemid=" + id +"]").prop('checked', ch.length===0);
});

function selall(){
//    $('#sampletable .contactsampleitem').each(function () { this.checked = $("#selall").is(":checked"); });
//    $('#sampletable .contactsampleboxitem').each(function () { this.checked = $("#selall").is(":checked"); });
  $('#sampletable td input:checkbox').each(function () { this.checked = $("#selall").is(":checked"); });
}

function cbDelAnalysis(rs)
{
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
    $('#'+$("ul#analyses-tab li.active a").attr("data-table")).trigger('reloadGrid');
    resetAnalysis();
    }
}
function cbStopAnalysis(rs)
{
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else
    {
    $('#'+$("ul#analyses-tab li.active a").attr("data-table")).trigger('reloadGrid');
    }
}

function printForm(){

        var RowId = $.map($(".sampleitemreseach:checkbox:checked"), function(n, i){return n.value;});
        if (RowId.length == 0)
            alertError('<%=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        else
        {
            printReport("F-138-2016-G", RowId[0])
        }
    }
    
function calculatetotal(){
    var tot = 0;
    $(".testprice").each(function(index) {
        var name = $(this).attr('name');
        var id = name.substring(8);
        var mp = 0;
        var mn = 0;
        console.log( '$("#edmaxpri"'+id+').val() = '+$("input[name=edmaxpri"+id+"]").val() );
        console.log( '$("#edmaxnum"'+id+').val() = '+$("input[name=edmaxnum"+id+"]").val() );
        console.log( '$("#maxprice"'+id+').val() = '+$("input[name=maxprice"+id+"]").val() );
        console.log( '$("#maxnum"'+id+').val() = '+$("input[name=maxnum"+id+"]").val() );
        if($("input[name=edmaxpri"+id+"]").length && !isNaN($("input[name=edmaxpri"+id+"]").val()) && $("input[name=edmaxpri"+id+"]").val().length > 0) mp = Number($("input[name=edmaxpri"+id+"]").val());
        if($("input[name=edmaxnum"+id+"]").length && !isNaN($("input[name=edmaxnum"+id+"]").val()) && $("input[name=edmaxnum"+id+"]").val().length > 0) mn = Number($("input[name=edmaxnum"+id+"]").val());
        if($("input[name=maxprice"+id+"]").length && !isNaN($("input[name=maxprice"+id+"]").val()) && $("input[name=maxprice"+id+"]").val().length > 0) mp = Number($("input[name=maxprice"+id+"]").val());
        if($("input[name=maxnum"+id+"]").length && !isNaN($("input[name=maxnum"+id+"]").val()) && $("input[name=maxnum"+id+"]").val().length > 0) mn = Number($("input[name=maxnum"+id+"]").val());
        var pr = mp*mn;
        tot += pr;
      //console.log( pr );
    });
    $("input[name=contractprice]").val(tot);
    
}
</script>