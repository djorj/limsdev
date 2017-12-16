<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    int n = 1;
    if(request.getParameter("n") != null)
        n = Integer.parseInt(request.getParameter("n"));
%>
<script>
    function delItem(){
        var n = <%=n%>-1;
        $.post("content/ordercdcpatient.jsp",{ n: n },function(data){ $("#s1").html(data); });
    }
    
    function addItem(){
        var n = <%=n%>+1;
        $.post("content/ordercdcpatient.jsp",{ n: n },function(data){ $("#s1").html(data); });
    }
    
    function clearPat(){
        $("#newpatient").val("");
    }
</script>
<div class="smart-form">
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-12">
            <h1><b>ელდარ გიორგაძე</b></h1>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-4">
            <b><%=trs.t("პირადი ნომერი")%>:</b> 100234678901
        </div>
        <div class="col col-sm-4">
            <b><%=trs.t("დაბადების თარიღი")%>:</b> 22/05/1978
        </div>
        <div class="col col-sm-4">
            <b><%=trs.t("სქესი")%>:</b><%=trs.t("კაცი")%>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-4">
            <b><%=trs.t("საფოსტო ინდექსი")%>:</b> 6354
        </div>
        <div class="col col-sm-4">
            <b><%=trs.t("ტელეფონი")%>:</b> +995 577 453627
        </div>
        <div class="col col-sm-4">
            <b><%=trs.t("ელ-ფოსტა")%>:</b> eldar@mail.com
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-10">
            <b><%=trs.t("მისამართი")%>:</b><br>
            <%=trs.t("საქართველო")%>, 
            <%=trs.t("გურიის მხარე")%>,
            <%=trs.t("ოზურგეთის რაიონი")%>,
            <%=trs.t("სოფ.")%> <%=trs.t("იანეთი")%>, 
            <%=trs.t("მე-5 შესახვევი #3")%>
        </div>
        <div class="col col-sm-2">
            <button onclick="editItem()" type="button" class="btn btn-xs btn-warning pull-right" title="<%=trs.t("რედაქტირება")%>">
                <span class="fa fa-pencil"></span>
            </button>
        </div>
    </div>
</div>

