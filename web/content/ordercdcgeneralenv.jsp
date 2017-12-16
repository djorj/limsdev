<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    
%>
<script>
    $("#controlcase2").hide();
    $("#controlcase3").hide();
    $("#radio3-1").on("click",function(){
        $("#controlcase1").show();
        $("#controlcase2").hide();
        $("#controlcase3").hide();
    });
    $("#radio3-2").on("click",function(){
        $("#controlcase1").hide();
        $("#controlcase2").show();
        $("#controlcase3").hide();
    });
    $("#radio3-3").on("click",function(){
        $("#controlcase1").hide();
        $("#controlcase2").hide();
        $("#controlcase3").show();
    });

</script>
<div class="smart-form">
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-9">
            <label class="input"> <i class="icon-append fa fa-institution"></i>
                <input list="contragent" placeholder="<%=trs.t("დამკვეთი")%>" type="text">
                <b class="tooltip tooltip-bottom-right"><i class="fa fa-institution txt-color-teal"></i> <%=trs.t("კვლევის დამკვეთი")%></b>
                <datalist id="contragent">
                    <option value="209472505 დამკვეთი"></option>
                    <option value="204861042 დამკვეთი"></option>
                    <option value="211361776 დამკვეთი"></option>
                    <option value="460010011 დამკვეთი"></option>
                    <option value="211351883 დამკვეთი"></option>
                </datalist>
            </label>
        </div>
        <div class="col col-sm-1">
            <button onclick="clearContragent()" class="btn btn-danger" data-original-title="<%=trs.t("გასუფთავება")%>" type="button">
                <i class="fa fa-close"></i> 
            </button>
        </div>
        <div class="col col-sm-2">
            <button onclick="addContragent()" class="btn btn-success" data-original-title="<%=trs.t("დამკვეთის დამატება")%>" type="button">
                <%=trs.t("დამატება")%> <i class="fa fa-plus"></i> 
            </button>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-12">        
            <label class="select">
                <select>
                    <option value="0"><%=trs.t("- საფუძველი -")%></option>
                    <option value="1"><%=trs.t("ეპიდზედამხედველობა")%></option>
                    <option value="2"><%=trs.t("C-ჰეპატიტი")%></option>
                    <option value="3"><%=trs.t("შიდსი")%></option>
                    <option value="4"><%=trs.t("თვითმომართვა")%></option>
                    <option value="5"><%=trs.t("სხვა")%></option>
                </select><i></i>
                <b class="tooltip tooltip-top-right"><%=trs.t("აირჩიეთ მომართვის საფუძველი")%></b>
            </label>
        </div>
    </div>
    
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-6">
            <label class="select">
                <select>
                    <option value="0"><%=trs.t("- მიმღები დაწესებულება -")%></option>
                </select><i></i>
                <b class="tooltip tooltip-top-right"><%=trs.t("მიმღები დაწესებულება")%></b>
            </label>
        </div>
        <div class="col col-sm-6">
            <label class="select">
                <select>
                    <option value="0"><%=trs.t("- გამომკვლევი დაწესებულება -")%></option>
                </select><i></i>
                <b class="tooltip tooltip-top-right"><%=trs.t("გამომკვლევი დაწესებულება")%></b>
            </label>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                <input placeholder="<%=trs.t("დამცავი კონტეინერის N")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-list-ol txt-color-teal"></i> <%=trs.t("დამცავი კონტეინერის N")%></b>
            </label>
        </div>
        <div class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-user"></i>
                <input placeholder="<%=trs.t("შევსებაზე პასუხისმგებელი პირის სახელი, გვარი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("შევსებაზე პასუხისმგებელი პირის სახელი, გვარი")%></b>
            </label>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                <input class="datetime" placeholder="<%=trs.t("გაგზავნის თარიღი/დრო")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-clock-o txt-color-teal"></i> <%=trs.t("გაგზავნის თარიღი და დრო")%></b>
            </label>
        </div>
        <div class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-phone"></i>
                <input placeholder="<%=trs.t("ტელეფონის ნომერი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-phone txt-color-teal"></i> <%=trs.t("შევსებაზე პასუხისმგებელი პირის ტელეფონის ნომერი")%></b>
            </label>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-12">
            <label class="input"> <i class="icon-append fa fa-users"></i>
                <input class="tagsinput" data-role="tagsinput" placeholder="<%=trs.t("ტრანსპ. პასუხისმგებელი პირები")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("ტრანსპ. პასუხისმგებელი პირები (სახელი, გვარი)")%></b>
            </label>
        </div>
    </div>
</div>
