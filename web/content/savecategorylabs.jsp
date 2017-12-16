<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/init.jsp" %>
<%
JSONObject res = new JSONObject();
Manager.getInstance().beginTransaction();
try{
    TestcategoryBean testcategory = TestcategoryManager.getInstance().loadByPrimaryKey(new Integer(request.getParameter("id")));
    
    
    JSONObject data = JSONObject.fromObject(request.getParameter("pars"));
    JSONArray institutions = data.getJSONArray("institutionid");
    
    TestcategorylabManager.getInstance().deleteByTestcategoryid(testcategory.getTestcategoryid());
    
    for(int i=0;i<institutions.size();i++){
        int instid = institutions.getInt(i);
        TestcategorylabBean tg = TestcategorylabManager.getInstance().createTestcategorylabBean();
        tg.setInstitutionid(instid);
        tg.setTestcategoryid(testcategory.getTestcategoryid());
        tg = TestcategorylabManager.getInstance().save(tg);
        LabtestBean[] labtests = LabtestManager.getInstance().loadByTestcategoryid(testcategory.getTestcategoryid());
        for(int j=0;j<labtests.length;j++){
            LabtestinstitutionManager.getInstance().deleteByLabtestid(labtests[j].getLabtestid());
            LabtestinstitutionBean gr = LabtestinstitutionManager.getInstance().createLabtestinstitutionBean();
            gr.setLabtestid(labtests[j].getLabtestid());
            gr.setInstitutionid(institutions.getInt(i));
            gr = LabtestinstitutionManager.getInstance().save(gr);
        }
    }
    
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
