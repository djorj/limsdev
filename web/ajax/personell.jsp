<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
String gridname = "personell";
String ses = "EXPORT_BAR_"+(new Date()).getTime();
jqexport exp = new jqexport(ses, null, null, "EXPORT_STOP", "content/export_personell.jsp", "");
%>
<%=exp.getExportAttr()%>
<style>
div.centered {
    position: fixed;
    top: 50%;
    left: 50%;
    margin-top: -50px;
    margin-left: -100px;

}
.ui-jqgrid tr.jqgrow td {
    font-weight: 400 !important;
    overflow: hidden !important;
    white-space: pre !important;
}

</style>
<script type="text/javascript">
    
    function checkad(){
        $("password").prop('disabled', false);
        var loginid = $("#loginid").val();
        if($.trim(loginid).length > 0){
            $.post("content/checkad.jsp",{ oper: "getdata", loginid: loginid },function(data){
                if(data.result == 0)    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                else {
                    $("#fname").val(data.fname);
                    $("#lname").val(data.lname);
                    //$("#phone").val("");
                    //$("#personelltypeid").val();
                    $("#address").val(data.address);
                    $("#institutionid").val(data.institutionid);
                    $("#password").val(data.password);
                    $("password").prop('disabled', true);
                }
            },"json");
        }
    }
    
    function uploadSignature(id){
        if(id > 0){
            var url = "content/signature.jsp?id="+id;
            BootstrapDialog.show({
                title: 'თანამშრომლის ხელმოწერა',
                size: BootstrapDialog.SIZE_NORMAL,
                message: function(dialog) {
                    var $message = $('<div></div>');
                    var pageToLoad = dialog.getData('pageToLoad');
                    $message.load(pageToLoad);

                    return $message;
                },
                data: {
                    'pageToLoad': url
                },
                buttons: [{
                    id: 'btn-save',   
                    icon: 'fa fa-save',       
                    label: ' შენახვა',
                    cssClass: 'btn-primary', 
                    autospin: false,
                    action: function(dialogRef){    
                        $.post(
                            "content/saveSignature.jsp", 
                            {
                               act: "add",
                               id: id
                            },
                            function(data){
                                if(data.result == 0)
                                    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                                else
                                    dialogRef.close();
                            },"json"
                        );
                    }
                },{
                    id: 'btn-delete',   
                    icon: 'fa fa-times',       
                    label: ' წაშლა',
                    cssClass: 'btn-danger', 
                    autospin: false,
                    action: function(dialogRef){
                        $.post(
                            "content/saveSignature.jsp", 
                            {
                               act: "del",
                               id: id
                            },
                            function(data){
                                if(data.result == 0)
                                    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                                else
                                    dialogRef.close();
                            },"json"
                        );
                    }
                },{
                    id: 'btn-cancel',   
                    icon: 'fa fa-circle-thin',       
                    label: ' დახურვა',
                    cssClass: 'btn-default', 
                    autospin: false,
                    action: function(dialogRef){    
                        dialogRef.close();
                    }
                }]
            });
        } else alert("აირჩიეთ ჩანაწერი");
    }
    
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
            
            jQuery().ready(function (){
        
        
        jQuery("#list<%=gridname%>").jqGrid(
            {
                url:'content/get<%=gridname%>list.jsp',
                datatype: "json",
                colNames:['სახელი','გვარი','ტელეფონი','თანამდებობა','რეგ. სახელი','პაროლი','ელფოსტა','ორგანიზაცია','რეგისტრაციის თარიღი','შეზღუდვა','გაუქმება'],
                colModel:[
                    {name:'fname',index:'fname', editable:true, align:"left", width:100, edittype:"text", editoptions:{size:"15"}, searchoptions:{sopt:['bw','bn','in','ni','ew','en','cn','nc']}, editrules: {edithidden:true, required:true}},
                    {name:'lname',index:'lname', editable:true, align:"left", width:150, edittype:"text", editoptions:{size:"30"}, searchoptions:{sopt:['bw','bn','in','ni','ew','en','cn','nc']}, editrules: {edithidden:true, required:true}},
                    {name:'phone',index:'phone', editable:true, align:"left", width:100, edittype:"text", editoptions:{size:"15"}, search: false},
                    {name:'personelltypeid',index:'personelltypeid', editable:true, align:"left", width:120, stype:"select", edittype:"select", editoptions:{dataUrl:'content/gettypes.jsp?edit=1&objname=Personelltype&cols=Personelltypeid&cols=Name&where=where companyid = <%=user.getCompanyid()%> order by name'},searchoptions:{dataUrl:'content/gettypes.jsp?objname=Personelltype&cols=Personelltypeid&cols=Name&where=where companyid = <%=user.getCompanyid()%>order by name',sopt:['eq','ne']}},
                    {name:'loginid',index:'loginid', editable:true, align:"left", width:120, edittype:"text", editoptions:{size:"25"}, search: false, editrules: {edithidden:true, required:true}, formoptions: {elmsuffix: '&nbsp;&nbsp;<b:button context="default" icon="check" label="" onclick="checkad();"/>'}},
                    {name:'password',index:'password', editable:true, align:"left", width:100, hidden:true, edittype:"password", editoptions:{size:"15", maxlength: "250"}, searchoptions:{sopt:['bw','bn','in','ni','ew','en','cn','nc']}, editrules: {edithidden:true, required:true}},
                    {name:'email',index:'email', editable:true, align:"left", width:120, edittype:"text", editoptions:{size:"30"}, search:false},
                    {name:'institutionid',index:'institutionid', editable:true, align:"left", width:200, stype:"select", edittype:"select", editoptions:{dataUrl:'content/getlablistselect.jsp',style:'width: 200px;'},searchoptions:{dataUrl:'content/getlablistselect.jsp?edit=1',sopt:['eq','ne']}},
                    {name:'regdate',index:'regdate', editable:false, align:"left", width:200, search:false},
                    {name:'limited',index:'limited', editable:true, align:"center", width:80, edittype:"checkbox",editoptions:{value:"დიახ:არა"}, search:false,formoptions:{elmsuffix:' (მხოლოდ საკუთარი კვლევების ნახვა)'}},
                    {name:'deleted',index:'deleted', editable:true, align:"center", width:80, edittype:"checkbox",editoptions:{value:"დიახ:არა"}, search:false}
                ],
                rowNum:20,
                height: 350,
                //width:900,
                autowidth: true,
                rowList:[20,50,100],
                pager: jQuery('#pager<%=gridname%>'),
                sortname: 'lname',
                viewrecords: true,
                sortorder: "asc",
                //shrinkToFit: true,
                //forceFit: false,
                mtype: "POST",
                altRows: true,
                autoencode: true,
                toolbarfilter: true,
                editurl:"content/upd<%=gridname%>.jsp",
                loadComplete: function(data){
		    var rows = $("#list<%=gridname%>").getDataIDs(); 
                    for (var i = 0; i < rows.length; i++)
                    {
                        var del = $("#list<%=gridname%>").getCell(rows[i],"deleted");
                        if(del == "დიახ")
                            $("#list<%=gridname%>l").jqGrid('setRowData',rows[i],false, {'text-decoration': 'line-through'});
                    }
      		   },
                ondblClickRow: function(id, ri, ci) {
                    jQuery("#list<%=gridname%>").jqGrid('editGridRow',id,{dataheight:400,width:500,closeAfterEdit:true,reloadAfterSubmit:false,afterSubmit:checkStatus});
                    return;
                }
            })
            .jqGrid('filterToolbar', { searchOnEnter: true, enableClear: true })
            .navGrid('#pager<%=gridname%>',{edit:<%=permissions[1]%>,add:<%=permissions[0]%>,del:<%=permissions[2]%>,view:false,search:false},
                        {dataheight:400,width:500,closeAfterEdit:true,reloadAfterSubmit:true,afterSubmit:checkStatus}, //  default settings for edit
                        {dataheight:400,width:500,closeAfterAdd:true,reloadAfterSubmit:true,afterSubmit:checkStatus}, //  default settings for add
                        {closeAfterDelete:true,reloadAfterSubmit:true,afterSubmit:checkStatus},  // delete instead that del:false we need this
                        {multipleSearch:true}, // search options
                        {dataheight:320,width:400,labelswidth:"68%",closeOnEscape:true} /* view parameters*/
                )
            <%if(permissions[1]){%>
            .navButtonAdd('#pager<%=gridname%>',{caption:'<i class="fa fa-graduation-cap"></i> ხელმოწერა', buttonicon:'none',onClickButton: function(){ uploadSignature(jQuery('#list<%=gridname%>').jqGrid('getGridParam','selrow')); },position:'last'})
            <%}if(permissions[4]){%>
            .navButtonAdd('#pager<%=gridname%>',{caption:'<i class="fa fa-file-excel-o"></i> ექსპორტი', buttonicon:'none',onClickButton: function(){ <%=exp.getClickCode()%> },position:'last'})
            <%}%>
             ;
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
                jQuery("#list<%=gridname%>").jqGrid('setGridWidth', $("#content").width());
                $("#gview_list<%=gridname%>").height(window.innerHeight-230);
            })
        }
    }

    loadScript("js/plugin/jqgrid/grid.locale-<%=trs.getFlag()%>.min.js", pagefunction);
    
    
</script>

<div class="table-size1">
    <table id="list<%=gridname%>"></table>
    <div id="pager<%=gridname%>"></div>
</div>
