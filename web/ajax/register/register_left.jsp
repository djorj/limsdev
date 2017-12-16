<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../includes/init.jsp" %>
<%
String actcontent = "საქართველოს სოფლის მეურნეობის სამინისტროს ლაბორატორიის ნიმუშების რეგისტრაციის და სტატისტიკური დამუშავების განყოფილების მთ.სპეციალისტი _______________ ერთის მხრივ და მეორე მხრივ __________________-ის წარმომადგენელი ___________________ ვადგენთ აქტს მასზედ, რომ _______________ ლაბორატორიაში შემოიტანა __________________________________________________________ გამოსაკვლევად.";    
    
%>

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
        <button class="btn btn-success btn-full" onclick="showcontract2lab()"><%=trs.t("გადაცემა")%></button>
    </section>
    <section class="col col-md-12" id="end-field" style="display: none;">
        <button class="btn btn-success btn-full" onclick="showmsg()"><%=trs.t("შენახვა")%></button>
    </section>
</div>