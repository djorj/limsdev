/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


    
    
    
    
    $(document).on("click", ".closeall", function () {
        $("#contragent-box").hide();
        $("#contract-box").hide();
        $("#appeal-box").hide();
        $("#print-box1").hide();
        $("#print-box2").hide();
        $("#grid-box").hide();
        $("#sample-box").hide();
        $("#act-box").hide();
    });
    
    $(document).on("click", ".labtestcount", function () {
        editAnalysis();
        $('#analyses-tab a[href="#s'+$(this).attr("data-itemid")+'"]').trigger('click');
    });
    $(document).on("click", ".banitem", function () {
        $("#frmbanitem input[name=id]").val($(this).attr("data-itemid"));
        $("#frmbanitem textarea[name=reason]").val("");
        $("#banModal").modal("show");
    });
    $(document).on("click", ".delitem", function () {
        ConfirmDelete('api/delobject.jsp',{obj:"objcontractsampleitem",id:$(this).attr("data-itemid")},cbDeleteContractSample);
        //sendRequest("api/delobject.jsp",{obj:"objcontractsampleitem",id:$(this).attr("data-itemid")},cbDeleteContractSample);
    });
    $(document).on("click", ".delsample", function () {
        ConfirmDelete('api/delobject.jsp',{obj:"objcontractsample",id:$(this).attr("data-itemid")},cbDeleteContractSample);
        //sendRequest("api/delobject.jsp",{obj:"objcontractsample",id:$(this).attr("data-itemid")},cbDeleteContractSample);
    });

    $(document).on("click", ".sampletypeinfo", function () {
        $(this).tooltip('destroy');
        var id = $(this).attr("data-itemid");
        $("#samplecomment").modal("show");
        $("#frmsamplecomment").load("api/load_sampleinfo_form.jsp?sampletypeid="+id);
    });
    
    $(document).on("click", ".sampletypeinfoitem", function () {
        $(this).tooltip('destroy');
        var id = $(this).attr("data-itemid");
        $("#samplecomment").modal("show");
        $("#frmsamplecomment").load("api/load_sampleinfo_form.jsp?sampleitemid="+id);
    });
    
    $(document).on("click", ".sampleiteminfo", function () {
        $(this).tooltip('destroy');
        var id = $(this).attr("data-itemid");
        $("#samplecomment").modal("show");
        $("#frmsamplecomment").load("api/load_sampleinfo_form.jsp?sampleitemid="+id);
    });
    $(document).on("click", ".updsample", function () {
        $(this).tooltip('destroy');
        var id = $(this).attr("data-itemid");
        sendRequest("api/setsampletype.jsp",{oper:"updSample",id:id,num1:$("#num1_"+id).val(),num2:$("#num2_"+id).val(),quantity:$("#qnt_"+id).val()},cbUpdSample);
    });
    $(document).on("click", ".samplequantity", function () {
        $(this).tooltip('destroy');
        var id = $(this).attr("data-itemid");
        sendRequest("api/setsampletype.jsp",{oper:"updSampleQuantity",id:id,quantity:$("#quantity_"+id).val()},cbUpdSample);
    });
    $(document).on("click", ".samplenums", function () {
        $(this).tooltip('destroy');
        var id = $(this).attr("data-itemid");
        sendRequest("api/setsampletype.jsp",{oper:"updSampleNums",id:id,num1:$("#num1_"+id).val(),num2:$("#num2_"+id).val()},cbUpdSample);
    });
    $(document).on("click", ".sampleboxnum", function () {
        $(this).tooltip('destroy');
        var id = $(this).attr("data-itemid");
        sendRequest("api/setsampletype.jsp",{oper:"updSampleBoxNum",id:id,num1:$("#boxnum_"+id).val()},cbUpdSample);
    });
    $(document).on("change", ".selspicies", function () {
        $(this).tooltip('destroy');
        var id = $(this).attr("data-itemid");
        sendRequest("api/setsampletype.jsp",{oper:"updSpecies",id:id,spcid:$("#spc_"+id).val(),num1:$("#num1_"+id).val(),num2:$("#num2_"+id).val()},cbUpdSample);
    });
    $(document).on("change", ".selspiciesitem", function () {
        $(this).tooltip('destroy');
        var id = $(this).attr("data-itemid");
        sendRequest("api/setsampletype.jsp",{oper:"updSpeciesItem",id:id,spcid:$("#spc_"+id).val(),num1:$("#num1_"+id).val(),num2:$("#num2_"+id).val()},cbUpdSample);
    });
    $(document).on("click", "#boxmode", function () {
        if ($(this).hasClass("btn-default"))
            $(this).removeClass("btn-default").addClass("btn-success");
        else
            $(this).removeClass("btn-success").addClass("btn-default");
    });
    $(document).on("change", "#contract-type", function () {
        if ($(this).val() == "0") {
            $(".contr1").hide();
            $(".contr2").hide();
            $(".contr4").hide();
        } else if ($(this).val() == "1") {
            $(".contr1").show();
            $(".contr2").hide();
        } else {
            $(".contr1").hide();
            $(".contr4").hide();
            $(".contr2").show();
        }
    });
    $(document).on("change", "#frmcontragent select[name=contragenttypeid]", function () {
        if ($(this).val() == "1") {
            $("#org-code").attr("placeholder","<%=trs.t("პირადი ნომერი")%>");
            $(".contragenttypeid").show();
        } else {
            $("#org-code").attr("placeholder","<%=trs.t("საიდენტიფიკაციო კოდი")%>");
            $(".contragenttypeid").hide();
        }
    });
    
    $(document).on("change", ".contractsample", function () {
      var v = $(this).val();
      var s = this.name.substring(10);
      $.getJSON("api/getobject.jsp?obj=labtest&sample="+v, function (json) {
        opt = json.data;
        var output = [];
        output.push('<option value=""><%=trs.t("კვლევა")%></option>');
        $.each(opt, function(i,v) {output.push('<option value="'+ v.id +'">'+ v.name +'</option>');});
        $("#labtest"+s).html(output.join(''));
        $("#labtest"+s).select2({allowClear: true,placeholder: "<%=trs.t("კვლევა")%>",
            formatNoMatches: function () {return "<%=trs.t("კვლევა არ მოიძებნა")%>";},
            escapeMarkup: function (markup) {return markup;}
            }); 
      });
    });

    $(document).on("change", ".contracttest", function () {
      var v = $(this).val();
      var s = this.name.substring(7);
      $.getJSON("api/getobject.jsp?obj=sampletype&labtest="+v, function (json) {
        opt = json.data;
        var output = [];
        output.push('<option value=""><%=trs.t("ნიმუში")%></option>');
        $.each(opt, function(i,v) {output.push('<option value="'+ v.id +'">'+ v.name +'</option>');});
        $("#sampletype"+s).html(output.join(''));
        $("#sampletype"+s).select2({allowClear: true,placeholder: "<%=trs.t("ნიმუში")%>",
            formatNoMatches: function () {return "<%=trs.t("ნიმუში არ მოიძებნა")%>";},
            escapeMarkup: function (markup) {return markup;}
            }); 
      });
    });
    $(document).on("change", "#upload-contract", function () {if ($(this).val()){$('#filename-contract').html('<span> ' + $(this).val() + ' <span id="remove-contr" class="fa fa-times"></span></span>');}else{$('#filename-contract').html("<%=trs.t("ხელშეკრულების ატვირთვა")%>");}});
    $(document).on("change", "#upload-appeal", function () { if ($(this).val()){$('#filename-appeal').html('<span> ' + $(this).val() + ' <span id="remove-appeal" class="fa fa-times"></span></span>');}else{$('#filename-appeal').html("<%=trs.t("მიმართვის ატვირთვა")%>");}});
    $(document).on("change", "#upload-bill", function () {
        var billnum = $("#billnum").val();
        var input = this;
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            if(billnum == '')   {
                    $("#errorbill").show();
                    $("#errorbilltxt").html('<%=trs.t("მიუთითეთ ქვითრის ნომერი")%>');
                    setTimeout(function(){ $("#errorbill").hide(); $("#errorbilltxt").html(""); }, 5000);
                } else {
                    reader.onload = function (e) {
                        var tm = new Date().valueOf();
                        var s = "<li class='list-group-item justify-content-between' id='bill"+tm+"' style='padding: 10px 15px !important; margin-top: 5px !important;'><a href='";
                        s += e.target.result;
                        s += "' target='_blank'>"+billnum+"</a><span class='pull-right' style='cursor: pointer;'><a class='btn btn-danger btn-xs' onclick='$(\"#bill"+tm+"\").remove();' style='padding: 1px 7px !important;'><i class='fa fa-times'></i> </a></span>";
                        s += "<input type='hidden' name='bill' value='"+billnum+"'/><input type='hidden' name='bill_"+billnum+"' value='"+e.target.result+"'/></li>";
                        $("#billlist").append(s);
                        $("#billnum").val("");
                    };
                    reader.readAsDataURL(input.files[0]);
                }
        }
    });
    $(document).on("change", "#upload-docs", function () {
        var doctype = $("#frmdocs select[name=doctypeid]").val();
        var input = this;
        if (input.files && input.files[0]) {
            if(doctype == '')   {
                $("#errordocs").show();
                $("#errordocstxt").html('<%=trs.t("აირჩიეთ დოკუმენტის ტიპი")%>');
                setTimeout(function(){ $("#errordocs").hide(); $("#errordocstxt").html(""); }, 5000);
            } else {
                var docsnum = $("#upload-docs").val();
                var reader = new FileReader();
                reader.onload = function (e) {
                        var tm = new Date().valueOf();
                        var s = "<li class='list-group-item justify-content-between' id='docs"+tm+"' style='padding: 10px 15px !important; margin-top: 5px !important;'><a href='";
                        s += e.target.result;
                        s += "' target='_blank'>"+docsnum+"</a><span class='pull-right' style='cursor: pointer;'><a class='btn btn-danger btn-xs' onclick='$(\"#docs"+tm+"\").remove();' style='padding: 1px 7px !important;'><i class='fa fa-times'></i> </a></span>";
                        s += "<input type='hidden' name='docs_"+doctype+"' value='"+e.target.result+"'/></li>";
                        $("#docslist").append(s);
                        $("#docsnum").val("");
                    };
                reader.readAsDataURL(input.files[0]);
            }
        }
    });
    $(document).on("click", "#remove-contr", function (e) {e.preventDefault();$('#upload-contract').val("").change();});
    $(document).on("click", "#remove-appeal", function (e) {e.preventDefault();$('#upload-appeal').val("").change();});
    $(document).on("click", "#remove-bill", function (e) {e.preventDefault();$('#upload-bill').val("").change();});
    $(document).on("click", "#remove-docs", function (e) {e.preventDefault();$('#upload-docs').val("").change();});
    $(document).on("click", ".clearbtn", function () {
        $(this).parent().parent().find("select").val("").trigger("change");
    });

    

    $(document).on("shown.bs.tab", 'a[data-toggle="tab"]', function(e) {
        var tb = $(this).attr("data-table");
        $('#'+tb).trigger('reloadGrid');
        $("#"+tb).jqGrid('setGridWidth', $("#grid-box").width() - 30);
    });
    
    
    
    
    
    
    
    
    
    
    $('#contragent').select2({
        minimumInputLength: 0,
        allowClear: true,
        placeholder: "<%=trs.t("კონტრაგენტი")%>",
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
                return {
                    results: data
                };
            }
        },
    formatSearching: function(){return "<span><i class='fa fa-spin fa-spinner'></i> <%=trs.t("მიმდინარეობს ძიება")%> </span>";},
    formatInputTooShort: function () {return "<%=trs.t("შეიტანეთ კონტრაგენტის ნომერი ან დასახელება")%>";},
    formatNoMatches: function () {return "<%=trs.t("კონტრაგენტი არ მოიძებნა")%>";},
    escapeMarkup: function (markup) {return markup;}
    });

   
    $(document).on("change", "#sample", function () {
        var v = $("#sample").val().trim();
        if (v=="")
            return;
        else if ($("#boxmode").hasClass("btn-default"))
        {
            sendRequest("api/setsampletype.jsp",{oper:"add",contractid:$("#contract").val(),sampleid:v,appealid: $("#appeal").val(), actid: $("#act").val()},cbAddSample);
        }
        else
        {
        $("#sampleModal").modal('show');
        $("#h4sampletype").html(": "+$("#sample option:selected").text());
        $("#frmsampletype input[name='sampleid']").val(v);
        $("#frmsampletype input[name='quantity']").val("");
        $("#frmsampletype input[name='contractid']").val($("#contract").val());
        }
        $("#sample-box").show();
    });
    
    $(document).on("change", '#contragent', function (e) {
        $("#contract-field").show();
        if($("#contragent").val() > 0)
            $("#editcontragentbtn").show();
        clearContract();
        loadContract("");
    });


    $("#analysis-field").bind("beforeShow", function (){ 
        resetAnalysis();
    });
    $('#analysis').on("select2:selecting", function(e) { 
   // what you would like to happen
    });



    $(document).on("change", "#analysis", function () {
        var v = $("#analysis").val().trim();
        if (v=="")
            return;
        //var ids = "";
        //$('#sampletable td input:checkbox:checked').each(function () { 
        //    if(ids.length > 0)  ids += ",";
        //    ids += $(this).val();
        //});

        boxids = $.map($(".contactsampleboxitem:checkbox:checked"), function(n, i){return n.value;}).join(',');
        itmids = $.map($(".contactsampleitem:checkbox:checked"), function(n, i){return n.value;}).join(',');
        boxids2= $.map($(".contactsampleboxitem:checkbox:checked"), function(n, i){return n.value;}).join(',');
        itmids2= $.map($(".sampleitemreseach:checkbox:checked"), function(n, i){return n.value;}).join(',');
        if (boxids.length+itmids.length+itmids2.length==0)
        {
            $("#analysis").select2("val", "");
            alertError('<%=trs.t("კვლევ(ებ)ის დასანიშნად მონიშნეთ შესაბამისი ნიმუში")%>',"",'<%=trs.t("დახურვა")%>');
        }
        else
        {
            sendRequest("api/setsampletype.jsp",{oper:"researchtest3",ids:itmids,ids2:itmids2,box:boxids,testparent:v,contractid:$("#contract").val()},cbSetResearch);
        }
    });
    

    
    $(document).on("change", '#contract', function () {
        if ($(this).val() != "" && $(this).val() != null) {
            loadContractDetails();
        } else {
            $("#appeal-field").hide();
            $("#act-field").hide();
            $("#sample-field").hide();
            $(".isleft").hide();
        }
    });
    $(document).on("change", '#appeal, #act', function () {
        if ($(this).val() != "0") {
            $("#analysis-field").show2();
        } else {
            $("#analysis-field").hide();
        }
        editSample();
    });
    $("button").tooltip({
        container: 'body',
        trigger : 'hover'        
    });
    $(document).on("change", ".checkshow", function () {
        if ($(".checkshow").is(':checked')) {
            $(".contr4").show();
        } else {
            $(".contr4").hide();
        }
    });
    $(document).on("click", ".addnew", function (e) {
        e.preventDefault();
        var $fg = $(".limits").find('.limit-item').length-1;
        var sampletype = $("#sampletype"+$fg).val().length;
        var labtest = $("#labtest"+$fg).val().length;
        var maxprice = $("#maxprice"+$fg).val().length;
        var maxnum = $("#maxnum"+$fg).val().length;
        if(sampletype === 0 && labtest === 0 && maxprice === 0)
            alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("არაა არჩეული არც ნიმუში არც კვლევა და არც მაქსიმალური ფასი!")%>','<%=trs.t("დახურვა")%>');
        else if(sampletype > 0 && maxnum === 0)
            alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ რაოდენობა!")%>','<%=trs.t("დახურვა")%>');
        else if(labtest > 0 && maxnum === 0 && maxprice === 0)
            alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ მაქსიმალური ფასი ან რაოდენობა!")%>','<%=trs.t("დახურვა")%>');
        else {
            addLabtest("","","","","","");
            $(this).removeClass("addnew").removeClass("btn-success").addClass("btn-danger").addClass("removenew");
            $(this).find(".fa").removeClass("fa-plus").addClass("fa-times");
            //calcTotalPrice();
        }
    });
    $(document).on("click", ".removenew", function () {
        $(this).parent().parent().remove();
        var $fg = $(".limits").find('.limit-item').length;
        for(i=0; i<$fg.length; i++) {
            $($fg[i]).find("input[type='text'], select, textarea").each(function () {
                    this.name = this.name.substr(0,this.name.length-1)+(i+1);
                    this.id = this.id.substr(0,this.id.length-1)+(i+1);
            });
        };
    });
    $(document).on("click", ".removeold", function () {
        $(this).parent().parent().remove();
    });
    
    $(".datetime").datetimepicker({
        format: 'DD/MM/YYYY HH:mm'
    });
    
    $("#contragentraion").hide();
    
    $(document).on("change", "#frmcontragent select[name='region']", function () {
        if($("select[name='region']").val() > 0){
            $("#contragentraion").hide();
            $("#contragentcity").hide();
            $("#contragentaddress").hide();
            loadRaion($("#frmcontragent select[name='region']").val());
        }
    });
    
    $(document).on("change", "#contragentraion select[name='raion']", function () {
        $("#contragentcity").hide();
        $("#contragentaddress").hide();
        loadCity($("#frmcontragent select[name='raion']").val());
    });
    
    $(document).on("change", "#contragentcity select[name='city']", function () {
        $("#contragentaddress").show();
    });
    
    $(document).on("change", ".contractclosing", function () {
        if ($(this).is(":checked")) {
            $(".controler"+$(this).val()+"_2").show();
            $(".controler"+$(this).val()+"_1").hide();
        } else {
            $(".controler"+$(this).val()+"_2").hide();
            $(".controler"+$(this).val()+"_1").show();
        }
    });
    var currentdate = new Date();
    var datetime = currentdate.getDate() + "/"
            + ("0" + (currentdate.getMonth() + 1)).slice(-2) + "/"
            + currentdate.getFullYear() + " "
            + currentdate.getHours() + ":"
            + currentdate.getMinutes();
    $(".now").val(datetime);
    

  

 $(".hasDatepicker").each(function(){
    $(this).datepicker({
        format: 'dd/mm/yyyy', 
        //startDate: getFmtDate(new Date()),
        autoclose: true, 
        language: 'ka', 
        todayHighlight: true, 
	prevText : '<i class="fa fa-chevron-left"></i>',
	nextText : '<i class="fa fa-chevron-right"></i>'
	})
	.on('changeDate', function(e) {
            if (this.id=="cotract_startdate") {
                $("#cotract_enddate").datepicker('setStartDate',e.date);
                $("#cotract_enddate").datepicker('update');
            } else if (this.id=="cotract_enddate") {
                $("#cotract_startdate").datepicker('setEndDate',e.date);
                $("#cotract_startdate").datepicker('update');
            }
        });
    });




jQuery.fn.extend({

    show2:function( speed, easing, callback ) {
        this.trigger('beforeShow');
        this.show(speed, easing, function(){
            $(this).trigger('afterShow');
            if ($.isFunction(callback)) {
                callback.apply(this);
            }
        });
        if(!speed){
            this.trigger('afterShow');            
        }            
    }


});

$(document).ready(function() {
 $("#labtest").select2({allowClear: true});
 loadScript("js/plugin/jqgrid/grid.locale-en.min.js", pagefunction2);
 select2contract();
 select2sample();
 select2analysis();
 loadRegion();    
});



$(document).on("input", ".testprice", function (e) {
    calcTotalPrice();
    });
    



/*
$(document).on("click", ".showanalisys", function () {
    $("#frmcancelban input[name=id]").val($(this).attr("data-itemid"));
    $("#cancelbanModal").modal("show");
});
*/
$(document).on("click", ".deltanalisys", function () {
    ConfirmDelete('api/setanalysis.jsp',{oper:"del",id:$(this).attr("data-itemid")},cbDelAnalysis);
});

$(document).on("click", ".stopanalisys", function () {
    var s = $(this).parent().parent().hasClass("stoped") ? 2 : 1;
    sendRequest("api/setanalysis.jsp",{oper:"status",id:$(this).attr("data-itemid"),status:s},cbStopAnalysis);
});

$(document).on("click", ".contactsampletype", function () {
    var id = $(this).attr("data-itemid");
    $(".contactsampleitem[data-itemid=" + id +"]").prop('checked', this.checked);
});
$(document).on("click", ".contactsampleitem", function () {
    var id = $(this).attr("data-itemid");
    var ch = $(".contactsampleitem:checkbox:not(:checked)[data-itemid=" + id +"]");
    $(".contactsampletype[data-itemid=" + id +"]").prop('checked', ch.length===0);
});
$(document).on("click", ".contactsamplebox", function () {
    var id = $(this).attr("data-itemid");
    $(".contactsampleboxitem[data-itemid=" + id +"]").prop('checked', this.checked);
});
$(document).on("click", ".contactsampleboxitem", function () {
    var id = $(this).attr("data-itemid");
    var ch = $(".contactsampleboxitem:checkbox:not(:checked)[data-itemid=" + id +"]");
    $(".contactsamplebox[data-itemid=" + id +"]").prop('checked', ch.length===0);
});





