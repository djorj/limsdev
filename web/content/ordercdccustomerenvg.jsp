<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    int n = 5;
    if(request.getParameter("n") != null)
        n = Integer.parseInt(request.getParameter("n"));
    SampletypeBean[] stps = SampletypeManager.getInstance().loadByWhere("where companyid = "+user.getCompanyid()+" order by name");
%>
<script>
    function delEpiditem(){
        var n = <%=n%>-1;
        $.post("content/ordercdcepidenvg.jsp",{ n: n },function(data){ $("#s3").html(data); });
    }
    
    function addEpiditem(){
        var n = <%=n%>+1;
        $.post("content/ordercdcepidenvg.jsp",{ n: n },function(data){ $("#s3").html(data); });
    }

</script>
<div class="smart-form">
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-12">
            <table class="table table-striped" style="width: 800px; display:block;">
                <thead>
                    <tr style="background-color: #428BCA !important;">
                        <td width="200" style="background-color: #428BCA !important; color: white !important;" align='center'><%=trs.t("ობიექტი")%></td>
                        <td width="200" style="background-color: #428BCA !important; color: white !important;" align='center'><%=trs.t("დასახელება")%></td>
                        <td width="200" style="background-color: #428BCA !important; color: white !important;" align='center'><%=trs.t("საკვლევი პათოგენი")%></td>
                        <td width="200" style="background-color: #428BCA !important; color: white !important;" align='center'><%=trs.t("მარკერი")%></td>
                    </tr>
                </thead>
                <tbody style="height: 255px; overflow:auto; display:block; width: 800px;">
                    <%for(int i=n-1;i>=0;i--){%>
                    <tr>
                        <td width="200" align='right'>sdgjhdfgjdfj</td>
                        <td width="200">გსდგჰჯ დფჯდფჰკკ</td>
                        <td width="200">
                            <label class="select">
                                <select placeholder="<%=trs.t("საკვლევი პათოგენი")%>">
                                    <option value="0"><%=trs.t("- საკვლევი პათოგენი -")%></option>
                                    <option value="1">Bacillus Anthracis</option>
                                    <option value="2">Francisella Tularensis</option>
                                    <option value="3">Yersinia Pestis</option>
                                    <option value="4">Parapox Virus</option>
                                    <option value="5">Escherichia Koli</option>
                                </select>
                            </label>
                        </td>
                        <td width="200">
                            <label class="select">
                                <select placeholder="<%=trs.t("მარკერი")%>">
                                    <option value="0"><%=trs.t("- მარკერი -")%></option>
                                    <option value="1"><%=trs.t("იმუნოგლობულინი")%></option>
                                    <option value="2"><%=trs.t("AFP")%></option>
                                    <option value="2"><%=trs.t("PCA")%></option>
                                </select>
                            </label>
                        </td>
                    </tr>
                    <%}%>
                </tbody>
                <tfoot>
                    <tr>
                        <td width="200"></td>
                        <td width="200"></td>
                        <td width="200" align="right"><%=trs.t("სულ")%></td>
                        <td width="200" align="right"><b><%=n%></b></td>
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