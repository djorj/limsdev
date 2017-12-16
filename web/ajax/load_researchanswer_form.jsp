<%-- 
    Document   : service
    Created on : Nov 22, 2014, 3:24:54 PM
    Author     : Gocha Tortladze
--%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
try
{
    long id = Long.parseLong(request.getParameter("id"));
    SampleitemreseachBean sb = SampleitemreseachManager.getInstance().loadByPrimaryKey(id);
    //LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(sb.getLabtestid());
    //TestcategoryBean tb = TestcategoryManager.getInstance().loadByPrimaryKey(labtest.getTestcategoryid());
    DeviceBean[] devices = DeviceManager.getInstance().loadByWhere("where institutionid in (select institutionid from labtestinstitution where labtestid = "+sb.getLabtestid()+")");
    
    VLabRequestBean[] sam = VLabRequestManager.getInstance().loadByWhere("WHERE sampleitemreseachid="+id);
    LabtestBean tst  = LabtestManager.getInstance().loadByPrimaryKey(sb.getLabtestid());
    //UnitsBean unit = UnitsManager.getInstance().loadByPrimaryKey(tst.getUnitsid());
    
%>

<form id="frmresearchanswer" action="api/setsampletype.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" value="researchanswer" type="hidden">
<input name="id" type="hidden" value="<%=request.getParameter("id")%>">
    <div class="tab-pane fade in active" id="i1">
        <div class="pull-left">
        <table id="reqanswer"></table>
        <div id="pagerreqanswer"></div>
        </div>
        <div class="smart-form pull-right" style="width: 300px;">
            <section class="col col-md-12">
            <label class="textarea"> <i class="icon-append fa fa-info"></i>
                <textarea name="resultinfo" placeholder="<%=trs.t("დამატებითი ინფორმაცია")%>"><%=sb.getResultInfo()%></textarea>
            </label>
            </section>
            <section class="col col-md-12">
                <label class="textarea"> <i class="icon-append fa fa-comment"></i>
                <textarea name="resultnote" placeholder="<%=trs.t("შენიშვნა")%>"><%=sb.getResultNote()%></textarea>
                </label>
            </section>
            <section class="col col-md-6">
                <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                    <input name="resultdate" type="text"  placeholder="<%=trs.t("ჩატარების თარიღი")%>" value="<%=dt.format(sb.getResultDatetime())%>">
                </label>
            </section>
            <section class="col col-md-6">
                <label class="input"> <i class="icon-append fa fa-clock-o"></i>
                <input name="resulttime" type="text"  placeholder="<%=trs.t("ჩატარების დრო")%>"   value="<%=dtime.format(sb.getResultDatetime())%>">
                </label>
            </section>
            <section class="col col-md-12">
                <label class="select">
                    <select name="device">
                        <option value="0"><%=trs.t("აპარატი")%></option>
                        <%
                        for(int i=0;i<devices.length;i++){
                            String sel = "";
                            if(sb.getDeviceid() != null && sb.getDeviceid().intValue() == devices[i].getDeviceid().intValue())
                                sel = "selected";
                        %>
                        <option value="<%=devices[i].getDeviceid()%>" <%=sel%>><%=trs.t(devices[i].getName())%></option>
                        <%
                        }
                        %>
                    </select> <i></i>
                </label>
            </section>
            <section class="col col-md-12">
                    <button class="btn btn-success pull-right resultconfirm"><%=trs.t("კონფირმაცია")%></button>
                    <button class="btn btn-danger pull-right" style="margin-right: 5px;"><%=trs.t("უარყოფა")%></button>
            </section>
        </div>
    </div>
</form>                        
<script>
<%
JSONArray res  = new JSONArray();
if (tst.getRestypeid()==1) { 
    String ans = ""
            + "<div class=\"smart-form\">"
            + "<label class=\"label\"></label>"
            + "<label class=\"select\">"
            + "<select name=result class=\"select2\" style=\"width:100%;\">>"
            + "<option value=\"\"></option>"
            + "<option value=\""+trs.t("დადებითი")+"\">"+trs.t("დადებითი")+"</option>"
            + "<option value=\""+trs.t("უარყოფითი")+"\">"+trs.t("უარყოფითი")+"</option>"
            + "</select>"
            + "</label>"
            + "</div>";
    JSONObject tmp = new JSONObject();
    tmp.put("id",  sam[0].getSampleitemreseachid());
    tmp.put("name",sam[0].getLabtestname());
    tmp.put("answer",ans);
    tmp.put("norm", "");
    res.add(tmp);
} else if (tst.getRestypeid()==2) { 
    String ans = "<div class=\"smart-form\"><label class=\"input\"><input name=result value=\""+sb.getResult()+"\" type=\"text\"></label></div>";
    JSONObject tmp = new JSONObject();
    tmp.put("id",  sam[0].getSampleitemreseachid());
    tmp.put("name",sam[0].getLabtestname());
    tmp.put("answer",ans);
    if (tst.getNormmin()!=null&&tst.getNormmax()!=null) tmp.put("norm", ""+tst.getNormmin()+" - "+tst.getNormmax());
    else if (tst.getNormmin()!=null) tmp.put("norm", "> "+tst.getNormmin());
    else if (tst.getNormmax()!=null) tmp.put("norm", "< "+tst.getNormmax());
    else tmp.put("norm", "-");
    res.add(tmp);
} else { 
    String ans = "<div class=\"smart-form\"><label class=\"input\"><input name=result value=\""+sb.getResult()+"\" type=\"text\"></label></div>";
    JSONObject tmp = new JSONObject();
    tmp.put("id",  sam[0].getSampleitemreseachid());
    tmp.put("name",sam[0].getLabtestname());
    tmp.put("answer",ans);
    tmp.put("norm", tst.getTnorm()!=null ? tst.getTnorm() : "-");
    res.add(tmp);
} 
out.println("var tbldata1="+res.toString()+";");
out.println("var tbldata2="+res.toString()+";");
%>
</script>
                

<%
}
catch(Exception e){
    e.printStackTrace();
}
%>
