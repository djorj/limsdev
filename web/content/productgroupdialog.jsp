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
int pid = 0;
int parentid = 0;
String savetitle = "";
String savecolor = "";
ProductgroupBean group = ProductgroupManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
String oper = request.getParameter("oper");
if(oper.equalsIgnoreCase("del")){
    pid = group.getProductgroupid().intValue();
    title = trs.t("ჯგუფის წაშლა:")+" <b>"+group.getName()+"</b>";
    savetitle = trs.t("წაშლა");
    savecolor = "danger";
} else if(oper.equalsIgnoreCase("edit")){
    title = trs.t("ჯგუფის რედაქტირება:")+" <b>"+group.getName()+"</b>";
    name = group.getName();
    code = group.getCode();
    pid = group.getProductgroupid().intValue();
    if(group.getParentid() != null)
        parentid = group.getParentid();
    savetitle = trs.t("განახლება");
    savecolor = "warning";
} else if(oper.equalsIgnoreCase("add")){
    title = trs.t("ახალი ჯგუფის დამატება");
    pid = 0;
    if(group != null && group.getProductgroupid() != null)
        pid = group.getProductgroupid().intValue();
    if(group != null) title = trs.t("ახალი ქვეჯგუფის დამატება ჯგუფში:")+" <b>"+group.getName()+"</b>";
    if(group != null && group.getParentid() != null)
        parentid = group.getParentid();
    savetitle = trs.t("დამატება");
    savecolor = "success";
}
%>
<div id="modalproducterror"></div>
<div class="smart-form">
    <%if(oper.equalsIgnoreCase("del")){%>
    <section class="col col-12">
        <%=trs.t("დარწმუნებული ხართ რომ გინდათ ჯგუფის წაშლა?")%>
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
    <%}%>
</div>
            