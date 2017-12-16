<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%

String ses = "EXPORT_BAR_"+(new Date()).getTime();
jqexport exp = new jqexport(ses, null, null, "EXPORT_STOP", "content/export_device.jsp", "");
%>
<%=exp.getExportAttr()%>
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

    
    function confirmcopy(id,dialogRef){
        BootstrapDialog.show({
            title: 'ნორმატივების კოპირება',
            message: "დარწმუნებული ხართ რომ გინდათ ნორმატივების კოპირება?",
            type: BootstrapDialog.TYPE_DANGER,
            size: BootstrapDialog.SIZE_NORMAL,
            buttons: [{
                    label: 'არა',
                    action: function(dialog) {
                        dialog.close();
                    }
                }, {
                    label: 'დიახ',
                    action: function(dialog) {
                        var devs = $(".chkdev:checked").map(function () {return this.value;}).get().join(",");
                        $.post(
                            "content/savecopydevice.jsp", 
                            {
                               oper: "add",
                               id: id,
                               devs: devs
                            },
                            function(data){
                                dialog.close();
                                if(data.result == 0)
                                    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                                else{
                                    dialogRef.close();
                                    alert("ნორმატივები წარმატებით შეინახა");
                                }
                            },"json"
                        );
                    }
                }]
        });
        
    }
    
    function confirmrem(id){
        BootstrapDialog.show({
            title: 'ნორმატივების წაშლა',
            message: "დარწმუნებული ხართ რომ გინდათ ნორმატივების წაშლა?",
            type: BootstrapDialog.TYPE_DANGER,
            size: BootstrapDialog.SIZE_NORMAL,
            buttons: [{
                    label: 'არა',
                    action: function(dialog) {
                        dialog.close();
                    }
                }, {
                    label: 'დიახ',
                    action: function(dialog) {
                        $.post(
                            "content/savecopydevice.jsp", 
                            {
                               oper: "del",
                               id: id
                            },
                            function(data){
                                dialog.close();
                                if(data.result == 0)
                                    alertError('<%=trs.t("შეცდომა")%>',data.error,'<%=trs.t("დახურვა")%>');
                                else
                                    alert("ნორმატივები წარმატებით წაიშალა");
                            },"json"
                        );
                    }
                }]
        });
        
    }
    
    function copyDevice(id){
        if(id > 0){
            var url = "content/copydevice.jsp?id="+id;
            BootstrapDialog.show({
                title: 'ნორმატივების კოპირება',
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
                        confirmcopy(id,dialogRef);
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
        } else alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ ჩანაწერი")%>','<%=trs.t("დახურვა")%>');
    }
    
    function addTest() {
        var id = jQuery('#device').jqGrid('getGridParam','selrow');
        if(id > 0){
            var url = "content/devicelabtest.jsp?id="+id;
            BootstrapDialog.show({
                title: '<%=trs.t("კვლევები/ტესტები")%>',
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
                    cssClass: 'btn-success', 
                    autospin: false,
                    action: function(dialogRef){
                        confirmcopy(id,dialogRef);
                    }
                },{
                    id: 'btn-cancel',   
                    icon: 'fa fa-close',       
                    label: ' დახურვა',
                    cssClass: 'btn-danger', 
                    autospin: false,
                    action: function(dialogRef){    
                        dialogRef.close();
                    }
                }]
            });
        } else alertError('<%=trs.t("შეცდომა")%>','<%=trs.t("აირჩიეთ ჩანაწერი")%>','<%=trs.t("დახურვა")%>');
    }
    
    var pagefunction = function () {
        loadScript("js/plugin/jqgrid/jquery.jqGrid.min.js", run_jqgrid_function);

        function run_jqgrid_function() {
            
        jQuery("#device").jqGrid(
            {
                url:'content/getdevicelist.jsp',
                datatype: "json",
                colNames:['დასახელება','ორგანიზაცია','მოდელი','სერიული ნომერი','გამოშვების თარიღი','მდგომარეობა','დაფა'],
                colModel:[
                    {name:'name',index:'name', editable:true, align:"left", width:200, edittype:"text", editoptions:{size:"30"}, editrules: {edithidden:true, required:true}},
                    {name:'institutionid',index:'institutionid', editable:true, align:"left", width:200, stype:"select", edittype:"select", editoptions:{dataUrl:'content/getlablistselect.jsp?childonly=1',style:'width: 200px;'},searchoptions:{dataUrl:'content/gettypes.jsp?objname=Institution&cols=Institutionid&cols=Name&where=order by name',sopt:['eq','ne']}},
                    {name:'model',index:'model', editable:true, align:"left", width:200, edittype:"text", editoptions:{size:"20"}},
                    {name:'sn',index:'sn', editable:true, align:"left", width:100, edittype:"text", editoptions:{size:"15"}},
                    {name:'createdate',index:'createdate', editable:true, align:"left", width:100, edittype:"text", editoptions:{size:"10",maxlength:"10",dataInit: function(element) {$(element).datepicker(<%=pickerformat%>)}}},
                    {name:'condition',index:'condition', editable:true, align:"left", width:200, edittype:"text", editoptions:{size:"30"}},
                    {name:'hasplate',index:'hasplate', editable:true, align:"center", width:80, edittype:"checkbox", editoptions:{value:"<%=trs.t("დიახ")%>:<%=trs.t("არა")%>"}}
                ],
                rowNum:20,
                height: 400,
                width:1000,
                autowidth: true,
                rowList:[20,50,100],
                pager: jQuery('#pdevice'),
                sortname: 'name',
                viewrecords: true,
                sortorder: "asc",
                editurl:"content/upddevice.jsp",
                title: "<%=trs.t("ლაბორატორიები")%>",
                ondblClickRow: function(id, ri, ci) {
                    jQuery("#device").jqGrid('editGridRow',id,{dataheight:300,width:400,closeAfterEdit:true,reloadAfterSubmit:false,afterSubmit:checkStatus});
                    return;
                }
            })
            .navGrid('#pdevice',{edit:<%=permissions[1]%>,add:<%=permissions[0]%>,del:<%=permissions[2]%>,view:false,search:false},
                        {dataheight:300,width:400,closeAfterEdit:true,reloadAfterSubmit:true,afterSubmit:checkStatus}, //  default settings for edit
                        {dataheight:300,width:400,closeAfterAdd:true,reloadAfterSubmit:true,afterSubmit:checkStatus}, //  default settings for add
                        {closeAfterDelete:true,reloadAfterSubmit:true,afterSubmit:checkStatus},  // delete instead that del:false we need this
                        {multipleSearch:true}, // search options
                        {dataheight:300,width:400,labelswidth:"68%",closeOnEscape:true} /* view parameters*/
                )
            //.navButtonAdd('#pdevice', {title:'', id: 'addtest', caption: '<i class="fa fa-flask"></i> < %=trs.t("კვლევები/ტესტები")%>', buttonicon: 'none', onClickButton: addTest})
             ;
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
                jQuery("#device").jqGrid('setGridWidth', $("#content").width());
            })


        } // end function


    }

    loadScript("js/plugin/jqgrid/grid.locale-en.min.js", pagefunction);
    
    
</script>
<%--div class="col-md-12 btn-panel">
    <%if(permissions[3]){%>
    <button class="btn btn-info pull-right" onclick="exportDevices();"><i class="fa fa-file-excel-o"></i> <%=trs.t("ექსპორტი")%></button>
    <%}%>
    <%if(permissions[1]){%>
    <button class="btn btn-success pull-right" onclick="copyDevice(jQuery('#device').jqGrid('getGridParam','selrow'));"><i class="fa fa-copy"></i> <%=trs.t("ნორმატივების კოპირება")%></button>
    <button class="btn btn-danger pull-right" onclick="confirmrem(jQuery('#device').jqGrid('getGridParam','selrow'));"><i class="fa fa-remove"></i> <%=trs.t("ნორმატივების წაშლა")%></button>
    <%}%>
</div--%>
<div class="table-size2 active">
    <table id="device"></table>
    <div id="pdevice"></div>
</div>
