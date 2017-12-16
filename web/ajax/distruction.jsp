<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%    
    String gridname = "distruction";
    String ses = "EXPORT_BAR_" + (new Date()).getTime();
    jqexport exp = new jqexport(ses, null, null, "EXPORT_STOP", "content/export_" + gridname + ".jsp", "");
    String sampletypes = ObjOptions.Sampletypes(user.getCompanyid());
    String species = "";
    SpeciesBean[] sps = SpeciesManager.getInstance().loadByWhere("order by name");
    for(int i=0;i<sps.length;i++){
        species += "<option value='"+sps[i].getSpeciesid()+"'>"+sps[i].getName()+"</option>";
    }
    PlevelBean[] plv = PlevelManager.getInstance().loadByWhere("where personelltypeid = "+user.getPersonelltypeid()+" and menuid = 111");
    if(plv.length > 0){
        //                       0: add 1: edit 2: delete   3: read 4: export   5: print
        permissions[0] = plv[0].getWrite();
        permissions[1] = plv[0].getWrite();
        permissions[2] = plv[0].getWrite();
        permissions[3] = plv[0].getRead();
        permissions[4] = plv[0].getExport();
        permissions[5] = plv[0].getPrint();
    }
%>
<style>
#exportsamplelist {
        line-height: 1.19 !important;
}
.popover.clockpicker-popover{
    z-index: 1050;
}
</style>
<%=exp.getExportAttr()%>
<link href="js/plugin/bootstrap-datepicker/css/datepicker3.css"  rel="stylesheet">
<script src="js/plugin/bootstrap-tags/bootstrap-tagsinput.min.js" type="text/javascript"></script>
<script src="js/plugin/bootstrap-datepicker/bootstrap-datepicker.js"></script>
<script src="js/plugin/bootstrap-datepicker/locales/bootstrap-datepicker.ka.js"></script>
<script src="js/plugin/clockpicker/clockpicker.min.js"></script>

<script type="text/javascript">
    pageSetUp();

    var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);

        function run_jqgrid_function() {

            jQuery("#list<%=gridname%>").jqGrid({
                url: 'content/get<%=gridname%>.jsp?lab=true',
                datatype: "json",
                colNames: ['<%=trs.t("ბარკოდი")%>', '<%=trs.t("ნიმუშის ტიპი")%>',  '<%=trs.t("თარიღი")%>', '<%=trs.t("საველე&nbsp;N")%>', '<%=trs.t("ადგილმდებარეობა")%>', '<%=trs.t("სტატუსი")%>', '<%=trs.t("თანამშრომელი")%>','statusid'],
                colModel: [
                    {name: 'barcode', index: 'barcode', editable: true, align: "center", width: 70,sortable:false},
                    {name: 'sampletype', index: 'sampletype', editable: true, align: "left", width: 200,sortable:false},
                    {name: 'regdate', index: 'regdate', editable: true, align: "center", width: 70,sortable:false},
                    {name: 'num1', index: 'num1', editable: true, align: "left", width: 70,sortable:false},
                    {name: 'place', index: 'place', editable: true, align: "left", width: 120,sortable:false},
                    {name: 'status', index: 'status', editable: true, align: "left", width: 80,sortable:false},
                    {name: 'author', index: 'author', editable: true, align: "center", width: 140,sortable:false},
                    {name: 'statusid', index: 'statusid', sortable: false, hidden: true, width: 0,sortable:false}
                ],
                rowNum: 20,
                height: 200,
                width: 1000,
                rownumbers:true,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pager<%=gridname%>'),
                sortname: 'regdate',
                viewrecords: true,
                sortorder: "desc",
                multiselect: true,
                caption: '',
                gridComplete: function() {
                    var grid = $(this);
                    var ids = $(this).jqGrid('getDataIDs');
                    for (var i=0;  i<ids.length; i++)  {
                        var s=grid.getCell(ids[i], 'statusid');
                        if (s=="6") {
                            //$('#' + ids[i]).addClass('stoped');            
                        }
                        else if (s=="3") {
                            //$('#' + ids[i]).addClass('rowbg1');            
                        }
                        
                    }
                }
            })
        .navGrid('#pager<%=gridname%>', {edit:false, add:false, del:false, view: false, search: false});
        



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
                jQuery("#list<%=gridname%>").jqGrid('setGridWidth', $("#content").width() - 10);
            })
            
            
            
            
        }
    }

    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);

    function showban() {
        $("#banmodal").modal("show");
    }
    function showdestroy() {
        $("#destroymodal").modal("show");
    }
    function showinfo() {
        $("#infoModal").modal("show");
    }

    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0!
    var yyyy = today.getFullYear();

    if (dd < 10) {
        dd = '0' + dd;
    }

    if (mm < 10) {
        mm = '0' + mm;
    }

    today = dd + '/' + mm + '/' + yyyy;
    $("#now").val(today);

    $('.daterangepicker').daterangepicker({
        autoUpdateInput: false,
        locale: {
            format: 'DD/MM/YYYY',
            cancelLabel: '<%=trs.t("დახურვა")%>'
        }
    });
    $('.daterangepicker').on('apply.daterangepicker', function (ev, picker) {$(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));});
    $('.daterangepicker').on('cancel.daterangepicker', function (ev, picker) {$(this).val('');});
    $(document).on("click", ".jarviswidget-toggle-btn", function () {
        $(".table-size13").toggleClass("active");
    });
    $(document).on("change", "input[name='sendoutside']", function () {
        if ($(this).is(":checked")) {
            $(".con5").show();
            $(".con4").hide();
        } else {
            $(".con5").hide();
            $(".con4").show();
        }
    });
    
    $(document).on("change", "input[name=itemaction]", function () {
        var id = $("input[name=itemaction]:checked").val();
        if (id == "1") {
            $(".con1").show();
            $(".con2").hide();
            $(".con3").hide();
        } else if (id == "2") {
            $(".con1").show();
            $(".con2").show();
            $(".con3").hide();
        } else if (id == "3") {
            $(".con1").show();
            $(".con2").hide();
            $(".con3").show();
        }
    });
    
    $("#frmfilter").keypress(function(e) { 
        if(e.keyCode == 13) {
            var op = $(this).serialize();
            $("#list<%=gridname%>").jqGrid('setGridParam',{url:'content/get<%=gridname%>list.jsp?'+op}).trigger("reloadGrid");
        }
    })
    
    function printForm(){
        var myGrid = $('#list<%=gridname%>');
        var RowId = myGrid.jqGrid('getGridParam', 'selrow');
        if (RowId===null)
            alertError('<%=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
        else
        {
            printReport("F-138-2016-G", RowId)
        }
    }
</script>
<section id="widget-grid" class="" style="padding-right: 5px;">
    <div class="jarviswidget" data-widget-collapsed="true" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false">
        <header>
            <h2><%=trs.t("ფილტრი")%></h2>
        </header>
        <div>
            <div class="smart-form col-sm-12" style="padding: 0;">
    <form id="frmfilter" method="post" accept-charset="UTF-8">               
    <div class="col-sm-12">
                    <section class="col col-sm-3">
                        <label class="input"> <i class="icon-append fa fa-barcode"></i>
                            <input name="barcode" type="text" placeholder="<%=trs.t("ბარკოდი")%>">
                        </label>
                    </section>
                    <section class="col col-sm-3">
                        <label class="input"> <i class="icon-append fa fa-calendar"></i>
                            <input name="daterange" class="daterangepicker" type="text" placeholder="<%=trs.t("თარიღი")%>">
                        </label>
                    </section>
                    <section class="col col-sm-3">
                        <label class="input"> <i class="icon-append fa fa-list-ol"></i>
                            <input name="num1" type="text" placeholder="<%=trs.t("საველე N")%>">
                        </label>
                    </section>
                    <section class="col col-sm-3">
                        <label class="input"> <i class="icon-append fa fa-search"></i>
                            <input name="location" type="text" placeholder="<%=trs.t("ადგილმდებარეობა")%>">
                        </label>
                    </section>
                    
                </div>
                <div class="col-sm-12">
                    <section class="col col-sm-4">
                        <label class="select">
                            <select id="sampletype" name="sampletype" style="width: 100%;">
                                <option value=""><%=trs.t("ნიმუშის ტიპი")%></option>
                                    <%=sampletypes%>
                           </select>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="select">
                            <select id="speciesid" name="speciesid" style="width: 100%;">
                                <option value=""><%=trs.t("სახეობა")%></option>
                                    <%=species%>
                           </select><i></i>
                        </label>
                    </section>
                    <section class="col col-sm-2">
                        <label class="select">
                            <select name="statusid" class="select2">
                                <option value=""><%=trs.t("სტატუსი")%></option>
<%
SamplestatusBean[] samsts = SamplestatusManager.getInstance().loadAll();
for(int i=0;i<samsts.length; i++)
    out.print("<option value="+samsts[i].getSamplestatusid()+">"+trs.t(samsts[i].getName())+"</option>");
%>
                            </select>
                        </label>
                    </section>
                    <button class="btn btn-info pull-right" style="margin-right: 5px; margin-bottom: 0px;" id="clearfilter"><i class="fa fa-times"></i> <%=trs.t("გასუფთავება")%></button>
                    <button class="btn btn-success pull-right" style="margin-right: 5px;" id="startfilter"><i class="fa fa-search"></i> <%=trs.t("ძებნა")%></button>
                </div>
    </form>
            </div>
        </div>
    </div>
</section>
<%if(permissions[0]){%>
<div class="col-md-12 btn-panel">
    <button class="btn btn-primary pull-left" onclick="printDistructionAct();"><i class="fa fa-print"></i> <%=trs.t("განადგურების აქტი")%></button>
    <button class="btn btn-success pull-right showdestroy1"><i class="fa fa-check"></i> <%=trs.t("დადასტურება")%></button>
    <button class="btn btn-primary pull-right" onclick="setReset();"><i class="fa fa-close"></i> <%=trs.t("უკუგდება")%></button>
</div>
<%}%>
<div class="table-size13 active">
    <table id="list<%=gridname%>"></table>
    <div id="pager<%=gridname%>"></div>
</div>
<div class="modal fade" id="destroymodal1" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("განადგურება")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
<form id="frmdestroymodal1" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden" value="status">
<input name="status" type="hidden" value="6">
<input name="id" type="hidden">
                    <section class="col col-sm-12">
                        <label class="label"> <%=trs.t("მეთოდი")%></label>
                        <label class="select">
                            <select name="method" style="width:100%;">
                                <option value=""></option>
<%
DestroymethodBean[] dms = DestroymethodManager.getInstance().loadAll();
for(int i=0;i<dms.length; i++)
    out.print("<option value="+dms[i].getDestroymethodid()+">"+trs.t(dms[i].getName())+"</option>");
%>
                            </select>
                        </label>
                    </section>
                    <section class="col col-sm-6">
                        <label class="label"> <%=trs.t("განადგურების თარიღი")%></label>
                        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                            <input name="destroydate" type="text">
                        </label>
                    </section>
                    <section class="col col-sm-6">
                        <label class="label"> <%=trs.t("განადგურების დრო")%></label>
                        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                            <input name="destroytime" type="text">
                        </label>
                    </section>
</form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("გაუქმება")%></button>
                <button type="button" class="btn btn-danger" onclick="saveForm('destroymodal1')"><%=trs.t("განადგურება")%></button>
            </footer>
        </div>
    </div>
</div>
<script>
$(document).on("click", "#clearfilter", function (e) {e.preventDefault();$(this).closest('form').find("input[type=text], textarea").val(""); $("#list<%=gridname%>").jqGrid('setGridParam',{url:'content/get<%=gridname%>list.jsp'}).trigger("reloadGrid"); });
$(document).on("click", "#startfilter", function (e) {
    e.preventDefault();
    $("#list<%=gridname%>").jqGrid('setGridParam',{
        url:'content/get<%=gridname%>list.jsp?'+$(this).closest('form').serialize()}).trigger("reloadGrid"); 
});

function setReset() {
    var myGrid = $('#list<%=gridname%>');
    var RowId = myGrid.jqGrid('getGridParam', 'selarrrow');
    if (RowId.length==0)
        alertError('<%=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
    else
    {
        
    }
}

function setConfirm() {
    var myGrid = $('#list<%=gridname%>');
    var RowId = myGrid.jqGrid('getGridParam', 'selarrrow');
    if (RowId.length==0)
        alertError('<%=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
    else
    {
        
    }
}


$(document).on("click", ".showban", function () {
    $("#frmbanmodal input[name=id]").val($(this).attr("data-itemid"));
    $("#frmbanmodal textarea[name=reason]").val("");
    $("#banmodal").modal("show");

});
$(document).on("click", ".showdestroy1", function () {
    var myGrid = $('#list<%=gridname%>');
    var RowId = myGrid.jqGrid('getGridParam', 'selarrrow');
    if (RowId.length==0)
        alertError('<%=trs.t("ჩანაწერი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
    else
    {
        var cd = new Date();
        $("#destroymodal1").modal("show");
        $("#frmdestroymodal1 input[name=id]").val(RowId.join(","));
        destroyid2select("frmdestroymodal1",RowId.join(","));
        $("#frmdestroymodal1 input[name=destroydate]").val(cd.getDate() + "/"+ ("0" + (cd.getMonth()+1)).slice(-2) + "/"+ cd.getFullYear());
        $("#frmdestroymodal1 input[name=destroytime]").val(cd.getHours() + ":"+ cd.getMinutes());
        $("#frmdestroymodal1 input[name=destroydate]").datepicker({format: 'dd/mm/yyyy'});
        $("#frmdestroymodal1 input[name=destroytime]").clockpicker({
            donetext: 'Done',
            twelvehour: false,
            autoclose: true
            });
    }
   
});

$(document).on("click", ".showinfo", function () {
    $("#historytree").html("");
    $("#historytree").load("api/gethistory.jsp?id="+$(this).attr("data-itemid"))
    $("#infoModal").modal("show");
});

function select2sample(opt)
{
//  $o =$("#frmfilter select[name=sampletype]");
  $o =$("#sampletype");
  /*
  opt = (typeof opt !== 'undefined') ? opt :[];
  var output = [];
  output.push('<option value=""><%=trs.t("ნიმუში")%></option>');
  $.each(opt, function(i,v) {output.push('<option value="'+ v.id +'">'+ v.name +'</option>');});
  $o.html(output.join(''));
  */
  $o.select2({allowClear: true,
    formatNoMatches: function () {return "<%=trs.t("ნიმუში არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
   }); 
}
/*
function contragentid2select(form) {
    $("#"+form+" input[name=contragentid]").select2({
        minimumInputLength: 1,
        allowClear: true,
        cache: true,
        ajax: {
            url: "api/getobject.jsp?obj=contragentlist",
            dataType: 'json',
            data: function (term, page) {
                return {
                    q: term
                  };
            },
            results: function (data, page) {
                return {results: data
                };
            }
        },
        
        
        
        formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> < %=trs.t("მიმდინარეობს ძიება")%> </span>"},
        formatInputTooShort: function () {return "< %=trs.t("შეიტანეთ დამკვეთის დასახელება ან ნომერი")%>";},
        formatNoMatches: function () {return "< %=trs.t("დამკვეთი არ მოიძებნა")%>";},
        escapeMarkup: function (markup) {return markup;}
    });
}
*/

function departamentid2select(form,pid) {
  $.getJSON("api/getobject.jsp?obj=departamentlist&sampleitemid="+pid, function (opt) {
    $o = $("#"+form+" select[name=departamentid]");
    $o.select2('destroy').empty();
    $o.append($('<option>').text("").attr('value', ""));
    $.each(opt.data, function(i, v) {$o.append($('<option>').text(v.text).attr('value', v.id));});
    
    $o.select2({
        allowClear: true,
        formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
        formatNoMatches: function () {return "<%=trs.t("დეპარტამენტი არ მოიძებნა")%>";},
        escapeMarkup: function (markup) {return markup;}
        });
    
  });
}

function destroyid2select(form,pid) {
    $o = $("#"+form+" select[name=method]");
    $o.select2({
        allowClear: true,
        formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
        formatNoMatches: function () {return "<%=trs.t("მეთოდი არ მოიძებნა")%>";},
        escapeMarkup: function (markup) {return markup;}
        });
}
function testparent2select (form,pid) {
  $.getJSON("api/getobject.jsp?obj=testlist&sampleitemid="+pid, function (opt) {
    $o = $("#"+form+" select[name=testparent]");
    $o.select2('destroy').empty();
    $o.append($('<option>').text("").attr('value', ""));
    $.each(opt.data, function(i, v) {$o.append($('<option>').text(v.text).attr('value', v.id));});
    
    $o.select2({
        allowClear: true,
        formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
        formatNoMatches: function () {return "<%=trs.t("ტესტი არ მოიძებნა")%>";},
        escapeMarkup: function (markup) {return markup;}
        });
    
  });
}
function derivate2select(form,pid) {
return;
  $.getJSON("api/getobject.jsp?obj=departamentlist&sampleitemid="+pid, function (opt) {
    $o = $("#"+form+" select[name=departamentid]");
    $o.select2('destroy').empty();
    $o.append($('<option>').text("").attr('value', ""));
    $.each(opt.data, function(i, v) {$o.append($('<option>').text(v.text).attr('value', v.id));});
    
    $o.select2({
        allowClear: true,
        formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
        formatNoMatches: function () {return "<%=trs.t("დეპარტამენტი არ მოიძებნა")%>";},
        escapeMarkup: function (markup) {return markup;}
        });
    
  });
}
$(function(){
//contragentid2select("frmfilter");
departamentid2select("frmsendmodal","");
select2sample();
});


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
            $('#list<%=gridname%>').trigger( 'reloadGrid' );
        }
    }).fail(function(xhr, textStatus, errorThrown) {
        hideLoader(); 
        alertError('<%=trs.t("შეცდომა")%>',textStatus,'<%=trs.t("დახურვა")%>');
    });
}

    $(document).on("change", "select[name=testparent]", function () {
        var id=$(this).val();
        if (id != "") {
            $.getJSON("api/getobject.jsp?obj=testgroup&id="+id, function (opt) {
                $("#sectestchild").hide();
                $("#testchild-list").html("");
                $o = $("select[name=testchild]");
                $o.select2('destroy').empty();
                $o.append($('<option>').text("").attr('value', ""));
                if (opt.data.length==0)
                    return;
                $("#sectestchild").show();
                $.each(opt.data, function(i, v) {$o.append($('<option>').text(v.text).attr('value', v.id));});
                $o.select2({
                    allowClear: true,
                    formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
                    formatNoMatches: function () {return "<%=trs.t("ტესტი არ მოიძებნა")%>";},
                    escapeMarkup: function (markup) {return markup;}
                    });
            });
        }
    });
</script>
