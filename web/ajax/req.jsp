<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    String restypes = "";
    String sql = "where labtestid > 0 ";
    if(user.getPersonelltypeid().intValue() != 1)
        sql += " and labtestid in (select labtestid from labtestinstitution where institutionid = "+user.getInstitutionid()+")";
    LabtestBean[] tests = LabtestManager.getInstance().loadByWhere(sql);
    for(int i=0;i<tests.length;i++){
        restypes += "<option value='"+tests[i].getLabtestid()+"'>"+tests[i].getName()+"</option>";
    }
    String sampletypes = ObjOptions.Sampletypes(user.getCompanyid());
    String labtests = ObjOptions.Labtest();
    //String labpers = ObjOptions.Labpers(user.getCompanyid());
%>
<style>
#exportreqlist {
        line-height: 1.19 !important;
}
.popover.clockpicker-popover{
    z-index: 1050;
}

.ui-jqgrid-sortable {
    top: 0px !important;
    
}
.ui-jqgrid .ui-jqgrid-hdiv { overflow-y: hidden; }

#reqanswer tr.jqgrow td
{           
    word-wrap: break-word; /* IE 5.5+ and CSS3 */
    white-space: pre-wrap; /* CSS3 */
    white-space: -pre-wrap; /* Opera 4-6 */
    white-space: -o-pre-wrap; /* Opera 7 */
    white-space: normal !important;
    height: auto;
    vertical-align: text-top;
    padding-top: 2px;
    padding-bottom: 3px;
}
</style>
<link href="js/plugin/bootstrap-datepicker/css/datepicker3.css"  rel="stylesheet">
<script src="js/plugin/bootstrap-tags/bootstrap-tagsinput.min.js" type="text/javascript"></script>
<script src="js/plugin/bootstrap-datepicker/bootstrap-datepicker.js"></script>
<script src="js/plugin/bootstrap-datepicker/locales/bootstrap-datepicker.ka.js"></script>
<script src="js/plugin/clockpicker/clockpicker.min.js"></script>
<section id="widget-grid" class="" style="padding-right: 5px;">
    <div class="jarviswidget" data-widget-collapsed="true" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false">
        <header>
            <h2><%=trs.t("ფილტრი")%></h2>
        </header>
        <div>
            <div class="smart-form col-sm-12" style="padding: 0;">
                <div class="col-sm-12">
                    <form id="frm0filter" method="post" accept-charset="UTF-8">
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-barcode"></i>
                            <input placeholder="<%=trs.t("ბარკოდი")%>" name="reqbarcode" id="reqbarcode" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select id="research" name="research" class="select2">
                                <option value="0"><%=trs.t("კვლევა")%></option>
                                <%=restypes%>
                            </select><i></i>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" name='regdate' placeholder="<%=trs.t("რეგ. თარიღი")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" name='resultdate' placeholder="<%=trs.t("ჩატარების თარიღი")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-comment"></i>
                            <input placeholder="<%=trs.t("შენიშვნა")%>" name='note' type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" name='confdate' placeholder="<%=trs.t("კონფ. თარიღი")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" name='controldate' placeholder="<%=trs.t("ხარ. კონტრ. თარიღი")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input class="daterangepicker" name='plandate' placeholder="<%=trs.t("სავარაუდო დას.")%>" type="text">
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select name='controlresult'>
                                <option value=''><%=trs.t("კონტრ. შედეგი")%></option>
                                <option value='გაიარა'><%=trs.t("გაიარა")%></option>
                                <option value='არ გაიარა'><%=trs.t("არ გაიარა")%></option>
                            </select><i></i>
                        </label>
                    </section>
                    <section class="col custwidth">
                        <label class="select">
                            <select class="select2" name='labtest' placeholder="<%=trs.t("მეთოდი")%>">
                                <option value=""><%=trs.t("მეთოდი")%></option>
                                <%=labtests%>
                            </select>
                        </label>
                    </section>
                    <%--section class="col custwidth">
                        <label class="select">
                            <select class="select2" name='author' placeholder="<%=trs.t("ავტორი")%>">
                                <option value=""><%=trs.t("ავტორი")%></option>
                                <%=labpers%>
                            </select>
                        </label>
                    </section--%>
                    <section class="col custwidth">
                        <label class="select">
                            <select class="select2" name='sampletype' placeholder="<%=trs.t("ნიმუშის ტიპი")%>">
                                <option value=""><%=trs.t("ნიმუშის ტიპი")%></option>
                                <%=sampletypes%>
                            </select>
                        </label>
                    </section>
                    </form>
                    <button class="btn btn-info pull-right" style="margin-right: 5px;" onclick="clearreq()"><i class="fa fa-times"></i> <%=trs.t("გასუფთავება")%></button>
                    <button class="btn btn-success pull-right" style="margin-right: 5px;" onclick="searchreq()" ><i class="fa fa-search"></i> <%=trs.t("ძებნა")%></button>
                </div>
                
            </div>
        </div>
    </div>
</section>
<div class="col-md-12 btn-panel">
    <button class="btn btn-info pull-right" id="btnprint"><i class="fa fa-print"></i> <%=trs.t("ბეჭდვა")%></button>
    <button class="btn btn-primary pull-right" onclick="setDevice();"><i class="fa fa-upload"></i> <%=trs.t("პასუხების ატვირთვა")%></button>
    <button class="btn btn-info pull-right"><i class="fa fa-file-excel-o"></i> <%=trs.t("ექსპორტი")%></button>
    <button class="btn btn-info pull-right" id="btnresearchanswer"><i class="fa fa-pencil-square"></i> <%=trs.t("პასუხ(ებ)ი")%></button>
    <button class="btn btn-danger pull-right" id="btnqualitycontrol"><i class="fa fa-check-square"></i> <%=trs.t("ხარისხი")%></button>
    <button class="btn btn-success pull-right" id="btnpostpone" ><i class="fa fa-clock-o"></i> <%=trs.t("გადავადება")%></button>
</div>
<div class="table-size9 active">
    <table id="req"></table>
    <div id="pagerreq"></div>
</div>
<div class="modal fade" id="researchanswer" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog large">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ანალიზის პასუხ(ებ)ი")%></h4>
            </div>
            <div class="modal-body" id="researchanswerform">
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("დახურვა")%></button>
                <button type="button" class="btn btn-success" onclick="saveForm('researchanswer')"><%=trs.t("შენახვა")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="qualitycontrol" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ხარისხის კონტროლი")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form col-sm-12" id="qualitycontrolform">
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("გაუქმება")%></button>
                <button type="button" class="btn btn-success" onclick="saveForm('qualitycontrol')"><%=trs.t("შენახვა")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="cancelrestore" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ყურადღება")%></h4>
            </div>
            <div class="modal-body"  id="cancelrestoreform">
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("არა")%></button>
                <button type="button" class="btn btn-success" onclick="saveForm('cancelrestore')"><%=trs.t("დიახ")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="msgModal2" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ყურადღება")%></h4>
            </div>
            <div class="modal-body" id="confirmform">
                <h2 id="message"><%=trs.t("დარწმუნებული ხართ, რომ გნებავთ კონფირმაცია?")%></h2>
                <input type="hidden" name="" value=""/>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <%=trs.t("არა")%>
                </button>
                <button type="button" class="btn btn-success" onclick="setConfirm('confirm')">
                    <%=trs.t("დიახ")%>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="postpone" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("გადავადება")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form" id="postponeform">
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("გაუქმება")%></button>
                <button type="button" class="btn btn-success" onclick="saveForm('postpone')"><%=trs.t("შენახვა")%></button>
            </footer>
        </div>
    </div>
</div>

<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript">
$(document).on("click", ".resultconfirm", function(e) {
    e.preventDefault();
    var sampleitemreseachid = $(this).attr("data-itemid");
    if(confirm('<%=trs.t("დარწმუნებული ხართ რომ გინდათ დაამოწმოთ შედეგები?")%>'))
        setConfirmReq(true,sampleitemreseachid,true);
    //ConfirmMessageArg('< %=trs.t("ყურადღება")%>','< %=trs.t("დარწმუნებული ხართ რომ გინდათ დაამოწმოთ შედეგები?")%>',['< %=trs.t("არა")%>','< %=trs.t("დიახ")%>'],setConfirmReq,sampleitemreseachid);
});

$(document).on("click", ".resultreject", function(e) {
    e.preventDefault();
    var sampleitemreseachid = $(this).attr("data-itemid");
    if(confirm('<%=trs.t("დარწმუნებული ხართ რომ გინდათ გააუქმოთ დაამოწმება?")%>'))
        setConfirmReq(true,sampleitemreseachid,false);
    //ConfirmMessageArg('< %=trs.t("ყურადღება")%>','< %=trs.t("დარწმუნებული ხართ რომ გინდათ უარყოთ შედეგები?")%>',['< %=trs.t("არა")%>','< %=trs.t("დიახ")%>'],setConfirmReq,sampleitemreseachid);
});

function setConfirmReq(result,id,tp){
    if(result){
        $.post("content/setconfirm.jsp", { id: id }, function (data) {
            if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
            else {
                var msg = '<%=trs.t("შედეგები გაუქმებულია")%>';
                if(tp)  {
                    msg = '<%=trs.t("შედეგები დამოწმებულია")%>';
                    $(".resultconfirm").hide();
                    $(".resultreject").show();
                } else {
                    $(".resultconfirm").show();
                    $(".resultreject").hide();
                }
                $("#req").trigger("reloadGrid");
                alert(msg);
            }
        });
    }
}

$("#frm0filter").keypress(function(e) { 
    if(e.keyCode == 13) {
        var op = $(this).serialize();
        $("#req").jqGrid('setGridParam',{url:"content/getreqlist.jsp?"+op}).trigger("reloadGrid");
    }
})


function searchreq(){
    $('#req').setGridParam({
        url:"content/getreqlist.jsp?"+$("#frm0filter").serialize()
    }).trigger("reloadGrid");

}

function clearreq(){
    $("#frm0filter").find("input[type=text], textarea, select").val("");
    $(".select2").val("").trigger('change');
    $("#research").val("0").trigger('change');
    $('#req').setGridParam({
        url:"content/getreqlist.jsp"
    }).trigger("reloadGrid");

}

function setDevice(){
    var myGrid = $('#req');
    var RowId = myGrid.jqGrid('getGridParam', 'selarrrow');
    //if (RowId.length==0)
    //    alertError('< %=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'< %=trs.t("დახურვა")%>');
    //else
    {
        BootstrapDialog.show({
            title: 'პასუხების ატვირთვა',
            size: BootstrapDialog.SIZE_WIDE,
            resizable: false,
            modal: true,
            draggable: false,
            closeOnEscape: false,
            message: function(dialog){
                var $message = $('<div></div>');
                $message.load("content/getdevicemap.jsp?id="+RowId.join(","));
                return $message;
            },
            buttons: [{
            id: 'btn-cancel',
            icon: 'fa fa-times',
            label: ' დახურვა',
            cssClass: 'btn-danger', 
            autospin: false,
            action: function(dialogRef){
                dialogRef.close();
            }
            }]
        });
    }
}

$(document).on("click", "#btnresearchanswer", function(e) {
    var myGrid = $('#req');
    var RowId = myGrid.jqGrid('getGridParam', 'selrow');
    if (RowId===null)
        alertError('<%=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
    else
    {
        $("#researchanswer").modal("show");
        $("#researchanswerform").load("api/load_researchanswer_form.jsp?id="+RowId, function() {
            inittable(tbldata1,tbldata2);
            $("#frmresearchanswer .select2").select2();
            $("#frmresearchanswer input[name=resultdate]").datepicker({
             format: 'dd/mm/yyyy', 
             autoclose: true, 
             language: 'ka', 
             todayHighlight: true, 
             prevText : '<i class="fa fa-chevron-left"></i>',
             nextText : '<i class="fa fa-chevron-right"></i>'
            });
            $("#frmresearchanswer input[name=resulttime]").clockpicker({
             donetext: 'Done',
             twelvehour: false,
             autoclose: true
            }); 
        });
    }
});

$(document).on("click", "#btnprint", function(e) {
    var myGrid = $('#req');
    var RowId = myGrid.jqGrid('getGridParam', 'selrow');
    if (RowId===null)
        alertError('<%=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
    else
    {
        //printReport("F-061-2016-G", RowId);
        printReport('internalanswer',RowId);
    }
});


$(document).on("click", "#btnpostpone", function(e) {
    var myGrid = $('#req');
    var RowId = myGrid.jqGrid('getGridParam', 'selrow');
    if (RowId===null)
        alertError('<%=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
    else
    {
        $("#postpone").modal("show");
        $("#postponeform").load("api/load_postpone_form.jsp?id="+RowId, function() {
            $("#frmpostpone input[name=enddate]").datepicker({
             format: 'dd/mm/yyyy', 
//           startDate: getFmtDate(new Date()),
             autoclose: true, 
             language: 'ka', 
             todayHighlight: true, 
             prevText : '<i class="fa fa-chevron-left"></i>',
             nextText : '<i class="fa fa-chevron-right"></i>'
            });
        });
    }
});
$(document).on("click", "#btnqualitycontrol", function(e) {
    var myGrid = $('#req');
    var RowId = myGrid.jqGrid('getGridParam', 'selrow');
    if (RowId===null)
        alertError('<%=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
    else
    {
        $("#qualitycontrol").modal("show");
        $("#qualitycontrolform").load("api/load_qualitycontrol_form.jsp?id="+RowId, function() {
            $("#frmqualitycontrol .select2").select2();
            $("#frmqualitycontrol input[name=crdate]").datepicker({
             format: 'dd/mm/yyyy', 
             autoclose: true, 
             language: 'ka', 
             todayHighlight: true, 
             prevText : '<i class="fa fa-chevron-left"></i>',
             nextText : '<i class="fa fa-chevron-right"></i>'
            });
            $("#frmqualitycontrol input[name=crtime]").clockpicker({
             donetext: 'Done',
             twelvehour: false,
             autoclose: true
            }); 
        });
    }
});
$(document).on("change", "#upload-bill", function () { inputBarcode();});
function inputBarcode() {
    var n = $("#itemid").val();
    if (n) {
        var tm = new Date().valueOf();
        var s = "<span id='bill"+tm+"' style='padding: 5px 5px !important; margin-top: 5px !important;'>";
        s += "<span style='cursor: pointer;'>"+n+"<a class='btn btn-danger btn-xs' onclick='$(\"#bill"+tm+"\").remove();' style='padding: 1px 7px !important;'><i class='fa fa-times'></i> </a></span>";
        s += "<input type='hidden' name='barcode' value='"+n+"'/></span>";
        $("#barcodelist").append(s);
        $("#itemid").val("");
    }
};
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

    var currentdate = new Date();
    var datetime = currentdate.getDate() + "/"
            + ("0" + (currentdate.getMonth() + 1)).slice(-2) + "/"
            + currentdate.getFullYear() + " "
            + currentdate.getHours() + ":"
            + currentdate.getMinutes()
    $(".datetime").val(datetime);

    var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);

        function run_jqgrid_function() {


            jQuery("#req").jqGrid({
                url: 'content/getreqlist.jsp',
                datatype: "json",
                treeGrid: true,
                treeGridModel: "adjacency",
                ExpandColumn: "name",
                //treedatatype: "local",
                colNames: ['id', '<%=trs.t("დასახელება")%>', '<%=trs.t("ბარკოდი")%>', '<%=trs.t("ნიმუშის ტიპი")%>',
                    '<%=trs.t("ნიმუშის მიღება")%>', '<%=trs.t("შედეგი")%>', 
                    '<%=trs.t("ტესტის დასრულება")%>', '<%=trs.t("ავტორი")%>', '<%=trs.t("სავარაუდო დასრულება")%>', 
                    '<%=trs.t("თარიღი")%>', '<%=trs.t("შედეგი")%>', '<%=trs.t("შენიშვნა")%>', 
                    '<%=trs.t("კონფირმაცია")%>','<%=trs.t("სტატუსი")%>'],
                colModel: [
                   {name: 'id', index: 'id', editable: true, align: "left", hidden: true, width: 1},
                    {width: 150, name: 'name', index: 'name', editable: true, align: "left",sortable:"true"},
                    {width: 80, name: 'code', index: 'code', editable: true, align: "left",sortable:"true"},
                    {width: 150, name: 'type', index: 'type', editable: true, align: "left",sortable:"true"},
                    {width: 80, name: 'getdate', index: 'getdate', editable: true, align: "center",sortable:"true"},
                    {width: 100, name: 'result', index: 'result', editable: true, align: "left",sortable:"false"},
                    {width: 80, name: 'enddate', index: 'enddate', editable: true, align: "center",sortable:"true"},
                    {width: 120, name: 'author', index: 'author', editable: true, align: "left",sortable:"true"},
                    {width: 80, name: 'plandate', index: 'plandate', editable: true, align: "center",sortable:"true"},

                    {width: 80, name: 'controldate', index: 'controldate', editable: true, align: "center",sortable:"true"},
                    
                    {width: 100, name: 'controlresult', index: 'controlresult', editable: true, align: "left",sortable:"false"},
                    
                    {width: 150, name: 'note', index: 'note', editable: true, align: "left",sortable:"true"},
                    {width: 80, name: 'confdate', index: 'confdate', editable: true, align: "center",sortable:"false"},
                    {name: 'status', index: 'status', sortable: false, hidden: true, width: 0}
                ],
                rowNum: 20,
                height: 350,
                //width: 900,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagerreq'),
                sortname: 'getdate',
                viewrecords: true,
                sortorder: "desc",
                loadComplete: function () {
                    //$('#' + $.jgrid.jqID(2)).addClass('rowbg2');
                    //$('#' + $.jgrid.jqID(4)).addClass('rowbg1');
                },
                gridComplete: function() {
                    var grid = $(this);
                    var ids = $(this).jqGrid('getDataIDs');
                    for (var i=0;  i<ids.length; i++)  {
                        var s=grid.getCell(ids[i], 'status');
                        if (s=="2") {
                            $('#' + ids[i]).addClass('rowbg2');            
                        }
                        else if (s=="1") {
                            //$('#' + ids[i]).addClass('rowbg1');            
                        }
                        
                    }
                }
            })
            .navGrid('#pagerreq', {edit: false, add: false, del: false, refresh: true, view: false, search: false})
            .navButtonAdd('#pagerreq', {
                caption: "გაუქმება",
                buttonicon: "ui-icon-2",
                onClickButton: function () {
                    var myGrid = $('#req');
                    var RowId = myGrid.jqGrid('getGridParam', 'selrow');
                    if (RowId==null)
                        alertError('<%=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
                    else
                    {
                        $("#cancelrestore").modal("show");
                        $("#cancelrestoreform").load("api/load_cancelrestore_form.jsp?id="+RowId, function() {
                            $("#frmcancelrestore .select2").select2();
                        });
                    }
                },
                position: "last"
            });
            jQuery("#req").jqGrid('setGroupHeaders', {
                useColSpanStyle: true,
                groupHeaders: [
                    
                    {startColumnName: 'controldate', numberOfColumns: 2, titleText: '<%=trs.t("ხარისხის კონტროლი")%>'}
                ]
            });

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

            $(".ui-icon.ui-icon-2").removeClass().addClass("fa fa-pencil").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");

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
                jQuery("#req").jqGrid('setGridWidth', $("#content").width() - 10);
                jQuery("#reqanswer").jqGrid('setGridWidth', 600);
                jQuery("#qcregistry").jqGrid('setGridWidth', 920);
            })
        }
    }

    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);
    $(document).on("click", ".jarviswidget-toggle-btn", function () {
        $(".table-size9").toggleClass("active");
    });
    $(".datetime").datetimepicker({
        format: 'DD/MM/YYYY HH:mm'
    });
    $('.daterangepicker').daterangepicker({
        autoUpdateInput: false,
        locale: {
            format: 'DD/MM/YYYY',
            cancelLabel: '<%=trs.t("დახურვა")%>'
        }
    });
    $('.daterangepicker').on('apply.daterangepicker', function (ev, picker) {
        $(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));
    });

    $('.daterangepicker').on('cancel.daterangepicker', function (ev, picker) {
        $(this).val('');
    });
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!
    var yyyy = today.getFullYear();

    if (dd < 10) {
        dd = '0' + dd
    }

    if (mm < 10) {
        mm = '0' + mm
    }

    today = dd + '/' + mm + '/' + yyyy;
    $("#now").val(today)

    function showList() {
        $("#qcregistryModal").modal("show");
    }
    
 function saveForm(frm) {
    showLoader();
    var form = $("#frm"+frm)[0];
    $.ajax({
        type: "POST",
        url: form.action,
        data: $(form).serialize(),
        dataType: "json"
    }).done(function(rs) { 
        hideLoader();
        if (rs.status=='ER')
        {
            alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
        }
        else
        {
            alertMessage(rs.message,'','<%=trs.t("დახურვა")%>');
            $("#"+frm).modal("hide");
            $("#req").trigger("reloadGrid");
            

        }
    }).fail(function(xhr, textStatus, errorThrown) {
        hideLoader(); 
        alertError('<%=trs.t("შეცდომა")%>',textStatus,'<%=trs.t("დახურვა")%>');
    });
}

function inittable(tbldata1,tbldata2)
{
            jQuery("#qcregistry").jqGrid({
                treeGrid: true,
                treeGridModel: "adjacency",
                ExpandColumn: "code",
                treedatatype: "local",
                datatype: "jsonstring",
                datastr: tbldata1,
                colNames: ["id", '<%=trs.t("ლოტის N")%>', '<%=trs.t("შტრიხკოდი")%>', '<%=trs.t("რეაგენტი")%>', '<%=trs.t("თარიღი/დრო")%>', '<%=trs.t("ვინ ჩაატარა")%>', '<%=trs.t("ნორმატივი")%>', '<%=trs.t("შედეგი")%>', '<%=trs.t("კვლევების რაოდენობა")%>'],
                colModel: [
                    {name: 'id', index: 'id', editable: true, align: "left", hidden: true, width: 1},
                    {name: 'number', index: 'number', editable: true, align: "left"},
                    {name: 'code', index: 'code', editable: true, align: "center"},
                    {name: 'reag', index: 'reag', editable: true, align: "left"},
                    {name: 'date', index: 'date', editable: true, align: "left"},
                    {name: 'user', index: 'user', editable: true, align: "left"},
                    {name: 'norm', index: 'norm', editable: true, align: "left"},
                    {name: 'result', index: 'result', editable: true, align: "left"},
                    {name: 'count', index: 'count', editable: true, align: "center"}
                ],
                rowNum: 20,
                height: 100,
                width: 900,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery("#pagerqcregistry"),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc"
            })
            .navGrid("#pagerqcregistry", {edit: false, add: false, del: false, refresh: false, view: false, search: false});


            jQuery("#reqanswer").jqGrid({
                data: tbldata2,
                datatype: "local",
                colNames: ['<%=trs.t("დასახელება")%>', '<%=trs.t("შედეგი")%>', '<%=trs.t("ნორმატივი")%>','<%=trs.t("სტანდარტი")%>'],
                colModel: [
                    {name: 'name', index: 'name', editable: true, align: "left",width:200},
                    {name: 'answer', index: 'answer', editable: true, align: "left",width:100},
                    {name: 'norm', index: 'norm', editable: true, align: "left",width:100},
                    {name: 'standardid', index: 'standardid', editable: true, align: "left",width:100}
                ],
                rowNum: 20,
                height: 250,
                width: 900,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: false,
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc"
            })
            .navGrid('#pagerreqanswer', {edit: false, add: false, del: false, refresh: false, view: false, search: false});
            jQuery("#qcregistry").jqGrid('setGridWidth', 920);
            jQuery("#reqanswer").jqGrid('setGridWidth', 600);
            $(window).on('resize.jqGrid', function () {
                jQuery("#reqanswer").jqGrid('setGridWidth', 600);
                jQuery("#qcregistry").jqGrid('setGridWidth', 920);
            })
            $("#reqanswer").parents('div.ui-jqgrid-bdiv').css("max-height","120px");
            $("#qcregistry").parents('div.ui-jqgrid-bdiv').css("max-height","120px");
            
            //$('.ui-jqgrid-sortable').css("top","0px !important");
}
</script>


