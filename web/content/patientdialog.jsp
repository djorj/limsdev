<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    String clb = trs.t("პაციენტის მოქალაქეობა");
%>
<script>
    $("#nonres").on("click",function(){
        if($(this).is(':checked')) {
            $(".control7").show();
        } else $(".control7").hide();
    });
</script>
<div class="smart-form">
    

        <section class="col col-sm-4">
            <label class="checkbox">
                <input name="checkbox1" id="nonres" type="checkbox">
                <i></i><%=trs.t("არარეზიდენტი")%></label>
        </section>
        <section class="col col-sm-4 control7" style="display: none;">
            <label class="input"> <i class="icon-append fa fa-id-card"></i>
                <input placeholder="<%=trs.t("პასპორტის N")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-id-card txt-color-teal"></i> <%=trs.t("პაციენტის პასპორტის N")%></b>
            </label>
        </section>
        <section class="col col-sm-4 control7" style="display: none;">
            <label class="select">
                <jsp:include page="../elements/country.jsp">
                    <jsp:param name="label" value="<%=clb%>"></jsp:param>
                    <jsp:param name="idname" value="countryid1"></jsp:param>
                    <jsp:param name="countryid" value="0"></jsp:param>
                </jsp:include>
                <i></i>
                <b class="tooltip tooltip-top-right"><%=trs.t("პაციენტის მოქალაქეობა")%></b>
            </label>
        </section>
        <section class="col col-sm-12 control6">
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
        <section class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-user"></i>
                <input placeholder="<%=trs.t("სახელი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("პაციენტის სახელი")%></b>
            </label>
        </section>
        <section class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-user"></i>
                <input placeholder="<%=trs.t("გვარი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("პაციენტის გვარი")%></b>
            </label>
        </section>
        <section class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-calendar"></i>
                <input class="datepicker" placeholder="<%=trs.t("დაბადების თარიღი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("პაციენტის დაბადების თარიღი")%></b>
            </label>
        </section>
        <section class="col col-sm-6">
            <label class="select">
                <select>
                    <option value="0"><%=trs.t("- სქესი -")%></option>
                    <option value="F"><%=trs.t("ქალი")%></option>
                    <option value="M"><%=trs.t("კაცი")%></option>
                </select><i></i>
                <b class="tooltip tooltip-top-right"><%=trs.t("პაციენტის სქესი")%></b>
            </label>
        </section>

        <jsp:include page="../elements/address.jsp">
            <jsp:param name="suffix" value="1"></jsp:param>
            <jsp:param name="colmd" value="4"></jsp:param>
        </jsp:include>

        
        <section class="col col-sm-4">
            <label class="input"> <i class="icon-append fa fa-fax"></i>
                <input placeholder="<%=trs.t("საფოსტო ინდექსი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-fax txt-color-teal"></i> <%=trs.t("პაციენტის საფოსტო ინდექსი")%></b>
            </label>
        </section>
        <section class="col col-sm-4">
            <label class="input"> <i class="icon-append fa fa-phone"></i>
                <input placeholder="<%=trs.t("ტელეფონი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-phone txt-color-teal"></i> <%=trs.t("პაციენტის ტელეფონი")%></b>
            </label>
        </section>
        <section class="col col-sm-4">
            <label class="input"> <i class="icon-append fa fa-envelope"></i>
                <input placeholder="<%=trs.t("ელ-ფოსტა")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-envelope txt-color-teal"></i> <%=trs.t("პაციენტის ელ-ფოსტა")%></b>
            </label>
        </section>
</div>