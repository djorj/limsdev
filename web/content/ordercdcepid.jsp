<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    int n = 0;
    if(request.getParameter("n") != null)
        n = Integer.parseInt(request.getParameter("n"));
    SampletypeBean[] stps = SampletypeManager.getInstance().loadByWhere("where companyid = "+user.getCompanyid()+" order by name");
%>
<script>
    function delEpiditem(){
        var n = <%=n%>-1;
        $.post("content/ordercdcepid.jsp",{ n: n },function(data){ $("#s4").html(data); });
    }
    
    function addEpiditem(){
        var n = <%=n%>+1;
        $.post("content/ordercdcepid.jsp",{ n: n },function(data){ $("#s4").html(data); });
    }

</script>
<div class="smart-form">
    
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                <input placeholder="<%=trs.t("ნიმუშ(ებ)ის ჭურჭლის N")%>" type="text">
                <b class="tooltip tooltip-bottom-right"><i class="fa fa-list-ol txt-color-teal"></i> <%=trs.t("ნიმუშ(ებ)ის ჭურჭლის N")%></b>
            </label>
        </div>
        <div class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                <input class="timepicker" placeholder="<%=trs.t("აღების დრო")%>" type="text">
                <b class="tooltip tooltip-bottom-right"><i class="fa fa-clock-o txt-color-teal"></i> <%=trs.t("ნიმუშის აღების დრო")%></b>
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
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-4">
            <label class="input" style="margin-bottom: 5px !important;"> <i class="icon-append fa fa-map-marker"></i>
                <input placeholder="<%=trs.t("ნიმუშ(ებ)ის აღების ადგილი")%>" type="text">
                <b class="tooltip tooltip-bottom-right"><i class="fa fa-map-marker txt-color-teal"></i> <%=trs.t("ნიმუშ(ებ)ის აღების ადგილი")%></b>
            </label>
        </div>
        <div class="col col-sm-6">
            <label class="input" style="margin-bottom: 5px !important;"> <i class="icon-append fa fa-users"></i>
                <input class="tagsinput" data-role="tagsinput" placeholder="<%=trs.t("ამღები პირები")%>" type="text">
                <b class="tooltip tooltip-bottom-right"><i class="fa fa-users txt-color-teal"></i> <%=trs.t("ნიმუშის ამღები პირები")%></b>
            </label>
        </div>
        <div class="col col-sm-2">
            <button onclick="addEpiditem()" class="btn btn-success" data-original-title="<%=trs.t("დამატება")%>" type="button">
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
                        <td width="80" style="background-color: #428BCA !important; color: white !important;"><%=trs.t("დრო")%></td>
                        <td width="150" style="background-color: #428BCA !important; color: white !important;"><%=trs.t("პათოგენი")%></td>
                        <td width="150" style="background-color: #428BCA !important; color: white !important;"><%=trs.t("მარკერი")%></td>
                        <td width="150" style="background-color: #428BCA !important; color: white !important;"><%=trs.t("ადგილი")%></td>
                        <td width="150" style="background-color: #428BCA !important; color: white !important;"><%=trs.t("ამღები")%></td>
                        <td width="100" style="background-color: #428BCA !important; color: white !important;"></td>
                    </tr>
                </thead>
                <tbody style="height: 180px; overflow:auto; display:block; width: 800px;">
                    <%for(int i=n-1;i>=0;i--){%>
                    <tr>
                        <td width="20"><%=i+1%></td>
                        <td width="80">10:00</td>
                        <td width="150">Bacillus Anthracis</td>
                        <td width="150">იმუნოგლობულინი</td>
                        <td width="150">ამბროლაურის რ-ნი ს.მეორე ტოლა</td>
                        <td width="150">ნათელაშვილი შალვა</td>
                        <td width="100">
                            <button onclick="delEpiditem()" class="btn btn-danger pull-right" data-original-title="<%=trs.t("წაშლა")%>" type="button">
                                 <i class="fa fa-trash"></i> 
                            </button>
                        </td>
                    </tr>
                    <%}%>
                </tbody>
                <tfoot>
                    <tr>
                        <td width="20"></td>
                        <td width="80"></td>
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