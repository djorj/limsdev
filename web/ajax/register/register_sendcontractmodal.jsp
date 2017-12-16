<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../includes/init.jsp" %>
<div class="modal fade" id="sendcontractModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ყურადღება")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form" id="frmclosingbody" >
<form id="frmsendcontract2lab" action="api/updcontractfield.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" value="sendcontract" type="hidden">
<input name="contractid" type="hidden" value="">
<input name="appealid" type="hidden" value="">
<input name="actid" type="hidden" value="">
                    ნიმუშების გადაცემა  ლაბორატორიისთვის
</form>                  
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("დახურვა")%></button>
                <button type="button" class="btn btn-success" onclick="sendContract2Lab(); return false;"><%=trs.t("გადაცემა")%></button>
            </footer>
        </div>
    </div>
</div>