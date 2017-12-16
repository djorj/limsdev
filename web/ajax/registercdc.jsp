<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
%>
<a class="fixed-btn btn2 btn-primary preview tip" data-original-title="<%=trs.t("ფორმის ნახვა")%>" data-placement="left" onclick="ShowView()"><i class="fa fa-eye"></i></a>
<a class="fixed-btn btn2 btn-warning edit tip" data-original-title="<%=trs.t("ფორმის რედაქტირება")%>" data-placement="left" onclick="HideView()" style="display: none;"><i class="fa fa-pencil"></i></a>
<div class="register-panel">
    <div class="panel panel-default">
        <div class="panel-body">
            <div class="smart-form">
                <div class="col-sm-12">
                    <section class="col col-sm-12">
                        <label class="label"><%=trs.t("საფუძველი:")%></label>
                        <div class="inline-group">
                            <label class="radio">
                                <input id="radio1-1" name="radio1" type="radio">
                                <i></i><%=trs.t("სხვა")%></label>
                            <label class="radio">
                                <input id="radio1-2" name="radio1" type="radio">
                                <i></i><%=trs.t("ეპიდზედამხედველობა")%></label>
                            <label class="radio">
                                <input id="radio1-3" name="radio1" type="radio">
                                <i></i><%=trs.t("პროექტი/პროგრამა")%></label>
                            <label class="radio">
                                <input id="radio1-4" name="radio1" type="radio">
                                <i></i><%=trs.t("თვითმომართვა")%></label>
                        </div>
                    </section>
                    <section class="col col-sm-4 control3" style="display: none;">
                        <div class="input-group">
                            <label class="input"> <i class="icon-append fa fa-institution"></i>
                                <input list="contragent" placeholder="<%=trs.t("დამკვეთი")%>" type="text">
                                <b class="tooltip tooltip-top-right"><i class="fa fa-institution txt-color-teal"></i> <%=trs.t("კვლევის დამკვეთი")%></b>
                                <datalist id="contragent">
                                    <option value="209472505 დამკვეთი"></option>
                                    <option value="204861042 დამკვეთი"></option>
                                    <option value="211361776 დამკვეთი"></option>
                                    <option value="460010011 დამკვეთი"></option>
                                    <option value="211351883 დამკვეთი"></option>
                                </datalist>
                            </label>
                            <div class="input-group-btn">
                                <button class="btn btn-success" data-original-title="<%=trs.t("დამკვეთის დამატება")%>" type="button">
                                    <i class="fa fa-plus"></i>
                                </button>
                            </div>
                            <div class="input-group-btn">
                                <button class="btn btn-danger" data-original-title="<%=trs.t("გასუფთავება")%>" type="button">
                                    <i class="fa fa-times"></i>
                                </button>
                            </div>
                        </div>
                    </section>
                    <section class="col col-sm-2 control1" style="display: none;">
                        <label class="select">
                            <select>
                                <option value="0"><%=trs.t("- პროგრამა/პროექტი -")%></option>
                                <option value="1"><%=trs.t("C-ჰეპატიტი")%></option>
                                <option value="2"><%=trs.t("შიდსი")%></option>
                            </select><i></i>
                            <b class="tooltip tooltip-top-right"><%=trs.t("პროგრამა/პროექტი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-12 control4" style="display: none;">
                        <label class="label"><%=trs.t("ნიმუშის ტიპი:")%></label>
                        <div class="inline-group">
                            <label class="radio">
                                <input id="radio2-1" name="radio2" type="radio">
                                <i></i><%=trs.t("ადამიანი")%></label>
                            <label class="radio">
                                <input id="radio2-2" name="radio2" type="radio">
                                <i></i><%=trs.t("გარემო")%></label>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-default control20" style="display: none;">
        <div class="panel-body">
            <div class="smart-form">
                <div class="col-sm-12">
                    <section class="col col-sm-12">
                        <div class="inline-group">
                            <label class="radio">
                                <input id="radio5-1" name="radio5" type="radio">
                                <i></i><%=trs.t("ინდივიდუალური")%></label>
                            <label class="radio">
                                <input id="radio5-2" name="radio5" type="radio">
                                <i></i><%=trs.t("ჯგუფური")%></label>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-default control21" style="display: none;">
        <div class="panel-heading"><%=trs.t("კონტაქტირებული")%></div>
        <div class="panel-body">
            <div class="smart-form">
                <div class="col-sm-12">
                    <section class="col col-sm-2">
                        <div class="input-group">
                            <label class="input"> <i class="icon-append fa fa-id-card"></i>
                                <input class="mask" placeholder="<%=trs.t("პირადი N")%>" type="text">
                                <b class="tooltip tooltip-top-right"><i class="fa fa-card txt-color-teal"></i> <%=trs.t("კვლევის დამკვეთი")%></b>
                            </label>
                            <div class="input-group-btn">
                                <button class="btn btn-success" data-original-title="<%=trs.t("შემოწმება")%>" type="button">
                                    <i class="fa fa-check"></i>
                                </button>
                            </div>
                        </div>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-user"></i>
                            <input placeholder="<%=trs.t("სახელი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("პაციენტის სახელი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-user"></i>
                            <input placeholder="<%=trs.t("გვარი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("პაციენტის გვარი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="select">
                            <select>
                                <option value="0"><%=trs.t("- სქესი -")%></option>
                            </select><i></i>
                            <b class="tooltip tooltip-top-right"><%=trs.t("პაციენტის სქესი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="datepicker" placeholder="<%=trs.t("დაბადების თარიღი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("პაციენტის დაბადების თარიღი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-12">
                        <jsp:include page="../elements/country.jsp">
                            <jsp:param name="label" value="საქართველო"></jsp:param>
                            <jsp:param name="idname" value="countryid"></jsp:param>
                            <jsp:param name="tooltip" value="პაციენტის მისამართი: ქვეყანა"></jsp:param>
                        </jsp:include>
                    </section>
                    <jsp:include page="../elements/address.jsp">
                        <jsp:param name="suffix" value="0"></jsp:param>
                        <jsp:param name="colmd" value="4"></jsp:param>
                    </jsp:include>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-fax"></i>
                            <input placeholder="<%=trs.t("საფოსტო ინდექსი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-fax txt-color-teal"></i> <%=trs.t("პაციენტის საფოსტო ინდექსი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-envelope"></i>
                            <input placeholder="<%=trs.t("ელ-ფოსტა")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-envelope txt-color-teal"></i> <%=trs.t("პაციენტის ელ-ფოსტა")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-12">
                        <label class="checkbox">
                            <input name="checkbox3" type="checkbox">
                            <i></i><%=trs.t("სინჯია")%></label>
                    </section>
                    <section class="col col-sm-2 control22">
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input placeholder="<%=trs.t("ნიმუშ(ებ)ის ჭურჭლის N")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-list-ol txt-color-teal"></i> <%=trs.t("ნიმუშ(ებ)ის ჭურჭლის N")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2 control22">
                        <label class="select">
                            <select>
                                <option value="0"><%=trs.t("- ნიმუშის ტიპი -")%></option>
                            </select><i></i>
                            <b class="tooltip tooltip-top-right"><%=trs.t("ნიმუშის ტიპი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2 control22">
                        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                            <input class="datetime" placeholder="<%=trs.t("აღების თარიღი/დრო")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-clock-o txt-color-teal"></i> <%=trs.t("ნიმუშის აღების თარიღი და დრო")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2 control23" style="display: none;">
                        <label class="input"> <i class="icon-append fa fa-eyedropper"></i>
                            <input placeholder="<%=trs.t("სინჯის ტიპი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-eyedropper txt-color-teal"></i> <%=trs.t("სინჯის ტიპი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2 control23" style="display: none;">
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input placeholder="<%=trs.t("საიდენტიფიკაციო N")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-list-ol txt-color-teal"></i> <%=trs.t("საიდენტიფიკაციო N")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2 control23" style="display: none;">
                        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                            <input class="datetime" placeholder="<%=trs.t("დამზადების თარიღი/დრო")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-clock-o txt-color-teal"></i> <%=trs.t("დამზადების თარიღი და დრო")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> 
                            <input name="analys" list='analys3' type="text" value="" placeholder="<%=trs.t("საკვლევი პათოგენი")%>">
                            <b class="tooltip tooltip-top-right"><%=trs.t("საკვლევი პათოგენი")%></b>
                            <datalist id="analys3">
                                <option value="პათოგენი"></option>
                                <option value="პათოგენი"></option>
                                <option value="პათოგენი"></option>
                            </datalist>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="select">
                            <select class="select2" multiple="" placeholder="<%=trs.t("მარკერი")%>">
                                <option value="0"><%=trs.t("მარკერი")%></option>
                                <option value="0"><%=trs.t("მარკერი")%></option>
                            </select>
                            <b class="tooltip tooltip-top-right"><%=trs.t("მარკერი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="select">
                            <select class="select2" multiple="" placeholder="<%=trs.t("გამოკვლევის მეთოდი")%>">
                                <option value="0"><%=trs.t("მეთოდი")%></option>
                                <option value="0"><%=trs.t("მეთოდი")%></option>
                            </select>
                            <b class="tooltip tooltip-top-right"><%=trs.t("გამოკვლევის მეთოდი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-6">
                        <button class="btn btn-success" onclick="addbox3()"><i class="fa fa-plus"></i></button>
                        <button class="btn btn-danger"><i class="fa fa-times"></i></button>
                    </section>
                </div>
            </div>
        </div>
    </div>
    <div id="box-box3"></div>
    <div class="panel panel-default control5" style="display: none;">
        <div class="panel-heading"><%=trs.t("ინფორმაცია პაციენტის შესახებ")%></div>
        <div class="panel-body">
            <div class="smart-form">
                <div class="col-sm-12">
                    <section class="col col-sm-12">
                        <label class="checkbox">
                            <input name="checkbox1" type="checkbox">
                            <i></i><%=trs.t("არარეზიდენტი")%></label>
                    </section>
                    <section class="col col-sm-2 control7" style="display: none;">
                        <label class="input"> <i class="icon-append fa fa-id-card"></i>
                            <input placeholder="<%=trs.t("პასპორტის N")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-id-card txt-color-teal"></i> <%=trs.t("პაციენტის პასპორტის N")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2 control7" style="display: none;">
                        <label class="select">
                            <select>
                                <option value="0"><%=trs.t("- მოქალაქეობა -")%></option>
                            </select><i></i>
                            <b class="tooltip tooltip-top-right"><%=trs.t("პაციენტის მოქალაქეობა")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2 control6">
                        <div class="input-group">
                            <label class="input"> <i class="icon-append fa fa-id-card"></i>
                                <input class="mask" placeholder="<%=trs.t("პირადი N")%>" type="text">
                                <b class="tooltip tooltip-top-right"><i class="fa fa-id-card txt-color-teal"></i> <%=trs.t("პაციენტის პირადი N")%></b>
                            </label>
                            <div class="input-group-btn">
                                <button class="btn btn-success" data-original-title="<%=trs.t("შემოწმება")%>" type="button">
                                    <i class="fa fa-check"></i>
                                </button>
                            </div>
                        </div>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-user"></i>
                            <input placeholder="<%=trs.t("სახელი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("პაციენტის სახელი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-user"></i>
                            <input placeholder="<%=trs.t("გვარი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("პაციენტის გვარი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="datepicker" placeholder="<%=trs.t("დაბადების თარიღი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("პაციენტის დაბადების თარიღი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="select">
                            <select>
                                <option value="0"><%=trs.t("- სქესი -")%></option>
                            </select><i></i>
                            <b class="tooltip tooltip-top-right"><%=trs.t("პაციენტის სქესი")%></b>
                        </label>
                    </section>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-default control5" style="display: none;">
        <div class="panel-heading"><%=trs.t("მისამართი")%></div>
        <div class="panel-body">
            <div class="smart-form">
                <div class="col-sm-12">
                    <section class="col col-sm-12 control7" style="display: none;">
                        <jsp:include page="../elements/country.jsp">
                            <jsp:param name="label" value="საქართველო"></jsp:param>
                            <jsp:param name="idname" value="countryid1"></jsp:param>
                            <jsp:param name="tooltip" value="პაციენტის მისამართი: ქვეყანა"></jsp:param>
                        </jsp:include>
                    </section>
                    <jsp:include page="../elements/address.jsp">
                        <jsp:param name="suffix" value="1"></jsp:param>
                        <jsp:param name="colmd" value="4"></jsp:param>
                    </jsp:include>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-fax"></i>
                            <input placeholder="<%=trs.t("საფოსტო ინდექსი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-fax txt-color-teal"></i> <%=trs.t("პაციენტის საფოსტო ინდექსი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-phone"></i>
                            <input placeholder="<%=trs.t("ტელეფონი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-phone txt-color-teal"></i> <%=trs.t("პაციენტის ტელეფონი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-envelope"></i>
                            <input placeholder="<%=trs.t("ელ-ფოსტა")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-envelope txt-color-teal"></i> <%=trs.t("პაციენტის ელ-ფოსტა")%></b>
                        </label>
                    </section>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-default control5" style="display: none;">
        <div class="panel-body">
            <div class="smart-form">
                <div class="col-sm-12">
                    <section class="col col-sm-12">
                        <div class="inline-group">
                            <label class="radio">
                                <input id="radio3-1" name="radio3" type="radio">
                                <i></i><%=trs.t("პაციენი/შემთხვევა")%></label>
                            <label class="radio">
                                <input id="radio3-2" name="radio3" type="radio">
                                <i></i><%=trs.t("გარდაცვლილი")%></label>
                            <label class="radio">
                                <input id="radio3-3" name="radio3" type="radio">
                                <i></i><%=trs.t("კულტურა")%></label>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-default control8" style="display: none;">
        <div class="panel-heading"><%=trs.t("პაციენი/შემთხვევა")%></div>
        <div class="panel-body">
            <div class="smart-form">
                <div class="col-sm-12">
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="datepicker" placeholder="<%=trs.t("კლინიკური სიმპტომების დაწყების თარიღი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("კლინიკური სიმპტომების დაწყების თარიღი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-pencil-square-o"></i>
                            <input placeholder="<%=trs.t("წინასწარი კლინიკური დიაგნოზი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-pencil-square-o txt-color-teal"></i> <%=trs.t("წინასწარი კლინიკური დიაგნოზი")%></b>
                        </label>
                    </section>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-default control9" style="display: none;">
        <div class="panel-heading"><%=trs.t("გარდაცვლილი")%></div>
        <div class="panel-body">
            <div class="smart-form">
                <div class="col-sm-12">
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="datepicker" placeholder="<%=trs.t("გარდაცვალების თარიღი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("გარდაცვალების თარიღი")%></b>
                        </label>
                    </section>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-default control10" style="display: none;">
        <div class="panel-heading"><%=trs.t("კულტურა")%></div>
        <div class="panel-body">
            <div class="smart-form">
                <div class="col-sm-12">
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-pencil-square-o"></i>
                            <input placeholder="<%=trs.t("დასახელება")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-pencil-square-o txt-color-teal"></i> <%=trs.t("კულტურის დასახელება")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input placeholder="<%=trs.t("საიდენტიფიკაციო N")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-list-ol txt-color-teal"></i> <%=trs.t("კულტურის საიდენტიფიკაციო N")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                            <input class="datetime" placeholder="<%=trs.t("დათესვის თარიღი/დრო")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-clock-o txt-color-teal"></i> <%=trs.t("დათესვის თარიღი და დრო")%></b>
                        </label>
                    </section>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-default control11" style="display: none;">
        <div class="panel-body">
            <div class="smart-form">
                <div class="col-sm-12">
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input placeholder="<%=trs.t("დამცავი კონტეინერის N")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-list-ol txt-color-teal"></i> <%=trs.t("დამცავი კონტეინერის N")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-12">
                        <label class="label"><%=trs.t("დამკვეთის მოთხოვნები:")%></label>
                        <div class="inline-group">
                            <label class="checkbox">
                                <input name="checkbox" type="checkbox">
                                <i></i><%=trs.t("კულტურის დადასტურება")%></label>
                            <label class="checkbox">
                                <input name="checkbox" type="checkbox">
                                <i></i><%=trs.t("კულტურის შენახვა")%></label>
                            <label class="checkbox">
                                <input name="checkbox" type="checkbox">
                                <i></i><%=trs.t("ნიმუშის კვლევა")%></label>
                            <label class="checkbox">
                                <input name="checkbox" type="checkbox">
                                <i></i><%=trs.t("სინჯის კვლევა")%></label>
                        </div>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="datepicker" placeholder="<%=trs.t("ნიმუშ(ებ)ის აღების თარიღი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("ნიმუშ(ებ)ის აღების თარიღი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-map-marker"></i>
                            <input placeholder="<%=trs.t("ნიმუშ(ებ)ის აღების ადგილი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-map-marker txt-color-teal"></i> <%=trs.t("ნიმუშ(ებ)ის აღების ადგილი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-8">
                        <label class="input"> <i class="icon-append fa fa-users"></i>
                            <input class="tagsinput" data-role="tagsinput" placeholder="<%=trs.t("ამღები პირები")%>" type="text" style="display: none;">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("ნიმუშის ამღები პირები")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-12">
                        <label class="checkbox">
                            <input name="checkbox4" type="checkbox">
                            <i></i><%=trs.t("სინჯია")%></label>
                    </section>
                    <section class="col col-sm-2 control24" style="display: none;">
                        <label class="input"> <i class="icon-append fa fa-eyedropper"></i>
                            <input placeholder="<%=trs.t("სინჯის დასახელება")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-eyedropper txt-color-teal"></i> <%=trs.t("სინჯის დასახელება")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2 control24" style="display: none;">
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input placeholder="<%=trs.t("საიდენტიფიკაციო N")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-list-ol txt-color-teal"></i> <%=trs.t("საიდენტიფიკაციო N")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2 control24" style="display: none;">
                        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                            <input class="datetime" placeholder="<%=trs.t("დამზადების თარიღი/დრო")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-clock-o txt-color-teal"></i> <%=trs.t("დამზადების თარიღი და დრო")%></b>
                        </label>
                    </section>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-default control12" style="display: none;">
        <div class="panel-body">
            <div class="smart-form">
                <div class="col-sm-12">
                    <section class="col col-sm-1">
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input placeholder="<%=trs.t("ნიმუშ(ებ)ის ჭურჭლის N")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-list-ol txt-color-teal"></i> <%=trs.t("ნიმუშ(ებ)ის ჭურჭლის N")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="select">
                            <select>
                                <option value="0"><%=trs.t("- ნიმუშის ტიპი -")%></option>
                            </select><i></i>
                            <b class="tooltip tooltip-top-right"><%=trs.t("ნიმუშის ტიპი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                            <input class="timepicker" placeholder="<%=trs.t("აღების დრო")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-clock-o txt-color-teal"></i> <%=trs.t("ნიმუშის აღების დრო")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> 
                            <input name="analys" list='analys' type="text" value="" placeholder="<%=trs.t("საკვლევი პათოგენი")%>">
                            <b class="tooltip tooltip-top-right"><%=trs.t("საკვლევი პათოგენი")%></b>
                            <datalist id="analys">
                                <option value="პათოგენი"></option>
                                <option value="პათოგენი"></option>
                                <option value="პათოგენი"></option>
                            </datalist>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="select">
                            <select class="select2" multiple="" placeholder="<%=trs.t("მარკერი")%>">
                                <option value="0"><%=trs.t("მარკერი")%></option>
                                <option value="0"><%=trs.t("მარკერი")%></option>
                            </select>
                            <b class="tooltip tooltip-top-right"><%=trs.t("მარკერი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="select">
                            <select class="select2" multiple="" placeholder="<%=trs.t("გამოკვლევის მეთოდი")%>">
                                <option value="0"><%=trs.t("მეთოდი")%></option>
                                <option value="0"><%=trs.t("მეთოდი")%></option>
                            </select>
                            <b class="tooltip tooltip-top-right"><%=trs.t("გამოკვლევის მეთოდი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-1">
                        <button class="btn btn-success" onclick="addbox()"><i class="fa fa-plus"></i></button>
                        <button class="btn btn-danger"><i class="fa fa-times"></i></button>
                    </section>
                </div>
            </div>
        </div>
    </div>        
    <div id="box-box"></div>
    <div class="panel panel-default control12 control21" style="display: none;">
        <div class="panel-body">
            <div class="smart-form">
                <div class="col-sm-12">
                    <section class="col col-sm-2">
                        <label class="select">
                            <select>
                                <option value="0"><%=trs.t("- მიმღები დაწესებულება -")%></option>
                            </select><i></i>
                            <b class="tooltip tooltip-top-right"><%=trs.t("მიმღები დაწესებულება")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2 control21" style="display: none;">
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input placeholder="<%=trs.t("დამცავი კონტეინერის N")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-list-ol txt-color-teal"></i> <%=trs.t("დამცავი კონტეინერის N")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="select">
                            <select>
                                <option value="0"><%=trs.t("- გამომკვლევი დაწესებულება -")%></option>
                            </select><i></i>
                            <b class="tooltip tooltip-top-right"><%=trs.t("გამომკვლევი დაწესებულება")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-user"></i>
                            <input placeholder="<%=trs.t("შევსებაზე პასუხისმგებელი პირის სახელი, გვარი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("შევსებაზე პასუხისმგებელი პირის სახელი, გვარი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                            <input class="datetime" placeholder="<%=trs.t("გაგზავნის თარიღი/დრო")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-clock-o txt-color-teal"></i> <%=trs.t("გაგზავნის თარიღი და დრო")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-phone"></i>
                            <input placeholder="<%=trs.t("ტელეფონის ნომერი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-phone txt-color-teal"></i> <%=trs.t("შევსებაზე პასუხისმგებელი პირის ტელეფონის ნომერი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-12">
                        <label class="input"> <i class="icon-append fa fa-users"></i>
                            <input class="tagsinput" data-role="tagsinput" placeholder="<%=trs.t("ტრანსპ. პასუხისმგებელი პირები")%>" type="text" style="display: none;">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("ტრანსპ. პასუხისმგებელი პირები (სახელი, გვარი)")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-12">
                        <button class="btn btn-success" id="away" onclick="ShowView()"><%=trs.t("გადაგზავნა")%></button>
                    </section>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-default control14" style="display: none;">
        <div class="panel-body">
            <div class="smart-form">
                <div class="col-sm-12">
                    <section class="col col-sm-12">
                        <div class="inline-group">
                            <label class="checkbox">
                                <input name="checkbox5" type="checkbox">
                                <i></i><%=trs.t("GPS კოორდინატები")%></label>
                        </div>
                    </section>
                </div>
                <section class="col col-sm-12 control18" style="padding: 0; display: none;">
                    <section class="col col-md-2 col-sm-4">
                        <label class="input"> <i class="icon-append fa fa-globe"></i>
                            <input placeholder="<%=trs.t("N")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("GPS კოორდინატი N (განედი)")%></b>
                        </label>
                    </section>
                    <section class="col col-md-2 col-sm-4">
                        <label class="input"> <i class="icon-append fa fa-globe"></i>
                            <input placeholder="<%=trs.t("E")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("GPS კოორდინატი E (გრძედი)")%></b>
                        </label>
                    </section>
                    <section class="col col-md-2 col-sm-4">
                        <label class="input"> <i class="icon-append fa fa-globe"></i>
                            <input placeholder="<%=trs.t("F(მ)")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("GPS კოორდინატი F (სიმაღლე მეტრებში)")%></b>
                        </label>
                    </section>
                </section>
                <section class="col col-sm-2">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("კვლევის ობიექტის დასახელება")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("კვლევის ობიექტის დასახელება")%></b>
                    </label>
                </section>
                <section class="col col-sm-2">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("ტელეფონი")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("ტელეფონი")%></b>
                    </label>
                </section>
                <section class="col col-sm-2">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("საფოსტო კოდი")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("საფოსტო კოდი")%></b>
                    </label>
                </section>
                <section class="col col-sm-2">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("ელ-ფოსტა")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("ელ-ფოსტა")%></b>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <jsp:include page="../elements/country.jsp">
                        <jsp:param name="label" value="საქართველო"></jsp:param>
                        <jsp:param name="idname" value="countryid2"></jsp:param>
                        <jsp:param name="tooltip" value="პაციენტის მისამართი: ქვეყანა"></jsp:param>
                    </jsp:include>
                </section>
                <jsp:include page="../elements/address.jsp">
                    <jsp:param name="suffix" value="2"></jsp:param>
                    <jsp:param name="colmd" value="4"></jsp:param>
                </jsp:include>
                <section class="col col-sm-2">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("შემსრულებელი ჯგუფის N")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("შემსრულებელი ჯგუფის N")%></b>
                    </label>
                </section>
                <section class="col col-sm-2">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("წერტილის N")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("წერტილის N")%></b>
                    </label>
                </section>
                <section class="col col-sm-2">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- სტაცია -")%></option>
                            <option value="1"><%=trs.t("ღია")%></option>
                            <option value="2"><%=trs.t("დახურული")%></option>
                        </select><i></i>
                        <b class="tooltip tooltip-top-right"><%=trs.t("სტაცია")%></b>
                    </label>
                </section>
                <section class="col col-sm-2">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("საკვლევი მასალის რაოდენობა")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("რაოდენობა")%></b>
                    </label>
                </section>
                <section class="col col-sm-2">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("აღების ადგილი")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("აღების ადგილი")%></b>
                    </label>
                </section>
                <section class="col col-sm-2">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("დამცავი კონტეინერის N")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("დამცავი კონტეინერის N")%></b>
                    </label>
                </section>
                <section class="col col-sm-2">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("ნიმუშის ჭურჭლის N")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("ნიმუშის ჭურჭლის N")%></b>
                    </label>
                </section>
                <section class="col col-sm-2">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- ნიმუშის ტიპი -")%></option>
                        </select><i></i>
                        <b class="tooltip tooltip-top-right"><%=trs.t("ნიმუშის ტიპი")%></b>
                    </label>
                </section>
                <section class="col col-sm-2">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("საკვლევი მასალა")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("საკვლევი მასალა")%></b>
                    </label>
                </section>
                <section class="col col-sm-2">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("GPS კოორდინატებიდან გადახრის კუთხე")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("GPS კოორდინატებიდან გადახრის კუთხე")%></b>
                    </label>
                </section>
                <section class="col col-sm-2">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("GPS კოორდინატებიდან მანძილი მეტრებში")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("GPS კოორდინატებიდან მანძილი მეტრებში")%></b>
                    </label>
                </section>
                <section class="col col-sm-2">
                    <label class="input"> 
                        <input name="analys" list='analys6' type="text" value="" placeholder="<%=trs.t("საკვლევი პათოგენი")%>">
                        <b class="tooltip tooltip-top-right"><%=trs.t("საკვლევი პათოგენი")%></b>
                        <datalist id="analys6">
                            <option value="პათოგენი"></option>
                            <option value="პათოგენი"></option>
                            <option value="პათოგენი"></option>
                        </datalist>
                    </label>
                </section>
                <section class="col col-sm-2">
                    <label class="select">
                        <select class="select2" multiple="" placeholder="<%=trs.t("მარკერი")%>">
                            <option value="0"><%=trs.t("მარკერი")%></option>
                            <option value="0"><%=trs.t("მარკერი")%></option>
                        </select>
                        <b class="tooltip tooltip-top-right"><%=trs.t("მარკერი")%></b>
                    </label>
                </section>
                <section class="col col-sm-2">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- გამოკვლევის მეთოდი -")%></option>
                        </select><i></i>
                        <b class="tooltip tooltip-top-right"><%=trs.t("გამოკვლევის მეთოდი")%></b>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="checkbox">
                        <input name="checkbox2" type="checkbox">
                        <i></i><%=trs.t("სინჯია")%></label>
                </section>
                <section class="col col-sm-2 control15" style="display: none;">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("საიდენტიფიკაციო N")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("საიდენტიფიკაციო N")%></b>
                    </label>
                </section>
                <section class="col col-sm-2 control15" style="display: none;">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("სინჯის დასახელება")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("საიდენტიფიკაციო N")%></b>
                    </label>
                </section>
                <section class="col col-sm-2 control15" style="display: none;">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input class="datepicker" placeholder="<%=trs.t("დამზადების თარიღი")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("დამზადების თარიღი")%></b>
                    </label>
                </section>
                <section class="col col-sm-2">
                    <button class="btn btn-success" onclick="addbox2()"><i class="fa fa-plus"></i></button>
                    <button class="btn btn-danger"><i class="fa fa-times"></i></button>
                </section>
            </div>
        </div>
    </div>
    <div id="box-box2"></div>
    <div class="panel panel-default control14" style="display: none;">
        <div class="panel-body">
            <div class="smart-form">
                <div class="col-sm-12">
                    <section class="col col-sm-2">
                        <label class="select">
                            <select>
                                <option value="0"><%=trs.t("- მიმღები დაწესებულება -")%></option>
                            </select><i></i>
                            <b class="tooltip tooltip-top-right"><%=trs.t("მიმღები დაწესებულება")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="select">
                            <select>
                                <option value="0"><%=trs.t("- გამომკვლევი დაწესებულება -")%></option>
                            </select><i></i>
                            <b class="tooltip tooltip-top-right"><%=trs.t("გამომკვლევი დაწესებულება")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-globe"></i>
                            <input placeholder="<%=trs.t("შევსებაზე პასუხისმგებელი პირის სახელი, გვარი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("შევსებაზე პასუხისმგებელი პირის სახელი, გვარი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-globe"></i>
                            <input class="datetime" placeholder="<%=trs.t("გაგზავნის თარიღი/დრო")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("გაგზავნის თარიღი და დრო")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="input"> <i class="icon-append fa fa-globe"></i>
                            <input placeholder="<%=trs.t("ტელეფონის ნომერი")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("ტელეფონის ნომერი")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-12">
                        <label class="input"> <i class="icon-append fa fa-users"></i>
                            <input class="tagsinput" data-role="tagsinput" placeholder="<%=trs.t("ტრანსპ. პასუხისმგებელი პირები")%>" type="text" style="display: none;">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("ტრანსპ. პასუხისმგებელი პირები (სახელი, გვარი)")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-12">
                        <button class="btn btn-success" id="away2" onclick="ShowView()"><%=trs.t("გადაგზავნა")%></button>
                    </section>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="view-panel" style="display: none;">
    <div class="col-sm-6">
        <div class="panel panel-default">
            <div class="panel-heading"><%=trs.t("ინფორმაცია")%></div>
            <div class="panel-body" style="height: calc(100vh - 216px); overflow: auto;">
                <div class="panel panel-default">
                    <div class="panel-heading"><%=trs.t("ძირითადი ინფორმაცია")%></div>
                    <div class="panel-body">
                        <p>
                            <b><%=trs.t("კვლევის საფუძველი")%></b>: <%=trs.t("ეპიდზედამხედველობა")%>
                            <br>
                            <b><%=trs.t("ნიმუშის ტიპი")%></b>: <%=trs.t("ადამიანი")%>
                            <br>
                            <b><%=trs.t("კატეგორია")%></b>: <%=trs.t("პაციენი/შემთხვევა")%>
                            <br>
                            <b><%=trs.t("წინასწარი კლინიკური დიაგნოზი")%></b>: <%=trs.t("ჯილეხი")%>
                            <br>
                        </p>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading"><%=trs.t("ინფორმაცია პაციენტის/შემთხვევის შესახებ")%></div>
                    <div class="panel-body">
                        <p>
                            <b><%=trs.t("პაციენტი სახელი, გვარი")%></b>: <%=trs.t("გიორგი გიორგაძე")%>
                            <br>
                            <b><%=trs.t("დაბადების თარიღი")%></b>: <%=trs.t("10/10/1885")%>
                            <br>
                            <b><%=trs.t("სქესი")%></b>: <%=trs.t("მამრობითი")%>
                            <br>
                            <b><%=trs.t("მისამართი")%></b>: <%=trs.t("აჭარა, ბათუმი")%>
                            <br>
                        </p>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading"><%=trs.t("ინფორმაცია დამკვეთის შესახებ შესახებ")%></div>
                    <div class="panel-body">
                        <p>
                            <b><%=trs.t("დამკვეთი დაწესებულება")%>")%></b>: <%=trs.t("მედი ქლაბი")%>
                            <br>
                            <b><%=trs.t("განყოფილება")%></b>: <%=trs.t("პედიატრია")%>
                            <br>
                            <b><%=trs.t("სახელი, გვარი")%></b>: <%=trs.t("დათო ჟორჟოლიანი")%>
                            <br>
                        </p>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading"><%=trs.t("ინფორმაცია ნიმუშების შესახებ")%></div>
                    <div class="panel-body">
                        <p>
                            <b><%=trs.t("დამკვეთის მოთხოვნები")%></b>: <%=trs.t("კულტურის დადასტურება, ნიმუშის კვლევა")%>
                            <br>
                            <b><%=trs.t("ნიმუშის ჭურჭლის N")%></b>: <%=trs.t("5454165")%>
                            <br>
                            <b><%=trs.t("ნიმუშის ტიპი")%></b>: <%=trs.t("წყლულის შიგთავსი")%>
                            <br>
                            <b><%=trs.t("აღების თარიღი/დრო")%></b>: <%=trs.t("20/07/2017 12:03")%>
                            <br>
                            <b><%=trs.t("საკვლევი პათოგენი")%></b>: <%=trs.t("Bacilus Antracis")%>
                            <br>
                            <b><%=trs.t("გამოკვლევის მეთოდი")%></b>: <%=trs.t("ბაქტერიოლოგიური, მოლეკულური")%>
                            <br>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-sm-6">
        <div class="panel panel-default">
            <div class="panel-heading"><%=trs.t("ლაბორატორიული კვლევის მოთხოვნის ფორმა")%></div>
            <div class="panel-body">
                <object data="documents/gggg.pdf" type="application/pdf" width="100%" style="height: calc(100vh - 251px)"><%=trs.t("თქვენ ბრაუზერს არ შეუძლია PDF-ის გახსნა")%></object>
            </div>
        </div>
    </div>
</div>
<div class="col-sm-12">
    <div class="panel panel-default control17" style="display: none;">
        <div class="panel-heading"><b><%=trs.t("ნიმუშის მიღება ლაბორატორიის მიერ")%></b></div>
        <div class="panel-body">
            <div class="smart-form">
                <div class="col-sm-12" style="padding: 0;">
                    <section class="col col-sm-2" style="padding: 0;">
                        <label class="input"> <i class="icon-append fa fa-globe"></i>
                            <input disabled='' class="datetime now" placeholder="<%=trs.t("მიღების თარიღი/დრო")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("მიღების თარიღი და დრო")%></b>
                        </label>
                    </section>
                </div>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th><%=trs.t("ნიმუშ(ებ)ის ჭურჭლის N")%></th>
                            <th><%=trs.t("ნიმუშის ტიპი")%></th>
                            <th><%=trs.t("შტრიხკოდი")%></th>
                            <th><%=trs.t("მდგომარეობა")%></th>
                            <th><%=trs.t("დანიშნულება")%></th>
                            <th><%=trs.t("მოქმედება")%></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><%=trs.t("27651283")%></td>
                            <td><%=trs.t("სისხლი")%></td>
                            <td><img src="img/code.png" alt="" style="height: 34px;"/></td>
                            <td>
                                <div class='smart-form'>
                                    <label class="select">
                                        <select class="poor">
                                            <option value="0"><%=trs.t("არადამაკმაყოფილებელი")%></option>
                                            <option value="1"><%=trs.t("დამაკმაყოფილებელი")%></option>
                                        </select><i></i>
                                        <b class="tooltip tooltip-top-right"><%=trs.t("ნიმუშის მდგომარეობა")%></b>
                                    </label>
                                </div>
                            </td>
                            <td>
                                <div class='smart-form'>
                                    <label class="select">
                                        <select>
                                            <option value="0"><%=trs.t("ადგილზე გამოსაკვლევი")%></option>
                                            <option value="1"><%=trs.t("ტრანზიტი")%></option>
                                        </select><i></i>
                                        <b class="tooltip tooltip-top-right"><%=trs.t("დანიშნულება")%></b>
                                    </label>
                                </div>
                            </td>
                            <td>
                                <button class="btn btn-default" onclick="hereModal()"><i class="fa fa-home"></i></button>
                                <button class="btn btn-warning"><i class="fa fa-pencil"></i></button>
                                <button class="btn btn-danger"><i class="fa fa-trash"></i></button>
                                <button class="btn btn-primary showcode"><i class="fa fa-print"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td>27651368</td>
                            <td><%=trs.t("სისხლი")%></td>
                            <td><img src="img/code.png" alt="" style="height: 34px;"/></td>
                            <td>
                                <div class='smart-form'>
                                    <label class="select">
                                        <select class="poor">
                                            <option value="0"><%=trs.t("არადამაკმაყოფილებელი")%></option>
                                            <option value="1"><%=trs.t("დამაკმაყოფილებელი")%></option>
                                        </select><i></i>
                                        <b class="tooltip tooltip-top-right"><%=trs.t("ნიმუშის მდგომარეობა")%></b>
                                    </label>
                                </div> 
                            </td>
                            <td>
                                <div class='smart-form'>
                                    <label class="select">
                                        <select>
                                            <option value="0"><%=trs.t("ადგილზე გამოსაკვლევი")%></option>
                                            <option value="1" selected=""><%=trs.t("ტრანზიტი")%></option>
                                        </select><i></i>
                                        <b class="tooltip tooltip-top-right"><%=trs.t("დანიშნულება")%></b>
                                    </label>
                                </div>
                            </td>
                            <td>
                                <button class="btn btn-default" onclick="transportModal()"><i class="fa fa-automobile"></i></button>
                                <button class="btn btn-warning"><i class="fa fa-pencil"></i></button>
                                <button class="btn btn-danger"><i class="fa fa-trash"></i></button>
                                <button class="btn btn-primary showcode"><i class="fa fa-print"></i></button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="col-sm-12">                            
    <div class="panel panel-default control13" style="display: none;">
        <div class="panel-heading"><b><%=trs.t("ნიმუშის მიღება ლაბორატორიის მიერ")%></b></div>
        <div class="panel-body">
            <div class="smart-form">
                <div class="col-sm-12" style="padding: 0;">
                    <section class="col col-sm-2" style="padding: 0;">
                        <label class="input"> <i class="icon-append fa fa-globe"></i>
                            <input disabled='' class="datetime now" placeholder="<%=trs.t("მიღების თარიღი/დრო")%>" type="text">
                            <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("მიღების თარიღი და დრო")%></b>
                        </label>
                    </section>
                </div>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th><%=trs.t("ნიმუშ(ებ)ის ჭურჭლის N")%></th>
                            <th><%=trs.t("ნიმუშის ტიპი")%></th>
                            <th><%=trs.t("შტრიხკოდი")%></th>
                            <th><%=trs.t("მდგომარეობა")%></th>
                            <th><%=trs.t("დანიშნულება")%></th>
                            <th><%=trs.t("მოქმედება")%></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>27651283</td>
                            <td><%=trs.t("სისხლი")%></td>
                            <td><img src="img/code.png" alt="" style="height: 34px;"/></td>
                            <td>
                                <div class='smart-form'>
                                    <label class="select">
                                        <select class="poor">
                                            <option value="0"><%=trs.t("არადამაკმაყოფილებელი")%></option>
                                            <option value="1"><%=trs.t("დამაკმაყოფილებელი")%></option>
                                        </select><i></i>
                                        <b class="tooltip tooltip-top-right"><%=trs.t("ნიმუშის მდგომარეობა")%></b>
                                    </label>
                                </div>
                            </td>
                            <td>
                                <div class='smart-form'>
                                    <label class="select">
                                        <select>
                                            <option value="0"><%=trs.t("ადგილზე გამოსაკვლევი")%></option>
                                            <option value="1"><%=trs.t("ტრანზიტი")%></option>
                                        </select><i></i>
                                        <b class="tooltip tooltip-top-right"><%=trs.t("დანიშნულება")%></b>
                                    </label>
                                </div>
                            </td>
                            <td>
                                <button class="btn btn-default" onclick="hereModal()"><i class="fa fa-home"></i></button>
                                <button class="btn btn-warning"><i class="fa fa-pencil"></i></button>
                                <button class="btn btn-danger"><i class="fa fa-trash"></i></button>
                                <button class="btn btn-primary showcode"><i class="fa fa-print"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td>27651368</td>
                            <td><%=trs.t("სისხლი")%></td>
                            <td><img src="img/code.png" alt="" style="height: 34px;"/></td>
                            <td>
                                <div class='smart-form'>
                                    <label class="select">
                                        <select class="poor">
                                            <option value="0"><%=trs.t("არადამაკმაყოფილებელი")%></option>
                                            <option value="1"><%=trs.t("დამაკმაყოფილებელი")%></option>
                                        </select><i></i>
                                        <b class="tooltip tooltip-top-right"><%=trs.t("ნიმუშის მდგომარეობა")%></b>
                                    </label>
                                </div> 
                            </td>
                            <td>
                                <div class='smart-form'>
                                    <label class="select">
                                        <select>
                                            <option value="0"><%=trs.t("ადგილზე გამოსაკვლევი")%></option>
                                            <option value="1" selected=""><%=trs.t("ტრანზიტი")%></option>
                                        </select><i></i>
                                        <b class="tooltip tooltip-top-right"><%=trs.t("დანიშნულება")%></b>
                                    </label>
                                </div>
                            </td>
                            <td>
                                <button class="btn btn-default" onclick="transportModal()"><i class="fa fa-automobile"></i></button>
                                <button class="btn btn-warning"><i class="fa fa-pencil"></i></button>
                                <button class="btn btn-danger"><i class="fa fa-trash"></i></button>
                                <button class="btn btn-primary showcode"><i class="fa fa-print"></i></button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="hereModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ადგილზე გამოსაკვლევი")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
                    <div class="col-sm-12">
                        <section class="col col-sm-4">
                            <label class="select">
                                <select>
                                    <option value="0"><%=trs.t("- გადაეცა პირს -")%></option>
                                </select><i></i>
                                <b class="tooltip tooltip-top-right"><%=trs.t("გადაეცა პირს")%></b>
                            </label>
                        </section>
                        <section class="col col-sm-4">
                            <label class="select">
                                <select>
                                    <option value="0"><%=trs.t("- ლაბორატორია -")%></option>
                                </select><i></i>
                                <b class="tooltip tooltip-top-right"><%=trs.t("ლაბორატორია")%></b>
                            </label>
                        </section>
                        <section class="col col-sm-4">
                            <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                <input class="datepicker" placeholder="<%=trs.t("თარიღი")%>" type="text">
                                <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("თარიღი")%></b>
                            </label>
                        </section>
                        <section class="col col-sm-12">
                            <label class='label'><%=trs.t("კვლევა")%></label>
                            <label class="select">
                                <select class="onchange">
                                    <option value="0"><%=trs.t("- ყველა -")%></option>
                                    <option value="1"><%=trs.t("ადამიანის ნიმუშების კვლევა შავი ჭირის გამომწვევზე.")%></option>
                                    <option value="2"><%=trs.t("ადამიანის ნიმუშების კვლევა ჯილეხის გამომწვევზე.")%></option>
                                </select><i></i>
                            </label>
                        </section>
                        <section class="col col-sm-12 controls0">
                            <label class='label'><%=trs.t("ტესტები")%></label>
                            <label class="select">
                                <select class="test-list1">
                                    <option value="0"><%=trs.t("- აირჩიეთ -")%></option>
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
                        </section>
                        <section class="col col-sm-12 controls1" style="display: none;">
                            <label class='label'><%=trs.t("ტესტები")%></label>
                            <label class="select">
                                <select class="test-list2">
                                    <option value="0"><%=trs.t("- აირჩიეთ -")%></option>
                                    <option value="1"><%=trs.t("დათესვა SBA აგარზე.")%></option>
                                    <option value="2"><%=trs.t("დათესვა მაკ-კონკის  აგარზე.")%></option>
                                    <option value="3"><%=trs.t("დათესვა CIN აგარზე")%></option>
                                    <option value="4"><%=trs.t("დათესვა BHIB ბულიონში")%></option>
                                </select><i></i>
                            </label>
                        </section>
                        <section class="col col-sm-12 controls2" style="display: none;">
                            <label class='label'><%=trs.t("ტესტები")%></label>
                            <label class="select">
                                <select class="test-list3">
                                    <option value="0"><%=trs.t("- აირჩიეთ -")%></option>
                                    <option value="1"><%=trs.t("დათესვა PLET აგარზე.")%></option>
                                    <option value="2"><%=trs.t("ჩათესვა თხევად საკვებ ნიადაგში.")%></option>
                                    <option value="3"><%=trs.t("დათესვა SBA აგარზე.")%></option>
                                    <option value="4"><%=trs.t("დათესვა BHIB ბულიონში")%></option>
                                </select><i></i>
                            </label>
                        </section>
                        <section class="col col-sm-12">
                            <div id='test-list'>

                            </div>
                        </section>
                    </div>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("დახურვა")%>
                </button>
                <button type="button" class="btn btn-success" data-dismiss="modal">
                    <%=trs.t("დამახსოვრება")%>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="transportModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ტრანზიტი")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
                    <div class="col-sm-12">
                        <section class="col col-sm-4">
                            <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                                <input placeholder="<%=trs.t("დამცავი კონტეინერის N")%>" type="text">
                                <b class="tooltip tooltip-top-right"><i class="fa fa-list-ol txt-color-teal"></i> <%=trs.t("დამცავი კონტეინერის N")%></b>
                            </label>
                        </section>
                        <section class="col col-sm-4">
                            <label class="input"> <i class="icon-append fa fa-institution"></i>
                                <input placeholder="<%=trs.t("მიმღები დაწესებულება")%>" type="text">
                                <b class="tooltip tooltip-top-right"><i class="fa fa-institution txt-color-teal"></i> <%=trs.t("მიმღები დაწესებულება")%></b>
                            </label>
                        </section>
                        <section class="col col-sm-4">
                            <label class="input"> <i class="icon-append fa fa-home"></i>
                                <input placeholder="<%=trs.t("გამომკვლევი დაწესებულება")%>" type="text">
                                <b class="tooltip tooltip-top-right"><i class="fa fa-home txt-color-teal"></i> <%=trs.t("გამომკვლევი დაწესებულება")%></b>
                            </label>
                        </section>
                        <section class="col col-sm-12">
                            <label class="input"> <i class="icon-append fa fa-users"></i>
                                <input class="tagsinput" data-role="tagsinput" placeholder="<%=trs.t("ტრანსპ. პასუხისმგებელი პირები")%>" type="text" style="display: none;">
                                <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("ტრანსპ. პასუხისმგებელი პირები (სახელი, გვარი)")%></b>
                            </label>
                        </section>
                    </div>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("დახურვა")%>
                </button>
                <button type="button" class="btn btn-success" data-dismiss="modal">
                    <%=trs.t("დამახსოვრება")%>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="reasonModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("დაწუნება")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
                    <div class="col-sm-12">
                        <section class="col col-sm-12">
                            <label class="label"><%=trs.t("აირჩიეთ დაწუნების მიზეზი")%></label>
                            <label class="select">
                                <select>
                                    <option value="0"><%=trs.t("- აირჩიეთ მიზეზი -")%></option>
                                    <option value="1"><%=trs.t("ნიმუში არ არის მოთავსებული სატრანსპორტო კონტეინერში")%></option>
                                    <option value="2"><%=trs.t("ნიმუში არ არის მოთავსებული დამცავ კონტეინერში")%></option>
                                </select><i></i>
                            </label>
                        </section>
                    </div>
                    <div class="col-sm-12">
                        <section class="col col-sm-12">
                            <label class="label"><%=trs.t("შენიშვნა")%></label>
                            <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                                <textarea type="text"></textarea>
                            </label>
                        </section>
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
<script src="js/plugin/bootstrap-tags/bootstrap-tagsinput.min.js" type="text/javascript"></script>
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>
<script>
                                    pageSetUp();

                                    $("button").tooltip({
                                        container: 'body'
                                    });
                                    $(".mask").mask("99999999999");
                                    $(".datetime").datetimepicker({
                                        format: 'DD/MM/YYYY HH:mm'
                                    });
                                    $(document).on("change", "input[name='radio1']", function () {
                                        var id = $("input[name='radio1']:checked").attr('id');
                                        if (id == "radio1-1" || id == "radio1-2") {
                                            $(".control1").hide();
                                            $(".control2").hide();
                                            $(".control3").show();
                                        } else if (id == "radio1-3") {
                                            $(".control1").show();
                                            $(".control3").show();
                                        } else if (id == "radio1-4") {
                                            $(".control1").hide();
                                            $(".control3").show();
                                        }
                                    });
                                    $(document).on("input", "input[list='contragent']", function () {
                                        if ($("input[list='contragent']").val() != "") {
                                            $(".control4").show();
                                        } else {
                                            $(".control4").hide();
                                        }
                                    });
                                    $(document).on("change", "input[name='radio2']", function () {
                                        var id = $("input[name='radio2']:checked").attr('id');
                                        var topid = $("input[name='radio1']:checked").attr('id');
                                        if (topid != "radio1-4") {
                                            if (id == "radio2-1") {
                                                $(".control20").show();
                                                $(".control14").hide();

                                            } else if (id == "radio2-2") {
                                                $(".control20").hide();
                                                $(".control14").show();
                                            }
                                        } else {
                                            if (id == "radio2-1") {
                                                $(".control5").show();
                                                $(".control21").hide();
                                            } else if (id == "radio2-2") {
                                                $(".control20").hide();
                                                $(".control14").show();
                                                $(".control5").hide();
                                                getRegionAddress("2");
                                            }
                                        }

                                    });
                                    $(document).on("change", "input[name='checkbox1']", function () {
                                        if ($(this).is(":checked")) {
                                            $(".control7").show();
                                            $(".control6").hide();
                                        } else {
                                            $(".control7").hide();
                                            $(".control6").show();

                                        }
                                    });
                                    $(document).on("change", "input[name='radio3']", function () {
                                        var id = $("input[name='radio3']:checked").attr('id');
                                        if (id == "radio3-1") {
                                            $(".control8").show();
                                            $(".control9").hide();
                                            $(".control10").hide();
                                            $(".control11").show();
                                            $(".control12").show();
                                        } else if (id == "radio3-2") {
                                            $(".control8").hide();
                                            $(".control9").show();
                                            $(".control10").hide();
                                            $(".control11").show();
                                            $(".control12").show();
                                        } else if (id == "radio3-3") {
                                            $(".control8").hide();
                                            $(".control9").hide();
                                            $(".control10").show();
                                            $(".control11").show();
                                            $(".control12").show();
                                        }
                                    });
                                    function addbox() {
                                        $("#box-box").append('<div class="panel panel-default control12"> <div class="panel-body"> <div class="smart-form"> <div class="col-sm-12"> <section class="col col-sm-2"> <label class="input"> <i class="icon-append fa fa-list-ol"></i> <input placeholder="<%=trs.t("ნიმუშ(ებ)ის ჭურჭლის N")%>" type="text"> </label> </section> <section class="col col-sm-2"> <label class="select"> <select> <option value="0"><%=trs.t("- ნიმუშის ტიპი -")%></option> </select><i></i> </label> </section> <section class="col col-sm-2 hide1"> <label class="input"> <i class="icon-append fa fa-clock-o"></i> <input class="timepicker" placeholder="<%=trs.t("აღების დრო")%>" type="text"> </label> </section> <section class="col col-sm-2"> <label class="input"> <input name="analys" list="analys" type="text" value="" placeholder="<%=trs.t("საკვლევი პათოგენი")%>"> <datalist id="analys"> <option value="პათოგენი"></option> <option value="პათოგენი"></option> <option value="პათოგენი"></option> </datalist> </label> </section> <section class="col col-sm-2"> <label class="select"> <select class="select2 cust" multiple="" placeholder="<%=trs.t("მარკერი")%>"> <option value="0"><%=trs.t("მარკერი")%></option> <option value="0"><%=trs.t("მარკერი")%></option> </select> </label> </section> <section class="col col-sm-2"> <label class="select"> <select class="select2 cust" multiple="" placeholder="<%=trs.t("გამოკვლევის მეთოდი")%>"> <option value="0"><%=trs.t("მეთოდი")%></option> <option value="0"><%=trs.t("მეთოდი")%></option> </select> </label> </section> <section class="col col-sm-2"> <button class="btn btn-warning"><i class="fa fa-pencil"></i></button> <button class="btn btn-danger"><i class="fa fa-trash"></i></button> <button class="btn btn-primary showcode"><i class="fa fa-print"></i></button> <button class="btn btn-default"><i class="fa fa-copy"></i></button> </section> </div></div></div></div>');
                                        $("select.cust").select2("destroy").select2();
                                        $(".hide1").hide();
                                    }
                                    $(document).on("click", "#away", function () {
                                        $(".control13").show();
                                    });
                                    function hereModal() {
                                        $("#hereModal").modal("show");
                                    }
                                    function transportModal() {
                                        $("#transportModal").modal("show");
                                    }
                                    $(document).on("change", "input[name='checkbox2']", function () {
                                        if ($(this).is(":checked")) {
                                            $(".control15").show();
                                            $(".control16").hide();
                                        } else {
                                            $(".control16").show();
                                            $(".control15").hide();
                                        }
                                    });
                                    function addbox2() {
                                        $("#box-box2").append('<div class="panel panel-default control14"> <div class="panel-body"> <div class="smart-form"> <section class="col col-sm-2"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("შემსრულებელი ჯგუფის N")%>" type="text"> </label> </section> <section class="col col-sm-2"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("დამცავი კონტეინერის N")%>" type="text"> </label> </section> <section class="col col-sm-2"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("საკვლევი მასალა")%>" type="text"> </label> </section> <section class="col col-sm-2"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("ნიმუშის ჭურჭლის N")%>" type="text"> </label> </section> <section class="col col-sm-2"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input class="datetime" placeholder="<%=trs.t("ნიმუშის აღების თარიღი/დრო")%>" type="text"> </label> </section> <section class="col col-sm-2"> <button class="btn btn-warning"><i class="fa fa-pencil"></i></button> <button class="btn btn-danger"><i class="fa fa-trash"></i></button> <button class="btn btn-primary showcode"><i class="fa fa-print"></i></button> <button class="btn btn-default"><i class="fa fa-copy"></i></button> </section> </div></div></div>');
                                    }
                                    $(document).on("click", "#away2", function () {
                                        $(".control17").show();
                                    });
                                    $(document).on("change", "input[name='checkbox5']", function () {
                                        if ($(this).is(":checked")) {
                                            $(".control18").show();
                                        } else {
                                            $(".control18").hide();
                                        }
                                    });
                                    var currentdate = new Date();
                                    var datetime = currentdate.getDate() + "/"
                                            + ("0" + (currentdate.getMonth() + 1)).slice(-2) + "/"
                                            + currentdate.getFullYear() + " "
                                            + currentdate.getHours() + ":"
                                            + currentdate.getMinutes()
                                    $(".now").val(datetime);
                                    $(document).on("change", "input[name='radio5']", function () {
                                        var id = $("input[name='radio5']:checked").attr('id');
                                        if (id == "radio5-1") {
                                            $(".control5").show();
                                            $(".control21").hide();
                                            getRegionAddress("1");
                                        } else if (id == "radio5-2") {
                                            $(".control5").hide();
                                            $(".control21").show();
                                            getRegionAddress("0");
                                        }
                                    });
                                    $(document).on("change", "input[name='checkbox3']", function () {
                                        if ($(this).is(":checked")) {
                                            $(".control23").show();
                                            $(".control22").hide();
                                        } else {
                                            $(".control22").show();
                                            $(".control23").hide();
                                        }
                                    });
                                    function addbox3() {
                                        $("#box-box3").append('<div class="panel panel-default control21"> <div class="panel-body"> <div class="smart-form"> <div class="col-sm-12"> <section class="col col-sm-2"> <label class="input"> <i class="icon-append fa fa-user"></i> <input placeholder="<%=trs.t("სახელი")%>" type="text"> </label> </section> <section class="col col-sm-2"> <label class="input"> <i class="icon-append fa fa-user"></i> <input placeholder="<%=trs.t("გვარი")%>" type="text"> </label> </section> <section class="col col-sm-2 control22"> <label class="input"> <i class="icon-append fa fa-list-ol"></i> <input placeholder="<%=trs.t("ნიმუშ(ებ)ის ჭურჭლის N")%>" type="text"> </label> </section> <section class="col col-sm-2 control22"> <label class="select"> <select> <option value="0"><%=trs.t("- ნიმუშის ტიპი -")%></option> </select><i></i> </label> </section> <section class="col col-sm-2"> <label class="select"> <select class="select2 cust" multiple="" placeholder="<%=trs.t("გამოკვლევის მეთოდი")%>"> <option value="0"><%=trs.t("მეთოდი")%></option> <option value="0"><%=trs.t("მეთოდი")%></option> </select> </label> </section> <section class="col col-sm-2"> <button class="btn btn-warning"><i class="fa fa-pencil"></i></button> <button class="btn btn-danger"><i class="fa fa-trash"></i></button> <button class="btn btn-primary showcode"><i class="fa fa-print"></i></button> <button class="btn btn-default"><i class="fa fa-copy"></i></button> </section> </div></div></div></div>');
                                        $("select.cust").select2("destroy").select2();
                                    }
                                    $(document).on("change", "#country", function () {
                                        if ($(this).val() != "1") {
                                            $(".notgeo").hide();
                                        } else {
                                            $(".notgeo").show();
                                        }
                                    });
                                    $(document).on("change", "input[name='checkbox4']", function () {
                                        if ($(this).is(":checked")) {
                                            $(".control24").show();
                                        } else {
                                            $(".control24").hide();
                                        }
                                    });
                                    function ShowView() {
                                        $(".view-panel").fadeIn("slow");
                                        $(".register-panel").hide();
                                        $(".btn2.preview").hide();
                                        $(".btn2.edit").show();
                                    }
                                    function HideView() {
                                        $(".view-panel").hide();
                                        $(".register-panel").fadeIn("slow");
                                        $(".btn2.preview").show();
                                        $(".btn2.edit").hide();
                                    }
                                    ;
                                    function getRegionAddress(sf) {
                                        $("#addressselect").hide();
                                        getTunit("regionselect" + sf, "<%=trs.t("რეგიონი")%>", 0, 0, "regionid", "<%=trs.t("რეგიონის დასახელება")%>", sf);
                                    }
                                    ;
                                    $(".tip").tooltip({
                                        container: 'body'
                                    });
                                    $(document).on("change", ".onchange", function () {
                                        var val = $(".onchange option:selected").html();
                                        if ($(this).val() == "0") {
                                            $(".controls0").show();
                                            $(".controls1").hide();
                                            $(".controls2").hide();
                                        } else if ($(this).val() == "1") {
                                            $(".controls0").hide();
                                            $(".controls1").show();
                                            $(".controls2").hide();
                                        } else if ($(this).val() == "2") {
                                            $(".controls0").hide();
                                            $(".controls1").hide();
                                            $(".controls2").show();
                                        }
                                        $("#test-list").append('<div class="full"><span class="chtest">' + val + '<i class="fa fa-times"></i></span></div>');
                                    });
                                    $(document).on("change", ".test-list1", function () {
                                        var val = $(".test-list1 option:selected").html();
                                        $("#test-list").append('<span class="chtest">' + val + '<i class="fa fa-times"></i></span>');
                                    });
                                    $(document).on("change", ".test-list2", function () {
                                        var val = $(".test-list2 option:selected").html();
                                        $("#test-list").append('<span class="chtest">' + val + '<i class="fa fa-times"></i></span>');
                                    });
                                    $(document).on("change", ".test-list3", function () {
                                        var val = $(".test-list3 option:selected").html();
                                        $("#test-list").append('<span class="chtest">' + val + '<i class="fa fa-times"></i></span>');
                                    });
                                    $(document).on("change", ".poor", function () {
                                        if ($(this).val() == "0") {
                                            $("#reasonModal").modal("show");
                                        }
                                    });
</script>