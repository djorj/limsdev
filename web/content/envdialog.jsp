<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    
%>
<div class="smart-form">
    
        <section class="col col-sm-12 control18" style="padding: 0;">
                    <section class="col col-sm-4">
                        <label class="input"> <i class="icon-append fa fa-globe"></i>
                            <input placeholder="<%=trs.t("N")%>" type="text">
                            <b class="tooltip tooltip-bottom-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("GPS კოორდინატი N (განედი)")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="input"> <i class="icon-append fa fa-globe"></i>
                            <input placeholder="<%=trs.t("E")%>" type="text">
                            <b class="tooltip tooltip-bottom-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("GPS კოორდინატი E (გრძედი)")%></b>
                        </label>
                    </section>
                    <section class="col col-sm-4">
                        <label class="input"> <i class="icon-append fa fa-globe"></i>
                            <input placeholder="<%=trs.t("F(მ)")%>" type="text">
                            <b class="tooltip tooltip-bottom-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("GPS კოორდინატი F (სიმაღლე მეტრებში)")%></b>
                        </label>
                    </section>
                </section>
                <section class="col col-sm-3">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("კვლევის ობიექტის დასახელება")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("კვლევის ობიექტის დასახელება")%></b>
                    </label>
                </section>
                <section class="col col-sm-3">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("ტელეფონი")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("ტელეფონი")%></b>
                    </label>
                </section>
                <section class="col col-sm-3">
                    <label class="input"> <i class="icon-append fa fa-globe"></i>
                        <input placeholder="<%=trs.t("საფოსტო კოდი")%>" type="text">
                        <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("საფოსტო კოდი")%></b>
                    </label>
                </section>
                <section class="col col-sm-3">
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
</div>
                    