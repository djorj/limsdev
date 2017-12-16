<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
ProductBean product = ProductManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("productid")));
ProductgroupBean group = ProductgroupManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("groupid")));
String title = "";
String name = "";
String code = "";
int punitid = 0;
double limitqty = 0;
String exp1 = "";
String exp2 = "";
int ageunit1 = 0;
int ageunit2 = 0;
int pid = 0;
int parentid = 0;
String savetitle = "";
String savecolor = "";

pid = group.getProductgroupid().intValue();
title = trs.t("ჯგუფის შეცვლა");
savetitle = trs.t("შეცვლა");
savecolor = "danger";
%>
<style>
    .grpfrom {
        background-color: #F0F1F1;
        border: 1px dotted #999;
        border-radius: 5px;
        display: inline-block;
        padding: 3px 8px;
        text-decoration: none;
        transition: color .2s ease .1s,background-color .2s ease .1s,border-color .3s ease .2s;
        margin: 0;
        -moz-box-sizing: content-box;
        list-style-type: none;
        direction: ltr;
        font-family: "Open Sans",Arial,Helvetica,Sans-Serif;
        font-size: 13px;
        line-height: 1.42857143;
        color: #333;
    }
    
    .grpto {
        background-color: rgb(217, 237, 247);
        border: 1px dotted #999;
        border-radius: 5px;
        display: inline-block;
        padding: 3px 8px;
        text-decoration: none;
        transition: color .2s ease .1s,background-color .2s ease .1s,border-color .3s ease .2s;
        margin: 0;
        -moz-box-sizing: content-box;
        list-style-type: none;
        direction: ltr;
        font-family: "Open Sans",Arial,Helvetica,Sans-Serif;
        font-size: 13px;
        line-height: 1.42857143;
        color: #333;
    }

</style>
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=title%></h4>
            </div>
            <div class="modal-body">
                <div id="modalproducterror"></div>
                <div class="smart-form" style="height: 90px !important; ">
                    <section class="col col-12" style="width: 100%">
                        <table width='100%' align='center'>
                            <tr>
                                <td align='left'>
                                    <div class="grpfrom"><%=product.getName()%></div> 
                                    <i class='fa fa-lg fa-long-arrow-right' style="color: #A90329"></i> 
                                    <div class="grpto"><%=group.getName()%></div>
                                </td>
                            </tr>
                            <tr>
                                <td align='left'><img src="img/blank.gif" alt="" width="1" height="40"/></td>
                            </tr>
                            <tr>
                                <td align='center'><%=trs.t("დარწმუნებული ხართ რომ გინდათ ჯგუფის შეცვლა?")%></td>
                            </tr>
                        </table>
                    </section>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("გაუქმება")%>
                </button>
                <button type="button" class="btn btn-<%=savecolor%>" onclick="saveChangeGroup(<%=product.getProductid()%>, '<%=group.getProductgroupid()%>');">
                    <%=savetitle%>
                </button>
            </footer>
        </div>
    </div>
</div>