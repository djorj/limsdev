<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
    session.removeAttribute("UPLOADEDRESULTS");
    //String ids = request.getParameter("id");
    //ContractsampleitemBean[] itm = ContractsampleitemManager.getInstance().loadByWhere("where contractsampleitemid in ("+ids+")");
    DeviceBean[] devs = DeviceManager.getInstance().loadByWhere("where deviceid in (select deviceid from plate where deviceid > 0) or (upper(name) = 'BIOTEK' and upper(model) = 'ELX808') order by name");
    //String[] pleft = {"A","B","C","D","E","F","G","H"};
%>
<style>
    .table-sizesm.active .ui-jqgrid-bdiv {
        height: calc(100vh - 500px) !important;
    }
</style>
<script>
    function uploadresult(input) {

        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $.post("content/uploadresult.jsp",{ plateid: $("#plateid").val(), deviceid: $("#deviceid").val(), content: e.target.result },function(data){
                    if(data.result == 0) {
                        $("#ribbonerrorupload").html(data.error);
                        $("#ribbonerrorolupload").show();
                        setTimeout(function(){$("#ribbonerrorolupload").hide();},10000);
                    } else {
                        $("#ribbonerrorolupload").hide();
                        $("#devres").trigger('reloadGrid');
                    }
                },"json");
            }

            reader.readAsDataURL(input.files[0]);
        }
    }
    
    function getPlateList(did){
        $.post("content/getplatelist.jsp",{deviceid: did},function(data){
            $("#platelist").html(data);
        },"html");
    }
    
    function checkUpload(pid){
        if(pid > 0) $("#uploadfilebtn").show();
        else        $("#uploadfilebtn").hide();
    }
    
    $("#uploadresult").change(function () {
        uploadresult(this);
    });
    
    $("#ribbonerrorolupload").hide();
    $("#uploadfilebtn").hide();

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
    
    function wrongBarcode(cellvalue, options, rowObject){
        var icon = "exclamation";
        var color = "#A90329";
        if(cellvalue == "1"){
            icon = "check ";
            color = "#739E73";
        } else if(cellvalue == "2"){
            icon = "check-circle ";
            color = "#739E73";
        }
        return "<span class=\"fa fa-"+icon+"\" style=\"color: "+color+"\"></span>";
    }
    
    function saveres(){
        $.post("content/saveres.jsp",{  },function(data){
            if(data.result == 0) {
                $("#ribbonerrorupload").html(data.error);
                $("#ribbonerrorolupload").show();
                setTimeout(function(){$("#ribbonerrorolupload").hide();},10000);
            } else {
                $("#ribbonerrorolupload").hide();
                $("#devres").trigger('reloadGrid');
            }
        },"json");
    }

    var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);

        function run_jqgrid_function() {
            
        jQuery("#devres").jqGrid(
            {
                url:'content/getdevreslist.jsp',
                datatype: "json",
                colNames:['<%=trs.t("ბარკოდი")%>','<%=trs.t("პასუხი1")%>','<%=trs.t("პასუხი2")%>','<%=trs.t("პასუხი3")%>','<%=trs.t("პარამეტრი1")%>','<%=trs.t("პარამეტრი2")%>','<%=trs.t("პარამეტრი3")%>','<%=trs.t("სტატუსი")%>'],
                colModel:[
                    {name:'barcode',index:'barcode', align:"left", width:200},
                    {name:'ans1',index:'ans1', align:"left", width:100},
                    {name:'ans2',index:'ans2', align:"left", width:100},
                    {name:'ans3',index:'ans3', align:"left", width:100},
                    {name:'par1',index:'par1', align:"left", width:100},
                    {name:'par2',index:'par2', align:"left", width:100},
                    {name:'par3',index:'par3', align:"left", width:100},
                    {name:'status',index:'status', align:"center", width:80, formatter:wrongBarcode}
                ],
                rowNum:200000,
                height: 200,
                width:1000,
                autowidth: true,
                rowList:[],
                pgbuttons: false,
                pgtext: null,
                pager: jQuery('#pdevres'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl:"content/upddevres.jsp",
                title: "<%=trs.t("პასუხები")%>",
                loadComplete: function(){
                    /*var rows = $("#devres").getDataIDs();
                    for (var i = 0; i < rows.length; i++){
                        var status = $("#devres").getCell(rows[i],"status");
                        if(status == 0)    $("#devres").jqGrid('setRowData',rows[i],false, {background: '#E66280', color: '#A90329'});
                    }*/
                },
                ondblClickRow: function(id, ri, ci) {
                    
                }
            })
            .navGrid('#pdevres',{edit:false,add:false,del:false,view:false,search:false},
                        {dataheight:300,width:400,closeAfterEdit:true,reloadAfterSubmit:true,afterSubmit:checkStatus}, //  default settings for edit
                        {dataheight:300,width:400,closeAfterAdd:true,reloadAfterSubmit:true,afterSubmit:checkStatus}, //  default settings for add
                        {closeAfterDelete:true,reloadAfterSubmit:true,afterSubmit:checkStatus},  // delete instead that del:false we need this
                        {multipleSearch:true}, // search options
                        {dataheight:300,width:400,labelswidth:"68%",closeOnEscape:true} /* view parameters*/
                )
            .navButtonAdd('#pdevres', {title:'', id: 'saveres', caption: '<i class="fa fa-save"></i> <%=trs.t("შენახვა")%>', buttonicon: 'none', onClickButton: saveres})
             ;
    // remove classes
    
            //$("#saveres").removeClass("btn-primary").addClass("btn-success");
    
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
            $(".ui-icon.ui-icon-pencil").removeClass().addClass("fa fa-pencil").parent(".btn-primary").removeClass("btn-primary").addClass("btn-warning");
            $(".ui-icon.ui-icon-trash").removeClass().addClass("fa fa-trash-o").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");
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
                jQuery("#devres").jqGrid('setGridWidth', $("#uploadedresults").width());
            })


        } // end function


    }

    loadScript("js/plugin/jqgrid/grid.locale-en.min.js", pagefunction);
    
    
</script>
    <div class="smart-form">
        <fieldset>
            <div class="row">
                <section class="col col-sm-12">
                    <div class="alert alert-danger fade in" id='ribbonerrorolupload'>
                        <button class="close" data-dismiss="alert">
                            ×
                        </button>
                        <i class="fa-fw fa fa-times"></i>
                        <strong><%=trs.t("Error!")%></strong> <span id='ribbonerrorupload'></span>
                    </div>
                </section>
            </div>
                
            
            <div class="row">
                <section class="col col-sm-4">
                    <label class="select">
                        <select id="deviceid" onchange="getPlateList($(this).val())">
                            <option value="0">- <%=trs.t("აირჩიეთ აპარატი")%> -</option>
                            <%
                            for(int i=0;i<devs.length;i++){
                                String sel = "";
                            %>
                            <option value="<%=devs[i].getDeviceid()%>" <%=sel%>><%=devs[i].getName()%></option>
                            <%
                            }
                            %>
                        </select><i></i>
                    </label>
                </section>
                <section class="col col-sm-4" id="platelist">

                </section>
                <section class="col col-4">
                    <div class="profile-pic" id="uploadfilebtn" style='margin-top: -10px !important;'>
                        <div>
                            <label class="btn btn-primary change-pic">
                                <%=trs.t("პასუხის ფაილის ატვირთვა")%>
                                <input type="file" id="uploadresult" style="position: absolute; opacity: 0; width: 0px; height: 0px;"/>
                            </label>
                        </div>
                    </div>
                </section>
            </div>
            <div class="row">
                <section class="col col-sm-12">
                    <div id="uploadedresults" class="table-sizesm active" style="height: calc(100vh - 450px) !important;">
                        <table id="devres"></table>
                        <div id="pdevres"></div>
                    </div>
                </section>
            </div>
        </fieldset>
    </div>

