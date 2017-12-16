<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%!
public String getInstSchema(InstitutionBean[] insts, int testcategoryid) throws Exception {
    String s = "<ul>";
    for(int i=0;i<insts.length;i++){
        InstitutionBean[] insts1 = InstitutionManager.getInstance().loadByWhere("where parentid = "+insts[i].getInstitutionid()+" order by name");
        s += "<li>";
        if(insts1.length > 0){
            s += "<span class=\"label label-info\"><i class=\"fa fa-lg fa-minus-circle\"></i> "+insts[i].getName()+"</span>";
            s += getInstSchema(insts1, testcategoryid);
        } else {
            String sel = "";
            if(TestcategorylabManager.getInstance().countWhere("where testcategoryid = "+testcategoryid+" and institutionid = "+insts[i].getInstitutionid()) > 0)
                sel = "checked";
            s += "<span>"
                    + "<input type=\"checkbox\" name=\"institutionid\" id=\"lab_"+insts[i].getInstitutionid()+"\" value=\""+insts[i].getInstitutionid()+"\" style=\"cursor: pointer;\" "+sel+"/> "
                    + "<label for=\"lab_"+insts[i].getInstitutionid()+"\" style=\"cursor: pointer;\">"+insts[i].getName()+"</label>"
                    + "</span>";
        }
    }
    s += "</ul>";
    return s;
}
%>
<%
  int testcategoryid = Integer.parseInt(request.getParameter("id"));
  InstitutionBean[] insts = InstitutionManager.getInstance().loadByWhere("where parentid is null order by name");
  String s = getInstSchema(insts,testcategoryid);
%>
<div class="tree smart-form">
    <%=s%>
</div>
<script>
    $(".tree > ul").attr("role", "tree").find("ul").attr("role", "group"),
        $(".tree").find("li:has(ul)").addClass("parent_li").attr("role", "treeitem").find(" > span").attr("title", "Collapse this branch").on("click", function (a) {
        var b = $(this).parent("li.parent_li").find(" > ul > li");
        b.is(":visible") ? (b.hide("fast"),
                $(this).attr("title", "Expand this branch").find(" > i").addClass("fa-plus-circle").removeClass("fa-minus-circle")) : (b.show("fast"),
                $(this).attr("title", "Collapse this branch").find(" > i").addClass("fa-minus-circle").removeClass("fa-plus-circle")),
                a.stopPropagation();
    });
</script>