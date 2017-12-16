<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    int level = Integer.parseInt(request.getParameter("level"));
    SampleitemreseachBean sb = SampleitemreseachManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("id")));
    boolean tp = false;
    if(level == 2){
        if(sb.getConfirmation2id() != null) tp = true;
    } else if(level == 3){
        if(sb.getConfirmation3id() != null) tp = true;
    }
%>
<script>
    $.post("content/getreport.jsp",{ name: "internalanswer", id: <%=sb.getSampleitemreseachid()%> },function(data){
        if(data.result == 0)    alert(data.error);
        else {
            var fname = data.filename;
            $("#resultview").attr("src","content/displayinline.jsp?name="+fname);
        }
        dialog.close();
    },"json");
    
    function confirmlevel(l,tp){
        var msg = '<%=trs.t("დარწმუნებული ხართ რომ გინდათ უარყოთ შედეგები?")%>';
        if(!tp)  msg = '<%=trs.t("დარწმუნებული ხართ რომ გინდათ შედეგების დამოწმება?")%>';
        if(confirm(msg))
            setConfirmAns(true,l,<%=sb.getSampleitemreseachid()%>);
        /*
        if(l == 2)
            ConfirmMessageArg('< %=trs.t("ყურადღება")%>',msg,['< %=trs.t("არა")%>','< %=trs.t("დიახ")%>'],setConfirmAns2,< %=sb.getSampleitemreseachid()%>);
        if(l == 3)
            ConfirmMessageArg('< %=trs.t("ყურადღება")%>',msg,['< %=trs.t("არა")%>','< %=trs.t("დიახ")%>'],setConfirmAns3,< %=sb.getSampleitemreseachid()%>);
        */
    }
    
function setConfirmAns(result,level,id){
    if(result){
        $.post("content/setconfirm.jsp", { id: id, level: level }, function (data) {
            if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
            else {
                //$("#answers2").trigger("reloadGrid");
                if(data.tp == 1){
                    $("#rejectlevel").show();
                    $("#confirmlevel").hide();
                    
                    $("#rejectlevel").attr("onclick","confirmlevel(<%=level%>,false)");
                    $("#confirmlevel").attr("onclick","confirmlevel(<%=level%>,true)");
                    
                    $("#btn_<%=level%>_"+id).removeClass("btn-warning").addClass("btn-success");
                } else {
                    $("#confirmlevel").show();
                    $("#rejectlevel").hide();
                    
                    $("#rejectlevel").attr("onclick","confirmlevel(<%=level%>,true)");
                    $("#confirmlevel").attr("onclick","confirmlevel(<%=level%>,false)");
                    $("#btn_<%=level%>_"+id).removeClass("btn-success").addClass("btn-warning");
                }
                
            }
        },"json");
    }
}

<%if(tp){%>
$("#rejectlevel").show();
$("#confirmlevel").hide();
<%}else{%>
$("#confirmlevel").show();
$("#rejectlevel").hide();
<%}%>
</script>
<table width="100%" align="center">
    <tr>
        <td valign="top" align="center">
            <iframe id="resultview" width="550" height="400" src="img/wait30trans.gif"></iframe>
        </td>
    </tr>
    <tr>
        <td valign="top" align="center">
            <button class="btn btn-success" id="confirmlevel" style="margin-right: 5px;" onclick="confirmlevel(<%=level%>,<%=tp%>)"><i class="fa fa-check"></i> <%=trs.t("კონფირმაცია")%></button>
            <button class="btn btn-danger" id="rejectlevel" style="margin-right: 5px;" onclick="confirmlevel(<%=level%>,<%=tp%>)"><i class="fa fa-times"></i> <%=trs.t("უარყოფა")%></button>
        </td>
    </tr>
</table>

