<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
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
                <section class="col col-sm-12 control3" style="display: none;">
                    <div class="input-group">
                        <label class="input"> <i class="icon-append fa fa-institution"></i>
                            <input list="contragent" placeholder="<%=trs.t("დამკვეთი")%>" type="text">
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
                <section class="col col-sm-12 control1" style="display: none;">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- პროგრამა/პროექტი -")%></option>
                            <option value="1"><%=trs.t("C-ჰეპატიტი")%></option>
                            <option value="2"><%=trs.t("შიდსი")%></option>
                        </select><i></i>
                    </label>
                </section>
                <section class="col col-sm-12 control4" style="display: none;">
                    <label class="label"><%=trs.t("ნიმუშის ტიპი:")%></label>
                    <div class="inline-group">
                        <label class="radio">
                            <input id="radio2-1" name="radio2" type="radio">
                            <i></i><%=trs.t("კლინიკური")%></label>
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
    <div class="panel-body">
        <div class="smart-form">
            <div class="col-sm-12">
                <section class="col col-sm-12">
                    <div class="input-group">
                        <label class="input"> <i class="icon-append fa fa-id-card"></i>
                            <input class="mask" placeholder="<%=trs.t("პირადი N")%>" type="text">
                        </label>
                        <div class="input-group-btn">
                            <button class="btn btn-success" data-original-title="<%=trs.t("შემოწმება")%>" type="button">
                                <i class="fa fa-check"></i>
                            </button>
                        </div>
                    </div>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-user"></i>
                        <input placeholder="<%=trs.t("სახელი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-user"></i>
                        <input placeholder="<%=trs.t("გვარი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- სქესი -")%></option>
                        </select><i></i>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-calendar"></i>
                        <input class="datepicker" placeholder="<%=trs.t("დაბადების თარიღი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- ქვეყანა -")%></option>
                            <option selected="" value="1"><%=trs.t("საქართველო")%></option>
                        </select><i></i>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- რეგიონი -")%></option>
                        </select><i></i>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- რაიონი -")%></option>
                        </select><i></i>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- ქალაქი/სოფელი -")%></option>
                        </select><i></i>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-map-marker"></i>
                        <input placeholder="<%=trs.t("მისამართი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-fax"></i>
                        <input placeholder="<%=trs.t("საფოსტო ინდექსი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-envelope"></i>
                        <input placeholder="<%=trs.t("ელ-ფოსტა")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="checkbox">
                        <input name="checkbox3" type="checkbox">
                        <i></i><%=trs.t("სინჯია")%></label>
                </section>
                <section class="col col-sm-12 control22">
                    <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                        <input placeholder="<%=trs.t("ნიმუშ(ებ)ის ჭურჭლის N")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12 control22">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- ნიმუშის ტიპი -")%></option>
                        </select><i></i>
                    </label>
                </section>
                <section class="col col-sm-12 control22">
                    <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                        <input class="datetime" placeholder="<%=trs.t("აღების თარიღი/დრო")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12 control23" style="display: none;">
                    <label class="input"> <i class="icon-append fa fa-eyedropper"></i>
                        <input placeholder="<%=trs.t("სინჯის ტიპი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12 control23" style="display: none;">
                    <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                        <input placeholder="<%=trs.t("საიდენტიფიკაციო N")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12 control23" style="display: none;">
                    <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                        <input class="datetime" placeholder="<%=trs.t("დამზადების თარიღი/დრო")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> 
                        <input name="analys" list='analys3' type="text" value="" placeholder="<%=trs.t("საკვლევი პათოგენი")%>">
                        <datalist id="analys3">
                            <option value="პათოგენი"></option>
                            <option value="პათოგენი"></option>
                            <option value="პათოგენი"></option>
                        </datalist>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("მარკერი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="select">
                        <select class="select2" multiple="" placeholder="<%=trs.t("გამოკვლევის მეთოდი")%>">
                            <option value="0"><%=trs.t("მეთოდი")%></option>
                            <option value="0"><%=trs.t("მეთოდი")%></option>
                        </select>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <button class="btn btn-success" onclick="addbox3()"><i class="fa fa-plus"></i></button>
                    <button class="btn btn-warning"><i class="fa fa-pencil"></i></button>
                    <button class="btn btn-danger"><i class="fa fa-trash"></i></button>
                    <button class="btn btn-primary showcode"><i class="fa fa-print"></i></button>
                    <button class="btn btn-default"><i class="fa fa-copy"></i></button>
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
                <section class="col col-sm-12 control7" style="display: none;">
                    <label class="input"> <i class="icon-append fa fa-code"></i>
                        <input placeholder="<%=trs.t("პასპორტის N")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12 control7" style="display: none;">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- მოქალაქეობა -")%></option>
                        </select><i></i>
                    </label>
                </section>
                <section class="col col-sm-12 control6">
                    <div class="input-group">
                        <label class="input"> <i class="icon-append fa fa-id-card"></i>
                            <input class="mask" placeholder="<%=trs.t("პირადი N")%>" type="text">
                        </label>
                        <div class="input-group-btn">
                            <button class="btn btn-success" data-original-title="<%=trs.t("შემოწმება")%>" type="button">
                                <i class="fa fa-check"></i>
                            </button>
                        </div>
                    </div>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-user"></i>
                        <input placeholder="<%=trs.t("სახელი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-user"></i>
                        <input placeholder="<%=trs.t("გვარი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-calendar"></i>
                        <input class="datepicker" placeholder="<%=trs.t("დაბადების თარიღი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- სქესი -")%></option>
                        </select><i></i>
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
                <section class="col col-sm-12">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- ქვეყანა -")%></option>
                            <option selected="" value="1"><%=trs.t("საქართველო")%></option>
                        </select><i></i>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- რეგიონი -")%></option>
                        </select><i></i>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- რაიონი -")%></option>
                        </select><i></i>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- ქალაქი/სოფელი -")%></option>
                        </select><i></i>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-map-marker"></i>
                        <input placeholder="<%=trs.t("მისამართი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-fax"></i>
                        <input placeholder="<%=trs.t("საფოსტო ინდექსი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-phone"></i>
                        <input placeholder="<%=trs.t("ტელეფონი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-envelope"></i>
                        <input placeholder="<%=trs.t("ელ-ფოსტა")%>" type="text">
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
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-calendar"></i>
                        <input class="datepicker" placeholder="<%=trs.t("კლინიკური სიმპტომების დაწყების თარიღი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-pencil-square-o"></i>
                        <input placeholder="<%=trs.t("წინასწარი კლინიკური დიაგნოზი")%>" type="text">
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
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-calendar"></i>
                        <input class="datepicker" placeholder="<%=trs.t("გარდაცვალების თარიღი")%>" type="text">
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
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-pencil-square-o"></i>
                        <input placeholder="<%=trs.t("დასახელება")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                        <input placeholder="<%=trs.t("საიდენტიფიკაციო N")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                        <input class="datetime" placeholder="<%=trs.t("დათესვის თარიღი/დრო")%>" type="text">
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
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                        <input placeholder="<%=trs.t("დამცავი კონტეინერის N")%>" type="text">
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
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-calendar"></i>
                        <input class="datepicker" placeholder="<%=trs.t("ნიმუშ(ებ)ის აღების თარიღი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("ნიმუშ(ებ)ის აღების ადგილი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-users"></i>
                        <input class="tagsinput" data-role="tagsinput" placeholder="<%=trs.t("ამღები პირები")%>" type="text" style="display: none;">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-eyedropper"></i>
                        <input placeholder="<%=trs.t("სინჯის დასახელება")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                        <input placeholder="<%=trs.t("საიდენტიფიკაციო N")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                        <input class="datetime" placeholder="<%=trs.t("დამზადების თარიღი/დრო")%>" type="text">
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
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                        <input placeholder="<%=trs.t("ნიმუშ(ებ)ის ჭურჭლის N")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- ნიმუშის ტიპი -")%></option>
                        </select><i></i>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                        <input class="timepicker" placeholder="<%=trs.t("აღების დრო")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> 
                        <input name="analys" list='analys' type="text" value="" placeholder="<%=trs.t("საკვლევი პათოგენი")%>">
                        <datalist id="analys">
                            <option value="პათოგენი"></option>
                            <option value="პათოგენი"></option>
                            <option value="პათოგენი"></option>
                        </datalist>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("მარკერი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="select">
                        <select class="select2" multiple="" placeholder="<%=trs.t("გამოკვლევის მეთოდი")%>">
                            <option value="0"><%=trs.t("მეთოდი")%></option>
                            <option value="0"><%=trs.t("მეთოდი")%></option>
                        </select>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <button class="btn btn-success" onclick="addbox()"><i class="fa fa-plus"></i></button>
                    <button class="btn btn-warning"><i class="fa fa-pencil"></i></button>
                    <button class="btn btn-danger"><i class="fa fa-trash"></i></button>
                    <button class="btn btn-primary showcode"><i class="fa fa-print"></i></button>
                    <button class="btn btn-default"><i class="fa fa-copy"></i></button>
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
                <section class="col col-sm-12">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- მიმღები დაწესებულება -")%></option>
                        </select><i></i>
                    </label>
                </section>
                <section class="col col-sm-12 control21" style="display: none;">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("დამცავი კონტეინერის N")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- გამომკვლევი დაწესებულება -")%></option>
                        </select><i></i>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("შევსებაზე პასუხისმგებელი პირის სახელი, გვარი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input class="datetime" placeholder="<%=trs.t("გაგზავნის თარიღი/დრო")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("ტელეფონის ნომერი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-users"></i>
                        <input class="tagsinput" data-role="tagsinput" placeholder="<%=trs.t("ტრანსპ. პასუხისმგებელი პირები")%>" type="text" style="display: none;">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <button class="btn btn-success" id="away"><%=trs.t("გადაგზავნა")%></button>
                </section>
            </div>
        </div>
    </div>
</div>
<div class="panel panel-default control13" style="display: none;">
    <div class="panel-body">
        <div class="smart-form">
            <div class="col-sm-12">
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input disabled='' class="datetime now" placeholder="<%=trs.t("მიღების თარიღი/დრო")%>" type="text">
                    </label>
                </section>
            </div>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ნიმუშ(ებ)ის ჭურჭლის N</th>
                        <th>ნიმუშის ტიპი</th>
                        <th>შტრიხკოდი</th>
                        <th>მდგომარეობა</th>
                        <th>დანიშნულება</th>
                        <th>მოქმედება</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>27651283</td>
                        <td>სისხლი</td>
                        <td><img src="img/code.png" alt="" style="height: 34px;"/></td>
                        <td>
                            <div class='smart-form'>
                                <label class="select">
                                    <select>
                                        <option value="0"><%=trs.t("არადამაკმაყოფილებელი")%></option>
                                        <option value="1"><%=trs.t("დამაკმაყოფილებელი")%></option>
                                    </select><i></i>
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
                        <td>სისხლი</td>
                        <td><img src="img/code.png" alt="" style="height: 34px;"/></td>
                        <td>
                            <div class='smart-form'>
                                <label class="select">
                                    <select>
                                        <option value="0"><%=trs.t("არადამაკმაყოფილებელი")%></option>
                                        <option value="1"><%=trs.t("დამაკმაყოფილებელი")%></option>
                                    </select><i></i>
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
<div class="panel panel-default control14" style="display: none;">
    <div class="panel-body">
        <div class="smart-form">
            <section class="col col-sm-12">
                <label class="checkbox">
                    <input name="checkbox2" type="checkbox">
                    <i></i><%=trs.t("სინჯია")%></label>
            </section>
            <div class="col-sm-12">
                <section class="col col-sm-12">
                    <div class="inline-group">
                        <label class="radio">
                            <input id="radio4-1" name="radio4" type="radio" checked="">
                            <i></i><%=trs.t("GPS კოორდინატები")%></label>
                        <label class="radio">
                            <input id="radio4-2" name="radio4" type="radio">
                            <i></i><%=trs.t("მისამართი")%></label>
                    </div>
                </section>
            </div>
            <section class="col col-sm-12 control18" style="padding: 0;">
                <section class="col col-md-2 col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("N")%>" type="text">
                    </label>
                </section>
                <section class="col col-md-2 col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("E")%>" type="text">
                    </label>
                </section>
                <section class="col col-md-2 col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("F(მ)")%>" type="text">
                    </label>
                </section>
            </section>
            <section class="col col-sm-12">
                <label class="select">
                    <select>
                        <option value="0"><%=trs.t("- ქვეყანა -")%></option>
                        <option selected="" value="1"><%=trs.t("საქართველო")%></option>
                    </select><i></i>
                </label>
            </section>
            <section class="col col-sm-12">
                <label class="select">
                    <select>
                        <option value="0"><%=trs.t("- რეგიონი -")%></option>
                    </select><i></i>
                </label>
            </section>
            <section class="col col-sm-12">
                <label class="select">
                    <select>
                        <option value="0"><%=trs.t("- რაიონი -")%></option>
                    </select><i></i>
                </label>
            </section>
            <section class="col col-sm-12">
                <label class="select">
                    <select>
                        <option value="0"><%=trs.t("- ქალაქი/სოფელი -")%></option>
                    </select><i></i>
                </label>
            </section>
            <section class="col col-sm-12">
                <label class="input"> <i class="icon-append fa fa-map-marker"></i>
                    <input placeholder="<%=trs.t("მისამართი")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12 control19" style="display: none;">
                <label class="input"> <i class="icon-append fa fa-globe"></i>
                    <input placeholder="<%=trs.t("აღების ადგილი")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12 control19" style="display: none;">
                <label class="input"> <i class="icon-append fa fa-globe"></i>
                    <input placeholder="<%=trs.t("დასახელება")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12 control19" style="display: none;">
                <label class="input"> <i class="icon-append fa fa-globe"></i>
                    <input placeholder="<%=trs.t("ტელეფონი")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12 control19" style="display: none;">
                <label class="input"> <i class="icon-append fa fa-globe"></i>
                    <input placeholder="<%=trs.t("საფოსტო კოდი")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12 control19" style="display: none;">
                <label class="input"> <i class="icon-append fa fa-globe"></i>
                    <input placeholder="<%=trs.t("ელ-ფოსტა")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12 control15" style="display: none;">
                <label class="input"> <i class="icon-append fa fa-globe"></i>
                    <input placeholder="<%=trs.t("საიდენტიფიკაციო N")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12 control15" style="display: none;">
                <label class="input"> <i class="icon-append fa fa-globe"></i>
                    <input placeholder="<%=trs.t("დასახელება")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12 control15" style="display: none;">
                <label class="input"> <i class="icon-append fa fa-globe"></i>
                    <input class="datepicker" placeholder="<%=trs.t("დამზადების თარიღი")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12 control16">
                <label class="input"> <i class="icon-append fa fa-globe"></i>
                    <input placeholder="<%=trs.t("შემსრულებელი ჯგუფის N")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12 control16">
                <label class="input"> <i class="icon-append fa fa-globe"></i>
                    <input placeholder="<%=trs.t("წერტილის N")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12 control16">
                <label class="select">
                    <select>
                        <option value="0"><%=trs.t("- სტაცია -")%></option>
                        <option value="1"><%=trs.t("ღია")%></option>
                        <option value="2"><%=trs.t("დახურული")%></option>
                    </select><i></i>
                </label>
            </section>
            <section class="col col-sm-12 control16">
                <label class="input"> <i class="icon-append fa fa-globe"></i>
                    <input placeholder="<%=trs.t("დასახელება")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12 control16">
                <label class="input"> <i class="icon-append fa fa-globe"></i>
                    <input placeholder="<%=trs.t("რაოდენობა")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12">
                <label class="input"> <i class="icon-append fa fa-globe"></i>
                    <input placeholder="<%=trs.t("დამცავი კონტეინერის N")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12">
                <label class="select">
                    <select>
                        <option value="0"><%=trs.t("- საკვლევი მასალის დასახელება -")%></option>
                    </select><i></i>
                </label>
            </section>
            <section class="col col-sm-12 control16">
                <label class="input"> <i class="icon-append fa fa-globe"></i>
                    <input placeholder="<%=trs.t("ნიმუშის ჭურჭლის N")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12 control16">
                <label class="input"> <i class="icon-append fa fa-globe"></i>
                    <input class="datetime" placeholder="<%=trs.t("ნიმუშის აღების თარიღი/დრო")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12 control16">
                <label class="input"> <i class="icon-append fa fa-globe"></i>
                    <input placeholder="<%=trs.t("გადახრის კუთხე")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12 control16">
                <label class="input"> <i class="icon-append fa fa-globe"></i>
                    <input placeholder="<%=trs.t("მანძილი მეტრებში")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12">
                <label class="input"> <i class="icon-append fa fa-globe"></i>
                    <input placeholder="<%=trs.t("საკვლევი პათაგონი")%>" type="text">
                </label>
            </section>
            <section class="col col-sm-12">
                <label class="select">
                    <select>
                        <option value="0"><%=trs.t("- გამოკვლევის მეთოდი -")%></option>
                    </select><i></i>
                </label>
            </section>
            <section class="col col-sm-12">
                <button class="btn btn-success" onclick="addbox2()"><i class="fa fa-plus"></i></button>
                <button class="btn btn-warning"><i class="fa fa-pencil"></i></button>
                <button class="btn btn-danger"><i class="fa fa-trash"></i></button>
                <button class="btn btn-primary showcode"><i class="fa fa-print"></i></button>
                <button class="btn btn-default"><i class="fa fa-copy"></i></button>
            </section>
        </div>
    </div>
</div>
<div id="box-box2"></div>
<div class="panel panel-default control14" style="display: none;">
    <div class="panel-body">
        <div class="smart-form">
            <div class="col-sm-12">
                <section class="col col-sm-12">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- მიმღები დაწესებულება -")%></option>
                        </select><i></i>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="select">
                        <select>
                            <option value="0"><%=trs.t("- გამომკვლევი დაწესებულება -")%></option>
                        </select><i></i>
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("შევსებაზე პასუხისმგებელი პირის სახელი, გვარი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input class="datetime" placeholder="<%=trs.t("გაგზავნის თარიღი/დრო")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("ტელეფონის ნომერი")%>" type="text">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-users"></i>
                        <input class="tagsinput" data-role="tagsinput" placeholder="<%=trs.t("ტრანსპ. პასუხისმგებელი პირები")%>" type="text" style="display: none;">
                    </label>
                </section>
                <section class="col col-sm-12">
                    <button class="btn btn-success" id="away2"><%=trs.t("გადაგზავნა")%></button>
                </section>
            </div>
        </div>
    </div>
</div>
<div class="panel panel-default control17" style="display: none;">
    <div class="panel-body">
        <div class="smart-form">
            <div class="col-sm-12">
                <section class="col col-sm-12">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input disabled='' class="datetime now" placeholder="<%=trs.t("მიღების თარიღი/დრო")%>" type="text">
                    </label>
                </section>
            </div>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ნიმუშ(ებ)ის ჭურჭლის N</th>
                        <th>ნიმუშის ტიპი</th>
                        <th>შტრიხკოდი</th>
                        <th>მდგომარეობა</th>
                        <th>დანიშნულება</th>
                        <th>მოქმედება</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>27651283</td>
                        <td>სისხლი</td>
                        <td><img src="img/code.png" alt="" style="height: 34px;"/></td>
                        <td>
                            <div class='smart-form'>
                                <label class="select">
                                    <select>
                                        <option value="0"><%=trs.t("არადამაკმაყოფილებელი")%></option>
                                        <option value="1"><%=trs.t("დამაკმაყოფილებელი")%></option>
                                    </select><i></i>
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
                        <td>სისხლი</td>
                        <td><img src="img/code.png" alt="" style="height: 34px;"/></td>
                        <td>
                            <div class='smart-form'>
                                <label class="select">
                                    <select>
                                        <option value="0"><%=trs.t("არადამაკმაყოფილებელი")%></option>
                                        <option value="1"><%=trs.t("დამაკმაყოფილებელი")%></option>
                                    </select><i></i>
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
                        <section class="col col-sm-12">
                            <label class="select">
                                <select>
                                    <option value="0"><%=trs.t("- გადაეცა პირს -")%></option>
                                </select><i></i>
                            </label>
                        </section>
                        <section class="col col-sm-12">
                            <label class="select">
                                <select>
                                    <option value="0"><%=trs.t("- ლაბორატორია -")%></option>
                                </select><i></i>
                            </label>
                        </section>
                        <section class="col col-sm-12">
                            <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                <input class="datepicker" placeholder="<%=trs.t("თარიღი")%>" type="text">
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
                        <section class="col col-sm-12">
                            <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                                <input placeholder="<%=trs.t("დამცავი კონტეინერის N")%>" type="text">
                            </label>
                        </section>
                        <section class="col col-sm-12">
                            <label class="input"> <i class="icon-append fa fa-institution"></i>
                                <input placeholder="<%=trs.t("მიმღები დაწესებულება")%>" type="text">
                            </label>
                        </section>
                        <section class="col col-sm-12">
                            <label class="input"> <i class="icon-append fa fa-home"></i>
                                <input placeholder="<%=trs.t("გამომკვლევი დაწესებულება")%>" type="text">
                            </label>
                        </section>
                        <section class="col col-sm-12">
                            <label class="input"> <i class="icon-append fa fa-users"></i>
                                <input class="tagsinput" data-role="tagsinput" placeholder="<%=trs.t("ტრანსპ. პასუხისმგებელი პირები")%>" type="text" style="display: none;">
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
                                    if (id == "radio2-1") {
                                        $(".control20").show();
                                        $(".control14").hide();
                                    } else if (id == "radio2-2") {
                                        $(".control20").hide();
                                        $(".control14").show();
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
                                    $("#box-box").append('<div class="panel panel-default control12"><div class="panel-body"><div class="smart-form"><div class="col-sm-12"><section class="col col-sm-12"><label class="input"> <i class="icon-append fa fa-list-ol"> </i><input placeholder="<%=trs.t("ნიმუშ(ებ)ის ჭურჭლის N")%>" type="text"></label></section><section class="col col-sm-12"><label class="select"><select><option value="0"><%=trs.t("- ნიმუშის ტიპი -")%> </option></select><i></i></label></section><section class="col col-sm-12"><label class="input"> <i class="icon-append fa fa-clock-o"> </i><input class="timepicker" placeholder="<%=trs.t("აღების დრო")%>" type="text"></label></section><section class="col col-sm-12"><label class="input"><input name="analys2" list="analys2" type="text" value="" placeholder="<%=trs.t("საკვლევი პათოგენი")%>"><datalist id="analys2"><option value="პათოგენი"> </option></datalist></label></section><section class="col col-sm-12"><label class="input"> <i class="icon-append fa fa-globe"> </i><input placeholder="<%=trs.t("მარკერი")%>" type="text"></label></section><section class="col col-sm-12"><label class="select"><select class="select2 cust" multiple="" placeholder="<%=trs.t("გამოკვლევის მეთოდი")%>"><option value="0"><%=trs.t("მეთოდი")%> </option><option value="0"><%=trs.t("მეთოდი")%> </option></select></label> </section><section class="col col-sm-12"><button class="btn btn-success" onclick="addbox()"> <i class="fa fa-plus"> </i></button> <button class="btn btn-warning"> <i class="fa fa-pencil"> </i></button> <button class="btn btn-danger"> <i class="fa fa-trash"> </i></button> <button class="btn btn-primary showcode"> <i class="fa fa-print"> </i></button> <button class="btn btn-default"> <i class="fa fa-copy"> </i></button> </section> </div> </div></div> </div>');
                                    $("select.cust").select2("destroy").select2();
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
                                    $("#box-box2").append('<div class="panel panel-default control14"> <div class="panel-body"> <div class="smart-form"> <section class="col col-sm-12"> <label class="checkbox"> <input name="checkbox2" type="checkbox"> <i></i><%=trs.t("სინჯია")%></label> </section> <div class="col-sm-12"> <section class="col col-sm-12"> <div class="inline-group"> <label class="radio"> <input id="radio4-1" name="radio4" type="radio" checked=""> <i></i><%=trs.t("GPS კოორდინატები")%></label> <label class="radio"> <input id="radio4-2" name="radio4" type="radio"> <i></i><%=trs.t("კვლევის ობიექტი")%></label> </div></section> </div><section class="col col-sm-12 control18" style="padding: 0;"> <section class="col col-md-2 col-sm-12"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("N")%>" type="text"> </label> </section> <section class="col col-md-2 col-sm-12"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("E")%>" type="text"> </label> </section> <section class="col col-md-2 col-sm-12"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("F(მ)")%>" type="text"> </label> </section> </section> <section class="col col-sm-12"> <label class="select"> <select> <option value="0"><%=trs.t("- ქვეყანა -")%></option> <option selected="" value="1"><%=trs.t("საქართველო")%></option> </select><i></i> </label> </section> <section class="col col-sm-12"> <label class="select"> <select> <option value="0"><%=trs.t("- რეგიონი -")%></option> </select><i></i> </label> </section> <section class="col col-sm-12"> <label class="select"> <select> <option value="0"><%=trs.t("- რაიონი -")%></option> </select><i></i> </label> </section> <section class="col col-sm-12"> <label class="select"> <select> <option value="0"><%=trs.t("- ქალაქი/სოფელი -")%></option> </select><i></i> </label> </section> <section class="col col-sm-12"> <label class="input"> <i class="icon-append fa fa-map-marker"></i> <input placeholder="<%=trs.t("მისამართი")%>" type="text"> </label> </section> <section class="col col-sm-12 control19" style="display: none;"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("აღების ადგილი")%>" type="text"> </label> </section> <section class="col col-sm-12 control19" style="display: none;"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("დასახელება")%>" type="text"> </label> </section> <section class="col col-sm-12 control19" style="display: none;"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("ტელეფონი")%>" type="text"> </label> </section> <section class="col col-sm-12 control19" style="display: none;"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("საფოსტო კოდი")%>" type="text"> </label> </section> <section class="col col-sm-12 control19" style="display: none;"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("ელ-ფოსტა")%>" type="text"> </label> </section> <section class="col col-sm-12 control15" style="display: none;"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("საიდენტიფიკაციო N")%>" type="text"> </label> </section> <section class="col col-sm-12 control15" style="display: none;"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("დასახელება")%>" type="text"> </label> </section> <section class="col col-sm-12 control15" style="display: none;"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input class="datepicker" placeholder="<%=trs.t("დამზადების თარიღი")%>" type="text"> </label> </section> <section class="col col-sm-12 control16"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("შემსრულებელი ჯგუფის N")%>" type="text"> </label> </section> <section class="col col-sm-12 control16"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("წერტილის N")%>" type="text"> </label> </section> <section class="col col-sm-12 control16"> <label class="select"> <select> <option value="0"><%=trs.t("- სტაცია -")%></option> <option value="1"><%=trs.t("ღია")%></option> <option value="2"><%=trs.t("დახურული")%></option> </select><i></i> </label> </section> <section class="col col-sm-12 control16"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("დასახელება")%>" type="text"> </label> </section> <section class="col col-sm-12 control16"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("რაოდენობა")%>" type="text"> </label> </section> <section class="col col-sm-12"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("დამცავი კონტეინერის N")%>" type="text"> </label> </section> <section class="col col-sm-12"> <label class="select"> <select> <option value="0"><%=trs.t("- საკვლევი მასალის დასახელება -")%></option> </select><i></i> </label> </section> <section class="col col-sm-12 control16"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("ნიმუშის ჭურჭლის N")%>" type="text"> </label> </section> <section class="col col-sm-12 control16"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input class="datetime" placeholder="<%=trs.t("ნიმუშის აღების თარიღი/დრო")%>" type="text"> </label> </section> <section class="col col-sm-12 control16"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("გადახრის კუთხე")%>" type="text"> </label> </section> <section class="col col-sm-12 control16"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("მანძილი მეტრებში")%>" type="text"> </label> </section> <section class="col col-sm-12"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("საკვლევი პათაგონი")%>" type="text"> </label> </section> <section class="col col-sm-12"> <label class="select"> <select> <option value="0"><%=trs.t("- გამოკვლევის მეთოდი -")%></option> </select><i></i> </label> </section> <section class="col col-sm-12"> <button class="btn btn-success" onclick="addbox2()"><i class="fa fa-plus"></i></button> <button class="btn btn-warning"><i class="fa fa-pencil"></i></button> <button class="btn btn-danger"><i class="fa fa-trash"></i></button> <button class="btn btn-primary showcode"><i class="fa fa-print"></i></button> <button class="btn btn-default"><i class="fa fa-copy"></i></button> </section> </div></div></div>');
                                }
                                $(document).on("click", "#away2", function () {
                                    $(".control17").show();
                                });
                                $(document).on("change", "input[name='radio4']", function () {
                                    var id = $("input[name='radio4']:checked").attr('id');
                                    if (id == "radio4-1") {
                                        $(".control18").show();
                                        $(".control19").hide();
                                    } else {
                                        $(".control18").hide();
                                        $(".control19").show();
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
                                    } else if (id == "radio5-2") {
                                        $(".control5").hide();
                                        $(".control21").show();
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
                                    $("#box-box3").append('<div class="panel panel-default control21"> <div class="panel-body"> <div class="smart-form"> <div class="col-sm-12"> <section class="col col-sm-12"> <div class="input-group"> <label class="input"> <i class="icon-append fa fa-id-card"></i> <input class="mask" placeholder="<%=trs.t("პირადი N")%>" type="text"> </label> <div class="input-group-btn"> <button class="btn btn-success" data-original-title="<%=trs.t("შემოწმება")%>" type="button"> <i class="fa fa-check"></i> </button> </div></div></section> <section class="col col-sm-12"> <label class="input"> <i class="icon-append fa fa-user"></i> <input placeholder="<%=trs.t("სახელი")%>" type="text"> </label> </section> <section class="col col-sm-12"> <label class="input"> <i class="icon-append fa fa-user"></i> <input placeholder="<%=trs.t("გვარი")%>" type="text"> </label> </section> <section class="col col-sm-12"> <label class="select"> <select> <option value="0"><%=trs.t("- სქესი -")%></option> </select><i></i> </label> </section> <section class="col col-sm-12"> <label class="input"> <i class="icon-append fa fa-calendar"></i> <input class="datepicker" placeholder="<%=trs.t("დაბადების თარიღი")%>" type="text"> </label> </section> <section class="col col-sm-12"> <label class="select"> <select> <option value="0"><%=trs.t("- ქვეყანა -")%></option> <option selected="" value="1"><%=trs.t("საქართველო")%></option> </select><i></i> </label> </section> <section class="col col-sm-12"> <label class="select"> <select> <option value="0"><%=trs.t("- რეგიონი -")%></option> </select><i></i> </label> </section> <section class="col col-sm-12"> <label class="select"> <select> <option value="0"><%=trs.t("- რაიონი -")%></option> </select><i></i> </label> </section> <section class="col col-sm-12"> <label class="select"> <select> <option value="0"><%=trs.t("- ქალაქი/სოფელი -")%></option> </select><i></i> </label> </section> <section class="col col-sm-12"> <label class="input"> <i class="icon-append fa fa-map-marker"></i> <input placeholder="<%=trs.t("მისამართი")%>" type="text"> </label> </section> <section class="col col-sm-12"> <label class="input"> <i class="icon-append fa fa-fax"></i> <input placeholder="<%=trs.t("საფოსტო ინდექსი")%>" type="text"> </label> </section> <section class="col col-sm-12"> <label class="input"> <i class="icon-append fa fa-envelope"></i> <input placeholder="<%=trs.t("ელ-ფოსტა")%>" type="text"> </label> </section> <section class="col col-sm-12"> <label class="checkbox"> <input name="checkbox3" type="checkbox"> <i></i><%=trs.t("სინჯია")%></label> </section> <section class="col col-sm-12 control22"> <label class="input"> <i class="icon-append fa fa-list-ol"></i> <input placeholder="<%=trs.t("ნიმუშ(ებ)ის ჭურჭლის N")%>" type="text"> </label> </section> <section class="col col-sm-12 control22"> <label class="select"> <select> <option value="0"><%=trs.t("- ნიმუშის ტიპი -")%></option> </select><i></i> </label> </section> <section class="col col-sm-12 control22"> <label class="input"> <i class="icon-append fa fa-clock-o"></i> <input class="datetime" placeholder="<%=trs.t("აღების თარიღი/დრო")%>" type="text"> </label> </section> <section class="col col-sm-12 control23" style="display: none;"> <label class="input"> <i class="icon-append fa fa-eyedropper"></i> <input placeholder="<%=trs.t("სინჯის ტიპი")%>" type="text"> </label> </section> <section class="col col-sm-12 control23" style="display: none;"> <label class="input"> <i class="icon-append fa fa-list-ol"></i> <input placeholder="<%=trs.t("საიდენტიფიკაციო N")%>" type="text"> </label> </section> <section class="col col-sm-12 control23" style="display: none;"> <label class="input"> <i class="icon-append fa fa-clock-o"></i> <input class="datetime" placeholder="<%=trs.t("დამზადების თარიღი/დრო")%>" type="text"> </label> </section> <section class="col col-sm-12"> <label class="input"> <input name="analys" list="analys3" type="text" value="" placeholder="<%=trs.t("საკვლევი პათოგენი")%>"> <datalist id="analys3"> <option value="პათოგენი"></option> <option value="პათოგენი"></option> <option value="პათოგენი"></option> </datalist> </label> </section> <section class="col col-sm-12"> <label class="input"> <i class="icon-append fa fa-globe"></i> <input placeholder="<%=trs.t("მარკერი")%>" type="text"> </label> </section> <section class="col col-sm-12"> <label class="select"> <select class="select2 cust" multiple="" placeholder="<%=trs.t("გამოკვლევის მეთოდი")%>"> <option value="0"><%=trs.t("მეთოდი")%></option> <option value="0"><%=trs.t("მეთოდი")%></option> </select> </label> </section> <section class="col col-sm-12"> <button class="btn btn-success" onclick="addbox3()"><i class="fa fa-plus"></i></button> <button class="btn btn-warning"><i class="fa fa-pencil"></i></button> <button class="btn btn-danger"><i class="fa fa-trash"></i></button> <button class="btn btn-primary showcode"><i class="fa fa-print"></i></button> <button class="btn btn-default"><i class="fa fa-copy"></i></button> </section> </div></div></div></div>');
                                    $("select.cust").select2("destroy").select2();
                                }
</script>