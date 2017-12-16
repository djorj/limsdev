<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%!
    /*
    public boolean isAnsestor(long pid1, long pid2) throws Exception {
        boolean bret = false;
        if(pid2 > 0){
            ProductBean pr = ProductManager.getInstance().loadByPrimaryKey(pid2);
            if(pr.getParentid() != null && pr.getParentid().longValue() == pid1)
                bret = true;
            else if(pr.getParentid() != null) {
                bret = isAnsestor(pid1, pr.getParentid().longValue());
            }
        }
        return bret;
    } 
    public String getProductTree(long parentid, String root, long expandedid) throws Exception {
        String sql = "where parentid ";
        if (parentid > 0) {
            sql += "= " + parentid;
        } else {
            sql += "is null";
        }
        sql += " order by name";
        ProductBean[] prs = ProductManager.getInstance().loadByWhere(sql);
        long expandedpid = 0;
        if(expandedid > 0){
            ProductBean pr = ProductManager.getInstance().loadByPrimaryKey(expandedid);
            if(pr.getParentid() != null)
                expandedpid = pr.getParentid().longValue();
        }
        for (int i = 0; i < prs.length; i++) {
            
            if (ProductManager.getInstance().countWhere("where parentid = " + prs[i].getProductid()) > 0) {
                root += "<li onclick=\"detailsGrid("+prs[i].getProductid()+");\"";
                if(prs[i].getParentid() != null && expandedid != prs[i].getProductid().longValue() && expandedpid != prs[i].getParentid().longValue())   root += " style=\"display: none;\"";
                root += "><span productid=\""+prs[i].getProductid()+"\" class=\"pleaf\" id=\"pleaf_"+prs[i].getProductid()+"\" style=\"cursor: pointer;\"><i class=\"icon-leaf\"></i> " + prs[i].getName() + "</span></li>";
                //root += "<li style=\"display: none;\"><button class=\"btn btn-primary btn-xs dropdown-toggle\" data-toggle=\"dropdown\">"+prs[i].getName()+" <span class=\"caret\"></span></button></li>";
            } else {
                boolean ansestor = isAnsestor(prs[i].getProductid().longValue(),expandedid);
                root += "<li ";
                if (parentid > 0 && !ansestor) {
                    root += " style=\"display: none;\"";
                }
                root += "class=\"parent_li\" role=\"treeitem\"><span productid=\""+prs[i].getProductid()+"\" id=\"rleaf_"+prs[i].getProductid()+"\" onclick='detailsGrid(0);' title=\"Expand\"><i class=\"fa fa-lg fa-"+( (ansestor) ? "minus":"plus" )+"-circle\"></i> " + prs[i].getName() + "</span><ul role=\"group\">";
                root += getProductTree(prs[i].getProductid().longValue(), "",expandedid);
                root += "</ul></li>";
            }
        }
        return root;
    }*/

    public String getProductTree(int companyid, long parentid, String root, boolean expanded) throws Exception {
        String sql = "where companyid = "+companyid+" and parentid ";
        if (parentid > 0) {
            sql += "= " + parentid;
        } else {
            sql += "is null";
        }
        sql += " order by name";
        ProductgroupBean[] prs = ProductgroupManager.getInstance().loadByWhere(sql);
        for (int i = 0; i < prs.length; i++) {
            
            if (ProductgroupManager.getInstance().countWhere("where companyid = "+companyid+" and parentid = " + prs[i].getProductgroupid()) == 0) {
                root += "<li onclick=\"detailsGrid("+prs[i].getProductgroupid()+");\"";
                if(!expanded)   root += " style=\"display: none;\"";
                root += "><span groupid=\""+prs[i].getProductgroupid()+"\" class=\"pleaf\" id=\"pleaf_"+prs[i].getProductgroupid()+"\" style=\"cursor: pointer;\"><i class=\"icon-leaf\"></i> " + prs[i].getName() + "</span></li>";
                //root += "<li style=\"display: none;\"><button class=\"btn btn-primary btn-xs dropdown-toggle\" data-toggle=\"dropdown\">"+prs[i].getName()+" <span class=\"caret\"></span></button></li>";
            } else {
                root += "<li ";
                if (parentid > 0 && !expanded) {
                    root += " style=\"display: none;\"";
                }
                root += "class=\"parent_li\" role=\"treeitem\"><span groupid=\""+prs[i].getProductgroupid()+"\" id=\"rleaf_"+prs[i].getProductgroupid()+"\" onclick='detailsGrid(0);' title=\"Expand\"><i class=\"fa fa-lg fa-"+( (expanded) ? "minus":"plus" )+"-circle\"></i> " + prs[i].getName() + "</span><ul role=\"group\">";
                root += getProductTree(companyid,prs[i].getProductgroupid().longValue(), "",expanded);
                root += "</ul></li>";
            }
        }
        return root;
    }
%>
<%

long productid = Long.parseLong(request.getParameter("productid"));
boolean expanded = false;
if(productid > 0)   expanded = true;
%>
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
<%=getProductTree(user.getCompanyid().intValue(),0,"",expanded)%>