<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%!
    public String getProductTree(long parentid, String root) throws Exception {
        System.out.println("parentid = " + parentid);
        String sql = "where parentid ";
        if (parentid > 0) {
            sql += "= " + parentid;
        } else {
            sql += "is null";
        }
        sql += " order by name";
        ProductBean[] prs = ProductManager.getInstance().loadByWhere(sql);
        for (int i = 0; i < prs.length; i++) {
            if (ProductManager.getInstance().countWhere("where parentid = " + prs[i].getProductid()) == 0) {
                root += "<li style=\"display: none;\"><span style=\"cursor: pointer;\"><i class=\"icon-leaf\"></i> " + prs[i].getName() + "</span></li>";
                //root += "<li style=\"display: none;\"><button class=\"btn btn-primary btn-xs dropdown-toggle\" data-toggle=\"dropdown\">"+prs[i].getName()+" <span class=\"caret\"></span></button></li>";
            } else {
                root += "<li ";
                if (parentid > 0) {
                    root += " style=\"display: none;\"";
                }
                root += "class=\"parent_li\" role=\"treeitem\"><span title=\"Expand\"><i class=\"fa fa-lg fa-plus-circle icon-plus-sign\"></i> " + prs[i].getName() + "</span><ul role=\"group\">";
                root += getProductTree(prs[i].getProductid().longValue(), "");
                root += "</ul></li>";
            }
        }
        return root;
    }
%>
<%
    /*
    long widgetid = (new Date()).getTime();
    String sdata = request.getParameter("data");
    JSONObject data = JSONObject.fromObject(sdata);
    String header = URLDecoder.decode(data.getString("header"),"UTF-8");
    String body = URLDecoder.decode(data.getString("body"),"UTF-8");
    boolean colorbutton = false;
    boolean editbutton = false;
    boolean togglebutton = false;
    boolean deletebutton = false;
    boolean fullscreenbutton = false;
    boolean custombutton = false;
    boolean collapsed = false; 
    boolean sortable = false;
    if(data.containsKey("attributes")){
        JSONObject attributes = data.getJSONObject("attributes");
        if(attributes.containsKey("colorbutton"))  colorbutton = attributes.getBoolean("colorbutton");
        if(attributes.containsKey("editbutton"))  editbutton = attributes.getBoolean("editbutton");
        if(attributes.containsKey("togglebutton"))  togglebutton = attributes.getBoolean("togglebutton");
        if(attributes.containsKey("deletebutton"))  deletebutton = attributes.getBoolean("deletebutton");
        if(attributes.containsKey("fullscreenbutton"))  colorbutton = attributes.getBoolean("fullscreenbutton");
        if(attributes.containsKey("custombutton"))  colorbutton = attributes.getBoolean("custombutton");
        if(attributes.containsKey("collapsed"))  colorbutton = attributes.getBoolean("collapsed");
        if(attributes.containsKey("sortable"))  colorbutton = attributes.getBoolean("sortable");
            
    }
    JSONArray icons = new JSONArray();
    if(data.containsKey("icons"))
        icons = data.getJSONArray("icons");
     */
    String s = getProductTree(0, "");
    System.out.println(s);
%>
<style>
    #contextMenu {
        position: absolute;
        display:none;
    }
</style>
<div class="tree smart-form"><ul role="tree"><%=s%></ul></div>
<script type="text/javascript">
    $(document).ready(function () {
        pageSetUp();

        var pagefunction = function () {
//            $("#treeview").html("");
//            $("#treeview").append('<div class="tree smart-form"><ul role="tree"><%=s%></ul></div>');
//
//            loadScript("js/plugin/bootstraptree/bootstrap-tree.min.js");

            /*$("#contextMenu").on("click", "a", function() {
             $("#contextMenu").hide();
             });
             
             $("#contextMenu").mouseleave(function() {
             $("#contextMenu").hide();
             });*/
            $(".tree > ul").attr("role", "tree").find("ul").attr("role", "group"),
                    $(".tree").find("li:has(ul)").addClass("parent_li").attr("role", "treeitem").find(" > span").attr("title", "Collapse this branch").on("click", function (a) {
                var b = $(this).parent("li.parent_li").find(" > ul > li");
                b.is(":visible") ? (b.hide("fast"),
                        $(this).attr("title", "Expand this branch").find(" > i").addClass("fa-plus-circle").removeClass("fa-minus-circle")) : (b.show("fast"),
                        $(this).attr("title", "Collapse this branch").find(" > i").addClass("fa-minus-circle").removeClass("fa-plus-circle")),
                        a.stopPropagation();
            });
        };

        pagefunction();
    });
</script>