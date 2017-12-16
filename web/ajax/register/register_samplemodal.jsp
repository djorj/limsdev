<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../includes/init.jsp" %>
<div class="modal fade" id="sampleModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ნიმუში")%><span id="h4sampletype"></span></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
<form id="frmsampletype" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" value="add" type="hidden">
<input name="isbox" type="hidden">
<input name="contractid" type="hidden">
<input name="sampleid" type="hidden">
  
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-id-card"></i>
                                        <input name="boxnum" placeholder="<%=trs.t("ყუთის ნომერი")%>" type="text">
                                    </label>
                                </section>
                                <section class="col col-md-4">
                                    <label class="input"> <i class="icon-append fa fa-id-card"></i>
                                        <input name="quantity" placeholder="<%=trs.t("ნიმუშის რაოდენობა")%>" type="text">
                                    </label>
                                </section>
</form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("დახურვა")%></button>
                <button type="button" class="btn btn-success" onclick="addSample(); return false;"><%=trs.t("დამატება")%></button>
            </footer>
        </div>
    </div>
</div>