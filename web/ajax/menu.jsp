<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    boolean canwrite = true;
    FileInputStream fi = new FileInputStream(session.getServletContext().getRealPath("/")+"/icons.json");
    byte[] b = new byte[fi.available()];
    fi.read(b);
    fi.close();
    JSONObject icons = JSONObject.fromObject(new String(b,"UTF-8"));
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

            jQuery("#menulist").jqGrid({
                url: 'content/getmenulist.jsp',
                datatype: "json",
                treeGridModel: 'adjacency',
                treeGrid: true,
                ExpandColumn: 'name',
                colNames: ['id', '<%=trs.t("სახელი")%>', '<%=trs.t("ფაილი")%>', '#', '<%=trs.t("პიქტოგრამა")%>', '<%=trs.t("ჯგუფი")%>'],
                colModel: [
                    {name: 'id', index: 'id', width: 1, hidden: true, key: true},
                    {name: 'name', index: 'name', editable: true, sortable: false, align: "left", width: 200, edittype: "text", editoptions: {size: "30"}},
                    {name: 'file', index: 'file', editable: true, sortable: false, align: "left", width: 200, edittype: "text", editoptions: {size: "30"}},
                    {name: 'ord', index: 'ord', editable: true, sortable: false, align: "left", width: 20, edittype: "text", editoptions: {size: "30"}, editrules: {required: true, integer: true}},
                    {name: 'iconname', index: 'iconname', hidden: false, editable: true, sortable: false, align: "left", width: 200, edittype: "text", editoptions: {size: "30"}, editrules: {edithidden: true}},
                    {name: 'parentid', index: 'parentid', hidden: true, editable: true, sortable: false, width: 200, edittype: "select", editoptions: {dataUrl: "content/getmenulistselect.jsp"}, editrules: {edithidden: true}}
                ],
                rowNum: 20,
                height: 400,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagermenulist'),
                sortname: 'ord',
                viewrecords: true,
                sortorder: "asc",
                editurl: "content/updmenu.jsp",
                ondblClickRow: function (id, ri, ci) {
                    jQuery("#list1").jqGrid('editGridRow', id, {height: 250, width: 350, closeAfterEdit: true, reloadAfterSubmit: false, afterSubmit: checkStatus});
                    return;
                },
                title: "<%=trs.t("მენიუ")%>"
            })
                    .sortableRows({update: function (event, ui) {
                            $.post("content/sortmenu.jsp", {neworder: $("#menulist").jqGrid("getDataIDs").join(",")}, function (data) { });
                        }})
                    .navGrid('#pagermenulist', {edit:<%=canwrite%>, add:<%=canwrite%>, del:<%=canwrite%>, view: false, search: false},
                            {dataheight: 250, width: 350, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus},
                            {dataheight: 250, width: 350, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus},
                            {dataheight: 250, width: 350, reloadAfterSubmit: true, afterSubmit: checkStatus},
                            {multipleSearch: true},
                            {dataheight: 250, width: 350, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                    )

            /* Add tooltips */
            $('.navtable .ui-pg-button').tooltip({
                container: 'body'
            });

            // remove classes
            $(".ui-jqgrid").removeClass("ui-widget ui-widget-content");
            $(".ui-jqgrid-view").children().removeClass("ui-widget-header ui-state-default");
            $(".ui-jqgrid-labels, .ui-search-toolbar").children().removeClass("ui-state-default ui-th-column ui-th-ltr");
            $(".ui-jqgrid-pager").removeClass("ui-state-default");
            $(".ui-jqgrid").removeClass("ui-widget-content");

            // add classes
            $(".ui-jqgrid-htable").addClass("table table-bordered table-hover");
            $(".ui-jqgrid-btable").addClass("table table-bordered table-striped");


            $(".ui-pg-div").removeClass().addClass("btn btn-sm btn-primary");
            $(".ui-icon.ui-icon-plus").removeClass().addClass("fa fa-plus").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");;
            $(".ui-icon.ui-icon-pencil").removeClass().addClass("fa fa-pencil").parent(".btn-primary").removeClass("btn-primary").addClass("btn-warning");;
            $(".ui-icon.ui-icon-trash").removeClass().addClass("fa fa-trash-o").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");;
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
                jQuery("#menulist").jqGrid('setGridWidth', $("#content").width());
            })


        } // end function


    }

    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);
    $(document).on("focus", "#iconname", function () {
        $("#iconsModal").modal("show");
    });
    function setIcon(icon) {
        $("#iconname").val(icon);
        $("#iconsModal").modal("hide");
    }
</script>
<div class="table-size1">
    <table id="menulist"></table>
    <div id="pagermenulist"></div>
</div>
<div class="modal fade" id="iconsModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("აირჩიეთ სასურველი პიქტოგრამა")%></h4>
            </div>
            <div class="modal-body">

                <div class="smart-form">
                    <div class="icon-box">
                        <%
                        for(Iterator i = icons.keys();i.hasNext();){
                            String name = (String)i.next();
                            String val = icons.getString(name);
                        %>
                        <i class="fa <%=name%>" onclick="setIcon('<%=name%>')"></i>
                        <%
                        }%>
                    </div>
                    <footer>
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                            Cancel
                        </button>
                    </footer>

                </div>
            </div>
        </div>
    </div>
</div>
