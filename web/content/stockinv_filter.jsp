<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
%>
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