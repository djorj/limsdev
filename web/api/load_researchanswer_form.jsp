<%-- 
    Document   : service
    Created on : Nov 22, 2014, 3:24:54 PM
    Author     : Gocha Tortladze
--%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<style>
#reqanswer tr.ui-row-ltr td {
    padding-right: 0px !important;
}
#reqanswer tr.jqgrow td {
    vertical-align: top !important;
}
</style>
<%
try
{
    long id = Long.parseLong(request.getParameter("id"));
    SampleitemreseachBean sm = SampleitemreseachManager.getInstance().loadByPrimaryKey(id);
    DeviceBean[] devs = DeviceManager.getInstance().loadByWhere("where deviceid in (select deviceid from devicelabtest where labtestid = "+sm.getLabtestid()+") and institutionid = "+sm.getInstitutionid());
    
    VLabRequestBean[] sam = VLabRequestManager.getInstance().loadByWhere("WHERE sampleitemreseachid="+id);
    LabtestBean tst  = LabtestManager.getInstance().loadByPrimaryKey(sam[0].getLabtestid());
    StandardBean[] stds = StandardManager.getInstance().loadByWhere("where standardid in (select standardid from labteststandard where labtestid = "+sam[0].getLabtestid()+")");
    //UnitsBean unit = UnitsManager.getInstance().loadByPrimaryKey(tst.getUnitsid());
    int clevel = 1;
    if(user.getPersonelltypeid().intValue() == 12)  clevel = 2;
    else if(user.getPersonelltypeid().intValue() == 11)  clevel = 3;
    if(sm.getResult() == null || sm.getResult().trim().length() == 0)
        clevel = 0;
    String result = (sm.getResult() != null) ? sm.getResult():"";
    String resultdata = "";
    if(sm.getDeviceid() != null){
        DeviceresultBean[] dvr = DeviceresultManager.getInstance().loadByWhere("where sampleitemreseachid = "+id+" and deviceid = "+sm.getDeviceid());
        LabtestcontrolBean[] lc = LabtestcontrolManager.getInstance().loadByLabtestid(sam[0].getLabtestid());
        if(dvr.length > 0 && lc.length > 0){
            
            resultdata = "<table border=\"1\" width=\"100%\"><tr><td colspan='4'><b>"+trs.t("აპარატის მონაცემები")+"</b></td></tr><tr><td align='center'>"+trs.t("პოზიცია")+"</td><td align='center'>"+trs.t("რაოდენობრივი")+"</td><td align='center'>"+trs.t("ხარისხობრივი")+"</td><td align='center'>"+trs.t("აბსორბცია")+"</td></tr>";
            for(int i=0;i<lc.length;i++){
                JSONObject ob = JSONObject.fromObject(dvr[i].getResult());
                resultdata += "<tr><td align='center'>"+ob.getString("wellno")+"</td><td align='center'>"+ob.getString("quantitative")+"</td><td align='center'>"+ob.getString("qualitative")+"</td><td align='center'>"+ob.getString("absorbency")+"</td></tr>";
            }
            resultdata += "</table><hr>";
            JSONObject ob = JSONObject.fromObject(dvr[0].getResult());
            if(ob.containsKey("alldata")){
                JSONArray alldata = ob.getJSONArray("alldata");
                resultdata += "<table border=\"1\" width=\"100%\"><tr><td colspan='4'><b>"+trs.t("ხარისხის კონტროლის მონაცემები")+"</b></td></tr><tr><td align='center'>"+trs.t("პოზიცია")+"</td><td align='center'>"+trs.t("რაოდენობრივი")+"</td><td align='center'>"+trs.t("ხარისხობრივი")+"</td><td align='center'>"+trs.t("აბსორბცია")+"</td></tr>";
                JSONObject o = JSONObject.fromObject(lc[0].getSchedule());
                if(o.containsKey("positive"))   {
                    String[] positives = o.getString("positive").split(",");
                    String s = "";
                    for(int i=0;i<positives.length;i++){
                        for(int j=0;j<alldata.size();j++){
                            JSONObject adt = alldata.getJSONObject(j);
                            if(adt.getString("wellno").equalsIgnoreCase(positives[i])){
                                s += "<tr><td align='center'>"+adt.getString("wellno")+"</td><td align='center'>"+adt.getString("quantitative")+"</td><td align='center'>"+adt.getString("qualitative")+"</td><td align='center'>"+adt.getString("absorbency")+"</td></tr>";
                            }
                        }
                    }
                    resultdata += s;
                }
                if(o.containsKey("negative"))   {
                    String[] negatives = o.getString("negative").split(",");
                    String s = "";
                    for(int i=0;i<negatives.length;i++){
                        for(int j=0;j<alldata.size();j++){
                            JSONObject adt = alldata.getJSONObject(j);
                            if(adt.getString("wellno").equalsIgnoreCase(negatives[i])){
                                s += "<tr><td align='center'>"+adt.getString("wellno")+"</td><td align='center'>"+adt.getString("quantitative")+"</td><td align='center'>"+adt.getString("qualitative")+"</td><td align='center'>"+adt.getString("absorbency")+"</td></tr>";
                            }
                        }
                    }
                    resultdata += s;
                }
                if(o.containsKey("extra"))   {
                    String[] extras = o.getString("extra").split(",");
                    String s = "";
                    for(int i=0;i<extras.length;i++){
                        for(int j=0;j<alldata.size();j++){
                            JSONObject adt = alldata.getJSONObject(j);
                            if(adt.getString("wellno").equalsIgnoreCase(extras[i])){
                                s += "<tr><td align='center'>"+adt.getString("wellno")+"</td><td align='center'>"+adt.getString("quantitative")+"</td><td align='center'>"+adt.getString("qualitative")+"</td><td align='center'>"+adt.getString("absorbency")+"</td></tr>";
                            }
                        }
                    }
                    resultdata += s;
                }
                resultdata += "</table>";
            }
        }
    }
%>

<form id="frmresearchanswer" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" value="researchanswer" type="hidden">
<input name="id" type="hidden" value="<%=request.getParameter("id")%>">
    <div class="tab-pane fade in active" id="i1">
        <div class="pull-left">
        <table id="reqanswer"></table>
        <div id="pagerreqanswer"></div>
        <div><hr></div>
        <%if(resultdata.length() > 0){%>
        <div><%=resultdata%></div>
        <div><hr></div>
        <%}%>
        <div class="smart-form">
            <section class="col col-md-12">
                <label class="textarea"> <i class="icon-append fa fa-info"></i>
                    <textarea name="resultdescr" id="resultdescr" placeholder="<%=trs.t("შედეგის აღწერა")%>"><%=(sm.getResultdescr() != null) ? sm.getResultdescr():""%></textarea>
                </label>
            </section>
        </div>
        </div>
        <div class="smart-form pull-right" style="width: 300px;">
            <section class="col col-md-12">
            <label class="textarea"> <i class="icon-append fa fa-info"></i>
                <textarea name="resultinfo" placeholder="<%=trs.t("დამატებითი ინფორმაცია")%>"><%=(sm.getResultInfo() != null) ? sm.getResultInfo():""%></textarea>
            </label>
            </section>
            <section class="col col-md-12">
                <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                <textarea name="resultnote" placeholder="<%=trs.t("შენიშვნა")%>"><%=(sm.getResultNote() != null) ? sm.getResultNote():""%></textarea>
                </label>
            </section>
            <section class="col col-md-6">
                <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                <input name="resultdate" type="text"  placeholder="<%=trs.t("ჩატარების თარიღი")%>" value="<%=(sm.getResultDatetime() != null) ? dt.format(sm.getResultDatetime()):""%>">
                </label>
            </section>
            <section class="col col-md-6">
                <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                <input name="resulttime" type="text"  placeholder="<%=trs.t("ჩატარების დრო")%>"   value="<%=(sm.getResultDatetime() != null) ? dtime.format(sm.getResultDatetime()):""%>">
                </label>
            </section>
            <section class="col col-md-12">
                <label class="select">
                    <select name="device">
                        <option value="0"><%=trs.t("აპარატი")%></option>
                        <%
                        for(int i=0;i<devs.length;i++){
                            String sel = "";
                            if(sm.getDeviceid() != null && devs[i].getDeviceid().intValue() == sm.getDeviceid().intValue())
                                sel = "selected";
                        %>
                        <option value="<%=devs[i].getDeviceid()%>" <%=sel%>><%=trs.t(devs[i].getName())%></option>
                        <%
                        }
                        %>
                    </select> <i></i>
                </label>
            </section>
            <section class="col col-md-12">
                <%--if(clevel > 0){%>
                    <button class="btn btn-success pull-right resultconfirm"  data-itemid="<%=request.getParameter("id")%>"><%=trs.t("კონფირმაცია")%></button>
                    <button class="btn btn-danger pull-right resultreject" data-itemid="<%=request.getParameter("id")%>" style="margin-right: 5px;"><%=trs.t("უარყოფა")%></button>
                <%}--%>
            </section>
        </div>
    </div>
</form>                        
<script>
<%
String stands = "";
for(int i=0;i<stds.length;i++){
    stands += "<option value=\""+stds[i].getStandardid()+"\"";
    if(sm.getStandardid() != null && sm.getStandardid().intValue() == stds[i].getStandardid().intValue())
        stands += " selected";
    stands += ">"+trs.t(stds[i].getName())+"</option>";
}
if(stds.length > 0)
    stands = "<div class=\"smart-form\"><label class=\"select\"><select name=\"standard\" class=\"select2\" style=\"width:100%;\">"+stands+"</select></label></div>";
String nrm = "";
if(sm.getNorm() != null)    nrm = sm.getNorm();
JSONArray res  = new JSONArray();
if (tst.getRestypeid()==1) { 
    String ans = ""
            + "<div class=\"smart-form\">"
            + "<label class=\"label\"></label>"
            + "<label class=\"select\">"
            + "<select name=\"result\" id=\"result\" onchange=\"setInterpret()\">"
            + "<option value=\"\"></option>"
            + "<option value=\"true\"";
    if(sm.getBresult() != null && sm.getBresult().booleanValue())   ans += " selected";
    ans += ">"+trs.t("დადებითი")+"</option>"
            + "<option value=\"false\"";
    if(sm.getBresult() != null && !sm.getBresult().booleanValue())   ans += " selected";
    ans += ">"+trs.t("უარყოფითი")+"</option>"
            + "</select><i></i>"
            + "</label>"
            + "</div>";
    String norm = "<div class=\"smart-form\"><label class=\"input\"><input name=norm value=\""+nrm+"\" type=\"text\"></label></div>";
    JSONObject tmp = new JSONObject();
    tmp.put("id",  sam[0].getSampleitemreseachid());
    tmp.put("name",sam[0].getLabtestname());
    tmp.put("answer",ans);
    tmp.put("norm", norm);
    tmp.put("standardid", stands);
    res.add(tmp);
} else if (tst.getRestypeid()==2) { 
    String ans = "<div class=\"smart-form\"><label class=\"input\"><input name=result value=\""+result+"\" type=\"text\"></label></div>";
    JSONObject tmp = new JSONObject();
    tmp.put("id",  sam[0].getSampleitemreseachid());
    tmp.put("name",sam[0].getLabtestname());
    tmp.put("answer",ans);
    String norm = "<div class=\"smart-form\"><label class=\"input\"><input name=norm value=\"";
    if (tst.getNormmin()!=null&&tst.getNormmax()!=null) norm += ""+tst.getNormmin()+" - "+tst.getNormmax();
    else if (tst.getNormmin()!=null) norm += "> "+tst.getNormmin();
    else if (tst.getNormmax()!=null) norm += "< "+tst.getNormmax();
    else norm += nrm;
    norm += "\" type=\"text\"></label></div>";
    tmp.put("norm", norm);
    tmp.put("standardid", stands);
    res.add(tmp);
} else { 
    String ans = "<div class=\"smart-form\"><label class=\"input\"><input name=result value=\""+result+"\" type=\"text\"></label></div>";
    String norm = "<div class=\"smart-form\"><label class=\"input\"><input name=norm value=\""+(tst.getTnorm()!=null ? tst.getTnorm() : nrm)+"\" type=\"text\"></label></div>";
    JSONObject tmp = new JSONObject();
    tmp.put("id",  sam[0].getSampleitemreseachid());
    tmp.put("name",sam[0].getLabtestname());
    tmp.put("answer",ans);
    tmp.put("norm", norm);
    tmp.put("standardid", stands);
    res.add(tmp);
} 
out.println("var tbldata1="+res.toString()+";");
out.println("var tbldata2="+res.toString()+";");
%>
<%if(sm.getConfirmation1id() == null){%>
$(".resultconfirm").show();
$(".resultreject").hide();
<%}if(sm.getConfirmation1id() != null){%>
$(".resultconfirm").hide();
$(".resultreject").show();
<%}%>
function setInterpret(){
	var result = $("#result").val(); 
	var descr = "";
	if(result == "true")	descr = "<%=(tst.getPos() != null) ? tst.getPos():""%>";
	if(result == "false")   descr = "<%=(tst.getNeg() != null) ? tst.getNeg():""%>";
	$("#resultdescr").val(descr);
}
$('#resultt').on("change", function() { 
   var result = $(this).val();
        var descr = "";
        if(result == "true")    descr = "<%=(tst.getPos() != null) ? tst.getPos():""%>";
        if(result == "false")   descr = "<%=(tst.getNeg() != null) ? tst.getNeg():""%>";
        $("#resultdescr").val(descr);
});
</script>
                

<%
}
catch(Exception e){
    e.printStackTrace();
}
%>
