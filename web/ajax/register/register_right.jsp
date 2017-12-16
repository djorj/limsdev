<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../includes/init.jsp" %>
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