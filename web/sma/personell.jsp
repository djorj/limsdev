<%@page contentType="text/html; charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
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
</style>
<script type="text/javascript">
    
    function checkad(){
        $("password").prop('disabled', false);
        var loginid = $("#loginid").val();
        if($.trim(loginid).length > 0){
            $.post("content/checkad.jsp",{ oper: "getdata", loginid: loginid },function(data){
                if(data.result == 0)    alert(data.error);
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
                                    alert(data.error);
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
                                    alert(data.error);
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
    
    jQuery().ready(function ()
    {
        
        
        jQuery("#list1").jqGrid(
            {
                url:'content/getpersonelllist.jsp',
                datatype: "xml",
                colNames:['სახელი','გვარი','ტელეფონი','თანამდებობა','რეგ. სახელი','პაროლი','ელფოსტა','ორგანიზაცია','რეგისტრაციის თარიღი','შეზღუდვა','გაუქმება'],
                colModel:[
                    {name:'fname',index:'fname', editable:true, align:"left", width:100, edittype:"text", editoptions:{size:"15"}, searchoptions:{sopt:['bw','bn','in','ni','ew','en','cn','nc']}, editrules: {edithidden:true, required:true}},
                    {name:'lname',index:'lname', editable:true, align:"left", width:150, edittype:"text", editoptions:{size:"30"}, searchoptions:{sopt:['bw','bn','in','ni','ew','en','cn','nc']}, editrules: {edithidden:true, required:true}},
                    {name:'phone',index:'phone', editable:true, align:"left", width:100, edittype:"text", editoptions:{size:"15"}, search: false},
                    {name:'personelltypeid',index:'personelltypeid', editable:true, align:"left", width:120, stype:"select", edittype:"select", editoptions:{dataUrl:'content/gettypes.jsp?edit=1&objname=Personelltype&cols=Personelltypeid&cols=Name&where=order by name'},searchoptions:{dataUrl:'content/gettypes.jsp?objname=Personelltype&cols=Personelltypeid&cols=Name&where=order by name',sopt:['eq','ne']}},
                    {name:'loginid',index:'loginid', editable:true, align:"left", width:120, edittype:"text", editoptions:{size:"25"}, search: false, editrules: {edithidden:true, required:true}, formoptions: {elmsuffix: '&nbsp;&nbsp;<b:button context="default" icon="check" label="" onclick="checkad();"/>'}},
                    {name:'password',index:'password', editable:true, align:"left", width:100, hidden:true, edittype:"password", editoptions:{size:"15", maxlength: "15"}, searchoptions:{sopt:['bw','bn','in','ni','ew','en','cn','nc']}, editrules: {edithidden:true, required:true}},
                    {name:'email',index:'email', editable:true, align:"left", width:120, edittype:"text", editoptions:{size:"30"}, search:false},
                    {name:'institutionid',index:'institutionid', editable:true, align:"left", width:200, stype:"select", edittype:"select", editoptions:{dataUrl:'content/gettypes.jsp?objname=Institution&cols=Institutionid&cols=Name&where=order by name',style:'width: 200px;'},searchoptions:{dataUrl:'content/gettypes.jsp?objname=Institution&cols=Institutionid&cols=Name&where=order by name',sopt:['eq','ne']}},
                    {name:'regdate',index:'regdate', editable:false, align:"left", width:200, search:false},
                    {name:'limited',index:'limited', editable:true, align:"center", width:80, edittype:"checkbox",editoptions:{value:"დიახ:არა"}, search:false,formoptions:{elmsuffix:' (მხოლოდ საკუთარი ორგანიზაციის პაციენტების ნახვა)'}},
                    {name:'deleted',index:'deleted', editable:true, align:"center", width:80, edittype:"checkbox",editoptions:{value:"დიახ:არა"}, search:false}
                ],
                rowNum:20,
                height: 350,
                width:900,
                autowidth: true,
                rowList:[20,50,100],
                pager: jQuery('#pager1'),
                sortname: 'lname',
                viewrecords: true,
                sortorder: "asc",
                editurl:"content/updpersonell.jsp",
                loadComplete: function(data){
		    var rows = $("#list1").getDataIDs(); 
                    for (var i = 0; i < rows.length; i++)
                    {
                        var del = $("#list1").getCell(rows[i],"deleted");
                        if(del == "დიახ")
                            $("#list1").jqGrid('setRowData',rows[i],false, {'text-decoration': 'line-through'});
                    }
      		   },
                ondblClickRow: function(id, ri, ci) {
                    jQuery("#list1").jqGrid('editGridRow',id,{dataheight:400,width:500,closeAfterEdit:true,reloadAfterSubmit:false,afterSubmit:checkStatus,beforeShowForm: function(form) { centerDialog(form); }});
                    return;
                }
            })
            .jqGrid('filterToolbar', { searchOnEnter: true, enableClear: true })
            .navGrid('#pager1',{edit:<%=canwrite%>,add:<%=canwrite%>,del:<%=canwrite%>,view:false,search:false},
                        {dataheight:400,width:500,closeAfterEdit:true,reloadAfterSubmit:true,afterSubmit:checkStatus,beforeShowForm: function(form) { centerDialog(form); }}, //  default settings for edit
                        {dataheight:400,width:500,closeAfterAdd:true,reloadAfterSubmit:true,afterSubmit:checkStatus,beforeShowForm: function(form) { centerDialog(form); }}, //  default settings for add
                        {closeAfterDelete:true,reloadAfterSubmit:true,afterSubmit:checkStatus},  // delete instead that del:false we need this
                        {multipleSearch:true}, // search options
                        {dataheight:320,width:400,labelswidth:"68%",closeOnEscape:true} /* view parameters*/
                )
            <%if(canwrite){%>
            .navButtonAdd('#pager1',{caption:'<i class="fa fa-graduation-cap"></i> ხელმოწერა', buttonicon:'ui-icon-note',onClickButton: function(){ uploadSignature(jQuery('#list1').jqGrid('getGridParam','selrow')); },position:'last'})
            <%}if(canexport){%>
            .navButtonAdd('#pager1',{caption:'<i class="fa fa-file-excel-o"></i> ექსპორტი', buttonicon:'ui-icon-calculator',onClickButton: function(){ <%=exp.getClickCode()%> },position:'last'})
            <%}%>
             ;
    });
    
    
</script>

<div class="row">
    <div class="col-lg-12 col-md-12">
        <div class="widget">
            <div class="widget-header">
                <div class="title">პერსონალი</div>
                <span class="tools">
                    
                </span>
            </div>
            <div class="widget-body">
                <table id="list1" width="100%" align="center"></table>
                <div id="pager1"></div>
            </div>
        </div>
    </div>
</div>
