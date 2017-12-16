<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    
%>
<script>
    $("#radio2-1").on("click",function(){
        $("#actualdata2").hide();
        $("#actualdata1").show();
    });
    $("#radio2-2").on("click",function(){
        $("#actualdata1").hide();
        $("#actualdata2").show();
    });
    
    $("#actualdata1").hide();
    $("#actualdata2").hide();
</script>
<div class="smart-form">
    <div class="col-sm-12">
    <section class="col col-sm-12 control4">
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
        <div class="col-sm-12" id="actualdata1">
            <jsp:include page="patientdialog.jsp"></jsp:include>
        </div>
        <div class="col-sm-12" id="actualdata2">
            <jsp:include page="envdialog.jsp"></jsp:include>
        </div>
</div>