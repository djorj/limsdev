<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<script>
    function loadMessages(){
        $.post("content/getmessagelist.jsp",{},function(data){ $("#messagelist").html(data); },"html");
    }
    
    function tLoadMessages(n){
        $.post("content/getmessagelist.jsp",{},function(data){ 
            $("#messagelist").html(data); 
            setTimeout(function(){
                tLoadMessages(n);
            },n);
        },"html");
    }
    
    function updmsg(id,oper){
        $.post("content/updmsg.jsp",{ id: id, oper: oper },function(data){ 
            if(data.result == 0)    alert(data.error);
            else                    {
                loadMessages();
                checkmessages();
            }
        },"json");
    }
    
    $(document).ready(function () {
        tLoadMessages(<%=msgtimeout%>);
        $("#divbigBoxes").html("");
        $("#divMiniIcons").html("");
        $("#messagelist :button").tooltip({
            position: "center right",
            offset: [-2, 10],
            effect: "fade",
            opacity: 0.7
            });
    });
</script>
<div id="messagelist"></div>
