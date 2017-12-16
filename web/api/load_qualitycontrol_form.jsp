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
    SampleitemreseachBean research = SampleitemreseachManager.getInstance().loadByPrimaryKey(id);
    ContractsampleitemBean itm = ContractsampleitemManager.getInstance().loadByPrimaryKey(research.getContractsampleitemid());
    LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(research.getLabtestid());
    LabtestBean[] controls = LabtestManager.getInstance().loadByWhere("where labtestid in (select controlid from labtestcontrol where labtestid = "+labtest.getLabtestid()+" and schedule not like '%\"val\":\"1\"%')");
    DeviceBean[] dev = DeviceManager.getInstance().loadByWhere("WHERE deleted=false and deviceid in (select deviceid from devicelabtest where labtestid = "+labtest.getLabtestid()+")");
    String sqlinsts = "select institutionid from labtestinstitution where labtestid = "+labtest.getLabtestid();
    if(controls.length > 0){
        QualitycontrolBean[] ptp = QualitycontrolManager.getInstance().loadByContractsampleitemid(research.getContractsampleitemid());
        String lot = "";
        int device = 0;
        int person = 0;
        String crdate = "";
        String crtime = "";
        String info = "";
        String positive = "";
        String negative = "";
        if(ptp.length > 0){
            lot = ptp[0].getLot();
            device = (ptp[0].getDeviceid() != null) ? ptp[0].getDeviceid().intValue():0;
            person = ptp[0].getQcPerson();
            crdate = dt.format(ptp[0].getQcDatetime());
            crtime = dtime.format(ptp[0].getQcDatetime());
            info = ptp[0].getInfo();
            
        }
%>
<form id="frmqualitycontrol" action="api/setqualitycontrol.jsp" method="post" accept-charset="UTF-8">               
<input name="oper" value="add" type="hidden">
<input name="id" type="hidden" value="<%=id%>">
<section class="col col-sm-6">
    <label class="label"><%=trs.t("ლოტი/კოდი")%></label>
    <label class="input"> <i class="icon-append fa fa-code"></i>
        <input name="lot" class="" placeholder="" type="text" value="<%=lot%>">
    </label>
</section>
<section class="col col-sm-6">
    <label class="label"><%=trs.t("აპარატი")%></label>
    <%if(dev.length > 0){%>
    <label class="select">
    <select name="device"  placeholder="<%=trs.t("აირჩიეთ")%>"   class="select2" style="width:100%;">
    <option value="0"></option>
<%
    
    for (int i=0;  i<dev.length; i++)
    {
        String sel = "";
        if(dev[i].getDeviceid().intValue() == device)
            sel = "selected";
        out.print("<option value=\""+dev[i].getDeviceid()+"\" "+sel+">"+dev[i].getName()+"</option>");
    }
%>
    </select>
    <%}else{%>
    <input type="hidden" name="device" value="0"/>
    კვლევაზე აპარატი არაა მინიჭებული
    <%}%>
    </label>
</section>
<section class="col col-sm-12">
    <label class="label"><%=trs.t("ჩაატარა")%></label>
    <label class="select">
    <select name="person"  placeholder="<%=trs.t("ჩაატარა")%>"   class="select2" style="width:100%;">
    <option value=""></option>
<%
    PersonellBean[] per = PersonellManager.getInstance().loadByWhere("WHERE deleted<>true and companyid="+user.getCompanyid()+" and institutionid in ("+sqlinsts+") ORDER BY lname,fname");
    for (int i=0;  i<per.length; i++)
    {
        String sel = "";
        if(per[i].getPersonellid().intValue() == person)
            sel = "selected";
        out.print("<option value=\""+per[i].getPersonellid()+"\" "+sel+">"+per[i].getFname()+" "+per[i].getLname()+"</option>");
    }
%>
    </select>
    </label>
</section>
<section class="col col-sm-6" >
    <label class="input"> <i class="icon-append fa fa-clock-o"></i>
    <input name="crdate" type="text"  class="dtpicker" placeholder="<%=trs.t("ჩატარების თარიღი")%>" value="<%=crdate%>">
    </label>
</section>
<section class="col col-sm-6" >
    <label class="input"> <i class="icon-append fa fa-clock-o"></i>
    <input name="crtime" type="text"  class="clockpicker" placeholder="<%=trs.t("ჩატარების დრო")%>"   value="<%=crtime%>">
    </label>
</section>
<%for(int i=0;i<controls.length;i++){%>
<section class="col col-md-12">
    <label class="label"><%=trs.t(controls[i].getName())%></label>
    <%if(controls[i].getRestypeid().intValue() == 1){
        String pos = controls[i].getPos();
        String neg = controls[i].getNeg();
        if(pos == null)    pos = "გაიარა";
        if(neg == null)    neg = "ვერ გაირა";
    %>
    <label class="select">
        <select name="labtestid_<%=controls[i].getLabtestid()%>">
            <option value="0"></option>
            <option value="1"><%=trs.t(pos)%></option>
            <option value="2"><%=trs.t(neg)%></option>
        </select> <i></i>
    </label>
    <%}else if(controls[i].getRestypeid().intValue() == 2){%>
    <label class="input"> <input type="text" name="labtestid_<%=controls[i].getLabtestid()%>" id="labtestid_<%=controls[i].getLabtestid()%>"></label>
    <%}else{%>
    <label class="textarea"> <i class="icon-append fa fa-comment"></i>
        <textarea  name="labtestid_<%=controls[i].getLabtestid()%>" type="text"></textarea>
    </label>
    <%}%>
</section>
<%}%>
<section class="col col-sm-12">
    <label class="label"><%=trs.t("ინტერპრეტაცია/კომენტარი")%></label>
        <label class="textarea"> <i class="icon-append fa fa-comment"></i>
        <textarea  name="info" type="text"><%=info%></textarea>
    </label>
</section>
<section class="col col-sm-12">
    <label class="label">ბარკოდი <span id="barcodecnt"><span></label>
    <div class="input-group">
        <label class="input"> <input type="text" name="itemid" id="itemid" value="<%=research.getContractsampleitemid()%>"></label>
    <%--div class="input-group-btn">
        <button class="btn btn-success showgrid" type="button">დაკავშირება</button>
    </div--%>
    <div class="input-group-btn" id="editcontragentbtn">
        <button class="btn btn-warning" data-original-title="<%=trs.t("კლავიატურიდან შეტანა")%>" type="button" onclick="inputBarcode()">
            <i class="fa fa-pencil"></i>
        </button>
    </div>
    </div>
</section>              
<section class="col col-sm-12">
    <div id='barcodelist'></div>
</section>
</form>
        <script>
            setTimeout(function(){inputBarcode();},1000);
        </script>
<%
    } else {
    %>
    <h2><%=trs.t("კვლევაზე ხარისხის კონტროლი არაა მინიჭებული")%></h2>
    <%
    }
}
catch(Exception e){
    e.printStackTrace();
}
%>
