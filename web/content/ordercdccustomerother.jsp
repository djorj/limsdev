<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    int n = 0;
    if(request.getParameter("n") != null)
        n = Integer.parseInt(request.getParameter("n"));
    SampletypeBean[] stps = SampletypeManager.getInstance().loadByWhere("where companyid = "+user.getCompanyid()+" order by name");
%>
<script>
    

</script>
<div class="smart-form">
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-12" id="controlcase1">
            <label class="select">
                <select id="labtestid" placeholder="<%=trs.t("გამოკვლევის მეთოდი")%>">
                    <option value="0"><%=trs.t("- გამოკვლევის მეთოდი -")%></option>
                    <option value="1"><%=trs.t("ბაქტერიოლოგიური")%></option>
                    <option value="2"><%=trs.t("სეროლოგიური")%></option>
                </select>
                <b class="tooltip tooltip-bottom-right"><%=trs.t("გამოკვლევის მეთოდი")%></b>
            </label>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-12">
            <label class="input"> <i class="icon-append fa fa-globe"></i>
                <input placeholder="<%=trs.t("საკვლევი მასალის დასახელება")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("საკვლევი მასალის დასახელება")%></b>
            </label>
        </div>
    </div>
</div>

<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>
<script>
        //pageSetUp();

        $("#sampletype").hide();
        
        $("#labtestid").on('change',function(){
            if($("#labtestid").val() == 0)   $("#sampletype").hide();
            else                                $("#sampletype").show();
        });
        
        $(".mask").mask("99999999999");
        $(".datetime").datetimepicker({
            format: 'DD/MM/YYYY HH:mm'
        });


        var currentdate = new Date();
        var datetime = currentdate.getDate() + "/"
                + ("0" + (currentdate.getMonth() + 1)).slice(-2) + "/"
                + currentdate.getFullYear() + " "
                + currentdate.getHours() + ":"
                + currentdate.getMinutes()
        $(".now").val(datetime);
                                    

                                    
</script>