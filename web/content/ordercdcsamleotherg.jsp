<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    int n = 0;
    if(request.getParameter("n") != null)
        n = Integer.parseInt(request.getParameter("n"));
%>
<script>
    function delEnvitem(){
        var n = <%=n%>-1;
        $.post("content/ordercdcsamleotherg.jsp",{ n: n },function(data){ $("#s2").html(data); });
    }
    
    function addEnvitem(){
        var n = <%=n%>+1;
        $.post("content/ordercdcsamleotherg.jsp",{ n: n },function(data){ $("#s2").html(data); });
    }

</script>
<div class="smart-form">
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-globe"></i>
                <input placeholder="<%=trs.t("საკვლევი მასალის ტიპი")%>" type="text">
                <b class="tooltip tooltip-bottom-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("საკვლევი მასალის ტიპი")%></b>
            </label>
        </div>
        <div class="col col-sm-6">
            <label class="input"> <i class="icon-append fa fa-globe"></i>
                <input placeholder="<%=trs.t("სერიული ნომერი")%>" type="text">
                <b class="tooltip tooltip-bottom-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("სერიული ნომერი")%></b>
            </label>
        </div>
    </div>
    <div class="row" style="margin-bottom: 5px !important;">
        <div class="col col-sm-5">
            <label class="input"> <i class="icon-append fa fa-globe"></i>
                <input placeholder="<%=trs.t("დასახელება")%>" type="text">
                <b class="tooltip tooltip-bottom-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("დასახელება")%></b>
            </label>
        </div>
        <div class="col col-sm-5">
            <label class="input"> <i class="icon-append fa fa-globe"></i>
                <input placeholder="<%=trs.t("ვარგისიანობის ვადა")%>" type="text">
                <b class="tooltip tooltip-top-right"><i class="fa fa-globe txt-color-teal"></i> <%=trs.t("ვარგისიანობის ვადა")%></b>
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
                        <td width="200" style="background-color: #428BCA !important; color: white !important;" align='center'><%=trs.t("ტიპი")%></td>
                        <td width="150" style="background-color: #428BCA !important; color: white !important;" align='center'><%=trs.t("ნომერი")%></td>
                        <td width="200" style="background-color: #428BCA !important; color: white !important;" align='center'><%=trs.t("დასახელება")%></td>
                        <td width="150" style="background-color: #428BCA !important; color: white !important;" align='center'><%=trs.t("ვადა")%></td>
                        <td width="100" style="background-color: #428BCA !important; color: white !important;" align='center'></td>
                    </tr>
                </thead>
                <tbody style="height: 180px; overflow:auto; display:block; width: 800px;">
                    <%for(int i=n-1;i>=0;i--){%>
                    <tr>
                        <td width="200" align='right'><%=trs.t("სადეზინფექციო ხსნარი")%></td>
                        <td width="150" align='right'>LOT - 4174096</td>
                        <td width="200">„SOLUSCOPE GTA“</td>
                        <td width="150" align='center'>06/2019</td>
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
                        <td width="200"></td>
                        <td width="150"></td>
                        <td width="200"></td>
                        <td width="150" align="right"><%=trs.t("სულ")%></td>
                        <td width="100" align="right"><b><%=n%></b></td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
</div>