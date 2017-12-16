<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<link href="js/plugin/bootstrap-datepicker/css/datepicker3.css"  rel="stylesheet">
<script src="js/plugin/bootstrap-datepicker/bootstrap-datepicker.js"></script>
<script src="js/plugin/bootstrap-datepicker/locales/bootstrap-datepicker.ka.js"></script>
<script src="js/plugin/clockpicker/clockpicker.min.js"></script>
<style>
.popover.clockpicker-popover{
    z-index: 1050;
}
</style>
<script>
$(function(){
  $('#blocknum').select2({
        minimumInputLength: 1,
        allowClear: true,
        placeholder: "<%=trs.t("ყუთის ნომერი")%>",
        cache: true,
        ajax: {
            url: "api/getobject.jsp?obj=blocknumlist",
            dataType: 'json',
            data: function (term, page) {return {q: term};},
            results: function (data, page) {return {results: data};}
        },
    formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
    formatInputTooShort: function () {return "<%=trs.t("შეიტანეთ ყუთის შტრიხკოდის ნომერი")%>";},
    formatNoMatches: function () {return "<%=trs.t("შტრიხკოდი არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
  });
})

function setTest() {
    value = $("#blocknum").val();
    if (value == "") 
        alertError('<%=trs.t("ყუთი არჩეული არ არის")%>',"",'<%=trs.t("დახურვა")%>');
    else
    {
        $('#testmodal').modal('show');
        $("#testmodalbody").html("");
        $("#testmodalbody").load("api/load_boxsample_test.jsp?id="+value, function() {
          $o = $("#frmtestmodal select[name=testparent]");
          $o.select2({
        allowClear: true,
        formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>"},
        formatNoMatches: function () {return "<%=trs.t("ტესტი არ მოიძებნა")%>";},
        escapeMarkup: function (markup) {return markup;}
          });
          });
    }
}

var boxinfo;
var testinfo;
function clearBlocknum() {
    $('#blocknum').select2("val","");
    $("#contractnum").html("");
    clearLabtest();
    }
function clearLabtest() {
    Report();
    $("#sampleitem").val("");
    $('#divlabtest').find('input, textarea, button, select').prop('disabled',true);
    $('#divquality').find('input, textarea, button, select').prop('disabled',true);
    $("#numeration").jqGrid('setGridParam',{url:"content/getboxitemresultlist.jsp?disclaim=0&boxid=0&testid=0"}).trigger("reloadGrid"); 
    $("#numeration1").jqGrid('setGridParam',{url:"content/getboxitemresultlist.jsp?disclaim=1&boxid=0&testid=0"}).trigger("reloadGrid"); 
    $(".dtpicker").datepicker({
        format: 'dd/mm/yyyy', 
        startDate: getFmtDate(new Date()),
        autoclose: true, 
        language: 'ka', 
        todayHighlight: true, 
	prevText : '<i class="fa fa-chevron-left"></i>',
	nextText : '<i class="fa fa-chevron-right"></i>'
	});
    $(".clockpicker").clockpicker({
        donetext: 'Done',
        twelvehour: false,
        autoclose: true
        }); 
    select2labtest();
    }

function getFmtDate(date) {
  var year = date.getFullYear();
  var month = (1 + date.getMonth()).toString();
  month = month.length > 1 ? month : '0' + month;
  var day = date.getDate().toString();
  day = day.length > 1 ? day : '0' + day;
  return  day + '/' + month + '/' + year;
}    

function loadSampleNum(id) {
  $.getJSON("api/getobject.jsp?obj=boxitemresult&id="+id, function (res) {
    var pos = res.QC.positive=='დადებითი' ? 'checked="checked"' : '';
    var neg = res.QC.negative!='უარყოფითი' ? 'checked="checked"' : '';
    $("#person").val(res.QC.person).change();
    $("#crdate").val(res.QC.qcdate);
    $("#crtime").val(res.QC.qctime);
    $("#secqc").html('<label class="toggle"><input name="positive" id="positive" '+pos+' type="checkbox"><i data-swchon-text="POS" data-swchoff-text="NEG"></i><%=trs.t("დადებითი")%></label><label class="toggle"><input name="negative" id="negative" '+neg+' type="checkbox"><i data-swchon-text="POS" data-swchoff-text="NEG"></i><%=trs.t("უარყოფითი")%></label>');
    $("#secans").html('<div class="inline-group"><label class="radio"><input id="radio-inline-1" name="testresult" value="დადებითი" '+(res.result=='დადებითი' ? 'checked="checked"' : '')+' type="radio"><i></i><%=trs.t("დადებითი")%></label><label class="radio"><input id="radio-inline-2" name="testresult" value="უარყოფითი" '+(res.result!='დადებითი' ? 'checked="checked"' : '')+'type="radio"><i></i><%=trs.t("უარყოფითი")%></label></div>');
    $("#sampleitem").val(res.itemid);
  });
}

function loadBoxsamples() {
    value = $("#blocknum").val();
    if (value == "") 
    {
        clearBlocknum();
    }
    else
    {
      $.getJSON("api/getobject.jsp?obj=boxtests&boxid="+value, function (res) {
        boxinfo=res.data;
        $("#contractnum").html("#"+res.data.contract);
        $('#divlabtest').find('input, textarea, button, select').prop('disabled',false);
        $('#divquality').find('input, textarea, button, select').prop('disabled',false);
        select2labtest(res.data.labtest);
        Report();
      });
    }
}
function Report() {
    var boxid  = $("#blocknum").val();
    var testid = $("#labtest").val();
    if (boxid == "" || testid=="")
    {
        $("#totalsample").html("");
        $("#submitsample").html("");
        $("#disclaimsample").html("");
        $("#leftsample").html("");
        $("#progresspercent").html("<div class=\"progress-bar progress-bar-primary\" role=\"progressbar\" style=\"width: 0%;\">0%</div>");
    }
    else
    {
      $.getJSON("api/getobject.jsp?obj=boxtestreport&boxid="+boxid+"&testid="+testid, function (res) {
        $("#totalsample").html(res.data.total);
        $("#submitsample").html(res.data.submited);
        $("#disclaimsample").html(res.data.disclaim);
        $("#leftsample").html(res.data.total-res.data.submited);
        var p = (res.data.total==0) ? 0 : parseInt((res.data.submited/res.data.total)*100);
        $("#progresspercent").html("<div class=\"progress-bar progress-bar-primary\" role=\"progressbar\" style=\"width: "+p+"%;\">"+p+"%</div>");
        });
    }
}
function select2labtest(opt)
{
  opt = (typeof opt !== 'undefined') ? opt :[];
  var output = [];
  output.push('<option value=""><%=trs.t("კვლევა")%></option>');
  $.each(opt, function(i,v) {output.push('<option value="'+ v.id +'">'+ v.name +'</option>');});
  $('#labtest').html(output.join(''));
  $("#labtest").select2({allowClear: true,
    formatNoMatches: function () {return "<%=trs.t("კვლევა არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
   }); 
}

$(document).on("change", "#labtest", function () {
    var boxid  = $("#blocknum").val();
    var testid = $("#labtest").val().trim();
    if (boxid == "") 
    {
        clearBlocknum();
    }
    else if (testid=="")
    {
        clearLabtest();
    }
    else
    {
      $.getJSON("api/getobject.jsp?obj=boxtestinfo&boxid="+boxid+"&testid="+testid, function (res) {
        testinfo=res.data;
        $('#divlabtest').find('input, textarea, button, select').prop('disabled',false);
        $('#divquality').find('input, textarea, button, select').prop('disabled',false);
        $("#numeration").jqGrid('setGridParam',{url:"content/getboxitemresultlist.jsp?disclaim=0&boxid="+boxid+"&testid="+testid}).trigger("reloadGrid"); 
        $("#numeration1").jqGrid('setGridParam',{url:"content/getboxitemresultlist.jsp?disclaim=1&boxid="+boxid+"&testid="+testid}).trigger("reloadGrid"); 
        Report();
      });
    }
});

$(document).on("change", "#sampleitem", function () {
    inputResult();
});

function inputResult() {
    var testid = $("#labtest").val().trim();
    var itemid = $("#sampleitem").val().trim();
    if (testid=="" || itemid==="")
        return;
    var qcperson = $("#person").val();
    var qcdate   = $("#crdate").val();
    var qctime   = $("#crtime").val();
    if (qcperson=="")
    {
        alertError('<%=trs.t("შეცდომა")%>',"შეიტანეთ ხარისხის კონტროლი ვინ ჩაატარა",'<%=trs.t("დახურვა")%>');
        return;
    }
    else if (qcdate=="")
    {
        alertError('<%=trs.t("შეცდომა")%>',"შეიტანეთ ჩატარების თარიღი",'<%=trs.t("დახურვა")%>');
        return;
    }
    else if (qctime=="")
    {
        alertError('<%=trs.t("შეცდომა")%>',"შეიტანეთ ჩატარების დრო",'<%=trs.t("დახურვა")%>');
        return;
    }    
    var data = {
        oper:"setboxitemresult",
        itemid:itemid,
        testid:testid,
        boxid:$("#blocknum").val(),
        person:qcperson,
        qcdate:qcdate,
        qctime:qctime,
        positive:$("input[name=positive]:checked").val(),
        negative:$("input[name=negative]:checked").val(),
        value:$("input[name=testresult]:checked").val()
    }
    sendRequest("api/setsampletype.jsp",data,cbItemResult);
}

$(document).on("change", '#blocknum', function (e) {
    loadBoxsamples();
});

pageSetUp();

function cbItemResult(rs)
{
    if (rs.status=='ER')
    {
        alertError('<%=trs.t("შეცდომა")%>',rs.message,'<%=trs.t("დახურვა")%>');
    }
    else 
    {
        $("#numeration").trigger("reloadGrid"); 
        Report();
    }
    $("#sampleitem").val("");
}

var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);

        function run_jqgrid_function() {
            jQuery("#numeration").jqGrid({
                url: 'content/getboxitemresultlist.jsp?disclaim=0&boxid='+$("#blocknum").val(),
                datatype: "json",
                colNames: ['<%=trs.t("საველე N")%>', '<%=trs.t("ცხოველის N")%>', '<%=trs.t("ბარკოდი")%>', '<%=trs.t("პასუხი")%>', '<%=trs.t("მოქმედება")%>'],
                colModel: [
                    {name: 'num', index: 'num', editable: true, align: "center", width: 200, edittype: "text", editoptions: {size: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'animal', index: 'animal', editable: true, align: "center", width: 200, edittype: "text", editoptions: {size: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'code', index: 'code', editable: true, align: "center", width: 200, edittype: "textarea", editoptions: {rows: "3", cols: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'ans', index: 'ans', editable: true, align: "center", width: 150, edittype: "text", editoptions: {size: "8"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'print', index: 'print', editable: true, align: "center", width: 150, edittype: "text", editoptions: {size: "8"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}}
                ],
                onSelectRow: function(ids) { 
                    if(ids !== null) {
                        loadSampleNum(ids);
                    } 
                },                        
                gridComplete:function() {
                },
                rowNum: 20,
                height: 300,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagernumeration'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                caption: ''
            })
            .navGrid('#pagernumeration', {edit: false, add: false, del: false, view: false, search: false});

            jQuery("#numeration1").jqGrid({
                url: 'content/getboxitemresultlist.jsp?disclaim=1&boxid='+$("#blocknum").val(),
                datatype: "json",
                colNames: ['<%=trs.t("საველე N")%>', '<%=trs.t("ცხოველის N")%>', '<%=trs.t("დაწუნების მიზეზი")%>', '<%=trs.t("პასუხი")%>', '<%=trs.t("მოქმედება")%>'],
                colModel: [
                    {name: 'num', index: 'num', editable: true, align: "center", width: 200, edittype: "text", editoptions: {size: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'animal', index: 'animal', editable: true, align: "center", width: 200, edittype: "text", editoptions: {size: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'code', index: 'code', editable: true, align: "center", width: 200, edittype: "textarea", editoptions: {rows: "3", cols: "30"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'ans', index: 'ans', editable: true, align: "center", width: 150, edittype: "text", editoptions: {size: "8"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}},
                    {name: 'print', index: 'print', editable: true, align: "center", width: 150, edittype: "text", editoptions: {size: "8"}, searchoptions: {sopt: ['bw', 'bn', 'in', 'ni', 'ew', 'en', 'cn', 'nc']}}
                ],
                gridComplete:function() {
                },
                rowNum: 20,
                height: 300,
                width: 1000,
                autowidth: true,
                rowList: [20, 50, 100],
                pager: jQuery('#pagernumeration1'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                caption: ''
            })
            .navGrid('#pagernumeration1', {edit: false, add: false, del: false, view: false, search: false});

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

            jQuery("#numeration").jqGrid('setGridWidth', $(".gridsize").width() - 50);
            jQuery("#numeration1").jqGrid('setGridWidth', $(".gridsize").width() - 50);
            $(window).on('resize.jqGrid', function () {
                jQuery("#numeration").jqGrid('setGridWidth', $(".gridsize").width() - 50);
                jQuery("#numeration1").jqGrid('setGridWidth', $(".gridsize").width() - 50);
            });

  clearBlocknum();

        }


    };
    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);
    $(document).on("change", "input[name='radio-inline']", function () {
        var id = $("input[name='radio-inline']:checked").attr('id');
    });
    $(document).on("click", "#result-btn", function () {
        var testid = $("#labtest").val().trim();
        if (testid=="")
            return;

        $("#resModal").modal("show");
    });
    $(document).on("click", ".test-list-item button", function () {
        $(this).find("i").toggleClass("fa-check").toggleClass("fa-warning");
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
            $("#numeration").trigger("reloadGrid"); 
            $("#numeration1").trigger("reloadGrid"); 
            Report();
            $("#"+frm).modal("hide");
        }
    }).fail(function(xhr, textStatus, errorThrown) {
        hideLoader();
        alertError('<%=trs.t("შეცდომა")%>',textStatus,'<%=trs.t("დახურვა")%>');
    });
}
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


$(document).on("click", ".deleteban", function () {
        $("#frmdelmodal input[name=id]").val($(this).attr("data-itemid"));
        $("#delmodal").modal("show");
    });
$(document).on("click", ".banitem", function () {
        $("#frmbanmodal input[name=id]").val($(this).attr("data-itemid"));
        $("#frmbanmodal textarea[name=reason]").val("");
        $("#banmodal").modal("show");
    });
$(document).on("click", ".cancelban", function () {
        $("#frmcancelmodal input[name=id]").val($(this).attr("data-itemid"));
        $("#cancelmodal").modal("show");
    });
$(document).on("click", "#resetbutton", function () {
    var boxid  = $("#blocknum").val();
    var testid = $("#labtest").val().trim();
    if (boxid=='' || testid=='')
    {
    }
    else
    {
        $("#frmresetmodal input[name=boxid]").val(boxid);
        $("#frmresetmodal input[name=testid]").val(testid);
        $("#resetmodal").modal("show");
    }
    });
$(document).on("click", ".delitem", function () {
        ConfirmDelete('api/delobject.jsp',{obj:"objcontractsampleitem",id:$(this).attr("data-itemid")},cbDeleteContractSample);
        //sendRequest("api/delobject.jsp",{obj:"objcontractsampleitem",id:$(this).attr("data-itemid")},cbDeleteContractSample);
});
</script>
<div class="jarviswidget jarviswidget-sortable" id="wid-id-3" data-widget-editbutton="false" data-widget-custombutton="false" role="widget" style="position: relative; opacity: 1; left: 0px; top: 0px;">
    <header role="heading">
        <span class="widget-icon"> <i class="fa fa-edit"></i> </span>
        <h2><%=trs.t("ხელშეკრულება")%> <span id="contractnum"> <b></b></span></h2>				
        <span class="jarviswidget-loader"><i class="fa fa-refresh fa-spin"></i></span>
    </header>
    <div role="content">
        <div class="jarviswidget-editbox"></div>
        <div class="widget-body no-padding">
            <div id="order-form" class="smart-form" novalidate="novalidate">
                <fieldset>
                    <div class="row">
                        <div class="col col-4">
                            <section class="col col-md-12">
                                <div class="input-group">
                                    <label class="input"> 
    <input type="hidden" id="blocknum" style="width:100%" />
                                    </label>
                                    <div class="input-group-btn">
                                        <button class="btn btn-danger clearbtn"  data-original-title="<%=trs.t("გასუთავება")%>" type="button" onclick="clearBlocknum()">
                                            <i class="fa fa-times"></i>
                                        </button>
                                    </div>
                                    <div class="input-group-btn">
                                        <button class="btn btn-success clearbtn"  data-original-title="<%=trs.t("ტესტის დანიშვნა")%>" type="button" onclick="setTest();">
                                            <i class="fa fa-eyedropper"></i>
                                        </button>
                                    </div>
                                </div>
                            </section>
                            <section class="col col-md-12">
                                <label class="select">
    <select id="labtest" style="width:100%"  ></select>
                                </label>
                            </section>
                            <section class="col col-md-12">
                                <div id="divquality" class="jarviswidget" data-widget-collapsed="true" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false" style="width: 100%;">
                                    <header style="width: 100%;padding: 0 !important;margin: 0 !important;">
                                        <h2><%=trs.t("ხარისხის კონტროლი")%></h2>
                                    </header>
                                    <div style="box-sizing: border-box;">
                                        <section class="col col-sm-12">
                                            <label class="label"><%=trs.t("ჩაატარა")%></label>
                                            <label class="select">
        <select name="person"  id="person"  placeholder="<%=trs.t("ჩაატარა")%>"   class="select2" style="width:100%;">>
        <option value=""></option>
<%
    PersonellBean[] per = PersonellManager.getInstance().loadByWhere("WHERE deleted<>true and companyid="+user.getCompanyid()+" ORDER BY lname,fname");
    for (int i=0;  i<per.length; i++)
    {
        String sel = "";
        out.print("<option value=\""+per[i].getPersonellid()+"\" "+sel+">"+per[i].getFname()+" "+per[i].getLname()+"</option>");
    }
%>
        </select>
                                            </label>
                                        </section>
        <section class="col col-sm-12" >
        <label class="label"><%=trs.t("ჩატარების თარიღი და დრო")%></label>
        </section>
        <section class="col col-sm-6" >
        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
        <input name="crdate" id="crdate" type="text"  class="dtpicker" placeholder="<%=trs.t("თარიღი")%>" value="">
        </label>
        </section>
        <section class="col col-sm-6" >
        <label class="input"> <i class="icon-append fa fa-clock-o"></i>
        <input name="crtime" id="crtime" type="text"  class="clockpicker" placeholder="<%=trs.t("დრო")%>"   value="">
        </label>
        </section>
        <section class="col col-sm-12" id="secqc">
            <label class="toggle">
            <input name="positive" id="positive" checked="checked" type="checkbox">
            <i data-swchon-text="POS" data-swchoff-text="NEG"></i><%=trs.t("დადებითი")%>
            </label>
            <label class="toggle">
            <input name="negative" id="negative" type="checkbox">
            <i data-swchon-text="POS" data-swchoff-text="NEG"></i><%=trs.t("უარყოფითი")%>
            </label>
        </section>
                                        <!----section class="col col-sm-12">
                                            <button class="btn btn-default" id="result-btn"><%=trs.t("ნიმუშების დაკავშირება")%></button>
                                        </section--->
                                    </div>
                                </div>
                            </section>
                            <section class="col col-md-12">
                                <div id="divlabtest" class="jarviswidget" data-widget-collapsed="true" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false" style="width: 100%;">
                                    <header style="width: 100%;padding: 0 !important;margin: 0 !important;">
                                        <h2><%=trs.t("პასუხები")%></h2>
                                    </header>
                                    <div style="box-sizing: border-box;">
                            <section class="col col-md-12" id="secans">
                                <div class="inline-group">
                                    <label class="radio">
                                        <input id="radio-inline-1" name="testresult" value="დადებითი" checked="checked" type="radio">
                                        <i></i><%=trs.t("დადებითი")%></label>
                                    <label class="radio">
                                        <input id="radio-inline-2" name="testresult" value="უარყოფითი" type="radio">
                                        <i></i><%=trs.t("უარყოფითი")%></label>
                                </div>
                            </section>

<section class="col col-sm-12">
    <div class="input-group">
    <label class="input"> <input placeholder="ნიმუშის ნომერი" type="text" name="sampleitem" id="sampleitem"></label>
    <div class="input-group-btn">
        <button class="btn btn-success" type="button">დაკავშირება</button>
    </div>
    <div class="input-group-btn" id="editcontragentbtn">
        <button class="btn btn-default"  data-original-title="<%=trs.t("კლავიატურიდან შეტანა")%>" type="button" onclick="inputResult()">
            <i class="fa fa-pencil"></i>
        </button>
    </div>
    </div>
</section>              
                                    </div>
                                </div>
                            </section>
                            <section class="col col-md-12">
                                <div id="divquality" class="jarviswidget" data-widget-collapsed="true" data-widget-colorbutton="false" data-widget-editbutton="false" data-widget-custombutton="false" data-widget-deletebutton="false" data-widget-fullscreenbutton="false" style="width: 100%;">
                                    <header style="width: 100%;padding: 0 !important;margin: 0 !important;">
                                        <h2><%=trs.t("ნიმუშების რაოდენობა: ")%><span class=" text-align-right text-primary" id="totalsample"></span></h2>
                                    </header>
                                    <div style="box-sizing: border-box;">
                            <section class="col col-md-12"  >
                                    <div class="row" ><div class="col-md-8"><%=trs.t("გატარებულია")%>:</div><div class="col-md-4"><span class=" text-align-right text-primary" id="submitsample"></span></div></div>
                                    <div class="row" style="padding-top: 10px;"><div class="col-md-8"><%=trs.t("დარჩენილია")%>:</div><div class="col-md-4"><span class=" text-align-right text-primary" id="leftsample"></span></div></div>
                                    <div class="row" style="padding-top: 20px;"><div class="col-md-8"><%=trs.t("დაწუნებულია")%>:</div><div class="col-md-4"><span class=" text-align-right text-danger" id="disclaimsample"></span></div></div>
                                    <div class="row" style="padding-top: 10px;">
                                                <div class="col-md-12">
                                                    <div class="progress progress-striped active no-margin" id="progresspercent">
                                                    </div>
                                                </div>
                                        </div>
                            </section>
                                    </div>
                                </div>
                            </section>
                            <section class="col col-md-12" id="end-field">
                                <button class="btn btn-success btn-full"><%=trs.t("დასრულება")%></button>
                            </section>
                        </div>
                        <div class="col col-8 gridsize">
                            <div class="btn-box">
                                <button class="btn btn-danger pull-right" id="resetbutton" ><i class="fa fa-trash"></i> <%=trs.t("ყველას წაშლა")%></button>
                            </div>
                            <ul id="stockmovementmain" class="nav nav-tabs bordered half">
                                <li class="active"><a href="#i1" data-toggle="tab"> <%=trs.t("მიღებული")%></a></li>
                                <li><a href="#i2" data-toggle="tab"> <%=trs.t("დაწუნებული")%></a></li>
                            </ul>
                            <div id="stockmovementmaincontent" class="tab-content padding-10">
                                <div class="tab-pane fade in active" id="i1" style="height: calc(100vh - 345px) !important;">
                                    <section class="col col-md-12">
                                        <div class="table-size3">
                                            <table id="numeration" width='100%'></table>
                                            <div id="pagernumeration"></div>
                                        </div>
                                    </section>
                                </div>
                                <div class="tab-pane fade" id="i2" style="height: calc(100vh - 345px) !important;">
                                    <section class="col col-md-12">
                                        <div class="table-size3">
                                            <table id="numeration1" width='100%'></table>
                                            <div id="pagernumeration1"></div>
                                        </div>
                                    </section>
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="resetmodal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ყურადღება")%></h4>
            </div>
            <div class="modal-body">
<form id="frmresetmodal" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden" value="resetboxresult">
<input name="boxid" type="hidden">
<input name="testid" type="hidden">
                <h2 id="message"><%=trs.t("დარწმუნებული ხართ, რომ გნებავთ მთლიანი ცხრილის გასუფთავება?")%></h2>
</form>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("არა")%></button>
                <button type="button" class="btn btn-success" onclick="saveForm('resetmodal')"><%=trs.t("დიახ")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="delmodal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ყურადღება")%></h4>
            </div>
            <div class="modal-body">
<form id="frmdelmodal" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden" value="deleteresearch">
<input name="id" type="hidden">
                <h2 id="message"><%=trs.t("დარწმუნებული ხართ, რომ გნებავთ ამ მოქმედების შესრულება?")%></h2>
</form>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("არა")%></button>
                <button type="button" class="btn btn-success" onclick="saveForm('delmodal')"><%=trs.t("დიახ")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="banmodal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("დაწუნება")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
<form id="frmbanmodal" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden" value="cancelrestore">
<input name="status" type="hidden" value="2">
<input name="id" type="hidden">
                    <section class="col col-sm-12">
                        <label class="label"><%=trs.t("დაწუნების მიზეზი")%></label>
                        <label class="textarea"> <i class="icon-append fa fa-info"></i>
                            <textarea name="reason"></textarea>
                        </label>
                    </section>
</form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("არა")%></button>
                <button type="button" class="btn btn-warning" onclick="saveForm('banmodal')"><%=trs.t("დაწუნება")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="cancelmodal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ყურადღება")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
<form id="frmcancelmodal" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" type="hidden" value="cancelrestore">
<input name="status" type="hidden" value="1">
<input name="id" type="hidden">
                <h2 id="message"><%=trs.t("დარწმუნებული ხართ, რომ გნებავთ დაწუნებულის უკან დაბრუნება?")%></h2>
</form>
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("არა")%></button>
                <button type="button" class="btn btn-success" onclick="saveForm('cancelmodal')"><%=trs.t("დიახ")%></button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="resModal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="result-title"><%=trs.t("ნიმუშების დაკავშირება ხარისხის კონტროლებთან")%></h4>
            </div>
            <div class="modal-body">
                <div class="smart-form">
<section class="col col-sm-12">
    <label class="label">ბარკოდი <span id="barcodecnt"><span></label>
    <div class="input-group">
    <label class="input"> <input type="text" name="itemid" id="itemid"></label>
    <div class="input-group-btn">
        <button class="btn btn-success" type="button">დაკავშირება</button>
    </div>
    <div class="input-group-btn" id="editcontragentbtn">
        <button class="btn btn-default"  data-original-title="<%=trs.t("კლავიატურიდან შეტანა")%>" type="button" onclick="inputBarcode()">
            <i class="fa fa-pencil"></i>
        </button>
    </div>
    </div>
</section>              
<section class="col col-sm-12">
    <div id='barcodelist'></div>
</section>
                </div>
            </div>
            <footer class="modal-footer" style="padding: 10px 20px 20px 0px;">
                <button type="button" class="btn btn-danger btn-sm">
                    <%=trs.t("შენახვა")%>
                </button>
                <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">
                    <%=trs.t("დახურვა")%>
                </button>
            </footer>
        </div>
    </div>
</div>
<div class="modal fade" id="testmodal" tabindex="-1" role="dialog" aria-labelledby="iconsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title"><%=trs.t("ტესტის დანიშვნა")%></h4>
            </div>
            <div class="modal-body">
                <div class='smart-form' id="testmodalbody">
                </div>
            </div>
            <footer class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal"><%=trs.t("გაუქმება")%></button>
                <button type="button" class="btn btn-success" onclick="saveForm('testmodal')"><%=trs.t("შენახვა")%></button>
            </footer>
        </div>
    </div>
</div>         
                