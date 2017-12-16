<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../includes/init.jsp" %>
<div class="modal fade" id="banModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ყურადღება")%></h4>
            </div>
            <div class="modal-body">
                <h2 id="message"><%=trs.t("დარწმუნებული ხართ, რომ გნებავთ ნიმუშის დაწუნება?")%></h2>
                <div class="smart-form">
<form id="frmbanitem" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden" value="banitem">
<input name="id" type="hidden">
                    <section class="col col-sm-12">
                        <label class="label"><%=trs.t("დაწუნების მიზეზი")%></label>
                        <label class="textarea"> <i class="icon-append fa fa-info"></i>
                            <textarea  name="reason"></textarea>
                        </label>
                    </section>
</form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("არა")%></button>
                <button type="button" class="btn btn-success" onclick="submitBanitem();"><%=trs.t("დიახ")%></button>
            </footer>
        </div>
    </div>
</div>