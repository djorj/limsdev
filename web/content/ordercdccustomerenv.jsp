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
        <div class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-globe"></i>
                <input placeholder="<%=trs.t("GPS კოორდინატებიდან გადახრის კუთხე")%>" type="text">
                <b class="tooltip tooltip-bottom-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("GPS კოორდინატებიდან გადახრის კუთხე")%></b>
            </label>
        </div>
        <div class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-globe"></i>
                <input placeholder="<%=trs.t("GPS კოორდინატებიდან მანძილი მეტრებში")%>" type="text">
                <b class="tooltip tooltip-bottom-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("GPS კოორდინატებიდან მანძილი მეტრებში")%></b>
            </label>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                <input placeholder="<%=trs.t("წერტილის N")%>" type="text">
                <b class="tooltip tooltip-bottom-right"><i class="fa fa-list-ol txt-color-teal"></i> <%=trs.t("წერტილის N")%></b>
            </label>
        </div>
        <div class="col col-sm-6">
            <label class="select">
                <select>
                    <option value="0"><%=trs.t("- სტაცია -")%></option>
                    <option value="1"><%=trs.t("ღია")%></option>
                    <option value="2"><%=trs.t("დახურული")%></option>
                </select><i></i>
                <b class="tooltip tooltip-top-right"><%=trs.t("სტაცია")%></b>
            </label>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-globe"></i>
                <input placeholder="<%=trs.t("აღების ადგილი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("აღების ადგილი")%></b>
            </label>
        </div>
        <div class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-globe"></i>
                <input placeholder="<%=trs.t("საკვლევი მასალის რაოდენობა")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("საკვლევი მასალის რაოდენობა")%></b>
            </label>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-12"><hr></div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-6" id="controlcase1">
            <label class="select">
                <select id="labtestid" placeholder="<%=trs.t("გამოკვლევის მეთოდი")%>">
                    <option value="0"><%=trs.t("- გამოკვლევის მეთოდი -")%></option>
                    <option value="1"><%=trs.t("ბაქტერიოლოგიური")%></option>
                    <option value="2"><%=trs.t("სეროლოგიური")%></option>
                </select>
                <b class="tooltip tooltip-bottom-right"><%=trs.t("გამოკვლევის მეთოდი")%></b>
            </label>
        </div>
        <div class="col col-sm-6">
            <label class="select">
                <select>
                    <option value="0"><%=trs.t("- ნიმუშის ტიპი -")%></option>
                    <%
                    for(int i=0;i<stps.length;i++){
                    %>
                    <option value="<%=stps[i].getSampletypeid()%>"><%=trs.t(stps[i].getName())%></option>
                    <%}%>
                </select><i></i>
                <b class="tooltip tooltip-bottom-right"><%=trs.t("ნიმუშის ტიპი")%></b>
            </label>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-6">
            <label class="select">
                <select placeholder="<%=trs.t("საკვლევი პათოგენი")%>">
                    <option value="0"><%=trs.t("- საკვლევი პათოგენი -")%></option>
                    <option value="1">Bacillus Anthracis</option>
                    <option value="2">Francisella Tularensis</option>
                    <option value="3">Yersinia Pestis</option>
                    <option value="4">Parapox Virus</option>
                    <option value="5">Escherichia Koli</option>
                </select>
                <b class="tooltip tooltip-bottom-right"><%=trs.t("საკვლევი პათოგენი")%></b>
            </label>
        </div>
        <div class="col col-sm-6">
            <label class="select">
                <select placeholder="<%=trs.t("მარკერი")%>">
                    <option value="0"><%=trs.t("- მარკერი -")%></option>
                    <option value="1"><%=trs.t("იმუნოგლობულინი")%></option>
                    <option value="2"><%=trs.t("AFP")%></option>
                    <option value="2"><%=trs.t("PCA")%></option>
                </select>
                <b class="tooltip tooltip-bottom-right"><%=trs.t("მარკერი")%></b>
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