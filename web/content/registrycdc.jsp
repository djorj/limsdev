<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
    int partidx = Integer.parseInt(request.getParameter("partidx"));
    JSONObject obj = (JSONObject)session.getAttribute("REGISTRYCDC");
    JSONArray parts = obj.getJSONArray("parts");
    JSONObject part = parts.getJSONObject(partidx);
    String icon = "";
    JSONArray icons = part.getJSONArray("iconsmall");
    for(int i=0;i<icons.size();i++){
        icon += "<i class=\""+icons.getString(i)+"\"></i>";
    }
    JSONArray buttons = part.getJSONArray("buttons");
    String caption = "<b>"+icon+" "+trs.t(part.getString("title"))+"</b> "
            + "<div class=\"btn-group pull-right\"><a id=\"dLabel\" role=\"button\" "
            + " class=\"btn btn-primary\" data-target=\"#\" href=\"javascript:hideRegistry();\" aria-expanded=\"false\"> <span class=\"fa fa-refresh\"></span> "
            + trs.t("ნიმუშის ტიპის შეცვლა")+"</a> <a class=\"btn btn-primary dropdown-toggle\" data-toggle=\"dropdown\" href=\"javascript:void(0);\"><span class=\"caret\"></span></a><ul class=\"dropdown-menu multi-level\" role=\"menu\">";
    for(int i=0;i<parts.size();i++){
        if(i == partidx)    continue;
        JSONObject part0 = parts.getJSONObject(i);
        caption += "<li class=\"inline-group\"><a href=\"javascript:showRegistry("+i+");\">"+trs.t(part0.getString("title").replaceAll("'", "&quot;"))+"</a></li>";
    }
    caption += "</ul></div>"
            
            + "<div class=\"dropdown pull-right\" style=\"padding-right: 2px;\"><a id=\"dLabel\" role=\"button\" "
            + "data-toggle=\"dropdown\" class=\"btn btn-primary\" data-target=\"#\" href=\"javascript:void(0);\" aria-expanded=\"false\"> <span class=\"fa fa-gear\"></span> "
            + trs.t("მოქმედება")+" <span class=\"caret\"></span> </a><ul class=\"dropdown-menu multi-level\" role=\"menu\">"
            + "<li class=\"inline-group\"><a href=\"javascript:vieweditReg("+partidx+");\">"+trs.t("რედაქტირება")+"</a></li>"
            + "<li class=\"inline-group\"><a href=\"javascript:printReg("+partidx+");\">"+trs.t("ბეჭდვა")+"</a></li>"
            + "<li class=\"inline-group\"><a href=\"javascript:deleteReg("+partidx+");\">"+trs.t("წაშლა")+"</a></li>"
            + "</ul></div>";
            
            //+ " <div class=\"pull-right\" style=\"padding-right: 40px;\"><button type=\"button\" style=\"height: 32px;\" class=\"btn btn-danger\" onclick=\"deleteReg("+partidx+")\"> <span class=\"fa fa-close\"></span></button></div>"
            //+ " <div class=\"pull-right\" style=\"padding-right: 2px;\"><button type=\"button\" style=\"height: 32px;\" class=\"btn btn-warning\" onclick=\"vieweditReg("+partidx+")\"> <span class=\"fa fa-pencil\"></span></button></div>"
            //+ " <div class=\"pull-right\" style=\"padding-right: 2px;\"><button type=\"button\" style=\"height: 32px;\" class=\"btn btn-primary\" onclick=\"printReg("+partidx+")\"> <span class=\"fa fa-print\"></span></button></div>";
    JSONArray colnames = part.getJSONArray("colnames");
    JSONArray colmodel = part.getJSONArray("colmodel");
    JSONArray sampledata = part.getJSONArray("sampledata");
    String scolnames = "";
    for(int i=0;i<colnames.size();i++){
        if(i > 0)   scolnames += ",";
        scolnames += "'"+trs.t(colnames.getString(i).replaceAll("'", "&#39;"))+"'";
    }
    String onSelectRow = "";
    if(part.containsKey("onSelectRow"))
        onSelectRow = part.getString("onSelectRow");
%>

<script type="text/javascript">
    pageSetUp();
    

    checkStatus = function (response, postdata) {
        var retval = true;
        var msg = "";
        var id = 0;
        var json = eval('(' + response.responseText + ')');
        if (json.result == 0)
        {
            msg = json.error;
            retval = false;
        } else
            id = json.id;
        return [retval, msg, id];
    }
    
    var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);

        function run_jqgrid_function() {

            var tbldata = <%=sampledata.toString()%>;
            jQuery("#reestr<%=partidx%>").jqGrid({
//                treeGrid: true,
//                treeGridModel: "adjacency",
//                ExpandColumn: "code",
//                treedatatype: "local",
//                datatype: "jsonstring",
//                datastr: tbldata,
                datatype: "local",
                data: tbldata,
                colNames: [<%=scolnames%>],
                colModel: <%=colmodel.toString()%>,
                rowNum: 20,
                height: 100,
                //width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagerreestr<%=partidx%>'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                caption: '<%=caption%>',
                onSelectRow: function(id){ <%=onSelectRow%> }
            })
                    .navGrid('#pagerreestr<%=partidx%>', {edit: false, add: false, del: false, view: false, search: false},
                            {dataheight: 150, width: 350, closeAfterEdit: true, reloadAfterSubmit: false, afterSubmit: checkStatus}, //  default settings for edit
                            {dataheight: 150, width: 350, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, //  default settings for add
                            {dataheight: 150, width: 350, reloadAfterSubmit: false, afterSubmit: checkStatus}, // delete instead that del:false we need this
                            {multipleSearch: true}, // search options
                            {dataheight: 150, width: 350, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    )
            <%for(int i=0;i<buttons.size();i++){
                JSONObject button = buttons.getJSONObject(i);
            %>
            .navButtonAdd('#pagerreestr<%=partidx%>', {id: '<%=button.getString("id")%>', caption: '<i class="<%=button.getString("icon")%>"></i> <%=trs.t(button.getString("caption"))%>', buttonicon: "none", onClickButton: function () { <%=button.getString("function")%> }, position: 'last'})
            <%}%>
            ;



            $('.navtable .ui-pg-button').tooltip({
                container: 'body'
            });

            // remove classes
            $(".ui-jqgrid-titlebar-close").remove();
            
            $(".ui-jqgrid").removeClass("ui-widget ui-widget-content");
            $(".ui-jqgrid-view").children().removeClass("ui-widget-header ui-state-default");
            $(".ui-jqgrid-labels, .ui-search-toolbar").children().removeClass("ui-state-default ui-th-column ui-th-ltr");
            $(".ui-jqgrid-pager").removeClass("ui-state-default");
            $(".ui-jqgrid").removeClass("ui-widget-content");

            // add classes
            $(".ui-jqgrid-htable").addClass("table table-bordered table-hover");
            $(".ui-jqgrid-btable").addClass("table table-bordered table-striped");


            $(".ui-pg-div").removeClass().addClass("btn btn-sm btn-primary");
            $(".ui-icon.ui-icon-plus").removeClass().addClass("fa fa-plus").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");
            ;
            $(".ui-icon.ui-icon-pencil").removeClass().addClass("fa fa-pencil").parent(".btn-primary").removeClass("btn-primary").addClass("btn-warning");
            ;
            $(".ui-icon.ui-icon-trash").removeClass().addClass("fa fa-trash-o").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");
            ;
            $(".ui-icon.ui-icon-search").removeClass().addClass("fa fa-search");
            $(".ui-icon.ui-icon-refresh").removeClass().addClass("fa fa-refresh");
            $(".ui-icon.ui-icon-disk").removeClass().addClass("fa fa-save").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");
            $(".ui-icon.ui-icon-cancel").removeClass().addClass("fa fa-times").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");

            $(".ui-icon.ui-icon-seek-prev").wrap("<div class='btn btn-sm btn-default'></div>");
            $(".ui-icon.ui-icon-seek-prev").removeClass().addClass("fa fa-backward");

            $(".ui-icon.ui-icon-seek-first").wrap("<div class='btn btn-sm btn-default'></div>");
            $(".ui-icon.ui-icon-seek-first").removeClass().addClass("fa fa-fast-backward");

            $(".ui-icon.ui-icon-seek-next").wrap("<div class='btn btn-sm btn-default'></div>");
            $(".ui-icon.ui-icon-seek-next").removeClass().addClass("fa fa-forward");

            $(".ui-icon.ui-icon-seek-end").wrap("<div class='btn btn-sm btn-default'></div>");
            $(".ui-icon.ui-icon-seek-end").removeClass().addClass("fa fa-fast-forward");




            // update buttons

            $(window).on('resize.jqGrid', function () {
                jQuery("#reestr<%=partidx%>").jqGrid('setGridWidth', $("#content").width() - 10);
                jQuery("#reestr<%=partidx%>").jqGrid('setGridHeight', $("#content").height() - 100);
                //calc(100vh - 320px)
            })
            
            
            $("#getorder").hide();
            $("#editorder").hide();
            jQuery("#reestr<%=partidx%>").jqGrid('setGridWidth', $("#content").width() - 10);
            jQuery("#reestr<%=partidx%>").jqGrid('setGridHeight', $("#content").height() - 100);
        }
    }

    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);

    
</script>

<%--div class="col-md-12 btn-panel">
    <button class="btn btn-warning pull-right"><i class="fa fa-book"></i> <%=trs.t("შემოწმება")%></button>
    <button class="btn btn-success pull-right"><i class="fa fa-book"></i> <%=trs.t("მიღება")%></button>
</div--%>
<div class="table-size2 active">
    <table id="reestr<%=partidx%>"></table>
    <div id="pagerreestr<%=partidx%>"></div>
</div>
