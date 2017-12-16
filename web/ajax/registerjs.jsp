<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%    
    String sampletypes = ObjOptions.Sampletypes(user.getCompanyid());
    
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
                        <jsp:include page="register/register_left.jsp"></jsp:include>
                        <jsp:include page="register/register_right.jsp"></jsp:include>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
</div>
<jsp:include page="register/register_billmodal.jsp"></jsp:include>
<jsp:include page="register/register_docsmodal.jsp"></jsp:include>
<jsp:include page="register/register_msgmodal.jsp"></jsp:include>
<jsp:include page="register/register_sendcontractmodal.jsp"></jsp:include>
<jsp:include page="register/register_samplecomment.jsp"></jsp:include>
<jsp:include page="register/register_banmodal.jsp"></jsp:include>
<jsp:include page="register/register_chlabmodal.jsp"></jsp:include>
<jsp:include page="register/register_samplemodal.jsp"></jsp:include>
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>
<jsp:include page="register/register_jsfunctions.jsp"></jsp:include>
