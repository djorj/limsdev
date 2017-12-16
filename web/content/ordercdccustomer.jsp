<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    int n = 0;
    if(request.getParameter("n") != null)
        n = Integer.parseInt(request.getParameter("n"));
    SampletypeBean[] stps = SampletypeManager.getInstance().loadByWhere("where companyid = "+user.getCompanyid()+" order by name");
%>
<script>
    function delOrderitem(){
        var n = <%=n%>-1;
        $.post("content/ordercdccustomer.jsp",{ n: n },function(data){ $("#s3").html(data); });
    }
    
    function addOrderitem(){
        var n = <%=n%>+1;
        $.post("content/ordercdccustomer.jsp",{ n: n },function(data){ $("#s3").html(data); });
    }

</script>
<div class="smart-form">
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-6">
            <label class="checkbox" style="margin-bottom: 5px !important;"><input name="checkbox" type="checkbox"><i></i><%=trs.t("კულტურის დადასტურება")%></label>
        </div>
        <div class="col col-sm-6">
            <label class="checkbox" style="margin-bottom: 5px !important;"><input name="checkbox" type="checkbox"><i></i><%=trs.t("კულტურის შენახვა")%></label>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-6">
            <label class="checkbox" style="margin-bottom: 5px !important;"><input name="checkbox" type="checkbox"><i></i><%=trs.t("ნიმუშის კვლევა")%></label>
        </div>
        <div class="col col-sm-6">
            <label class="checkbox" style="margin-bottom: 5px !important;"><input name="checkbox" type="checkbox"><i></i><%=trs.t("სინჯის კვლევა")%></label>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-12"><hr></div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-5" id="controlcase1">
            <label class="select">
                <select id="labtestid" class="select2" multiple="" placeholder="<%=trs.t("გამოკვლევის მეთოდი")%>">
                    <option value="1"><%=trs.t("ბაქტერიოლოგიური")%></option>
                    <option value="2"><%=trs.t("სეროლოგიური")%></option>
                </select>
                <b class="tooltip tooltip-bottom-right"><%=trs.t("გამოკვლევის მეთოდი")%></b>
            </label>
        </div>
        <div class="col col-sm-5" id="sampletype">
            <label class="select">
                
                <select>
                    <option value="0"><%=trs.t("- ნიმუშის ტიპი -")%></option>
                    <option value="1"><%=trs.t("სისხლი")%></option>
                    <option value="2"><%=trs.t("ნაცხი")%></option>
                    <%
                    for(int i=0;i<stps.length;i++){
                    %>
                    <option value="<%=stps[i].getSampletypeid()%>"><%=trs.t(stps[i].getName())%></option>
                    <%}%>
                </select><i></i>
                <b class="tooltip tooltip-bottom-right"><%=trs.t("ნიმუშის ტიპი")%></b>
            </label>
        </div>
        <div class="col col-sm-2" id="addsampletype">
            <button onclick="addOrderitem()" class="btn btn-success" data-original-title="<%=trs.t("დამატება")%>" type="button">
                <%=trs.t("დამატება")%> <i class="fa fa-plus"></i> 
            </button>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <hr>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-12">
            <table class="table table-striped" style="width: 800px; display:block;">
                <thead>
                    <tr style="background-color: #428BCA !important;">
                        <td width="20" style="background-color: #428BCA !important; color: white !important;">N</td>
                        <td width="400" style="background-color: #428BCA !important; color: white !important;"><%=trs.t("გამოკვლევის მეთოდი")%></td>
                        <td width="280" style="background-color: #428BCA !important; color: white !important;"><%=trs.t("ნიმუში")%></td>
                        <td width="100" style="background-color: #428BCA !important; color: white !important;"></td>
                    </tr>
                </thead>
                <tbody style="height: 180px; overflow:auto; display:block; width: 800px;">
                    <%for(int i=n-1;i>=0;i--){%>
                    <tr>
                        <td width="20"><%=i+1%></td>
                        <td width="400"><%=trs.t("ბაქტერიოლოგიური")%></td>
                        <td width="280"><%=trs.t("სისხლი")%></td>
                        <td width="100">
                            <button onclick="delOrderitem()" class="btn btn-danger pull-right" data-original-title="<%=trs.t("წაშლა")%>" type="button">
                                 <i class="fa fa-trash"></i> 
                            </button>
                        </td>
                    </tr>
                    <%}%>
                </tbody>
                <tfoot>
                    <tr>
                        <td width="20"></td>
                        <td width="400"></td>
                        <td width="280" align="right"><%=trs.t("სულ")%></td>
                        <td width="100" align="right"><b><%=n%></b></td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
</div>

<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>
<script>
        pageSetUp();
/*
        $("#sampletype").hide();
        $("#addsampletype").hide();
        
        $("#labtestid").on('change',function(){ 
            if($("#labtestid").val() == 0)   { $("#sampletype").hide(); $("#addsampletype").hide(); }
            else                             { $("#sampletype").show(); $("#addsampletype").show(); }
        });
        */
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