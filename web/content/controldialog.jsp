<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
    LabtestBean[] controls = LabtestManager.getInstance().loadByWhere("where companyid = "+user.getCompanyid()+" and labtestid != "+labtest.getLabtestid()+" and ctr = true order by name");
    session.removeAttribute("CONTROLDOCS_"+labtest.getLabtestid());
    //String[] weekdays = {trs.t("ორშაბათს"), trs.t("სამშაბათს"), trs.t("ოთხშაბათს"),trs.t("ხუთშაბათს"),trs.t("პარასკევს")};
    String procedures = labtest.getControlprocedure();
    if(procedures == null)  procedures = "";
    LabtestcontroldocumentBean[] documents = LabtestcontroldocumentManager.getInstance().loadByWhere("where labtestid = "+labtest.getLabtestid()+" order by documentid");
    JSONArray docs = new JSONArray();
    for(int i=0;i<documents.length;i++){
        DocumentBean document = DocumentManager.getInstance().loadByPrimaryKey(documents[i].getDocumentid());
        JSONObject doc = new JSONObject();
        doc.put("labtestid", labtest.getLabtestid());
        doc.put("name", document.getName());
        doc.put("filename", document.getFilename());
        doc.put("path", document.getPath());
        doc.put("url", document.getUrl());
        doc.put("type", document.getType());
        doc.put("size", document.getSize());
        doc.put("id", documents[i].getDocumentid());
        docs.add(doc);
    }
    session.setAttribute("CONTROLDOCS_"+labtest.getLabtestid(), (JSONArray)docs);
    LabtestcontrolBean[] lc = LabtestcontrolManager.getInstance().loadByLabtestid(labtest.getLabtestid());
%>

<script>
    
    
    var docnum = 0;
    
    function selControl(id){
        $(".listcontrol").removeClass("bg-color-red txt-color-white");
        $("#control"+id).addClass("bg-color-red txt-color-white");
        $.post("content/controlschedule.jsp",{ id: <%=labtest.getLabtestid()%>, cid: id}, function(data){ $("#controlschedule").html(data); });
        $(".contrscd").hide();
        $("#controlschedule"+id).show();
    }
    
    function deldoc(n){
        $.post("content/addcontroldocument.jsp",{ 
            oper: "del",
            id: <%=labtest.getLabtestid()%>, 
            n: n
        },function(data){
            if(data.result == 0) {
                $("#controldialogerror").html(data.error);
                $("#controldialogerrorol").show();
            } else {
                $("#controldialogerrorol").hide();
               $("#documentlist").html(data.dlist);
            }
        },"json");
        
    }
    $(".contrscd").hide();
    
    $.post("content/addcontroldocument.jsp",{ 
        oper: "list",
        id: <%=labtest.getLabtestid()%>
    },function(data){
        if(data.result == 0) {
            $("#controldialogerror").html(data.error);
            $("#controldialogerrorol").show();
        } else {
            $("#controldialogerrorol").hide();
            $("#documentlist").html(data.dlist);
            $("#docname").val("");
        }
    },"json");
    
    
    $("#upload-contract").change(function () {
        
        if (this.files && this.files[0]) {
            
            var reader = new FileReader();

            reader.onload = function (e) {
                var doc = new Object();
                doc.filename = $("#upload-contract")[0].files[0].name;
                doc.size = $("#upload-contract")[0].files[0].size;
                doc.type = $("#upload-contract")[0].files[0].type;
                $.post("content/addcontroldocument.jsp",{ 
                    oper: "add",
                    id: <%=labtest.getLabtestid()%>, 
                    doc: e.target.result, 
                    name: $("#docname").val(),
                    filename: doc.filename,
                    size: doc.size,
                    type: doc.type
                },function(data){
                    if(data.result == 0) {
                        $("#controldialogerror").html(data.error);
                        $("#controldialogerrorol").show();
                    } else {
                        $("#controldialogerrorol").hide();
                        $("#documentlist").html(data.dlist);
                        $("#docname").val("");
                    }
                },"json");
                //console.log(e.target);
            }

            reader.readAsDataURL(this.files[0]);
        }
    });
    
    <%for(int i=0;i<lc.length;i++){%>
        selControl(<%=lc[i].getControlid()%>);
    <%}%>
    
</script>
<div class="smart-form">
    <div class="col col-md-12">
        <ol style="float: right; margin-right: 5px; display: none;" id='controldialogerrorol'>
            <div class="alert alert-danger fade in">
                <button class="close" data-dismiss="alert">
                    ×
                </button>
                <i class="fa-fw fa fa-times"></i>
                <strong><%=trs.t("Error!")%></strong> <span id='controldialogerror'></span>
            </div>
        </ol>
    </div>
    <div class="col col-md-6">
        <fieldset style="padding-top: 0px !important; margin-bottom: 0px;">
        <section class="col col-sm-12">
            <label class="label font-md"><%=trs.t("ხარისხის კონტროლის ტესტები:")%></label>
            
                <ol class="dd-list bordered-box" style="padding-left: 5px;  padding-right: 5px; display: block; overflow-y: auto; height: 120px;">
                <%
                for(int i=0;i<controls.length;i++){
                %>
                <li class="dd-item" data-id="<%=controls[i].getLabtestid()%>" style="cursor: pointer;" onclick="selControl(<%=controls[i].getLabtestid()%>)">
                <div class="dd-handle listcontrol" id="control<%=controls[i].getLabtestid()%>">
                <%=trs.t(controls[i].getName())%>
                <em id="controlchk<%=controls[i].getLabtestid()%>" class="" rel="tooltip" title="" data-placement="left" data-original-title=""></em>
                </div>
                </li>
                <%
                }
                %>
                </ol>
            
        </section>
        <section class="col col-sm-12">
            <label class="textarea">
                <textarea placeholder="<%=trs.t("პროცედურების აღწერა")%>" id="procdescr"><%=procedures%></textarea>
            </label>
        </section>
        <section class="col col-sm-12">
            <div class="row">
                <div class="col col-sm-8">
                    <label class="input"> <i class="icon-append fa fa-address-book"></i>
                        <input name="docname" id="docname" type="text" value="" placeholder="<%=trs.t("დოკუმენტის დასახელება")%>">
                    </label>
                </div>
                <div class="col col-sm-4">
                    <label class="btn btn-primary">
                        <span id="filename"><%=trs.t("ატვირთვა")%></span>
                        <input id="upload-contract" type="file">
                    </label>
                </div>
            </div>
        </section>
        <section class="col col-sm-12">
            <label class="label font-md"><%=trs.t("დოკუმენტები:")%></label>
            <ol class="dd-list bordered-box" id="documentlist" style="padding-left: 5px;  padding-right: 5px; display: block; overflow-y: auto; height: 100px;">
            
            </ol>
        </section>
        </fieldset>
    </div>
    <%
    for(int i=0;i<controls.length;i++){
    %>
    <div class="col col-md-6 contrscd" id="controlschedule<%=controls[i].getLabtestid()%>" style="display: block; overflow-y: auto; height: 500px;">
        <jsp:include page="controlschedule.jsp">
            <jsp:param name="id" value="<%=labtest.getLabtestid()%>"></jsp:param>
            <jsp:param name="cid" value="<%=controls[i].getLabtestid()%>"></jsp:param>
        </jsp:include>
    </div>
    <%
    }
    %>
    
</div>