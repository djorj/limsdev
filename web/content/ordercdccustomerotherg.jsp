<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    int n = 4;
    if(request.getParameter("n") != null)
        n = Integer.parseInt(request.getParameter("n"));
    SampletypeBean[] stps = SampletypeManager.getInstance().loadByWhere("where companyid = "+user.getCompanyid()+" order by name");
%>
<script>
    

</script>
<div class="smart-form">
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-12">
            <table class="table table-striped" style="width: 800px; display:block;">
                <thead>
                    <tr style="background-color: #428BCA !important;">
                        <td width="150" style="background-color: #428BCA !important; color: white !important;" align='center'><%=trs.t("ტიპი")%></td>
                        <td width="100" style="background-color: #428BCA !important; color: white !important;" align='center'><%=trs.t("ნომერი")%></td>
                        <td width="150" style="background-color: #428BCA !important; color: white !important;" align='center'><%=trs.t("დასახელება")%></td>
                        <td width="150" style="background-color: #428BCA !important; color: white !important;" align='center'><%=trs.t("მეთოდი")%></td>
                        <td width="150" style="background-color: #428BCA !important; color: white !important;" align='center'><%=trs.t("მასალა")%></td>
                        <td width="100" style="background-color: #428BCA !important; color: white !important;" align='center'></td>
                    </tr>
                </thead>
                <tbody style="height: 280px; overflow:auto; display:block; width: 800px;">
                    <%for(int i=n-1;i>=0;i--){%>
                    <tr>
                        <td width="150" align='left'><%=trs.t("სადეზინფექციო ხსნარი")%></td>
                        <td width="100" align='left'>LOT - 4174096</td>
                        <td width="150">„SOLUSCOPE GTA“</td>
                        <td width="150" align='center'>
                            <label class="select">
                                <select id="labtestid" >
                                    <option value="1"><%=trs.t("ბაქტერიოლოგიური")%></option>
                                    <option value="2"><%=trs.t("სეროლოგიური")%></option>
                                </select>
                            </label>
                        </td>
                        <td width="150" align='center'>
                            <label class="input"> <i class="icon-append fa fa-globe"></i>
                                <input  type="text">
                            </label>
                        </td>
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
                        <td width="150"></td>
                        <td width="100"></td>
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