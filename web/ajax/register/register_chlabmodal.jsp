<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../includes/init.jsp" %>
<div class="modal fade" id="chlabModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("აირჩიეთ ლაბორატორია")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form" id="frmchlab">
<form id="frminstitution" action="api/setanalysis.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" value="edit" type="hidden">
<input name="contractid" type="hidden">
<input name="id" type="hidden">
                    <section class="col col-sm-12">
                        <label class="select">
                            <select id="institution" name="institutionid"  style="width:100%;">
                            </select> 
                        </label>
                    </section>
</form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("დახურვა")%></button>
                <button type="button" class="btn btn-success" onclick="submitInstitution(); return false;"><%=trs.t("შენახვა")%></button>
            </footer>
        </div>
    </div>
</div>