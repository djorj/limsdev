<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%    String[] names = {
        "ლაბორატორიული კვლევის მოთხოვნის ფორმა",
        "კონტაქტირებულთა ნიმუშების / სინჯების კვლევის მოთხოვნის ჯგუფური ფორმა",
        "გარემო (E) - ნიმუშების კვლევის მოთხოვნის ფორმა",
        "E-სინჯების კვლევის მოთხოვნის ფორმა",
        "E-კლინიკური ნიმუშების / სინჯების კვლევის მოთხოვნის ჯგუფური ფორმა"
    };

    String[] nums = {
        "FOR-GDO-011-Examination Request-V1.0",
        "FOR-GDO-034-H-Contacted -V1.0",
        "FOR-GDO-036-Environmental Samples-V1.0",
        "FOR-GDO-037-E-Specimens Examination -V1.0",
        "FOR-GDO-035-E-clinical -V1.0"
    };

    int n = Integer.parseInt(request.getParameter("n"));
%>
<script>
    pageSetUp();

    $(".datetime").datetimepicker({
        format: 'DD/MM/YYYY HH:mm'
    });
</script>
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>
<ul class="nav nav-tabs bordered half">
    <li class="active">
        <a href="#s1" data-toggle="tab"> <%=trs.t("A ივსება ნიმუშის მოპოვებისას ან ლაბორატორიიდან სინჯის/კულტურის გაგზავნისას")%></a>
    </li>
    <li>
        <a href="#s2" data-toggle="tab"> <%=trs.t("B ივსება ნიმუშის/სინჯის/კულტურის მიღებისა და ტრანზიტის დროს")%></a>
    </li>
</ul>

<div class="tab-content padding-10">
    <div class="tab-pane fade in active" id="s1">
        <div class="col-sm-12" style="padding: 0;">
            <button class="btn btn-default"><%=trs.t("გაუქმება")%></button>
            <button class="btn btn-success pull-right"><%=trs.t("დამახსოვრება")%></button>
        </div>
        <form>
            <div class="container-fluid shadow">
                <div class="row">
                    <div class="row">
                        <div class="col-md-12">
                            <h2><%=names[n]%> <%=nums[n]%></h2>
                        </div>
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-6">
                                    <div id="panel1" class="panel panel-default" data-role="panel">
                                        <div class="panel-heading">ინფორმაცია პაციენტის/შემთხვევის შესახებ</div>
                                        <div class="panel-body">
                                            <div class="smart-form col-sm-12" style="padding: 0;">
                                                <div class="col-sm-12">
                                                    <section class="col col-sm-6">
                                                        <label class="input"> <i class="icon-append fa fa-barcode"></i>
                                                            <input placeholder="<%=trs.t("სახელი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("გვარი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6">
                                                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                                            <input placeholder="<%=trs.t("პირადი ნომერი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6">
                                                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                                            <input class="datepicker" placeholder="<%=trs.t("დაბადების თარიღი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6">
                                                        <label class="select">
                                                            <select>
                                                                <option value=""><%=trs.t("- სქესი -")%></option>
                                                                <option value="Option 1">კაცი</option>
                                                                <option value="Option 2">ქალი</option>
                                                            </select><i></i>
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6">
                                                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                                            <input placeholder="<%=trs.t("მისამართი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6">
                                                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                                            <input placeholder="<%=trs.t("ქალაქი/საფოსტო კოდი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6">
                                                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                                            <input placeholder="<%=trs.t("ტელეფონი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6">
                                                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                                            <input placeholder="<%=trs.t("ელ-ფოსტა")%>" type="text">
                                                        </label>
                                                    </section>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div id="panel2" class="panel panel-default" data-role="panel">
                                        <div class="panel-heading">ინფორმაცია დამკვეთის შესახებ</div>
                                        <div class="panel-body" style="height: 275px;">
                                            <div class="smart-form col-sm-12" style="padding: 0;">
                                                <div class="col-sm-12">
                                                    <section class="col col-sm-6">
                                                        <label class="input"> <i class="icon-append fa fa-barcode"></i>
                                                            <input placeholder="<%=trs.t("დამკვეთი დაწესებულება")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("განყოფილება")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6">
                                                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                                            <input placeholder="<%=trs.t("დაწესებულების მისამართი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6">
                                                        <label class="input"> <i class="icon-append fa fa-barcode"></i>
                                                            <input placeholder="<%=trs.t("სახელი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("გვარი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6">
                                                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                                            <input placeholder="<%=trs.t("ტელეფონი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6">
                                                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                                                            <input placeholder="<%=trs.t("ელ-ფოსტა")%>" type="text">
                                                        </label>
                                                    </section>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="panel panel-default" data-role="panel">
                                        <div class="panel-body">
                                            <div class="smart-form col-sm-12" style="padding: 0;">
                                                <div class="col-sm-12">
                                                    <section class="col col-sm-6">
                                                        <label class="checkbox">
                                                            <input name="checkbox" type="checkbox">
                                                            <i></i><b><%=trs.t("პაციენტი/შემთხვევა")%></b> <%=trs.t("(H-ნიმუში/სინჯი)")%> <%=trs.t("(იხ. ინფორმაცია პაციენტის/შემთხვევის შესახებ)")%></label>
                                                    </section>
                                                    <section class="col col-sm-6">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input class="datepicker" placeholder="<%=trs.t("კლინიკური სიმპტომების დაწყების თარიღი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-12">
                                                        <label class="textarea"> <i class="icon-append fa fa-calendar"></i>
                                                            <textarea placeholder="<%=trs.t("წინასწარი კლინიკური დიაგნოზი")%>"></textarea>
                                                        </label>
                                                    </section>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="panel panel-default" data-role="panel">
                                        <div class="panel-body">
                                            <div class="smart-form col-sm-12" style="padding: 0;">
                                                <div class="col-sm-12">
                                                    <section class="col col-sm-6">
                                                        <label class="checkbox">
                                                            <input name="checkbox" type="checkbox">
                                                            <i></i><b><%=trs.t("გარდაცვლილი")%></b> <%=trs.t("(A-აუტოფსიური ნიმუში/სინჯი)")%> <%=trs.t("(იხ. ინფორმაცია პაციენტის/შემთხვევის შესახებ)")%></label>
                                                    </section>
                                                    <section class="col col-sm-6">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input class="datepicker" placeholder="<%=trs.t("გარდაცვალების თარიღი")%>" type="text">
                                                        </label>
                                                    </section>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="panel panel-default" data-role="panel">
                                        <div class="panel-body">
                                            <div class="smart-form col-sm-12" style="padding: 0;">
                                                <div class="col-sm-12">
                                                    <section class="col col-sm-12">
                                                        <label class="checkbox">
                                                            <input name="checkbox" type="checkbox">
                                                            <i></i><%=trs.t("კულტურა")%></label>
                                                    </section>
                                                    <section class="col col-sm-4">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("დასახელება")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-4">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("საიდენტიფიკაციო N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-4">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input class="datepicker" placeholder="<%=trs.t("დათესვის თარიღი")%>" type="text">
                                                        </label>
                                                    </section>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="panel panel-default" data-role="panel">
                                        <div class="panel-body">
                                            <div class="smart-form col-sm-12" style="padding: 0;">
                                                <div class="col-sm-12">
                                                    <section class="col col-sm-4">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("ნიმუშ(ებ)ის ჭურჭლის No")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-4">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("ნიმუშის ტიპი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-4">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input class="datepicker" placeholder="<%=trs.t("აღების დრო")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-4">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("ნიმუშ(ებ)ის ჭურჭლის No")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-4">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("ნიმუშის ტიპი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-4">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input class="datepicker" placeholder="<%=trs.t("აღების დრო")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-4">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("ნიმუშ(ებ)ის ჭურჭლის No")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-4">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("ნიმუშის ტიპი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-4">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input class="datepicker" placeholder="<%=trs.t("აღების დრო")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-4">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("ნიმუშ(ებ)ის ჭურჭლის No")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-4">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("ნიმუშის ტიპი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-4">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input class="datepicker" placeholder="<%=trs.t("აღების დრო")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("დამცავი კონტეინერის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input class="datepicker" placeholder="<%=trs.t("ნიმუშ(ებ)ის აღების თარიღი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="select">
                                                            <select>
                                                                <option value="0"><%=trs.t("- ნიმუშ(ებ)ის აღების ადგილი -")%></option>
                                                                <option>მიმღები</option>
                                                                <option>საპროცედურო</option>
                                                            </select>
                                                        </label><i></i>
                                                    </section>
                                                    <section class="col col-sm-12">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("ამღები პირ(ებ)ი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("სინჯი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("საიდენტიფიკაციო N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input class="datetime" placeholder="<%=trs.t("დამზადების თარიღი/დრო")%>" type="text">
                                                        </label>
                                                    </section>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="panel panel-default" data-role="panel">
                                        <div class="panel-body">
                                            <div class="smart-form col-sm-12" style="padding: 0;">
                                                <div class="col-sm-12">
                                                    <section class="col col-sm-12">
                                                        <label class="label"><%=trs.t("დამკვეთის მოთხოვნები")%></label>
                                                        <div class="inline-group">
                                                            <label class="checkbox">
                                                                <input name="checkbox-inline" type="checkbox">
                                                                <i></i><%=trs.t("კულტურის დადასტურება")%></label>
                                                            <label class="checkbox">
                                                                <input name="checkbox-inline" type="checkbox">
                                                                <i></i><%=trs.t("კულტურის შენახვა")%></label>
                                                            <label class="checkbox">
                                                                <input name="checkbox-inline" type="checkbox">
                                                                <i></i><%=trs.t("ნიმუშის კვლევა")%></label>
                                                            <label class="checkbox">
                                                                <input name="checkbox-inline" type="checkbox">
                                                                <i></i><%=trs.t("სინჯის კვლევა")%></label>
                                                        </div>
                                                    </section>
                                                    <div class="border-container">
                                                        <section class="col col-sm-3">
                                                            <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                                <input placeholder="<%=trs.t("ნიმუშ(ებ)ის ჭურჭლის No")%>" type="text">
                                                            </label>
                                                        </section>
                                                        <section class="col col-sm-3">
                                                            <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                                <input placeholder="<%=trs.t("საკვლევი პათოგენი")%>" type="text">
                                                            </label>
                                                        </section>
                                                        <section class="col col-sm-3">
                                                            <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                                <input placeholder="<%=trs.t("მარკერი")%>" type="text">
                                                            </label>
                                                        </section>
                                                        <section class="col col-sm-3">
                                                            <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                                <input placeholder="<%=trs.t("გამოკვლევის მეთოდი")%>" type="text">
                                                            </label>
                                                        </section>
                                                        <section class="col col-sm-12">
                                                            <div class="inline-group">
                                                                <label class="checkbox">
                                                                    <input name="checkbox-inline" type="checkbox">
                                                                    <i></i><%=trs.t("ბაქტერიოლოგიური")%></label>
                                                                <label class="checkbox">
                                                                    <input name="checkbox-inline" type="checkbox">
                                                                    <i></i><%=trs.t("სეროლოგიური")%></label>
                                                                <label class="checkbox">
                                                                    <input name="checkbox-inline" type="checkbox">
                                                                    <i></i><%=trs.t("მოლეკულური")%></label>
                                                                <label class="checkbox">
                                                                    <input name="checkbox-inline" type="checkbox">
                                                                    <i></i><%=trs.t("ვირუსოლოგიური")%></label>
                                                            </div>
                                                        </section>
                                                    </div>
                                                    <div class="border-container">
                                                        <section class="col col-sm-3">
                                                            <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                                <input placeholder="<%=trs.t("ნიმუშ(ებ)ის ჭურჭლის No")%>" type="text">
                                                            </label>
                                                        </section>
                                                        <section class="col col-sm-3">
                                                            <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                                <input placeholder="<%=trs.t("საკვლევი პათოგენი")%>" type="text">
                                                            </label>
                                                        </section>
                                                        <section class="col col-sm-3">
                                                            <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                                <input placeholder="<%=trs.t("მარკერი")%>" type="text">
                                                            </label>
                                                        </section>
                                                        <section class="col col-sm-3">
                                                            <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                                <input placeholder="<%=trs.t("გამოკვლევის მეთოდი")%>" type="text">
                                                            </label>
                                                        </section>
                                                        <section class="col col-sm-12">
                                                            <div class="inline-group">
                                                                <label class="checkbox">
                                                                    <input name="checkbox-inline" type="checkbox">
                                                                    <i></i><%=trs.t("ბაქტერიოლოგიური")%></label>
                                                                <label class="checkbox">
                                                                    <input name="checkbox-inline" type="checkbox">
                                                                    <i></i><%=trs.t("სეროლოგიური")%></label>
                                                                <label class="checkbox">
                                                                    <input name="checkbox-inline" type="checkbox">
                                                                    <i></i><%=trs.t("მოლეკულური")%></label>
                                                                <label class="checkbox">
                                                                    <input name="checkbox-inline" type="checkbox">
                                                                    <i></i><%=trs.t("ვირუსოლოგიური")%></label>
                                                            </div>
                                                        </section>
                                                    </div>
                                                    <div class="border-container">
                                                        <section class="col col-sm-3">
                                                            <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                                <input placeholder="<%=trs.t("ნიმუშ(ებ)ის ჭურჭლის No")%>" type="text">
                                                            </label>
                                                        </section>
                                                        <section class="col col-sm-3">
                                                            <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                                <input placeholder="<%=trs.t("საკვლევი პათოგენი")%>" type="text">
                                                            </label>
                                                        </section>
                                                        <section class="col col-sm-3">
                                                            <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                                <input placeholder="<%=trs.t("მარკერი")%>" type="text">
                                                            </label>
                                                        </section>
                                                        <section class="col col-sm-3">
                                                            <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                                <input placeholder="<%=trs.t("გამოკვლევის მეთოდი")%>" type="text">
                                                            </label>
                                                        </section>
                                                        <section class="col col-sm-12">
                                                            <div class="inline-group">
                                                                <label class="checkbox">
                                                                    <input name="checkbox-inline" type="checkbox">
                                                                    <i></i><%=trs.t("ბაქტერიოლოგიური")%></label>
                                                                <label class="checkbox">
                                                                    <input name="checkbox-inline" type="checkbox">
                                                                    <i></i><%=trs.t("სეროლოგიური")%></label>
                                                                <label class="checkbox">
                                                                    <input name="checkbox-inline" type="checkbox">
                                                                    <i></i><%=trs.t("მოლეკულური")%></label>
                                                                <label class="checkbox">
                                                                    <input name="checkbox-inline" type="checkbox">
                                                                    <i></i><%=trs.t("ვირუსოლოგიური")%></label>
                                                            </div>
                                                        </section>
                                                    </div>
                                                    <div class="border-container">
                                                        <section class="col col-sm-3">
                                                            <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                                <input placeholder="<%=trs.t("ნიმუშ(ებ)ის ჭურჭლის No")%>" type="text">
                                                            </label>
                                                        </section>
                                                        <section class="col col-sm-3">
                                                            <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                                <input placeholder="<%=trs.t("საკვლევი პათოგენი")%>" type="text">
                                                            </label>
                                                        </section>
                                                        <section class="col col-sm-3">
                                                            <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                                <input placeholder="<%=trs.t("მარკერი")%>" type="text">
                                                            </label>
                                                        </section>
                                                        <section class="col col-sm-3">
                                                            <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                                <input placeholder="<%=trs.t("გამოკვლევის მეთოდი")%>" type="text">
                                                            </label>
                                                        </section>
                                                        <section class="col col-sm-12">
                                                            <div class="inline-group">
                                                                <label class="checkbox">
                                                                    <input name="checkbox-inline" type="checkbox">
                                                                    <i></i><%=trs.t("ბაქტერიოლოგიური")%></label>
                                                                <label class="checkbox">
                                                                    <input name="checkbox-inline" type="checkbox">
                                                                    <i></i><%=trs.t("სეროლოგიური")%></label>
                                                                <label class="checkbox">
                                                                    <input name="checkbox-inline" type="checkbox">
                                                                    <i></i><%=trs.t("მოლეკულური")%></label>
                                                                <label class="checkbox">
                                                                    <input name="checkbox-inline" type="checkbox">
                                                                    <i></i><%=trs.t("ვირუსოლოგიური")%></label>
                                                            </div>
                                                        </section>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="panel panel-default" data-role="panel">
                                        <div class="panel-body">
                                            <div class="smart-form col-sm-12" style="padding: 0;">
                                                <div class="col-sm-12">
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("I მიმღები დაწესებულება")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("გამომკვლევი დაწესებულება")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("ნიმუშის ჭურჭლის No")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input class="datetime" placeholder="<%=trs.t("გაგზავნის თარიღი/დრო")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-12">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("ტრანსპორტირებზე პასუხისმგებელი პირები")%>" type="text">
                                                        </label>
                                                    </section>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>

    </div>
    <div class="tab-pane fade" id="s2">
        <div class="col-sm-12" style="padding: 0;">
            <button class="btn btn-default"><%=trs.t("გაუქმება")%></button>
            <button class="btn btn-success pull-right"><%=trs.t("დამახსოვრება")%></button>
        </div>
        <form>
            <div class="container-fluid shadow">
                <div class="row">
                    <div class="row">
                        <div class="col-md-12">
                            <h2><%=names[n]%> <%=nums[n]%></h2>
                        </div>
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="panel panel-default" data-role="panel">
                                        <div class="panel-body">
                                            <div class="smart-form col-sm-12" style="padding: 0;">
                                                <div class="col-sm-12">
                                                    <section class="col col-sm-12">
                                                        <label class="checkbox">
                                                            <input name="checkbox" type="checkbox">
                                                            <i></i><%=trs.t("I მიღება")%></label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input class="datetime" placeholder="<%=trs.t("მიღების თარიღი/დრო")%>" type="text">
                                                        </label>
                                                    </section>
                                                </div>
                                                <div class="col-sm-12">
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("I ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("I სარეგისტრაციო N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6" style="height: 34px;">
                                                        <div class="inline-group">
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("დამაკმაყოფილებელი")%></label>
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("არადამაკმაყოფილებელი,")%></label>
                                                        </div>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("II ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("II სარეგისტრაციო N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6" style="height: 34px;">
                                                        <div class="inline-group">
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("დამაკმაყოფილებელი")%></label>
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("არადამაკმაყოფილებელი,")%></label>
                                                        </div>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("III ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("III სარეგისტრაციო N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6" style="height: 34px;">
                                                        <div class="inline-group">
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("დამაკმაყოფილებელი")%></label>
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("არადამაკმაყოფილებელი,")%></label>
                                                        </div>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("IV ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("IV სარეგისტრაციო N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6" style="height: 34px;">
                                                        <div class="inline-group">
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("დამაკმაყოფილებელი")%></label>
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("არადამაკმაყოფილებელი,")%></label>
                                                        </div>
                                                    </section>
                                                    <section class="col col-sm-12">
                                                        <label class="label"><%=trs.t("დანიშნულება")%></label>
                                                        <div class="inline-group">
                                                            <label class="radio" style="width: 200px;">
                                                                <input name="radio-inline1" type="radio">
                                                                <i></i><%=trs.t("I ადგილზე გამოსაკვლევი")%></label>
                                                            <label class="radio" style="width: 200px;">
                                                                <input name="radio-inline2" type="radio">
                                                                <i></i><%=trs.t("II ადგილზე გამოსაკვლევი")%></label>
                                                            <label class="radio" style="width: 200px;">
                                                                <input name="radio-inline3" type="radio">
                                                                <i></i><%=trs.t("III ადგილზე გამოსაკვლევი")%></label>
                                                            <label class="radio" style="width: 200px;">
                                                                <input name="radio-inline4" type="radio">
                                                                <i></i><%=trs.t("IV ადგილზე გამოსაკვლევი")%></label>
                                                        </div>
                                                    </section>
                                                    <section class="col col-sm-12">
                                                        <div class="inline-group">
                                                            <label class="radio" style="width: 200px;">
                                                                <input name="radio-inline1" type="radio">
                                                                <i></i><%=trs.t("I სატრანზიტო")%></label>
                                                            <label class="radio" style="width: 200px;">
                                                                <input name="radio-inline2" type="radio">
                                                                <i></i><%=trs.t("II სატრანზიტო")%></label>
                                                            <label class="radio" style="width: 200px;">
                                                                <input name="radio-inline3" type="radio">
                                                                <i></i><%=trs.t("III სატრანზიტო")%></label>
                                                            <label class="radio" style="width: 200px;">
                                                                <input name="radio-inline4" type="radio">
                                                                <i></i><%=trs.t("IV სატრანზიტო")%></label>
                                                        </div>
                                                    </section>
                                                    <section class="col col-sm-12">
                                                        <label class="label"><%=trs.t("გადაეცა:")%></label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("პირი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("ლაბორატორია")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input class="datetime" placeholder="<%=trs.t("თარიღი/დრო")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-12">
                                                        <label class="checkbox">
                                                            <input name="checkbox" type="checkbox">
                                                            <i></i><%=trs.t("I ტრანზიტი")%></label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("დამცავი კონტეინერის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("II მიმღები დაწესებულება")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("გამომკვლევი დაწესებულება")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("ტრანსპორტირებაზე პასუხისმგებელი პირი I")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("ტრანსპორტირებაზე პასუხისმგებელი პირი II")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input class="datetime" placeholder="<%=trs.t("გაგზავნის თარიღი/დრო")%>" type="text">
                                                        </label>
                                                    </section>
                                                </div>
                                                <div class="com-sm-12">
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("I ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("II ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("III ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("IV ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                </div>
                                                <hr class="cust">
                                                <div class="col-sm-12">
                                                    <section class="col col-sm-12">
                                                        <label class="checkbox">
                                                            <input name="checkbox" type="checkbox">
                                                            <i></i><%=trs.t("II მიღება")%></label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input class="datetime" placeholder="<%=trs.t("მიღების თარიღი/დრო")%>" type="text">
                                                        </label>
                                                    </section>
                                                </div>
                                                <div class="col-sm-12">
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("I ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("I სარეგისტრაციო N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6" style="height: 34px;">
                                                        <div class="inline-group">
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("დამაკმაყოფილებელი")%></label>
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("არადამაკმაყოფილებელი,")%></label>
                                                        </div>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("II ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("II სარეგისტრაციო N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6" style="height: 34px;">
                                                        <div class="inline-group">
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("დამაკმაყოფილებელი")%></label>
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("არადამაკმაყოფილებელი,")%></label>
                                                        </div>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("III ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("III სარეგისტრაციო N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6" style="height: 34px;">
                                                        <div class="inline-group">
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("დამაკმაყოფილებელი")%></label>
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("არადამაკმაყოფილებელი,")%></label>
                                                        </div>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("IV ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("IV სარეგისტრაციო N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6" style="height: 34px;">
                                                        <div class="inline-group">
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("დამაკმაყოფილებელი")%></label>
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("არადამაკმაყოფილებელი,")%></label>
                                                        </div>
                                                    </section>
                                                    <section class="col col-sm-12">
                                                        <label class="label"><%=trs.t("დანიშნულება")%></label>
                                                        <div class="inline-group">
                                                            <label class="radio" style="width: 200px;">
                                                                <input name="radio-inline1" type="radio">
                                                                <i></i><%=trs.t("I ადგილზე გამოსაკვლევი")%></label>
                                                            <label class="radio" style="width: 200px;">
                                                                <input name="radio-inline2" type="radio">
                                                                <i></i><%=trs.t("II ადგილზე გამოსაკვლევი")%></label>
                                                            <label class="radio" style="width: 200px;">
                                                                <input name="radio-inline3" type="radio">
                                                                <i></i><%=trs.t("III ადგილზე გამოსაკვლევი")%></label>
                                                            <label class="radio" style="width: 200px;">
                                                                <input name="radio-inline4" type="radio">
                                                                <i></i><%=trs.t("IV ადგილზე გამოსაკვლევი")%></label>
                                                        </div>
                                                    </section>
                                                    <section class="col col-sm-12">
                                                        <div class="inline-group">
                                                            <label class="radio" style="width: 200px;">
                                                                <input name="radio-inline1" type="radio">
                                                                <i></i><%=trs.t("I სატრანზიტო")%></label>
                                                            <label class="radio" style="width: 200px;">
                                                                <input name="radio-inline2" type="radio">
                                                                <i></i><%=trs.t("II სატრანზიტო")%></label>
                                                            <label class="radio" style="width: 200px;">
                                                                <input name="radio-inline3" type="radio">
                                                                <i></i><%=trs.t("III სატრანზიტო")%></label>
                                                            <label class="radio" style="width: 200px;">
                                                                <input name="radio-inline4" type="radio">
                                                                <i></i><%=trs.t("IV სატრანზიტო")%></label>
                                                        </div>
                                                    </section>
                                                    <section class="col col-sm-12">
                                                        <label class="label"><%=trs.t("გადაეცა:")%></label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("პირი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("ლაბორატორია")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input class="datetime" placeholder="<%=trs.t("თარიღი/დრო")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-12">
                                                        <label class="checkbox">
                                                            <input name="checkbox" type="checkbox">
                                                            <i></i><%=trs.t("II ტრანზიტი")%></label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("დამცავი კონტეინერის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("III მიმღები დაწესებულება")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("გამომკვლევი დაწესებულება")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("ტრანსპორტირებაზე პასუხისმგებელი პირი I")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("ტრანსპორტირებაზე პასუხისმგებელი პირი II")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input class="datetime" placeholder="<%=trs.t("გაგზავნის თარიღი/დრო")%>" type="text">
                                                        </label>
                                                    </section>
                                                </div>
                                                <div class="com-sm-12">
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("I ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("II ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("III ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("IV ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                </div>
                                                <hr class="cust">
                                                <div class="col-sm-12">
                                                    <section class="col col-sm-12">
                                                        <label class="checkbox">
                                                            <input name="checkbox" type="checkbox">
                                                            <i></i><%=trs.t("III მიღება")%></label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input class="datetime" placeholder="<%=trs.t("მიღების თარიღი/დრო")%>" type="text">
                                                        </label>
                                                    </section>
                                                </div>
                                                <div class="col-sm-12">
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("I ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("I სარეგისტრაციო N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6" style="height: 34px;">
                                                        <div class="inline-group">
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("დამაკმაყოფილებელი")%></label>
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("არადამაკმაყოფილებელი,")%></label>
                                                        </div>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("II ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("II სარეგისტრაციო N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6" style="height: 34px;">
                                                        <div class="inline-group">
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("დამაკმაყოფილებელი")%></label>
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("არადამაკმაყოფილებელი,")%></label>
                                                        </div>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("III ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("III სარეგისტრაციო N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6" style="height: 34px;">
                                                        <div class="inline-group">
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("დამაკმაყოფილებელი")%></label>
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("არადამაკმაყოფილებელი,")%></label>
                                                        </div>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("IV ნიმუშის ჭურჭლის N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("IV სარეგისტრაციო N")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-6" style="height: 34px;">
                                                        <div class="inline-group">
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("დამაკმაყოფილებელი")%></label>
                                                            <label class="radio">
                                                                <input name="checkbox-inline" type="radio">
                                                                <i></i><%=trs.t("არადამაკმაყოფილებელი,")%></label>
                                                        </div>
                                                    </section>
                                                    <section class="col col-sm-12">
                                                        <label class="label"><%=trs.t("დანიშნულება")%></label>
                                                        <div class="inline-group">
                                                            <label class="checkbox" style="width: 200px;">
                                                                <input name="radio-inline1" type="checkbox">
                                                                <i></i><%=trs.t("I ადგილზე გამოსაკვლევი")%></label>
                                                            <label class="checkbox" style="width: 200px;">
                                                                <input name="radio-inline2" type="checkbox">
                                                                <i></i><%=trs.t("II ადგილზე გამოსაკვლევი")%></label>
                                                            <label class="checkbox" style="width: 200px;">
                                                                <input name="radio-inline3" type="checkbox">
                                                                <i></i><%=trs.t("III ადგილზე გამოსაკვლევი")%></label>
                                                            <label class="checkbox" style="width: 200px;">
                                                                <input name="radio-inline4" type="checkbox">
                                                                <i></i><%=trs.t("IV ადგილზე გამოსაკვლევი")%></label>
                                                        </div>
                                                    </section>
                                                    <section class="col col-sm-12">
                                                        <label class="label"><%=trs.t("გადაეცა:")%></label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("პირი")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input placeholder="<%=trs.t("ლაბორატორია")%>" type="text">
                                                        </label>
                                                    </section>
                                                    <section class="col col-sm-3">
                                                        <label class="input"> <i class="icon-append fa fa-address-book"></i>
                                                            <input class="datetime" placeholder="<%=trs.t("თარიღი/დრო")%>" type="text">
                                                        </label>
                                                    </section>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        </form>
    </div>
</div>