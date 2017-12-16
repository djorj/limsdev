<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
    LabtestparamsBean[] ss = LabtestparamsManager.getInstance().loadByWhere("where labtestid = "+labtest.getLabtestid()+" order by labtestid, sampletypeid, standardid");
    Vector v = new Vector();
    for(int i=0;i<ss.length;i++)
        v.addElement((LabtestparamsBean)ss[i]);
    session.setAttribute("LABTESTPARAMS", (Vector)v);
    //InstitutionBean[] insts = InstitutionManager.getInstance().loadByWhere("where parentid is null order by parentid, name");
%>
<link href="css/jquery.bootstrap.treeselect.css" rel="stylesheet" type="text/css"/>
<script src="js/jquery.bootstrap.treeselect.js" type="text/javascript"></script>
<style>
.ui-autocomplete {
    z-index: 10000 !important;
}

#gview_samplestandardgrid .ui-jqgrid-bdiv{
    height: 300px !important;
}
</style>
<script>
    pageSetUp();
    
    function addPar(){
        var sampletypeid = $("#sampletypeid").val();
        var standardid = $("#standardid").val();
        if(sampletypeid == 0)   alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ ნიმუში")%>','<%=trs.t("დახურვა")%>');
        //else if(standardid == 0)   alertError('< %=trs.t("შეცდომა")%>','< %=trs.t("აირჩიეთ სტანდარტი")%>','< %=trs.t("დახურვა")%>');
        else {
            $.post("content/updsamplestandard.jsp",{ oper: "add", sampletypeid: sampletypeid, standardid: standardid, labtestid: <%=labtest.getLabtestid()%> }, function(data){
                if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                else {
                    $("#sampletypeid").val(0);
                    $("#standardid").val(0);
                    $("#sampletypename").val("");
                    $("#standardname").val("");
                    $("#sampletypename").focus();
                    jQuery("#samplestandardgrid").trigger("reloadGrid");
                }
            },"json");
        }
    }
    
    function reloadlist10(rowid, result) {
      $("#calcgrid").trigger("reloadGrid"); 
    }
    
    $("#sampletypename").autocomplete({
        source: "content/searchsampletype.jsp",
        minLength: 3,
        select: function( event, ui ) {
            $("#sampletypeid").val(ui.item.id);
            $("#standardname").focus();
            setTimeout(function(){$("#sampletypename").val(ui.item.value)},1000);
        }
    });
    
    $("#standardname").autocomplete({
        source: "content/searchstandard.jsp",
        minLength: 3,
        select: function( event, ui ) {
            $("#standardid").val(ui.item.id);
            $("#institutionid").focus();
            setTimeout(function(){$("#standardname").val(ui.item.value)},1000);
        }
    });
    
    var lastSel;
        jQuery("#samplestandardgrid").jqGrid({
                    url:'content/getsamplestandard.jsp?labtestid=<%=labtest.getLabtestid()%>',
                    datatype: "json",
                    colNames: ['<%=trs.t("ნიმუში")%>', '<%=trs.t("სტანდარტი")%>'],
                    colModel: [
                        {width: 200, name: 'sampletype', index: 'sampletype', editable: false, align: "left",sort:false},
                        {width: 200, name: 'standard', index: 'standard', editable: false, align: "left",sort:false}
                    ],
                    rowNum: 20,
                    height: 200,
                    //width: 900,
                    autowidth: true,
                    rowList: [20,50,100],
                    pager: jQuery('#psamplestandardgrid'),
                    sortname: 'sampletypeid',
                    pgbuttons: true,
                    //pgtext: null,
                    viewrecords: true,
                    sortorder: "asc",
                    footerrow: true,
                    userDataOnFooter: true,
                    onSelectRow: function(id){
                        if(id && id!==lastSel){
                            $('#samplestandardgrid').restoreRow(lastSel); 
                            lastSel=id;
                        }
                        $('#samplestandardgrid').editRow(id, true,'','','','',reloadlist10); 
                    },
                    editurl: "content/updsamplestandard.jsp?labtestid=<%=labtest.getLabtestid()%>"
                })
                        .navGrid('#psamplestandardgrid', {edit:false,add:false,del:<%=permissions[2]%>,view:false,search:false},
                                {dataheight: 230, width: 300, closeAfterEdit: true, reloadAfterSubmit: true, afterSubmit: checkStatus,recreateForm:true,afterShowForm : function (formid) {$('.FormElement').on('focusin', function(e) {e.stopPropagation();}); rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>'); }}, //  default settings for edit
                                {dataheight: 230, width: 300, closeAfterAdd: true, reloadAfterSubmit: true, afterSubmit: checkStatus,recreateForm:true,afterShowForm : function (formid) {$('.FormElement').on('focusin', function(e) {e.stopPropagation();}); rbtn(formid,'<%=trs.t("შენახვა")%>','<%=trs.t("დახურვა")%>'); }}, //  default settings for add
                                {closeAfterDelete: true, reloadAfterSubmit: true, afterSubmit: checkStatus}, // delete instead that del:false we need this
                                {multipleSearch: true}, // search options
                                {dataheight: 230, width: 300, labelswidth: "68%", closeOnEscape: true} /* view parameters*/
                        );

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

        $(".ui-icon.ui-icon-1").removeClass().addClass("fa fa-plus").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");
        $(".ui-icon.ui-icon-2").removeClass().addClass("fa fa-pencil").parent(".btn-primary").removeClass("btn-primary").addClass("btn-warning");
        $(".ui-icon.ui-icon-4").removeClass().addClass("fa fa-minus").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");

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

        jQuery("#samplestandardgrid").jqGrid('setGridWidth', 950);
	jQuery("#samplestandardgrid").jqGrid('setGridHeight', 200);

    
</script>

<input type="hidden" id="labtestidparamdialog" value="<%=labtest.getLabtestid()%>"/>
<div class="smart-form col-sm-12" style="padding: 0;">
    <div class="col-sm-12">
        <section class="col col-sm-5">
            <label class="input">
                <input placeholder="<%=trs.t("ნიმუში")%>" type="text" id='sampletypename'>
                <input type='hidden' id='sampletypeid' value="0"/>
            </label>
        </section>
        <section class="col col-sm-5">
            <label class="input">
                <input placeholder="<%=trs.t("სტანდარტი")%>" type="text" id='standardname'>
                <input type='hidden' id='standardid' value="0"/>
            </label>
        </section>
        <%--section class="col col-sm-5">
            <label class="select">
                <select id="institutionid" class="select2">
                <%
                for(int i=0;i<insts.length;i++){
                %>
                <optgroup label="<%=insts[i].getName()%>">
                <%
                    InstitutionBean[] labs = InstitutionManager.getInstance().loadByWhere("where parentid = "+insts[i].getInstitutionid()+" order by parentid, name");
                    for(int j=0;j<labs.length;j++){
                %>
                <option value="<%=labs[j].getInstitutionid()%>"><%=labs[j].getName()%></option>
                <%
                    }
                %>
                </optgroup>
                <%}%>
                </select>
            </label>
        </section--%>
        <section class="col col-sm-2" id="bplus">
            <button type="submit" class="btn btn-success" onclick="addPar()">
                <%=trs.t("დამატება")%> <span class="fa fa-plus"></span>
            </button>
        </section>
    </div>
    <div class="col-sm-12">
        <table id="samplestandardgrid"></table>
        <div id="psamplestandardgrid"></div>
    </div>
</div>
        

