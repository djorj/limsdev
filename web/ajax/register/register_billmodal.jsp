<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../includes/init.jsp" %>
<div class="modal fade" id="billModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ქვითრები")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form" id="frmbill">
                                   
                    <input name="oper" value="edit" type="hidden">
                    <input name="contractid" type="hidden">
                    <input name="id" type="hidden">
                    <section class="col col-md-12">
                        <div class="row" id='errorbill' style="display: none;">
                            <div class="col col-md-12">
                                <div class="alert alert-danger fade in">
                                    <strong><%=trs.t("შეცდომა!")%></strong> <span id='errorbilltxt'></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col col-md-6">
                                <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                                    <div class="input-group">
                                    <span class="input-group-addon">ქვითრის N:</span>
                                    <input class="form-control" name="billnum" id="billnum" placeholder="<%=trs.t("ქვითრის ნომერი")%>" type="text" data-autoclose="true">
                                    </div>
                                </label>
                            </div>
                            <div class="col col-md-3">
                                <label class="btn btn-primary change-pic contract-file">
                                    <span id="filename-bill"><%=trs.t("ატვირთვა")%></span>
                                    <input name=docfile type="file" id="upload-bill"/>
                                </label>
                            </div>
                            <div class="col col-md-3">
                                <a class="btn btn-primary" onclick="scanToJpg();"><%=trs.t("სკანირება")%></a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col col-md-12">
                                <ul class="list-group" id='billlist'>
                                    
                                </ul>
                            </div>
                        </div>
                    </section>
                    
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("დახურვა")%></button>
            </footer>
        </div>
    </div>
</div>