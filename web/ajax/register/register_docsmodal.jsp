<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../includes/init.jsp" %>
<div class="modal fade" id="docsModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-md">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("დოკუმენტები")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form" id="frmdocs">
                                   
                    <input name="oper" value="edit" type="hidden">
                    <input name="contractid" type="hidden">
                    <input name="id" type="hidden">
                    <section class="col col-md-12">
                        <div class="row" id='errordocs' style="display: none;">
                            <div class="col col-md-12">
                                <div class="alert alert-danger fade in">
                                    <strong><%=trs.t("შეცდომა!")%></strong> <span id='errordocstxt'></span>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col col-md-6">
                                <label class="input"> 
                                    <div class="input-group">
                                    <span class="input-group-addon">ტიპი:</span>
                                    <select class="form-control select2" name="doctypeid" placeholder="<%=trs.t("დოკუმენტის ტიპი")%>">
        <option value=""></option> 
<%            
        DoctypeBean[]  dtb = DoctypeManager.getInstance().loadAll();
        for(int i=0; i<dtb.length;i++) 
            out.print("<option value="+dtb[i].getDoctypeid()+">"+dtb[i].getName()+"</option>");
%>
        </select>
                                    </div>
                                </label>
                            </div>
                            <div class="col col-md-3">
                                <label class="btn btn-primary change-pic contract-file">
                                    <span id="filename-docs"><%=trs.t("ატვირთვა")%></span>
                                    <input name=docfile type="file" id="upload-docs"/>
                                </label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col col-md-12">
                                <ul class="list-group" id='docslist'>
                                    
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