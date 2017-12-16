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
<div class="row" style="margin-bottom: 5px !important;">
    <div class="col col-sm-9">
        <label class="input"> <i class="icon-append fa fa-user"></i>
        <input list="patient" id="newpatient" placeholder="<%=trs.t("პაციენტი")%>" type="text">
        <b class="tooltip tooltip-bottom-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("შეიყვანეთ პაციენტის პირადი ნომერი ან გვარი")%></b>
        <datalist id="patient">
            <option value="20947250532"></option>
            <option value="20486104211"></option>
            <option value="21136177647"></option>
            <option value="46001001156"></option>
            <option value="21135188301"></option>
        </datalist>
    </label></div>
    <div class="col col-sm-1">
        <button onclick="clearPat()" class="btn btn-danger" data-original-title="<%=trs.t("გასუფთავება")%>" type="button">
            <i class="fa fa-close"></i> 
        </button>
    </div>
    <div class="col col-sm-2">
        <button onclick="addItem()" class="btn btn-success" data-original-title="<%=trs.t("პაციენტის დამატება")%>" type="button">
            <%=trs.t("დამატება")%> <i class="fa fa-plus"></i> 
        </button>
    </div>
</div>
<div class="row">
    <div class="col col-sm-12">
        
        <div class="panel-group smart-accordion-default" id="patientlist">
            <%for(int i=0;i<n;i++){%>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        
                        <a data-toggle="collapse" data-parent="#accordion" href="#patient<%=i%>" aria-expanded="false" class=""> 
                            
                            <i class="fa fa-lg fa-angle-down pull-right"></i> 
                            <i class="fa fa-lg fa-angle-up pull-right"></i> 
                            პაციენტი <%=(n==1) ? "":String.valueOf(i+1)%>: <b>ელდარ გიორგაძე</b> 
                        </a>
                        
                    </h4>
                </div>
                <div id="patient<%=i%>" class="panel-collapse collapse <%=(n == 1) ? "in":""%>" aria-expanded="false" style="">
                    <div class="panel-body no-padding">
                        <table class="table table-striped">
                            <tr>
                                <td align="right" nowrap><b><%=trs.t("პირადი ნომერი")%>:</b></td>
                                <td style="overflow: hidden;">100234678901</td>
                                <td align="right" nowrap><b><%=trs.t("დაბადების თარიღი")%>:</b></td>
                                <td style="overflow: hidden;">22/05/1978</td>
                                <td align="right" nowrap><b><%=trs.t("სქესი")%>:</b></td>
                                <td><%=trs.t("კაცი")%></td>
                            </tr>
                            <tr>
                                <td align="right" nowrap><b><%=trs.t("საფოსტო ინდექსი")%>:</b></td>
                                <td style="overflow: hidden;">6354</td>
                                <td align="right" nowrap><b><%=trs.t("ტელეფონი")%>:</b></td>
                                <td style="overflow: hidden;">+995 577 453627</td>
                                <td align="right" nowrap><b><%=trs.t("ელ-ფოსტა")%>:</b></td>
                                <td style="overflow: hidden;">eldar@mail.com</td>
                            </tr>
                            <tr>
                                <td align="right" valign="top" nowrap><b><%=trs.t("მისამართი")%>:</b></td>
                                <td colspan="4" style="overflow: hidden;">
                                    <%=trs.t("საქართველო")%>, 
                                    <%=trs.t("გურიის მხარე")%>,
                                    <%=trs.t("ოზურგეთის რაიონი")%>,
                                    <%=trs.t("სოფ.")%> <%=trs.t("იანეთი")%>, 
                                    <%=trs.t("მე-5 შესახვევი #3")%>
                                </td>
                                <td colspan="1" align="center" nowrap>
                                    <table>
                                        <tr>
                                            <td>
                                                <button onclick="editItem()" type="button" class="btn btn-xs btn-warning pull-right" title="<%=trs.t("რედაქტირება")%>">
                                                     <span class="fa fa-pencil"></span>
                                                </button>
                                            </td>
                                            <%if(n>1){%>
                                            <td align="right" style="padding-left: 5px;">
                                                <button onclick="delItem()" type="button" class="btn btn-xs btn-danger pull-right" title="<%=trs.t("წაშლა")%>">
                                                     <span class="fa fa-trash"></span>
                                                </button>
                                            </td>
                                            <%}%>
                                        </tr>
                                    </table>
                                    
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <%}%>
        </div>
    </div>
</div>		


<%--div class="smart-form">
        
        <section class="col col-sm-12 control6">
            <div class="input-group">
                <label class="input"> <i class="icon-append fa fa-id-card"></i>
                    872136547865
                    <b><i class="fa fa-id-card txt-color-teal"></i> <%=trs.t("პაციენტის პირადი N")%></b>
                </label>
                
            </div>
        </section>
        <section class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-user"></i>
                <input placeholder="<%=trs.t("სახელი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("პაციენტის სახელი")%></b>
            </label>
        </section>
        <section class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-user"></i>
                <input placeholder="<%=trs.t("გვარი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("პაციენტის გვარი")%></b>
            </label>
        </section>
        <section class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-calendar"></i>
                <input class="datepicker" placeholder="<%=trs.t("დაბადების თარიღი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("პაციენტის დაბადების თარიღი")%></b>
            </label>
        </section>
        <section class="col col-sm-6">
            <label class="select">
                <select>
                    <option value="0"><%=trs.t("- სქესი -")%></option>
                    <option value="F"><%=trs.t("ქალი")%></option>
                    <option value="M"><%=trs.t("კაცი")%></option>
                </select><i></i>
                <b class="tooltip tooltip-top-right"><%=trs.t("პაციენტის სქესი")%></b>
            </label>
        </section>

        <jsp:include page="../elements/address.jsp">
            <jsp:param name="suffix" value="1"></jsp:param>
            <jsp:param name="colmd" value="4"></jsp:param>
        </jsp:include>

        
        <section class="col col-sm-4">
            <label class="input"> <i class="icon-append fa fa-fax"></i>
                <input placeholder="<%=trs.t("საფოსტო ინდექსი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-fax txt-color-teal"></i> <%=trs.t("პაციენტის საფოსტო ინდექსი")%></b>
            </label>
        </section>
        <section class="col col-sm-4">
            <label class="input"> <i class="icon-append fa fa-phone"></i>
                <input placeholder="<%=trs.t("ტელეფონი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-phone txt-color-teal"></i> <%=trs.t("პაციენტის ტელეფონი")%></b>
            </label>
        </section>
        <section class="col col-sm-4">
            <label class="input"> <i class="icon-append fa fa-envelope"></i>
                <input placeholder="<%=trs.t("ელ-ფოსტა")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-envelope txt-color-teal"></i> <%=trs.t("პაციენტის ელ-ფოსტა")%></b>
            </label>
        </section>
</div--%>