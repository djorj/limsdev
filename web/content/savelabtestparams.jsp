<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
JSONObject res = new JSONObject();
Manager.getInstance().beginTransaction();
try{
    LabtestBean labtest = LabtestManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
    Vector v = (Vector)session.getAttribute("LABTESTPARAMS");
    if(v == null)   v = new Vector();
    LabteststandardManager.getInstance().deleteByLabtestid(labtest.getLabtestid());
    LabtestsampletypeManager.getInstance().deleteByLabtestid(labtest.getLabtestid());
    LabtestparamsManager.getInstance().deleteByLabtestid(labtest.getLabtestid());
    for(int i=0;i<v.size();i++){
        LabtestparamsBean lp = (LabtestparamsBean)v.elementAt(i);
        LabtestparamsBean lp0 = LabtestparamsManager.getInstance().createLabtestparamsBean();
        lp0.setLabtestid(lp.getLabtestid());
        lp0.setSampletypeid(lp.getSampletypeid());
        lp0.setStandardid(lp.getStandardid());
        lp0 = LabtestparamsManager.getInstance().save(lp0);
	if(LabtestsampletypeManager.getInstance().countWhere("where labtestid = "+labtest.getLabtestid()+" and sampletypeid = "+lp0.getSampletypeid())==0){
	        LabtestsampletypeBean gr = LabtestsampletypeManager.getInstance().createLabtestsampletypeBean();
        	gr.setLabtestid(labtest.getLabtestid());
	        gr.setSampletypeid(lp0.getSampletypeid());
        	gr = LabtestsampletypeManager.getInstance().save(gr);
	}
        if(lp0.getStandardid() != null && LabteststandardManager.getInstance().countWhere("where labtestid = "+labtest.getLabtestid()+" and standardid = "+lp0.getStandardid())==0){
            LabteststandardBean ls = LabteststandardManager.getInstance().createLabteststandardBean();
            ls.setLabtestid(labtest.getLabtestid());
            ls.setStandardid(lp0.getStandardid());
            ls = LabteststandardManager.getInstance().save(ls);
        }
    }
    
    
    /*
    JSONObject data = JSONObject.fromObject(request.getParameter("pars"));
    JSONArray groups = data.getJSONArray("groupid");
    JSONArray samples = data.getJSONArray("sampleid");
    JSONArray institutions = data.getJSONArray("institutionid");
    JSONArray standards = data.getJSONArray("standardid");
    
    TestgroupManager.getInstance().deleteByLabtestid(labtest.getLabtestid());
    LabtestsampletypeManager.getInstance().deleteByLabtestid(labtest.getLabtestid());
    LabtestinstitutionManager.getInstance().deleteByLabtestid(labtest.getLabtestid());
    LabteststandardManager.getInstance().deleteByLabtestid(labtest.getLabtestid());
    
    for(int i=0;i<groups.size();i++){
        TestgroupBean gr = TestgroupManager.getInstance().createTestgroupBean();
        gr.setLabtestid(labtest.getLabtestid());
        gr.setTestgroupid(groups.getInt(i));
        gr = TestgroupManager.getInstance().save(gr);
    }

    for(int i=0;i<samples.size();i++){
        LabtestsampletypeBean gr = LabtestsampletypeManager.getInstance().createLabtestsampletypeBean();
        gr.setLabtestid(labtest.getLabtestid());
        gr.setSampletypeid(samples.getInt(i));
        gr = LabtestsampletypeManager.getInstance().save(gr);
    }
    
    for(int i=0;i<institutions.size();i++){
        LabtestinstitutionBean gr = LabtestinstitutionManager.getInstance().createLabtestinstitutionBean();
        gr.setLabtestid(labtest.getLabtestid());
        gr.setInstitutionid(institutions.getInt(i));
        gr = LabtestinstitutionManager.getInstance().save(gr);
    }
    
    for(int i=0;i<standards.size();i++){
        LabteststandardBean gr = LabteststandardManager.getInstance().createLabteststandardBean();
        gr.setLabtestid(labtest.getLabtestid());
        gr.setStandardid(standards.getInt(i));
        gr = LabteststandardManager.getInstance().save(gr);
    }
    */
    Manager.getInstance().endTransaction(true);
    res.put("result",1);
}catch(Exception e){
    Manager.getInstance().endTransaction(false);
    e.printStackTrace();
    res.put("result",0);
    res.put("error",e.getMessage());
}
out.print(res.toString());
out.flush();
%>
