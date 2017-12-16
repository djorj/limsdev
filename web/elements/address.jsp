<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String sz = "sm"; // lg xs sm
int countryid = 76;
if(request.getParameter("countryid") != null)
    countryid = Integer.parseInt(request.getParameter("countryid"));
%>
<script>
    pageSetUp();
    
    function getTunit(ctrl,label,punitid,selid,idname){
        $.post("elements/gettunitselect.jsp", {
            label: label,
            punitid: punitid,
            selid: selid,
            countryid: <%=countryid%>,
            sz: '<%=sz%>',
            idname: idname
        }, function(data){
            $("#"+ctrl).html(data);
        },"html");
    }
    
    function regionidchanged(pid){
        getTunit("raionselect","<%=trs.t("რაიონი")%>",pid,0,"raionid");
        $("#addressselect").hide();
    }
    
    function raionidchanged(pid){
        getTunit("cityselect","<%=trs.t("ქალაქი/სოფელი")%>",pid,0,"cityid");
        $("#addressselect").hide();
    }
    
    function cityidchanged(pid){
        $("#addressselect").show();
    }
    
    jQuery().ready(function (){
        $("#addressselect").hide();
        getTunit("regionselect","<%=trs.t("რეგიონი")%>",0,0,"regionid");
        
    });
</script>
<fieldset>
<section id="regionselect"></section>
<section id="raionselect"></section>
<section id="cityselect"></section>
<section id="addressselect">
    <label class="textarea textarea-resizable"><textarea rows="3" class="custom-scroll" style="width: 250px;" placeholder="<%=trs.t("მისამართი")%>"></textarea></label>
</section>
</fieldset>