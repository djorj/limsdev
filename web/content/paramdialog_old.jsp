<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp"%>
<%
    LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
    LabtestBean[] groups = LabtestManager.getInstance().loadByWhere("where labtestid != "+labtest.getLabtestid()+" and grp = true order by name");
    SampletypeBean[] samples = SampletypeManager.getInstance().loadByWhere("order by name");
    //InstitutionBean[] insts = InstitutionManager.getInstance().loadByWhere("where parentid is null order by name");
    StandardBean[] stds = StandardManager.getInstance().loadByWhere("order by name");
    
%>
<div class="smart-form">
<ul class="nav nav-tabs bordered" id="ptabs">
    <li class="active">
        <a data-toggle="tab" href="#s1"><%=trs.t("ჯგუფები")%></a>
    </li>
    <li>
        <a data-toggle="tab" href="#s2"><%=trs.t("ნიმუშები")%></a>
    </li>
    <li class="active">
        <a data-toggle="tab" href="#s3"><%=trs.t("ლაბორატორიები")%></a>
    </li>
    <li>
        <a data-toggle="tab" href="#s4"><%=trs.t("სტანდარტები")%></a>
    </li>
</ul>

<div class="tab-content padding-10"  id="pTabContent" style='height: calc(100vh - 400px); overflow-y: scroll; overflow-x: hidden;'>
    <div class="tab-pane fade in active" id="s1" style="padding-left: 20px;">
        <%
        for(int i=0;i<groups.length;i++){
            String sel = "";
            if(TestgroupManager.getInstance().countWhere("where labtestid = "+labtest.getLabtestid()+" and testgroupid = "+groups[i].getLabtestid()) > 0)
                sel = "checked";
        %>
        <div class="row">
            <div class="col col-12">
                <label class="checkbox" style="cursor: pointer;"><input name="groupid" value="<%=groups[i].getLabtestid()%>" type="checkbox" <%=sel%>> <i></i><%=trs.t(groups[i].getName())%></label>
            </div>
        </div>
        <%
        }
        %>
    </div>

    <div class="tab-pane fade" id="s2" style="padding-left: 20px;">
        <%
        for(int i=0;i<samples.length;i++){
            String sel = "";
            if(LabtestsampletypeManager.getInstance().countWhere("where labtestid = "+labtest.getLabtestid()+" and sampletypeid = "+samples[i].getSampletypeid()) > 0)
                sel = "checked";
        %>
        <div class="row">
            <div class="col col-12">
                <label class="checkbox" style="cursor: pointer;"><input name="sampleid" value="<%=samples[i].getSampletypeid()%>" type="checkbox" <%=sel%>> <i></i><%=trs.t(samples[i].getName())%></label>
            </div>
        </div>
        <%
        }
        %>
    </div>

    <div class="tab-pane fade" id="s3" style="padding-left: 20px;">
        <jsp:include page="labtree.jsp">
            <jsp:param name="labtestid" value="<%=labtest.getLabtestid()%>"></jsp:param>
        </jsp:include>
    </div>

    <div class="tab-pane fade" id="s4" style="padding-left: 20px;">
        <%
        for(int i=0;i<stds.length;i++){
            String sel = "";
            if(LabteststandardManager.getInstance().countWhere("where labtestid = "+labtest.getLabtestid()+" and standardid = "+stds[i].getStandardid()) > 0)
                sel = "checked";
        %>
        <div class="row">
            <div class="col col-12">
                <label class="checkbox" style="cursor: pointer;"><input name="standardid" value="<%=stds[i].getStandardid()%>" type="checkbox" <%=sel%>> <i></i><%=trs.t(stds[i].getName())%></label>
            </div>
        </div>
        <%
        }
        %>
    </div>
</div>
</div>