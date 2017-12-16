<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../includes/init.jsp" %>
<div class="modal fade" id="msgModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog large">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ყურადღება")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form" id="frmclosingbody" >
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("დახურვა")%></button>
                <button type="button" class="btn btn-success" onclick="submitClosing(); return false;"><%=trs.t("დამახსოვრება")%></button>
            </footer>
        </div>
    </div>
</div>