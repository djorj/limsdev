<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
PunitBean[] punits = PunitManager.getInstance().loadByWhere("order by name");
String title = "";
String name = "";
String code = "";
int punitid = 0;
double limitqty = 0;
String exp1 = "";
String exp2 = "";
int ageunit1 = 0;
int ageunit2 = 0;
long pid = 0;
long parentid = 0;
String savetitle = "";
String savecolor = "";
ProductBean product = ProductManager.getInstance().loadByPrimaryKey(new Long(request.getParameter("id")));
String oper = request.getParameter("oper");
if(oper.equalsIgnoreCase("del")){
    pid = product.getProductid().longValue();
    title = trs.t("პროდუქტის წაშლა:")+" <b>"+product.getName()+"</b>";
    savetitle = trs.t("წაშლა");
    savecolor = "danger";
} else if(oper.equalsIgnoreCase("edit")){
    title = trs.t("პროდუქტის რედაქტირება:")+" <b>"+product.getName()+"</b>";
    name = product.getName();
    code = product.getCode();
    if(product.getPunitid() != null)
        punitid = product.getPunitid().intValue();
    limitqty = product.getLimitqty().doubleValue();
    long vl = 0;
    if(product.getExp1() != null)   vl = product.getExp1().longValue();
    for (int i = 0; i < ageunitvals.length; i++) {
        if (vl > ageunitvals[i]) {
            vl = Math.round(vl / ageunitvals[i]);
            ageunit1 = i;
            exp1 = String.valueOf(vl);
            break;
        }
    }
    vl = 0;
    if(product.getExp2() != null)   vl = product.getExp2().longValue();
    for (int i = 0; i < ageunitvals.length; i++) {
        if (vl > ageunitvals[i]) {
            vl = Math.round(vl / ageunitvals[i]);
            ageunit2 = i;
            exp2 = String.valueOf(vl);
            break;
        }
    }
    pid = product.getProductid().longValue();
    parentid = product.getParentid();
    savetitle = trs.t("განახლება");
    savecolor = "warning";
} else if(oper.equalsIgnoreCase("add")){
    title = trs.t("ახალი პროდუქტის დამატება");
    if(product != null) title = trs.t("ახალი პროდუქტის დამატება კატეგორიაში:")+" <b>"+product.getName()+"</b>";
    parentid = 0;
    if(product.getParentid() != null)
        parentid = product.getParentid();
    savetitle = trs.t("დამატება");
    savecolor = "success";
}
%>
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
                <div class="smart-form">
                    <%if(oper.equalsIgnoreCase("del")){%>
                    <section class="col col-12">
                        <%=trs.t("დარწმუნებული ხართ რომ გინდათ პროდუქტის წაშლა?")%>
                    </section>
                    <%}else{%>
                    <section class="col col-6">
                        <label class="label"><%=trs.t("დასახელება")%></label>
                        <label class="input">
                            <input type="text" id="name" value="<%=name%>">
                            <input type='hidden' id='parent' value="<%=parentid%>">
                        </label>
                    </section>
                    <section class="col col-6">
                        <label class="label"><%=trs.t("კოდი")%></label>
                        <label class="input">
                            <input type="text" id="code" value="<%=code%>">
                        </label>
                    </section>
                    <section class="col col-6">
                        <label class="label"><%=trs.t("ძირითადი ერთეული")%></label>
                        <label class="select">
                            <select id="punitid" class="dropdown">
                                <option value="0"><%=trs.t("არ აქვს")%></option>
                                <%
                                for(int i=0;i<punits.length;i++){
                                    String sel = "";
                                    if(punits[i].getPunitid().intValue() == punitid)   sel = "selected";
                                %>
                                <option <%=sel%> value="<%=punits[i].getPunitid()%>"><%=punits[i].getName()%></option>
                                <%
                                }
                                %>
                            </select>
                        </label>
                    </section>
                    <section class="col col-6">
                        <label class="label"><%=trs.t("პროდუქტის რაოდენობის ლიმიტი")%></label>
                        <label class="input">
                            <input id="limitqty" class="text-right numeric" type="text"  value="<%=dc.format(limitqty)%>">
                        </label>
                    </section>
                    <section class="col col-6">
                        <label class="label"><%=trs.t("ვადა გახსნამდე")%></label>
                        <label class="input col col-6" style="padding: 0;">
                            <input id="exp1" type="text" class="text-right numeric" value="<%=exp1%>">
                        </label>
                        <label class="select col col-6" style="padding: 0;">
                            <select id="unit1" class="dropdown" style="border-left: 0;">
                                <%
                                for(int i=0;i<agenames.length;i++){
                                    String sel = "";
                                    if(i == ageunit1)   sel = "selected";
                                %>
                                <option <%=sel%> value="<%=i%>"><%=agenames[i]%></option>
                                <%
                                }
                                %>
                            </select>
                        </label>
                    </section>
                    <section class="col col-6">
                        <label class="label"><%=trs.t("ვადა გახსნის შემდეგ")%></label>
                        <label class="input col col-6" style="padding: 0;">
                            <input id="exp2" type="text" class="text-right numeric" value="<%=exp2%>">
                        </label>
                        <label class="select col col-6" style="padding: 0;">
                            <select  id=unit2 class="dropdown" style="border-left: 0;">
                                <%
                                for(int i=0;i<agenames.length;i++){
                                    String sel = "";
                                    if(i == ageunit2)   sel = "selected";
                                %>
                                <option <%=sel%> value="<%=i%>"><%=agenames[i]%></option>
                                <%
                                }
                                %>
                            </select>
                        </label>
                    </section>
                    <%}%>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("გაუქმება")%>
                </button>
                <button type="button" class="btn btn-<%=savecolor%>" onclick="saveProduct(<%=pid%>, '<%=oper%>');">
                    <%=savetitle%>
                </button>
            </footer>
        </div>
    </div>
</div>