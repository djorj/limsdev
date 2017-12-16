<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    int n = 2;
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
        <div class="col col-sm-12">
            <table class="table table-striped" style="width: 800px; display:block;">
                <thead>
                    <tr>
                        <td width="20">N</td>
                        <td width="300"><%=trs.t("კონტაქტირებული")%></td>
                        <td width="200"><%=trs.t("ნიმუშის ტიპი")%></td>
                        <td width="150"><%=trs.t("ჭურჭლის N")%></td>
                        <td width="130"><%=trs.t("აღების დრო")%></td>
                    </tr>
                </thead>
                <tbody style="height: 280px; overflow:auto; display:block; width: 800px;">
                    <%for(int i=0;i<n;i++){%>
                    <tr>
                        <td width="20"><%=i+1%></td>
                        <td width="300">შალვა ნათელაშვილი</td>
                        <td width="200">
                            <label class="select">
                                <select>
                                    <option value="1"><%=trs.t("სისხლი")%></option>
                                    <option value="2"><%=trs.t("ნაცხი")%></option>
                                </select>
                            </label>
                        </td>
                        <td width="150">
                            <label class="input">
                                <input type="text">
                                
                            </label>
                        </td>
                        <td width="130">
                            <label class="input">
                                <input class="timepicker" type="text">
                            </label>
                        </td>
                        
                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
    </div>
</div>
<script src="js/plugin/bootstrap-tags/bootstrap-tagsinput.min.js" type="text/javascript"></script>
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>
<script>
                                    pageSetUp();

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