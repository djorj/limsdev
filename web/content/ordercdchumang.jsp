<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    String clb = trs.t("პაციენტის მოქალაქეობა");
    int n = 0;
    if(request.getParameter("n") != null)
        n = Integer.parseInt(request.getParameter("n"));
%>
<script>
    $("#nonres").on("click",function(){
        if($(this).is(':checked')) {
            $(".control7").show();
        } else $(".control7").hide();
    });
    
    function delPatitem(){
        var n = <%=n%>-1;
        $.post("content/ordercdchumang.jsp",{ n: n },function(data){ $("#s2").html(data); });
    }
    
    function addPatitem(){
        var n = <%=n%>+1;
        $.post("content/ordercdchumang.jsp",{ n: n },function(data){ $("#s2").html(data); });
    }
</script>
<div class="smart-form">
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-4">
            <label class="checkbox">
                <input name="checkbox1" id="nonres" type="checkbox">
                <i></i><%=trs.t("არარეზიდენტი")%></label>
        </div>
        <div class="col col-sm-4 control7" style="display: none;">
            <label class="input"> <i class="icon-append fa fa-id-card"></i>
                <input placeholder="<%=trs.t("პასპორტის N")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-id-card txt-color-teal"></i> <%=trs.t("პაციენტის პასპორტის N")%></b>
            </label>
        </div>
        <div class="col col-sm-4 control7" style="display: none;">
            <label class="select">
                <jsp:include page="../elements/country.jsp">
                    <jsp:param name="label" value="<%=clb%>"></jsp:param>
                    <jsp:param name="idname" value="countryid1"></jsp:param>
                    <jsp:param name="countryid" value="0"></jsp:param>
                </jsp:include>
                <i></i>
                <b class="tooltip tooltip-top-right"><%=trs.t("პაციენტის მოქალაქეობა")%></b>
            </label>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-4 control6">
            <div class="input-group">
                <label class="input"> <i class="icon-append fa fa-id-card"></i>
                    <input class="mask" placeholder="<%=trs.t("პირადი N")%>" type="text">
                    <b class="tooltip tooltip-top-right"><i class="fa fa-id-card txt-color-teal"></i> <%=trs.t("პაციენტის პირადი N")%></b>
                </label>
                <div class="input-group-btn">
                    <button class="btn btn-success" data-original-title="<%=trs.t("შემოწმება")%>" type="button">
                        <i class="fa fa-check"></i>
                    </button>
                </div>
            </div>
        </div>
        <div class="col col-sm-4">
            <label class="input"> <i class="icon-append fa fa-user"></i>
                <input placeholder="<%=trs.t("სახელი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("პაციენტის სახელი")%></b>
            </label>
        </div>
        <div class="col col-sm-4">
            <label class="input"> <i class="icon-append fa fa-user"></i>
                <input placeholder="<%=trs.t("გვარი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-user txt-color-teal"></i> <%=trs.t("პაციენტის გვარი")%></b>
            </label>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-calendar"></i>
                <input class="datepicker" placeholder="<%=trs.t("დაბადების თარიღი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-calendar txt-color-teal"></i> <%=trs.t("პაციენტის დაბადების თარიღი")%></b>
            </label>
        </div>
        <div class="col col-sm-6">
            <label class="select">
                <select>
                    <option value="0"><%=trs.t("- სქესი -")%></option>
                    <option value="F"><%=trs.t("ქალი")%></option>
                    <option value="M"><%=trs.t("კაცი")%></option>
                </select><i></i>
                <b class="tooltip tooltip-top-right"><%=trs.t("პაციენტის სქესი")%></b>
            </label>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <jsp:include page="../elements/address.jsp">
            <jsp:param name="suffix" value="1"></jsp:param>
            <jsp:param name="colmd" value="4"></jsp:param>
        </jsp:include>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-3">
            <label class="input"> <i class="icon-append fa fa-fax"></i>
                <input placeholder="<%=trs.t("საფოსტო ინდექსი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-fax txt-color-teal"></i> <%=trs.t("პაციენტის საფოსტო ინდექსი")%></b>
            </label>
        </div>
        <div class="col col-sm-4">
            <label class="input"> <i class="icon-append fa fa-phone"></i>
                <input placeholder="<%=trs.t("ტელეფონი")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-phone txt-color-teal"></i> <%=trs.t("პაციენტის ტელეფონი")%></b>
            </label>
        </div>
        <div class="col col-sm-4">
            <label class="input"> <i class="icon-append fa fa-envelope"></i>
                <input placeholder="<%=trs.t("ელ-ფოსტა")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-envelope txt-color-teal"></i> <%=trs.t("პაციენტის ელ-ფოსტა")%></b>
            </label>
        </div>
        <div class="col col-sm-1">
            <button onclick="addPatitem()" class="btn btn-success" data-original-title="<%=trs.t("დამატება")%>" type="button">
                 <i class="fa fa-plus"></i> 
            </button>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-12">
            <table class="table table-striped" style="width: 800px; display:block;">
                <thead>
                    <tr style="background-color: #428BCA !important;">
                        <td width="20" style="background-color: #428BCA !important; color: white !important;">N</td>
                        <td width="330" style="background-color: #428BCA !important; color: white !important;"><%=trs.t("სახელი, გვარი")%></td>
                        <td width="100" style="background-color: #428BCA !important; color: white !important;"><%=trs.t("პირადი N")%></td>
                        <td width="100" style="background-color: #428BCA !important; color: white !important;"><%=trs.t("სქესი")%></td>
                        <td width="150" style="background-color: #428BCA !important; color: white !important;"><%=trs.t("დაბ. თარიღი")%></td>
                        <td width="100" style="background-color: #428BCA !important; color: white !important;"></td>
                    </tr>
                </thead>
                <tbody style="height: 90px; overflow:auto; display:block; width: 800px;">
                    <%for(int i=n-1;i>=0;i--){%>
                    <tr>
                        <td width="20"><%=i+1%></td>
                        <td width="330">შალვა ნათელაშვილი</td>
                        <td width="100">010101010</td>
                        <td width="100">კაცი</td>
                        <td width="150">01/01/1960</td>
                        <td width="100">
                            <button onclick="delPatitem()" class="btn btn-danger pull-right" data-original-title="<%=trs.t("წაშლა")%>" type="button">
                                 <i class="fa fa-trash"></i> 
                            </button>
                            <button onclick="editPatitem()" class="btn btn-warning pull-right" data-original-title="<%=trs.t("რედაქტირება")%>" type="button">
                                 <i class="fa fa-pencil"></i> 
                            </button>
                        </td>
                    </tr>
                    <%}%>
                </tbody>
                <tfoot>
                    <tr>
                        <td width="20"></td>
                        <td width="330"></td>
                        <td width="100"></td>
                        <td width="100"></td>
                        <td width="150" align="right"><%=trs.t("სულ")%></td>
                        <td width="100" align="right"><b><%=n%></b></td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
</div>