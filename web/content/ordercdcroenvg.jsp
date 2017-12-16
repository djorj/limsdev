<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    int n = 0;
    if(request.getParameter("n") != null)
        n = Integer.parseInt(request.getParameter("n"));
    SampletypeBean[] stps = SampletypeManager.getInstance().loadByWhere("where companyid = "+user.getCompanyid()+" order by name");
%>
<script>
    function delEnvitem(){
        var n = <%=n%>-1;
        $.post("content/ordercdcroenvg.jsp",{ n: n },function(data){ $("#s2").html(data); });
    }
    
    function addEnvitem(){
        var n = <%=n%>+1;
        $.post("content/ordercdcroenvg.jsp",{ n: n },function(data){ $("#s2").html(data); });
    }

</script>
<div class="smart-form">
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-4">
            <label class="select">
                <select>
                    <option value="0"><%=trs.t("- სტაცია -")%></option>
                    <option value="1"><%=trs.t("ღია")%></option>
                    <option value="2"><%=trs.t("დახურული")%></option>
                </select><i></i>
                <b class="tooltip tooltip-bottom-right"><%=trs.t("სტაცია")%></b>
            </label>
        </div>
        <div class="col col-sm-4">
            <label class="input"> <i class="icon-append fa fa-globe"></i>
                <input placeholder="<%=trs.t("დასახელება")%>" type="text">
                <b class="tooltip tooltip-bottom-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("კვლევის ობიექტის დასახელება")%></b>
            </label>
        </div>
        <div class="col col-sm-4">
            <label class="input"> <i class="icon-append fa fa-globe"></i>
                <input placeholder="<%=trs.t("საკვლევი მასალის რაოდენობა")%>" type="text">
                <b class="tooltip tooltip-bottom-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("საკვლევი მასალის რაოდენობა")%></b>
            </label>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-5">
            <label class="input"> <i class="icon-append fa fa-globe"></i>
                <input placeholder="<%=trs.t("GPS კოორდინატებიდან გადახრის კუთხე")%>" type="text">
                <b class="tooltip tooltip-bottom-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("GPS კოორდინატებიდან გადახრის კუთხე")%></b>
            </label>
        </div>
        <div class="col col-sm-5">
            <label class="input"> <i class="icon-append fa fa-globe"></i>
                <input placeholder="<%=trs.t("GPS კოორდინატებიდან მანძილი მეტრებში")%>" type="text">
                <b class="tooltip tooltip-bottom-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("GPS კოორდინატებიდან მანძილი მეტრებში")%></b>
            </label>
        </div>
        <div class="col col-sm-2">
            <button onclick="addEnvitem()" class="btn btn-success" data-original-title="<%=trs.t("დამატება")%>" type="button">
                <%=trs.t("დამატება")%> <i class="fa fa-plus"></i> 
            </button>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-12">
            <table class="table table-striped" style="width: 800px; display:block;">
                <thead>
                    <tr style="background-color: #428BCA !important;">
                        <td width="100" style="background-color: #428BCA !important; color: white !important;" align='center'><%=trs.t("სტაცია")%></td>
                        <td width="150" style="background-color: #428BCA !important; color: white !important;" align='center'><%=trs.t("დასახელება")%></td>
                        <td width="150" style="background-color: #428BCA !important; color: white !important;" align='center'><%=trs.t("რაოდენობა")%></td>
                        <td width="150" style="background-color: #428BCA !important; color: white !important;" align='center'><%=trs.t("GPS კუთხე")%></td>
                        <td width="150" style="background-color: #428BCA !important; color: white !important;" align='center'><%=trs.t("GPS მანძილი")%></td>
                        <td width="100" style="background-color: #428BCA !important; color: white !important;" align='center'></td>
                    </tr>
                </thead>
                <tbody style="height: 180px; overflow:auto; display:block; width: 800px;">
                    <%for(int i=n-1;i>=0;i--){%>
                    <tr>
                        <td width="100" align='right'><%=i+1%></td>
                        <td width="150" align='right'>56</td>
                        <td width="150">გსდგჰჯ დფჯდფჰკკ</td>
                        <td width="150" align='right'>43</td>
                        <td width="150" align='center'>01/08/2017 12:23</td>
                        <td width="100" align='center'>
                            <button onclick="delEnvitem()" class="btn btn-danger pull-right" data-original-title="<%=trs.t("წაშლა")%>" type="button">
                                 <i class="fa fa-trash"></i> 
                            </button>
                            <button onclick="" class="btn btn-warning pull-right" data-original-title="<%=trs.t("რედაქტირება")%>" type="button">
                                 <i class="fa fa-pencil"></i> 
                            </button>
                        </td>
                    </tr>
                    <%}%>
                </tbody>
                <tfoot>
                    <tr>
                        <td width="100"></td>
                        <td width="150"></td>
                        <td width="150"></td>
                        <td width="150"></td>
                        <td width="150" align="right"><%=trs.t("სულ")%></td>
                        <td width="100" align="right"><b><%=n%></b></td>
                    </tr>
                </tfoot>
            </table>
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